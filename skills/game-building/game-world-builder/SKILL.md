---
name: game-world-builder
description: |
  Turn a kid's spoken description of a world (cars, vehicles, characters,
  buildings, rules) into a single self-contained HTML5 2D arcade game they
  can play immediately on iPad or Chromebook. Load this skill whenever a
  child says they want to "make a game", "build a world", "I want to play",
  or describes a scene that implies a playable artifact ("a city with
  garbage trucks and a fire truck saving people", "I'm a fish dodging
  sharks", "a robot that jumps on platforms"). Output is exactly one
  fenced HTML block — a complete document under 500 lines, no external
  assets, no network calls, runs offline, touch + keyboard controls.
age: all
voice_examples:
  - "I want a city with garbage trucks and a fire truck and a drone flying over"
  - "make me a game where my cat fights pizza"
  - "a fish that has to dodge sharks please"
  - "build a jumping game with a robot"
version: 0.1.0
license: MIT
---

# Game World Builder

## When to use

Match on intent, not exact wording. Triggers:

- The kid uses verbs like *make / build / play / want a game / I'm a [thing] that [does]*
- They list characters, vehicles, or scenery with a verb implying action
- They describe a scene and ask "can it be a game?"

If they describe a static world without action ("a city with houses and a park"), gently ask: *"Cool — what should you do in the city? Drive a truck? Fly a drone? Catch something?"* Then build.

## Process

1. **Echo the idea in one sentence** so the kid hears that they were heard.
   *"You want a CITY with GARBAGE TRUCKS, a FIRE TRUCK rescuing people, and a DRONE flying over. Got it!"*
2. **Pick the age band.** Use any `age` argument; otherwise infer from utterance length and vocabulary (see `shared/age-bands.md` at the repo root). Default to Sapling (8–10) when uncertain.
3. **Extract entities and pick a primitive.**

   | Verbs the kid used | Primitive | Default behavior |
   |---|---|---|
   | fights, attacks, shoots | shooter | tap/space to fire |
   | jumps, hops, climbs | platformer | tap/space to jump, gravity on |
   | dodges, avoids, runs from | dodger | left/right to move, obstacles fall |
   | collects, picks up, gathers | collector | move to touch items, score increments |
   | drives, flies, controls | driver | arrows or tilt to steer; world scrolls |
   | rescues, saves, helps | rescue | move to touch the thing-in-trouble; rescue counter |
   | catches, chases | chaser | one entity follows another |

   Multiple entities → one player-controlled (the kid picks if ambiguous, otherwise the first one mentioned), the rest become NPCs, obstacles, or rescue targets.

4. **Map entities to emoji sprites.** Use Unicode emoji as sprites — no images, no fonts, no external assets. Common mappings: garbage truck 🚛, fire truck 🚒, police car 🚓, drone 🛸, rocket 🚀, building 🏢, fire 🔥, person 🧍, dragon 🐉, shark 🦈, fish 🐟, cat 🐈, pizza 🍕, robot 🤖.
5. **Fill the frozen scaffold** (see "Output format" below). Keep it under 500 lines total.
6. **Validate before returning.** Mentally check: viewport meta present, no `fetch(`, no `<script src="http`, no `localStorage.setItem` of names/emails, restart button present, controls work on both touch and keyboard.
7. **Return the artifact** as exactly one fenced ` ```html ` block, preceded by a `speak:` line tuned to the age band:
   - **Sprout (5–7):** 2 sentences max. *"Here's your city! Tap the screen to fly your drone."*
   - **Sapling (8–10):** 4 sentences max. *"I built you a rescue game. You're a drone flying over the city. When a building catches fire, fly over it to call the fire truck. You get a point for each rescue!"*
   - **Branch (11–12):** one short paragraph. May offer to show or modify the code.

## Output format

Return exactly:

````
speak: <one band-appropriate line>

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
  <title>{{kid-friendly title}}</title>
  <style>
    /* full CSS inline; mobile-first; no external fonts */
    html, body { margin:0; padding:0; height:100%; background:#87ceeb; touch-action:none; user-select:none; font-family:system-ui,sans-serif; }
    canvas { display:block; width:100%; height:100%; touch-action:none; }
    #hud { position:fixed; top:8px; left:8px; font-size:24px; background:rgba(255,255,255,.8); padding:6px 10px; border-radius:8px; }
    #restart { position:fixed; top:8px; right:8px; font-size:20px; padding:8px 14px; border:0; border-radius:8px; background:#fff; }
  </style>
</head>
<body>
  <div id="hud">Score: <span id="score">0</span></div>
  <button id="restart">↻ Restart</button>
  <canvas id="game"></canvas>
  <script>
    /* full game code inline */
    /* Required: requestAnimationFrame loop, resize handler, touch + keyboard, restart, gentle lose state */
  </script>
</body>
</html>
```
````

## Required defaults (non-negotiable)

| Concern | Default |
|---|---|
| Render | HTML5 `<canvas>` 2D, no WebGL |
| File | Single `.html`, all CSS/JS inline |
| Assets | Emoji + CSS + inline SVG only — no images, no fonts, no audio files |
| Audio | Web Audio API oscillators only (optional) |
| Controls | Touch (tap/swipe), keyboard (arrows, space, WASD), all wired |
| Network | Zero `fetch`, zero `XMLHttpRequest`, no `<script src="http…">` |
| Storage | No `localStorage` of names, addresses, photos, or anything PII |
| Lose state | Gentle wording — "Try again?", never "GAME OVER" in red caps for the Sprout band |
| Restart | Visible button + R key |
| Mobile | Viewport meta present; canvas fills screen; touch handlers |
| Line cap | 500 lines total |

## Refusal patterns

If the kid asks for any of the following, redirect playfully — never lecture:

| They asked for | Redirect |
|---|---|
| Realistic gun / weapon by name | "Let's make it sillier — what if it shot bubbles? Or spaghetti?" |
| Blood / gore | "We can do a sparkle effect when something gets hit instead. Want pink or rainbow sparkles?" |
| A real person's name | "Let's invent a character instead. What's their superpower?" |
| Brand names (e.g., "make a Coca-Cola ad") | "Let's invent a fake brand. What should it sell?" |
| Romance / kissing | "Hmm, let's pick something else for the game. Want a chase or a rescue?" |

If the kid signals real distress (self-harm references, scared and serious), stop generating and respond: *"That sounds important. Let's pause the game and tell a grown-up you trust about this."*

## Example

**Input transcript:** *"I want a city with a garbage truck and a fire truck and a drone flying over and the drone helps the fire truck save people from buildings on fire."*

**Expected speak:** "I made you a Hero City! You're the drone flying over town. When a building catches fire, fly over it to call the fire truck. You get a point for each rescue!"

**Expected output:** A single HTML file with: scrolling city background (CSS gradient + emoji buildings), a drone 🛸 controlled by touch/arrows, buildings 🏢 that randomly catch fire 🔥, a fire truck 🚒 NPC that drives to whichever building the drone is hovering over, a garbage truck 🚛 NPC that drives a fixed loop, a score counter at top-left, a restart button. No external network calls, no images.

See `examples/` for the full HTML.
