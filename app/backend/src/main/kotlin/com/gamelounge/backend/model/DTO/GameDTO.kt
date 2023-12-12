package com.gamelounge.backend.model.DTO

import java.time.Instant
import com.gamelounge.backend.constant.GameGenre
import com.gamelounge.backend.constant.GamePlatform
import com.gamelounge.backend.constant.NumberOfPlayers
import com.gamelounge.backend.constant.UniverseInfo
import com.gamelounge.backend.constant.GameMechanics


data class GameDTO(
        var gameId: Long = 0,
        var title: String = "",
        var description: String = "",
        var genre: GameGenre = GameGenre.EMPTY,
        var platform: GamePlatform = GamePlatform.EMPTY,
        var characters: List<CharacterDTO>,
        var playerNumber: NumberOfPlayers = NumberOfPlayers.EMPTY,
        var releaseYear: Int = 0,
        var universe: UniverseInfo = UniverseInfo.EMPTY,
        var mechanics: GameMechanics = GameMechanics.EMPTY,
        var playtime: String = "",
        var totalRating: Int,
        var countRating: Int,
        var averageRating: Double,
        var creationDate: Instant? = null,
        var tags: List<TagDTO>,
        var gamePicture: String? = null,
        var status: String = "",
)