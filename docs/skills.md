# skills.md — Agent Meta-Skills for OpenCode Server

## Docker Workflow

### Start serveren
```bash
docker-compose up -d --build
```

### Stop serveren
```bash
docker-compose down
```

### Genstart efter config-ændringer
Config-ændringer i `docker-compose.yml` kræver `docker-compose up -d --build` (ikke bare `restart`).

### Tjek server-status
```bash
docker ps --filter name=opencode
```

### Se logs
```bash
docker logs opencode
```

## API Test

### Opret session og send besked (ét script)
```bash
SESSION=$(curl -s -X POST http://localhost:4096/session -H "Content-Type: application/json" -d '{}' | jq -r '.id')
curl -s -X POST "http://localhost:4096/session/$SESSION/message" \
  -H "Content-Type: application/json" \
  -d '{"parts":[{"type":"text","text":"sig hej"}]}' | jq '.parts[] | select(.type=="text") | .text'
```

## File Locations Huskeliste

| Ressource | Lokation |
|-----------|----------|
| Docker Compose config | `docker-compose.yml` |
| Alternativ Dockerfile | `Dockerfile` |
| Projekt kontrakt | `GEMINI.md` |
| API howto | `docs/opencode_howto.md` |
| Metafile howto | `docs/opencode-metafiles-howto.md` |
| Markdown regler | `docs/md-rules.md` |
| Persistent hukommelse | `docs/memory.md` |
| Job log | `docs/journal.md` |
| Opgaveliste | `docs/TODO.md` |
