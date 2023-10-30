package com.gamelounge.backend.entity

import jakarta.persistence.*
import java.time.Instant


@Entity
@Table(name = "password_reset_tokens")
class PasswordResetToken(
    @Id val token: String,
    @ManyToOne
    @JoinColumn(name = "username", nullable = false)
    val user: User,
    val expiryTimestamp: Instant
) {
    constructor() : this("", User(), Instant.now())
}