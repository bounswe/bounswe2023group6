package com.gamelounge.backend.repository
import org.springframework.stereotype.Repository
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.entity.PostCategory
import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.JpaRepository
@Repository
interface PostRepository : JpaRepository<Post, Long>{

    fun findByUser(user: User): List<Post>

    fun findAllByCategory(category: PostCategory): List<Post>

}