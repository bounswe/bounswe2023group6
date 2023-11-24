package com.gamelounge.backend.model.request
import com.fasterxml.jackson.annotation.JsonProperty
data class ReportRequest(
    @JsonProperty("reason")
    val reason: String
)