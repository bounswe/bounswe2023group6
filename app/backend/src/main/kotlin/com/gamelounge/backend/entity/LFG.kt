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
    var lfgId: Long = 0,

    var title: String = "",
    var description: String = "",
    var requiredPlatform: String = "",
    var requiredLanguage: String = "",
    var micCamRequirement: Boolean = true,
    var memberCapacity: Int = 0,
    var creationDate: Instant = Instant.now(),
    var totalComments: Int = 0,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    var user: User? = null,

    @OneToMany(mappedBy = "lfg", cascade = [CascadeType.ALL], orphanRemoval = true)
    var comments: List<Comment> = mutableListOf(),

    @ManyToOne
    @JoinColumn(name = "gameId")
    var relatedGame: Game? = null,

    @ManyToMany
    @JoinTable(
    name = "lfg_tags",
    joinColumns = [JoinColumn(name = "lfgId")],
    inverseJoinColumns = [JoinColumn(name = "tagId")]
    )
    var tags: List<Tag> = mutableListOf()
)