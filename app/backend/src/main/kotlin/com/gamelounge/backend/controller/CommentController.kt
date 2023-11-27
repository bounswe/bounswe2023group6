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
    val sampleUUID: UUID = UUID.fromString("1997004a-6715-45c2-a559-087be232b823")

    @PostMapping("/post/{postId}")

    fun createComment(@PathVariable postId: Long, @RequestBody comment: CreateCommentRequest): ResponseEntity<CommentDTO> {
        val newComment = commentService.createComment(sampleUUID, postId, comment)
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

    fun updateComment(@PathVariable id: Long, @RequestBody updatedComment: UpdateCommentRequest): ResponseEntity<CommentDTO> {
        val comment = commentService.updateComment(sampleUUID, id, updatedComment)
        val commentDTO = ConverterDTO.convertToCommentDTO(comment)
        return ResponseEntity.ok(commentDTO)
    }

    @DeleteMapping("/{id}")

    fun deleteComment(@PathVariable id: Long): ResponseEntity<ResponseMessage> {
        commentService.deleteComment(sampleUUID, id)
        return ResponseEntity.ok(ResponseMessage(message = "Comment deleted successfully"))
    }

    @GetMapping("/post/{postId}")

    fun getAllCommentsForPost(@PathVariable postId: Long): ResponseEntity<List<CommentDTO>> {
        val comments = commentService.getAllCommentsForPost(postId)
        val commentsDTO = ConverterDTO.convertBulkToCommentDTO(comments)
        return ResponseEntity.ok(commentsDTO)
    }

    @PutMapping("/{id}/upvote")

    fun upvoteComment(@PathVariable id: Long): ResponseEntity<CommentDTO> {
        val comment = commentService.upvoteComment(sampleUUID, id)
        val commentDTO = ConverterDTO.convertToCommentDTO(comment)
        return ResponseEntity.ok(commentDTO)
    }

    @PutMapping("/{id}/downvote")

    fun downvoteComment(@PathVariable id: Long): ResponseEntity<CommentDTO> {
        val comment = commentService.downvoteComment(sampleUUID, id)
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

    @PostMapping("/{id}/report")

    fun reportComment(@PathVariable id: Long, @RequestBody reqBody: ReportRequest): ResponseEntity<ResponseMessage> {
        commentService.reportComment(sampleUUID, id, reqBody)
        return ResponseEntity.ok(ResponseMessage(message = "Comment reported successfully"))
    }

    @GetMapping("/{id}/replies")

    fun getAllReplies(@PathVariable id: Long): ResponseEntity<List<CommentDTO>> {
        val replies = commentService.getAllReplies(id)
        val repliesDTO = ConverterDTO.convertBulkToCommentDTO(replies)
        return ResponseEntity.ok(repliesDTO)
    }
}