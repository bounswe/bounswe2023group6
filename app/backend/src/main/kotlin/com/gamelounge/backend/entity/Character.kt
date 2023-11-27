package com.gamelounge.backend.entity

import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne

import jakarta.persistence.*
import lombok.NoArgsConstructor


@Entity
@Table(name = "characters")
@NoArgsConstructor
class Character(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val characterId: Long = 0,

    var name: String = "",
    var description: String = "",

    @ManyToOne
    @JoinColumn(name = "gameId")
    var relatedGame: Game? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    var user: User? = null,
)