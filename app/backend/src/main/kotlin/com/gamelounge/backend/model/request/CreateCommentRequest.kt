package com.gamelounge.backend.model.request
import com.fasterxml.jackson.annotation.JsonProperty

data class CreateCommentRequest(
    @JsonProperty("content")
    val content: String,
    @JsonProperty("replyToCommentId")
    val replyToCommentId: Long? = null
)