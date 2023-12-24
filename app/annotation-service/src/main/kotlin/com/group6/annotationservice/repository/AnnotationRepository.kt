package com.group6.annotationservice.repository

import com.group6.annotationservice.entity.Annotation
import org.springframework.data.jpa.repository.JpaRepository

interface AnnotationRepository: JpaRepository<Annotation,String> {
    fun findByTargetId(targetId: String): List<Annotation>
}