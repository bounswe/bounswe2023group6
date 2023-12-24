package com.gamelounge.backend.service

import com.gamelounge.backend.entity.*
import com.gamelounge.backend.repository.LFGRepository
import com.gamelounge.backend.repository.PostRepository
import org.springframework.stereotype.Service


@Service
class RecommendationService(
    private val postRepository: PostRepository,
    private val lfgRepository: LFGRepository
){
    fun getRecommendedPosts(user: User): List<Post> {
        val recommendedGames = getRecommendedGames(user)

        return getPostsRelatedToGames(recommendedGames)
    }

    fun getRecommendedLFGs(user: User): List<LFG>{
        val recommendedGames = getRecommendedGames(user)

        return getLFGsRelatedToGames(recommendedGames)
    }

    fun getRecommendedGames(user: User): List<Game> {
        val likedPosts = user.likedPosts
        val mostFrequentGamesInPosts = getMostFrequentGamesInPosts(likedPosts)

        return getSimilarGamesBulk(mostFrequentGamesInPosts)
    }

    fun getMostFrequentGamesInPosts(posts: List<Post>): List<Game>{
        val mostFrequentGames: List<Game>

        val gameOccurrences = getGameOccurrences(posts)
        mostFrequentGames = getMostFrequentNGames(gameOccurrences, 5)

        return mostFrequentGames
    }

    fun getPostsRelatedToGames(games: List<Game>): List<Post>{

        val recommendedPosts = games.map { game ->
            postRepository.findByRelatedGame(game)
        }.flatten().distinct()

        return recommendedPosts
    }

    fun getLFGsRelatedToGames(games: List<Game>): List<LFG>{

        val recommendedLFGs = games.map { game ->
             lfgRepository.findByRelatedGame(game)
        }.flatten().distinct()

        return recommendedLFGs
    }

    fun getSimilarGamesBulk(games: List<Game>): List<Game>{

        val similarGames = games.map { game ->
             game.similarGames
        }.flatten().distinct().toMutableList()

        games.forEach { similarGames.add(it) }

        return similarGames
    }

    fun getGameOccurrences(posts: List<Post>): MutableMap<Game, Int>{
        val occurrences: MutableMap<Game, Int> = mutableMapOf()

        posts.forEach {  post ->
            val game = post.relatedGame
            game?.let {occurrences[it] = occurrences.getOrDefault(it, 0) + 1}
        }
        return occurrences
    }

    fun getMostFrequentNGames(occurrences: MutableMap<Game, Int>, n: Int): List<Game> {
        return occurrences.entries
            .sortedByDescending { it.value }
            .take(n)
            .map { it.key }
    }
}
