# MonolithStarter

This project is intended to help developers quickly stand up a monolithic React/Spring Boot application. For the most part you can simply replace all instances of `monolithstarter` with appropriately-cased `yourprojectname` but make sure to do a Ctrl + F for `FIXME` to find places where more action is required.

This readme assumes that you have completed the [newhire checklist](https://github.com/validityhq/we_the_engineers/tree/master/newhire).

## Development Setup

During development, you may simply work on front-end and backend with independent tools.

For PC users: For all the `./mvnw` commands mentioned below use `mvnw` instead.

### To run the back-end:

```bash
# Move to the backend directory
cd monolithstarter-svc

# Start the application in dev mode
./mvnw
```

You will now have a host running at [localhost:8080](http://localhost:8080/)

### To run the front-end:

```bash
# Move to the right directory
cd monolithstarter-static

# Install dependencies
yarn

# Start the application in dev mode
yarn run start
```
You will now have your frontend running at [localhost:9000](http://localhost:9000/)

To build frontend for production with minification:

```bash
yarn run build
```

The build artifacts will be stored in the `build/` directory


## Build / Deployment

### Local
The Maven build process (`./mvnw clean install`) makes use of `frontend-maven-plugin` and `maven-resources-plugin` to automatically run the front-end build and copy the output to `monolithstarter-svc/target/public` to be packaged with the back-end so the entire application can be deployed as a single JAR.

The front-end can be built separately by running `yarn run build` in the `monolithstarter-static` directory.

### Docker
```bash
# Move to the monolithstarter-svc directory
cd monolithstarter-svc

# Generate a clean package
./mvnw clean package

# Construct the docker image
docker build -t monolithstarter-svc .

# Run the image container (substitute 5000 for desired port)
docker run -p 5000:8080 monolithstarter-svc
```
The full application is now accessible at [localhost:5000](http://localhost:5000/) (or whatever port you chose to use)
