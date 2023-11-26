import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	id("org.springframework.boot") version "3.1.4"
	id("io.spring.dependency-management") version "1.1.3"
	kotlin("jvm") version "1.8.22"
	kotlin("plugin.spring") version "1.8.22"
}

group = "com.game-lounge"
version = "0.0.1-SNAPSHOT"

java {
	sourceCompatibility = JavaVersion.VERSION_17
}

repositories {
	mavenCentral()
}

dependencies {
	compileOnly("org.projectlombok:lombok:1.18.24")
	implementation("org.springframework.boot:spring-boot-starter")
	implementation("org.jetbrains.kotlin:kotlin-reflect")
	implementation("org.springframework.boot:spring-boot-starter-web:3.1.5")
	implementation("org.springframework.boot:spring-boot-starter-data-jpa:3.1.5")
	implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.9.0")
	implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui:2.0.0")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	implementation("org.mockito.kotlin:mockito-kotlin:5.1.0")
	runtimeOnly("org.postgresql:postgresql")
	runtimeOnly("org.jetbrains.kotlin:kotlin-reflect:1.9.0")
	implementation("org.springframework.boot:spring-boot-starter-mail")
	implementation("org.flywaydb:flyway-core")
	implementation("software.amazon.awssdk:s3:2.17.101")


}

tasks.withType<KotlinCompile> {
	kotlinOptions {
		freeCompilerArgs += "-Xjsr305=strict"
		jvmTarget = "17"
	}
}

tasks.withType<Test> {
	useJUnitPlatform()
}

