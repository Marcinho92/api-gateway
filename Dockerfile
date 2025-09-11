# Użyj oficjalnego obrazu OpenJDK 21
FROM openjdk:21-jdk-slim

# Ustaw katalog roboczy
WORKDIR /app

# Skopiuj pliki Maven Wrapper
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Dodaj uprawnienia do mvnw
RUN chmod +x mvnw

# Pobranie zależności (cache layer)
RUN ./mvnw dependency:go-offline -B

# Skopiuj kod źródłowy
COPY src ./src

# Zbuduj aplikację
RUN ./mvnw clean package -DskipTests

# Uruchom aplikację
EXPOSE 8080
CMD ["java", "-jar", "target/api-gateway-0.0.1-SNAPSHOT.jar"]