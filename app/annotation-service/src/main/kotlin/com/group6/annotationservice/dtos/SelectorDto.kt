package com.group6.annotationservice.dtos

import lombok.AllArgsConstructor
import lombok.Data
import lombok.NoArgsConstructor

@NoArgsConstructor
@AllArgsConstructor
@Data
data class SelectorDto (
    val type: String = "TextPositionSelector",
    val startIndex: Int,  // Starting character position
    val endIndex: Int     // Ending character position
)