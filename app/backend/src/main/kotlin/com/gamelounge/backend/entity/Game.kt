package com.gamelounge.backend.entity

import com.gamelounge.backend.entity.Character
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.ManyToOne
import com.gamelounge.backend.constant.GameGenre
import com.gamelounge.backend.constant.GamePlatform
import com.gamelounge.backend.constant.NumberOfPlayers
import com.gamelounge.backend.constant.UniverseInfo
import com.gamelounge.backend.constant.GameMechanics

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
        @Enumerated(EnumType.STRING)
        var genre: GameGenre = GameGenre.EMPTY,
        @Enumerated(EnumType.STRING)
        var platform: GamePlatform = GamePlatform.EMPTY,
        @Enumerated(EnumType.STRING)
        var playerNumber: NumberOfPlayers = NumberOfPlayers.EMPTY,
        var releaseYear: Int = 0,
        @Enumerated(EnumType.STRING)
        var universe: UniverseInfo = UniverseInfo.EMPTY,
        @Enumerated(EnumType.STRING)
        var mechanics: GameMechanics = GameMechanics.EMPTY,
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

        /*@ManyToMany
        @JoinTable(
                name = "user_game_rating",
                joinColumns = [JoinColumn(name = "gameId")],
                inverseJoinColumns = [JoinColumn(name = "userId")]
        )
        var ratedUsers: MutableList<User> = mutableListOf(),*/

        )