# OpenCode Metafiles How-To

Denne guide forklarer de fire **metafiler** som en OpenCode-agent kan bruge i et projekt for at opretholde hukommelse, tracke progress, dele færdigheder og administrere opgaver på tværs af sessioner.

Metafilerne er almindelige Markdown-filer i projektets rodmappe. De refereres fra projektets `AGENTS.md` (som OpenCode læser automatisk ved session-start), så agenten ved de findes og hvornår de skal læses/opdateres.

| Fil | Formål | Læses | Opdateres |
|-----|--------|-------|-----------|
| `memory.md` | Persistent hukommelse | Ved session-start | Når der er noget værd at huske |
| `journal.md` | Kronologisk job-log | Ved session-start | Én linje pr. afsluttet job |
| `skills.md` | Agent meta-skills | Når du skal udføre tilbagevendende opgaver | Når nye procedurer er lært |
| `TODO.md` | Opgaveliste og status | Ved session-start | Når opgaver tilføjes/fuldføres |

---

## 1. `memory.md` — Persistent hukommelse

**Formål:** Bevare viden der er svær at gen-opdage på tværs af sessioner. Hver ny session starter med en frisk kontekst, så arkitektoniske beslutninger, faldgruber og mønstre der tog timer at finde, vil gå tabt uden denne fil.

**Hvad skrives:**
- Arkitektoniske beslutninger og hvorfor de blev truffet
- Faldgruber ("lærte den hårde vej") med rodårsag og løsning
- Nyttige mønstre der genbruges
- Status-tabeller (f.eks. spoke health, integration-tilstand)
- Konfigurations-værdier der er svære at finde

**Hvad IKKE skrives:**
- Forbigående debugging-state (det hører til journal.md)
- Kildekode (det hører i filerne)
- Trivielle observationer

**Eksempel-struktur:**
```markdown
# memory.md - Persistent hukommelse på tværs af sessioner

## Arkitektur-beslutninger
### Event-Driven Autonomy
Spokes ejer egne cron-schedules. Hub lytter for SSE notifications...

## Faldgruber (Lærte den hårde vej)
### Elite signals freeze (28. jun 2026)
Symptom: Dashboard viste "Stage 2 for 49 dage siden" — frosset.
Rodårsag: scan_elite.run_elite_scan() ikke koblet på nogen cron...
Løsning: scripts/cron/elite_scan.sh med stale-check.
Lektion: Når et dashboard viser "for N dage siden" konsistent, tjek cron.

## Nyttige mønstre
### Idempotent stale-check cron pattern
...

## Status-tabeller
| Komponent | Status | Bemærkning |
|-----------|--------|-----------|
```

**Hvornår opdateres:** Efter ethvert job der har afsløret en faldgrube, et mønster eller en beslutning værd at huske. Skriv **imens** du arbejder, ikke først ved session-slut.

---

## 2. `journal.md` — Kronologisk job-log

**Formål:** Progress-tracking. En simpel tidsordnet log over hvilke jobs der er udført, så du kan se hvad der er sket på tværs af sessioner uden at skulle læse hele memory.md.

**Hvad skrives:**
- Én linje (eller kort blok) pr. afsluttet job
- Dato, job-navn, hvad der blev gjort, status
- Korte referencer til filer der blev ændret

**Hvad IKKE skrives:**
- Detaljerede diagnoser (det hører i memory.md)
- Kildekode
- TODOs (det hører i TODO.md)

**Eksempel-struktur:**
```markdown
# journal.md - Kronologisk log af udførte jobs

## 2026-06-28

- **2026-06-28 | Elite cron-fix (StocksDash) | Status: ✅ Færdig**
  - Oprettet scripts/cron/elite_scan.sh med stale-check (6t threshold).
  - Tilføjet cron-entry 0 09-17 * * 1-5 i crontab.
  - Genbygget stocksdash-cron container. Regenereret elite_signals.json.

- **2026-06-28 | Market-Intelligence MCP fix | Status: ✅ Færdig**
  - Tilføjet get_system_status tool.
  - Rettet MARKET_INTELLIGENCE_URL fra /sse til /mcp i docker-compose.yml.
```

**Hvornår opdateres:** Umiddelbart efter et job er afsluttet. Brug status-værdierne `✅ Færdig`, `🔄 I gang`, `⏸️ Pauset`, `❌ Afbrudt`.

---

## 3. `skills.md` — Agent meta-skills

**Formål:** Procedurer og best-practices for arbejde i projektet. Hvor memory.md beskriver **hvad** der er besluttet, beskriver skills.md **hvordan** man udfører tilbagevendende opgaver effektivt.

**Hvad skrives:**
- Debug-procedurer (f.eks. "når en spoke er offline, følg disse 5 trin")
- Workflow-best-practices (f.eks. "hvornår genstart vs. genbyg")
- Verifikations-procedurer (f.eks. "sådan tjekker du data-freshness")
- Gentagne mønstre med reference-implementationer
- Huskelister (f.eks. file locations)

**Hvad IKKE skrives:**
- Engangs-beslutninger (det hører i memory.md)
- Specifikke jobs (det hører i journal.md)
- Kildekode-dokumentation (det hører i kode-kommentarer / docs/)

**Eksempel-struktur:**
```markdown
# skills.md - Agent Meta-Skills for GlobalSentinel

## MCP Debugging
### Når en spoke er offline i hub health-check
1. Tjek fejlbesked — "Cannot POST /sse" betyder typisk...
2. Tjek docker-compose.yml env vars — kan overskrive kode-defaults...
3. Tjek at get_system_status tool findes...
4. Verificér raw HTTP først...
5. Tjek STREAMABLE_HTTP_SPOKES listen...

## Docker Workflow
### Efter kodeændringer
- Hub: ./src:/app/src mounted → docker restart...
- MI, NN: source baked → docker compose up -d --build...

## File Locations Huskeliste
| Ressource | Lokation |
|-----------|----------|
```

**Hvornår opdateres:** Når du har udført en procedure flere gange og ser et mønster der kan formaliseres, ELLER når du har lært en ny færdighed der vil være nyttig i fremtiden.

---

## 4. `TODO.md` — Opgaveliste og status

**Formål:** Holde styr på opgaver og deres status på tværs af sessioner. Selvstændig fil så `AGENTS.md` (som er instruktioner til agenten og måske overskrives af opencode-versions) ikke mister TODO-data.

**Hvad skrives:**
- Aktuelle opgaver med `[ ]` / `[x]` check-boxes
- Korte beskrivelser med kontekst (fil-stier, rodårsag)
- "Gennemført" sektioner med dato for afsluttede faser
- Reference til mere detaljeret dokumentation hvor relevant

**Hvad IKKE skrives:**
- Diagnoser (det hører i memory.md)
- Job-log (det hører i journal.md)
- Arkitektoniske beslutninger (det hører i memory.md)

**Eksempel-struktur:**
```markdown
# 🚀 GlobalSentinel TODO & Status

## 🔥 Aktuelle opgaver (2026-06-28)
- [ ] Fix remaining StocksDash scanner test failures...
- [ ] Ensure all spokes correctly receive AI config updates...

### ✅ Gennemført (2026-06-28)
- [x] **StocksDash Elite cron-fix:** scripts/cron/elite_scan.sh...
- [x] **Market-Intelligence MCP fix:** Tilføjet get_system_status tool...

## ✅ Gennemført (Phase 4: Elite Intelligence - 2026-05-10)
- **Elite Signals (The Power Trinity):** Implementeret filter...
```

**Hvornår opdateres:**
- Når en opgave identificeres → tilføj under "Aktuelle opgaver"
- Når en opgave fuldføres → flyt til "Gennemført" sektion med dato
- Ved session-start → læs for at vide hvad der er i kø

---

## Integration med `AGENTS.md`

Metafilerne refereres fra `AGENTS.md` i en dedikeret sektion, så agenten ved de findes:

```markdown
## Agent Memory & Journal
- **`memory.md`**: Persistent hukommelse på tværs af sessioner — arkitektoniske
  beslutninger, faldgruber, mønstre. Læses ved session-start, opdateres når der
  er noget værd at huske.
- **`journal.md`**: Kronologisk log af udførte jobs (dato, opgave, status). Skriv
  én linje pr. afsluttet job.
- **`skills.md`**: Agent meta-skills — procedurer for tilbagevendende opgaver.
  Læses når du skal udføre tilbagevendende opgaver.
- **`TODO.md`**: Opgaveliste og status. Se `TODO.md` for aktuelle items.
```

`AGENTS.md` selv bør kun indeholde **instruktioner til agenten** (arkitektur, commands, conventions), ikke TODO-data eller detaljeret hukommelse — det lever i metafilerne.

---

## Workflow: Session-start

En ny OpenCode-session starter med at agenten læser:

1. **`AGENTS.md`** (automatisk) — forstår projektet, commands, conventions
2. **`memory.md`** (manuel) — genkender faldgruber og mønstre fra tidligere sessioner
3. **`journal.md`** (manuel) — ser hvad der senest er udført
4. **`TODO.md`** (manuel) — ser hvad der er i kø

Herefter kan agenten læse **`skills.md`** on-demand når den skal udføre en procedure der er dokumenteret der.

## Workflow: Job-afslutning

Når et job er afsluttet:

1. **`journal.md`** — tilføj én linje med dato, job-navn, status
2. **`TODO.md`** — flyt opgave til "Gennemført" sektion hvis den var listet
3. **`memory.md`** — opdater hvis jobbet afslørede en ny faldgrube, beslutning eller mønster
4. **`skills.md`** — opdater hvis jobbet formaliserede en ny procedure

Dette sikrer at næste session starter med fuld kontekst og ikke skal gen-opdage de samme ting.