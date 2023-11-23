package com.gamelounge.backend.util

import com.gamelounge.backend.entity.Comment
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.model.DTO.CommentDTO
import com.gamelounge.backend.model.DTO.PostDTO

object ConverterDTO {
    fun convertToPostDTO(Post: Post) : PostDTO {
        return PostDTO(
            postId = Post.postId,
            title = Post.title,
            content = Post.content,
            creationDate = Post.creationDate,
            upvotes = Post.upvotes,
            downvotes = Post.downvotes,
            totalComments = Post.totalComments,
            category = Post.category
        )
    }
    fun convertBulkToPostDTO(Posts: List<Post>) : List<PostDTO> {
        return Posts.map { convertToPostDTO(it) }
    }
    fun convertToCommentDTO(comment: Comment) : CommentDTO {
        return CommentDTO(
            commentId = comment.commentId,
            content = comment.content,
            creationDate = comment.creationDate,
            upvotes = comment.upvotes,
            downvotes = comment.downvotes,
        )
    }
    fun convertBulkToCommentDTO(comments: List<Comment>) : List<CommentDTO> {
        return comments.map { convertToCommentDTO(it) }
    }
}