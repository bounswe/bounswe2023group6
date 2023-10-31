package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.PasswordResetToken
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.time.Instant

@Repository
interface PasswordResetTokenRepository : JpaRepository<PasswordResetToken, String> {
    fun deleteByExpiryTimestampBefore(expiryTimestamp: Instant): Long
}
