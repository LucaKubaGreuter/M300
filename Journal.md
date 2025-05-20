# Woche 1 - Journal

## 1. Projektplanung und Struktur

- Projektziel definiert: Wetter-Dashboard mit KI
- Entscheidung für Azure, AKS, PostgreSQL, Terraform und öffentliches HTTPS
- Nutzung von nip.io für Domains, keine eigene Domain notwendig

## 2. Terraform Setup erstellt

- Lokale Terraform-Projektstruktur mit Modulen aufgebaut
- Module implementiert für:
  - AKS Cluster (mit Autoscaling von 1 bis 2 Nodes)
  - PostgreSQL Flexible Server
  - Storage Account + Container für Backups
  - Azure Container Registry
- Remote State mit Azure Blob Storage in der Region northeurope erfolgreich eingerichtet

## 3. Fehlerbehebung und Optimierungen

- Zugriff auf das Remote Backend korrigiert
- Provider-Version angepasst
- Fehler in sku_name, Version, HA, Autoscaling, Storage-Namen behoben
- PostgreSQL korrekt mit gültigem SKU und Version konfiguriert
- AKS-Konfiguration auf min_count = 1 angepasst für funktionierendes Autoscaling

## 4. Nächste Schritte vorbereitet

- Ingress mit Public IP und nip.io Domain geplant
- cert-manager und Let's Encrypt für HTTPS bereit
- App-Deployments, Ingress und CI/CD sind als nächste Schritte vorgesehen
