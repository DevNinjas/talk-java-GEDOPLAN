Hello World Spring Boot Application
-----------------------------------

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Ein einfaches Spring Boot "Hello World"-Projekt, das in einem Container läuft und für Kubernetes bereitgestellt ist.

## Inhaltsverzeichnis

1. [Überblick](#überblick)
2. [Voraussetzungen](#voraussetzungen)
3. [Build und Ausführung mit Podman](#build-und-ausführung-mit-podman)
4. [Build und Ausführung mit Docker](#build-und-ausführung-mit-docker)
5. [Build und Ausführung mit Docker Multi-Target](#build-und-ausführung-mit-docker-multi-target)
6. [Deployment mit Kubernetes](#deployment-mit-kubernetes)
7. [Lizenz und Autoren](#lizenz-und-autoren)

## [Überblick](#überblick)

Diese Anwendung ist eine einfache Spring Boot-Anwendung, die auf zwei Endpunkten antwortet:
-  `/` : Gibt eine Begrüßung mit Host- und Knoteninformationen aus.
-  `/hello` : Gibt "Hallo Welt!" aus.

Die Anwendung ist so konzipiert, dass sie in einem Container läuft und für Kubernetes bereitgestellt werden kann.

### Projektstruktur
```shell
./
├── .k8s/                                         # Verzeichnis für Kubernetes-Ressourcendefinitionen
│  ├── app.yaml                                   # Kubernetes Deployment Manifests für die Anwendung
│  ├── ingress.yaml                               # Kubernetes Ingress Manifest zum Konfigurieren des Zugriffs auf die Anwendung
│  └── svc.yaml                                   # Kubernetes Service Manifest zur Exponierung der Anwendung
├── src/                                          # Verzeichnis für den Anwendungsquellcode und Tests
│  ├── main/                                      # Hauptquellcode der Anwendung
│  │  ├── java/                                   # Java-Quellcodeverzeichnis
│  │  │  └── com/
│  │  │     └── devninjas/
│  │  │        └── helloworld/
│  │  │           ├── GreetingController.java     # Controller-Klasse für HTTP-Endpoints
│  │  │           └── HelloworldApplication.java  # Spring Boot Main-Klasse zur Initialisierung der Anwendung
│  │  └── resources/                              # Ressourcenverzeichnis für Konfigurations- und andere Dateien
│  │     └── application.properties               # Anwendungskonfigurationsdatei
│  └── test/                                      # Verzeichnis für Testquellcode
│     └── java/
│        └── com/
│           └── devninjas/
│              └── helloworld/
│                 └── HelloworldApplicationTests.java # Testklasse für die Anwendung
├── target/                                           # Ausgabeverzeichnis für die gebauten Artefakte
│  ├── classes/                                       # Enthält die kompilierten Klassendateien
│  │  └── application.properties                      # Kopie der Hauptkonfigurationsdatei
│  ├── generated-sources/                             # Generierte Quellen während des Build-Prozesses
│  │  └── annotations/                                # Verzeichnis für durch Annotation Processor generierte Quelltexte
│  └── maven-status/                                  # Maven-spezifische Statusinformationen
│     └── maven-compiler-plugin/                      # Statusinformationen des Maven-Compiler-Plugins
│        └── compile/
│           └── default-compile/
│              ├── createdFiles.lst               # Liste der während des Builds erzeugten Dateien
│              └── inputFiles.lst                 # Liste der während des Builds verwendeten Eingabedateien
├── Dockerfile                                    # Dockerfile zur Erstellung eines Docker-Images für die Anwendung
├── HELP.md                                       # Hilfedokumentation und Referenzlinks
├── mvnw*                                         # Maven Wrapper Script für Unix-basierte Systeme
├── mvnw.cmd                                      # Maven Wrapper Script für Windows
├── pom.xml                                       # Maven Projektobjektmodell (POM) Datei mit Projektkonfiguration und Abhängigkeiten
└── README.md                                     # Dokumentation des Projekts mit Anweisungen zur Nutzung
```

## [Voraussetzungen](#voraussetzungen)

-  **Java 17**: Stellen Sie sicher, dass Sie die Java Development Kit (JDK) Version 17 installiert haben.
-  **Maven 3.8.x**: Maven muss installiert sein, um das Projekt zu bauen.
-  **Podman/Docker**: Ein Container-Tool, um die Anwendung in einem Container zu bauen und auszuführen.
-  **Kubernetes Cluster**: Ein funktionierender Kubernetes-Cluster.
- Ein **Ingress Controller** muss installiert sein.
- **cert-manager**: Für die TLS-Zertifikatsverwaltung.

## [Build und Ausführung mit Podman](#build-und-ausführung-mit-podman)
1. Docker Image bauen:
```shell
podman build -t [name]:[tag] .
```

2. Docker push:
```shell
podman push [name]:[tag]
```

## [Build und Ausführung mit Docker](#build-und-ausführung-mit-docker)
1. Docker Image bauen:
```shell
docker build -t [name]:[tag] .
```

2. Docker push:
```shell
docker push [name]:[tag]
```

## [Build und Ausführung mit Docker Multi-Target](#build-und-ausführung-mit-docker-multi-target)
1. Docker Image bauen:
```shell
docker buildx build -t [name]:[tag] --platform=linux/amd64,linux/arm64 . --push
```

## [Deployment mit Kubernetes](#deployment-mit-kubernetes)

1. Code anpassen und Image Name und Tag in der `deployment.yaml` anpassen.
2. Kubernetes-Recourcen erstellen/updaten:
```shell
kubectl apply -f ./.k8s
```


## [Lizenz und Autoren](#lizenz-und-autoren)

Dieses Projekt steht unter der MIT-Lizenz. Erstellt von **Nico Swiatecki** und der [DevNinjas GmbH](https://www.devninjas.io).