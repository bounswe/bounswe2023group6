package com.gamelounge.backend.entity


import jakarta.persistence.Entity
import jakarta.persistence.Id
import jakarta.persistence.Table

@Entity
@Table(name ="users")
class User(
        @Id val username: String,
        val email: String,
        val name: String,
        val surname: String,
        val image: ByteArray? = null,
        var passwordHash: ByteArray,
        var salt: ByteArray,
    ){
    constructor() : this("", "", "", "", null, ByteArray(0), ByteArray(0))

}