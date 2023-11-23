package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.service.PostService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/forum/posts")
class PostController(private val postService: PostService) {

    @PostMapping
    fun createPost(@CookieValue("SESSIONID") sessionId: UUID, @RequestBody post: Post): ResponseEntity<Post> {
        val newPost = postService.createPost(sessionId, post)
        return ResponseEntity.ok(newPost)
    }

    @GetMapping("/{id}")
    fun getPost(@PathVariable id: Long): ResponseEntity<Post> {
        val post = postService.getPost(id)
        return ResponseEntity.ok(post)
    }

    @PutMapping("/{id}")
    fun updatePost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody updatedPost: Post): ResponseEntity<Post> {
        val post = postService.updatePost(sessionId, id, updatedPost)
        return ResponseEntity.ok(post)
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
}
