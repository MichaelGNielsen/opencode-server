# Markdown Formatteringsregler


Disse regler sikrer konsistent Markdown-formatering på tværs af projektet.

## Grundlæggende Regler

- Kun én H1-overskrift (`#`) per fil.
- Overskrifter skal følge et sekventielt hierarki (`#` -> `##` -> `###`, osv.) uden spring.
- Der skal altid være en tom linje efter en overskrift (f.eks. efter `# Min Overskrift`).
- Afslut altid filer med en tom linje efter sidste tekst.

## Lister

- Brug kun bindestreg (`-`) til punktlister (unordered lists).
- Der skal altid være en tom linje før starten af en punktliste.
- Brug præcis ét mellemrum efter bindestregen i punktlister (f.eks. `- Dette er et listepunkt`).

## Eksempler på Korrekt Formatering

### Overskrifter

En overskrift skal efterfølges af præcis én tom linje.

```markdown
# Hovedoverskrift

## Under-overskrift

Dette er tekst efter en overskrift.
```

### Lister og Kodeblokke

Der skal være præcis én tom linje før både punktlister og kodeblokke. Lister skal bruge bindestreg (`-`) efterfulgt af ét mellemrum.

```bash
npm install
```

Dette er tekst efter kodeblokken.
