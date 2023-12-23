package com.gamelounge.backend.service

import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.CommentDTO
import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.DTO.UserDTO
import com.gamelounge.backend.model.request.UpdateUserRequest
import com.gamelounge.backend.model.response.GetUserInfoResponse
import com.gamelounge.backend.repository.GameRepository
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.repository.SessionRepository
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.ConverterDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToCommentDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToGameDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToPostDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToUserDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToTagDTO
import com.gamelounge.backend.util.ConverterDTO.convertToUserDTO
import jakarta.servlet.http.Cookie
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.util.*

@Service
class UserService(
        private val sessionRepository: SessionRepository,
        private val userRepository: UserRepository,
        private val postRepository: PostRepository,
        private val gameRepository: GameRepository,
        private val sessionAuth: SessionAuth,
        private val s3Service: S3Service,
        private val tagService: TagService,
        private val accessService: AccessService
) {

    fun getUserBySessionId(sessionId: UUID): UserDTO {
        val user = sessionRepository.findById(sessionId).map {
            it.user
        }.orElseThrow { SessionNotFoundException("Session not found.") }

        return convertToUserDTO(user)
    }

    fun getUserInfoByUsername(username: String): GetUserInfoResponse {
        val user = userRepository.findByUsername(username) ?: throw UsernameNotFoundException("User does not exist.")

        return fromUserToGetUserInfoResponse(user)
    }

    fun updateUser(request: UpdateUserRequest, image: MultipartFile?, userId: Long) {
        val user = userRepository.findByUserId(userId) ?: throw UsernameNotFoundException("User does not exist.")

        user.email = request.email ?: user.email
        user.about = request.about ?: user.about
        user.profilePicture = image?.let { s3Service.uploadProfilePictureAndReturnURL(it, user.userId) } ?: user.profilePicture
        user.tags = tagService.createAndReturnTagsFromTagNames(request.tags) ?: user.tags
        user.title = request.title ?: user.title
        user.company = request.company ?: user.company
        user.isVisible = request.isVisible ?: user.isVisible

        userRepository.save(user)
    }

    fun getCreatedPosts(userId: Long): List<PostDTO> {
        val user = userRepository.findByUserId(userId) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToPostDTO(postRepository.findByUser(user))
    }

    fun getCreatedGames(userId: Long): List<GameDTO> {
        val user = userRepository.findByUserId(userId) ?: throw UsernameNotFoundException("User does not exist.")
        return convertBulkToGameDTO(gameRepository.findByUser(user))
    }

    fun getLikedPosts(userId: Long): List<PostDTO> {
        val user = userRepository.findByUserId(userId) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToPostDTO(user.likedPosts)
    }

    fun getLikedComments(userId: Long): List<CommentDTO> {
        val user = userRepository.findByUserId(userId) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToCommentDTO(user.likedComments)
    }

    fun getCreatedPosts(username: String): List<PostDTO>{
        val user = userRepository.findByUsername(username) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToPostDTO(postRepository.findByUser(user))
    }

    fun getCreatedGames(username: String): List<GameDTO>{
        val user = userRepository.findByUsername(username) ?: throw UsernameNotFoundException("User does not exist.")
        return convertBulkToGameDTO(gameRepository.findByUser(user))
    }

    fun getLikedPosts(username: String): List<PostDTO>{
        val user = userRepository.findByUsername(username) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToPostDTO(user.likedPosts)
    }

    fun getLikedComments(username: String): List<CommentDTO>{
        val user = userRepository.findByUsername(username) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToCommentDTO(user.likedComments)
    }

    fun fromUserToGetUserInfoResponse(user: User): GetUserInfoResponse {
        return GetUserInfoResponse(
            user.userId,
            user.username,
            user.email,
            user.profilePicture,
            user.about,
            user.isAdmin,
            convertBulkToTagDTO(user.tags),
            user.title,
            user.company,
            user.isVisible,
            user.followerCount,
            user.following.size
        )
    }

    fun followUser(sessionId: UUID, userIdToBeFollowed: Long) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val userToBeFollowed = userRepository.findById(userIdToBeFollowed).orElseThrow { UsernameNotFoundException("User to be followed not found") }
        // Check if the user is trying to follow themselves
        if (userId == userIdToBeFollowed) {
            throw DuplicatedUserFollowing("User cannot follow themselves.")
        }
        // Check if user is not already following the userToBeFollowed
        if (!userToBeFollowed.isDeleted) {
            if (!user.following.contains(userToBeFollowed)) {
                user.following = user.following.toMutableList().apply {
                    add(userToBeFollowed)
                }
                userToBeFollowed.followerCount += 1;
                userRepository.save(user)
                userRepository.save(userToBeFollowed)
            } else {
                throw DuplicatedUserFollowing("User is already following.")
            }
        }else{
            throw DuplicatedUserFollowing("User to be followed not found")
        }
    }

    fun unfollowUser(sessionId: UUID, userIdToBeFollowed: Long) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val userToBeFollowed = userRepository.findById(userIdToBeFollowed).orElseThrow { UsernameNotFoundException("User to be unfollowed not found") }

        if (user.following.contains(userToBeFollowed)) {
            user.following = user.following.toMutableList().apply {
                remove(userToBeFollowed)
            }
            userToBeFollowed.followerCount -= 1;
            userRepository.save(user)
            userRepository.save(userToBeFollowed)
        } else {
            throw DuplicatedUserFollowing("No user is already following.")
        }
    }

    fun getFollowings(sessionId: UUID): List<User> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        var filteredFollowing = user.following.filter { !it.isDeleted }
        return filteredFollowing
    }

    fun getVisibleUsers(): List<User> {
        val users = userRepository.findByVisible(true)
        //filter not deleted users
        var filteredUser = users.filter { !it.isDeleted }

        return filteredUser
    }

    fun deleteUser(sessionId: UUID) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }

        user.isDeleted = true
        userRepository.save(user)
        sessionId.let { accessService.logout(it) }
    }
}