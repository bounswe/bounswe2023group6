package com.group6.annotationservice

import com.group6.annotationservice.Utils.DtoConverter
import com.group6.annotationservice.dtos.AnnotationDto
import com.group6.annotationservice.dtos.BodyDto
import com.group6.annotationservice.dtos.FragmentSelectorDto
import com.group6.annotationservice.dtos.TargetDto
import com.group6.annotationservice.entity.*
import com.group6.annotationservice.entity.Annotation
import com.group6.annotationservice.entity.Target
import com.group6.annotationservice.repository.AnnotationRepository
import com.group6.annotationservice.service.AnnotationService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.mockito.Mockito.*
import org.mockito.kotlin.whenever
import java.util.*


class AnnotationServiceTests {

    private val annotationRepository = mock<AnnotationRepository>()
    private val annotationService = AnnotationService(annotationRepository)

    @Test
    fun `createAnnotation should correctly transform and save annotation`() {
        val inputAnnotationDto = AnnotationDto(
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
        val createdAnnotationTarget = Annotation(
            context = "http://www.w3.org/ns/anno.jsonld",
            id = "1",
            type = "Annotation",
            motivation = listOf(Motivation(value = "editing")),
            creator = "test_creator",
            created = inputAnnotationDto.created,
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

        val convertedAnnotation = DtoConverter.convertAnnotationDtoToAnnotation(inputAnnotationDto)

        whenever(annotationRepository.save(any<Annotation>())).thenAnswer { it.arguments[0] }

        val result = annotationService.createAnnotation(inputAnnotationDto)

        assertEquals(convertedAnnotation.id, result.id)
        assertEquals(convertedAnnotation.context, result.context)
        assertEquals(convertedAnnotation.type, result.type)
        for (i in convertedAnnotation.motivation!!.indices) {
            assertEquals(convertedAnnotation.motivation!![i].value, result.motivation!![i].value)
        }
        assertEquals(convertedAnnotation.creator, result.creator)
        assertEquals(convertedAnnotation.created, result.created)
        assertEquals(convertedAnnotation.body, result.body)
        assertEquals(convertedAnnotation.target, result.target)
        assertEquals(convertedAnnotation.selector, result.selector)


        assertEquals(createdAnnotationTarget.id, result.id)
        assertEquals(createdAnnotationTarget.context, result.context)
        assertEquals(createdAnnotationTarget.type, result.type)
        for (i in createdAnnotationTarget.motivation!!.indices) {
            assertEquals(createdAnnotationTarget.motivation!![i].value, result.motivation!![i].value)
        }
        assertEquals(createdAnnotationTarget.creator, result.creator)
        assertEquals(createdAnnotationTarget.created, result.created)
        assertEquals(createdAnnotationTarget.body, result.body)
        assertEquals(createdAnnotationTarget.target, result.target)
        assertEquals(createdAnnotationTarget.selector, result.selector)


        // Verify interaction with the repository
        //verify(annotationRepository).save(any<Annotation>())
    }

    @Test
    fun `getAnnotation should return annotation when found`() {
        val annotationId = "testId"
        val expectedAnnotation = Annotation(
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

        whenever(annotationRepository.findById(annotationId)).thenReturn(Optional.of(expectedAnnotation))

        val result = annotationService.getAnnotation(annotationId)

        assertEquals(expectedAnnotation, result)
    }

    @Test
    fun `getAnnotation should return null when annotation not found`() {
        val annotationId = "testId"

        whenever(annotationRepository.findById(annotationId)).thenReturn(Optional.empty())

        val result = annotationService.getAnnotation(annotationId)

        assertNull(result)
    }

    @Test
    fun `getAnnotationsByTarget should return list of annotations when found`() {
        val targetId = "target1"
        val expectedAnnotations = listOf(
            Annotation(
                context = "http://www.w3.org/ns/anno.jsonld",
                id = "1",
                type = "Annotation",
                motivation = listOf(Motivation(value = "editing")),
                creator = "test_creator",
                body = listOf(
                    Body(id = "1", type = "TextualBody", value = "Example text")
                ),
                target = Target(
                    id = "target1",
                    format = "text/plain",
                ),
                selector = FragmentSelector(
                    type = "FragmentSelector",
                    value = "Example selector"
                )

            ),
            Annotation(
                context = "http://www.w3.org/ns/anno.jsonld",
                id = "2",
                type = "Annotation",
                motivation = listOf(Motivation(value = "editing")),
                creator = "test_creator",
                body = listOf(
                    Body(id = "1", type = "TextualBody", value = "Example text")
                ),
                target = Target(
                    id = "target1",
                    format = "text/plain",
                ),
                selector = FragmentSelector(
                    type = "FragmentSelector",
                    value = "Example selector"
                )
            )
            // Add more annotations as needed
        )

        whenever(annotationRepository.findByTargetId(targetId)).thenReturn(expectedAnnotations)

        val result = annotationService.getAnnotationsByTarget(targetId)

        assertEquals(expectedAnnotations, result)
        assertEquals(2, result.size) // Assuming two annotations were setup
    }

    @Test
    fun `deleteAnnotation should return true and delete annotation when found`() {
        val annotationId = "testId"
        val existingAnnotation = Annotation(/* ... initialize with test data ... */)

        whenever(annotationRepository.findById(annotationId)).thenReturn(Optional.of(existingAnnotation))

        val result = annotationService.deleteAnnotation(annotationId)

        assertTrue(result)
        verify(annotationRepository).delete(existingAnnotation)
    }

    @Test
    fun `deleteAnnotation should return false when annotation not found`() {
        val annotationId = "testId"

        whenever(annotationRepository.findById(annotationId)).thenReturn(Optional.empty())

        val result = annotationService.deleteAnnotation(annotationId)

        assertFalse(result)
        verify(annotationRepository, never()).delete(any())
    }


}