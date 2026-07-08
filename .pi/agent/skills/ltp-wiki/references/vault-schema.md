# Vault Schema — LTP Wiki

## Paths

| Layer | Path |
|---|---|
| Vault root | `/mnt/c/Users/joao.barbosa/LTP/` |
| Wiki (LLM-owned) | `/mnt/c/Users/joao.barbosa/LTP/wiki/` |
| Raw sources (read-only) | Everything else in vault |

## Wiki Directory Layout

```
wiki/
├── index.md          # catalog — one line per page
├── log.md            # append-only operation log
├── overview.md       # high-level synthesis of the whole vault
├── projects/
│   ├── AIR.md        # main data platform / asset ingestion tool
│   ├── CARE.md       # design system + MCA001 product
│   ├── TILE.md       # product (see TILE/Description.md)
│   └── AYA.md        # "And You Are" product
├── tools/
│   ├── Keycloak.md   # auth/SSO — used by AIR, CARE
│   ├── ArgoCD.md     # GitOps CD tool
│   ├── Grafana.md    # monitoring/dashboards
│   ├── RabbitMQ.md   # message broker
│   └── FastAPI.md    # Python web framework
├── processes/
│   └── ISO27001.md   # information security management
└── people/
    └── (create as needed — e.g., tiago-ribeiro.md)
```

## Raw Source → Wiki Category Mapping

| Raw source location | Wiki category |
|---|---|
| `AIR/`, `AIR*.md`, `FDS + AIR.md`, `custom gpt && AIR.md` | `wiki/projects/AIR.md` |
| `CARE*.md`, `MCA001*.md`, `Meeting notes MCA*.md`, `PRD MCA*.md` | `wiki/projects/CARE.md` |
| `TILE/` | `wiki/projects/TILE.md` |
| `AYA*.md`, `Aya.md` | `wiki/projects/AYA.md` |
| `Keycloak*.md`, `Demo Realm.md` | `wiki/tools/Keycloak.md` |
| `ARGOCD.md`, `Intro to deployments.md` | `wiki/tools/ArgoCD.md` |
| `Grafana.md` | `wiki/tools/Grafana.md` |
| `RabbitMQ.md` | `wiki/tools/RabbitMQ.md` |
| `FastAPI.md` | `wiki/tools/FastAPI.md` |
| `ISO270001/` | `wiki/processes/ISO27001.md` |
| `Service Accounts.md`, `Secrets Management.md` | `wiki/tools/ArgoCD.md` or new `wiki/processes/secrets.md` |
| `Software in Use.md` | `wiki/overview.md` |
| `tiago ribeiro.md` | `wiki/people/tiago-ribeiro.md` |
| `Untitled*.md`, `trash.md` | Skip unless content found |

## Page Frontmatter (add to every wiki page)

```yaml
---
tags: [wiki, <category>]       # e.g. wiki, project
sources: [<list of raw files>] # e.g. ["AIR/AIR.md", "AIR Deployment Guide.md"]
updated: YYYY-MM-DD
---
```

## index.md Format

```markdown
# Wiki Index
_Last updated: YYYY-MM-DD_

## Projects
- [[wiki/projects/AIR]] — Data platform for asset ingestion and management (N sources)
- [[wiki/projects/CARE]] — Design system and MCA001 product (N sources)
...

## Tools
- [[wiki/tools/Keycloak]] — Auth/SSO layer (N sources)
...

## Processes
- [[wiki/processes/ISO27001]] — Information security management (N sources)
...
```

## log.md Format

Each entry starts with a parseable prefix:

```markdown
## [YYYY-MM-DD] ingest | <source name>
Brief: what was added, which pages were touched.

## [YYYY-MM-DD] query | <question summary>
Brief: what pages were read, answer summary.

## [YYYY-MM-DD] lint | health check
Brief: issues found, fixes applied.
```

Parse recent entries: `grep "^## \[" wiki/log.md | tail -10`

## Wikilink Style

Use Obsidian wikilinks throughout: `[[wiki/projects/AIR]]`  
For cross-references between wiki pages, always use wikilinks — not relative paths.
