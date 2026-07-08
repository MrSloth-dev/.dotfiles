---
name: handoff
description: "Write or update a HANDOFF.md document so the next agent with fresh context can continue in-progress work. Use when the user wants to hand off, checkpoint, or summarize work for a future session or agent. Triggers on: write a handoff, create handoff doc, /handoff, summarize progress for next session, checkpoint this work, create a handoff so I can continue later."
---

# Handoff

## Workflow

1. Check if `HANDOFF.md` exists in the project root.
2. If it exists, read it first to understand prior context before updating.
3. Gather context from the current conversation: goal, progress, decisions, failures, next steps.
4. Write or update `HANDOFF.md` with the structure below.
5. Tell the user the exact file path.

## Document Structure

```markdown
# Handoff

## Goal
What we're trying to accomplish and why.

## Current Progress
What has been completed. Be specific: file paths, function names, endpoints changed.

## What Worked
Approaches or decisions that succeeded and should be continued.

## What Didn't Work
Approaches that failed or were abandoned, and why. Prevents repeating mistakes.

## Next Steps
Ordered, actionable items. Each item must be self-contained enough to act on without re-reading the full conversation.

## Context / Notes
Non-obvious constraints, gotchas, or decisions that shape future work.
```

## Guidelines

- Be specific: file paths, line numbers, function names — not vague summaries.
- "What Didn't Work" is critical: future agents repeat failures without it.
- Next Steps must be actionable — not "continue the work" but "implement X in file Y using pattern Z".
- Omit sections with nothing to say rather than writing filler.
- This document replaces the full conversation context; every sentence earns its place.
