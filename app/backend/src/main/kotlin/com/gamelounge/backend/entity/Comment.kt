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
    val commentId: Long = 0,

    val content: String = "",
    val creationDate: Instant = Instant.now(),
    val upvotes: Int = 0,
    val downvotes: Int = 0,


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "postId")
    val post: Post? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lfgId")
    val lfg: LFG? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    val user: User? = null
)