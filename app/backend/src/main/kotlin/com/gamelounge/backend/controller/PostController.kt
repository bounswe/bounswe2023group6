package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.service.PostService
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/forum/posts")
class PostController(private val postService: PostService) {

    @PostMapping
    fun createPost(@CookieValue("SESSIONID") sessionId: UUID, @RequestBody post: Post): ResponseEntity<PostDTO> {
        val newPost = postService.createPost(sessionId, post)
        val newPostDTO = ConverterDTO.convertToPostDTO(newPost)
        return ResponseEntity.ok(newPostDTO)
    }

    @GetMapping("/{id}")
    fun getPost(@PathVariable id: Long): ResponseEntity<PostDTO> {
        val post = postService.getPost(id)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    @PutMapping("/{id}")
    fun updatePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody updatedPost: Post): ResponseEntity<PostDTO> {
        val post = postService.updatePost(sessionId, id, updatedPost)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    @DeleteMapping("/{id}")
    fun deletePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<Void> {
        postService.deletePost(sessionId, id)
        return ResponseEntity.noContent().build<Void>()
    }

    @GetMapping
    fun getAllPosts(): ResponseEntity<List<Post>> {
        val posts = postService.getAllPosts()
        return ResponseEntity.ok(posts)
    }

    // implement upvote endpoint
    @PutMapping("/{id}/upvote")
    fun upvotePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<PostDTO> {
        val post = postService.upvotePost(sessionId, id)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    // implement downvote endpoint
    @PutMapping("/{id}/downvote")
    fun downvotePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<PostDTO> {
        val post = postService.downvotePost(sessionId, id)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    // implement get upvoted users endpoint
    @GetMapping("/{id}/upvoteUsers")
    fun getUpvotedUsers(@PathVariable id: Long): ResponseEntity<List<String>> {
        val upvotedUsers = postService.getUpvotedUsers(id)
        return ResponseEntity.ok(upvotedUsers)
    }

    // implement get downvoted users endpoint
    @GetMapping("/{id}/downvoteUsers")
    fun getDownvotedUsers(@PathVariable id: Long): ResponseEntity<List<String>> {
        val downvotedUsers = postService.getDownvotedUsers(id)
        return ResponseEntity.ok(downvotedUsers)
    }

}
