package com.gamelounge.backend.entity

import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table
import lombok.NoArgsConstructor
import java.time.LocalDateTime
import java.util.UUID
@Entity
@Table(name = "sessions")
class Session(
    @Id
    val id: UUID,
    @ManyToOne
    val user: User,
    val timestamp: LocalDateTime
)
{
    constructor() : this(UUID.randomUUID(), User(), LocalDateTime.now())
}
