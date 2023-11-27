package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Tag
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.SessionNotFoundException
import com.gamelounge.backend.exception.UserNotFoundException
import com.gamelounge.backend.exception.UsernameNotFoundException
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
import com.gamelounge.backend.util.ConverterDTO.convertBulkToCommentDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToGameDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToPostDTO
import com.gamelounge.backend.util.ConverterDTO.convertToUserDTO
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.util.*

@Service
class UserService(
    private val sessionRepository: SessionRepository,
    private val userRepository: UserRepository,
    private val postRepository: PostRepository,
    private val gameRepository: GameRepository,
    private val s3Service: S3Service,
    private val tagService: TagService
) {

    fun getUserBySessionId(sessionId: UUID): UserDTO {
        val user = sessionRepository.findById(sessionId).map {
            it.user
        }.orElseThrow{SessionNotFoundException("Session not found.")}

        return convertToUserDTO(user)
    }

    fun getUserInfoByUsername(username: String): GetUserInfoResponse {
        val user = userRepository.findByUsername(username) ?: throw UsernameNotFoundException("User does not exist.")

        return fromUserToGetUserInfoResponse(user)
    }

    fun updateUser(request: UpdateUserRequest, image: MultipartFile?, userId: Long){
        val user = userRepository.findByUserId(userId) ?: throw UsernameNotFoundException("User does not exist.")

        user.email = request.email ?: user.email
        user.about = request.about ?: user.about
        user.profilePicture = image?.let { s3Service.uploadProfilePictureAndReturnURL(it, user.userId) }
        user.tags = tagService.createAndReturnTagsFromTagNames(request.tags) ?: user.tags
        user.title = request.title ?: user.title
        user.company = request.company ?: user.company

        userRepository.save(user)
    }

    fun getCreatedPosts(userId: Long): List<PostDTO>{
        val user = userRepository.findByUserId(userId) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToPostDTO(postRepository.findByUser(user))
    }

    fun getCreatedGames(userId: Long): List<GameDTO>{
        val user = userRepository.findByUserId(userId) ?: throw UsernameNotFoundException("User does not exist.")
        return convertBulkToGameDTO(gameRepository.findByUser(user))
    }

    fun getLikedPosts(userId: Long): List<PostDTO>{
        val user = userRepository.findByUserId(userId) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToPostDTO(user.likedPosts)
    }

    fun getLikedComments(userId: Long): List<CommentDTO>{
        val user = userRepository.findByUserId(userId) ?: throw UserNotFoundException("User does not exist.")
        return convertBulkToCommentDTO(user.likedComments)
    }

    fun fromUserToGetUserInfoResponse(user: User): GetUserInfoResponse {
        return GetUserInfoResponse(
            user.userId,
            user.username,
            user.email,
            user.profilePicture,
            user.about
        )
    }
}