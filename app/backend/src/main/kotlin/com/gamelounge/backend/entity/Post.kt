package com.gamelounge.backend.entity
import jakarta.persistence.*
import lombok.NoArgsConstructor
import java.time.Instant

@Entity
@Table(name = "posts")
class Post(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val postId: Long? = null,

    val content: String = "",
    val creationDate: Instant = Instant.now(),
    val upvotes: Int = 0,
    val downvotes: Int = 0,
    val tags: String? = "",
    val category: String = "",
    val relatedGamePage: String? = "",
    val annotations: String? = "",

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    val user: User? = null,

    @OneToMany(mappedBy = "post", cascade = arrayOf(CascadeType.ALL), orphanRemoval = true)
    val comments: List<Comment> = mutableListOf()
)