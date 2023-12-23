package com.gamelounge.backend.model.DTO

import com.gamelounge.backend.entity.User
import java.time.Instant

data class LFGDTO(
    var lfgId: Long = 0,
    var title: String = "",
    var description: String = "",
    var requiredPlatform: String = "",
    var requiredLanguage: String = "",
    var micCamRequirement: Boolean = true,
    var memberCapacity: Int = 0,
    var creationDate: Instant = Instant.now(),
    var user: UserDTO? = null,
    var relatedGame: GameDTO? = null,
    var tags: List<TagDTO> = mutableListOf()
)