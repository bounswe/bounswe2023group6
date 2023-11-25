package com.gamelounge.backend.controller

import com.gamelounge.backend.model.DTO.TagDTO
import com.gamelounge.backend.service.TagService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/tags")
class TagController (
    private val tagService: TagService
){
    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    @CrossOrigin(origins = ["*"])
    fun getAllTags(): List<TagDTO>{
        return tagService.getAllTags()
    }
}