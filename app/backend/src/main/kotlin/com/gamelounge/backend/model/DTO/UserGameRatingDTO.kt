package com.gamelounge.backend.model.DTO

class UserGameRatingDTO (
    var user: UserDTO,
    var game: GameDTO,
    var rating: Int
)

data class UserGameRatingDTO(
    var gameDTO: GameDTO,
    var score: Int
)

