package com.group6.annotationservice.service

import com.group6.annotationservice.repository.AnnotationRepository
import org.springframework.stereotype.Service
import com.group6.annotationservice.entity.Annotation
@Service
class AnnotationService (
    private val annotationRepository: AnnotationRepository
) {
    fun createAnnotation(annotation: Annotation): Annotation {
        return annotationRepository.save(annotation)
    }

    fun getAnnotation(id: String): Annotation? {
        return annotationRepository.findById(id).orElse(null)
    }
    fun getAnnotationsByTarget(targetId: String): List<Annotation> {
        return annotationRepository.findByTargetId(targetId)
    }
    fun deleteAnnotation(id: String): Boolean {
        val existingAnnotation = annotationRepository.findById(id).orElse(null)
        if (existingAnnotation != null) {
            annotationRepository.delete(existingAnnotation)
            return true
        }
        return false
    }

}