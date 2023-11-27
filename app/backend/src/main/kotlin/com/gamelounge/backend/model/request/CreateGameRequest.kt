package com.gamelounge.backend.model.request

class CreateGameRequest(
        val title: String,
        val description: String,
        val genre: String,
        val platform: String,
        val playerNumber: String,
        val releaseYear: Int,
        val universe: String,
        val mechanics: String,
        val playtime: String,
        var totalRating: Int,
        var countRating: Int,
        var averageRating: Double,
)