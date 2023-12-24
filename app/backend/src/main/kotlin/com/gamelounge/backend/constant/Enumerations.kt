package com.gamelounge.backend.constant

enum class GameGenre {
    RGP,
    Strategy,
    Shooter,
    Sports,
    Fighting,
    MOBA,
    Action,
    Adventure,
    Simulation,
    Horror,
    Empty
}

enum class GamePlatform {
    XBOX,
    Computer,
    PS, // PlayStation
    Onboard,
    Mobile,
    Empty
}

enum class NumberOfPlayers {
    Single,
    Teams,
    Multiplayer,
    MMO, // Massively Multiplayer Online
    Empty
}

enum class UniverseInfo {
    Medieval,
    Fantasy,
    SciFi,
    Cyberpunk,
    Historical,
    Contemporary,
    PostApocalyptic,
    AlternateReality,
    Empty
}

enum class GameMechanics {
    TurnBased,
    ChangeBased,
    RealTime,
    Empty
    // Add more mechanics as needed
}
