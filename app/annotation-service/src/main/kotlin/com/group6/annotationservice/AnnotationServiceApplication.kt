package com.group6.annotationservice

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.web.servlet.config.annotation.CorsRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer

@SpringBootApplication
class AnnotationServiceApplication {
    @Bean
    fun corsFilter(): WebMvcConfigurer {
        return object : WebMvcConfigurer {
            override fun addCorsMappings(registry: CorsRegistry) {
                registry.addMapping("/**")
                    .allowedOrigins("http://localhost:3000", "http://167.99.242.175", "http://167.99.242.175:3000", "http://game-lounge.com", "http://game-lounge.com:3000", "http://www.game-lounge.com", "http://www.game-lounge.com:3000", "https://game-lounge.com", "https://www.game-lounge.com")
                    .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                    .allowCredentials(true)
                    .allowedHeaders("*")
                    .exposedHeaders("Access-Control-Allow-Origin", "Cookie", "Set-Cookie")
            }
        }
    }
}

fun main(args: Array<String>) {
    runApplication<AnnotationServiceApplication>(*args)
}
