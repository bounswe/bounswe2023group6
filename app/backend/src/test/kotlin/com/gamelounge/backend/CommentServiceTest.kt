package com.gamelounge.backend

import com.fasterxml.jackson.databind.ObjectMapper
import com.gamelounge.backend.entity.*
import com.gamelounge.backend.exception.UnauthorizedCommentAccessException
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.request.CreateCommentRequest
import com.gamelounge.backend.model.request.UpdateCommentRequest
import com.gamelounge.backend.repository.CommentRepository
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.repository.ReportRepository
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.service.CommentService
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertThrows
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows
import org.mockito.kotlin.*
import java.time.Instant
import java.util.*

class CommentServiceTest {
    private val commentRepository: CommentRepository = mock()
    private val sessionAuth: SessionAuth = mock()
    private val postRepository: PostRepository = mock()
    private val userRepository: UserRepository = mock()
    private val reportRepository: ReportRepository = mock()
    private val objectMapper: ObjectMapper = mock()
    private val commentService = CommentService(
        commentRepository,
        sessionAuth,
        postRepository,
        userRepository,
        reportRepository,
        objectMapper
    )

    @Test
    fun `createComment should successfully create a comment`() {
        val sessionId = UUID.randomUUID()
        val postId = 1L
        val userId = 123L
        val createCommentRequest = CreateCommentRequest("Test content", replyToCommentId = null)

        val user = User(
            userId = userId,
            username = "testUser",
            email = "test@example.com",
            profilePicture = "profilePicUrl",
            about = "about",
            title = "title",
            company = "company",
            passwordHash = "hashedPassword".toByteArray(),
            salt = "salt".toByteArray()
        )

        val post = Post(
            postId = postId,
            title = "Test Post",
            content = "Post Content",
            creationDate = Instant.now(),
            upvotes = 0,
            downvotes = 0,
            totalComments = 0,
            category = PostCategory.DISCUSSION,
            user = user,
            relatedGame = null
        )
        val mockComment = Comment(
            commentId = 1L,
            content = createCommentRequest.content,
            replyToComment = null,
            user = user,
            post = post
        )

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(userRepository.findById(userId)).thenReturn(Optional.of(user))
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))
        whenever(commentRepository.save(any<Comment>())).thenReturn(mockComment)

        val result = commentService.createComment(sessionId, postId, createCommentRequest)

        assertEquals(createCommentRequest.content, result.content)
        assertEquals(user, result.user)
        assertEquals(post, result.post)
    }

    @Test
    fun `updateComment should update and return comment when user is authorized`() {
        val sessionId = UUID.randomUUID()
        val commentId = 1L
        val userId = 123L
        val updatedContent = "Updated content"
        val updatedCommentRequest = UpdateCommentRequest(updatedContent)

        val user = User(userId = userId)
        val comment = Comment(commentId = commentId, user = user, content = "Original content")

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(commentRepository.findById(commentId)).thenReturn(Optional.of(comment))
        whenever(commentRepository.save(any<Comment>())).thenAnswer { invocation -> invocation.arguments[0] as Comment }

        val result = commentService.updateComment(sessionId, commentId, updatedCommentRequest)

        assertEquals(updatedContent, result.content)
    }

    @Test
    fun `updateComment should throw UnauthorizedCommentAccessException when user is not authorized`() {
        val sessionId = UUID.randomUUID()
        val commentId = 1L
        val userId = 123L
        val unauthorizedUserId = 999L
        val updatedCommentRequest = UpdateCommentRequest("Updated content")

        val user = User(userId = userId)
        val comment = Comment(commentId = commentId, user = user, content = "Original content")

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(unauthorizedUserId)
        whenever(commentRepository.findById(commentId)).thenReturn(Optional.of(comment))

        assertThrows<UnauthorizedCommentAccessException> {
            commentService.updateComment(sessionId, commentId, updatedCommentRequest)
        }
    }
    @Test
    fun `deleteComment should successfully delete comment when user is authorized`() {
        val sessionId = UUID.randomUUID()
        val commentId = 1L
        val userId = 123L
        val postId = 2L

        val user = User(
            userId = userId,
            username = "testUser",
            email = "test@example.com",
            profilePicture = "profilePicUrl",
            about = "about",
            title = "title",
            company = "company",
            passwordHash = "hashedPassword".toByteArray(),
            salt = "salt".toByteArray(),
        )

        val post = Post(
            postId = postId,
            title = "Test Post",
            content = "Post Content",
            creationDate = Instant.now(),
            upvotes = 0,
            downvotes = 0,
            totalComments = 1,
            category = PostCategory.DISCUSSION,
            user = user
        )

        val comment = Comment(commentId = commentId, user = user, post = post, content = "Test content")

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(commentRepository.findById(commentId)).thenReturn(Optional.of(comment))
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))
        whenever(reportRepository.save(any<Report>())).thenAnswer { invocation -> invocation.arguments[0] as Report }


        commentService.deleteComment(sessionId, commentId)

        verify(commentRepository).delete(comment)
        verify(postRepository).save(post)
        assertEquals(post.totalComments, 0)
    }

    @Test
    fun `deleteComment should throw UnauthorizedCommentAccessException when user is not authorized`() {
        val sessionId = UUID.randomUUID()
        val commentId = 1L
        val userId = 123L
        val unauthorizedUserId = 999L

        val user = User(userId = userId)
        val comment = Comment(commentId = commentId, user = user, content = "Test content")

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(unauthorizedUserId)
        whenever(commentRepository.findById(commentId)).thenReturn(Optional.of(comment))

        assertThrows<UnauthorizedCommentAccessException> {
            commentService.deleteComment(sessionId, commentId)
        }
    }


}