package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Hamburger
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface HamburgerRepository : JpaRepository<Hamburger, Long>