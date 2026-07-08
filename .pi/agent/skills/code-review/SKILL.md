---
name: code-reviewer
description: review backend code against project documentation stored in /docs, identify discrepancies, ask which source should prevail for each discrepancy, update the documentation directly, and write a plan.md for the code changes. use when reconciling a backend repository with brd/prd/technical docs, especially when the docs live in /docs and the goal is to compare implementation with documented behavior before planning code work.
---

# Code Reviewer

## Overview

Compare a backend codebase against the documentation in `/docs`, surface mismatches, resolve them with user decisions, and update the documentation so it matches the agreed source of truth. Then produce `plan.md` describing the code changes that should follow.

## Workflow

Follow this order every time:

1. **Index check** — call `list_projects`. If the repo is not indexed, call `index_repository` on the working directory root before proceeding. Wait for indexing to complete (`index_status`) before reading code.
2. Read all documentation under `/docs`.
3. Inspect the backend codebase using codebase-memory tools (see below). Prioritize entrypoints, routes, services, models, schemas, integrations, validations, workflows, and tests.
4. Compare implementation to documentation feature by feature and rule by rule.
5. Collect all discrepancies before asking questions.
6. Present the discrepancies in a single report and ask which source should prevail for each one.
7. After the user answers, update the documentation directly.
8. Write `plan.md` with the code-change plan that corresponds to the resolved discrepancies.

## Code exploration — use codebase-memory tools

Prefer graph tools over raw file reads. They return precise structural results in ~500 tokens vs ~80K for grep.

| Need | Tool |
|------|------|
| Find routes / handlers | `search_graph(label="Function", name_pattern=".*router.*\|.*endpoint.*\|.*route.*")` |
| Find models / schemas | `search_graph(label="Class", name_pattern=".*Model.*\|.*Schema.*\|.*Entity.*")` |
| Trace what a function calls | `trace_path(function_name="X", direction="outbound")` |
| Read source of a symbol | `get_code_snippet(qualified_name="project.module.ClassName")` |
| Understand overall structure | `get_architecture(aspects=["modules", "layers"])` |
| Text search fallback | `search_code(pattern="keyword")` |

Only fall back to direct `Read` for config files, non-code text (e.g. `.ini`, `.toml`), or when a specific file path is already known and graph tools won't help.

## Review rules

- Treat `/docs` as the canonical documentation source unless the user decides otherwise for a specific discrepancy.
- Do not invent requirements that are not documented.
- Do not assume code behavior is correct just because it exists.
- Focus on business rules, workflows, data models, validations, integrations, error handling, permissions, and other backend behavior that affects the documented system.
- Ignore frontend-only details unless they affect backend contracts.
- If multiple documentation files disagree, identify the exact conflicting files and sections.
- Cite concrete evidence from file paths, class names, functions, endpoints, schemas, tests, and doc sections.
- Do not modify code in this skill; only update documentation and create `plan.md`.

## First-pass discrepancy report

Use this structure:

# Review summary

## Main alignment
State whether the backend is mostly aligned, partially aligned, or significantly divergent.

## Discrepancies
For each item, include:
- ID
- Area
- Documentation reference
- Code reference
- What differs
- Impact
- Which source should prevail: documentation / code / needs clarification

## Decisions needed
List all unresolved discrepancies as one decision set so the user can answer them in batch.

## Documentation update scope
List the doc files that will need edits once the decisions are made.

## Code-change plan
Briefly describe the code changes that should be planned, but do not implement them.

## Documentation update phase
After the user resolves the discrepancies:
- edit the relevant files under `/docs` directly
- remove or revise outdated text rather than appending contradictory notes
- keep terminology consistent across all docs
- write `plan.md` with the agreed follow-up code work, file targets, and sequencing
- include a short changelog of what changed in the docs

## plan.md contents
`plan.md` should contain:
- resolved discrepancy list
- proposed backend changes
- affected files or modules
- implementation order
- open questions, if any remain

## Expected behavior
- Ask one batch of decision questions after gathering all discrepancies.
- Update documentation directly once decisions are received.
- Save the implementation plan to `plan.md`.
- Keep the output precise and evidence-based.
