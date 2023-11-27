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

    val sampleUUID: UUID = UUID.fromString("1997004a-6715-45c2-a559-087be232b823")

    // Access-Control-Allow-Origin: *
    @PostMapping
    @CrossOrigin(origins = ["http://localhost:3000"], allowCredentials = "true", allowedHeaders = ["*"], exposedHeaders = ["Access-Control-Allow-Origin"])
//    fun createPost(@CookieValue("SESSIONID") sessionId: UUID, @RequestBody post: CreatePostRequest): ResponseEntity<PostDTO> {
//        val newPost = postService.createPost(sessionId, post)
//        val newPostDTO = ConverterDTO.convertToPostDTO(newPost)
//        return ResponseEntity.ok(newPostDTO)
//    }
    fun createPost(@RequestBody post: CreatePostRequest): ResponseEntity<PostDTO> {
        val newPost = postService.createPost(sampleUUID, post)
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
    fun updatePost(@PathVariable id: Long, @RequestBody updatedPost: UpdatePostRequest): ResponseEntity<PostDTO> {
        val post = postService.updatePost(sampleUUID, id, updatedPost)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    @DeleteMapping("/{id}")
    @CrossOrigin(origins = ["*"])
    fun deletePost(@PathVariable id: Long): ResponseEntity<ResponseMessage> {
        postService.deletePost(sampleUUID, id)
        return ResponseEntity.ok(ResponseMessage(message = "Post deleted successfully"))
    }

    @GetMapping
    @CrossOrigin(origins = ["*"])
    fun getAllPosts(): ResponseEntity<List<PostDTO>> {
        val posts = postService.getAllPosts()
        val postsDTO = ConverterDTO.convertBulkToPostDTO(posts)
        return ResponseEntity.ok(postsDTO)
    }

    @PutMapping("/{id}/upvote")
    @CrossOrigin(origins = ["*"])
    fun upvotePost(@PathVariable id: Long): ResponseEntity<PostDTO> {
        val post = postService.upvotePost(sampleUUID, id)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    @PutMapping("/{id}/downvote")
    @CrossOrigin(origins = ["*"])
    fun downvotePost(@PathVariable id: Long): ResponseEntity<PostDTO> {
        val post = postService.downvotePost(sampleUUID, id)
        val postDTO = ConverterDTO.convertToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    @GetMapping("/{id}/upvoteUsers")
    @CrossOrigin(origins = ["*"])
    fun getUpvotedUsers(@PathVariable id: Long): ResponseEntity<List<UserDTO>> {
        val upvotedUsersDTO = postService.getUpvotedUsers(id)
        return ResponseEntity.ok(upvotedUsersDTO)
    }

    @GetMapping("/{id}/downvoteUsers")
    @CrossOrigin(origins = ["*"])
    fun getDownvotedUsers(@PathVariable id: Long): ResponseEntity<List<UserDTO>> {
        val downvotedUsersDTO = postService.getDownvotedUsers(id)
        return ResponseEntity.ok(downvotedUsersDTO)
    }

    @PostMapping("/{id}/report")
    @CrossOrigin(origins = ["*"])
    fun reportPost(@PathVariable id: Long, @RequestBody reqBody: ReportRequest): ResponseEntity<ResponseMessage> {
        postService.reportPost(sampleUUID, id, reqBody)
        return ResponseEntity.ok(ResponseMessage(message = "Post reported successfully"))
    }

}
