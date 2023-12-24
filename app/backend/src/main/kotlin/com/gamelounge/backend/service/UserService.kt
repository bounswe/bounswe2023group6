package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.GameStatus
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.CommentDTO
import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.DTO.UserDTO
import com.gamelounge.backend.model.request.UpdateUserRequest
import com.gamelounge.backend.model.response.GetUserInfoResponse
import com.gamelounge.backend.repository.*
import com.gamelounge.backend.util.ConverterDTO.convertBulkToCommentDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToGameDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToPostDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToUserDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToTagDTO
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
        private val sessionAuth: SessionAuth,
        private val s3Service: S3Service,
        private val tagService: TagService,
        private val accessService: AccessService,
        private val reportRepository: ReportRepository
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
            user.isDeleted,
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

    fun banUserForGame(sessionId: UUID, gameId: Long): User {
        val userIdTakenSession = sessionAuth.getUserIdFromSession(sessionId)
        val sessionUser = userRepository.findById(userIdTakenSession).orElseThrow { UsernameNotFoundException("User not found") }

        val game = gameRepository.findById(gameId).orElseThrow { GameNotFoundException("Game not found with ID: $gameId") }

        if (sessionUser.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to ban user with ID: ${game.user.userId}")
        }

        val reportedGame = reportRepository.findByReportedGame(game)
        val reportedGameFiltered = reportedGame.filter { it.reportingUser?.userId == game.user.userId }

        val reportedUser = userRepository.findById(game.user.userId).orElseThrow { UsernameNotFoundException("User not found") }

        if (!reportedGameFiltered.isNullOrEmpty()) {
            reportedUser.isDeleted = true
            reportedUser.isBanned = true
            reportRepository.delete(reportedGameFiltered[0])
        }

        return userRepository.save(reportedUser)
    }

    fun deleteReportedGame(sessionId: UUID, gameId: Long): Game {
        val userIdTakenSession = sessionAuth.getUserIdFromSession(sessionId)
        val sessionUser = userRepository.findById(userIdTakenSession).orElseThrow { UsernameNotFoundException("User not found") }

        val game = gameRepository.findById(gameId).orElseThrow { GameNotFoundException("Game not found with ID: $gameId") }

        if (sessionUser.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to delete game with ID: ${gameId}")
        }

        val reportedGame = reportRepository.findByReportedGame(game)

        val reportedGameFiltered = reportedGame.filter { it.reportingUser?.userId == game.user.userId }
        if (!reportedGameFiltered.isNullOrEmpty()) {
            reportRepository.delete(reportedGameFiltered[0])
            game.isDeleted = true
            return gameRepository.save(game)
        }
        return throw GameNotFoundException("Reported game not found with ID: $gameId")

    }

    fun cancelReportedGame(sessionId: UUID, gameId: Long) {
        val userIdTakenSession = sessionAuth.getUserIdFromSession(sessionId)
        val sessionUser = userRepository.findById(userIdTakenSession).orElseThrow { UsernameNotFoundException("User not found") }

        val game = gameRepository.findById(gameId).orElseThrow { GameNotFoundException("Game not found with ID: $gameId") }

        if (sessionUser.isAdmin != true) {
            throw UnauthorizedGameAccessException("Unauthorized to cancel game with ID: ${gameId}")
        }

        val reportedGame = reportRepository.findByReportedGame(game)

        val reportedGameFiltered = reportedGame.filter { it.reportingUser?.userId == game.user.userId }
        if (!reportedGameFiltered.isNullOrEmpty()) {
            reportRepository.delete(reportedGameFiltered[0])
        }else{
            throw GameNotFoundException("Reported game not found with ID: $gameId")
        }

    }

    fun deleteReportedPost(sessionId: UUID, postId: Long) {
        val userIdTakenSession = sessionAuth.getUserIdFromSession(sessionId)
        val sessionUser = userRepository.findById(userIdTakenSession).orElseThrow { UsernameNotFoundException("User not found") }

        val post = postRepository.findById(postId).orElseThrow { PostNotFoundException("Post not found with ID: $postId") }

        if (sessionUser.isAdmin != true) {
            throw UnauthorizedPostAccessException("Unauthorized to delete post with ID: ${postId}")
        }

        val reportedPost = reportRepository.findByReportedPost(post)

        val reportedPostFiltered = reportedPost.filter { it.reportingUser?.userId == post.user.userId }
        if (!reportedPostFiltered.isNullOrEmpty()) {
            reportRepository.delete(reportedPostFiltered[0])
            postRepository.delete(post)
        }else{
            throw PostNotFoundException("Reported post not found with ID: $postId")
        }
    }

    fun cancelReportedPost(sessionId: UUID, postId: Long) {
        val userIdTakenSession = sessionAuth.getUserIdFromSession(sessionId)
        val sessionUser = userRepository.findById(userIdTakenSession).orElseThrow { UsernameNotFoundException("User not found") }

        val post = postRepository.findById(postId).orElseThrow { PostNotFoundException("Post not found with ID: $postId") }

        if (sessionUser.isAdmin != true) {
            throw UnauthorizedPostAccessException("Unauthorized to cancel post with ID: ${postId}")
        }

        val reportedPost = reportRepository.findByReportedPost(post)

        val reportedPostFiltered = reportedPost.filter { it.reportingUser?.userId == post.user.userId }
        if (!reportedPostFiltered.isNullOrEmpty()) {
            reportRepository.delete(reportedPostFiltered[0])
        }else{
            throw PostNotFoundException("Reported post not found with ID: $postId")
        }

    }

    fun banUserForPost(sessionId: UUID, postId: Long): User {
        val userIdTakenSession = sessionAuth.getUserIdFromSession(sessionId)
        val sessionUser = userRepository.findById(userIdTakenSession).orElseThrow { UsernameNotFoundException("User not found") }

        val post = postRepository.findById(postId).orElseThrow { PostNotFoundException("Post not found with ID: $postId") }

        if (sessionUser.isAdmin != true) {
            throw UnauthorizedPostAccessException("Unauthorized to ban user with ID: ${post.user.userId}")
        }

        val reportedPost = reportRepository.findByReportedPost(post)
        val reportedPostFiltered = reportedPost.filter { it.reportingUser?.userId == post.user.userId }

        val reportedUser = userRepository.findById(post.user.userId).orElseThrow { UsernameNotFoundException("User not found") }

        if (!reportedPostFiltered.isNullOrEmpty()) {
            reportedUser.isDeleted = true
            reportedUser.isBanned = true
            reportRepository.delete(reportedPostFiltered[0])
        }

        return userRepository.save(reportedUser)
    }
}