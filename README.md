# OpenCode AI Server (Dockerized)

Dette projekt leverer en enkel, containeriseret version af **OpenCode AI Server**, som er designet til at fungere som en central AI-backend for dit lokale netværk (LAN).

Ved at køre denne server i Docker, kan du nemt stille AI-funktionalitet til rådighed for alle dine computere og services uden at skulle installere Node.js eller andre afhængigheder manuelt på hver maskine.

## Egenskaber

- **LAN-klar:** Serveren lytter på `0.0.0.0`, hvilket gør den tilgængelig fra andre enheder på dit netværk.
- **Isoleret:** Kører i en Docker-container (Node 20-slim), så det ikke roder med din værtsmaskines opsætning.
- **Portabel:** Kan startes på enhver maskine med Docker installeret (Windows/WSL2, NUC, Linux osv.).

## Hurtig start

1. **Start serveren:**
   Kør følgende kommando i denne mappe:

   ```bash
   docker-compose up -d --build
   ```

2. **Stop serveren:**

   ```bash
   docker-compose down
   ```

## Anvendelse

Når serveren kører, kan den tilgås på port **4096**. OpenCodes standardport (4096), så kan andre brugere også tilgå den på den normale standart port.

- **Fra samme maskine:** `http://localhost:4096`
- **Fra andre maskiner på netværket:** `http://<VÆRTENS-IP>:4096`

Serveren bruger det officielle `ghcr.io/anomalyco/opencode` Docker-image og er konfigureret til at køre med `serve --hostname 0.0.0.0`.

## API Guide
For instructions on how to call OpenCode using cURL and manage sessions, see: [OpenCode API How-To](docs/opencode_howto.md)

## Metafiles Guide
For instructions on how to use project metafiles (`memory.md`, `journal.md`, `skills.md`, `TODO.md`) for persistent agent context across sessions, see: [OpenCode Metafiles How-To](docs/opencode-metafiles-howto.md)

## Krav

- Docker
- Docker Compose

## Documentation

| Dokument | Beskrivelse |
|----------|-------------|
| [GEMINI.md](GEMINI.md) | Projektets kontrakt og meta-engineering principper for agenten |
| [docs/opencode_howto.md](docs/opencode_howto.md) | API-vejledning: cURL-kald og session-håndtering |
| [docs/opencode-metafiles-howto.md](docs/opencode-metafiles-howto.md) | Metafiler (`memory.md`, `journal.md`, `skills.md`, `TODO.md`) — persistent agent-kontekst på tværs af sessioner |
| [docs/md-rules.md](docs/md-rules.md) | Markdown formaterings-regler for projektet |
