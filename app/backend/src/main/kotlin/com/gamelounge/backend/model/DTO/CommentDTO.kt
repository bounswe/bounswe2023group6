package com.gamelounge.backend.model.DTO

import java.time.Instant

data class CommentDTO(
    var commentId: Long = 0,
    var creatorUserId: Long = 0,
    var content: String = "",
    var creationDate: Instant = Instant.now(),
    var upvotes: Int = 0,
    var downvotes: Int = 0,
)
