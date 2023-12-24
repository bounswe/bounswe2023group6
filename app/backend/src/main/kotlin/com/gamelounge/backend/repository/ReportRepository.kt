package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Game
import com.gamelounge.backend.entity.Post
import com.gamelounge.backend.entity.Report
import com.gamelounge.backend.entity.User
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ReportRepository : JpaRepository<Report, Long>{
    fun findByReportingUser(user: User): List<Report>
    fun findByReportedGame(game: Game): List<Report>
    fun findByReportedPost(post: Post): List<Report>
}
