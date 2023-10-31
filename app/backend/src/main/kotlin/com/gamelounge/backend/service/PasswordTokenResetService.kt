package com.gamelounge.backend.service

import com.gamelounge.backend.entity.PasswordResetToken
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.TokenNotFoundException
import com.gamelounge.backend.repository.PasswordResetTokenRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.time.Instant
import java.util.UUID

@Service
class PasswordResetTokenService(@Autowired private val tokenRepository: PasswordResetTokenRepository) {

    fun createToken(user: User): String {
        val token = UUID.randomUUID().toString()
        val expiryTimestamp = Instant.now().plusSeconds(3600) // 1 hour validity
        val passwordResetToken = PasswordResetToken(token, user, expiryTimestamp)
        tokenRepository.save(passwordResetToken)
        return token
    }

    fun validateToken(token: String): PasswordResetToken {
        val passwordResetToken = tokenRepository.findById(token).orElseThrow{
            TokenNotFoundException("Token is not found. It may have expired.")
        }

        if (isTokenExpired(passwordResetToken)) {
            tokenRepository.delete(passwordResetToken)
            throw TokenNotFoundException("Token is not found. It may have expired.")
        }
        return passwordResetToken


    }

    private fun isTokenExpired(passwordResetToken: PasswordResetToken): Boolean {
        return Instant.now().isAfter(passwordResetToken.expiryTimestamp)
    }


    fun deleteExpiredTokens() {
        val now = Instant.now()
        tokenRepository.deleteByExpiryTimestampBefore(now)
    }
}
