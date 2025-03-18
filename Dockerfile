# Stage 1: Build the Spring Boot Application (Backend)
FROM maven:3.8.1-openjdk-17 AS build

# Set the working directory for the build process
WORKDIR /app

# Copy the pom.xml file and fetch dependencies
COPY pom.xml .

# Download dependencies (this step is cached if there are no changes to pom.xml)
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Package the application (skip tests for quicker builds)
RUN mvn clean package -DskipTests

# Stage 2: Build the Frontend (Static Files)
FROM node:16-alpine AS frontend-build

# Set the working directory for the frontend build
WORKDIR /frontend

# Copy the frontend source code
COPY src/main/resources/static ./frontend

# Optionally, you can add frontend build commands here if you need to compile assets
# RUN npm install (Uncomment if you need to use npm/yarn for JS packages)
# RUN npm run build (Uncomment if you need to run a build command)

# Stage 3: Final Image (Running the Spring Boot Application)
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the Spring Boot jar file from the build stage
COPY --from=build /app/target/*.jar /app/app.jar

# Copy frontend static files into Spring Boot's static folder
COPY --from=frontend-build /frontend /app/src/main/resources/static

# Expose the Spring Boot port (8080)
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "/app/app.jar"]
