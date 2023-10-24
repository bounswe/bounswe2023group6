package com.gamelounge.backend.util

import com.gamelounge.backend.constant.HashingConstants
import java.security.SecureRandom
import java.security.spec.KeySpec
import java.util.*
import javax.crypto.SecretKey
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.PBEKeySpec

object HashingUtil {
    private fun generateRandomSalt(): ByteArray {
        val random = SecureRandom()
        val salt = ByteArray(16)
        random.nextBytes(salt)
        return salt
    }

    private fun ByteArray.toHexString(): String =
        HexFormat.of().formatHex(this)

    fun generateHash(password: String, salt: ByteArray = generateRandomSalt()): Pair<ByteArray, ByteArray> {

        val factory: SecretKeyFactory = SecretKeyFactory.getInstance(HashingConstants.ALGORITHM)
        val spec: KeySpec = PBEKeySpec(password.toCharArray(), salt, HashingConstants.ITERATIONS, HashingConstants.KEY_LENGTH)
        val key: SecretKey = factory.generateSecret(spec)
        val hash: ByteArray = key.encoded

        return Pair(hash, salt)
    }
}