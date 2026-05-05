---
name: skill-name-in-kebab-case
description: |
  One paragraph. Describe what the skill does, when Claude should load it
  (trigger phrases — match on intent, not exact wording), and what the
  output looks like. The model uses THIS field to decide whether to
  invoke the skill, so be specific about triggers.
age: all                    # one of: 5-7, 8-10, 11-12, all
voice_examples:
  - "real utterance from a kid in the target band"
  - "another one — include mispronunciations and run-on sentences"
  - "third one — short fragmentary utterance"
safety:
  banned_topics: [list, of, skill-specific, redlines]
  pii_writes: forbidden     # never write a kid's name, school, etc. to localStorage
  network_calls: forbidden  # default; flip only with reviewer sign-off
output:
  shape: single-html-file   # or: text, svg, multi-file
  max_lines: 500
  read_aloud: true          # if true, prepend a `speak:` line per age band
version: 0.1.0
license: MIT
maintainers: [github-handle]
---

# Skill display name

## When to use

Match on intent. List the trigger phrases or scenarios that should load this
skill. Be liberal — kids paraphrase.

## Process

1. **Confirm the idea in one sentence.** Echo the kid's words back so they
   know they were heard.
2. **Pick the age band.** Use the `age` argument if provided; else infer
   from utterance length and vocabulary (see `shared/age-bands.md`).
3. **Pick a variant** from the lookup table below (if applicable).
4. **Fill the template** in `assets/template.html` (or compose output from
   primitives).
5. **Run** `scripts/validate.sh` against the output before returning it.
6. **Read the result aloud** per age band: 2 sentences (Sprout), 4
   (Sapling), 1 paragraph (Branch).

## Output format

Describe the exact return shape. Example for an HTML-producing skill:

> Return exactly one fenced ` ```html ` block containing a complete document
> (`<!doctype html> ... </html>`). Above the block, include a `speak:` line
> of ≤2 sentences describing what the kid will see.

## Variants / Primitives lookup

| Player verb | Variant | Default behavior |
|---|---|---|
| (example: fights, attacks) | shooter | tap/space to fire |
| (example: jumps, hops) | platformer | tap/space to jump |

## Examples

See `examples/` for three ground-truth artifacts with the input transcript
and expected output.

## Refusal patterns

If the kid asks for a banned topic, redirect playfully — never lecture.
Examples:

- "Realistic gun" → "Let's make it sillier — what if it shot bubbles?"
- "Real person's name" → "Let's invent a character instead. What's their
  superpower?"

## Validation

`scripts/validate.sh` checks:

- No `<script src=>` to a remote URL
- No `fetch(` / `XMLHttpRequest` calls (offline test)
- No `localStorage.setItem` of strings matching name/email patterns
- Line count under `output.max_lines`
- `<meta name="viewport">` present
- File parses as valid HTML

## Changelog

- 0.1.0 — initial version.
