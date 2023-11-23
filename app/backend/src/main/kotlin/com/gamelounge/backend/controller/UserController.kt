package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.model.request.RegisterationRequest
import com.gamelounge.backend.model.request.UpdateUserRequest
import com.gamelounge.backend.model.response.GetUserInfoResponse
import com.gamelounge.backend.service.UserService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.util.UUID

@RestController
@RequestMapping("/user")
class UserController (
    val userService: UserService
){
    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getUserInfoBySessionId(@CookieValue("SESSIONID") sessionId: UUID): User{
        return userService.getUserBySessionId(sessionId)
    }

    @GetMapping("/{username}")
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getUserInfoByUsername(@PathVariable username: String): GetUserInfoResponse{
        return userService.getUserInfoByUsername(username)
    }

    @PostMapping()
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun updateUserByUsername(
        @RequestPart("request") request: UpdateUserRequest,
        @RequestPart("image") image: MultipartFile?,
        username: String
    ){
        userService.updateUser(request, image, username)
    }

    @GetMapping("/created-posts")
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getCreatedPosts(username: String): List<Post>{
        return userService.getCreatedPosts(username)
    }

    @GetMapping("/created-games")
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getCreatedGames(username: String): List<Game>{
        return userService.getCreatedGames(username)
    }

}































