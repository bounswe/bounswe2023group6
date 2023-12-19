package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.GameStatus
import com.gamelounge.backend.entity.RequestedEditingGame
import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.JpaRepository

interface EditedGameRepository: JpaRepository<RequestedEditingGame, Long> {

    fun findByGameId (gameId: Long): List<RequestedEditingGame>

}