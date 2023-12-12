package com.gamelounge.backend.constant

enum class GameGenre {
    RPG,
    STRATEGY,
    SHOOTER,
    SPORTS_AND_RACING,
    FIGHTING,
    MOBA,
    EMPTY
}

enum class GamePlatform {
    XBOX,
    COMPUTER,
    PS, // PlayStation
    ONBOARD,
    EMPTY
}

enum class NumberOfPlayers {
    SINGLE,
    TEAMS,
    MULTIPLE,
    MMO, // Massively Multiplayer Online
    EMPTY
}

enum class UniverseInfo {
    MEDIEVAL,
    FANTASY,
    SCIFI,
    CYBERPUNK,
    HISTORICAL,
    CONTEMPORARY,
    POST_APOCALYPTIC,
    ALTERNATE_REALITY,
    EMPTY
}

enum class GameMechanics {
    TURN_BASED,
    CHANCE_BASED,
    EMPTY
    // Add more mechanics as needed
}
