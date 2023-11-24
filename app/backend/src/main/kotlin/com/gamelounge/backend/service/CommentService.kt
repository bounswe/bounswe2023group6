package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Comment
import com.gamelounge.backend.repository.CommentRepository
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.exception.CommentNotFoundException
import com.gamelounge.backend.exception.PostNotFoundException
import com.gamelounge.backend.exception.UnauthorizedCommentAccessException
import com.gamelounge.backend.exception.UserNotFoundException
import com.gamelounge.backend.model.DTO.UserDTO
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.ConverterDTO
import jakarta.transaction.Transactional
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class CommentService(
    private val commentRepository: CommentRepository,
    private val sessionAuth: SessionAuth,
    private val postRepository: PostRepository,
    private val userRepository: UserRepository
) {
    fun createComment(sessionId: UUID, postId: Long, comment: Comment): Comment {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }
        val post = postRepository.findById(postId).orElseThrow { PostNotFoundException("Post not found") }
        comment.user = user
        comment.post = post
        return commentRepository.save(comment)
    }

    fun getComment(commentId: Long): Comment {
        return commentRepository.findById(commentId).orElseThrow { CommentNotFoundException("Comment not found with ID: $commentId") }
    }

    fun updateComment(sessionId: UUID, commentId: Long, updatedComment: Comment): Comment {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val comment = getComment(commentId)

        if (comment.user?.userId != userId) {
            throw UnauthorizedCommentAccessException("Unauthorized to update comment with ID: $commentId")
        }

        comment.content = updatedComment.content
        // TODO: Update other fields

        return commentRepository.save(comment)
    }

    fun deleteComment(sessionId: UUID, commentId: Long) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val comment = getComment(commentId)

        if (comment.user?.userId != userId) {
            throw UnauthorizedCommentAccessException("Unauthorized to delete comment with ID: $commentId")
        }

        commentRepository.delete(comment)
    }

    fun getAllCommentsForPost(postId: Long): List<Comment> {
        return commentRepository.findAll().filter { it.post?.postId == postId }
    }
    @Transactional
    fun upvoteComment(sessionId: UUID, commentId: Long): Comment {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }
        val comment = getComment(commentId)

        if (!comment.likedUsers.contains(user)) {
            comment.likedUsers.add(user)
            user.likedComments.add(comment)
            comment.upvotes += 1
        }
        else {
            comment.likedUsers.remove(user)
            user.likedComments.remove(comment)
            comment.upvotes -= 1
        }
        userRepository.save(user)
        return commentRepository.save(comment)
    }

    @Transactional
    fun downvoteComment(sessionId: UUID, commentId: Long): Comment {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }
        val comment = getComment(commentId)

        if (!comment.dislikedUsers.contains(user)) {
            comment.dislikedUsers.add(user)
            user.dislikedComments.add(comment)
            comment.downvotes += 1
        }
        else {
            comment.dislikedUsers.remove(user)
            user.dislikedComments.remove(comment)
            comment.downvotes -= 1
        }
        userRepository.save(user)
        return commentRepository.save(comment)
    }

    fun getUpvotedUsers(commentId: Long): List<UserDTO> {
        val comment = getComment(commentId)
        val commentsDTO = ConverterDTO.convertBulkToUserDTO(comment.likedUsers)
        return commentsDTO
    }
    fun getDownvotedUsers(commentId: Long): List<UserDTO> {
        val comment = getComment(commentId)
        val commentsDTO = ConverterDTO.convertBulkToUserDTO(comment.dislikedUsers)
        return commentsDTO
    }

}
