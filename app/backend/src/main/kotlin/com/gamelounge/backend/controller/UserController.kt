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
    val sampleUUID: UUID = UUID.fromString("1997004a-6715-45c2-a559-087be232b823")

    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    fun getUserInfoBySessionId(): User{
        return userService.getUserBySessionId(sampleUUID)
    }

    @GetMapping("/{username}")
    @ResponseStatus(HttpStatus.OK)

    fun getUserInfoByUsername(@PathVariable username: String): GetUserInfoResponse{
        return userService.getUserInfoByUsername(username)
    }

    @PostMapping()
    @ResponseStatus(HttpStatus.OK)

    fun updateUserByUserId(
        @RequestPart("request") request: UpdateUserRequest,
        @RequestPart("image") image: MultipartFile?
    ): ResponseEntity<Map<String, String>>{
        val userId = sessionAuth.getUserIdFromSession(sampleUUID)

        userService.updateUser(request, image, userId)

        return ResponseEntity.ok().body(mapOf("message" to "User updated successfully"))
    }

    @GetMapping("/created-posts")
    @ResponseStatus(HttpStatus.OK)

    fun getCreatedPosts(): List<PostDTO>{
        val userId = sessionAuth.getUserIdFromSession(sampleUUID)

        return userService.getCreatedPosts(userId)
    }

    @GetMapping("/created-games")
    @ResponseStatus(HttpStatus.OK)

    fun getCreatedGames(): List<GameDTO>{
        val userId = sessionAuth.getUserIdFromSession(sampleUUID)

        return userService.getCreatedGames(userId)
    }

    @GetMapping("/liked-posts")
    @ResponseStatus(HttpStatus.OK)

    fun getLikedPosts(): List<PostDTO>{
        val userId = sessionAuth.getUserIdFromSession(sampleUUID)

        return userService.getLikedPosts(userId)
    }

    @GetMapping("/liked-comments")
    @ResponseStatus(HttpStatus.OK)

    fun getLikedComments(): List<CommentDTO>{
        val userId = sessionAuth.getUserIdFromSession(sampleUUID)

        return userService.getLikedComments(userId)
    }

}
