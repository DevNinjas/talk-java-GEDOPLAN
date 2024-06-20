# Build Stage
# Verwenden Sie das offizielle Maven 3.8 mit OpenJDK 17 Image als Basisimage für den Build
FROM maven:3.8-openjdk-17 AS build

# Setzen Sie das Arbeitsverzeichnis im Container
WORKDIR /app

# Kopieren Sie die Maven-Wrapper-Dateien und die pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Installieren Sie die Maven-Abhängigkeiten ohne Tests auszuführen
RUN ./mvnw dependency:go-offline

# Kopieren Sie den Rest des Projekts
COPY . .

# Bauen Sie das Projekt ohne Tests
RUN ./mvnw clean install -DskipTests

# App Stage
# Verwenden Sie das offizielle OpenJDK 17 Slim Image als Basisimage für den Laufzeitcontainer
FROM openjdk:17-jdk-slim

# Setzen Sie das Arbeitsverzeichnis im Container
WORKDIR /app

# Kopieren Sie die gebaute JAR-Datei aus dem vorherigen Build-Stage
COPY --from=build /app/target/*.jar app.jar

# Exponieren Sie den Port, auf dem die Anwendung läuft
EXPOSE 8080

# Definieren Sie den Befehl zum Ausführen der JAR-Datei
ENTRYPOINT ["java", "-jar", "app.jar"]
