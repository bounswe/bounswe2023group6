package com.gamelounge.backend.model

data class ForgotPasswordRequest(
    val username: String,
    val email: String
)