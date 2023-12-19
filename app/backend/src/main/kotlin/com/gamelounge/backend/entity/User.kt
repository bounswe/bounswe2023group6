package com.gamelounge.backend.entity

import jakarta.persistence.*
import lombok.Data
import lombok.NoArgsConstructor
import org.springframework.boot.web.server.Cookie

@Entity
@Table(name = "users")
@NoArgsConstructor
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val userId: Long = 0,

    val username: String = "",
    var email: String = "",
    var profilePicture: String? = null,
    var about: String? = null,
    var title: String? = null,
    var company: String? = null,
    var passwordHash: ByteArray = ByteArray(0),
    var salt: ByteArray = ByteArray(0),
    var isAdmin: Boolean = false, // indicating whether the user is an admin
    var isVisible: Boolean = true, // indicating whether the user is visible to other users
    var isDeleted: Boolean = false, // indicating whether the user is deleted
    var isBanned: Boolean = false, // indicating whether the user is banned

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    val posts: List<Post> = mutableListOf(),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    val games: List<Game> = mutableListOf(),

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    val lfgs: List<LFG> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_post_likes",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "postId")]
    )
    var likedPosts: MutableList<Post> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_post_dislikes",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "postId")]
    )
    var dislikedPosts: MutableList<Post> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_comment_likes",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "commentId")]
    )
    var likedComments: MutableList<Comment> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_comment_dislikes",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "commentId")]
    )
    var dislikedComments: MutableList<Comment> = mutableListOf(),

    @ManyToMany
    @JoinTable(
        name = "user_tags",
        joinColumns = [JoinColumn(name = "userId")],
        inverseJoinColumns = [JoinColumn(name = "tagId")]
    )
    var tags: List<Tag> = mutableListOf(),

    // user can follow other users
    @ManyToMany
    @JoinTable(
            name = "user_follows",
            joinColumns = [JoinColumn(name = "userId")],
            inverseJoinColumns = [JoinColumn(name = "followedUserId")]
    )
    var following: List<User> = mutableListOf(),



    )