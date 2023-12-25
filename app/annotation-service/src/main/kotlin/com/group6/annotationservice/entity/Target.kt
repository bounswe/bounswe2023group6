package com.group6.annotationservice.entity

import jakarta.persistence.Entity
import jakarta.persistence.Id

@Entity
data class Target(
    @Id
    val id: String ="", // e.g., "http://forum.com/posts/789"
    val format: String? = null, // e.g., "text/html"
    val language: String? = null, // e.g., "en"
)