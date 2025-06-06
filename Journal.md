# Woche 1 - Journal

## Thema: Eine Simple Infrastruktur in Terraform bauen. 

### Projektplanung und Struktur

- Projektziel definiert: Wetter Dashboard mit KI
- Entscheidung für Azure, AKS, PostgreSQL, Terraform und öffentliches HTTPS
- Nutzung von nip.io für Domains, keine eigene Domain notwendig

### Terraform Setup erstellt

- Lokale Terraform Projektstruktur mit Modulen aufgebaut
- Module implementiert für:
  - AKS Cluster (mit Autoscaling von 1 bis 2 Nodes)
  - PostgreSQL Flexible Server
  - Storage Account + Container für Backups
  - Azure Container Registry
- Remote State mit Azure Blob Storage in der Region northeurope erfolgreich eingerichtet

### Fehlerbehebung und Optimierungen

- Zugriff auf das Remote Backend korrigiert
- Provider Version angepasst
- Fehler in sku_name, Version, HA, Autoscaling, Storage Namen behoben
- PostgreSQL korrekt mit gültigem SKU und Version konfiguriert
- AKS-Konfiguration auf min_count = 1 angepasst für funktionierendes Autoscaling

### Nächste Schritte vorbereitet

- Ingress mit Public IP und nip.io Domain geplant
- cert-manager und Let's Encrypt für HTTPS bereit
- App Deployments, Ingress und CI/CD sind als nächste Schritte vorgesehen

# Woche 2 - Journal

## Thema: Deployment einer Container basierten Wetter-App auf Azure VM mit HTTPS


### Was wurde heute erreicht?

- **Docker + NGINX Setup auf Azure VM**
   - VM mit Terraform deployed (inkl. NSG, SSH-Zugriff, Static IP)
   - Docker + Docker Compose erfolgreich installiert und getestet (mit `hello-world`)
   - Containerisierte App (Frontend, API, ML-Service, Proxy) lokal auf VM deployed

- **Nginx-Reverse-Proxy**
   - Eigener NGINX Container für HTTP Routing auf Port 80
   - Proxy Routing konfiguriert für `/`, `/api/` und `/ml/` zu den entsprechenden Services

- **HTTPS mit Let's Encrypt (Certbot)**
   - NIP.IO Domain (`13.74.162.14.nip.io`) verwendet
   - Zertifikat erfolgreich mit Certbot (Webroot Modus) generiert
   - HTTPS Serverblock in nginx eingerichtet
   - HTTP auf HTTPS Weiterleitung per `return 301` eingerichtet

- **Frontend mit API verbunden**
   - API liefert Wetter Dummy Daten via `/api/weather`
   - Frontend ruft API über `fetch()` auf
   - Encoding Bug (UTF-8) in HTML erkannt und gefixt
   - Ausgabe: Wetterdaten dynamisch auf Webseite angezeigt

### Probleme & Lösungen

| Problem                             | Lösung                                                               |
|------------------------------------|----------------------------------------------------------------------|
| Certbot schlägt fehl wegen nginx.pid | Certbot auf Webroot Modus umgestellt                                |
| "Not Found" bei API                | Proxy `/api/` + FastAPI Pfad `/api/weather` → angepasst auf `/weather` |
| Sonderzeichen falsch dargestellt   | `<meta charset="UTF-8">` im HTML Header ergänzt                     |
| Port 443 nicht erreichbar          | NSG Regeln in Terraform geprüft + Certbot korrekt ausgeführt        |

### Warum kein AKS?

Ursprünglich war geplant, die App auf Azure Kubernetes Service (AKS) zu deployen. Beim Terraform Deployment kam es jedoch zu einem Berechtigungsfehler:

- **Problem:** Kein Zugriff auf `Microsoft.ContainerService/register/action`
- **Ursache:** Azure Playground Account ohne nötige Rechte zur Registrierung des AKS-Providers
- **Lösung:** Wechsel auf Azure Virtual Machine als Alternative (manuelles Container Hosting via Docker)

Dadurch konnten alle nötigen Services (API, Frontend, ML, Proxy) direkt über Docker Compose betrieben werden.

### Was habe ich gelernt?

- Wie man eine Azure-VM mit Terraform provisioniert
- Docker + Docker Compose produktionsnah aufsetzt
- HTTPS mit Let’s Encrypt und NGINX korrekt integriert
- Basics zu NGINX Reverse Proxy & FastAPI Pfad Handling
- Cleanes Zusammenspiel zwischen Infrastruktur, Backend und Frontend
- Umgang mit Fehlern im Encoding und Routing

# Lernjournal 3 & 4

## Thema: Integration eines ML-Moduls in die Wetter-App

### Zielsetzung
Das Ziel war es, ein Machine Learning Modul in die bestehende Wetter-App zu integrieren, welches eine zusätzliche 7 Tage Vorhersage bereitstellt, weil der free tier der API nur eine 3 Tage Vorhersage anbietet, wird mit ML-Modul noch die restlichen Tage der Wochen predicted. Dabei sollte das ML-Modul unabhängig als Microservice über FastAPI laufen und historische Wetterdaten nutzen. Auch damit die Webseite nicht mehr über die IP Addresse aufgerufen werden muss, wird mit DuckDNS eine Domain erstelle, im nginx.conf wird dann einfach die Addresse angepasst.

### Was wurde heute erreicht?

- DuckDNS Domain eingerichtet, damit die App nicht immer mit der IP aufgerufen werden muss.
- Aufbau eines eigenständigen Docker Containers für das ML-Modul (`ml`)
- Implementierung eines `train.py` Moduls zur Vorhersage der Temperatur mit echten historischen Wetterdaten über die WeatherAPI
- Einführung einer gemeinsamen Code Basis (`shared/weather_utils.py`) zur Wiederverwendung von API Funktionen
- Erstellung eines FastAPI-Endpunkts `/forecast` im `ml` Service
- Konfiguration des Dockerfiles und `docker-compose.yml` zur Einbindung von `shared/`
- Erweiterung von nginx zur Weiterleitung von `/ml/forecast` Anfragen bei vorhandenem Sicherheitsschlüssel
- Absicherung des ML-Endpunkts durch `X-Internal-Key` Header
- Behebung von Laufzeitfehlern durch korrekte `CMD` und Netzwerkdefinitionen
- Troubleshooting von HTTP Kommunikationsproblemen zwischen nginx und dem ML-Service

### Herausforderungen

- Die Verbindung von nginx zum ML-Service war fehleranfällig. Die Meldung „Invalid HTTP request received“ wurde durch inkorrekte Header oder unvollständige Requests verursacht.
- Das Container Netzwerk musste richtig konfiguriert sein, damit Dienste sich untereinander erreichen konnten.
- Das Logging im Container war entscheidend, um zu erkennen, dass `uvicorn` korrekt läuft, die Requests aber vom Client nicht vollständig oder fehlerhaft gesendet wurden.

### Nächste Schritte

- Finalisierung der Kommunikation zwischen Frontend und ML-Modul, sodass die erweiterten Vorhersagen im UI angezeigt werden
- Optional: Trainiertes Modell zwischenspeichern (statt bei jeder Anfrage zu trainieren)
- Auswertung der Prognosequalität durch Validierung mit echten Wetterdaten
- Styling Anpassung des Frontends für die neue 7 Tage Vorhersage

### Was habe ich gelernt

- Ein Simples ML-Modul in python schreiben (grössten Teils einfach importierte python libraries)
- Absiecherung der Website Endpunkte mitels `X-Internal-Key`
- Troubelshooting von Kommunikationsproblemen zwischen Docker Containern
