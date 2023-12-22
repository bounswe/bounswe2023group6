package com.gamelounge.backend.controller

import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.request.CreateGameRequest
import com.gamelounge.backend.model.request.UpdateGameRequest
import com.gamelounge.backend.service.GameService
import com.gamelounge.backend.util.ConverterDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToGameDTO
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.util.*

@RestController
@RequestMapping("/game")
class GameController(private val gameService: GameService) {
    @PostMapping(consumes = [MediaType.MULTIPART_FORM_DATA_VALUE])
    @ResponseStatus(HttpStatus.CREATED)
    fun createGame(@CookieValue("SESSIONID") sessionId: UUID,
                   @RequestPart("request") game: CreateGameRequest,
                   @RequestPart("image") image: MultipartFile?
    ): ResponseEntity<GameDTO> {
        val newGame = gameService.createGame(sessionId, game, image)
        val newGameDTO = ConverterDTO.convertToGameDTO(newGame)
        return ResponseEntity.ok(newGameDTO)
    }

    @GetMapping("/{id}")
    fun getGame(@PathVariable id: Long): ResponseEntity<GameDTO> {
        val game = gameService.getGame(id)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @PutMapping("/{id}")
    fun updateGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody updatedGame: UpdateGameRequest): ResponseEntity<GameDTO> {
        val game = gameService.updateGame(sessionId, id, updatedGame)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @DeleteMapping("/{id}")
    fun deleteGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<Void> {
        gameService.deleteGame(sessionId, id)
        return ResponseEntity.noContent().build<Void>()
    }

    @GetMapping
    fun getAllGames(): ResponseEntity<List<GameDTO>> {
        val gameDTOs = convertBulkToGameDTO(gameService.getAllGames())
        return ResponseEntity.ok(gameDTOs)
    }

    @GetMapping("/recommended")
    fun getRecommendedGames(@CookieValue("SESSIONID") sessionId: UUID?): ResponseEntity<List<GameDTO>> {
        val gameDTOs = gameService.getRecommendedGames(sessionId)
        return ResponseEntity.ok(gameDTOs)
    }

    @PutMapping("/{id}/rating/{score}")
    fun rateGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @PathVariable score: Long): ResponseEntity<GameDTO> {
        val game = gameService.rateGame(sessionId, id, score)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @GetMapping("/rated")
    fun getGamesRatedHighlyByUser(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<GameDTO>> {
        val games = gameService.getRatedGamesByUser(sessionId)
        val gameDTO = ConverterDTO.convertBulkToGameDTO(games)
        return ResponseEntity.ok(gameDTO)
    }
}