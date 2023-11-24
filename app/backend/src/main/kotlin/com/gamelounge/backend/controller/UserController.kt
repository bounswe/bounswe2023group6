package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.User
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.CommentDTO
import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.request.UpdateUserRequest
import com.gamelounge.backend.model.response.GetUserInfoResponse
import com.gamelounge.backend.service.UserService
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.util.UUID

@RestController
@RequestMapping("/user")
class UserController (
    val userService: UserService,
    val sessionAuth: SessionAuth
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
    fun updateUserByUserId(
        @RequestPart("request") request: UpdateUserRequest,
        @RequestPart("image") image: MultipartFile?,
        @CookieValue("SESSIONID") sessionId: UUID
    ): ResponseEntity<Map<String, String>>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        userService.updateUser(request, image, userId)

        return ResponseEntity.ok().body(mapOf("message" to "User updated successfully"))
    }

    @GetMapping("/created-posts")
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getCreatedPosts(@CookieValue("SESSIONID") sessionId: UUID): List<PostDTO>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        return userService.getCreatedPosts(userId)
    }

    @GetMapping("/created-games")
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getCreatedGames(@CookieValue("SESSIONID") sessionId: UUID): List<GameDTO>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        return userService.getCreatedGames(userId)
    }

    @GetMapping("/liked-posts")
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getLikedPosts(@CookieValue("SESSIONID") sessionId: UUID): List<PostDTO>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        return userService.getLikedPosts(userId)
    }

    @GetMapping("/liked-comments")
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getLikedComments(@CookieValue("SESSIONID") sessionId: UUID): List<CommentDTO>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        return userService.getLikedComments(userId)
    }

}