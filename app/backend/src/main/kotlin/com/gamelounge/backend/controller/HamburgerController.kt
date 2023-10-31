package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Hamburger
import com.gamelounge.backend.service.HamburgerService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/hamburgers")
class HamburgerController(private val hamburgerService: HamburgerService) {

    @GetMapping
    fun getAllHamburgers(): ResponseEntity<List<Hamburger>> =
        ResponseEntity.ok(hamburgerService.getAllHamburgers())

    @PostMapping
    fun createHamburger(@RequestBody hamburger: Hamburger): ResponseEntity<Hamburger> =
        ResponseEntity.ok(hamburgerService.createHamburger(hamburger))

    @GetMapping("/{id}")
    fun getHamburgerById(@PathVariable id: Long): ResponseEntity<Hamburger> =
        ResponseEntity.ok(hamburgerService.getHamburgerById(id))

    @PutMapping("/{id}")
    fun updateHamburger(@PathVariable id: Long, @RequestBody hamburger: Hamburger): ResponseEntity<Hamburger> =
        ResponseEntity.ok(hamburgerService.updateHamburger(id, hamburger))

    @DeleteMapping("/{id}")
    fun deleteHamburger(@PathVariable id: Long): ResponseEntity<Void> {
        hamburgerService.deleteHamburger(id)
        return ResponseEntity.noContent().build()
    }
}