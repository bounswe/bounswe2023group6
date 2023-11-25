package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Tag
import com.gamelounge.backend.model.DTO.TagDTO
import com.gamelounge.backend.repository.TagRepository
import com.gamelounge.backend.util.ConverterDTO.convertBulkToTagDTO
import org.springframework.stereotype.Service

@Service
class TagService(
    private val tagRepository: TagRepository
) {

    fun getAllTags(): List<TagDTO>{
        return convertBulkToTagDTO(tagRepository.findAll())
    }

    fun createAndReturnTagsFromTagNames(tagNames: List<String>?): List<Tag>?{
        if(tagNames == null)
            return null

        tagNames.forEach { tagName ->
            if(!tagRepository.existsByName(tagName))
                tagRepository.save(Tag(name = tagName))
        }

        return tagNames.mapNotNull { tagName -> tagRepository.findTagByName(tagName) }
    }


}