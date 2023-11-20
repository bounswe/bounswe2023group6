package com.gamelounge.backend.middleware

import com.gamelounge.backend.repository.SessionRepository
import com.gamelounge.backend.exception.SessionNotFoundException
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class SessionAuth(private val sessionRepository: SessionRepository) {

    fun getUserIdFromSession(sessionId: UUID): Long {
        val session = sessionRepository.findById(sessionId).orElseThrow {
            SessionNotFoundException("Session not found for ID: $sessionId")
        }
        return session.user.userId
    }
}
