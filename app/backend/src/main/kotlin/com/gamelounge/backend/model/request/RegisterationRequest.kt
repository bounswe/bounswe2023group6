package com.gamelounge.backend.model.request

import com.fasterxml.jackson.annotation.JsonProperty

data class RegisterationRequest (
    @JsonProperty("username")
    val username: String,

    @JsonProperty("password")
    val password: String,

    @JsonProperty("email")
    val email: String
)