package com.gamelounge.backend.model.DTO

data class UserGameRatingDTO(
    var user: UserDTO,
    var gameDTO: GameDTO,
    var score: Int
)

