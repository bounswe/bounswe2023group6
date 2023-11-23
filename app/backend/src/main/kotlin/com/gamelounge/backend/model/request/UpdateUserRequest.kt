package com.gamelounge.backend.model.request

import com.fasterxml.jackson.annotation.JsonProperty
import com.gamelounge.backend.entity.Tag

data class UpdateUserRequest(
    @JsonProperty("email")
    val email: String?,

    @JsonProperty("about")
    val about: String?,

    @JsonProperty("tags")
    val tags: List<String>?,

    @JsonProperty("title")
    val title: String?,

    @JsonProperty("company")
    val company: String?
) 