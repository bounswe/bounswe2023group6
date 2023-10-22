package com.gamelounge.backend.service


import com.gamelounge.backend.model.RegisterationRequest
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.HashingUtil.generateHash
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.exception.UsernameAlreadyExistException
import org.springframework.stereotype.Service

@Service
class AccessService (
    val userRepository: UserRepository
){

    fun register(request: RegisterationRequest){
        // Encrypt the password
        val (passwordHash, salt) = generateHash(request.password)

        // Save the data to database
        if (userRepository.existsByUsername(request.username)){
            throw UsernameAlreadyExistException("The username already exists!")
        }
        userRepository.save(User(request.username, request.email, request.name, request.surname, request.image, passwordHash, salt))
    }
}