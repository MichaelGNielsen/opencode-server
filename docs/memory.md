# memory.md — Persistent hukommelse på tværs af sessioner

## Arkitektur-beslutninger

### Docker Compose bruger pre-built image, ikke Dockerfile
`docker-compose.yml` trækker `ghcr.io/anomalyco/opencode:latest` direkte. `Dockerfile` er en alternativ lokal-build sti og bruges ikke af compose. Ændringer i Dockerfile påvirker ikke den kørende server medmindre compose-filen ændres til at bruge `build: .` i stedet for `image:`.

### Workspace mount: `../:/workspace`
Containeren ser rodbiblioteket over dette repo som `/workspace`. Det betyder at alle projekter i parent-mappen er tilgængelige for OpenCode. Dette er bevidst for at give agenten adgang til hele udviklingsmiljøet.

## Faldgruber (Lærte den hårde vej)

## Nyttige mønstre

## Status-tabeller
