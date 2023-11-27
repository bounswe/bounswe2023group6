package com.gamelounge.backend.service

import com.gamelounge.backend.config.CustomProperties
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.model.request.RegisterationRequest
import com.gamelounge.backend.repository.GameRepository
import com.gamelounge.backend.repository.PasswordResetTokenRepository
import com.gamelounge.backend.repository.SessionRepository
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.HashingUtil
import com.gamelounge.backend.util.HashingUtil.generateHash
import org.junit.jupiter.api.Assertions.assertNotEquals
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows
import org.mockito.kotlin.*
import org.springframework.web.multipart.MultipartFile
import kotlin.reflect.KClass


class AccessServiceTest {

    private val userRepository: UserRepository = mock()
    private val sessionRepository: SessionRepository = mock()
    private val emailService: EmailService = mock()
    private val passwordResetTokenRepository: PasswordResetTokenRepository = mock()
    private val passwordResetTokenService: PasswordResetTokenService = mock()
    private val s3Service: S3Service = mock()
    private val gameRepository: GameRepository = mock()
    private val hashingUtil: HashingUtil = mock()

    private val accessService = AccessService(
        userRepository,
        sessionRepository,
        emailService,
        passwordResetTokenRepository,
        passwordResetTokenService,
        CustomProperties(),
        s3Service,
        gameRepository
    )

    @Test
    fun `register should throw UsernameAlreadyExistException if username already exists`() {
        val request = RegisterationRequest("testUser", "psw", "test@email.com")
        val multipartFile: MultipartFile? = null;
        // Mocking the behavior
        whenever(userRepository.existsByUsername(request.username)).thenReturn(true)

        assertThrows<UsernameAlreadyExistException> {
            accessService.register(request, multipartFile)
        }
    }

    @Test
    fun `register should save user when username is unique`() {
        val request = RegisterationRequest("testUser", "password", "test@email.com")
        val multipartFile: MultipartFile? = null
        val captor = argumentCaptor<User>()

        whenever(userRepository.existsByUsername(request.username)).thenReturn(false)
        whenever(userRepository.save(any<User>())).thenAnswer { invocation -> invocation.arguments[0] as User }

        accessService.register(request, multipartFile)

        verify(userRepository).save(captor.capture())
        captor.firstValue.apply {
            assert(username == request.username)
            assert(email == request.email)
            assert(passwordHash.isNotEmpty())
            assert(salt.isNotEmpty())
            assert(!passwordHash.contentEquals(request.password.toByteArray()))
        }
    }


    @Test
    fun `login should throw UsernameNotFoundException if user does not exist`() {
        whenever(userRepository.findByUsername("unknownUser")).thenReturn(null)

        assertThrows<UsernameNotFoundException> {
            accessService.login("unknownUser1", "password")
        }
    }

    @Test
    fun `login should throw WrongCredentialsException if password is incorrect`() {

        var username = "testUser"
        var password = "wrongPassword"
        var hashedPassword = "correctHashedPassword".toByteArray()

        whenever(userRepository.findByUsername("testUser")).thenReturn(User(username = username, passwordHash = hashedPassword, salt = "salt".toByteArray()))

        assertThrows<WrongCredentialsException> {
            accessService.login(username, password)
        }
    }




}