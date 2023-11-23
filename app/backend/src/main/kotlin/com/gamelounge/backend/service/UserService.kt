package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.entity.Tag
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.SessionNotFoundException
import com.gamelounge.backend.exception.UsernameNotFoundException
import com.gamelounge.backend.model.request.UpdateUserRequest
import com.gamelounge.backend.model.response.GetUserInfoResponse
import com.gamelounge.backend.repository.GameRepository
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.repository.SessionRepository
import com.gamelounge.backend.repository.UserRepository
import org.hibernate.sql.Update
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.util.*

@Service
class UserService(
    val sessionRepository: SessionRepository,
    val userRepository: UserRepository,
    val postRepository: PostRepository,
    val gameRepository: GameRepository
) {

    fun getUserBySessionId(sessionId: UUID): User {
        val user = sessionRepository.findById(sessionId).map {
            it.user
        }.orElseThrow{SessionNotFoundException("Session not found.")}

        return user
    }

    fun getUserInfoByUsername(username: String): GetUserInfoResponse {
        val user = userRepository.findByUsername(username) ?: throw UsernameNotFoundException("User does not exist.")

        return fromUserToGetUserInfoResponse(user)
    }

    fun updateUser(request: UpdateUserRequest, image: MultipartFile?, username: String){
        val user = userRepository.findByUsername(username) ?: throw UsernameNotFoundException("User does not exist.")

        user.email = request.email ?: user.email
        user.about = request.about ?: user.about
        user.tags = fromStringToTag(request.tags) ?: user.tags
        user.title = request.title ?: user.title
        user.company = request.company ?: user.company

        userRepository.save(user)
    }

    fun getCreatedPosts(username: String): List<Post>{
        val user = userRepository.findByUsername(username) ?: throw UsernameNotFoundException("User does not exist.")
        return postRepository.findByUser(user)
    }

    fun getCreatedGames(username: String): List<Game>{
        val user = userRepository.findByUsername(username) ?: throw UsernameNotFoundException("User does not exist.")
        return gameRepository.findByUser(user)
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

    fun fromStringToTag(tags: List<String>?): List<Tag>?{
        TODO()
    }


}

