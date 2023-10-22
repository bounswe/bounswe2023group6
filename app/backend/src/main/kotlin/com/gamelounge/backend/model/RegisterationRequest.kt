package com.gamelounge.backend.model


import com.fasterxml.jackson.annotation.JsonProperty

data class RegisterationRequest (
    @JsonProperty("username")
    var username: String,

    @JsonProperty("password")
    var password: String,

    @JsonProperty("email")
    var email: String,

    @JsonProperty("name")
    var name: String,

    @JsonProperty("surname")
    var surname: String,

    @JsonProperty("image")
    var image: ByteArray

)
