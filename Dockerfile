# Build Stage
# Verwenden das offizielle Maven 3.8 mit OpenJDK 17 Image als Basisimage für den Build
FROM maven:3.8-openjdk-17 AS build

# Setzen das Arbeitsverzeichnis im Container
WORKDIR /app

# Kopieren die Maven-Wrapper-Dateien und die pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Installieren die Maven-Abhängigkeiten ohne Tests auszuführen
RUN ./mvnw dependency:go-offline

# Kopieren den Rest des Projekts
COPY . .

# Bauen das Projekt ohne Tests
RUN ./mvnw clean install -DskipTests

# App Stage
# Verwenden das offizielle OpenJDK 17 Slim Image als Basisimage für den Laufzeitcontainer
FROM gcr.io/distroless/java17-debian12:nonroot

# Setzen das Benutzer auf nonroot
USER nonroot

# Setzen das Arbeitsverzeichnis im Container
WORKDIR /app

# Kopieren die gebaute JAR-Datei aus dem vorherigen Build-Stage und benennen Sie sie in app.jar um
COPY --from=build --chown=nonroot /app/target/*.jar app.jar

# Exponieren den Port, auf dem die Anwendung läuft
EXPOSE 8080

# Definieren den Befehl zum Ausführen der JAR-Datei
CMD ["app.jar"]
