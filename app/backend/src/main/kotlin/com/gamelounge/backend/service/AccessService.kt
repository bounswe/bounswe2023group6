package com.gamelounge.backend.service


import com.gamelounge.backend.model.RegisterationRequest
import com.gamelounge.backend.util.HashingUtil.generateHash
import org.springframework.stereotype.Service



@Service
class AccessService {

    fun register(request: RegisterationRequest){
        // Encrypt the password
        val (hash, salt) = generateHash(request.password)

        // Save the data to database

    }



}