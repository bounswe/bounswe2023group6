package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.repository.CrudRepository

interface GameRepository: JpaRepository<Game, Long> {

    fun findByUser(user: User): List<Game>
}