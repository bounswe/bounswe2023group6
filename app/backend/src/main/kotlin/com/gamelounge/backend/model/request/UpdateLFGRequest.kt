package com.gamelounge.backend.model.request

class UpdateLFGRequest(
    val title: String?,
    val description: String?,
    val requiredPlatform: String?,
    val requiredLanguage: String?,
    val micCamRequirement: Boolean?,
    val memberCapacity: Int?,
    val gameId: Long?,
    val tags: List<String>?
)