# Stage 1: Build the Backend (Spring Boot Application)
FROM maven:3.8.1-openjdk-17 AS build

# Set the working directory for the backend build
WORKDIR /app

# Copy the pom.xml file and fetch dependencies
COPY pom.xml .

# Download dependencies (this step is cached if there are no changes to pom.xml)
RUN mvn dependency:go-offline

# Copy the backend source code
COPY src ./src

# Package the backend application (skip tests for quicker builds)
RUN mvn clean package -DskipTests

# Stage 2: Build the Frontend (Static Files)
FROM node:16-alpine AS frontend-build

# Set the working directory for the frontend build
WORKDIR /frontend

# Copy the frontend static files (HTML, CSS, JS) to the container
COPY src/main/resources/static ./frontend

# Optionally, uncomment if you need to build the frontend assets
# RUN npm install
# RUN npm run build

# Stage 3: Final Image (Running the Spring Boot Application)
FROM openjdk:17-jdk-slim

# Set the working directory for the final image
WORKDIR /app

# Copy the Spring Boot jar file from the build stage
COPY --from=build /app/target/*.jar /app/app.jar

# Copy frontend static files into Spring Boot's static folder
COPY --from=frontend-build /frontend /app/src/main/resources/static

# Expose the Spring Boot application port (8080)
EXPOSE 8080

# Use environment variables for sensitive data like MongoDB URI
# You can set these when running the container using the `-e` flag
CMD ["java", "-Dspring.data.mongodb.uri=${MONGODB_URI}", "-Djava.security.egd=file:/dev/./urandom", "-jar", "./app.jar"]
