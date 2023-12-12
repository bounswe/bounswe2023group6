package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.GameStatus
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
import com.gamelounge.backend.entity.UserGameRating
import com.gamelounge.backend.repository.UserGameRatingRepository

@Service
class GameService(
        private val gameRepository: GameRepository,
        private val userGameRatingRepository: UserGameRatingRepository,
        private val sessionAuth: SessionAuth,
        private val userRepository: UserRepository,
        val s3Service: S3Service
) {
    fun createGame(sessionId: UUID, game: CreateGameRequest, image: MultipartFile?): Game {
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
                status = GameStatus.PENDING_APPROVAL
        )
        gameRepository.save(newGame) // save to get gameId for image name
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

    fun getRatedGamesByUser(sessionId: UUID): List<Game> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val ratedGames = userGameRatingRepository.findByUser(user)
                .filter { it.score >= 4 }
        val ratedGameIds = ratedGames.map { it.game.gameId }
        return gameRepository.findAllById(ratedGameIds)
    }

    @Transactional
    fun rateGame(sessionId: UUID, gameId: Long, score: Long): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val game = getGame(gameId)

        if (score < 1 || score > 5) {
            throw WrongRatingGameException("Rating interval ranges from 5 to 1 for the game ID: $gameId")
        }

        //val alreadyRated = game.ratedUsers.contains(user)
        val alreadyRated = userGameRatingRepository.findByUserAndGame(user, game)
        if (alreadyRated.isNotEmpty()){
            throw DuplicatedRatingGameException("Not allowed to rate more than once")
        }

        val userGameRating = UserGameRating(user = user, game = game, score = score.toInt())
        //game.ratedUsers.add(user)
        game.countRating += 1
        game.totalRating += score.toInt()
        game.averageRating = game.totalRating.toDouble() / game.countRating.toDouble()

        userGameRatingRepository.save(userGameRating)
        return gameRepository.save(game)
    }

    fun getPendingGames(sessionId: UUID): List<Game> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        if (user.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to get pending games")
        }
        val pendingGames = gameRepository.findByStatus(GameStatus.PENDING_APPROVAL)
        val pendingGameIds = pendingGames.map { it.gameId }
        return gameRepository.findAllById(pendingGameIds)
    }

    @Transactional
    fun approveGame(sessionId: UUID, gameId: Long): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val game = getGame(gameId)

        if (user.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to approve game with ID: $gameId")
        }

        if (game.status != GameStatus.PENDING_APPROVAL) {
            throw WrongGameStatusException("Game with ID: $gameId is not pending approval")
        }
        game.status = GameStatus.APPROVED

        return gameRepository.save(game)
    }

    fun rejectGame(sessionId: UUID, gameId: Long): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val game = getGame(gameId)

        if (user.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to reject game with ID: $gameId")
        }

        if (game.status != GameStatus.PENDING_APPROVAL) {
            throw WrongGameStatusException("Game with ID: $gameId is not pending approval")
        }
        game.status = GameStatus.REJECTED

        return gameRepository.save(game)
    }

}