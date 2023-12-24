package com.group6.annotationservice.entity

import jakarta.persistence.*
import lombok.Data
import lombok.NoArgsConstructor
import java.time.LocalDateTime
@Entity
@NoArgsConstructor
@Data
data class Annotation(
    val context: String = "http://www.w3.org/ns/anno.jsonld",
    @Id
    val id: String = "",
    val type: String = "Annotation",
    val created: LocalDateTime? = LocalDateTime.now(),
    val creator: String? = null,
    @OneToMany(cascade = [CascadeType.ALL], orphanRemoval = true)
    @JoinColumn(name = "annotation_id")
    val motivation: List<Motivation>? = null, // i.e. listOf("commenting", "tagging")
    @OneToMany(mappedBy = "annotation",cascade = [CascadeType.ALL], orphanRemoval = true)
    var body: List<Body>? = null,
    @OneToMany(mappedBy = "annotation",cascade = [CascadeType.ALL], orphanRemoval = true)
    var target: List<Target> = ArrayList()
)