package com.gamelounge.backend

import com.gamelounge.backend.entity.PasswordResetToken
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.TokenNotFoundException
import com.gamelounge.backend.repository.PasswordResetTokenRepository
import com.gamelounge.backend.service.PasswordResetTokenService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows
import org.mockito.Mockito.mock
import org.mockito.Mockito.verify
import org.mockito.kotlin.argumentCaptor
import org.mockito.kotlin.whenever
import java.time.Instant
import java.util.*

class PasswordTokenResetServiceTest {

    private val tokenRepository: PasswordResetTokenRepository = mock()
    private val tokenService = PasswordResetTokenService(tokenRepository)

    @Test
    fun `createToken should generate a new token, save it, and return it`() {
        val user = User(userId = 123L, username = "testUser", email = "sample@example.com.tr")
        val capturedToken = argumentCaptor<PasswordResetToken>()

        val generatedToken = tokenService.createToken(user)

        verify(tokenRepository).save(capturedToken.capture())

        assertNotNull(generatedToken)
        assertEquals(generatedToken, capturedToken.firstValue.token)
        assertEquals(user, capturedToken.firstValue.user)
        assertTrue(capturedToken.firstValue.expiryTimestamp.isAfter(Instant.now()))
        assertTrue(capturedToken.firstValue.expiryTimestamp.isBefore(Instant.now().plusSeconds(3700)))
    }

    @Test
    fun `validateToken should return PasswordResetToken when token is valid`() {
        val token = UUID.randomUUID().toString()
        val user = User(userId = 123L)
        val expiryTimestamp = Instant.now().plusSeconds(3600)
        val passwordResetToken = PasswordResetToken(token, user, expiryTimestamp)

        whenever(tokenRepository.findById(token)).thenReturn(Optional.of(passwordResetToken))

        val result = tokenService.validateToken(token)

        assertNotNull(result)
        assertEquals(token, result.token)
        assertEquals(user, result.user)
        assertFalse(tokenService.isTokenExpired(result))
    }
    @Test
    fun `validateToken should throw TokenNotFoundException when token is not found or expired`() {
        val token = UUID.randomUUID().toString()

        whenever(tokenRepository.findById(token)).thenReturn(Optional.empty())

        assertThrows<TokenNotFoundException> {
            tokenService.validateToken(token)
        }


        val user = User(userId = 123L)
        val expiredToken = PasswordResetToken(token, user, Instant.now().minusSeconds(1000))
        whenever(tokenRepository.findById(token)).thenReturn(Optional.of(expiredToken))


        assertThrows<TokenNotFoundException> {
            tokenService.validateToken(token)
        }
    }




}