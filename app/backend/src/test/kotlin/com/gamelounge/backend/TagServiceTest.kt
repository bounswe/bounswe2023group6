package com.gamelounge.backend

import com.gamelounge.backend.entity.Tag
import com.gamelounge.backend.repository.TagRepository
import com.gamelounge.backend.service.TagService
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.mockito.Mockito.mock
import org.mockito.kotlin.whenever

class TagServiceTest {
    private val tagRepository: TagRepository = mock()
    private val tagService = TagService(tagRepository)

    @Test
    fun `createAndReturnTagsFromTagNames should return null when input is null`() {
        val result = tagService.createAndReturnTagsFromTagNames(null)
        assertNull(result)
    }
    @Test
    fun `createAndReturnTagsFromTagNames should save new tags and return them`() {
        val tagNames = listOf("Tag1", "Tag2")
        val tags = tagNames.map { Tag(name = it) }

        tagNames.forEach { tagName ->
            whenever(tagRepository.existsByName(tagName)).thenReturn(false)
            whenever(tagRepository.save(Tag(name = tagName))).thenReturn(Tag(name = tagName))
        }
        tagNames.forEach { tagName ->
            whenever(tagRepository.findTagByName(tagName)).thenReturn(Tag(name = tagName))
        }

        val result = tagService.createAndReturnTagsFromTagNames(tagNames)

        assertNotNull(result)
        assertEquals(2, result?.size)
        assertTrue(result?.map { it.name }?.containsAll(tagNames) == true)
    }

    @Test
    fun `createAndReturnTagsFromTagNames should return existing tags`() {
        val tagNames = listOf("Tag1", "Tag2")
        val tags = tagNames.map { Tag(name = it) }

        tagNames.forEach { tagName ->
            whenever(tagRepository.existsByName(tagName)).thenReturn(true)
        }
        tagNames.forEach { tagName ->
            whenever(tagRepository.findTagByName(tagName)).thenReturn(Tag(name = tagName))
        }

        val result = tagService.createAndReturnTagsFromTagNames(tagNames)

        assertNotNull(result)
        assertEquals(2, result?.size)
        assertTrue(result?.map { it.name }?.containsAll(tagNames) == true)
    }





}