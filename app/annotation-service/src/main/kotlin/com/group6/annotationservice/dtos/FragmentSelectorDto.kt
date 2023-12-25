package com.group6.annotationservice.dtos

import com.fasterxml.jackson.annotation.JsonTypeName

@JsonTypeName("FragmentSelector")
data class FragmentSelectorDto(
    override val type: String = "FragmentSelector",
    val value: String = "xywh=,,,", // e.g., "annotea is awesome"
) : SelectorDto()