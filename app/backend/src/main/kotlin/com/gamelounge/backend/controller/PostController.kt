package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.DTO.UserDTO
import com.gamelounge.backend.model.request.CreatePostRequest
import com.gamelounge.backend.model.request.ReportRequest
import com.gamelounge.backend.model.request.UpdatePostRequest
import com.gamelounge.backend.model.response.ResponseMessage
import com.gamelounge.backend.service.PostService
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/forum/posts")
class PostController(private val postService: PostService) {

    @PostMapping
    @CrossOrigin(origins = ["*"])
    fun createPost(@CookieValue("SESSIONID") sessionId: UUID, @RequestBody post: CreatePostRequest): ResponseEntity<PostDTO> {
        val newPost = postService.createPost(sessionId, post)
        val newPostDTO = ConverterDTO.convertToPostDTO(newPost)
        return ResponseEntity.ok(newPostDTO)
    }

    @GetMapping("/{id}")
    @CrossOrigin(origins = ["*"])
    fun getPost(@PathVariable id: Long): ResponseEntity<PostDTO> {
        val post = postService.getPost(id)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    @PutMapping("/{id}")
    @CrossOrigin(origins = ["*"])
    fun updatePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody updatedPost: UpdatePostRequest): ResponseEntity<PostDTO> {
        val post = postService.updatePost(sessionId, id, updatedPost)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    @DeleteMapping("/{id}")
    @CrossOrigin(origins = ["*"])
    fun deletePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<ResponseMessage> {
        postService.deletePost(sessionId, id)
        return ResponseEntity.ok(ResponseMessage(message = "Post deleted successfully"))
    }

    @GetMapping
    @CrossOrigin(origins = ["*"])
    fun getAllPosts(): ResponseEntity<List<PostDTO>> {
        val posts = postService.getAllPosts()
        val postsDTO = ConverterDTO.convertBulkToPostDTO(posts)
        return ResponseEntity.ok(postsDTO)
    }

    // implement upvote endpoint
    @PutMapping("/{id}/upvote")
    @CrossOrigin(origins = ["*"])
    fun upvotePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<PostDTO> {
        val post = postService.upvotePost(sessionId, id)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    // implement downvote endpoint
    @PutMapping("/{id}/downvote")
    @CrossOrigin(origins = ["*"])
    fun downvotePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<PostDTO> {
        val post = postService.downvotePost(sessionId, id)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    // implement get upvoted users endpoint
    @GetMapping("/{id}/upvoteUsers")
    @CrossOrigin(origins = ["*"])
    fun getUpvotedUsers(@PathVariable id: Long): ResponseEntity<List<UserDTO>> {
        val upvotedUsersDTO = postService.getUpvotedUsers(id)
        return ResponseEntity.ok(upvotedUsersDTO)
    }

    // implement get downvoted users endpoint
    @GetMapping("/{id}/downvoteUsers")
    @CrossOrigin(origins = ["*"])
    fun getDownvotedUsers(@PathVariable id: Long): ResponseEntity<List<UserDTO>> {
        val downvotedUsersDTO = postService.getDownvotedUsers(id)
        return ResponseEntity.ok(downvotedUsersDTO)
    }
    // REPORT POST
    @PostMapping("/{id}/report")
    @CrossOrigin(origins = ["*"])
    fun reportPost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody reqBody: ReportRequest): ResponseEntity<ResponseMessage> {
        postService.reportPost(sessionId, id, reqBody)
        return ResponseEntity.ok(ResponseMessage(message = "Post reported successfully"))
    }

}
