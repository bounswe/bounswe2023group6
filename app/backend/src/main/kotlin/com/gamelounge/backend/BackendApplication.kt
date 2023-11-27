package com.gamelounge.backend

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import org.springframework.web.servlet.config.annotation.CorsRegistry

@SpringBootApplication
class BackendApplication {
	@Bean
	fun corsFilter(): WebMvcConfigurer {
		return object : WebMvcConfigurer {
			override fun addCorsMappings(registry: CorsRegistry) {
				registry.addMapping("/**")
					.allowedOrigins("http://localhost:3000")
					.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
					.allowCredentials(true)
					.allowedHeaders("*")
					.exposedHeaders("Access-Control-Allow-Origin", "Cookie", "Set-Cookie")
			}
		}
	}
}

fun main(args: Array<String>) {
	runApplication<BackendApplication>(*args)
}