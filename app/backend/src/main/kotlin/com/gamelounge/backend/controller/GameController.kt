package com.gamelounge.backend.controller

import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.DTO.UserGameRatingDTO
import com.gamelounge.backend.model.request.*
import com.gamelounge.backend.model.response.ResponseMessage
import com.gamelounge.backend.service.GameService
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.util.*


@RestController
@RequestMapping("/game")
class GameController(
    private val gameService: GameService
) {

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

    @PutMapping("/delete/{id}")
    fun deleteGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<ResponseMessage> {
        gameService.deleteGame(sessionId, id)
        return ResponseEntity.ok(ResponseMessage(message = "Game deleted successfully"))
    }

    @GetMapping
    fun getAllGames(): ResponseEntity<List<GameDTO>> {
        val games = gameService.getAllGames()
        val gameDTO = ConverterDTO.convertBulkToGameDTO(games)
        return ResponseEntity.ok(gameDTO)
    }

    @PutMapping("/{id}/rating/{score}")
    fun rateGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @PathVariable score: Long): ResponseEntity<GameDTO> {
        val game = gameService.rateGame(sessionId, id, score)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @GetMapping("/rated")
    fun getGamesRatedByUser(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<UserGameRatingDTO>> {
        val userGameRatingDTOs = gameService.getRatedGamesByUser(sessionId)
        return ResponseEntity.ok(userGameRatingDTOs)
    }

    @PostMapping("/{id}/report")
    fun reportGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody reqBody: ReportRequest): ResponseEntity<ResponseMessage> {
        gameService.reportGame(sessionId, id, reqBody)
        return ResponseEntity.ok(ResponseMessage(message = "Game reported successfully"))
    }

    @PostMapping("/{id}", consumes = [MediaType.MULTIPART_FORM_DATA_VALUE])
    @ResponseStatus(HttpStatus.CREATED)
    fun createEditingRequest(@CookieValue("SESSIONID") sessionId: UUID,
                   @RequestPart("request") editedGame: CreateEditingRequest,
                   @RequestPart("image") image: MultipartFile?,
                   @PathVariable id: Long
    ): ResponseEntity<ResponseMessage> {
        gameService.createEditingRequest(sessionId, editedGame, image, id)
        return ResponseEntity.ok(ResponseMessage(message = "Editing game was requested successfully."))
    }

}