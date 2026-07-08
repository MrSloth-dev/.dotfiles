---
name: mr-message
description: Use this skill when the user asks to "write an MR message", "generate a merge request description", "draft an MR", "write a PR message", or wants to prepare a merge/pull request description for the current branch. Analyzes the diff between the current branch and a target branch.
version: 1.0.0
tools: Bash
---

# MR Message

Generates a well-structured Merge Request message by analyzing the diff between the current branch and a target branch provided as an argument.

## Argument

`$1` — the target branch to diff against (e.g. `main`, `develop`). If not provided, default to `main`.

## Workflow

Follow these steps in order:

### 1. Gather context

Run the following commands in parallel:

```bash
# Commit log between target and current branch
git log $1..HEAD --oneline

# Full diff between target branch and current branch
git diff $1...HEAD

# Current branch name
git rev-parse --abbrev-ref HEAD
```

### 2. Analyze the diff

From the diff and commit log, identify:
- **What changed**: files touched, modules affected, added/removed/modified behaviour
- **Why it changed**: infer intent from commit messages, variable names, and surrounding code
- **Type of change**: new feature, bug fix, refactor, docs, chore, config, test, etc.

### 3. Write the MR message

Produce a message in this structure:

```
## Summary

<1-3 bullet points describing what this MR does and why>

## Changes

<Bulleted list of notable changes, grouped logically if needed>
```

**Title** (one line, under 72 characters):
- Prefix with type: `feat:`, `fix:`, `refactor:`, `chore:`, etc.
- Imperative mood: "Add X", "Fix Y", "Remove Z"

## Rules

- Focus on the **why**, not just the what
- Be concise — avoid padding or filler sentences
- Group related changes together
- If the diff is large, summarize by area/module rather than listing every file
- Do not invent behaviour not present in the diff
- Output the title first, then the body in a single fenced block so it is easy to copy
