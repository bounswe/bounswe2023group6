package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Tag
import com.gamelounge.backend.entity.User
import org.springframework.data.repository.CrudRepository

interface TagRepository: CrudRepository<Tag, Long> {

    fun findTagByUsers(users: MutableList<User>)
}