---
name: task-format
description: Defines the canonical structure, frontmatter schema, and file naming conventions for task markdown files. Load this when creating, reading, updating, or reviewing task files.
---

## Storage location

All tasks live under `.tasks/` at the root of the current repo:

- Task status is defined by which directory it is placed in.
- New tasks are written to `.tasks/backlog/`
- Tasks in other states may live in `.tasks/doing/`, `.tasks/done/`, `.tasks/blocked/`

## File naming

```
T-NNN-slugified-title.md
```

Examples:
- `T-001-add-audit-logging.md`
- `T-042-refactor-auth-middleware.md`

Slug rules: lowercase, hyphens only, no special characters, derived from the title.

## ID assignment

Scan all files under `.tasks/` recursively for the highest existing `T-NNN` id (from filenames or frontmatter). Increment by one. If no tasks exist, start at `T-001`.

## Frontmatter schema

```yaml
---
id: T-NNN
title: Short imperative title
priority: medium
created_at: YYYY-MM-DD
workspace: <repo name from git or directory name>
---
```

### Valid values

**priority:** `low` | `medium` | `high` | `critical`

**workspace:** the repo name — detect via `git remote get-url origin` (extract repo name) or fall back to the current directory name.

**created_at:** ISO 8601 date of task creation (today's date).

## Required sections

Every task file must contain these sections in order:

### `# Goal`
One paragraph. What this task achieves and why it matters.

### `# Context`
Background, current state, relevant constraints, or links. Keep it brief.

### `# Implementation Plan`
Numbered steps. Concrete and ordered. Include:
- data model / schema changes
- migrations
- config changes
- tests
- documentation updates

### `# Definition of Done`
Checkbox list. Each item must be independently verifiable.

```markdown
- [ ] Item one
- [ ] Item two
```

### `# Risks`
Bullet list of risks, unknowns, or things to watch out for.

### `# Notes`
Free-form. Always include at the end:

```
Generated via plan-task
```

## Example

```markdown
---
id: T-198
title: Audit failed login attempts
priority: medium
created_at: 2026-04-28
workspace: auth-service
---

# Goal

Add audit logging for failed login attempts so security incidents can be investigated.

# Context

Current login flow records success metrics but no failure audit trail.

# Implementation Plan

1. Add `failed_login_events` persistence model.
2. Hook login failure path to emit event.
3. Store email/identifier, IP, timestamp, reason.
4. Add retention cleanup policy.
5. Add tests.

# Definition of Done

- [ ] Failed login attempts are recorded
- [ ] IP + timestamp captured
- [ ] No sensitive password data stored
- [ ] Tests cover event creation
- [ ] Documentation updated

# Risks

- High-volume spam attempts may create noise
- Ensure GDPR/data retention compliance

# Notes

Generated via plan-task
```
