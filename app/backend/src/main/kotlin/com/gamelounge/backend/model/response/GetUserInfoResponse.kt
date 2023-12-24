package com.gamelounge.backend.model.response

import com.gamelounge.backend.model.DTO.TagDTO

data class GetUserInfoResponse(
    val userId: Long = 0,
    val username: String = "",
    val email: String = "",
    val profilePicture: String? = null,
    val about: String? = null,
    val isAdmin: Boolean = false,
    val isDeleted: Boolean = false,
    val tags: List<TagDTO>? = null,
    val title: String? = null,
    val company: String? = null,
    val isVisible: Boolean? = true,
    val followerCount: Int = 0,
    val followingCount: Int = 0,
)