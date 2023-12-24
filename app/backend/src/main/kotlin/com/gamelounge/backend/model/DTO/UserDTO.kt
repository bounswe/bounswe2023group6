package com.gamelounge.backend.model.DTO

data class UserDTO(
    var userId: Long = 0,
    var username: String = "",
    var email: String = "",
    var profilePicture: String? = null,
    var about: String? = null,
    var title: String? = null,
    var company: String? = null,
    var tags: List<TagDTO>? = null,
    var followers: List<UserDTO>? = null,
    var isVisible: Boolean = false,
    var isDeleted: Boolean = false,
    var isAdmin: Boolean = false
)