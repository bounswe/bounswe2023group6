package com.gamelounge.backend.service

import com.fasterxml.jackson.databind.ObjectMapper
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.entity.Report
import com.gamelounge.backend.exception.PostNotFoundException
import com.gamelounge.backend.exception.UnauthorizedPostAccessException
import com.gamelounge.backend.exception.UsernameNotFoundException
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.UserDTO
import com.gamelounge.backend.model.request.CreatePostRequest
import com.gamelounge.backend.model.request.ReportRequest
import com.gamelounge.backend.model.request.UpdatePostRequest
import com.gamelounge.backend.repository.ReportRepository
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.ConverterDTO
import jakarta.transaction.Transactional
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class PostService(
    private val postRepository: PostRepository,
    private val sessionAuth: SessionAuth,
    private val userRepository: UserRepository,
    private val reportRepository: ReportRepository,
    private val objectMapper: ObjectMapper,
    private val tagService: TagService
) {
    fun createPost(sessionId: UUID, post: CreatePostRequest): Post {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val newPost = Post(
            title = post.title,
            content = post.content,
            category = post.category,
            user = user,
            postTags = tagService.createAndReturnTagsFromTagNames(post.tags) ?: emptyList()
        )
        return postRepository.save(newPost)
    }

    fun getPost(postId: Long): Post {
        return postRepository.findById(postId).orElseThrow { PostNotFoundException("Post not found with ID: $postId") }
    }

    fun updatePost(sessionId: UUID, postId: Long, updatedPost: UpdatePostRequest): Post {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val post = getPost(postId)

        if (post.user?.userId != userId) {
            throw UnauthorizedPostAccessException("Unauthorized to update post with ID: $postId")
        }

        post.title = updatedPost.title ?: post.title
        post.content = updatedPost.content ?: post.content
        post.category = updatedPost.category ?: post.category
        post.postTags = tagService.createAndReturnTagsFromTagNames(updatedPost.tags) ?: post.postTags
        // TODO

        return postRepository.save(post)
    }

    fun deletePost(sessionId: UUID, postId: Long) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val post = getPost(postId)

        if (post.user?.userId != userId) {
            throw UnauthorizedPostAccessException("Unauthorized to delete post with ID: $postId")
        }
        val postDTO = ConverterDTO.convertToPostDTO(post)
        post.reports.forEach { report ->
            report.reportedObject = objectMapper.writeValueAsString(postDTO)
            report.reportedPost = null
            reportRepository.save(report)
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

        val alreadyLiked = post.likedUsers.contains(user)
        val alreadyDisliked = post.dislikedUsers.contains(user)
        if (alreadyLiked){
            post.likedUsers.remove(user)
            //user.likedPosts.remove(post) no need to add to user it handles itself
            post.upvotes -= 1
        }
        else if (alreadyDisliked){
            post.dislikedUsers.remove(user)
            //user.dislikedPosts.remove(post) no need to add to user it handles itself
            post.downvotes -= 1
            post.likedUsers.add(user)
            //user.likedPosts.add(post) no need to add to user it handles itself
            post.upvotes += 1
        }
        else{
            post.likedUsers.add(user)
            //user.likedPosts.add(post) no need to add to user it handles itself
            post.upvotes += 1
        }
        return postRepository.save(post)
    }
    @Transactional
    fun downvotePost(sessionId: UUID, postId: Long): Post {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val post = getPost(postId)

        val alreadyLiked = post.likedUsers.contains(user)
        val alreadyDisliked = post.dislikedUsers.contains(user)
        if (alreadyDisliked){
            post.dislikedUsers.remove(user)
            //user.dislikedPosts.remove(post) no need to add to user it handles itself
            post.downvotes -= 1
        }
        else if (alreadyLiked){
            post.likedUsers.remove(user)
            //user.likedPosts.remove(post) no need to add to user it handles itself
            post.upvotes -= 1
            post.dislikedUsers.add(user)
            //user.dislikedPosts.add(post) no need to add to user it handles itself
            post.downvotes += 1
        }
        else{
            post.dislikedUsers.add(user)
            //user.dislikedPosts.add(post) no need to add to user it handles itself
            post.downvotes += 1
        }
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

    fun reportPost(sessionId: UUID, postId: Long, reqBody: ReportRequest) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val post = getPost(postId)
        var newReport = Report(reason = reqBody.reason, reportingUser = user, reportedPost = post)
        reportRepository.save(newReport)
    }

}
