# Workflows — LTP Wiki

## Ingest Workflow

Goal: process one raw source note into the wiki, touching all relevant pages.

```
1. Read the source file (raw — do not modify)
2. Extract: key entities, concepts, decisions, open questions, relationships
3. Determine which wiki pages to update (use vault-schema.md mapping)
4. For each affected wiki page:
   a. Read existing page (if it exists)
   b. Merge new info — update summaries, add details, flag contradictions
   c. Add/update cross-links to related pages
   d. Update `sources:` frontmatter field
5. Update wiki/index.md — add page if new, update source count
6. Append entry to wiki/log.md
```

**When source contradicts existing wiki content:** flag it inline:
```markdown
> ⚠️ Contradiction: [old-source] says X but [new-source] says Y. Needs resolution.
```

**Batch ingest** (many sources at once): group by category, ingest all sources for one wiki page before moving to next. Still update index and log after each batch.

## Bulk Ingest (Bootstrap)

Run once after wiki/ is first created to seed it from all existing vault notes.

```
1. Process by category in this order:
   a. projects/ (AIR → CARE → TILE → AYA)
   b. tools/ (Keycloak → ArgoCD → Grafana → RabbitMQ → FastAPI)
   c. processes/ (ISO27001)
   d. people/ (as encountered)
2. For each category: gather all mapped raw files, read them, write wiki page
3. After all categories: write wiki/overview.md as cross-domain synthesis
4. Write initial wiki/index.md
5. Append single log entry: [date] ingest | BOOTSTRAP — N files across M pages
```

Skip: `Untitled*.md`, `trash.md`, `Excalidraw/*.md` (diagrams, no prose), `.mdenc` files (encrypted).

## Query Workflow

```
1. Read wiki/index.md to identify relevant pages
2. Read those pages (1-5 usually sufficient)
3. Synthesize answer with inline citations:
   "AIR uses Keycloak for authentication ([[wiki/tools/Keycloak]])"
4. Note gaps: "wiki/tools/RabbitMQ.md has no info on X — check raw source RabbitMQ.md"
5. If answer is valuable synthesis, offer: "File this as wiki/analyses/<topic>.md?"
6. Append to log: [date] query | <question summary>
```

## Lint Workflow

Run periodically to keep the wiki healthy.

Checklist:
```
[ ] Orphan pages — pages with no inbound wikilinks from other wiki pages
[ ] Missing pages — concepts mentioned (e.g. [[wiki/tools/X]]) but no file exists
[ ] Stale content — source files modified more recently than wiki page updated date
[ ] Contradictions — ⚠️ flags still unresolved
[ ] Empty or stub pages — pages with < 5 lines of content
[ ] index.md gaps — wiki pages that exist but aren't in index
[ ] Cross-link gaps — entities mentioned by name but not linked
```

Run status script first:
```bash
bash /home/jbarbosa/.claude/skills/ltp-wiki/scripts/wiki-status.sh
```

After fixing issues: append log entry `[date] lint | <summary of issues found/fixed>`

## New Page Decision

Create a new wiki page when:
- A concept/entity appears in 2+ sources and has enough substance for its own page
- A query answer is rich enough to be reusable (file under `wiki/analyses/`)
- A person is referenced with context (file under `wiki/people/`)

Don't create pages for: one-off meeting notes, ephemeral tasks, encrypted files.
