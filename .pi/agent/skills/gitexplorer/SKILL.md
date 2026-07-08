---
name: gitexplorer
description: Run the five git diagnostics from the "Git Commands I Run Before Reading Any Code" essay to audit churn, bug density, velocity, and emergency work. Use when the user needs a repeatable repo health report built from those commands (hotspots, contributor breakdown, bug clusters, velocity curve, and revert frequency).
---

# Git Explorer

Target this skill whenever a request mentions "git audit", "repo health", or the five diagnostics from the essay (churn hotspots, who built the code, bug clusters, commit velocity, and revert frequency). It pairs each command with commentary so you can copy, run, and interpret the results without recreating the workflow each time.

## Workflow

1. Run each of the commands listed in this essay in the order they appear so you capture a full diagnostic picture: churn hotspots, contributor shortlog, bug-related files, commits per month, and revert/hotfix frequency. Copy the exact incantations from `references/command-guide.md` to keep filters consistent with the original guidance.
2. For every command, capture the top results and pair them with the insights the essay associates with them (e.g., compare churn vs. bug-hot files, flag contributors who pushed the majority of commits, watch for momentum shifts in the velocity chart, and count how often revert/hotfix keywords appear).
3. Package the observations into a brief report (bullet list or paragraph) that highlights: the riskiest files, potential bus-factor contributors, whether development velocity is steady or declining, and whether reverts/hotfixes are frequent.

## Report Structure

- **Churn vs. Bugs**: Note the top 5 files from the churn command and mark the ones that also show up in the bug-cluster command to identify fragile areas.
- **People Risk**: Summarize `git shortlog --no-merges` output and call out any single contributors responsible for ~60%+ of commits or whose activity disappears when filtering the last six months.
- **Momentum**: Describe the commit velocity command results (steady, spiking, dipping) and tie them to what the essay says about reading that pattern.
- **Emergency Work**: Flag whether the revert/hotfix command produced frequent matches, which can indicate pipeline distrust.
- **Next Steps**: Recommend follow-ups such as reviewing files that bubble up in multiple commands or inquiring about contributors who dominate the log.

## References

Use `references/command-guide.md` whenever you need the full reasoning behind a command, its expected output, and the interpretations described in the essay. Keep that file handy so you don't overload this overview with long explanations.
