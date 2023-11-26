package com.gamelounge.backend.repository

import com.gamelounge.backend.entity.Report
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ReportRepository : JpaRepository<Report, Long>