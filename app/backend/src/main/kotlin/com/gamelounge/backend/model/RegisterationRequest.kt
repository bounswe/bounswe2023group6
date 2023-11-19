package com.gamelounge.backend.model


import com.fasterxml.jackson.annotation.JsonProperty
import java.net.URL

data class RegisterationRequest (
    @JsonProperty("username")
    val username: String,

    @JsonProperty("password")
    val password: String,

    @JsonProperty("email")
    val email: String,

    @JsonProperty("image")
    val image: ByteArray?

)
