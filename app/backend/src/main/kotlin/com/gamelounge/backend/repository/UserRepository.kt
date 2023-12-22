package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface UserRepository : CrudRepository<User, Long> {
    fun existsByUsername(username: String): Boolean

    fun findByUsername(username: String): User?

    fun findByUserId(userId: Long): User?

    @Query("SELECT u FROM User u WHERE u.isVisible = :isVisible")
    fun findByVisible(@Param("isVisible") isVisible: Boolean): List<User>

}