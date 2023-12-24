package com.gamelounge.backend.exception

import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice
import software.amazon.awssdk.services.s3.model.S3Exception

@RestControllerAdvice
class GlobalExceptionHandler {

    private val logger = LoggerFactory.getLogger(javaClass)

    @ExceptionHandler(UsernameAlreadyExistException::class)
    fun handleUsernameAlreadyExistException(exception: UsernameAlreadyExistException): ResponseEntity<Map<String, String?>> {

        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
            .body(mapOf("errorMessage" to exception.message))

    }

    @ExceptionHandler(UsernameNotFoundException::class)
    fun handleUsernameNotFoundException(exception: UsernameNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(WrongCredentialsException::class)
    fun handleWrongCredentialsException(exception: WrongCredentialsException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
            .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(SessionNotFoundException::class)
    fun handleSessionNotFoundException(exception: SessionNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(LogoutFailedException::class)
    fun handleLogoutFailedException(exception: LogoutFailedException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
            .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(EmailNotFoundException::class)
    fun handleEmailNotFoundException(exception: EmailNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(TokenNotFoundException::class)
    fun handleTokenNotFoundException(exception: TokenNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(PasswordMismatchException::class)
    fun handlePasswordMismatchException(exception: PasswordMismatchException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
            .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(UserNotFoundException::class)
    fun handleUserNotFoundException(exception: UserNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(PostNotFoundException::class)
    fun handlePostNotFoundException(exception: PostNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(GameNotFoundException::class)
    fun handleGetNotFoundException(exception: GameNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(CharacterNotFoundException::class)
    fun handleCharacterNotFoundException(exception: CharacterNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(UnauthorizedPostAccessException::class)
    fun handleUnauthorizedPostAccessException(exception: UnauthorizedPostAccessException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
            .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(UnauthorizedGameAccessException::class)
    fun handleUnauthorizedGameAccessException(exception: UnauthorizedGameAccessException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(UnauthorizedCharacterAccessException::class)
    fun handleUnauthorizedCharacterAccessException(exception: UnauthorizedCharacterAccessException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(CommentNotFoundException::class)
    fun handleCommentNotFoundException(exception: CommentNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(UnauthorizedCommentAccessException::class)
    fun handleUnauthorizedCommentAccessException(exception: UnauthorizedCommentAccessException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
            .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(S3Exception::class)
    fun handleAmazonS3Exception(exception: S3Exception): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(WrongRatingGameException::class)
    fun handleWrongRatingGameException(exception: WrongRatingGameException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(DuplicatedRatingGameException::class)
    fun handleDuplicatedRatingGameException(exception: DuplicatedRatingGameException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(WrongGameStatusException::class)
    fun handleWrongGameStatusException(exception: WrongGameStatusException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(DuplicatedEditingRequestException::class)
    fun handleDuplicatedEditingRequestException(exception: DuplicatedEditingRequestException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(DuplicatedUserFollowing::class)
    fun handleDuplicatedUserFollowing(exception: DuplicatedUserFollowing): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(DeletedGameException::class)
    fun handleDeletedGameException(exception: DeletedGameException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(UnauthorizedLFGAccessException::class)
    fun handleUnauthorizedLFGAccessException(exception: UnauthorizedLFGAccessException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(LFGNotFoundException::class)
    fun handleLFGNotFoundException(exception: LFGNotFoundException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(mapOf("errorMessage" to exception.message))
    }

    @ExceptionHandler(DuplicateGameException::class)
    fun handleDuplicateGameException(exception: DuplicateGameException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }
    @ExceptionHandler(UnauthorizedReportsAccessException::class)
    fun handleUnauthorizedReportsAccessException(exception: UnauthorizedReportsAccessException): ResponseEntity<Map<String, String?>> {
        logger.info(exception.message)
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(mapOf("errorMessage" to exception.message))
    }


}