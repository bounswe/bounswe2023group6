# Build stage
FROM amazoncorretto:17-alpine3.15 AS TEMP_BUILD_IMAGE
ENV APP_HOME=/game-lounge-annotation-service/
WORKDIR $APP_HOME
COPY . $APP_HOME

# Copy the gradle files and wrapper
COPY build.gradle.kts settings.gradle.kts gradlew $APP_HOME
COPY gradle $APP_HOME/gradle


# Set the script to be executable
RUN chmod +x ./gradlew

RUN ./gradlew build -x test || return 0 
COPY . .
RUN ./gradlew build -x test

# Final stage
FROM amazoncorretto:17-alpine3.15
ENV ARTIFACT_NAME=annotation-service-0.0.1-SNAPSHOT.jar
ENV APP_HOME=/game-lounge-annotation-service/
WORKDIR $APP_HOME
EXPOSE 6000
RUN mkdir /annotation

# Copy the JAR from the build stage to the final image
COPY --from=TEMP_BUILD_IMAGE $APP_HOME/build/libs/$ARTIFACT_NAME ./spring-boot-application.jar

# Run the application
ENTRYPOINT ["java", "-jar", "spring-boot-application.jar"]
