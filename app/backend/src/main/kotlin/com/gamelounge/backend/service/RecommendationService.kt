package com.gamelounge.backend.service

import com.gamelounge.backend.entity.*
import com.gamelounge.backend.repository.LFGRepository
import com.gamelounge.backend.repository.PostRepository
import kotlinx.coroutines.*
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

    fun getPostsRelatedToGames(games: List<Game>): List<Post> = runBlocking{

        val deferredRecommendedPosts = games.map { game ->
            async(Dispatchers.IO) {postRepository.findByRelatedGame(game)}
        }.awaitAll().flatten().distinct()

        return@runBlocking deferredRecommendedPosts
    }

    fun getLFGsRelatedToGames(games: List<Game>): List<LFG> = runBlocking{

        val deferredRecommendedLFGs = games.map { game ->
            async(Dispatchers.IO) { lfgRepository.findByRelatedGame(game) }
        }.awaitAll().flatten().distinct()

        return@runBlocking deferredRecommendedLFGs
    }

    fun getSimilarGamesBulk(games: List<Game>): List<Game> = runBlocking{

        val deferredRelatedGames = games.map { game ->
            async(Dispatchers.IO) { game.similarGames }
        }.awaitAll().flatten().distinct()

        return@runBlocking deferredRelatedGames
    }

    fun getGameOccurrences(posts: List<Post>): MutableMap<Game, Int>{
        val occurrences: MutableMap<Game, Int> = mutableMapOf()

        posts.forEach {  post ->
            val game = post.relatedGame
            game?.let {occurrences[it] = occurrences.getOrDefault(it, 0) + 1}
        }
        
        return occurrences
    }

    fun getMostFrequentNGames(occurrences: MutableMap<Game, Int>, n: Int): List<Game>{

        val sortedGames = occurrences.entries
            .sortedByDescending { it.value }
            .take(n)
            .map { it.key }

        return sortedGames
    }
}
