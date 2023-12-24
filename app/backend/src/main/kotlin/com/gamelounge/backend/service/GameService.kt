package com.gamelounge.backend.service

import com.gamelounge.backend.entity.*
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.request.CreateGameRequest
import com.gamelounge.backend.model.request.UpdateGameRequest
import jakarta.transaction.Transactional
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.util.*
import com.gamelounge.backend.entity.UserGameRating
import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToGameDTO
import com.gamelounge.backend.model.DTO.UserGameRatingDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToUserGameRatingDTO
import com.gamelounge.backend.model.request.CreateEditingRequest
import com.gamelounge.backend.model.request.ReportRequest
import com.gamelounge.backend.repository.*

@Service
class GameService(
        private val gameRepository: GameRepository,
        private val editedGameRepository: EditedGameRepository,
        private val userGameRatingRepository: UserGameRatingRepository,
        private val sessionAuth: SessionAuth,
        private val userRepository: UserRepository,
        private val recommendationService: RecommendationService,
        private val reportRepository: ReportRepository,
        val s3Service: S3Service,
        private val gameSimilarityService: GameSimilarityService
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
        gameSimilarityService.updateSimilarGamesField(newGame)
        gameRepository.save(newGame) // save to get gameId for image name
        image?.let { saveImageInS3AndImageURLInDBForGame(image, newGame) }

        return gameRepository.save(newGame)
    }

    fun createEditingRequest(sessionId: UUID, editedGame: CreateEditingRequest, image: MultipartFile?, gameId: Long): RequestedEditingGame {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val game = getGame(gameId)

        if (game.user?.userId != userId) {
            throw UnauthorizedGameAccessException("Unauthorized to update game with ID: $gameId")
        }

        // don't allow if the game is pending status
        if (game.status == GameStatus.PENDING_APPROVAL) {
            throw WrongGameStatusException("Game with ID: $gameId is pending approval. After approval, you can edit the game.")
        }

        val existedEditingRequest = editedGameRepository.findByGameId(game.gameId)
        if (existedEditingRequest.isNotEmpty()) {
            throw DuplicatedEditingRequestException("Not allowed to edit more than once")
        }

        val requestEditingGame = RequestedEditingGame(
                gameId = gameId,
                title = editedGame.title,
                description = editedGame.description,
                genre = editedGame.genre,
                platform = editedGame.platform,
                playerNumber = editedGame.playerNumber,
                releaseYear = editedGame.releaseYear,
                universe = editedGame.universe,
                mechanics = editedGame.mechanics,
                playtime = editedGame.playtime,
        )
        editedGameRepository.save(requestEditingGame) // save to get gameId for image name
        image?.let { saveImageInS3AndImageURLInDBForEditedGame(image, requestEditingGame) }
        return editedGameRepository.save(requestEditingGame)
    }

    private fun saveImageInS3AndImageURLInDBForGame(image: MultipartFile, game: Game) {
        game.gamePicture = s3Service.uploadGamePictureAndReturnURL(image, game.gameId)
        gameRepository.save(game)
    }

    private fun saveImageInS3AndImageURLInDBForEditedGame(image: MultipartFile, editedGame: RequestedEditingGame) {
        editedGame.gamePicture = s3Service.uploadGamePictureAndReturnURL(image, editedGame.gameId)
        editedGameRepository.save(editedGame)
    }

    fun getGame(gameId: Long): Game {
        return gameRepository.findById(gameId).filter { !it.isDeleted }.orElseThrow { GameNotFoundException("Game not found with ID: $gameId") }
    }

    fun getEditingGame(editingGameId: Long): RequestedEditingGame {
        return editedGameRepository.findById(editingGameId).orElseThrow { GameNotFoundException("Requested editing game not found with ID: $editingGameId") }
    }

    fun updateGame(sessionId: UUID, gameId: Long, updatedGame: UpdateGameRequest): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val game = getGame(gameId)

        if (game.user?.userId != userId) {
            throw UnauthorizedGameAccessException("Unauthorized to update post with ID: $gameId")
        }

        // don't allow deleted games to be updated
        if (game.isDeleted) {
            throw DeletedGameException("Game with ID: $gameId is deleted")
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

        // don't allow deleted games to be updated
        if (game.isDeleted) {
            throw DeletedGameException("Game with ID: $gameId is deleted")
        }

        game.isDeleted = true
        gameRepository.save(game)
    }

    fun getAllGames(): List<Game> {
        return gameRepository.findAll().filter { !it.isDeleted }
    }

    fun getRatedGamesByUser(sessionId: UUID): List<UserGameRatingDTO> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val userGameRatings = userGameRatingRepository.findByUser(user)

        return convertBulkToUserGameRatingDTO(userGameRatings)
    }

    @Transactional
    fun rateGame(sessionId: UUID, gameId: Long, score: Long): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val game = getGame(gameId)

        if (game.isDeleted) {
            throw DeletedGameException("Game with ID: $gameId is deleted")
        }

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
        return gameRepository.findAllById(pendingGameIds).filter { !it.isDeleted }
    }

    fun getEditedGames(sessionId: UUID): List<RequestedEditingGame> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        if (user.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to get edited games")
        }
        val editedGames = editedGameRepository.findAll()
        val editedGameIds = editedGames.map { it.id }
        return editedGameRepository.findAllById(editedGameIds)
    }

    @Transactional
    fun approveEditingGame(sessionId: UUID, editingGameId: Long): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }

        val requestedEditingGame = getEditingGame(editingGameId)
        val game = getGame(requestedEditingGame.gameId)

        if (game.isDeleted) {
            throw DeletedGameException("Game with ID: ${game.gameId} is deleted")
        }

        if (user.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to approve editing game with ID: ${game.gameId}")
        }

        game.title = requestedEditingGame.title
        game.description = requestedEditingGame.description
        game.genre = requestedEditingGame.genre
        game.platform = requestedEditingGame.platform
        game.playerNumber = requestedEditingGame.playerNumber
        game.releaseYear = requestedEditingGame.releaseYear
        game.universe = requestedEditingGame.universe
        game.mechanics = requestedEditingGame.mechanics
        game.playtime = requestedEditingGame.playtime

        editedGameRepository.delete(requestedEditingGame)
        return gameRepository.save(game)
    }

    fun rejectEditingGame(sessionId: UUID, editingGameId: Long): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }

        val requestedEditingGame = getEditingGame(editingGameId)
        val game = getGame(requestedEditingGame.gameId)

        if (game.isDeleted) {
            throw DeletedGameException("Game with ID: ${game.gameId} is deleted")
        }

        if (user.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to reject editing game with ID: ${game.gameId}")
        }

        editedGameRepository.delete(requestedEditingGame)

        return game
    }

    @Transactional
    fun approveGame(sessionId: UUID, gameId: Long): Game {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val game = getGame(gameId)

        if (game.isDeleted) {
            throw DeletedGameException("Game with ID: ${game.gameId} is deleted")
        }

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

        if (game.isDeleted) {
            throw DeletedGameException("Game with ID: ${game.gameId} is deleted")
        }

        if (user.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to reject game with ID: $gameId")
        }

        if (game.status != GameStatus.PENDING_APPROVAL) {
            throw WrongGameStatusException("Game with ID: $gameId is not pending approval")
        }

        game.status = GameStatus.REJECTED

        return gameRepository.save(game)
    }

    fun getRecommendedGames(sessionId: UUID?): List<GameDTO>{
        var gameDTOs = convertBulkToGameDTO(getAllGames())

        sessionId?.let {
            gameDTOs = try{
                val userId = sessionAuth.getUserIdFromSession(sessionId)
                val user = userRepository.findByUserId(userId)
                convertBulkToGameDTO(recommendationService.getRecommendedGames(user!!))
            }catch (e: SessionNotFoundException){
                convertBulkToGameDTO(getAllGames())
            }
        }

        return gameDTOs
    }

    fun reportGame(sessionId: UUID, gameId: Long, reqBody: ReportRequest) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val game = getGame(gameId)

        if (game.isDeleted) {
            throw DeletedGameException("Game with ID: ${game.gameId} is deleted")
        }

        var newReport = Report(reason = reqBody.reason, reportingUser = user, reportedGame = game)
        reportRepository.save(newReport)
    }

}