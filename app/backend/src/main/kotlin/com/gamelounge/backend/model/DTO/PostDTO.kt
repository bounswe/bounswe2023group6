package com.gamelounge.backend.model.DTO

import com.gamelounge.backend.entity.PostCategory
import java.time.Instant

data class PostDTO(
    var postId: Long = 0,
    var title: String = "",
    var content: String = "",
    var creationDate: Instant = Instant.now(),
    var upvotes: Int = 0,
    var downvotes: Int = 0,
    var totalComments: Int = 0,
    var category: PostCategory = PostCategory.DISCUSSION
)

