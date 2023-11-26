package com.gamelounge.backend.model.request

data class ForgotPasswordRequest(
    val username: String,
    val email: String
)