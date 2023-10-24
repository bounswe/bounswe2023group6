package com.gamelounge.backend.entity

import jakarta.persistence.*

@Entity
@Table(name = "hamburgers")
data class Hamburger(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false)
    val name: String = "",

    @Column(nullable = false)
    val ingredients: String = "",

    @Column(nullable = false)
    val price: Double = 0.0
)
