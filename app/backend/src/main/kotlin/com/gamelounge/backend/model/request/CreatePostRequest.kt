package com.gamelounge.backend.model.request

import com.fasterxml.jackson.annotation.JsonProperty
import com.gamelounge.backend.entity.PostCategory

data class CreatePostRequest(
    @JsonProperty("title")
    val title: String,
    @JsonProperty("content")
    val content: String,
    @JsonProperty("category")
    val category: PostCategory,
    @JsonProperty("tags")
    val tags: List<String>? = emptyList()
)