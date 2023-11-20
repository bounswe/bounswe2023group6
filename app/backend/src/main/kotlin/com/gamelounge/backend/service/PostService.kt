package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.exception.PostNotFoundException
import com.gamelounge.backend.exception.UnauthorizedPostAccessException
import com.gamelounge.backend.exception.UsernameNotFoundException
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.repository.UserRepository
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class PostService(
    private val postRepository: PostRepository,
    private val sessionAuth: SessionAuth,
    private val userRepository: UserRepository
) {
    fun createPost(sessionId: UUID, post: Post): Post {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        post.user = user
        return postRepository.save(post)
    }

    fun getPost(postId: Long): Post {
        return postRepository.findById(postId).orElseThrow { PostNotFoundException("Post not found with ID: $postId") }
    }

    fun updatePost(sessionId: UUID, postId: Long, updatedPost: Post): Post {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val post = getPost(postId)

        if (post.user?.userId != userId) {
            throw UnauthorizedPostAccessException("Unauthorized to update post with ID: $postId")
        }

        post.title = updatedPost.title
        post.content = updatedPost.content
        post.category = updatedPost.category
        // TODO

        return postRepository.save(post)
    }

    fun deletePost(sessionId: UUID, postId: Long) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val post = getPost(postId)

        if (post.user?.userId != userId) {
            throw UnauthorizedPostAccessException("Unauthorized to delete post with ID: $postId")
        }

        postRepository.delete(post)
    }

    fun getAllPosts(): List<Post> {
        return postRepository.findAll()
    }
}
