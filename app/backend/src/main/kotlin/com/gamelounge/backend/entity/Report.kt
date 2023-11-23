package com.gamelounge.backend.entity

import jakarta.persistence.*
import lombok.NoArgsConstructor

@Entity
@Table(name = "users")
@NoArgsConstructor
class Report(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val reportId: Long = 0,

    val reason: String = "",

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    var reportingUser: User? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "postId")
    var reportedPost: Post? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lfgId")
    var reportedLFG: LFG? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "commentId")
    var reportedComment: Comment? = null
)