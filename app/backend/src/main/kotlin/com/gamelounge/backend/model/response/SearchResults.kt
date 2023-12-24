package com.gamelounge.backend.model.response

import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.LFGDTO
import com.gamelounge.backend.model.DTO.PostDTO

data class SearchResults (
    val postResults: List<PostDTO>? = emptyList(),
    val lfgResults: List<LFGDTO>? = emptyList(),
    val gameResults: List<GameDTO>? = emptyList()

)