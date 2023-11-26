package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.request.CreateGameRequest
import com.gamelounge.backend.model.request.UpdateGameRequest
import com.gamelounge.backend.repository.GameRepository
import com.gamelounge.backend.repository.UserRepository
import jakarta.transaction.Transactional
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.util.*

@Service
class GameService(
        private val gameRepository: GameRepository,
        private val sessionAuth: SessionAuth,
        private val userRepository: UserRepository,
        val s3Service: S3Service
) {
    fun createGame(sessionId: UUID, game: CreateGameRequest, image: MultipartFile?): Game {
    //fun createGame(sessionId: UUID, game: CreateGameRequest): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val newGame = Game(
                title = game.title,
                description = game.description,
                genre = game.genre,
                platform = game.platform,
                playerNumber = game.playerNumber,
                releaseYear = game.releaseYear,
                universe = game.universe,
                mechanics = game.mechanics,
                playtime = game.playtime,
                user = user,
        )
        image?.let { saveImageInS3AndImageURLInDBForGame(image, newGame) }
        return gameRepository.save(newGame)
    }

    private fun saveImageInS3AndImageURLInDBForGame(image: MultipartFile, game: Game) {
        game.gamePicture = s3Service.uploadGamePictureAndReturnURL(image, game.gameId)
        gameRepository.save(game)
    }

    fun getGame(gameId: Long): Game {
        return gameRepository.findById(gameId).orElseThrow { GameNotFoundException("Game not found with ID: $gameId") }
    }

    fun updateGame(sessionId: UUID, gameId: Long, updatedGame: UpdateGameRequest): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val game = getGame(gameId)

        if (game.user?.userId != userId) {
            throw UnauthorizedGameAccessException("Unauthorized to update post with ID: $gameId")
        }

        game.title = updatedGame.title
        game.description = updatedGame.description
        game.genre = updatedGame.genre
        game.platform = updatedGame.platform
        game.playerNumber = updatedGame.playerNumber
        game.releaseYear = updatedGame.releaseYear
        game.universe = updatedGame.universe
        game.mechanics = updatedGame.mechanics
        game.playtime = updatedGame.playtime

        return gameRepository.save(game)
    }

    fun deleteGame(sessionId: UUID, gameId: Long) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val game = getGame(gameId)

        if (game.user?.userId != userId) {
            throw UnauthorizedGameAccessException("Unauthorized to delete post with ID: $gameId")
        }

        gameRepository.delete(game)
    }

    fun getAllGames(): List<Game> {
        return gameRepository.findAll()
    }

    @Transactional
    fun rateGame(sessionId: UUID, gameId: Long, score: Long): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val game = getGame(gameId)

        if (score < 1 || score > 5) {
            throw WrongRatingGameException("Rating interval ranges from 5 to 1 for the game ID: $gameId")
        }

        val alreadyRated = game.ratedUsers.contains(user)
        if (alreadyRated){
            throw DuplicatedRatingGameException("Not allowed to rate more than once")
        }
        game.ratedUsers.add(user)
        game.countRating += 1
        game.totalRating += score.toInt()
        game.averageRating = game.totalRating.toDouble() / game.countRating.toDouble()

        return gameRepository.save(game)
    }
}