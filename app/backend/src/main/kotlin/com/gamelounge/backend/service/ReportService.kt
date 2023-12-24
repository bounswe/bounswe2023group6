package com.gamelounge.backend.service

import com.gamelounge.backend.entity.Report
import com.gamelounge.backend.exception.UnauthorizedGameAccessException
import com.gamelounge.backend.exception.UnauthorizedReportsAccessException
import com.gamelounge.backend.exception.UserNotFoundException
import com.gamelounge.backend.middleware.SessionAuth
import com.gamelounge.backend.repository.ReportRepository
import com.gamelounge.backend.repository.UserRepository
import org.springframework.stereotype.Service
import java.util.*

@Service
class ReportService(
    private val reportRepository: ReportRepository,
    private val sessionAuth: SessionAuth,
    private val userRepository: UserRepository
) {
    fun getAllGameReports(sessionId: UUID): List<Report> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }
        if (!user.isAdmin) {
            throw UnauthorizedReportsAccessException("User is not an admin")
        }
        return reportRepository.findByReportedGameIsNotNull()
    }
    fun getAllPostReports(sessionId: UUID): List<Report> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }
        if (!user.isAdmin) {
            throw UnauthorizedReportsAccessException("User is not an admin")
        }
        return reportRepository.findByReportedPostIsNotNull()
    }
    fun getAllCommentReports(sessionId: UUID): List<Report> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }
        if (!user.isAdmin) {
            throw UnauthorizedReportsAccessException("User is not an admin")
        }
        return reportRepository.findByReportedCommentIsNotNull()
    }
    fun getAllLFGReports(sessionId: UUID): List<Report> {
        val userId = sessionAuth.getUserIdFromSession(sessionId)
        val user = userRepository.findById(userId).orElseThrow { UserNotFoundException("User not found") }
        if (!user.isAdmin) {
            throw UnauthorizedReportsAccessException("User is not an admin")
        }
        return reportRepository.findByReportedLFGIsNotNull()
    }
}