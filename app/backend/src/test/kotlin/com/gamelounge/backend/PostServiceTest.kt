package com.gamelounge.backend.service

import com.fasterxml.jackson.databind.ObjectMapper
import com.gamelounge.backend.config.CustomProperties
import com.gamelounge.backend.entity.*
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.request.CreatePostRequest
import com.gamelounge.backend.model.request.RegisterationRequest
import com.gamelounge.backend.model.request.UpdatePostRequest
import com.gamelounge.backend.repository.*
import com.gamelounge.backend.util.ConverterDTO
import com.gamelounge.backend.util.HashingUtil.generateHash
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows
import org.mockito.kotlin.*
import org.springframework.web.multipart.MultipartFile
import java.util.*
import kotlin.reflect.KClass


class PostServiceTest {

    private val postRepository: PostRepository = mock()
    private val sessionAuth: SessionAuth = mock()
    private val userRepository: UserRepository = mock()
    private val reportRepository: ReportRepository = mock()
    private val objectMapper: ObjectMapper = mock()
    private val tagService: TagService = mock()
    private val converterDto : ConverterDTO = mock()

    private val postService = PostService(
        postRepository,
        sessionAuth,
        userRepository,
        reportRepository,
        objectMapper,
        tagService
    )

    @Test
    fun `createPost should create and return a new post`() {
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val postRequest = CreatePostRequest(
            title = "New Post",
            content = "Post content",
            category = PostCategory.DISCUSSION,
            tags = listOf("tag1", "tag2")
        )

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

        val postTags = listOf(Tag(name = "tag1"), Tag(name = "tag2"))

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(userRepository.findById(userId)).thenReturn(Optional.of(user))
        whenever(tagService.createAndReturnTagsFromTagNames(postRequest.tags)).thenReturn(postTags)
        whenever(postRepository.save(any<Post>())).thenAnswer { invocation -> invocation.arguments[0] as Post }

        val result = postService.createPost(sessionId, postRequest)

        assertEquals(postRequest.title, result.title)
        assertEquals(postRequest.content, result.content)
        assertEquals(postRequest.category, result.category)
        assertEquals(user, result.user)
        assertTrue(result.postTags.containsAll(postTags))
    }
    @Test
    fun `updatePost should update and return post when user is authorized`() {
        val sessionId = UUID.randomUUID()
        val postId = 1L
        val userId = 123L
        val updatedPostRequest = UpdatePostRequest(
            title = "Updated Title",
            content = "Updated Content",
            category = PostCategory.REVIEW,
            tags = listOf("UpdatedTag1", "UpdatedTag2")
        )

        val user = User(userId = userId)
        val post = Post(
            postId = postId,
            title = "Original Title",
            content = "Original Content",
            category = PostCategory.DISCUSSION,
            user = user,

        )

        val updatedTags = listOf(Tag(name = "UpdatedTag1"), Tag(name = "UpdatedTag2"))

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))
        whenever(tagService.createAndReturnTagsFromTagNames(updatedPostRequest.tags)).thenReturn(updatedTags)
        whenever(postRepository.save(any<Post>())).thenAnswer { invocation -> invocation.arguments[0] as Post }

        val result = postService.updatePost(sessionId, postId, updatedPostRequest)

        assertEquals(updatedPostRequest.title, result.title)
        assertEquals(updatedPostRequest.content, result.content)
        assertEquals(updatedPostRequest.category, result.category)
        assertTrue(result.postTags.containsAll(updatedTags))
    }

    @Test
    fun `updatePost should throw UnauthorizedPostAccessException when user is not authorized`() {
        val sessionId = UUID.randomUUID()
        val postId = 1L
        val unauthorizedUserId = 999L
        val updatedPostRequest = UpdatePostRequest("Updated Title", "Updated Content", PostCategory.REVIEW, listOf("UpdatedTag1"))

        val user = User(userId = 123L)
        val post = Post(postId = postId, user = user)

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(unauthorizedUserId)
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))

        assertThrows<UnauthorizedPostAccessException> {
            postService.updatePost(sessionId, postId, updatedPostRequest)
        }
    }

    @Test
    fun `deletePost should successfully delete post when user is authorized`() {
        val sessionId = UUID.randomUUID()
        val postId = 1L
        val userId = 123L

        val user = User(userId = userId)
        val post = Post(postId = postId, user = user)
        val postDTO = PostDTO(postId = postId)

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))
        whenever(converterDto.convertToPostDTO(post)).thenReturn(postDTO)
        whenever(reportRepository.save(any<Report>())).thenAnswer { invocation -> invocation.arguments[0] as Report }

        postService.deletePost(sessionId, postId)

        verify(postRepository).delete(post)
    }
    @Test
    fun `deletePost should throw UnauthorizedPostAccessException when user is not authorized`() {
        val sessionId = UUID.randomUUID()
        val postId = 1L
        val unauthorizedUserId = 999L

        val user = User(userId = 123L)
        val post = Post(postId = postId, user = user)

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(unauthorizedUserId)
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))

        assertThrows<UnauthorizedPostAccessException> {
            postService.deletePost(sessionId, postId)
        }
    }
    @Test
    fun `upvotePost should add upvote if user hasn't liked or disliked the post`() {
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val postId = 1L

        val user = User(userId = userId)
        val post = Post(postId = postId, likedUsers = mutableListOf(), dislikedUsers = mutableListOf(), upvotes = 0)

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(userRepository.findById(userId)).thenReturn(Optional.of(user))
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))
        whenever(postRepository.save(any<Post>())).thenAnswer { invocation -> invocation.arguments[0] as Post }

        val result = postService.upvotePost(sessionId, postId)

        assertTrue(result.likedUsers.contains(user))
        assertEquals(1, result.upvotes)
    }
    @Test
    fun `upvotePost should remove upvote if user already liked the post`() {
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val postId = 1L

        val user = User(userId = userId)
        val post = Post(postId = postId, likedUsers = mutableListOf(user), dislikedUsers = mutableListOf(), upvotes = 1)

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(userRepository.findById(userId)).thenReturn(Optional.of(user))
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))
        whenever(postRepository.save(any<Post>())).thenAnswer { invocation -> invocation.arguments[0] as Post }

        val result = postService.upvotePost(sessionId, postId)

        assertFalse(result.likedUsers.contains(user))
        assertEquals(0, result.upvotes)
    }
    @Test
    fun `upvotePost should switch vote from downvote to upvote if user disliked the post`() {
        val sessionId = UUID.randomUUID()
        val userId = 123L
        val postId = 1L

        val user = User(userId = userId)
        val post = Post(postId = postId, likedUsers = mutableListOf(), dislikedUsers = mutableListOf(user), upvotes = 0, downvotes = 1)

        whenever(sessionAuth.getUserIdFromSession(sessionId)).thenReturn(userId)
        whenever(userRepository.findById(userId)).thenReturn(Optional.of(user))
        whenever(postRepository.findById(postId)).thenReturn(Optional.of(post))
        whenever(postRepository.save(any<Post>())).thenAnswer { invocation -> invocation.arguments[0] as Post }

        val result = postService.upvotePost(sessionId, postId)

        assertFalse(result.dislikedUsers.contains(user))
        assertTrue(result.likedUsers.contains(user))
        assertEquals(1, result.upvotes)
        assertEquals(0, result.downvotes)
    }















}