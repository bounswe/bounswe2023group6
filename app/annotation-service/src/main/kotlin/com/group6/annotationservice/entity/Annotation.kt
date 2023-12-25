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

    @ManyToMany(cascade = [CascadeType.ALL])
    val motivation: List<Motivation>? = null, // i.e. listOf("commenting", "tagging")

    @ManyToMany(cascade = [CascadeType.ALL])
    var body: List<Body>? = null,

    @ManyToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "target_id")
    var target: Target? = null,

    @ManyToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "selector_id")
    var selector: Selector? = null


)