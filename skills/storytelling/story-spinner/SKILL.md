---
name: story-spinner
description: |
  Turn a kid's spoken story idea into an illustrated multi-page interactive
  story they can navigate by tapping or by saying "next". Load this skill
  when a kid says "tell me a story", "I want a story about…", "make up a
  story", or describes characters and a setting without asking for a game.
  Output is one self-contained HTML file with 4–8 pages, emoji + inline-SVG
  illustrations, large text, a read-aloud Speak button (Web Speech API),
  and a "next page" button. Runs offline, touch-first, no external assets.
age: all
voice_examples:
  - "tell me a story about a sneaky fox who finds a spaceship"
  - "I want a story about my puppy named Muffin"
  - "make up a story about a dragon and a lonely robot"
version: 0.1.0
license: MIT
---

# Story Spinner

## When to use

Triggers:

- *"tell me a story", "story about", "I want a story", "make up a story"*
- A kid lists characters or a setting with no action verb (no "fight", "dodge", "build" — that's `game-world-builder`)
- A kid asks for a "bedtime" or "calm" story → use Sprout band defaults

## Process

1. **Echo the idea.** *"A story about a sneaky FOX who finds a SPACESHIP — got it!"*
2. **Pick the age band.** Default Sapling.
3. **Pick a length.** Sprout: 4 pages, calm arc. Sapling: 6 pages, light conflict + resolution. Branch: 8 pages, can include subplot.
4. **Choose a structure.** Linear by default. If the kid says "choose your own adventure" or "give me choices", branch at pages 3 and 5 (each branch ≤2 options).
5. **Write the pages.** One scene per page. Each page has: a 2-line illustration (emoji composition or inline SVG), a one-paragraph story body, optional choice buttons.
6. **Wire the navigation.** "Next" button + "Previous" + "Read this page" (uses `SpeechSynthesis`). All buttons touch-friendly (≥48×48px).
7. **Return.** One fenced HTML block, preceded by a `speak:` line per band.

## Page-body length per band

| Band | Body per page |
|---|---|
| Sprout (5–7) | 2 short sentences, present tense, emoji-heavy |
| Sapling (8–10) | 3–4 sentences, mix of dialogue and description |
| Branch (11–12) | One paragraph (≤80 words), can include figurative language |

## Output format

````
speak: <one band-appropriate line about the story you made>

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{story title}}</title>
  <style>
    body { margin:0; font-family:system-ui,sans-serif; background:#fdf6e3; color:#222; }
    .page { display:none; padding:24px; min-height:100vh; box-sizing:border-box; }
    .page.active { display:block; }
    .illus { font-size:96px; text-align:center; margin:24px 0; }
    .body { font-size:22px; line-height:1.5; max-width:680px; margin:0 auto; }
    .nav { display:flex; gap:12px; justify-content:center; margin-top:32px; }
    button { font-size:20px; padding:14px 24px; border:0; border-radius:12px; background:#ffd166; cursor:pointer; }
  </style>
</head>
<body>
  <!-- 4-8 .page divs, each with .illus, .body, and .nav -->
  <script>
    /* page navigation, optional choice routing, SpeechSynthesis read-aloud */
  </script>
</body>
</html>
```
````

## Required defaults

- No `fetch`, no remote scripts, no fonts, no images.
- `SpeechSynthesis` for read-aloud is optional but recommended; gracefully degrade if unavailable.
- Large tappable buttons (≥48px on each side).
- Light, warm color palette by default; for "bedtime" requests, switch to a deeper palette and slow the rendering.
- No PII written to `localStorage`. If you save state at all, save only the current page index.

## Refusal patterns

| Kid asks for | Redirect |
|---|---|
| Scary horror, jump scares | "Let's make it more curious than scary. Want a mysterious cave or a friendly ghost instead?" |
| Real people / classmates by name | "Let's invent a character. What should we call them?" |
| Romance / kissing | Pivot to friendship or sibling adventures. |
| Death of the main character | Soften — character "falls asleep", "goes home", "is rescued at the last second". |
| Real-world distressing events (war, illness, accidents) | "That's a heavy topic. Let's tell a story about something brave instead — what's something hard your character can solve?" |

## Example

**Input:** *"a story about a sneaky fox who finds a spaceship"*

**Expected speak:** "I made you a 6-page story about Sly the fox who finds a glowing spaceship behind a tree. Tap NEXT to read each page, or tap the speaker icon to hear it out loud."

**Page 1 illus:** 🦊🌲✨ — "Sly the fox slipped between the pines."
**Page 2 illus:** 🦊👀🛸 — "Behind a thicket, something was glowing…"
**(continued through page 6)**
