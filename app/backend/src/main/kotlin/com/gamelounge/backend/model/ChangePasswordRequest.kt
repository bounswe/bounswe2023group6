package com.gamelounge.backend.model

data class ChangePasswordRequest (
    val currentPassword: String,
    val newPassword: String,
    val confirmPassword: String
)