package com.group6.annotationservice.entity

import jakarta.persistence.*

@Entity
data class Target(
    @Id
    val id: String ="", // e.g., "http://forum.com/posts/789"
    val format: String? = null, // e.g., "text/html"
    val language: String? = null, // e.g., "en"
    @OneToMany
    @JoinColumn(name = "target_id")
    val selector: List<Selector>? = null, // See Selector class below
    @ManyToOne
    @JoinColumn(name = "annotation_id")
    val annotation : Annotation = Annotation()
)