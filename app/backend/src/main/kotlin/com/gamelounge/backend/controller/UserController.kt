package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.User
import com.gamelounge.backend.service.UserService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.CookieValue
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController
import java.util.UUID

@RestController
class UserController (
    val userService: UserService
){
    @GetMapping("/user")
    @ResponseStatus(HttpStatus.OK)
    fun getUserInfoBySessionId(@CookieValue("SESSIONID") sessionId: UUID): User{
        return userService.getUserBySessionId(sessionId)
    }

    @GetMapping("/user/{username}")
    @ResponseStatus(HttpStatus.OK)
    fun getUserInfoByUsername(@PathVariable username: String): User{
        return userService.getUserByUsername(username)
    }

}