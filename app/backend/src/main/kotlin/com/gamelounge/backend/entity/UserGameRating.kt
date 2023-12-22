package com.gamelounge.backend.entity

import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne

import jakarta.persistence.*
import lombok.NoArgsConstructor
import java.time.Instant

@Entity
@Table(name = "user_game_ratings")
@NoArgsConstructor
class UserGameRating (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @ManyToOne
    @JoinColumn(name = "userId")
    val user: User,

    @ManyToOne
    @JoinColumn(name = "gameId")
    val game: Game,

    var score: Int = 0 // provide a default value for the score
){
    // JPA requires a no-arg constructor, so provide one
    protected constructor() : this(null, User(), Game(), 0)
}





