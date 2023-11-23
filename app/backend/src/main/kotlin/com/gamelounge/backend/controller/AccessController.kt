package com.gamelounge.backend.controller

import com.gamelounge.backend.model.request.*
import com.gamelounge.backend.service.AccessService
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.util.UUID


@RestController
class AccessController(
    val accessService: AccessService
) {
    @PostMapping("/register", consumes = [MediaType.MULTIPART_FORM_DATA_VALUE])
    @CrossOrigin(origins = ["*"])
    @ResponseStatus(HttpStatus.CREATED)
    fun register(
        @RequestPart("request") request: RegisterationRequest,
        @RequestPart("image") image: MultipartFile?
    ): ResponseEntity<Map<String, String>> {

        accessService.register(request, image)
        return ResponseEntity.status(HttpStatus.CREATED).body(mapOf("message" to "Registered successfully!"))

    }

    @PostMapping("/login")
    @CrossOrigin(origins = ["*"])
    fun login(@RequestBody request: LoginRequest): ResponseEntity<Map<String, String>> {
        val sessionId = accessService.login(request.username, request.password)
        return ResponseEntity.ok().header("Set-Cookie", "SESSIONID=$sessionId; HttpOnly").body(mapOf("message" to "Logged in successfully."))
    }

    @PostMapping("/logout")
    @CrossOrigin(origins = ["*"])
    fun logout(@CookieValue("SESSIONID") sessionId: UUID?): ResponseEntity<Map<String, String>> {
        sessionId?.let { accessService.logout(it) }
        return ResponseEntity.ok().body(mapOf("message" to "Logged out successfully."))

    }

    @PostMapping("/change-password")
    @CrossOrigin(origins = ["*"])
    fun changePassword(
            @CookieValue("SESSIONID") sessionId: UUID?,
            @RequestBody request: ChangePasswordRequest
    ): ResponseEntity<Map<String, String>> {
        sessionId?.let { existingSessionId ->
            // First, check if the user is logged in with the provided session ID.
            if (accessService.isLoggedIn(existingSessionId)) {
                if (request.newPassword == request.confirmPassword) {
                    val passwordChangeResult = accessService.changePassword(existingSessionId, request.currentPassword, request.newPassword)
                    if (passwordChangeResult) {
                        return ResponseEntity.ok().body(mapOf("message" to "Password changed successfully."))
                    }
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(mapOf("error" to "Current password is incorrect."))

                }
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(mapOf("error" to "New password and confirmation password do not match."))
            }
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(mapOf("error" to "User is not logged in."))
    }

    @PostMapping("/forgot-password")
    @CrossOrigin(origins = ["*"])
    fun forgotPassword(@RequestBody request: ForgotPasswordRequest): ResponseEntity<Map<String, String>> {
        accessService.forgotPassword(username = request.username, email = request.email)
        return ResponseEntity.ok().body(mapOf("message" to "Password reset token generated successfully."))
    }

    @PostMapping("/reset-password")
    @CrossOrigin(origins = ["*"])
    fun resetPassword(@RequestBody request: ResetPasswordRequest): ResponseEntity<Map<String, String>> {
        accessService.resetPassword(token = request.token, newPassword = request.newPassword, confirmNewPassword = request.confirmNewPassword)
        return ResponseEntity.ok().body(mapOf("message" to "Password reset successfully."))
    }

}