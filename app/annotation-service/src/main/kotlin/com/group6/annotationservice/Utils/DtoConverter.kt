package com.group6.annotationservice.Utils

import com.group6.annotationservice.dtos.*
import com.group6.annotationservice.entity.*
import com.group6.annotationservice.entity.Annotation
import com.group6.annotationservice.entity.Target

object DtoConverter {
    fun convertAnnotationDtoToAnnotation(annotationDto: AnnotationDto): Annotation {

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



        return annotation
    }

    fun convertAnnotationToAnnotationDto(annotation: Annotation): AnnotationDto {

        val bodyDtoList = ArrayList<BodyDto>()
        if (annotation.body != null) {
            for (body in annotation.body!!) {
                val bodyDto = BodyDto(
                    type = body.type,
                    format = body.format,
                    value = body.value,
                    language = body.language,
                    purpose = body.purpose,
                    id = body.id
                )
                bodyDtoList.add(bodyDto)
            }
        }

        var targetDto = TargetDto()
        val target = annotation.target
        if (target != null) { // it wont be null

            targetDto = TargetDto(
                id = target.id,
                format = target.format,
                language = target.language
            )
            if (annotation.selector != null) {
                val selector = annotation.selector
                if (selector is FragmentSelector) {
                    val selectorDto = FragmentSelectorDto(
                        type = selector.type,
                        value = selector.value
                    )
                    targetDto.selector = selectorDto
                } else if (selector is TextPositionSelector) {
                    val selectorDto = TextPositionSelectorDto(
                        type = selector.type,
                        start = selector.startIndex,
                        end = selector.endIndex
                    )
                    targetDto.selector = selectorDto
                }
            }
        }
        val motivationList = ArrayList<String>()
        val motivations = annotation.motivation
        if (motivations != null) {

            for (motivation in motivations) {
                motivationList.add(motivation.value)
            }
        }
        val annotationDto = AnnotationDto(
            motivation = motivationList,
            creator = annotation.creator,
            created = annotation.created,
            id = annotation.id,
            type = annotation.type,
            context = annotation.context,
            body = bodyDtoList,
            target = targetDto
        )

        return annotationDto

    }
}