package com.gamelounge.backend.controller

import com.gamelounge.backend.model.LoginRequest
import com.gamelounge.backend.model.RegisterationRequest
import com.gamelounge.backend.service.AccessService
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping()
class AccessController(
    val accessService: AccessService
) {

    @PostMapping("/register")
    @ResponseStatus(HttpStatus.OK)
    fun register(@RequestBody request: RegisterationRequest){
        accessService.register(request)
    }

    @PostMapping("/login")
    fun login(@RequestBody request: LoginRequest): ResponseEntity<String> {
        val sessionId = accessService.login(request.username, request.password)
        return ResponseEntity.ok().header("Set-Cookie", "SESSIONID=$sessionId; HttpOnly").body("Logged in successfully.")
    }

    @PostMapping("/logout")
    fun logout(@CookieValue("SESSIONID") sessionId: String?): ResponseEntity<String> {
        sessionId?.let { accessService.logout(it) }
        return ResponseEntity.ok().body("Logged out successfully.")
    }
}