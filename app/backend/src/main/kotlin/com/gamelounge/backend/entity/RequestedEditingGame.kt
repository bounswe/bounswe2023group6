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
        var creationDate: Instant = Instant.now(),
        var gamePicture: String? = null,
)