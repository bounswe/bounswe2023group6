package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.User
import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Repository

@Repository
interface UserRepository : CrudRepository<User, Long> {
    fun existsByUsername(username: String): Boolean

    fun findByUsername(username: String): User?

}