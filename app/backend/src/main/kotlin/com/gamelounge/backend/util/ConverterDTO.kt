package com.gamelounge.backend.util

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.LFG
import com.gamelounge.backend.entity.Tag
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.LFGDTO
import com.gamelounge.backend.model.DTO.TagDTO
import com.gamelounge.backend.model.DTO.UserDTO

object ConverterDTO {
    fun convertToUserDTO(user: User): UserDTO {
        return UserDTO(
            userId = user.userId,
            username = user.username,
            email = user.email,
            profilePicture = user.profilePicture,
            about = user.about,
            title = user.title,
            company = user.company,
            tags = convertBulkToTagDTO(user.tags)
        )
    }

    fun convertToTagDTO(tag: Tag): TagDTO{
        return TagDTO(
            tagId = tag.tagId,
            name = tag.name
        )
    }

    fun convertBulkToTagDTO(tags: List<Tag>): List<TagDTO>{
        return tags.map{tag -> convertToTagDTO(tag)}
    }

    fun convertToLFGDTO(lfg: LFG): LFGDTO{
        return LFGDTO(
            lfg.lfgId,
            lfg.title,
            lfg.description,
            lfg.requiredPlatform,
            lfg.requiredLanguage,
            lfg.micCamRequirement,
            lfg.memberCapacity,
            lfg.creationDate,
            lfg.user,
            lfg.relatedGame?.let { convertToGameDTO(it) },
            convertBulkToTagDTO(lfg.tags)
        )
    }

    fun convertBulkToLFGDTO(lfgs: List<LFG>): List<LFGDTO>{
        return lfgs.map { lfg -> convertToLFGDTO(lfg) }
    }

    fun convertToGameDTO(game: Game): GameDTO{
        return GameDTO(
            game.gameId,
            game.title,
            game.description,
            game.genre,
            game.platform,
            game.avatarDetails,
            game.playerNumber,
            game.releaseYear,
            game.universe,
            game.mechanics,
            game.playtime,
            game.mapInformation,
            convertBulkToTagDTO(game.tags)
        )
    }

    fun convertBulkToGameDTO(games: List<Game>): List<GameDTO>{
        return games.map { game -> convertToGameDTO(game) }
    }



}