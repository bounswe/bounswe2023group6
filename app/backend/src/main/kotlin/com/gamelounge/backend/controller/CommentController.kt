package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Comment
import com.gamelounge.backend.service.CommentService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/comments")
class CommentController(private val commentService: CommentService) {

    @PostMapping("/post/{postId}")
    fun createComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable postId: Long, @RequestBody comment: Comment): ResponseEntity<Comment> {
        val newComment = commentService.createComment(sessionId, postId, comment)
        return ResponseEntity.ok(newComment)
    }

    @GetMapping("/{id}")
    fun getComment(@PathVariable id: Long): ResponseEntity<Comment> {
        val comment = commentService.getComment(id)
        return ResponseEntity.ok(comment)
    }

    @PutMapping("/{id}")
    fun updateComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody updatedComment: Comment): ResponseEntity<Comment> {
        val comment = commentService.updateComment(sessionId, id, updatedComment)
        return ResponseEntity.ok(comment)
    }

    @DeleteMapping("/{id}")
    fun deleteComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<Void> {
        commentService.deleteComment(sessionId, id)
        return ResponseEntity.noContent().build<Void>()
    }

    @GetMapping("/post/{postId}")
    fun getAllCommentsForPost(@PathVariable postId: Long): ResponseEntity<List<Comment>> {
        val comments = commentService.getAllCommentsForPost(postId)
        return ResponseEntity.ok(comments)
    }
}
