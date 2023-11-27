package com.gamelounge.backend

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.request.CreateGameRequest
import com.gamelounge.backend.repository.GameRepository
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.service.GameService
import com.gamelounge.backend.service.S3Service
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test
import org.mockito.Mockito.mock
import org.mockito.kotlin.any
import org.mockito.kotlin.whenever
import org.springframework.web.multipart.MultipartFile
import java.util.*

class GameServiceTest {
    private val gameRepository: GameRepository = mock()
    private val sessionAuth: SessionAuth = mock()
    private val userRepository: UserRepository = mock()
    private val s3Service: S3Service = mock()
    private val gameService = GameService(
        gameRepository,
        sessionAuth,
        userRepository,
        s3Service
    )
    @Test
    fun `createGame should create and save game without image`() {
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameRequest = CreateGameRequest(
            title = "Game Title",
            description = "Description",
            genre = "Genre",
            platform = "Platform",
            playerNumber = "Player Number",
            releaseYear = 2020,
            universe = "Universe",
            mechanics = "Mechanics",
            playtime = "100",
            totalRating = 0,
            countRating = 0,
            averageRating = 0.0,
        )

        val user = User(userId = userId)

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(userRepository.findById(userId)).thenReturn(Optional.of(user))
        whenever(gameRepository.save(any<Game>())).thenAnswer { invocation -> invocation.arguments[0] as Game }

        val result = gameService.createGame(sessionId, gameRequest, null)

        assertNotNull(result)
        assertEquals(gameRequest.title, result.title)
        assertEquals(gameRequest.description, result.description)
        assertEquals(gameRequest.genre, result.genre)
        assertEquals(gameRequest.platform, result.platform)
        assertEquals(gameRequest.playerNumber, result.playerNumber)
        assertEquals(gameRequest.releaseYear, result.releaseYear)
        assertEquals(gameRequest.universe, result.universe)
        assertEquals(gameRequest.mechanics, result.mechanics)
        assertEquals(gameRequest.playtime, result.playtime)
        assertEquals(gameRequest.totalRating, result.totalRating)
        assertEquals(gameRequest.countRating, result.countRating)
        assertEquals(gameRequest.averageRating, result.averageRating)
        assertEquals(user, result.user)
    }

    @Test
    fun `createGame should create and save game with image`() {
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val gameRequest = CreateGameRequest(
            title = "Game Title",
            description = "Description",
            genre = "Genre",
            platform = "Platform",
            playerNumber = "Player Number",
            releaseYear = 2020,
            universe = "Universe",
            mechanics = "Mechanics",
            playtime = "100",
            totalRating = 0,
            countRating = 0,
            averageRating = 0.0,
        )

        val image: MultipartFile = mock()

        whenever(s3Service.uploadProfilePictureAndReturnURL(image, userId)).thenReturn("imageUrl")
        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(userRepository.findById(userId)).thenReturn(Optional.of(User(userId = userId)))
        whenever(gameRepository.save(any<Game>())).thenAnswer { invocation ->
            (invocation.arguments[0] as Game).apply { gamePicture = "imageUrl" }
        }

        val result = gameService.createGame(sessionId, gameRequest, image)

        assertNotNull(result)
        assertEquals("imageUrl", result.gamePicture)
    }





}