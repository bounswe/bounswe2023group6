package com.gamelounge.backend.entity

import jakarta.persistence.*
import java.time.Instant

@Entity
@Table(name = "lfg")
class LFG(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val lfgId: Long? = null,

    val title: String = "",
    val description: String = "",
    val requiredPlatform: String = "",
    val requiredLanguage: String = "",
    val micCamRequirement: Boolean = true,
    val memberCapacity: Int = 0,
    val creationDate: Instant = Instant.now(),
    val tags: String? = "",

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    val user: User? = null,

    @OneToMany(mappedBy = "lfg", cascade = arrayOf(CascadeType.ALL), orphanRemoval = true)
    val comments: List<Comment> = mutableListOf()
)