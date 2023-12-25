package com.group6.annotationservice.entity

import jakarta.persistence.DiscriminatorValue
import jakarta.persistence.Entity

@Entity
@DiscriminatorValue("FragmentSelector")
data class FragmentSelector(
    override val type: String = "FragmentSelector",
    val value: String = "xywh=,,,", // e.g., "annotea is awesome"

) : Selector()