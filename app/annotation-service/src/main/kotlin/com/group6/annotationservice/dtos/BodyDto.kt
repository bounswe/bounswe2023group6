package com.group6.annotationservice.dtos

import java.util.UUID

data class BodyDto (
    val id: String,
    val type: String? = null, // e.g., "TextualBody", "Image", "Video"
    val value: String? = null, // e.g., "This is an insightful post!"
    val format: String? = null,
    val language: String? = null,
    val purpose: String? = null
)