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

# Woche 2 - Journal

## Thema: Deployment einer Container-basierten Wetter-App auf Azure VM mit HTTPS

---

## Was wurde heute erreicht?

1. **Docker + NGINX Setup auf Azure VM**
   - VM mit Terraform deployed (inkl. NSG, SSH-Zugriff, Static IP)
   - Docker + Docker Compose erfolgreich installiert und getestet (mit `hello-world`)
   - Containerisierte App (Frontend, API, ML-Service, Proxy) lokal auf VM deployed

2. **Nginx-Reverse-Proxy**
   - Eigener NGINX-Container für HTTP-Routing auf Port 80
   - Proxy-Routing konfiguriert für `/`, `/api/` und `/ml/` zu den entsprechenden Services

3. **HTTPS mit Let's Encrypt (Certbot)**
   - NIP.IO-Domain (`13.74.162.14.nip.io`) verwendet
   - Zertifikat erfolgreich mit Certbot (Webroot-Modus) generiert
   - HTTPS-Serverblock in nginx eingerichtet
   - HTTP auf HTTPS Weiterleitung per `return 301` eingerichtet

4. **Frontend mit API verbunden**
   - API liefert Wetter-Dummy-Daten via `/api/weather`
   - Frontend ruft API über `fetch()` auf
   - Encoding-Bug (UTF-8) in HTML erkannt und gefixt
   - Ausgabe: Wetterdaten dynamisch auf Webseite angezeigt

---

## Probleme & Lösungen

| Problem                             | Lösung                                                               |
|------------------------------------|----------------------------------------------------------------------|
| Certbot schlägt fehl wegen nginx.pid | Certbot auf Webroot-Modus umgestellt                                |
| "Not Found" bei API                | Proxy `/api/` + FastAPI Pfad `/api/weather` → angepasst auf `/weather` |
| Sonderzeichen falsch dargestellt   | `<meta charset="UTF-8">` im HTML-Header ergänzt                     |
| Port 443 nicht erreichbar          | NSG-Regeln in Terraform geprüft + Certbot korrekt ausgeführt        |

### Warum kein AKS?

Ursprünglich war geplant, die App auf Azure Kubernetes Service (AKS) zu deployen. Beim Terraform-Deployment kam es jedoch zu einem Berechtigungsfehler:

- **Problem:** Kein Zugriff auf `Microsoft.ContainerService/register/action`
- **Ursache:** Azure Playground-Account ohne nötige Rechte zur Registrierung des AKS-Providers
- **Lösung:** Wechsel auf Azure Virtual Machine als Alternative (manuelles Container-Hosting via Docker)

Dadurch konnten alle nötigen Services (API, Frontend, ML, Proxy) direkt über Docker Compose betrieben werden.

---

## Was habe ich gelernt?

- Wie man eine Azure-VM mit Terraform provisioniert
- Docker + Docker Compose produktionsnah aufsetzt
- HTTPS mit Let’s Encrypt und NGINX korrekt integriert
- Basics zu NGINX Reverse Proxy & FastAPI Pfad-Handling
- Cleanes Zusammenspiel zwischen Infrastruktur, Backend und Frontend
- Umgang mit Fehlern im Encoding und Routing