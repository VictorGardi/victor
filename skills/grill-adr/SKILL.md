---
name: grill-adr
description: Outcome-first grilling that finds the decisions worth an ADR. A short interview with the user about the outcome, then an agent-vs-agent interview backed by research, escalating only the questions that need the user. Ends with a Q&A table, what the decisions mean for the end user, and advice on to-spec vs implementing right away. Use instead of grill-with-docs when the user wants to settle decisions, not implementation details.
---

Settle the decisions that deserve an ADR, at the altitude where they make sense. The user cares about the outcome and that it works as expected. They do not care about function names or technical detail.

Call the Skill tool for "domain-modeling" before you start, and follow it for `GLOSSARY.md` and ADR formats. Use glossary terms in every question.

## The altitude rule

Ask a question only if the answer is **hard to reverse**, **surprising without context**, and **a real trade-off with genuine alternatives**. These are the same three tests as an ADR. Anything else is an implementation detail: decide it yourself, or leave it to implementation. Never ask about names, file layout, function signatures or library minutiae unless a choice among them is itself hard to reverse.

## Phase 1: Outcome interview (user)

Follow the "grilling" skill's round format (numbered questions, each with your recommended answer), with these changes:

- 3–6 questions in total, in 1–2 rounds. Outcome only: who is affected, what changes for them, what "done" looks like, what is out of scope, hard constraints.
- Ban implementation vocabulary. If a question mentions code, rewrite it as user-visible behaviour.
- Look up facts yourself (sub-agent) rather than asking.
- End by writing a one-paragraph **outcome brief** (what the user sees and does, non-goals, how we'll know it works). Play it back in plain words and ask the user to confirm or correct. On a correction, update and play back again. Do not start phase 2 before confirmation.

## Phase 2: Research (sub-agents)

Dispatch parallel sub-agents, as many as the problem needs:

- how the system behaves today in the affected area
- `GLOSSARY.md` terms and existing ADRs that constrain the area (flag conflicts)
- external docs or prior art, where an outside system or library is involved

Each returns facts with file or source references, not opinions. Every sub-agent prompt ends: "you cannot reach the user; return findings, never ask". From these, list the **open decisions**. Drop any that fail the altitude rule.

Write the outcome brief, the research and a running **decision log** to `.scratch/<slug>/` (or the repo's usual scratch location) as they arrive, so a dropped session can resume. Nothing lives only in chat.

## Phase 3: Agent-vs-agent interview

You are the **interviewer**. Each round, spawn a **fresh, stateless respondent** sub-agent and give it the outcome brief, the research, the decision log so far, and this round's questions. Statelessness means it re-reads the log each time instead of depending on remembered context. The respondent's instructions:

- Answer each question from evidence. Spawn your own research sub-agents when the evidence isn't in hand.
- Tag every answer `decided` (an ADR or the user already settled it), `inferred` (reasoned from evidence, state it) or `needs-human`.
- Never agree just because the interviewer suggests an answer. Say what the evidence supports, or say `needs-human`.
- Give the strongest alternative and what it would do to the outcome.
- You cannot reach the user; return findings, never ask.

Each question you write has plain-words background, 2–4 options with what each does to the outcome, and your recommendation.

Interviewer rules:

- Work the design tree in rounds, asking the whole frontier each round, with your recommended answer as in "grilling".
- Cap at 4 rounds. Stop earlier when no open decision remains.
- Update `GLOSSARY.md` inline when a term is resolved. Do not put implementation detail in it.
- **Escalate to the user** only when one of these holds: it's a one-way door; it changes what the end user experiences; it's a product preference research can't settle; the respondent answered `needs-human` or with low confidence; it conflicts with an existing ADR. Batch escalations into one round, each with the respondent's answer and your recommendation.
- Ask escalations with AskUserQuestion, up to 4 per call, each with background, options with outcome impact, and your recommendation. Record each answer in the decision log as it arrives.
- If interviewer and respondent still disagree after the round cap, do not pick silently: escalate it with both sides' options, pros and cons.
- Do not escalate everything else. The user should see few questions.
- Soft cap on ADRs: if more than about three decisions pass the three tests, say so; the scope is probably too big and should be split.

After the last round, spawn a fresh **checker** sub-agent. It reads the outcome brief and the decisions and returns, point by point, whether each "how we'll know it works" item is still met, `ok` or `blocking`. Outcome only, never technical choices. Fix or escalate blocking points before phase 4.

## Phase 4: Output

Present all of this in chat:

1. **Glossary and ADRs.** `GLOSSARY.md` is already updated. For each decision that passes the three ADR tests, show a **draft ADR** (format from domain-modeling) and wait for approval before writing it to `docs/adr/`.

2. **Q&A table.**

   | # | Question | Answer | Decided by | Basis |
   |---|----------|--------|------------|-------|

   `Decided by` is `user`, `respondent: decided`, `respondent: inferred` or `research`. Mark `inferred` rows with ⚠️ so the user can spot and challenge them. Then ask with AskUserQuestion which rows to reopen, in pages of up to three rows plus "None on this page". For each reopened row, put it to the user with the options, update the table and any affected ADR draft, and ask again until no veto.

3. **What this means.** A short summary in plain language, from the end user's side: what they can now do or will notice, what gets harder or is ruled out, and what happens in the cases that could surprise them. No code terms.

4. **Next step.** Recommend one, with the signals that led to it:
   - **Implement right away** if it fits one vertical slice, touches few areas, has no one-way doors left open, and needs at most one ADR.
   - **Run to-spec first** if it spans several slices, produced several ADRs, has remaining risk, or needs an agreed test seam.

Do not act on the result until the user approves.
