package com.gamelounge.backend.entity

import jakarta.persistence.*

@Entity
@Table(name = "tags")
class Tag(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val tagId: Long = 0,

    val name: String = "",

    @ManyToMany(mappedBy = "tags")
    val posts: List<Post> = mutableListOf(),

    @ManyToMany(mappedBy = "tags")
    val lfgs: List<LFG> = mutableListOf()
)