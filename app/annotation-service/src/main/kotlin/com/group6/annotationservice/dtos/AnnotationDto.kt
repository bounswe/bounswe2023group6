package com.group6.annotationservice.dtos

import java.time.LocalDateTime
import java.util.*

data class AnnotationDto (
    val context: String = "http://www.w3.org/ns/anno.jsonld",
    val id: String = "" + UUID.randomUUID().toString(), //todo put our domain name here and generate a uuid
    val type: String = "Annotation",
    val motivation: List<String>? = null,
    val creator: String? = null,
    val created: LocalDateTime? = LocalDateTime.now(), // ISO-8601 datetime format
    val body: List<BodyDto>? = null,
    val target: TargetDto = TargetDto()
)