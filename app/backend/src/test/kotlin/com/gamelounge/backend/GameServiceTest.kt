import com.gamelounge.backend.constant.GameGenre
import com.gamelounge.backend.constant.GamePlatform
import com.gamelounge.backend.entity.*
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.request.CreateGameRequest
import com.gamelounge.backend.model.request.CreateEditingRequest
import com.gamelounge.backend.model.request.ReportRequest
import com.gamelounge.backend.repository.*
import com.gamelounge.backend.service.GameService
import com.gamelounge.backend.service.RecommendationService
import com.gamelounge.backend.service.S3Service
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import com.gamelounge.backend.constant.GameMechanics
import com.gamelounge.backend.constant.NumberOfPlayers
import com.gamelounge.backend.constant.UniverseInfo
import com.gamelounge.backend.service.GameSimilarityService
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.assertThrows
import org.mockito.ArgumentMatchers.any
import org.mockito.ArgumentMatchers.anyLong
import org.mockito.ArgumentMatchers.anyString
import org.mockito.Mockito.*
import org.springframework.web.multipart.MultipartFile
import java.util.*

class GameServiceTest {

    private val gameRepository: GameRepository = mock()
    private val editedGameRepository: EditedGameRepository = mock()
    private val userGameRatingRepository: UserGameRatingRepository = mock()
    private val sessionAuth: SessionAuth = mock()
    private val userRepository: UserRepository = mock()
    private val recommendationService: RecommendationService = mock()
    private val reportRepository: ReportRepository = mock()
    private val s3Service: S3Service = mock()
    private val gameSimilarityService: GameSimilarityService = mock()

    private val gameService = GameService(
            gameRepository,
            editedGameRepository,
            userGameRatingRepository,
            sessionAuth,
            userRepository,
            recommendationService,
            reportRepository,
            s3Service,
            gameSimilarityService
    )

    @Test
    fun `createGame should create and return a new game`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val createGameRequest = CreateGameRequest(
                title = "New Game",
                description = "Game description",
                genres = listOf("ACTION", "ADVENTURE"),
                platforms = listOf("PC", "XBOX"),
                playerNumber = NumberOfPlayers.Multiplayer,
                releaseYear = 2022,
                universe = UniverseInfo.Fantasy,
                mechanics = GameMechanics.RealTime,
                playtime = "10 hours",
                totalRating = 0,
                countRating = 0,
                averageRating = 0.0
        )
        val image: MultipartFile? = mock()
        val user = User(userId = userId)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.save(any(Game::class.java))).thenAnswer { invocation -> invocation.arguments[0] as Game }
        `when`(s3Service.uploadGamePictureAndReturnURL(any(MultipartFile::class.java), anyLong())).thenReturn("image-url.jpg")

        // Act
        val result = gameService.createGame(sessionId, createGameRequest, image)

        // Assert
        assertEquals(createGameRequest.title, result.title)
        assertEquals(createGameRequest.description, result.description)
        assertEquals(createGameRequest.genres, result.genres)
        assertEquals(createGameRequest.platforms, result.platforms)
        assertEquals(createGameRequest.playerNumber, result.playerNumber)
        assertEquals(createGameRequest.releaseYear, result.releaseYear)
        assertEquals(createGameRequest.universe, result.universe)
        assertEquals(createGameRequest.mechanics, result.mechanics)
        assertEquals(createGameRequest.playtime, result.playtime)
        assertEquals(createGameRequest.totalRating, result.totalRating)
        assertEquals(createGameRequest.countRating, result.countRating)
        assertEquals(createGameRequest.averageRating, result.averageRating)
    }

    @Test
    fun `createEditingRequest should create and return a new editing request`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val createEditingRequest = CreateEditingRequest(
                title = "Updated Title",
                description = "Updated Description",
                genres = listOf("ACTION"),
                platforms = listOf("PC"),
                playerNumber = NumberOfPlayers.Single,
                releaseYear = 2023,
                universe = UniverseInfo.Historical,
                mechanics = GameMechanics.TurnBased,
                playtime = "15 hours",
                totalRating = 0,
                countRating = 0,
                averageRating = 0.0
        )
        val editedImage: MultipartFile? = mock()
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))
        `when`(editedGameRepository.findByGameId(gameId)).thenReturn(emptyList())
        `when`(editedGameRepository.save(any(RequestedEditingGame::class.java))).thenAnswer { invocation -> invocation.arguments[0] as RequestedEditingGame }
        `when`(s3Service.uploadEditedGamePictureAndReturnURL(any(MultipartFile::class.java), anyLong())).thenReturn("edited-image-url.jpg")

        // Act
        gameService.createEditingRequest(sessionId, createEditingRequest, editedImage, gameId)

        // Assert
        verify(editedGameRepository).save(any(RequestedEditingGame::class.java))
    }

    @Test
    fun `deleteGame should mark the game as deleted`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))
        `when`(gameRepository.save(any(Game::class.java))).thenAnswer { invocation -> invocation.arguments[0] as Game }

        // Act
        gameService.deleteGame(sessionId, gameId)

        // Assert
        assertTrue(game.isDeleted)
    }

    @Test
    fun `getAllGames should return a list of approved and non-deleted games`() {
        // Arrange
        val games = listOf(
                Game(title = "Game1", status = GameStatus.APPROVED),
                Game(title = "Game2", status = GameStatus.PENDING_APPROVAL),
                Game(title = "Game3", status = GameStatus.APPROVED, isDeleted = true),
                Game(title = "Game4", status = GameStatus.APPROVED)
        )

        `when`(gameRepository.findAll()).thenReturn(games)

        // Act
        val result = gameService.getAllGames()

        // Assert
        assertEquals(2, result.size)
        assertEquals("Game1", result[0].title)
        assertEquals("Game4", result[1].title)
        // Add more assertions based on your requirements
    }

    @Test
    fun `rateGame should update the game's rating and return the modified game`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val score = 4L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED, totalRating = 10, countRating = 2)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))
        `when`(gameRepository.save(any(Game::class.java))).thenAnswer { invocation -> invocation.arguments[0] as Game }
        `when`(userGameRatingRepository.findByUserAndGame(user, game)).thenReturn(emptyList())

        // Act
        val result = gameService.rateGame(sessionId, gameId, score)

        // Assert
        assertEquals(score.toDouble(), result.averageRating)
        assertEquals(12, result.totalRating)
        assertEquals(3, result.countRating)
    }

    @Test
    fun `rateGame should update the user's rating for the game if already rated`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val score = 4L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED, totalRating = 10, countRating = 2)
        val userGameRating = UserGameRating(user = user, game = game, score = 3)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))
        `when`(gameRepository.save(any(Game::class.java))).thenAnswer { invocation -> invocation.arguments[0] as Game }
        `when`(userGameRatingRepository.findByUserAndGame(user, game)).thenReturn(listOf(userGameRating))

        // Act
        val result = gameService.rateGame(sessionId, gameId, score)

        // Assert
        assertEquals(score.toDouble(), result.averageRating)
        assertEquals(11, result.totalRating)
        assertEquals(2, result.countRating)
    }

    @Test
    fun `rateGame should throw WrongRatingGameException for an invalid rating score`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val invalidScore = 6L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))

        // Act and Assert
        assertThrows<WrongRatingGameException> {
            gameService.rateGame(sessionId, gameId, invalidScore)
        }
    }

    @Test
    fun `deleteGame should throw UnauthorizedGameAccessException if the user is not the owner`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val ownerUserId = 456L
        val user = User(userId = userId)
        val owner = User(userId = ownerUserId)
        val game = Game(gameId = gameId, user = owner, status = GameStatus.APPROVED)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))

        // Act and Assert
        assertThrows<UnauthorizedGameAccessException> {
            gameService.deleteGame(sessionId, gameId)
        }
    }

    @Test
    fun `deleteGame should throw DeletedGameException if the game is already deleted`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED, isDeleted = true)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))

        // Act and Assert
        assertThrows<DeletedGameException> {
            gameService.deleteGame(sessionId, gameId)
        }
    }

    @Test
    fun `rateGame should update the rating of the game and create a UserGameRating`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val score = 4L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED)
        val userGameRating = UserGameRating(user = user, game = game, score = 0)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))
        `when`(userGameRatingRepository.findByUserAndGame(user, game)).thenReturn(emptyList())
        `when`(userGameRatingRepository.save(any(UserGameRating::class.java))).thenAnswer { invocation -> invocation.arguments[0] as UserGameRating }
        `when`(gameRepository.save(any(Game::class.java))).thenAnswer { invocation -> invocation.arguments[0] as Game }

        // Act
        val result = gameService.rateGame(sessionId, gameId, score)

        // Assert
        assertEquals(score, result.averageRating)
        verify(userGameRatingRepository).save(any(UserGameRating::class.java))
    }

    @Test
    fun `rateGame should update the rating of the game and update the UserGameRating`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val score = 4L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED)
        val existingUserGameRating = UserGameRating(user = user, game = game, score = 3)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))
        `when`(userGameRatingRepository.findByUserAndGame(user, game)).thenReturn(listOf(existingUserGameRating))
        `when`(userGameRatingRepository.save(any(UserGameRating::class.java))).thenAnswer { invocation -> invocation.arguments[0] as UserGameRating }
        `when`(gameRepository.save(any(Game::class.java))).thenAnswer { invocation -> invocation.arguments[0] as Game }

        // Act
        val result = gameService.rateGame(sessionId, gameId, score)

        // Assert
        assertEquals(score, result.averageRating)
        verify(userGameRatingRepository).save(any(UserGameRating::class.java))
        // Add more assertions based on your requirements
    }

    @Test
    fun `rateGame should throw DeletedGameException if the game is already deleted`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val score = 4L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED, isDeleted = true)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))

        // Act and Assert
        assertThrows<DeletedGameException> {
            gameService.rateGame(sessionId, gameId, score)
        }
    }

    @Test
    fun `getGame should throw GameNotFoundException if the game does not exist`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val gameId = 1L

        `when`(gameRepository.findById(gameId)).thenReturn(Optional.empty())

        // Act and Assert
        assertThrows<GameNotFoundException> {
            gameService.getGame(gameId)
        }
    }

    @Test
    fun `getEditingGame should throw GameNotFoundException if the editing game does not exist`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val editingGameId = 1L

        `when`(editedGameRepository.findByGameId(editingGameId)).thenReturn(emptyList())

        // Act and Assert
        assertThrows<GameNotFoundException> {
            gameService.getEditingGame(editingGameId)
        }
    }

    @Test
    fun `createGame should update game similarity`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        // Provide necessary details for creating a game
        val createGameRequest = CreateGameRequest(
                title = "New Game",
                description = "Game description",
                genres = listOf("ACTION", "ADVENTURE"),
                platforms = listOf("PC", "XBOX"),
                playerNumber = NumberOfPlayers.Multiplayer,
                releaseYear = 2022,
                universe = UniverseInfo.Fantasy,
                mechanics = GameMechanics.RealTime,
                playtime = "10 hours",
                totalRating = 0,
                countRating = 0,
                averageRating = 0.0
        )
        val image: MultipartFile? = mock()

        val user = User(userId = 123L)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(user.userId)
        `when`(userRepository.findById(user.userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.save(any(Game::class.java))).thenAnswer { invocation -> invocation.arguments[0] as Game }
        `when`(s3Service.uploadGamePictureAndReturnURL(any(MultipartFile::class.java), anyLong())).thenReturn("image-url.jpg")

        // Act
        gameService.createGame(sessionId, createGameRequest, image)

        // Assert
        verify(gameSimilarityService).updateSimilarGamesField(any(Game::class.java))
        verify(gameRepository).save(any(Game::class.java))
    }

    // Add other tests related to game similarity as needed

    @Test
    fun `rateGame should update the game's rating and game similarity`() {
        // Arrange
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameId = 1L
        val score = 4L
        val user = User(userId = userId)
        val game = Game(gameId = gameId, user = user, status = GameStatus.APPROVED, totalRating = 10, countRating = 2)

        `when`(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        `when`(userRepository.findById(userId)).thenReturn(Optional.of(user))
        `when`(gameRepository.findById(gameId)).thenReturn(Optional.of(game))
        `when`(gameRepository.save(any(Game::class.java))).thenAnswer { invocation -> invocation.arguments[0] as Game }
        `when`(userGameRatingRepository.findByUserAndGame(user, game)).thenReturn(emptyList())

        // Act
        val result = gameService.rateGame(sessionId, gameId, score)

        // Assert
        assertEquals(score.toDouble(), result.averageRating)
        assertEquals(12, result.totalRating)
        assertEquals(3, result.countRating)

        verify(gameSimilarityService).updateSimilarGamesField(any(Game::class.java))
        verify(userGameRatingRepository).save(any(UserGameRating::class.java))
    }

}
