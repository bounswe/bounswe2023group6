package com.gamelounge.backend

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import org.springframework.web.servlet.config.annotation.CorsRegistry
import org.springframework.context.event.EventListener
import org.springframework.context.event.ContextRefreshedEvent
import com.gamelounge.backend.entity.User
import com.gamelounge.backend.repository.UserRepository
import com.gamelounge.backend.util.HashingUtil

@SpringBootApplication
class BackendApplication (val userRepository: UserRepository){
	@Bean
	fun corsFilter(): WebMvcConfigurer {
		return object : WebMvcConfigurer {
			override fun addCorsMappings(registry: CorsRegistry) {
				registry.addMapping("/**")
					.allowedOrigins("http://localhost:3000", "http://game-lounge.com", "http://167.99.242.175", "http://167.99.242.175:3000")
					.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
					.allowCredentials(true)
					.allowedHeaders("*")
					.exposedHeaders("Access-Control-Allow-Origin", "Cookie", "Set-Cookie")
			}
		}
	}

	@EventListener(ContextRefreshedEvent::class)
	fun initAdminUser() {
		val adminUsername = "admin"
		val adminEmail = "admin@example.com"
		val adminPassword = "adminPassword" // Change this to a secure password
		val (passwordHash, salt) = HashingUtil.generateHash(adminPassword)

		if (!userRepository.existsByUsername(adminUsername)) {
			val adminUser = userRepository.save(User(username = adminUsername, email = adminEmail, passwordHash = passwordHash, salt = salt, isAdmin = true))
			userRepository.save(adminUser)
		}
	}
}

fun main(args: Array<String>) {
	runApplication<BackendApplication>(*args)
}