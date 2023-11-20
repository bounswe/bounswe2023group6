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
    val email: String = "",
    val profilePicture: String? = null,
    val about: String? = null,
    var passwordHash: ByteArray = ByteArray(0),
    var salt: ByteArray = ByteArray(0),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    val posts: List<Post> = mutableListOf(),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
     val games: List<Game> = mutableListOf(),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    val lfgs: List<LFG> = mutableListOf(),

)