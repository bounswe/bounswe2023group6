package com.gamelounge.backend.model.DTO

data class UserGameRatingDTO(
    var gameDTO: GameDTO,
    var score: Int
)
