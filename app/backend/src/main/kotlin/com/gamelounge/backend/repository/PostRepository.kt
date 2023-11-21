package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.entity.User
import org.springframework.data.repository.CrudRepository

interface PostRepository: CrudRepository<Post, Long> {

    fun findByUser(user: User): List<Post>

}