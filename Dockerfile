# Użyj obrazu Maven z Java 21 do buildowania
FROM eclipse-temurin:21-jdk as build

WORKDIR /app

# Skopiuj pliki Maven
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Pobranie zależności (cache layer)
RUN ./mvnw dependency:go-offline -B

# Skopiuj kod źródłowy
COPY src src

# Zbuduj aplikację
RUN ./mvnw clean package -DskipTests

# Drugi stage - środowisko runtime
FROM eclipse-temurin:21-jre

WORKDIR /app

# Skopiuj JAR z build stage
COPY --from=build /app/target/*.jar app.jar

# Stwórz użytkownika (bezpieczeństwo)
RUN useradd --create-home --shell /bin/bash runtime
USER runtime

# Port dla Railway
ARG PORT=8080
ENV PORT=${PORT}

# Uruchom aplikację
ENTRYPOINT ["java", "-Dserver.port=${PORT}", "-jar", "app.jar"]