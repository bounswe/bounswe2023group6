package com.gamelounge.backend.model.DTO

data class UserDTO(
    var userId: Long = 0,
    var username: String = "",
    var email: String = "",
    var profilePicture: String? = null,
    var about: String? = null,
    var title: String? = null,
    var company: String? = null,
    var tags: List<TagDTO>? = null
)