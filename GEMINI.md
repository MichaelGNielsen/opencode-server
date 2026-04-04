# GEMINI.md

## Project Overview
Dette projekt leverer en containeriseret **OpenCode AI Server**, der fungerer som en centraliseret AI-backend for hele det lokale netværk (LAN). Formålet er at have en nem, standardiseret opsætning, der kan køres på tværs af forskellige PC'er (f.eks. NUC eller Windows via WSL2) og tilgås af alle lokale services.

### Technology Stack
- **AI:** OpenCode AI (`opencode-ai` pakken).
- **Miljø:** Node.js (v20-slim base image).
- **Orkestrering:** Docker & Docker Compose.

## Netværk & Tilgængelighed

### Global Lytning (0.0.0.0)
Serveren er konfigureret til at binde til `0.0.0.0` i Docker-containeren. Dette, kombineret med port-mapping i `docker-compose.yml`, gør serveren tilgængelig på værtens IP-adresse for alle enheder på lokalnetværket.

- **Port:** 4096
- **Endpoint:** `http://<VÆRTENS-IP>:4096`

## Setup & Operationer

### Installation & Udrulning
Da opsætningen er baseret på Docker, er den identisk på alle maskiner:
1. Klon eller kopier denne mappe til den ønskede PC.
2. Start serveren:
   ```bash
   docker-compose up -d --build
   ```

### Stop Serveren
```bash
docker-compose down
```

## Anvendelse
Denne server er designet til at modtage kald fra:
- Lokale udviklingsmiljøer på samme maskine.
- Andre computere eller microservices på dit LAN.
- Automationer eller agenter, der kræver en stabil AI-backend uden at skulle installere tunge afhængigheder lokalt på hver klient.

## Udviklingskonventioner
- **Portabilitet:** Docker-opsætningen sikrer, at serveren opfører sig ens uanset hardware.
- **Enkelhed:** Ingen lokal installation af Node.js eller pakker er nødvendig på værtsmaskinen; alt kører isoleret i Docker.
