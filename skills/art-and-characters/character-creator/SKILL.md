---
name: character-creator
description: |
  Turn a kid's spoken description of a hero, monster, sidekick, or pet into
  a printable character sheet with art (inline SVG), stats, backstory, a
  signature line ("voice"), and a special move. Load this skill when a kid
  describes a character without asking for a game or a story — "a hero who
  is part dragon part chef", "make me a monster that's nice", "I want a
  pet that flies". Output is one self-contained HTML page sized for A4
  printing, with inline-SVG art (no images), readable on-screen and
  printable as a single sheet.
age: all
voice_examples:
  - "a hero who's part dragon and part chef"
  - "make me a monster that's actually nice"
  - "I want a pet that has wings and roller skates"
version: 0.1.0
license: MIT
---

# Character Creator

## When to use

Triggers:

- *"make me a [character / hero / monster / pet / sidekick]"*
- *"a [adjective] [noun] that [verb]"* without "game" or "story" cues
- Follow-up requests after a story or game: *"give them a name"*, *"what's their power?"* — extend an existing character instead of creating a new one if context allows

## Process

1. **Echo the idea.** *"A hero who's part DRAGON and part CHEF — that's amazing!"*
2. **Pick the age band.** Default Sapling.
3. **Generate the character sheet fields:**
   - **Name** — invented, alliterative or rhyming when possible. Never a real person's name.
   - **Species / type** — combine the kid's traits.
   - **Three stats** — out of 10. Tune to the band: Sprout sees Strength / Speed / Kindness; Sapling adds Smarts; Branch can have 5 stats including a custom one tied to the character's theme.
   - **Special move** — one line, action verb in caps. *"BREATH BAKES COOKIES."*
   - **Backstory** — band-appropriate (1 sentence Sprout, 2–3 Sapling, short paragraph Branch).
   - **Catchphrase / voice** — one line in quotes.
4. **Draw the art.** Inline SVG, ≤200 lines. Build from primitive shapes (`<circle>`, `<rect>`, `<path>`, `<polygon>`). Use the kid's traits literally — a dragon-chef has a chef hat *and* scales. No external images, no `<image>` tags pointing to URLs.
5. **Layout the sheet.** A4-friendly print CSS, large headers, the SVG taking the top half of the page, fields below.
6. **Return.** One fenced HTML block + `speak:` line.

## Output format

````
speak: <band-appropriate intro of the character>

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{character name}}</title>
  <style>
    @page { size: A4; margin: 12mm; }
    body { font-family:system-ui,sans-serif; max-width:780px; margin:0 auto; padding:24px; color:#222; }
    h1 { font-size:48px; margin:0 0 8px; }
    .species { color:#666; font-size:20px; margin-bottom:24px; }
    .art { width:100%; height:auto; max-height:400px; }
    .stats { display:grid; grid-template-columns:repeat(3,1fr); gap:16px; margin:24px 0; }
    .stat { text-align:center; padding:12px; background:#fff7d6; border-radius:12px; }
    .stat .num { font-size:36px; font-weight:bold; }
    .move { background:#ffe0e6; padding:16px; border-radius:12px; font-size:20px; margin:16px 0; }
    .quote { font-style:italic; color:#444; }
    @media print { button { display:none; } }
  </style>
</head>
<body>
  <button onclick="window.print()">🖨 Print</button>
  <h1>{{Name}}</h1>
  <div class="species">{{Species}}</div>
  <svg class="art" viewBox="0 0 400 300">
    <!-- inline SVG built from primitives -->
  </svg>
  <div class="stats"><!-- 3 or 4 stat boxes --></div>
  <div class="move">🔥 SPECIAL MOVE: {{move}}</div>
  <p>{{backstory}}</p>
  <p class="quote">"{{catchphrase}}"</p>
</body>
</html>
```
````

## Required defaults

- All art is inline SVG — no `<img>`, no external URLs.
- The sheet must look reasonable when printed (A4) and on-screen (mobile).
- Stat values must be realistic-ish (no all-10s); leave one stat lower so kids can imagine improvement.
- Backstory never includes real people, schools, or addresses.

## Refusal patterns

| Kid asks for | Redirect |
|---|---|
| A real person turned into a character | "Let's invent someone new. What's a name we just made up?" |
| A character who hurts other characters as their main trait | "Let's make their power be something funnier — what if they could turn enemies into pancakes instead of hurting them?" |
| Body-shaming descriptors | Soften silently; describe the character with positive traits. |
| Brand mascots | "Let's invent a brand-new character with that vibe." |

## Example

**Input:** *"a hero who's part dragon and part chef"*

**Expected speak:** "Meet Saffron Scaleflame — a dragon chef who bakes cookies with her breath. Her stats are below, and you can print the sheet if you want to keep it!"

**Sheet contents (sketch):**
- Name: Saffron Scaleflame
- Species: Dragon-Chef (rare)
- Strength 7 / Smarts 8 / Kindness 9
- Special move: **BREATH BAKES COOKIES**
- Backstory: Saffron left the dragon kingdom to open a bakery in the clouds.
- Voice: *"Order up, sky-friends!"*
- Art: SVG dragon with chef hat, scaled wings tied with apron strings.
