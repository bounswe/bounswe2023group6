package com.gamelounge.backend.entity
import jakarta.persistence.*
import lombok.NoArgsConstructor
import java.time.LocalDateTime
import java.util.UUID

@Entity
@Table(name = "sessions")
class Session(
    @Id
    val id: UUID,
    @ManyToOne
    @JoinColumn(name = "user_id")  // Specify the correct column name here
    val user: User,
    val timestamp: LocalDateTime
)
{
    constructor() : this(UUID.randomUUID(), User(), LocalDateTime.now())
}
