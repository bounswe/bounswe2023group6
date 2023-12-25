## Available Scripts

In the project directory, you can run:

### npm install

Installs the dependencies.

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can't go back!**

If you aren't satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you're on your own.

You don't have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn't feel obligated to use this feature. However we understand that this tool wouldn't be useful if you couldn't customize it when you are ready for it.

### `make precommit`

To maintain code quality, we use ESLint and Prettier. Before committing any changes, run this command.

When you run this command, 'npm run lint' and 'npm run format' commands are executed.

## Docker

If you prefer to run the application in a Docker container, you can use the following Docker commands inside the frontend folder:

### `docker build -t game-lounge .`

This command is used to create a Docker image and assign the name "game-lounge" to that image.

### `docker run -p 3000:3000 -d game-lounge`

The command "docker run -p 3000:3000 -d game-lounge" starts a Docker container from the "game-lounge" Docker image, mapping traffic from your local machine's port 3000 to the container's port 3000, and runs the container in the background.

Please note that one needs to setup a simple .env file before running it as the the backend url is defined by it. It's enough to define REACT_APP_API_URL (either localhost:8080 or some remote url).




