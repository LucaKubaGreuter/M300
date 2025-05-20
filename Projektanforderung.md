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
    - [7. CI/CD Pipeline](#7-cicd-pipeline)
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
- [ ] AKS Cluster + Node Pool provisionieren
- [ ] PostgreSQL (Azure Database for PostgreSQL Flexible Server)
- [ ] Storage Account für Backups anlegen
- [ ] Öffentliches DNS-Name + Zertifikatsetup vorbereiten
- [ ] Secrets über Azure Key Vault managen

---

### 3. Applikation lokal bauen
- [ ] Backend API
- [ ] REST-Endpunkte für:
  - [ ] Wetterdaten speichern
  - [ ] Wetterdaten abrufen
  - [ ] ML-Vorhersage aufrufen
- [ ] ML-Modell:
  - [ ] Daten beschaffen
  - [ ] Trainieren & exportieren
  - [ ] Modellserver als eigenständiger Container
- [ ] Frontend:
  - [ ] UI für aktuelle Daten & Vorhersage
  - [ ] Charts

---

### 4. Containerisierung & Kubernetes
- [ ] Dockerfiles für Backend, Frontend, ML-Modell
- [ ] Kubernetes Manifeste
- [ ] Ingress Controller + HTTPS via Cert-Manager
- [ ] DNS-Record + Zertifikatsvalidierung

---

### 5. Datenbank & Backup
- [ ] Verbindung zu PostgreSQL sichern 
- [ ] Schema-Definition
- [ ] Regelmässige Backups einrichten

---

### 6. Monitoring & Logging
- [ ] Prometheus + Grafana Dashboard
- [ ] Logging mit Fluent Bit + Loki
- [ ] Alerts einrichten 

---

### 7. CI/CD Pipeline 
- [ ] Workflow für Build + Push der Images
- [ ] Workflow für Kubernetes Deployment
- [ ] Optional: Terraform Automation

---

### 8. Dokumentation
- [ ] Infrastruktur-Doku
- [ ] Code-Doku 
- [ ] ML-Modell Training + Performance
- [ ] Sicherheitsüberblick 
- [ ] Backup-Strategie
- [ ] Projektfazit + mögliche Erweiterungen

---

## Mögliche Erweiterungen
- Authentifizierung 
- Mehrere Städte speichern & vergleichen
- Komplexeres ML-Modell 
- Dark-Mode im Frontend
