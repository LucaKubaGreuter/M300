# Wetter-App mit KI

## Projektbeschreibung

Ziel ist der Aufbau einer cloudnativen Wetter-App, das Wetterdaten sammelt, speichert, visualisiert und mithilfe eines ML Modells einfache Vorhersagen treffen kann. Die Applikation wird auf Azure Kubernetes Service deployt, komplett provisioniert mit Terraform und mit HTTPS öffentlich zugänglich gemacht.

- [Wetter-App mit KI](#wetter-app-mit-ki)
  - [Projektbeschreibung](#projektbeschreibung)
  - [Projektanforderungen](#projektanforderungen)
  - [Projekt-Checkliste](#projekt-checkliste)
    - [1. Planung \& Setup](#1-planung--setup)
    - [2. Azure Infrastruktur](#2-azure-infrastruktur)
    - [3. Applikation lokal bauen](#3-applikation-lokal-bauen)
    - [4. Containerisierung \& Kubernetes](#4-containerisierung--kubernetes)
    - [5. Datenbank \& Backup](#5-datenbank--backup)
    - [6. Monitoring \& Logging](#6-monitoring--logging)
    - [8. Dokumentation](#8-dokumentation)
  - [Mögliche Erweiterungen](#mögliche-erweiterungen)
---

## Projektanforderungen

- **Frontend** zur Anzeige von Wetterdaten & Vorhersagen
- **Backend API** zur Bereitstellung & Speicherung von Wetterdaten
- **ML-Modell** für Temperaturvorhersagen 
- **PostgreSQL-Datenbank** mit Backup
- **HTTPS-Zugriff** mit DNS + Let's Encrypt
- **Monitoring**
- **Zentrales Logging**
- **CI/CD-Pipeline** mit GitHub Actions
- **Deployment** via Terraform

---

## Projekt-Checkliste 

### 1. Planung & Setup
- [x] Repository erstellen
- [x] Projektbeschreibung + Readme schreiben
- [x] Architekturdiagramm erstellen
- [x] Terraform Setup vorbereiten

---

### 2. Azure Infrastruktur
- [x] AKS Cluster + Node Pool provisionieren
- [x] PostgreSQL (Azure Database for PostgreSQL Flexible Server)
- [x] Storage Account für Backups anlegen
- [x] Öffentliches DNS-Name + Zertifikatsetup vorbereiten
- [x] Secrets über Azure Key Vault managen

---

### 3. Applikation lokal bauen
- [x] Backend API
- [x] REST-Endpunkte für:
  - [x] Wetterdaten speichern
  - [x] Wetterdaten abrufen
  - [x] ML-Vorhersage aufrufen
- [x] ML-Modell:
  - [x] Daten beschaffen
  - [x] Trainieren & exportieren
  - [x] Modellserver als eigenständiger Container
- [x] Frontend:
  - [x] UI für aktuelle Daten & Vorhersage
  - [x] Charts

---

### 4. Containerisierung & Kubernetes
- [x] Dockerfiles für Backend, Frontend, ML-Modell
- [x] Kubernetes Manifeste
- [x] Ingress Controller + HTTPS via Cert-Manager
- [x] DNS-Record + Zertifikatsvalidierung

---

### 5. Datenbank & Backup
- [x] Verbindung zu PostgreSQL sichern 
- [x] Schema-Definition
- [x] Regelmässige Backups einrichten

---

### 6. Monitoring & Logging
- [x] Prometheus + Grafana Dashboard

---

### 8. Dokumentation
- [x] Infrastruktur-Doku
- [x] Code-Doku 
- [x] ML-Modell Training + Performance
- [x] Sicherheitsüberblick 
- [x] Backup-Strategie
- [x] Projektfazit + mögliche Erweiterungen

---

## Mögliche Erweiterungen
- Authentifizierung 
- Mehrere Städte speichern & vergleichen
- Komplexeres ML-Modell 
- Dark-Mode im Frontend
