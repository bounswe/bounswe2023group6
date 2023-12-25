package com.group6.annotationservice.Utils
import com.group6.annotationservice.dtos.AnnotationDto
import com.group6.annotationservice.dtos.BodyDto
import com.group6.annotationservice.dtos.SelectorDto
import com.group6.annotationservice.dtos.TargetDto
import com.group6.annotationservice.entity.Annotation
import com.group6.annotationservice.entity.Body
import com.group6.annotationservice.entity.Selector
import com.group6.annotationservice.entity.Target

object DtoConverter {
    fun convertAnnotationDtoToAnnotation(annotationDto: AnnotationDto): Annotation {
        val annotation = Annotation(
            motivation = annotationDto.motivation,
            creator = annotationDto.creator,
            created = annotationDto.created,
            id = annotationDto.id,
            type = annotationDto.type,
            context = annotationDto.context
        )

        val bodyList = ArrayList<Body>()
        if (annotationDto.body != null){
            for (bodyDto in annotationDto.body) {
                val body = Body(
                    type = bodyDto.type,
                    format = bodyDto.format,
                    value = bodyDto.value,
                    language = bodyDto.language,
                    purpose = bodyDto.purpose,
                    id = bodyDto.id,
                    annotation = annotation
                )
                bodyList.add(body)
            }
        }
        val targetList = ArrayList<Target>()
        for (targetDto in annotationDto.target) {
            val selectorList = ArrayList<Selector>()
            if (targetDto.selectors != null){
                for (selectorDto in targetDto.selectors) {
                    val selector = Selector(
                        type = selectorDto.type,
                        startIndex = selectorDto.startIndex,
                        endIndex = selectorDto.endIndex
                    )
                    selectorList.add(selector)
                }
            }
            val target = Target(
                id = targetDto.id,
                format = targetDto.format,
                language = targetDto.language,
                annotation = annotation,
                selector = selectorList
            )

            targetList.add(target)
        }
        annotation.body = bodyList
        annotation.target = targetList


        return annotation
    }
    fun convertAnnotationToAnnotationDto(annotation: Annotation): AnnotationDto {
        val targetDtoArrayList = ArrayList<TargetDto>()
        for (annotationTarget in annotation.target) {
            val selectorDtoList = ArrayList<SelectorDto>()
            if (annotationTarget.selector != null){
                for (selector in annotationTarget.selector) {
                    val selectorDto = SelectorDto(
                        type = selector.type,
                        startIndex = selector.startIndex,
                        endIndex = selector.endIndex
                    )
                    selectorDtoList.add(selectorDto)
                }
            }

            val targetDto = TargetDto(
                id = annotationTarget.id,
                format = annotationTarget.format,
                language = annotationTarget.language,
                selectors = selectorDtoList
            )
            targetDtoArrayList.add(targetDto)
        }

        val bodyDtoList = ArrayList<BodyDto>()
        if(annotation.body != null){

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

        return AnnotationDto(
            motivation = annotation.motivation,
            creator = annotation.creator,
            created = annotation.created,
            id = annotation.id,
            type = annotation.type,
            context = annotation.context,
            body = bodyDtoList,
            target = targetDtoArrayList
        )
    }
}