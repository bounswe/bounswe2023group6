package com.group6.annotationservice.dtos

import com.fasterxml.jackson.annotation.JsonSubTypes
import com.fasterxml.jackson.annotation.JsonTypeInfo

@JsonTypeInfo(
    use = JsonTypeInfo.Id.NAME,
    include = JsonTypeInfo.As.EXISTING_PROPERTY,
    property = "type",
    visible = true
)
@JsonSubTypes(
    JsonSubTypes.Type(value = TextPositionSelectorDto::class, name = "TextPositionSelector"),
    JsonSubTypes.Type(value = FragmentSelectorDto::class, name = "FragmentSelector")
)
abstract class SelectorDto(
    open val type: String = ""
)