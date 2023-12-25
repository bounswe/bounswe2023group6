package com.group6.annotationservice.dtos

import java.util.*

class TargetDto (
    val id: String = "" + UUID.randomUUID().toString(), //todo put our domain name here and generate a uuid
    val format: String? = null,
    val language: String? = null,
    var selector: SelectorDto? = null
)