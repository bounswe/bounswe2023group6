package com.gamelounge.backend.model.response
import com.fasterxml.jackson.annotation.JsonProperty

data class ResponseMessage(
    @JsonProperty("message")
    val message: String
)