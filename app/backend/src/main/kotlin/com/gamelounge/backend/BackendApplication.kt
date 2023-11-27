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
					.allowedOrigins("http://localhost:3000") // Specify the exact origin
					.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
					.allowCredentials(true) // Allow credentials
					.allowedHeaders("*")
					.exposedHeaders("Access-Control-Allow-Origin")

            // ctx.response.headers.add("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE, OPTIONS")
            // ctx.response.headers.add("Access-Control-Allow-Headers", "DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range")
			}
		}
	}
}

fun main(args: Array<String>) {
	runApplication<BackendApplication>(*args)
}
