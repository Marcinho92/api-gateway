# Użyj oficjalnego obrazu Maven z OpenJDK 17
FROM maven:3.9.6-openjdk-17

# Ustaw katalog roboczy
WORKDIR /app

# Skopiuj pliki projektu
COPY pom.xml ./
COPY src ./src

# Pobranie zależności (cache layer)
RUN mvn dependency:go-offline -B

# Zbuduj aplikację
RUN mvn clean package -DskipTests

# Uruchom aplikację
EXPOSE 8080
CMD ["java", "-jar", "target/api-gateway-0.0.1-SNAPSHOT.jar"]