package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Character
import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.exception.CharacterNotFoundException
import com.gamelounge.backend.exception.UnauthorizedCharacterAccessException
import com.gamelounge.backend.exception.UnauthorizedGameAccessException
import com.gamelounge.backend.exception.UsernameNotFoundException
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.request.CreateCharacterRequest
import com.gamelounge.backend.model.request.UpdateCharacterRequest
import com.gamelounge.backend.repository.CharacterRepository
import com.gamelounge.backend.repository.UserRepository
import org.springframework.stereotype.Service
import java.util.*

@Service
class CharacterService(
        private val characterRepository: CharacterRepository,
        private val sessionAuth: SessionAuth,
        private val userRepository: UserRepository
) {
    fun createCharacter(sessionId: UUID, character: CreateCharacterRequest, game: Game): Character {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val newCharacter = Character(
                name = character.name,
                description = character.description,
                relatedGame = game,
                user = user
        )
        return characterRepository.save(newCharacter)
    }

    fun getCharacter(characterId: Long): Character {
        return characterRepository.findById(characterId).orElseThrow { CharacterNotFoundException("Character not found with ID: $characterId") }
    }

    fun updateCharacter(sessionId: UUID, characterId: Long, updatedCharacter: UpdateCharacterRequest): Character {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val character = getCharacter(characterId)

        if (character.user?.userId != userId) {
            throw UnauthorizedCharacterAccessException("Unauthorized to update character with ID: $characterId")
        }

        character.name = updatedCharacter.name
        character.description = updatedCharacter.description

        return characterRepository.save(character)
    }

    fun deleteCharacter(sessionId: UUID, characterId: Long) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val character = getCharacter(characterId)

        if (character.user?.userId != userId) {
            throw UnauthorizedCharacterAccessException("Unauthorized to delete character with ID: $characterId")
        }

        characterRepository.delete(character)
    }
}