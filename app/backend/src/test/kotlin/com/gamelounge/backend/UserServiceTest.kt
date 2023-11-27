package com.gamelounge.backend

import com.gamelounge.backend.entity.Tag
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.UsernameNotFoundException
import com.gamelounge.backend.model.request.UpdateUserRequest
import com.gamelounge.backend.repository.GameRepository
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.repository.SessionRepository
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.service.S3Service
import com.gamelounge.backend.service.TagService
import com.gamelounge.backend.service.UserService
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows
import org.mockito.Mockito.mock
import org.mockito.kotlin.any
import org.mockito.kotlin.check
import org.mockito.kotlin.verify
import org.mockito.kotlin.whenever
import org.springframework.web.multipart.MultipartFile

class UserServiceTest {
    private val sessionRepository: SessionRepository = mock()
    private val userRepository: UserRepository = mock()
    private val postRepository: PostRepository = mock()
    private val gameRepository: GameRepository = mock()
    private val s3Service: S3Service = mock()
    private val tagService: TagService = mock()
    private val userService = UserService(
        sessionRepository,
        userRepository,
        postRepository,
        gameRepository,
        s3Service,
        tagService
    )
    @Test
    fun `updateUser should update all fields when provided`() {
        val userId = 123L
        val image: MultipartFile = mock()
        val user = User(userId = userId)
        val request = UpdateUserRequest(
            email = "new.email@example.com",
            about = "new about",
            tags = listOf("tag1", "tag2"),
            title = "new title",
            company = "new company"
        )
        val newImageUrl = "imageurl"
        val newTags = listOf(Tag(name = "tag1"), Tag(name = "tag2"))

        whenever(userRepository.findByUserId(userId)).thenReturn(user)
        whenever(s3Service.uploadProfilePictureAndReturnURL(image, userId)).thenReturn(newImageUrl)
        whenever(tagService.createAndReturnTagsFromTagNames(request.tags)).thenReturn(newTags)
        whenever(userRepository.save(any<User>())).thenAnswer { invocation -> invocation.arguments[0] as User }

        userService.updateUser(request, image, userId)

        verify(userRepository).save(check {
            assertEquals(request.email, it.email)
            assertEquals(request.about, it.about)
            assertEquals(newImageUrl, it.profilePicture)
            assertEquals(newTags, it.tags)
            assertEquals(request.title, it.title)
            assertEquals(request.company, it.company)
        })
    }

    @Test
    fun `updateUser should throw UsernameNotFoundException if user does not exist`() {
        val userId = 123L
        val image: MultipartFile? = null
        val request = UpdateUserRequest(
            email = "new.email@example.com",
            about = "new about",
            tags = listOf("tag1", "tag2"),
            title = "new title",
            company = "new company"
        )

        whenever(userRepository.findByUserId(userId)).thenReturn(null)

        assertThrows<UsernameNotFoundException> {
            userService.updateUser(request, image, userId)
        }
    }





}