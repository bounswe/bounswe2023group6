package com.group6.annotationservice.service

import com.group6.annotationservice.dtos.AnnotationDto
import com.group6.annotationservice.dtos.FragmentSelectorDto
import com.group6.annotationservice.dtos.TextPositionSelectorDto
import com.group6.annotationservice.entity.*
import com.group6.annotationservice.entity.Annotation
import com.group6.annotationservice.entity.Target
import com.group6.annotationservice.repository.AnnotationRepository
import org.springframework.stereotype.Service

@Service
class AnnotationService (
    private val annotationRepository: AnnotationRepository,

) {
    fun createAnnotation(annotationDto: AnnotationDto): Annotation {

        val motivationList = ArrayList<Motivation>()
        if (annotationDto.motivation != null) {

            for (motivation in annotationDto.motivation) {
                motivationList.add(Motivation(value = motivation))
            }

        }
        val annotation = Annotation(
            creator = annotationDto.creator,
            created = annotationDto.created,
            id = annotationDto.id,
            type = annotationDto.type,
            context = annotationDto.context,
            motivation = motivationList
        )

        val bodyList = ArrayList<Body>()
        if (annotationDto.body != null) {

            for (bodyDto in annotationDto.body) {
                val body = Body(
                    type = bodyDto.type,
                    format = bodyDto.format,
                    value = bodyDto.value,
                    language = bodyDto.language,
                    purpose = bodyDto.purpose,
                    id = bodyDto.id,
                )
                bodyList.add(body)
            }
        }

        val target = Target(
            id = annotationDto.target.id,
            format = annotationDto.target.format,
            language = annotationDto.target.language,
        )

        val targetDto = annotationDto.target
        if (targetDto.selector != null) {
            val selectorDto = targetDto.selector!!
            if (selectorDto.type == "FragmentSelector") {
                val selector = FragmentSelector(
                    type = selectorDto.type,
                    value = (selectorDto as FragmentSelectorDto).value
                )
                annotation.selector = selector


            } else if (selectorDto.type == "TextPositionSelector") {
                val selector = TextPositionSelector(
                    type = selectorDto.type,
                    startIndex = (selectorDto as TextPositionSelectorDto).start,
                    endIndex = selectorDto.end
                )
                annotation.selector = selector
            }
        }

        annotation.body = bodyList
        annotation.target = target

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