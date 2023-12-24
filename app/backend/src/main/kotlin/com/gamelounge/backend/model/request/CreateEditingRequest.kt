package com.gamelounge.backend.model.request
import com.gamelounge.backend.constant.GameGenre
import com.gamelounge.backend.constant.GamePlatform
import com.gamelounge.backend.constant.NumberOfPlayers
import com.gamelounge.backend.constant.UniverseInfo
import com.gamelounge.backend.constant.GameMechanics

class CreateEditingRequest(
        val gameId: Long = 0,
        val title: String,
        val description: String,
        val genres: List<String>,
        val platforms: List<String>,
        val playerNumber: NumberOfPlayers,
        val releaseYear: Int,
        val universe: UniverseInfo,
        val mechanics: GameMechanics,
        val playtime: String,
        var totalRating: Int,
        var countRating: Int,
        var averageRating: Double,
)