package com.gamelounge.backend.entity

import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table
import java.time.LocalDateTime

@Entity
@Table(name = "sessions")
class Session(
    @Id
    val id: String,
    @ManyToOne
    val user: User,
    val timestamp: LocalDateTime
) {
    constructor() : this("", User(), LocalDateTime.now())
}
