# Building and Running the Spring Boot Application

## Available Scripts

Before getting started, make sure that:
- the PostgreSQL configurations in the `application.properties` file valid: The port number, db name, username, and password should match. So that you can run the application in your local.
- you have the `Java 17` or higher versions are installed in your environment, since the Gradle version 3.x.x only supports Java 17 and higher, i.e Java 21

Then once you are in the project directory you can run the project as follows:

### `./gradlew build`

The command ./gradlew build is a common way to trigger a project build using the Gradle build automation tool. This command initiates a series of tasks that compile source code, run tests, and generate project artifacts, ensuring that the software is built and ready for deployment.

### `./gradlew bootRun`

The command ./gradlew bootRun is a Gradle task used to start a Spring Boot application. When executed, it initiates the embedded web server and deploys the Spring Boot application, making it accessible for testing and development. It's a simple and convenient way to launch a Spring Boot project from the command line using the Gradle Wrapper.

## Seeing The Exposed Endpoints

After the application is up and going in your local, you can visit the Swagger Documentation following the `http://localhost:8080/swagger-ui/index.html`. 
