package com.gamelounge.backend.model.DTO

import java.time.Instant
import com.gamelounge.backend.constant.GameGenre
import com.gamelounge.backend.constant.GamePlatform
import com.gamelounge.backend.constant.NumberOfPlayers
import com.gamelounge.backend.constant.UniverseInfo
import com.gamelounge.backend.constant.GameMechanics


data class EditedGameDTO(
        var gameId: Long = 0,
        var title: String = "",
        var description: String = "",
        var genre: GameGenre = GameGenre.EMPTY,
        var platform: GamePlatform = GamePlatform.EMPTY,
        var playerNumber: NumberOfPlayers = NumberOfPlayers.EMPTY,
        var releaseYear: Int = 0,
        var universe: UniverseInfo = UniverseInfo.EMPTY,
        var mechanics: GameMechanics = GameMechanics.EMPTY,
        var playtime: String = "",
        var creationDate: Instant? = null,
        var gamePicture: String? = null,
)