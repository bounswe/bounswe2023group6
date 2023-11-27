package com.gamelounge.backend.entity

import com.gamelounge.backend.entity.Character
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne

import jakarta.persistence.*
import lombok.NoArgsConstructor
import java.time.Instant

@Entity
@Table(name = "games")
@NoArgsConstructor
class Game(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val gameId: Long = 0,

        var title: String = "",
        var description: String = "",
        var genre: String = "",
        var platform: String = "",
        var playerNumber: String = "",
        var releaseYear: Int = 0,
        var universe: String = "",
        var mechanics: String = "",
        var playtime: String = "",
        var totalRating: Int = 0,
        var countRating: Int = 0,
        var averageRating: Double = 0.0,
        var creationDate: Instant = Instant.now(),
        var gamePicture: String? = null,

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(name = "userId")
        val user: User? = null,

        @OneToMany(mappedBy = "relatedGame")
        val lfgs: List<LFG> = mutableListOf(),

        @OneToMany(mappedBy = "relatedGame")
        val posts: List<Post> = mutableListOf(),

        @OneToMany(mappedBy = "relatedGame")
        val characters: List<Character> = mutableListOf(),

        @ManyToMany
        @JoinTable(
                name = "game_tags",
                joinColumns = [JoinColumn(name = "gameId")],
                inverseJoinColumns = [JoinColumn(name = "tagId")]
        )
        var tags: List<Tag> = mutableListOf(),

        @ManyToMany
        @JoinTable(
                name = "user_game_rating",
                joinColumns = [JoinColumn(name = "gameId")],
                inverseJoinColumns = [JoinColumn(name = "userId")]
        )
        var ratedUsers: MutableList<User> = mutableListOf(),



        )