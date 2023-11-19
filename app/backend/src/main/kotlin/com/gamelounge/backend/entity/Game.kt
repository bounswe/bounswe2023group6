package com.gamelounge.backend.entity

import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne

import jakarta.persistence.*

@Entity
@Table(name = "games")
class Game (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val gameId: Long? = null,

    val title: String = "",
    val description: String = "",
    val genre: String = "",
    val platform: String = "",
    val avatarDetails: String = "", // Consider a more complex structure
    val playerNumber: String = "",
    val releaseYear: Int = 0,
    val universe: String = "",
    val mechanics: String = "",
    val playtime: String = "",
    val mapInformation: String = "",

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    val user: User? = null
)