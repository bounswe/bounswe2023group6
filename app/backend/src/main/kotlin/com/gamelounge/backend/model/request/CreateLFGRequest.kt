package com.gamelounge.backend.model.request

import com.fasterxml.jackson.annotation.JsonProperty

data class CreateLFGRequest(
    @JsonProperty("title")
    val title: String,
    @JsonProperty("description")
    val description: String,
    @JsonProperty("requiredPlatform")
    val requiredPlatform: String,
    @JsonProperty("requiredLanguage")
    val requiredLanguage: String,
    @JsonProperty("micCamRequirement")
    val micCamRequirement: Boolean,
    @JsonProperty("memberCapacity")
    val memberCapacity: Int,
    @JsonProperty("gameId")
    val gameId: Long? = null,
    @JsonProperty("tags")
    val tags: List<String>? = emptyList()
)