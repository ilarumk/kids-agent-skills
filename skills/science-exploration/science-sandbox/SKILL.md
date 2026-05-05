---
name: science-sandbox
description: |
  Answer a kid's "what happens if…" or "why…" question with a small
  interactive simulation, not a lecture. Load this skill when a kid asks
  a physics, chemistry, biology, or astronomy question that has an
  observable outcome ("what happens if I drop a watermelon from a
  rocket?", "why is the sky blue?", "what happens if a ball bounces
  forever?"). Output is one self-contained HTML file with an animated
  canvas simulation, a 1–2 sentence explanation tuned to the age band,
  and 2–3 sliders or buttons letting the kid change parameters. No
  external assets, runs offline.
age: all
voice_examples:
  - "what happens if I drop a watermelon from a rocket"
  - "why is the sky blue"
  - "what if gravity was upside down"
  - "how do bees fly"
version: 0.1.0
license: MIT
---

# Science Sandbox

## When to use

Triggers:

- *"what happens if…"*, *"what if…"*, *"why is…"*, *"how does…"*, *"how do…"*
- A question that implies an observable phenomenon (motion, light, gravity, plants growing, animals moving)

If the question is purely factual with no visual phenomenon ("how many bones are in my hand?"), answer briefly in text instead of building a simulation.

## Process

1. **Echo the curiosity.** *"Great question! Let's find out what happens when a watermelon falls from a rocket."*
2. **Pick the age band.**
3. **Identify the phenomenon and the variables.** What can the kid change to play? Pick 2–3 parameters that meaningfully affect the outcome.
4. **Build the simulation.** Canvas-based, simple physics or visual. Loop with `requestAnimationFrame`. Provide sliders / buttons for the parameters.
5. **Write the explanation.** Tuned to the band:
   - **Sprout (5–7):** 1 sentence, no jargon. *"When something heavy falls from high up, it falls fast!"*
   - **Sapling (8–10):** 2 sentences, one named concept. *"Gravity pulls things toward the ground. The higher you start, the faster they go when they hit!"*
   - **Branch (11–12):** Short paragraph, can name the actual physics term ("acceleration", "terminal velocity") with a one-line definition.
6. **Add a "Try it" prompt.** A line under the controls that suggests a parameter to change. *"Try moving the height slider all the way up!"*
7. **Return.** One fenced HTML block + `speak:` line.

## Required defaults

- Simulations must be **safe to run continuously** — no memory leaks, no growing arrays.
- All sliders / buttons keyboard- and touch-accessible.
- Math must be approximately right — don't teach wrong physics. If you're unsure, prefer a qualitative animation over a misleading "accurate" one.
- No real medical, dietary, or safety advice. If a kid asks "what happens if I eat X", redirect: *"Some experiments are best done by reading, not trying! Let's pick something we can simulate instead."*
- No experiments that mimic real dangerous activities (mixing household chemicals, electrical experiments, fire). Simulate at a clearly cartoonish level.

## Output format

````
speak: <band-appropriate one-line answer>

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{phenomenon}}</title>
  <style>
    body { margin:0; font-family:system-ui,sans-serif; background:#0e1016; color:#fff; }
    canvas { display:block; width:100%; max-height:60vh; background:#000; }
    .panel { padding:16px; max-width:680px; margin:0 auto; }
    .ctrl { display:flex; align-items:center; gap:12px; margin:12px 0; }
    .ctrl label { width:140px; font-size:18px; }
    .ctrl input { flex:1; }
    .explain { background:#1f2436; padding:16px; border-radius:12px; font-size:18px; line-height:1.5; }
    .try { color:#ffd166; margin-top:12px; }
  </style>
</head>
<body>
  <canvas id="sim"></canvas>
  <div class="panel">
    <div class="explain">{{1-2 sentence explanation}}</div>
    <!-- 2-3 .ctrl rows with labeled sliders or buttons -->
    <div class="try">{{try-it suggestion}}</div>
  </div>
  <script>
    /* simulation loop, parameter wiring, resize handler */
  </script>
</body>
</html>
```
````

## Refusal patterns

| Kid asks | Redirect |
|---|---|
| "What happens if I eat / drink / touch X?" | "Some experiments are safer to read about than try. Let's pick one we can simulate instead — what about gravity?" |
| Anything dangerous (fire, electricity, weapons, chemicals) | Decline the literal version, offer a cartoonish simulation. *"Real fire is something to ask a grown-up about. Let's simulate volcanoes from space instead!"* |
| Medical or mental-health questions | "That's a great question for a grown-up you trust. I can show you a simulation about something else — want to see how a heart pumps blood, but as a cartoon?" |

## Example

**Input:** *"what happens if I drop a watermelon from a rocket?"*

**Expected speak:** "Watermelons fall fast when you drop them from way up — but air pushes back, so there's a top speed they can hit!"

**Simulation sketch:**
- Canvas: rocket at top, ground at bottom, watermelon emoji 🍉 falling.
- Sliders: height (1m to 100km), gravity (0–20 m/s²).
- Animation: watermelon accelerates, shows velocity in m/s, splats with cartoonish sparkles on impact.
- Explanation (Sapling): "Gravity pulls the watermelon down. The higher it starts, the faster it goes — but air slows it down too. That's why even from a rocket, it doesn't go infinitely fast!"
- Try-it: "Set gravity to zero — what happens?"
