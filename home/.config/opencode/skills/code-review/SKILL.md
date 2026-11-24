---
name: Code Review
description: Checklist for reviewing diffs for correctness, security, regressions, and missing tests
---

# Code Review

## Procedure

1. Read the diff and the surrounding code; do not rely on the diff alone.
2. Check each change for:
   - correctness and edge cases;
   - regressions in callers, API contracts, and data flow;
   - security and secret handling;
   - error handling and observability;
   - tests: are new behaviors covered? are existing tests still valid?
3. Report findings in severity order (blocker, high, medium, low). For each: `file:line`, impact, and a concrete fix.
4. If there are no findings, say so explicitly and list what you verified.
5. Do not edit files. Do not run mutating commands.
