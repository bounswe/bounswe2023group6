package com.gamelounge.backend.model.request

import com.gamelounge.backend.entity.PostCategory

data class UpdatePostRequest(
    val title: String,
    val content: String,
    val category: PostCategory
)