package com.gamelounge.backend.model.DTO

data class GameDTO(
    var gameId: Long = 0,
    var title: String = "",
    var description: String = "",
    var genre: String = "",
    var platform: String = "",
    var avatarDetails: String = "", // Consider a more complex structure
    var playerNumber: String = "",
    var releaseYear: Int = 0,
    var universe: String = "",
    var mechanics: String = "",
    var playtime: String = "",
    var mapInformation: String = "",
    var tags: List<TagDTO>
)