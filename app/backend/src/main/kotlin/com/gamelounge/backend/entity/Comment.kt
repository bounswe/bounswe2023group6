package com.gamelounge.backend.entity
import jakarta.persistence.*
import lombok.NoArgsConstructor
import java.time.Instant

@Entity
@Table(name = "comments")
@NoArgsConstructor
class Comment(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var commentId: Long = 0,

    var content: String = "",
    var creationDate: Instant = Instant.now(),
    var upvotes: Int = 0,
    var downvotes: Int = 0,


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "postId")
    var post: Post? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lfgId")
    var lfg: LFG? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    var user: User? = null
)