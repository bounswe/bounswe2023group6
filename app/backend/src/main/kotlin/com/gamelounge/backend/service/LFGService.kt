package com.gamelounge.backend.service

import com.gamelounge.backend.util.ConverterDTO.convertBulkToLFGDTO  
import com.gamelounge.backend.model.DTO.LFGDTO
import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.LFG
import com.gamelounge.backend.exception.*
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.request.CreateLFGRequest
import com.gamelounge.backend.model.request.UpdateLFGRequest
import com.gamelounge.backend.repository.LFGRepository
import com.gamelounge.backend.repository.UserRepository
import org.springframework.stereotype.Service
import java.util.*

@Service
class LFGService(
    private val sessionAuth: SessionAuth,
    private val userRepository: UserRepository,
    private val recommendationService: RecommendationService,
    private val lfgRepository: LFGRepository,
    private val gameService: GameService,
    private val tagService: TagService
) {
    fun createLFG(sessionId: UUID, lfg: CreateLFGRequest): LFG {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UsernameNotFoundException("User not found") }
        val newLFG = LFG(
            title = lfg.title,
            description = lfg.description,
            requiredPlatform = lfg.requiredPlatform,
            requiredLanguage = lfg.requiredLanguage,
            micCamRequirement = lfg.micCamRequirement,
            memberCapacity = lfg.memberCapacity,
            user = user,
            relatedGame = lfg.gameId?.let { gameService.getGame(it) },
            tags = tagService.createAndReturnTagsFromTagNames(lfg.tags) ?: emptyList()
        )
        newLFG.members = newLFG.members.plus(user)
        newLFG.totalMembers += 1
        return lfgRepository.save(newLFG)
    }

    fun getLFG(lfgId: Long): LFG {
        return lfgRepository.findById(lfgId).orElseThrow { LFGNotFoundException("LFG not found with ID: $lfgId") }
    }

    fun updateLFG(sessionId: UUID, lfgId: Long, updatedLFG: UpdateLFGRequest): LFG {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val lfg = getLFG(lfgId)

        if (lfg.user?.userId != userId) {
            throw UnauthorizedLFGAccessException("Unauthorized to update LFG with ID: $lfgId")
        }

        lfg.title = updatedLFG.title ?: lfg.title
        lfg.description = updatedLFG.description ?: lfg.description
        lfg.requiredPlatform = updatedLFG.requiredPlatform ?: lfg.requiredPlatform
        lfg.requiredLanguage = updatedLFG.requiredLanguage ?: lfg.requiredLanguage
        lfg.micCamRequirement = updatedLFG.micCamRequirement ?: lfg.micCamRequirement
        lfg.memberCapacity = updatedLFG.memberCapacity ?: lfg.memberCapacity
        lfg.relatedGame = updatedLFG.gameId?.let { gameService.getGame(it) } ?: lfg.relatedGame
        lfg.tags = updatedLFG.tags?.let { tagService.createAndReturnTagsFromTagNames(it) } ?: lfg.tags

        return lfgRepository.save(lfg)
    }

    fun deleteLFG(sessionId: UUID, lfgId: Long) {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val lfg = getLFG(lfgId)

        if (lfg.user?.userId != userId) {
            throw UnauthorizedLFGAccessException("Unauthorized to delete LFG with ID: $lfgId")
        }
        lfgRepository.delete(lfg)

    }
    
    fun getRecommendedLFGs(sessionId: UUID?): List<LFGDTO>{
        var LFGDTOs = convertBulkToLFGDTO(getAllLFGs())

        sessionId?.let {
            LFGDTOs = try{
                val userId = sessionAuth.getUserIdFromSession(sessionId)
                val user = userRepository.findByUserId(userId)
                convertBulkToLFGDTO(recommendationService.getRecommendedLFGs(user!!))
            }catch (e: SessionNotFoundException){
                convertBulkToLFGDTO(getAllLFGs())
            }
        }

        return LFGDTOs
    }

    fun getAllLFGs(): List<LFG> {
        return lfgRepository.findAll()
    }
   
    fun getLFGsByGame(game: Game): List<LFG>{
        return lfgRepository.findByRelatedGame(game)
    }
    fun joinLFG(sessionId: UUID, lfgId: Long): LFG {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val lfg = getLFG(lfgId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }

        if (lfg.members.contains(user)) {
            throw UnauthorizedLFGAccessException("User is already a member of LFG with ID: $lfgId")
        }
        if(lfg.totalMembers == lfg.memberCapacity){
            throw LFGisFullException("LFG with ID: $lfgId is full")
        }

        lfg.members = lfg.members.plus(user)
        lfg.totalMembers += 1

        return lfgRepository.save(lfg)
    }
    fun leaveLFG(sessionId: UUID, lfgId: Long): LFG {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val lfg = getLFG(lfgId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }

        if (!lfg.members.contains(user)) {
            throw LFGAlreadyLeftException("User is not a member of LFG with ID: $lfgId")
        }

        lfg.members = lfg.members.minus(user)
        lfg.totalMembers -= 1

        return lfgRepository.save(lfg)
    }
    fun kickUserFromLFG(sessionId: UUID, lfgId: Long, kickUserId: Long): LFG {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val lfg = getLFG(lfgId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }
        val kickUser = userRepository.findById(kickUserId).orElseThrow { UserNotFoundException("User not found") }

        if (lfg.user?.userId != userId) {
            throw UnauthorizedLFGAccessException("Unauthorized to kick user from LFG with ID: $lfgId")
        }
        if (!lfg.members.contains(kickUser)) {
            throw LFGAlreadyLeftException("User is not a member of LFG with ID: $lfgId")
        }

        lfg.members = lfg.members.minus(kickUser)
        lfg.totalMembers -= 1

        return lfgRepository.save(lfg)
    }

}
