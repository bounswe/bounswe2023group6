package com.group6.annotationservice.dtos

import com.group6.annotationservice.entity.Selector
import java.util.UUID

class TargetDto (
    val id: String = "" + UUID.randomUUID().toString(), //todo put our domain name here and generate a uuid
    val format: String? = null,
    val language: String? = null,
    val selectors: List<SelectorDto>? = null
)