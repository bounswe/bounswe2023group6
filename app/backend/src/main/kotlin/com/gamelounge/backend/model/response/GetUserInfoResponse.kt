package com.gamelounge.backend.model.response

data class GetUserInfoResponse(
    val userId: Long = 0,
    val username: String = "",
    val email: String = "",
    val profilePicture: String? = null,
    val about: String? = null,
    val isAdmin: Boolean = false
)