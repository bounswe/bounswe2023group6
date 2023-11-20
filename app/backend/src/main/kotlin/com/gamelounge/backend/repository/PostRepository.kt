package com.gamelounge.backend.repository
import org.springframework.stereotype.Repository
import com.gamelounge.backend.entity.Post
import org.springframework.data.jpa.repository.JpaRepository
@Repository
interface PostRepository : JpaRepository<Post, Long>