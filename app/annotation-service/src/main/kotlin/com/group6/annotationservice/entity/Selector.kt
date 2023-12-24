package com.group6.annotationservice.entity

import jakarta.persistence.Entity
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id

@Entity
data class Selector(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = 0,
    val type: String = "TextPositionSelector",
    val startIndex: Int = 0,  // Starting character position
    val endIndex: Int = 0    // Ending character position
)