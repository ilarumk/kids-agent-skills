---
name: quest-generator
description: |
  Turn a kid's spoken wish ("I want to find a dragon", "I want to be a
  detective") into a multi-step adventure with obstacles and choices,
  rendered as a single-page interactive HTML quest screen. Load this
  skill when a kid says "I want to go", "I want to find", "I want to be
  a [job/role]", or describes a goal without listing characters or
  asking for a story. Output is one self-contained HTML file with a
  3–5 step quest, choice buttons at each step, an inventory of items
  collected, and a victory screen. Runs offline, touch-first.
age: all
voice_examples:
  - "I want to find a dragon"
  - "I want to be a pirate captain"
  - "I want to go on a treasure hunt"
version: 0.1.0
license: MIT
---

# Quest Generator

## When to use

Triggers:

- *"I want to [verb] a [noun]"* where the verb implies a journey: find, catch, become, rescue, build, defeat, deliver
- *"a quest about…"*, *"an adventure where…"*
- Distinguish from `story-spinner` (passive narration) and `game-world-builder` (real-time gameplay): a quest is **branching choices** with a clear goal.

## Process

1. **Echo the goal.** *"You want to FIND a DRAGON. Adventure incoming!"*
2. **Pick the age band.** Default Sapling.
3. **Generate the quest spine** — 3 steps for Sprout, 4 for Sapling, 5 for Branch.
   Each step is a short scene with: a setting, an obstacle, and 2–3 choices. One choice always advances the quest; the others may give an item, lose time, or loop back.
4. **Track an inventory.** Items the kid picks up appear in a sidebar. Some final-step choices unlock only with the right item.
5. **Write a victory screen.** Recap the path the kid took ("You crossed the misty bridge, befriended the cave bats, and used the glow stone to find the dragon"). Include an option to **replay** with different choices.
6. **Wire the UI.** Each step is a `.step` div with illustration (emoji or inline SVG), body text, and choice buttons. Hide all but the active step. Inventory pinned to the corner. Restart button always visible.
7. **Return.** One fenced HTML block + `speak:` line per band.

## Step-body length per band

| Band | Body per step |
|---|---|
| Sprout (5–7) | 1–2 sentences, 2 choices, illustration emoji-only |
| Sapling (8–10) | 2–3 sentences, 2–3 choices, optional inventory mechanic |
| Branch (11–12) | Short paragraph, 3 choices, inventory affects ending |

## Output format

````
speak: <band-appropriate intro to the quest>

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{quest title}}</title>
  <style>
    body { margin:0; font-family:system-ui,sans-serif; background:#1a1d2e; color:#fff; min-height:100vh; }
    .step { display:none; padding:24px; max-width:680px; margin:0 auto; }
    .step.active { display:block; }
    .illus { font-size:80px; text-align:center; margin:16px 0; }
    .body { font-size:22px; line-height:1.5; }
    .choices { display:flex; flex-direction:column; gap:12px; margin-top:24px; }
    .choices button { font-size:20px; padding:16px; background:#3a3f6e; color:#fff; border:0; border-radius:12px; cursor:pointer; text-align:left; }
    .choices button:hover { background:#4a508e; }
    #inv { position:fixed; top:8px; right:8px; background:#fff; color:#222; padding:8px 12px; border-radius:8px; font-size:18px; }
    #restart { position:fixed; top:8px; left:8px; background:#fff; color:#222; padding:8px 14px; border:0; border-radius:8px; }
  </style>
</head>
<body>
  <button id="restart" onclick="location.reload()">↻ Restart</button>
  <div id="inv">🎒 <span id="items">empty</span></div>
  <!-- 3-5 .step divs -->
  <div class="step" id="victory"><!-- recap + replay --></div>
  <script>
    /* show/hide steps, track items array, render inventory, route choices */
  </script>
</body>
</html>
```
````

## Required defaults

- All choices clearly visible — no hidden hover-only options.
- Inventory state lives in memory only (not `localStorage`).
- Replay option on victory screen — restarts cleanly.
- Buttons ≥48px tall for touch.
- No timed pressure on Sprout band (no count-down clocks).

## Refusal patterns

| Kid asks for | Redirect |
|---|---|
| Quest with real-world weapons | Replace with magical equivalents — "sword" stays, "gun" becomes a "blaster of bubbles". |
| Quest where the goal is to hurt someone real | Pivot to befriend / outsmart / rescue. |
| Quest involving real locations (their school, their home) | Generalize to "the school across the river" or "an old house on the hill". |
| Adult themes (gambling, drinking) | Replace with kid-friendly equivalents (a card-flipping puzzle, a potion-mixing scene). |

## Example

**Input:** *"I want to find a dragon"*

**Expected speak:** "Quest started! You're heading to the misty mountains to find a dragon. There are 4 steps. Choose carefully — your decisions change how it ends!"

**Sketch of the spine:**
1. Misty Bridge: cross carefully (advance) / look down (lose time, learn the river is glowing) / turn back (loop)
2. Cave entrance: light a torch (advance) / call out (advance + makes bats friendly) / sneak (advance, no items)
3. Cavern: pick up the glow stone (item) / pick up the silver bell (item) / leave both (advance)
4. Dragon: show glow stone (peaceful ending) / ring bell (silly ending) / nothing (dragon hides — replay hint)
