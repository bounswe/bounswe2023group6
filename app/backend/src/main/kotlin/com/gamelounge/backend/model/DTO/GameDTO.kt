package com.gamelounge.backend.model.DTO

import java.time.Instant

data class GameDTO(
        var gameId: Long = 0,
        var title: String = "",
        var description: String = "",
        var genre: String = "",
        var platform: String = "",
        var characters: List<CharacterDTO>,
        var playerNumber: String = "",
        var releaseYear: Int = 0,
        var universe: String = "",
        var mechanics: String = "",
        var playtime: String = "",
        var totalRating: Int,
        var countRating: Int,
        var averageRating: Double,
        var creationDate: Instant? = null,
        var tags: List<TagDTO>,
        var gamePicture: String? = null,
        var status: String = "",
)