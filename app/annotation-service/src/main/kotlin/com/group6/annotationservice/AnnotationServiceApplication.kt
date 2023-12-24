package com.group6.annotationservice

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class AnnotationServiceApplication

fun main(args: Array<String>) {
    runApplication<AnnotationServiceApplication>(*args)
}
