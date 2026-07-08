---
name: ltplabs-design
description: Strict LTPLABS Plotly design-system guidance for reusing existing components, preserving the template structure, following curated documentation, and deciding when a new component needs UX-UI approval. Use when working in this repo on UI composition, component selection, documentation-driven implementation, or any task that may require a new component.
---

# LTPLABS Design System

## Purpose

Use this skill when working in the LTPLABS Plotly design-system repository and you need to preserve the existing template structure, reuse modified components, or follow the repo documentation before changing UI code.

## Workflow

1. Read `references/repo-map.md` first.
2. Prefer an existing component, page pattern, or template over creating new UI.
3. Follow the component docs and page docs that match the target area.
4. Keep changes minimal and aligned with the current repo structure.
5. If a needed component already exists but needs different behavior, adapt the existing one rather than creating a duplicate.
6. If no existing component fits, stop and write a UX-UI follow-up note.
7. Create a new component only if the user explicitly authorizes it with `a teresa deixa` or a clearly equivalent approval.
8. If the docs are ambiguous or conflict with implementation, do not guess; ask for clarification.

## Required Checks

- Verify the target lives under the existing component/page structure.
- Check the matching README or documentation page before editing.
- Confirm prop names, defaults, and examples against the curated references.
- Preserve documented layout and doc-page behavior unless the task explicitly asks otherwise.

## Output

- State which existing component or template you reused.
- If a new component would be needed, record it as a UX-UI note instead of building it.
- Separate implementation notes from UX-UI follow-up notes.

## References

- `references/repo-map.md`
- `references/component-rules.md`
- `references/change-policy.md`
