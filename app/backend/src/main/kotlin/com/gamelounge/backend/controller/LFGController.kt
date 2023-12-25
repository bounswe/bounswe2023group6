package com.gamelounge.backend.controller

import com.gamelounge.backend.model.DTO.LFGDTO
import com.gamelounge.backend.util.ConverterDTO.convertBulkToLFGDTO
import com.gamelounge.backend.model.request.CreateLFGRequest
import com.gamelounge.backend.model.request.UpdateLFGRequest
import com.gamelounge.backend.model.response.ResponseMessage
import com.gamelounge.backend.service.LFGService
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/lfg")
class LFGController(private val lfgService: LFGService) {

    @PostMapping
    fun createLFG(@CookieValue("SESSIONID") sessionId: UUID, @RequestBody lfg: CreateLFGRequest): ResponseEntity<LFGDTO> {
        val newLFG = lfgService.createLFG(sessionId, lfg)
        val newLFGDTO = ConverterDTO.convertToLFGDTO(newLFG)
        return ResponseEntity.ok(newLFGDTO)
    }

    @GetMapping("/{id}")
    fun getLFG(@PathVariable id: Long): ResponseEntity<LFGDTO> {
        val lfg = lfgService.getLFG(id)
        val lfgDTO = ConverterDTO.convertToLFGDTO(lfg)
        return ResponseEntity.ok(lfgDTO)
    }

    @PutMapping("/{id}")
    fun updateLFG(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @RequestBody lfg: UpdateLFGRequest): ResponseEntity<LFGDTO> {
        val updatedLFG = lfgService.updateLFG(sessionId, id, lfg)
        val updatedLFGDTO = ConverterDTO.convertToLFGDTO(updatedLFG)
        return ResponseEntity.ok(updatedLFGDTO)
    }

    @DeleteMapping("/{id}")
    fun deleteLFG(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<ResponseMessage> {
        lfgService.deleteLFG(sessionId, id)
        return ResponseEntity.ok(ResponseMessage(message = "LFG deleted successfully"))
    }

    @GetMapping("/all")
    fun getAllLFGs(): ResponseEntity<List<LFGDTO>> {
        val lfgs = lfgService.getAllLFGs()
        val lfgDTOs = ConverterDTO.convertBulkToLFGDTO(lfgs)
        return ResponseEntity.ok(lfgDTOs)
    }
    
    @GetMapping("/recommended")
    fun getRecommendedLFGs(@CookieValue("SESSIONID") sessionId: UUID?): ResponseEntity<List<LFGDTO>> {
        val LFGDTOs = lfgService.getRecommendedLFGs(sessionId)
        return ResponseEntity.ok(LFGDTOs)
    }

    // join to lfg
    @PostMapping("/{id}/join")
    fun joinLFG(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<LFGDTO> {
        val lfg = lfgService.joinLFG(sessionId, id)
        val lfgDTO = ConverterDTO.convertToLFGDTO(lfg)
        return ResponseEntity.ok(lfgDTO)
    }
    // leave lfg
    @PostMapping("/{id}/leave")
    fun leaveLFG(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long): ResponseEntity<LFGDTO> {
        val lfg = lfgService.leaveLFG(sessionId, id)
        val lfgDTO = ConverterDTO.convertToLFGDTO(lfg)
        return ResponseEntity.ok(lfgDTO)
    }
    // kick user from lfg
    @PostMapping("/{id}/kick/{kickUserId}")
    fun kickUserFromLFG(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable id: Long, @PathVariable kickUserId: Long): ResponseEntity<LFGDTO> {
        val lfg = lfgService.kickUserFromLFG(sessionId, id, kickUserId)
        val lfgDTO = ConverterDTO.convertToLFGDTO(lfg)
        return ResponseEntity.ok(lfgDTO)
    }
}
