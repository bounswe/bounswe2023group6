package com.gamelounge.backend.model.request

data class ChangePasswordRequest (
    val currentPassword: String,
    val newPassword: String,
    val confirmPassword: String
)