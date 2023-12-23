package com.gamelounge.backend.service

import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.LFGDTO
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.response.SearchResults
import com.gamelounge.backend.repository.GameRepository
import com.gamelounge.backend.repository.LFGRepository
import com.gamelounge.backend.repository.PostRepository
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.stereotype.Service

@Service
class SearchService (
    private val postRepository: PostRepository,
    private val lfgRepository: LFGRepository,
    private val gameRepository: GameRepository
){
    fun searchAll(query: String): SearchResults{
        val postDTOs = searchPosts(query)
        val lfgDTOs = searchLFGs(query)
        val gameDTOs = searchGames(query)
        val searchResults = SearchResults(postResults = postDTOs, lfgResults =  lfgDTOs, gameResults = gameDTOs)
        return searchResults
    }
    fun searchPosts(query: String): List<PostDTO> {
        val posts = postRepository.findByTitleContainingOrContentContaining(query, query)
        val postDTOs = ConverterDTO.convertBulkToPostDTO(posts)
        return postDTOs
    }

    fun searchLFGs(query: String): List<LFGDTO> {
        val lfgs = lfgRepository.findByTitleContainingOrDescriptionContaining(query, query)
        val lfgDTOs = ConverterDTO.convertBulkToLFGDTO(lfgs)
        return lfgDTOs
    }

    fun searchGames(query: String): List<GameDTO> {
        val games = gameRepository.findByTitleContainingOrDescriptionContaining(query, query)
        val gameDTOs = ConverterDTO.convertBulkToGameDTO(games)
        return gameDTOs
    }
}