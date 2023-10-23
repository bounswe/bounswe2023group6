package com.gamelounge.backend.controller

import com.gamelounge.backend.model.RegisterationRequest
import com.gamelounge.backend.service.AccessService
import org.springframework.http.HttpStatus
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
}