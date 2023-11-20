package com.gamelounge.backend.model


import com.fasterxml.jackson.annotation.JsonProperty
import org.springframework.web.multipart.MultipartFile


data class RegisterationRequest (
    @JsonProperty("username")
    val username: String,

    @JsonProperty("password")
    val password: String,

    @JsonProperty("email")
    val email: String
)
