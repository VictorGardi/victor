---
name: grill-me
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me".
---

Interview the user relentlessly about every important aspect of the plan until you reach a shared understanding.

## Behavior

- Ask questions one at a time.
- Walk down the decision tree branch by branch.
- For each question:
  - explain why it matters
  - provide your recommended answer
  - ask for the user's choice
- Do not skip hidden dependencies.
- Do not collapse multiple decisions into one question.

## Exploration rule

If a question can be answered by exploring the codebase, explore the codebase instead of asking the user.

## Goal

Reduce ambiguity before implementation.
Find missing assumptions.
Force the design to become explicit.
