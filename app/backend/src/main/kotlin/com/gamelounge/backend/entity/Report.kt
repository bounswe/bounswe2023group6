package com.gamelounge.backend.entity

import jakarta.persistence.*
import lombok.NoArgsConstructor
import org.hibernate.annotations.ColumnTransformer

@Entity
@Table(name = "reports")
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
    @JoinColumn(name = "gameId")
    var reportedGame: Game? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lfgId")
    var reportedLFG: LFG? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "commentId")
    var reportedComment: Comment? = null,

    @Column(name = "reported_object", columnDefinition = "json")
    @Basic(fetch = FetchType.LAZY)
    @ColumnTransformer(read = "reported_object::json", write = "?::json")
    var reportedObject: String? = null

)