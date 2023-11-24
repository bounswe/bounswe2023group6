package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Comment
import com.gamelounge.backend.model.DTO.CommentDTO
import com.gamelounge.backend.model.DTO.UserDTO
import com.gamelounge.backend.service.CommentService
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/comments")
class CommentController(private val commentService: CommentService) {

    @PostMapping("/post/{postId}")
    fun createComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable postId: Long, @RequestBody comment: Comment): ResponseEntity<CommentDTO> {
        val newComment = commentService.createComment(sessionId, postId, comment)
        val newCommentDTO = ConverterDTO.convertToCommentDTO(newComment)
        return ResponseEntity.ok(newCommentDTO)
    }

    @GetMapping("/{id}")
    fun getComment(@PathVariable id: Long): ResponseEntity<CommentDTO> {
        val comment = commentService.getComment(id)
        val commentDTO = ConverterDTO.convertToCommentDTO(comment)
        return ResponseEntity.ok(commentDTO)
    }

    @PutMapping("/{id}")
    fun updateComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody updatedComment: Comment): ResponseEntity<CommentDTO> {
        val comment = commentService.updateComment(sessionId, id, updatedComment)
        val commentDTO = ConverterDTO.convertToCommentDTO(comment)
        return ResponseEntity.ok(commentDTO)
    }

    @DeleteMapping("/{id}")
    fun deleteComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<Void> {
        commentService.deleteComment(sessionId, id)
        return ResponseEntity.noContent().build<Void>()
    }

    @GetMapping("/post/{postId}")
    fun getAllCommentsForPost(@PathVariable postId: Long): ResponseEntity<List<CommentDTO>> {
        val comments = commentService.getAllCommentsForPost(postId)
        val commentsDTO = ConverterDTO.convertBulkToCommentDTO(comments)
        return ResponseEntity.ok(commentsDTO)
    }

    // implement upvote endpoint
    @PutMapping("/{id}/upvote")
    fun upvoteComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<CommentDTO> {
        val comment = commentService.upvoteComment(sessionId, id)
        val commentDTO = ConverterDTO.convertToCommentDTO(comment)
        return ResponseEntity.ok(commentDTO)
    }
    @PutMapping("/{id}/downvote")
    fun downvoteComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<CommentDTO> {
        val comment = commentService.downvoteComment(sessionId, id)
        val commentDTO = ConverterDTO.convertToCommentDTO(comment)
        return ResponseEntity.ok(commentDTO)
    }

    @GetMapping("/{id}/upvotedUsers")
    fun getUpvotedUsers(@PathVariable id: Long): ResponseEntity<List<UserDTO>> {
        val usersDTO = commentService.getUpvotedUsers(id)
        return ResponseEntity.ok(usersDTO)
    }
    @GetMapping("/{id}/downvotedUsers")
    fun getDownvotedUsers(@PathVariable id: Long): ResponseEntity<List<UserDTO>> {
        val usersDTO = commentService.getDownvotedUsers(id)
        return ResponseEntity.ok(usersDTO)
    }

}
