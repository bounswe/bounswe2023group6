package com.group6.annotationservice.repository

import com.group6.annotationservice.entity.Target
import org.springframework.data.jpa.repository.JpaRepository

interface TargetRepository : JpaRepository<Target, String> {

}