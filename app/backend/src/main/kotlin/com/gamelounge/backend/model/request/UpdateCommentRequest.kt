package com.gamelounge.backend.model.request
import com.fasterxml.jackson.annotation.JsonProperty

data class UpdateCommentRequest(
    @JsonProperty("content")
    val content: String
)