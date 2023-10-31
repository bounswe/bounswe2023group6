package com.gamelounge.backend.service

import com.gamelounge.backend.config.CustomProperties
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.model.RegisterationRequest
import com.gamelounge.backend.repository.PasswordResetTokenRepository
import com.gamelounge.backend.repository.SessionRepository
import com.gamelounge.backend.repository.UserRepository
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows
import org.mockito.kotlin.*


class AccessServiceTest {

    private val userRepository: UserRepository = mock()
    private val sessionRepository: SessionRepository = mock()
    private val emailService: EmailService = mock()
    private val passwordResetTokenRepository: PasswordResetTokenRepository = mock()
    private val passwordResetTokenService: PasswordResetTokenService = mock()

    private val accessService = AccessService(
        userRepository,
        sessionRepository,
        emailService,
        passwordResetTokenRepository,
        passwordResetTokenService,
        CustomProperties()
    )

    @Test
    fun `register should throw UsernameAlreadyExistException if username already exists`() {
        val request = RegisterationRequest("testUser", "psw", "test@email.com", "name", "surname", "hello".toByteArray())

        // Mocking the behavior
        whenever(userRepository.existsByUsername(request.username)).thenReturn(true)

        assertThrows<UsernameAlreadyExistException> {
            accessService.register(request)
        }
    }

    @Test
    fun `register should save user when username is unique`() {
        val request = RegisterationRequest("testUser", "psw", "test@email.com", "name", "surname", "hello".toByteArray())

        // Mocking the behavior
        whenever(userRepository.existsByUsername(request.username)).thenReturn(false)

        accessService.register(request)

        // Verifying the save method was called
        verify(userRepository).save(any<User>())
    }

    @Test
    fun `login should throw UsernameNotFoundException if user does not exist`() {
        whenever(userRepository.findByUsername("unknownUser")).thenReturn(null)

        assertThrows<UsernameNotFoundException> {
            accessService.login("unknownUser", "password")
        }
    }

    @Test
    fun `login should throw WrongCredentialsException if password is incorrect`() {

        val user = User("testUser", "test@email.com", "Name", "Surname", "image".toByteArray(), byteArrayOf(1), byteArrayOf(1))
        whenever(userRepository.findByUsername("testUser")).thenReturn(user)

        assertThrows<WrongCredentialsException> {
            accessService.login("testUser", "wrongPassword")
        }
    }


}