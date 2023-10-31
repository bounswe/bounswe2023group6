package com.gamelounge.backend.config

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.Configuration

@Configuration
@ConfigurationProperties(prefix = "custom")
class CustomProperties {
    lateinit var mailUrl: String
}