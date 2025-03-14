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

# Stage 2: Build the Frontend with Nginx (Frontend)
FROM node:16-alpine AS frontend-build

# Set the working directory for the frontend build
WORKDIR /frontend

# Copy the frontend source code
COPY src/main/resources/static ./frontend

# Install necessary dependencies and build the static files (if you need to compile them)
# RUN npm install (Uncomment if you need to use npm/yarn for JS packages)
# RUN npm run build (Uncomment if you need to run a build command)

# Stage 3: Serve the Application using Nginx and Spring Boot (Final Image)
FROM openjdk:17-jdk-slim

# Install Nginx and Supervisor
RUN apt-get update && apt-get install -y nginx supervisor

# Set the working directory
WORKDIR /app

# Copy the Spring Boot jar file from the build stage
C
