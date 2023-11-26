package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Comment
import com.gamelounge.backend.model.DTO.CommentDTO
import com.gamelounge.backend.model.DTO.UserDTO
import com.gamelounge.backend.model.request.CreateCommentRequest
import com.gamelounge.backend.model.request.ReportRequest
import com.gamelounge.backend.model.request.UpdateCommentRequest
import com.gamelounge.backend.model.response.ResponseMessage
import com.gamelounge.backend.service.CommentService
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/comments")
class CommentController(private val commentService: CommentService) {

    @PostMapping("/post/{postId}")
    fun createComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable postId: Long, @RequestBody comment: CreateCommentRequest): ResponseEntity<CommentDTO> {
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
    fun updateComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody updatedComment: UpdateCommentRequest): ResponseEntity<CommentDTO> {
        val comment = commentService.updateComment(sessionId, id, updatedComment)
        val commentDTO = ConverterDTO.convertToCommentDTO(comment)
        return ResponseEntity.ok(commentDTO)
    }

    @DeleteMapping("/{id}")
    fun deleteComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<ResponseMessage> {
        commentService.deleteComment(sessionId, id)
        return ResponseEntity.ok(ResponseMessage(message = "Comment deleted successfully"))
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
    // report comment
    @PostMapping("/{id}/report")
    fun reportComment(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody reqBody: ReportRequest): ResponseEntity<ResponseMessage> {
        commentService.reportComment(sessionId, id, reqBody)
        return ResponseEntity.ok(ResponseMessage(message = "Comment reported successfully"))
    }

    // get all replies to a comment
    @GetMapping("/{id}/replies")
    fun getAllReplies(@PathVariable id: Long): ResponseEntity<List<CommentDTO>> {
        val replies = commentService.getAllReplies(id)
        val repliesDTO = ConverterDTO.convertBulkToCommentDTO(replies)
        return ResponseEntity.ok(repliesDTO)
    }


}
