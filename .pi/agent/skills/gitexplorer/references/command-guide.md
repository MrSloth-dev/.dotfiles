# Git Explorer Command Guide

This file holds the precise commands and the rationale carried in the essay "The Git Commands I Run Before Reading Any Code." Load it whenever you need to run the diagnostics or interpret your findings without reading the entire skill every time.

## 1. Churn Hotspots (High-Risk Files)
- **Command**
  ```bash
  git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20
  ```
- **Purpose**: Shows the 20 files that have been touched most often in the last year. High churn indicates a complex or controversial file.
- **Interpretation**: Cross-reference this list with the bug-cluster command below; files that appear in both lists are the repo's highest fragility points. Consider documenting why each file churns so frequently before making changes.

## 2. Who Built the Code (Contributor Distribution)
- **Command**
  ```bash
  git shortlog -sn --no-merges
  ```
- **Purpose**: Ranks contributors by commit volume to expose the bus factor.
- **Interpretation**: A single individual owning ~60%+ of commits is a risk. Run the command again with `--since="6 months ago"` to detect contributors who have left or gone quiet. Pair this with the churn results to know which files are tied to fragile authorship.

## 3. Bug Clusters (Files That Keep Breaking)
- **Command**
  ```bash
  git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20
  ```
- **Purpose**: Surfaces the files that appear in commits mentioning bug, fix, or broken.
- **Interpretation**: Files repeating here and in the churn command likely oscillate between fragile and patched states. These are good candidates for refactors, better tests, or documentation.

## 4. Velocity (Commit Cadence)
- **Command**
  ```bash
  git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
  ```
- **Purpose**: Shows commit count by month, revealing velocity trends.
- **Interpretation**: A straight line suggests steady pace, spikes followed by quiet months imply batching, and a downward slope hints at losing momentum or team members. Annotate the report with context (e.g., "spike in March then drop"), since this is a team-level signal rather than code-level.

## 5. Emergency Work (Reverts & Hotfixes)
- **Command**
  ```bash
  git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback'
  ```
- **Purpose**: Counts commits that appear to be rollbacks or urgent fixes.
- **Interpretation**: Frequent results mean the team lacks confidence in its pipeline or tests. Zero results may mean good stability or a habit of writing vague messages. Include the raw count or examples in your report.

## Report Tips
- Save the output (or the top few lines) of each command so you can cite them when summarizing risk.
- Always compare churn and bug lists before recommending refactors, and highlight any files or contributors that show up multiple times.
- Mention both the command and its purpose in your report so the reader knows why you ran it.
