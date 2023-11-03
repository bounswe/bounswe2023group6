package com.gamelounge.backend.service

import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.SessionNotFoundException
import com.gamelounge.backend.exception.UsernameNotFoundException
import com.gamelounge.backend.repository.SessionRepository
import com.gamelounge.backend.repository.UserRepository
import org.springframework.stereotype.Service
import java.util.*

@Service
class UserService(
    val sessionRepository: SessionRepository,
    val userRepository: UserRepository
) {

    fun getUserBySessionId(sessionId: UUID): User {
        val user = sessionRepository.findById(sessionId).map {
            it.user
        }.orElseThrow{SessionNotFoundException("Session not found.")}

        return user
    }

    fun getUserByUsername(username: String): User{
        val user = userRepository.findByUsername(username)

        if (user == null)
            throw UsernameNotFoundException("User does not exist.")

        return user

    }
}

