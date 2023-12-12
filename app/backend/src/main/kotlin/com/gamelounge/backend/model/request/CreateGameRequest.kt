package com.gamelounge.backend.model.request
import com.gamelounge.backend.constant.GameGenre
import com.gamelounge.backend.constant.GamePlatform
import com.gamelounge.backend.constant.NumberOfPlayers
import com.gamelounge.backend.constant.UniverseInfo
import com.gamelounge.backend.constant.GameMechanics

class CreateGameRequest(
        val title: String,
        val description: String,
        val genre: GameGenre,
        val platform: GamePlatform,
        val playerNumber: NumberOfPlayers,
        val releaseYear: Int,
        val universe: UniverseInfo,
        val mechanics: GameMechanics,
        val playtime: String,
        var totalRating: Int,
        var countRating: Int,
        var averageRating: Double,
)