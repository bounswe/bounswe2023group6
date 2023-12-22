package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.UserGameRating
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.entity.Game
import org.springframework.data.jpa.repository.JpaRepository

interface UserGameRatingRepository: JpaRepository<UserGameRating, Long> {
    fun findByUserAndGame(user: User, game: Game): List<UserGameRating>

    fun findByUser(user: User): List<UserGameRating>
}

