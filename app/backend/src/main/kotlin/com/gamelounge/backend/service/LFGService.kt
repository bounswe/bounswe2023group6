package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.LFG
import com.gamelounge.backend.exception.SessionNotFoundException
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.model.DTO.LFGDTO
import com.gamelounge.backend.repository.LFGRepository
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.ConverterDTO.convertBulkToLFGDTO
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class LFGService(
    private val userRepository: UserRepository,
    private val recommendationService: RecommendationService,
    private val lfgRepository: LFGRepository,
    private val sessionAuth: SessionAuth
) {
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
}