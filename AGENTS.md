# AGENTS.md

## Project nature
This is a **Docker deployment config repo** for OpenCode AI Server — no source code, no tests, no build pipeline. The actual server is the pre-built image `ghcr.io/anomalyco/opencode:latest`.

## Commands
- Start: `docker-compose up -d --build`
- Stop: `docker-compose down`
- Server listens on port **4096**, bound to `0.0.0.0`

## Key config details
- The `Dockerfile` is **not used** by `docker-compose.yml` (which pulls the pre-built image). The Dockerfile is an alternative local-build path.
- Workspace mount: `../:/workspace` — the container sees the **parent directory** of this repo as `/workspace`.
- Project name in compose: `opencode`

## Documentation
- All docs are in **Danish**.
- `GEMINI.md` — project contract and meta-engineering principles (read first).
- `docs/opencode_howto.md` — API usage: `POST /session` then `POST /session/{id}/message`.
- `docs/opencode-metafiles-howto.md` — metafile pattern (`memory.md`, `journal.md`, `skills.md`, `TODO.md`) for persistent agent context.
- `docs/md-rules.md` — Markdown formatting conventions for the project.

## Agent Memory & Journal
- **`docs/memory.md`**: Persistent memory across sessions — architectural decisions, pitfalls, patterns. Read at session start, update when something worth remembering is discovered.
- **`docs/journal.md`**: Chronological job log. Write one line per completed job.
- **`docs/skills.md`**: Agent meta-skills — procedures for recurring tasks. Read on-demand.
- **`docs/TODO.md`**: Task list and status. See `docs/TODO.md` for current items.
