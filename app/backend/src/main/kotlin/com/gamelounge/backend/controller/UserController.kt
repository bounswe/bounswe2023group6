package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.User
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.*
import com.gamelounge.backend.model.request.UpdateUserRequest
import com.gamelounge.backend.model.response.GetUserInfoResponse
import com.gamelounge.backend.model.response.ResponseMessage
import com.gamelounge.backend.service.UserService
import com.gamelounge.backend.util.ConverterDTO
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
    fun getUserInfoBySessionId(@CookieValue("SESSIONID") sessionId: UUID): UserDTO {
        return userService.getUserBySessionId(sessionId)
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
        @RequestPart("image") image: MultipartFile?,
        @CookieValue("SESSIONID") sessionId: UUID
    ): ResponseEntity<Map<String, String>>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        userService.updateUser(request, image, userId)

        return ResponseEntity.ok().body(mapOf("message" to "User updated successfully"))
    }

    @GetMapping("/created-posts")
    @ResponseStatus(HttpStatus.OK)
    fun getCreatedPosts(@CookieValue("SESSIONID") sessionId: UUID): List<PostDTO>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        return userService.getCreatedPosts(userId)
    }

    @GetMapping("/created-posts/{userId}")
    @ResponseStatus(HttpStatus.OK)
    fun getCreatedPostsByUserId(@PathVariable userId: Long): List<PostDTO>{
        return userService.getCreatedPosts(userId)
    }

    @GetMapping("/created-games")
    @ResponseStatus(HttpStatus.OK)
    fun getCreatedGames(@CookieValue("SESSIONID") sessionId: UUID): List<GameDTO>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        return userService.getCreatedGames(userId)
    }

    @GetMapping("/created-games/{userId}")
    @ResponseStatus(HttpStatus.OK)
    fun getCreatedGamesByUserId(@PathVariable userId: Long): List<GameDTO>{
        return userService.getCreatedGames(userId)
    }

    @GetMapping("/liked-posts")
    @ResponseStatus(HttpStatus.OK)
    fun getLikedPosts(@CookieValue("SESSIONID") sessionId: UUID): List<PostDTO>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        return userService.getLikedPosts(userId)
    }

    @GetMapping("/liked-posts/{userId}")
    @ResponseStatus(HttpStatus.OK)
    fun getLikedPostsByUserId(@PathVariable userId: Long): List<PostDTO>{
        return userService.getLikedPosts(userId)
    }

    @GetMapping("/liked-comments")
    @ResponseStatus(HttpStatus.OK)
    fun getLikedComments(@CookieValue("SESSIONID") sessionId: UUID): List<CommentDTO>{
        val userId = sessionAuth.getUserIdFromSession(sessionId)

        return userService.getLikedComments(userId)
    }

    @GetMapping("/liked-comments/{userId}")
    @ResponseStatus(HttpStatus.OK)
    fun getLikedCommentsByUserId(@PathVariable userId: Long): List<CommentDTO>{
        return userService.getLikedComments(userId)
    }

    @PutMapping("/follow-user/{userIdToBeFollowed}")
    @ResponseStatus(HttpStatus.OK)
    fun followUser(
            @CookieValue("SESSIONID") sessionId: UUID,
            @PathVariable userIdToBeFollowed: Long
    ): ResponseEntity<Map<String, String>>{
        userService.followUser(sessionId, userIdToBeFollowed)
        return ResponseEntity.ok().body(mapOf("message" to "User followed successfully"))
    }

    @PutMapping("/unfollow-user/{userIdToBeFollowed}")
    @ResponseStatus(HttpStatus.OK)
    fun unfollowUser(
            @CookieValue("SESSIONID") sessionId: UUID,
            @PathVariable userIdToBeFollowed: Long
    ): ResponseEntity<Map<String, String>>{
        userService.unfollowUser(sessionId, userIdToBeFollowed)
        return ResponseEntity.ok().body(mapOf("message" to "User followed successfully"))
    }

    @GetMapping("/get-followings")
    fun getFollowings(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<UserDTO>> {
        val followedUsers = userService.getFollowings(sessionId)
        val followedUserDTO = ConverterDTO.convertBulkToUserDTO(followedUsers)
        return ResponseEntity.ok(followedUserDTO)
    }

    @GetMapping("/get-users")
    fun getVisibleUsers(): ResponseEntity<List<UserDTO>> {
        val visibleUsers = userService.getVisibleUsers()
        val visibleUsersDTO = ConverterDTO.convertBulkToUserDTO(visibleUsers)
        return ResponseEntity.ok(visibleUsersDTO)
    }

    @PutMapping("/delete")
    fun deleteUser(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<ResponseMessage>{
        userService.deleteUser(sessionId)
        return ResponseEntity.ok(ResponseMessage(message = "User deleted successfully"))
    }

}