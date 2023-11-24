package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.exception.PostNotFoundException
import com.gamelounge.backend.exception.UnauthorizedPostAccessException
import com.gamelounge.backend.exception.UsernameNotFoundException
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.UserDTO
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.ConverterDTO
import jakarta.transaction.Transactional
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
    @Transactional
    fun upvotePost(sessionId: UUID, postId: Long): Post {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val post = getPost(postId)

        if (!post.likedUsers.contains(user)){
            post.likedUsers.add(user)
            user.likedPosts.add(post)
            post.upvotes += 1
        }
        else{
            post.likedUsers.remove(user)
            user.likedPosts.remove(post)
            post.upvotes -= 1
        }
        userRepository.save(user)
        return postRepository.save(post)
    }
    @Transactional
    fun downvotePost(sessionId: UUID, postId: Long): Post {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val post = getPost(postId)

        if (!post.dislikedUsers.contains(user)){
            post.dislikedUsers.add(user)
            user.dislikedPosts.add(post)
            post.downvotes += 1
        }
        else{
            post.dislikedUsers.remove(user)
            user.dislikedPosts.remove(post)
            post.downvotes -= 1
        }
        userRepository.save(user)
        return postRepository.save(post)
    }
    fun getUpvotedUsers(postId: Long): List<UserDTO> {
        val post = getPost(postId)
        val usersDTO = ConverterDTO.convertBulkToUserDTO(post.likedUsers)
        return usersDTO
    }
    fun getDownvotedUsers(postId: Long): List<UserDTO> {
        val post = getPost(postId)
        val usersDTO = ConverterDTO.convertBulkToUserDTO(post.dislikedUsers)
        return usersDTO
    }


}
