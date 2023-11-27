package com.gamelounge.backend

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import org.springframework.web.servlet.config.annotation.CorsRegistry

@SpringBootApplication
class BackendApplication

class SpringSecurityCorsApplication{
	@Bean
	fun corsFilter(): WebMvcConfigurer {
		return object : WebMvcConfigurer {
			override fun addCorsMappings(registry: CorsRegistry) {
				registry.addMapping("/**")
						.allowedMethods("*")
						.allowedOrigins("http://localhost:3000", "http://localhost", "*" )
						.allowedHeaders("*")
			}
		}
	}
}

fun main(args: Array<String>) {
	runApplication<BackendApplication>(*args)
}
