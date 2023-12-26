package com.group6.annotationservice

import com.group6.annotationservice.controller.AnnotationController
import com.group6.annotationservice.dtos.AnnotationDto
import com.group6.annotationservice.dtos.BodyDto
import com.group6.annotationservice.dtos.FragmentSelectorDto
import com.group6.annotationservice.dtos.TargetDto
import com.group6.annotationservice.entity.*
import com.group6.annotationservice.entity.Annotation
import com.group6.annotationservice.entity.Target
import com.group6.annotationservice.service.AnnotationService
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Mockito.`when`
import org.mockito.junit.jupiter.MockitoExtension
import org.springframework.http.HttpStatus

@ExtendWith(MockitoExtension::class)
class AnnotationControllerTests {

    @Mock
    private lateinit var annotationService: AnnotationService

    @InjectMocks
    private lateinit var annotationController: AnnotationController


    @Test
    fun `createAnnotation should return created status with converted DTO`() {
        val inputDto = AnnotationDto(
            context = "http://www.w3.org/ns/anno.jsonld",
            id = "1",
            type = "Annotation",
            motivation = listOf("editing"),
            creator = "test_creator",
            body = listOf(
                BodyDto(id = "1", type = "TextualBody", value = "Example text")
            ),
            target = TargetDto(
                id = "1",
                format = "text/plain",
                selector = FragmentSelectorDto(
                    type = "FragmentSelector",
                    value = "Example selector"
                )
            )
        )


        val createdAnnotation = Annotation(
            context = "http://www.w3.org/ns/anno.jsonld",
            id = "1",
            type = "Annotation",
            motivation = listOf(Motivation(value = "editing")),
            creator = "test_creator",
            body = listOf(
                Body(id = "1", type = "TextualBody", value = "Example text")
            ),
            target = Target(
                id = "1",
                format = "text/plain",
            ),
            selector = FragmentSelector(
                type = "FragmentSelector",
                value = "Example selector"
            )
        )

        val convertedDto = AnnotationDto(
            context = "http://www.w3.org/ns/anno.jsonld",
            id = "1",
            type = "Annotation",
            motivation = listOf("editing"),
            creator = "test_creator",
            created = createdAnnotation.created,
            body = listOf(
                BodyDto(id = "1", type = "TextualBody", value = "Example text")
            ),
            target = TargetDto(
                id = "1",
                format = "text/plain",
                selector = FragmentSelectorDto(
                    type = "FragmentSelector",
                    value = "Example selector"
                )
            )
        )


        `when`(annotationService.createAnnotation(inputDto)).thenReturn(createdAnnotation)
        //`when`(DtoConverter.convertAnnotationToAnnotationDto(createdAnnotation)).thenReturn(convertedDto)

        val response = annotationController.createAnnotation(inputDto)

        assertEquals(HttpStatus.CREATED, response.statusCode)
        assertEquals(convertedDto.id, response.body!!.id)
        assertEquals(convertedDto.type, response.body!!.type)
        assertEquals(convertedDto.motivation, response.body!!.motivation)
        assertEquals(convertedDto.creator, response.body!!.creator)
        assertEquals(convertedDto.created, response.body!!.created)
        assertEquals(convertedDto.body, response.body!!.body)
        assertEquals(convertedDto.target.id, response.body!!.target.id)
        assertEquals(convertedDto.target.format, response.body!!.target.format)
        assertEquals(convertedDto.target.language, response.body!!.target.language)
        assertEquals(convertedDto.target.selector, response.body!!.target.selector)
    }


}