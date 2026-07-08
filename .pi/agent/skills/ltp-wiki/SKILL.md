---
name: ltp-wiki
description: "Maintain, ingest, query, and lint the LTP Obsidian vault wiki at /mnt/c/Users/joao.barbosa/LTP. Use when the user asks to ingest a note or source into the wiki, query the wiki for information, lint/health-check the wiki, bootstrap the wiki structure for the first time, or organize/synthesize vault notes. Triggers on: ingest this, add to wiki, what does the wiki say about X, query the wiki, lint the wiki, organize my notes, bootstrap the wiki, update the wiki."
---

# LTP Wiki Maintainer

Vault: `/mnt/c/Users/joao.barbosa/LTP`  
Wiki: `/mnt/c/Users/joao.barbosa/LTP/wiki/`  
Raw sources: all `.md` files NOT inside `wiki/` — treat as immutable (read-only)

**Read [vault-schema.md](references/vault-schema.md) first** — it defines the wiki structure, categories, frontmatter conventions, and taxonomy for this specific vault.

**Read [workflows.md](references/workflows.md)** for step-by-step procedures for each operation.

## Operations

### Bootstrap (first-time setup)
Run when `wiki/` does not exist or `wiki/index.md` is missing.

1. Create `wiki/` directory structure (see vault-schema.md for layout)
2. Create `wiki/index.md` (empty catalog skeleton)
3. Create `wiki/log.md` (empty log)
4. Create `wiki/overview.md` (high-level synthesis — fill after first few ingests)
5. Bulk-ingest existing vault notes by domain (see workflows.md → Bulk Ingest)

### Ingest
Process a source note into the wiki. Single source preferred; batch possible.

See workflows.md → Ingest Workflow for the full procedure.

### Query
Answer a question by reading wiki pages, not raw sources.

1. Read `wiki/index.md` to identify relevant pages
2. Read those pages
3. Synthesize answer with citations (`[[wiki/projects/AIR]]` style)
4. If answer is valuable, offer to file it as a new wiki page

### Lint
Health-check the wiki for quality issues.

See workflows.md → Lint Workflow for the checklist.

## Search

Use the search script to find content across wiki pages:

```bash
bash /home/jbarbosa/.claude/skills/ltp-wiki/scripts/wiki-search.sh "<term>"
```

Check wiki status (orphans, recent log):

```bash
bash /home/jbarbosa/.claude/skills/ltp-wiki/scripts/wiki-status.sh
```

## Key Rules

- Never modify raw source files — read only
- Always update `wiki/index.md` and append to `wiki/log.md` after every ingest
- Cross-link aggressively using `[[wiki/path/to/page]]` Obsidian wikilinks
- Add YAML frontmatter to every wiki page (see vault-schema.md)
