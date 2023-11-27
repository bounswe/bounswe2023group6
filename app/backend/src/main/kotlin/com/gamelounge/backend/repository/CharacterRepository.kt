package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Character
import com.gamelounge.backend.entity.Game
import org.springframework.data.jpa.repository.JpaRepository



interface CharacterRepository: JpaRepository<Character, Long> {
    fun findByRelatedGame(game: Game): List<Character>
}