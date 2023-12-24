package com.gamelounge.backend.model.DTO

class UserGameRatingDTO (
    var user: UserDTO,
    var game: GameDTO,
    var rating: Int
)