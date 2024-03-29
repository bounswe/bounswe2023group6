package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Session
import com.gamelounge.backend.entity.User

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface SessionRepository : JpaRepository<Session, String> {
    fun findById(id: UUID): Optional<Session>
    fun findByUser(user: User): Session?

}