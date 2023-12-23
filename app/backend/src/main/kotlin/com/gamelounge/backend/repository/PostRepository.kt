package com.gamelounge.backend.repository
import com.gamelounge.backend.entity.Game
import org.springframework.stereotype.Repository
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.entity.PostCategory
import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.JpaRepository
@Repository
interface PostRepository : JpaRepository<Post, Long>{

    fun findByUser(user: User): List<Post>

    fun findByRelatedGame(game: Game): List<Post>
  
    fun findByCategory(category: PostCategory): List<Post>

    fun findAllByCategory(category: PostCategory): List<Post>
    fun findByTitleContainingOrContentContaining(title: String, content: String): List<Post>
}