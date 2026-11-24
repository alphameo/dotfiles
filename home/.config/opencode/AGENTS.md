# Global tool-usage guidance

- Prefer `read` with `limit`/`offset` over `head`, `tail` or `cat`.
- Use `write`/`edit` instead of `echo >`, `printf >` or heredocs for file changes.
- Use `grep`/`glob` for search; do not use `rg`/`fd`/`jq` through shell to read files.
- Use shell only when no dedicated tool exists; keep the narrow allowlist.
- Use context7 only for current documentation of third-party libraries and frameworks.
  For OpenCode itself, prefer the built-in `opencode` skill and https://opencode.ai/docs.
  Avoid speculative context7 calls; batch independent lookups in a single `execute` call.
