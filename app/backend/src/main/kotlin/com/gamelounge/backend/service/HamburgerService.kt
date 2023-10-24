package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Hamburger
import com.gamelounge.backend.repository.HamburgerRepository
import org.springframework.stereotype.Service

@Service
class HamburgerService(private val hamburgerRepository: HamburgerRepository) {

    fun getAllHamburgers(): List<Hamburger> = hamburgerRepository.findAll()

    fun createHamburger(hamburger: Hamburger): Hamburger = hamburgerRepository.save(hamburger)

    fun getHamburgerById(id: Long): Hamburger = hamburgerRepository.findById(id).orElseThrow()

    fun updateHamburger(id: Long, hamburger: Hamburger): Hamburger {
        val existingHamburger = getHamburgerById(id)
        val updatedHamburger = existingHamburger.copy(name = hamburger.name, ingredients = hamburger.ingredients, price = hamburger.price)
        return hamburgerRepository.save(updatedHamburger)
    }

    fun deleteHamburger(id: Long) = hamburgerRepository.deleteById(id)
}