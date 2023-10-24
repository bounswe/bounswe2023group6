package com.gamelounge.backend.controller

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
    @ResponseStatus(HttpStatus.CREATED)
    fun register(@RequestBody request: RegisterationRequest): ResponseEntity<Map<String, String>> {
        accessService.register(request)
        return ResponseEntity.status(HttpStatus.CREATED).body(mapOf("message" to "Registered successfully!"))
    }
}