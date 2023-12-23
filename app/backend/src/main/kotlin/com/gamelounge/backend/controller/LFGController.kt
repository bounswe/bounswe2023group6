package com.gamelounge.backend.controller

import com.gamelounge.backend.model.DTO.LFGDTO
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
}
