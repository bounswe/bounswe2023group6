package com.gamelounge.backend.entity

import jakarta.persistence.*
import lombok.NoArgsConstructor

@Entity
@Table(name = "tags")
@NoArgsConstructor
class Tag(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val tagId: Long = 0,

    @Column(unique = true)
    val name: String = "",

    @ManyToMany
    @JoinTable(
        name = "post_tags",
        joinColumns = [JoinColumn(name = "tagId")],
        inverseJoinColumns = [JoinColumn(name = "postId")]
    )
    val posts: List<Post> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "lfg_tags",
        joinColumns = [JoinColumn(name = "tagId")],
        inverseJoinColumns = [JoinColumn(name = "lfgId")]
    )
    val lfgs: List<LFG> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_tags",
        joinColumns = [JoinColumn(name = "tagId")],
        inverseJoinColumns = [JoinColumn(name = "userId")]
    )
    val users: List<User> = mutableListOf()
)