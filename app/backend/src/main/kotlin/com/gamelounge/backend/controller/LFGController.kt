package com.gamelounge.backend.controller

import com.gamelounge.backend.model.DTO.LFGDTO
import com.gamelounge.backend.service.LFGService
import com.gamelounge.backend.util.ConverterDTO.convertBulkToLFGDTO
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CookieValue
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.util.*

@RestController
@RequestMapping("/lfg")
class LFGController(
    private val lfgService: LFGService
) {
    @GetMapping()
    fun getAllLFGs(@CookieValue("SESSIONID") sessionId: UUID?): ResponseEntity<List<LFGDTO>> {
        val LFGDTOs = convertBulkToLFGDTO(lfgService.getAllLFGs())
        return ResponseEntity.ok(LFGDTOs)
    }

    @GetMapping("/recommended")
    fun getRecommendedLFGs(@CookieValue("SESSIONID") sessionId: UUID?): ResponseEntity<List<LFGDTO>> {
        val LFGDTOs = lfgService.getRecommendedLFGs(sessionId)
        return ResponseEntity.ok(LFGDTOs)
    }
}