package com.gamelounge.backend.controller

import com.gamelounge.backend.model.DTO.*
import com.gamelounge.backend.model.response.ResponseMessage
import com.gamelounge.backend.service.GameService
import com.gamelounge.backend.service.PostService
import com.gamelounge.backend.service.ReportService
import com.gamelounge.backend.service.UserService
import com.gamelounge.backend.util.ConverterDTO
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
class AdminController(
        val gameService: GameService,
        val postService: PostService,
        val userService: UserService,
        val reportService: ReportService
) {

    @GetMapping("/admin/pendingGames")
    fun getPendingGames(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<GameDTO>> {
        val game = gameService.getPendingGames(sessionId)
        val gameDTO = ConverterDTO.convertBulkToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @GetMapping("/admin/editedGames")
    fun getEditedGames(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<EditedGameDTO>> {
        val editedGame = gameService.getEditedGames(sessionId)
        val editedGameDTO = ConverterDTO.convertBulkToEditedGameDTO(editedGame)
        return ResponseEntity.ok(editedGameDTO)
    }

    @PutMapping("/admin/approveEditingGame/{editingGameId}")
    fun approveEditingGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable editingGameId: Long): ResponseEntity<GameDTO> {
        val game = gameService.approveEditingGame(sessionId, editingGameId)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @PutMapping("/admin/rejectEditingGame/{editingGameId}")
    fun rejectEditingGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable editingGameId: Long): ResponseEntity<GameDTO> {
        val game = gameService.rejectEditingGame(sessionId, editingGameId)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @PutMapping("/admin/approveGame/{gameId}")
    fun approveGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable gameId: Long): ResponseEntity<GameDTO> {
        val game = gameService.approveGame(sessionId, gameId)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @PutMapping("/admin/rejectGame/{gameId}")
    fun rejectGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable gameId: Long): ResponseEntity<GameDTO> {
        val game = gameService.rejectGame(sessionId, gameId)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @GetMapping("/admin/reportedGames")
    fun getReportedGames(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<GameDTO>> {
        val game = gameService.getReportedGames(sessionId)
        val gameDTO = ConverterDTO.convertBulkToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @PutMapping("/admin/banUser/game/{gameId}")
    fun banUserForGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable gameId: Long): ResponseEntity<UserDTO> {
        val user = userService.banUserForGame(sessionId, gameId)
        val userDTO = ConverterDTO.convertToUserDTO(user)
        return ResponseEntity.ok(userDTO)
    }

    @PutMapping("/admin/delete/game/{gameId}")
    fun deleteReportedGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable gameId: Long): ResponseEntity<GameDTO> {
        val game = userService.deleteReportedGame(sessionId, gameId)
        val gameDTO = ConverterDTO.convertToGameDTO(game)
        return ResponseEntity.ok(gameDTO)
    }

    @PutMapping("/admin/cancel/game/{gameId}")
    fun cancelReportedGame(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable gameId: Long): ResponseEntity<ResponseMessage> {
        userService.cancelReportedGame(sessionId, gameId)
        return ResponseEntity.ok(ResponseMessage(message = "Reported game cancelled successfully"))
    }

    @PutMapping("/admin/delete/post/{postId}")
    fun deleteReportedPost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable postId: Long): ResponseEntity<ResponseMessage> {
        userService.deleteReportedPost(sessionId, postId)
        return ResponseEntity.ok(ResponseMessage(message = "Reported post deleted successfully"))
    }

    @PutMapping("/admin/cancel/post/{postId}")
    fun cancelReportedPost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable postId: Long): ResponseEntity<ResponseMessage> {
        userService.cancelReportedPost(sessionId, postId)
        return ResponseEntity.ok(ResponseMessage(message = "Reported post cancelled successfully"))
    }

    @GetMapping("/admin/reportedPosts")
    fun getReportedPosts(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<PostDTO>> {
        val post = postService.getReportedPosts(sessionId)
        val postDTO = ConverterDTO.convertBulkToPostDTO(post)
        return ResponseEntity.ok(postDTO)
    }

    @PutMapping("/admin/banUser/post/{postId}")
    fun banUserForPost(@CookieValue("SESSIONID") sessionId: UUID, @PathVariable postId: Long): ResponseEntity<UserDTO> {
        val user = userService.banUserForPost(sessionId, postId)
        val userDTO = ConverterDTO.convertToUserDTO(user)
        return ResponseEntity.ok(userDTO)
    }
    @GetMapping("/admin/all-game-reports")
    fun getAllGameReports(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<ReportDTO>> {
        val reports = reportService.getAllGameReports(sessionId)
        val reportDTO = ConverterDTO.convertBulkToReportDTO(reports)
        return ResponseEntity.ok(reportDTO)
    }
    @GetMapping("/admin/all-post-reports")
    fun getAllPostReports(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<ReportDTO>> {
        val reports = reportService.getAllPostReports(sessionId)
        val reportDTO = ConverterDTO.convertBulkToReportDTO(reports)
        return ResponseEntity.ok(reportDTO)
    }
    @GetMapping("/admin/all-lfg-reports")
    fun getAllLFGReports(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<ReportDTO>> {
        val reports = reportService.getAllLFGReports(sessionId)
        val reportDTO = ConverterDTO.convertBulkToReportDTO(reports)
        return ResponseEntity.ok(reportDTO)
    }
    @GetMapping("/admin/all-comment-reports")
    fun getAllCommentReports(@CookieValue("SESSIONID") sessionId: UUID): ResponseEntity<List<ReportDTO>> {
        val reports = reportService.getAllCommentReports(sessionId)
        val reportDTO = ConverterDTO.convertBulkToReportDTO(reports)
        return ResponseEntity.ok(reportDTO)
    }
}