package com.group6.annotationservice.entity

import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import com.group6.annotationservice.entity.Annotation

@Entity
data class Body(

    @Id
    var id: String = "", // e.g., "http://example.org/anno1/body1"
    var type: String? = "TextualBody", // e.g., "TextualBody" or "Image"
    var value: String? = "", // e.g., "This is an insightful post!"
    var format: String? = null, // e.g., "text/plain"
    var language: String? = null, // e.g., "en"
    var purpose: String? = null, // e.g., "commenting"
    @ManyToOne
    @JoinColumn(name = "annotation_id")
    var annotation : Annotation = Annotation()
)