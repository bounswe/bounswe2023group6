package com.gamelounge.backend.entity

import jakarta.persistence.*
import lombok.NoArgsConstructor
import java.time.Instant

@Entity
@Table(name = "lfgs")
@NoArgsConstructor
class LFG(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val lfgId: Long = 0,

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

    @OneToMany(mappedBy = "lfg", cascade = [CascadeType.ALL], orphanRemoval = true)
    val comments: List<Comment> = mutableListOf(),

    @ManyToOne
    @JoinColumn(name = "gameId")
    val relatedGame: Game? = null
)