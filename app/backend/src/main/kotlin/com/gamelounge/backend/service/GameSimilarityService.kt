package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.repository.GameRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.runBlocking
import org.springframework.stereotype.Service

@Service
class GameSimilarityService(
    private val gameRepository: GameRepository
) {


    fun updateAllSimilarGamesFields(){
        val allGames = gameRepository.findAll()

        allGames.forEach { game ->
            updateSimilarGamesField(game, allGames)
            gameRepository.save(game)
        }
    }

    fun updateSimilarGamesField(game: Game){ // This could be wrong
        val allGames = gameRepository.findAll()
        val similarGames = getSimilarGames(game, allGames)

        game.similarGames = similarGames
    }

    fun updateSimilarGamesField(game: Game, allGames: List<Game>){ // This could be wrong
        val similarGames = getSimilarGames(game, allGames)

        game.similarGames = similarGames
    }

    fun getSimilarGames(referenceGame: Game, allGames: List<Game>): List<Game>{
        val similarityMap = allGames
            .filter { it != referenceGame }
            .map { game -> game to calculateJaccardSimilarity(referenceGame, game) }
            .sortedByDescending { it.second }

        return similarityMap.take(7).map { it.first }
    }

    fun calculateJaccardSimilarity(referenceGame: Game, targetGame: Game): Int {
        val game1FieldValues = getFieldValuesAsSet(referenceGame)
        val game2FieldValues = getFieldValuesAsSet(targetGame)

        return game1FieldValues.intersect(game2FieldValues).size
    }

    fun getFieldValuesAsSet(game: Game): HashSet<String>{
        val valuesSet = hashSetOf<String>()

        valuesSet.addAll(game.genres.map { it.name })
        valuesSet.addAll(game.platforms.map { it.name })
        valuesSet.add(game.playerNumber.name)
        valuesSet.add(game.universe.name)
        valuesSet.add(game.mechanics.name)

        return valuesSet
    }
}