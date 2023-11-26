package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Tag
import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.repository.CrudRepository
import org.springframework.stereotype.Repository

@Repository
interface TagRepository: JpaRepository<Tag, Long> {

    fun findTagByName(name: String): Tag?

    fun existsByName(name: String): Boolean
}