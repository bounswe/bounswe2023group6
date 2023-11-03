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


## Docker

To run the backend application on Docker, you can follow the commands below in order:

- First, build the backend application. Navigate to the backend folder and execute the following command:

```bash
docker build -t game-lounge-backend .
```

This command builds the backend application and creates a Docker image. We can use this image to run our application on Docker.

- After building the backend application, you need to run the Postgres database on Docker. Execute the following command:

```bash
docker run --detach -p 5432:5432 -e POSTGRES_USER="<postgres-username>" -e POSTGRES_PASSWORD="<postgres-password>" -e POSTGRES_DB="<postgres-database-name>" postgres
```

When you run this command, it will pull the Postgres image from Docker and run it in a container. We use the `-p 5432:5432` instruction to allow the database container to accept requests on port 5432. You can provide the user, password, and database name as per your requirements. Make sure to remember these details as you will need them later. 
If Postgres is already running in the background on your computer, you might encounter an error. To prevent this error, stop Postgres on your computer. On Linux, you can do it like this:

```bash
sudo systemctl stop postgres
```

- After the database container is running, you can run the backend image as a container. Execute the following command:

```bash
docker run --detach -p 8080:8080 -e SPRING_DATASOURCE_URL="jdbc:postgresql://<your-local-ip>:5432/<postgres-database-name>" -e SPRING_DATASOURCE_USERNAME="<postgres-username>" -e SPRING_DATASOURCE_PASSWORD="<postgres-password>" game-lounge-backend
```

This command runs the backend image that you previously built and allows it to accept requests on port 8080. Fill in the database details with the information you used when running the database container. Once the backend container is running, you can access your backend application via port 8080 on localhost.

