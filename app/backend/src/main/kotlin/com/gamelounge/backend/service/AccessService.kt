package com.gamelounge.backend.service


import com.gamelounge.backend.config.CustomProperties

import com.gamelounge.backend.entity.Session
import com.gamelounge.backend.model.RegisterationRequest
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.HashingUtil.generateHash
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.repository.PasswordResetTokenRepository
import com.gamelounge.backend.repository.SessionRepository
import org.springframework.stereotype.Service
import java.time.LocalDateTime
import java.util.*

@Service
class AccessService(
    val userRepository: UserRepository,
    val sessionRepository: SessionRepository,
    val emailService: EmailService,
    val passwordResetTokenRepository: PasswordResetTokenRepository,
    val passwordResetTokenService: PasswordResetTokenService,
    val customProperties: CustomProperties
){

    fun register(request: RegisterationRequest){
        // Encrypt the password
        val (passwordHash, salt) = generateHash(request.password)

        // Save the data to database
        if (userRepository.existsByUsername(request.username)){
            throw UsernameAlreadyExistException("The username already exists!")
        }
//        val imageUrl: String = s3Service.save(request.image)
        val imageUrl: String = "some-url"
        userRepository.save(User(username = request.username, passwordHash = passwordHash, salt = salt, email = request.email, password = request.password, profilePicture = imageUrl))

    }

    fun login(username: String, password: String): UUID {
        val user = userRepository.findByUsername(username)
            ?: throw UsernameNotFoundException("User not found.")

        // Check credentials, and throw exception if they're incorrect
        if (!verifyPassword(password, user.passwordHash, user.salt)) {
            throw WrongCredentialsException("Wrong credentials.")
        }

        // Create and save session
        val session = Session(UUID.randomUUID(), user, LocalDateTime.now())
        sessionRepository.save(session)

        return session.id
    }

    fun logout(sessionId: UUID) {
        val session = sessionRepository.findById(sessionId)
            .orElseThrow { SessionNotFoundException("Session not found.") }

        try {
            sessionRepository.delete(session)
        } catch (e: Exception) {
            // Log the exception based on your logging strategy
            throw LogoutFailedException("An error occurred while logging out.")
        }
    }


    private fun verifyPassword(rawPassword: String, passwordHash: ByteArray, salt: ByteArray): Boolean {
        val (hash, _) = generateHash(rawPassword, salt)
        return hash.contentEquals(passwordHash)
    }

    // Function to check if a user is logged in with a valid session ID.
    fun isLoggedIn(sessionId: UUID): Boolean {
        val user = sessionRepository.findById(sessionId)
                .map { it.user }
                .orElse(null)

        return user != null
    }

    // Function to change the user's password.
    fun changePassword(sessionId: UUID, currentPassword: String, newPassword: String): Boolean {
        // Find the session associated with the provided sessionId.
        val sessionOptional = sessionRepository.findById(sessionId)

        if (sessionOptional.isEmpty) {
            throw SessionNotFoundException("Session not found.")
        }

        val session = sessionOptional.get()
        val user = session.user ?: throw UsernameNotFoundException("User not found.")

        // Check if the current password is correct.
        if (!verifyPassword(currentPassword, user.passwordHash, user.salt)) {
            throw WrongCredentialsException("Wrong credentials.")
        }

        // Generate a new password hash and salt for the user.
        val (newPasswordHash, newSalt) = generateHash(newPassword)
        user.passwordHash = newPasswordHash
        user.salt = newSalt

        // Save the updated user to the database.
        userRepository.save(user)

        return true
    }

    fun forgotPassword(username: String,email: String) {
        //validate username and email
        val user = userRepository.findByUsername(username)
            ?: throw UsernameNotFoundException("User not found.")
        if (user.email != email){
            throw EmailNotFoundException("Email not found.")
        }
        //generate token
        val token = passwordResetTokenService.createToken(user)

        emailService.sendSimpleMessage(email, "Password Reset", "Click the link to reset your password: ${customProperties.mailUrl}/reset-password?token=$token")
    }

    fun resetPassword(token: String, newPassword: String, confirmNewPassword: String) {
        //validate token

        val passwordResetToken = passwordResetTokenService.validateToken(token)

        //validate password
        if (newPassword != confirmNewPassword){
            throw PasswordMismatchException("Passwords do not match.")
        }

        //update password
        val user = passwordResetToken.user
        val (newPasswordHash, newSalt) = generateHash(newPassword)
        user.passwordHash = newPasswordHash
        user.salt = newSalt
        userRepository.save(user)
        //delete token
        passwordResetTokenRepository.delete(passwordResetToken)
    }


}