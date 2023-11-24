package com.gamelounge.backend.entity

import jakarta.persistence.*
import lombok.Data
import lombok.NoArgsConstructor

@Entity
@Table(name = "users")
@NoArgsConstructor
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val userId: Long = 0,

    val username: String = "",
    var email: String = "",
    val profilePicture: String? = null,
    var about: String? = null,
    var title: String? = null,
    var company: String? = null,
    var passwordHash: ByteArray = ByteArray(0),
    var salt: ByteArray = ByteArray(0),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    val posts: List<Post> = mutableListOf(),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    val games: List<Game> = mutableListOf(),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    val lfgs: List<LFG> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_likes",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "postId")]
    )
    var likedPosts: MutableList<Post> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_dislikes",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "postId")]
    )
    var dislikedPosts: MutableList<Post> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_likes",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "postId")]
    )
    var likedComments: List<Post> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_dislikes",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "postId")]
    )
    var dislikedComments: List<Post> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_tags",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "tagId")]
    )
    var tags: List<Tag> = mutableListOf()

    )