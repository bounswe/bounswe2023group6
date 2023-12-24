package com.group6.annotationservice.dtos

import com.group6.annotationservice.entity.Motivation
import java.time.LocalDateTime
import java.util.UUID

data class AnnotationDto (
    val context: String = "http://www.w3.org/ns/anno.jsonld",
    val id: String = "" + UUID.randomUUID().toString(), //todo put our domain name here and generate a uuid
    val type: String = "Annotation",
    val motivation: List<Motivation>? = null,
    val creator: String? = null,
    val created: LocalDateTime? = LocalDateTime.now(), // ISO-8601 datetime format
    val body: List<BodyDto>? = null,
    val target: List<TargetDto>
)