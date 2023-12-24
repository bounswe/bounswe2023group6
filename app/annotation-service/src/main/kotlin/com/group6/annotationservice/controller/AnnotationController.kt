package com.group6.annotationservice.controller

import com.group6.annotationservice.Utils.DtoConverter
import com.group6.annotationservice.dtos.AnnotationDto
import com.group6.annotationservice.service.AnnotationService
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import com.group6.annotationservice.entity.Annotation

@RestController
@RequestMapping("/annotation")
class AnnotationController(
    private val annotationService: AnnotationService
) {
    @PostMapping("/create")
    fun createAnnotation(@RequestBody annotationDto: AnnotationDto): ResponseEntity<AnnotationDto> {
        val annotation = DtoConverter.convertAnnotationDtoToAnnotation(annotationDto)
        val responseAnnotation = DtoConverter
            .convertAnnotationToAnnotationDto(annotationService.createAnnotation(annotation))
        return ResponseEntity(responseAnnotation, HttpStatus.CREATED)
    }

    @GetMapping("/{id}")
    fun getAnnotation(@PathVariable id: String): ResponseEntity<AnnotationDto> {
        val annotation = annotationService.getAnnotation(id) ?: return ResponseEntity(HttpStatus.NOT_FOUND)

        val responseAnnotation = DtoConverter.convertAnnotationToAnnotationDto(annotation)

        return ResponseEntity.ok(responseAnnotation)
    }

    @GetMapping("/get-annotations-by-target/{targetId}")
    fun getAnnotationsByTarget(@PathVariable targetId: String): ResponseEntity<List<AnnotationDto>> {
        val annotations = annotationService.getAnnotationsByTarget(targetId)
        val responseAnnotationList = annotations.map { DtoConverter.convertAnnotationToAnnotationDto(it) }
        return ResponseEntity.ok(responseAnnotationList)
    }

    @DeleteMapping("/{id}")
    fun deleteAnnotation(@PathVariable id: String): ResponseEntity<Void> {
        return if (annotationService.deleteAnnotation(id)) {
            ResponseEntity<Void>(HttpStatus.NO_CONTENT)
        } else {
            ResponseEntity<Void>(HttpStatus.NOT_FOUND)
        }
    }
}