package com.gamelounge.backend.controller

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.LFG
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.model.DTO.GameDTO
import com.gamelounge.backend.model.DTO.LFGDTO
import com.gamelounge.backend.model.DTO.PostDTO
import com.gamelounge.backend.model.response.SearchResults
import com.gamelounge.backend.service.SearchService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/search")
class SearchController(private val searchService: SearchService) {
    @GetMapping("/all")
    fun searchAll(@RequestParam("query") query: String): SearchResults {
        return searchService.searchAll(query)
    }
    @GetMapping("/posts")
    fun searchPosts(@RequestParam("query") query: String): List<PostDTO> {
        return searchService.searchPosts(query)
    }
    @GetMapping("/lfgs")
    fun searchLFGs(@RequestParam("query") query: String): List<LFGDTO> {
        return searchService.searchLFGs(query)
    }
    @GetMapping("/games")
    fun searchGames(@RequestParam("query") query: String): List<GameDTO> {
        return searchService.searchGames(query)
    }

}