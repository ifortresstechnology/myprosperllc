# Use a base image with Java
FROM openjdk:11-jdk-slim AS build

# Set the working directory for the backend (Spring Boot)
WORKDIR /app

# Copy the jar file from the build context to the container (Spring Boot)
COPY target/prosper-llc.jar /app/prosper-llc.jar

# Use Nginx for the frontend (this will be combined into one container)
FROM nginx:alpine

# Install supervisord to manage both Spring Boot and Nginx
RUN apk update && apk add --no-cache supervisor

# Create a directory for the Spring Boot application logs and configurations
RUN mkdir -p /var/log/springboot

# Copy the Spring Boot application (JAR) from the first build stage to the container
COPY --from=build /app/prosper-llc.jar /app/prosper-llc.jar

# Copy the frontend build into the Nginx directory
COPY ./frontend /usr/share/nginx/html

# Copy the supervisord config file
COPY supervisord.conf /etc/supervisord.conf

# Expose both ports (Nginx port 80 and Spring Boot port 8080)
EXPOSE 80 8080

# Command to start supervisord, which will run both Spring Boot and Nginx
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
