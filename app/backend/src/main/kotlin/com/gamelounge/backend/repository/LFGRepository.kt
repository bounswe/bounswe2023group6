package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.LFG
import com.gamelounge.backend.entity.User
import org.springframework.data.repository.CrudRepository

interface LFGRepository: CrudRepository<LFG, Long> {

    fun findByUser(user: User): List<LFG>

}