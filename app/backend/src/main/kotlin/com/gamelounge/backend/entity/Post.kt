package com.gamelounge.backend.entity
import jakarta.persistence.*
import lombok.NoArgsConstructor
import java.time.Instant
enum class PostCategory {
    GUIDE, REVIEW, DISCUSSION
}
@Entity
@Table(name = "posts")
@NoArgsConstructor
class Post(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var postId: Long = 0,

    var content: String = "",
    var creationDate: Instant = Instant.now(),
    var upvotes: Int = 0,
    var downvotes: Int = 0,

    @Enumerated(EnumType.STRING)
    var category: PostCategory = PostCategory.DISCUSSION,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    var user: User? = null,

    @OneToMany(mappedBy = "post", cascade = [CascadeType.ALL], orphanRemoval = true)
    var comments: List<Comment> = mutableListOf(),

    @ManyToOne
    @JoinColumn(name = "gameId")
    var relatedGame: Game? = null
)