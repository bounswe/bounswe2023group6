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

    var title: String = "",
    var content: String = "",
    var creationDate: Instant = Instant.now(),
    var upvotes: Int = 0,
    var downvotes: Int = 0,
    var totalComments: Int = 0,


    @Enumerated(EnumType.STRING)
    var category: PostCategory = PostCategory.DISCUSSION,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    var user: User? = null,

    @ManyToOne
    @JoinColumn(name = "gameId")
    var relatedGame: Game? = null,

    @OneToMany(mappedBy = "post", cascade = [CascadeType.ALL], orphanRemoval = true)
    var comments: List<Comment> = mutableListOf(),


    @ManyToMany
    @JoinTable(
        name = "post_tags",
        joinColumns = [JoinColumn(name = "postId")],
        inverseJoinColumns = [JoinColumn(name = "tagId")]
    )
    var postTags: List<Tag>? = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_post_likes",
        joinColumns = [JoinColumn(name = "postId")],
        inverseJoinColumns = [JoinColumn(name = "userId")]
    )
    var likedUsers: MutableList<User> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_post_dislikes",
        joinColumns = [JoinColumn(name = "postId")],
        inverseJoinColumns = [JoinColumn(name = "userId")]
    )
    var dislikedUsers: MutableList<User> = mutableListOf(),

    @OneToMany(mappedBy = "reportedPost", cascade = [CascadeType.PERSIST])
    var reports: MutableList<Report> = mutableListOf()
)