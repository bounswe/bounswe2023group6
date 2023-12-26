package com.group6.annotationservice.controller

import com.group6.annotationservice.Utils.DtoConverter
import com.group6.annotationservice.dtos.AnnotationDto
import com.group6.annotationservice.dtos.GetAnnotationsByTargetIdRequest
import com.group6.annotationservice.dtos.SelectorDto
import com.group6.annotationservice.service.AnnotationService
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/annotation")
class AnnotationController(
    private val annotationService: AnnotationService
) {
    @PostMapping("parse-selector")
    @CrossOrigin(origins = ["http://localhost:3000", "http://167.99.242.175", "http://167.99.242.175:3000", "http://game-lounge.com", "http://game-lounge.com:3000", "http://www.game-lounge.com", "http://www.game-lounge.com:3000", "https://game-lounge.com", "https://www.game-lounge.com"])
    fun parseSelector(@RequestBody selector: SelectorDto): ResponseEntity<String> {

        return ResponseEntity.ok("test")
    }
    @PostMapping("/create")
    @CrossOrigin(origins = ["http://localhost:3000", "http://167.99.242.175", "http://167.99.242.175:3000", "http://game-lounge.com", "http://game-lounge.com:3000", "http://www.game-lounge.com", "http://www.game-lounge.com:3000", "https://game-lounge.com", "https://www.game-lounge.com"])
    fun createAnnotation(@RequestBody annotationDto: AnnotationDto): ResponseEntity<AnnotationDto> {

        val responseAnnotation = DtoConverter
            .convertAnnotationToAnnotationDto(annotationService.createAnnotation(annotationDto))
        return ResponseEntity(responseAnnotation, HttpStatus.CREATED)
    }

    @GetMapping("/{id}")
    @CrossOrigin(origins = ["http://localhost:3000", "http://167.99.242.175", "http://167.99.242.175:3000", "http://game-lounge.com", "http://game-lounge.com:3000", "http://www.game-lounge.com", "http://www.game-lounge.com:3000", "https://game-lounge.com", "https://www.game-lounge.com"])
    fun getAnnotation(@PathVariable id: String): ResponseEntity<AnnotationDto> {
        val annotation = annotationService.getAnnotation(id) ?: return ResponseEntity(HttpStatus.NOT_FOUND)

        val responseAnnotation = DtoConverter.convertAnnotationToAnnotationDto(annotation)

        return ResponseEntity.ok(responseAnnotation)
    }

    @PostMapping("/get-annotations-by-target")
    @CrossOrigin(origins = ["http://localhost:3000", "http://167.99.242.175", "http://167.99.242.175:3000", "http://game-lounge.com", "http://game-lounge.com:3000", "http://www.game-lounge.com", "http://www.game-lounge.com:3000", "https://game-lounge.com", "https://www.game-lounge.com"])
    fun getAnnotationsByTarget(@RequestBody request: GetAnnotationsByTargetIdRequest): ResponseEntity<List<AnnotationDto>> {
        val annotations = annotationService.getAnnotationsByTarget(request.targetId)
        val responseAnnotationList = annotations.map { DtoConverter.convertAnnotationToAnnotationDto(it) }
        return ResponseEntity.ok(responseAnnotationList)
    }

    @DeleteMapping("/{id}")
    @CrossOrigin(origins = ["http://localhost:3000", "http://167.99.242.175", "http://167.99.242.175:3000", "http://game-lounge.com", "http://game-lounge.com:3000", "http://www.game-lounge.com", "http://www.game-lounge.com:3000", "https://game-lounge.com", "https://www.game-lounge.com"])
    fun deleteAnnotation(@PathVariable id: String): ResponseEntity<Void> {
        return if (annotationService.deleteAnnotation(id)) {
            ResponseEntity<Void>(HttpStatus.NO_CONTENT)
        } else {
            ResponseEntity<Void>(HttpStatus.NOT_FOUND)
        }
    }
}
