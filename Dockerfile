FROM openjdk:17-jdk-slim
WORKDIR /app
COPY ./target/*.jar app.jar
EXPOSE 8081
CMD ["java", "-jar", "app.jar"]
# Set working directory

# Copy the application JAR


# Set environment variables
# ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql-container:3306/myapplication?createDatabaseIfNotExist=true
# ENV SPRING_DATASOURCE_USERNAME=root
# ENV SPRING_DATASOURCE_PASSWORD=1234
# Expose port


# Start the application
