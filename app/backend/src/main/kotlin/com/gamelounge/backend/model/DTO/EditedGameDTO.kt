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
        val genres: List<GameGenre>,
        val platforms: List<GamePlatform>,
        var playerNumber: NumberOfPlayers = NumberOfPlayers.Empty,
        var releaseYear: Int = 0,
        var universe: UniverseInfo = UniverseInfo.Empty,
        var mechanics: GameMechanics = GameMechanics.Empty,
        var playtime: String = "",
        var creationDate: Instant? = null,
        var gamePicture: String? = null,
)