package com.gamelounge.backend.controller

import com.gamelounge.backend.model.LoginRequest
import com.gamelounge.backend.model.RegisterationRequest
import com.gamelounge.backend.service.AccessService
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID


@RestController
@RequestMapping()
class AccessController(
    val accessService: AccessService
) {

    @PostMapping("/register")
    @ResponseStatus(HttpStatus.CREATED)
    fun register(@RequestBody request: RegisterationRequest): ResponseEntity<Map<String, String>> {
        accessService.register(request)
        return ResponseEntity.status(HttpStatus.CREATED).body(mapOf("message" to "Registered successfully!"))
    }

    @PostMapping("/login")
    fun login(@RequestBody request: LoginRequest): ResponseEntity<Pair<String, String>> {
        val sessionId = accessService.login(request.username, request.password)
        return ResponseEntity.ok().header("Set-Cookie", "SESSIONID=$sessionId; HttpOnly").body("message" to "Logged in successfully.")
    }

    @PostMapping("/logout")
    fun logout(@CookieValue("SESSIONID") sessionId: UUID?): ResponseEntity<Map<String, String>> {
        sessionId?.let { accessService.logout(it) }
        return ResponseEntity.ok().body(mapOf("message" to "Logged out successfully."))

    }
}