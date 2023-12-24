package com.gamelounge.backend.model.request

import com.fasterxml.jackson.annotation.JsonProperty
import com.gamelounge.backend.entity.PostCategory

data class UpdatePostRequest(
    @JsonProperty("title")
    val title: String?,
    @JsonProperty("content")
    val content: String?,
    @JsonProperty("category")
    val category: PostCategory?,
    @JsonProperty("gameId")
    val gameId: Long?,
    @JsonProperty("tags")
    val tags: List<String>?
)