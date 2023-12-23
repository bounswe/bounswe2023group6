package com.gamelounge.backend.model.DTO

data class ReportDTO(
    val reportId: Long = 0,
    val reason: String = "",
    var reportingUser: UserDTO,
    var reportedPost: PostDTO? = null,
    var reportedGame: GameDTO? = null,
    var reportedLFG: LFGDTO? = null,
    var reportedComment: CommentDTO? = null
)