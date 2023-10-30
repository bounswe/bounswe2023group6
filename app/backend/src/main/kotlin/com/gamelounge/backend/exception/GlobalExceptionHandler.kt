package com.gamelounge.backend.exception

import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice

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



}