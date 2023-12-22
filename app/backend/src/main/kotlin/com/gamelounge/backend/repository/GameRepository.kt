package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.GameStatus
import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.JpaRepository

interface GameRepository: JpaRepository<Game, Long> {

    fun findByUser(user: User): List<Game>

    fun findByStatus(status: GameStatus): List<Game>

}