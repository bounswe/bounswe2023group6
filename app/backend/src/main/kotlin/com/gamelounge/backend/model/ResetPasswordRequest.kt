package com.gamelounge.backend.model

data class ResetPasswordRequest(
    val username: String,
    val token: String,
    val newPassword: String,
    val confirmNewPassword: String
)