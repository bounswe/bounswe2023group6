package com.group6.annotationservice.entity

import jakarta.persistence.DiscriminatorValue
import jakarta.persistence.Entity

@Entity
@DiscriminatorValue("TextQuoteSelector")
data class TextPositionSelector(
    override val type: String = "TextPositionSelector",
    val startIndex: Int = 0,  // Starting character position
    val endIndex: Int = 0    // Ending character position
) : Selector()