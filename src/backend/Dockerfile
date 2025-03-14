# Use a base image with Java
FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the jar file from the build context to the container
COPY target/prosper-llc.jar /app/prosper-llc.jar

# Expose the port that the Spring Boot application will run on
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/prosper-llc.jar"]
# Use an Nginx image to serve the static files
FROM nginx:alpine

# Copy the frontend build into the Nginx directory
COPY ./frontend /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80
