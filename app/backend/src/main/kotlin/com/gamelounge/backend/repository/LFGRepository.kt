package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.LFG
import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.repository.CrudRepository

interface LFGRepository: JpaRepository<LFG, Long> {

    fun findByUser(user: User): List<LFG>
    fun findByRelatedGame(game: Game): List<LFG>
}