# Użyj obrazu z Maven i Java 21
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

# Skopiuj pom.xml i pobierz dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Skopiuj kod źródłowy
COPY src src

# Zbuduj aplikację
RUN mvn clean package -DskipTests

# Drugi stage - środowisko runtime
FROM eclipse-temurin:21-jre

WORKDIR /app

# Skopiuj JAR z build stage
COPY --from=build /app/target/*.jar app.jar

# Port dla Railway
ARG PORT=8080
ENV PORT=${PORT}

# Uruchom aplikację
ENTRYPOINT ["java", "-Dserver.port=${PORT}", "-jar", "app.jar"]