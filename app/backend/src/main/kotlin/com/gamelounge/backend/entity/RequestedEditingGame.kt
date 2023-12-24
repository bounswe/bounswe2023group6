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
@Table(name = "requested_editing_games")
@NoArgsConstructor
class RequestedEditingGame(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long = 0,

        val gameId: Long = 0,
        var title: String = "",
        var description: String = "",

        @ElementCollection(targetClass = GameGenre::class)
        @Enumerated(EnumType.STRING)
        @CollectionTable(name = "edited_game_genres", joinColumns = [JoinColumn(name = "gameId")])
        var genres: Set<GameGenre> = emptySet(),

        @ElementCollection(targetClass = GamePlatform::class)
        @Enumerated(EnumType.STRING)
        @CollectionTable(name = "edited_game_platforms", joinColumns = [JoinColumn(name = "gameId")])
        var platforms: Set<GamePlatform> = emptySet(),

        @Enumerated(EnumType.STRING)
        var playerNumber: NumberOfPlayers = NumberOfPlayers.Empty,
        var releaseYear: Int = 0,
        @Enumerated(EnumType.STRING)
        var universe: UniverseInfo = UniverseInfo.Empty,
        @Enumerated(EnumType.STRING)
        var mechanics: GameMechanics = GameMechanics.Empty,
        var playtime: String = "",
        var creationDate: Instant = Instant.now(),
        var gamePicture: String? = null,



        )