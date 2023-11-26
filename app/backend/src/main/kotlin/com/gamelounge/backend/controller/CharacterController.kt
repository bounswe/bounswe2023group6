package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Character
import com.gamelounge.backend.model.DTO.CharacterDTO
import com.gamelounge.backend.model.request.CreateCharacterRequest
import com.gamelounge.backend.model.request.UpdateCharacterRequest
import com.gamelounge.backend.service.CharacterService
import com.gamelounge.backend.service.GameService
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/character/{gameID}")
class CharacterController (private val characterService: CharacterService, private val gameService: GameService) {
    @PostMapping()
    fun createCharacter(@CookieValue("SESSIONID") sessionId: UUID, @RequestBody character: CreateCharacterRequest, @PathVariable gameID: Long
    ): ResponseEntity<CharacterDTO> {
        val game = gameService.getGame(gameID)
        val newCharacter = characterService.createCharacter(sessionId, character, game)
        val newCharacterDTO = ConverterDTO.convertToCharacterDTO(newCharacter)
        return ResponseEntity.ok(newCharacterDTO)
    }

    @GetMapping("/{id}")
    fun getCharacter(@PathVariable id: Long): ResponseEntity<CharacterDTO> {
        val character = characterService.getCharacter(id)
        val characterDTO = ConverterDTO.convertToCharacterDTO(character)
        return ResponseEntity.ok(characterDTO)
    }

    @PutMapping("/{id}")
    fun updateCharacter(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody updatedCharacter: UpdateCharacterRequest): ResponseEntity<CharacterDTO> {
        val character = characterService.updateCharacter(sessionId, id, updatedCharacter)
        val characterDTO = ConverterDTO.convertToCharacterDTO(character)
        return ResponseEntity.ok(characterDTO)
    }

    @DeleteMapping("/{id}")
    fun deleteCharacter(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<Void> {
        characterService.deleteCharacter(sessionId, id)
        return ResponseEntity.noContent().build<Void>()
    }
}