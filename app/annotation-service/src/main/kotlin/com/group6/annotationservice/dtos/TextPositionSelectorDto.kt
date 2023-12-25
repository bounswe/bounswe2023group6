package com.group6.annotationservice.dtos

import com.fasterxml.jackson.annotation.JsonTypeName

@JsonTypeName("TextPositionSelector")
data class TextPositionSelectorDto(
    override val type: String = "TextPositionSelector",
    val start: Int = 0, // e.g., 0
    val end: Int = 0, // e.g., 10

) : SelectorDto()