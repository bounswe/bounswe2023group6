package com.gamelounge.backend.model


import com.fasterxml.jackson.annotation.JsonProperty

data class RegisterationRequest (
    @JsonProperty("username")
    val username: String,

    @JsonProperty("password")
    val password: String,

    @JsonProperty("email")
    val email: String,

    @JsonProperty("name")
    val name: String,

    @JsonProperty("surname")
    val surname: String,

    @JsonProperty("image")
    val image: ByteArray?

)
