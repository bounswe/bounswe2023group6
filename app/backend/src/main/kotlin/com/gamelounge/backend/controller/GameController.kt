package com.gamelounge.backend.controller

import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.request.CreateGameRequest
import com.gamelounge.backend.model.request.CreatePostRequest
import com.gamelounge.backend.model.request.RegisterationRequest
import com.gamelounge.backend.model.request.UpdateGameRequest
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
class GameController(private val gameService: GameService) {

    // Static Session ID for testing
    val sampleUUID: UUID = UUID.fromString("1997004a-6715-45c2-a559-087be232b823")

    @PostMapping(consumes = [MediaType.MULTIPART_FORM_DATA_VALUE])
    @ResponseStatus(HttpStatus.CREATED)
    fun createGame(@RequestPart("request") game: CreateGameRequest,
                   @RequestPart("image") image: MultipartFile?
    ): ResponseEntity<GameDTO> {
        val newGame = gameService.createGame(sampleUUID, game, image);
        val newGameDTO = ConverterDTO.convertToGameDTO(newGame);
        return ResponseEntity.ok(newGameDTO);
    }

    @GetMapping("/{id}")
    fun getGame(@PathVariable id: Long): ResponseEntity<GameDTO> {
        val game = gameService.getGame(id);
        val gameDTO = ConverterDTO.convertToGameDTO(game);
        return ResponseEntity.ok(gameDTO);
    }

    @PutMapping("/{id}")
    fun updateGame(@PathVariable id: Long, @RequestBody updatedGame: UpdateGameRequest): ResponseEntity<GameDTO> {
        val game = gameService.updateGame(sampleUUID, id, updatedGame);
        val gameDTO = ConverterDTO.convertToGameDTO(game);
        return ResponseEntity.ok(gameDTO);
    }

    @DeleteMapping("/{id}")
    fun deleteGame(@PathVariable id: Long): ResponseEntity<Void> {
        gameService.deleteGame(sampleUUID, id);
        return ResponseEntity.noContent().build<Void>();
    }

    @GetMapping
    fun getAllGames(): ResponseEntity<List<GameDTO>> {
        val games = gameService.getAllGames();
        val gameDTOs = ConverterDTO.convertBulkToGameDTO(games);
        return ResponseEntity.ok(gameDTOs);
    }

    @PutMapping("/{id}/rating/{score}")
    fun rateGame(@PathVariable id: Long, @PathVariable score: Long): ResponseEntity<GameDTO> {
        val game = gameService.rateGame(sampleUUID, id, score);
        val gameDTO = ConverterDTO.convertToGameDTO(game);
        return ResponseEntity.ok(gameDTO);
    }
}