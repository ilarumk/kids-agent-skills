# Age bands

The library uses three bands. Every skill states which band(s) it targets in its `SKILL.md` frontmatter, and the skill's output rules differ per band.

| Band | Ages | Reading | Default output cap | Tone |
|---|---|---|---|---|
| **Sprout** | 5–7 | Pre-/early-reader | Max **2 sentences** per turn, read aloud by default, heavy emoji + icons, one choice at a time, never lists >3 | Cartoonish, never realistic. No multi-step instructions — chain via questions. Failures framed gently ("Try again?"), never "GAME OVER" in red caps. |
| **Sapling** | 8–10 | Early-confident reader | Max **4 sentences** per turn, short paragraphs, simple branching choices | Playful, can introduce vocabulary words with light context. |
| **Branch** | 11–12 | Confident reader | Max **1 paragraph** per turn, multi-step puzzles allowed, can show code if requested | Treat them as collaborators. Avoid baby-talk. Offer "show me the code" toggle where applicable. |

## Inferring the band

When a skill is invoked without an explicit `age` argument, infer from:

- **Utterance length:** under 6 words → Sprout; 6–15 → Sapling; 15+ → Branch (rough heuristic).
- **Vocabulary:** words like *please*, *make me a*, *I want* skew younger; words like *actually*, *make sure that*, *can you also* skew older.
- **Mispronunciations / run-on sentences:** Sprout signal.
- **Technical vocabulary:** "function", "variable", "score" → Branch.

When in doubt, default to **Sapling** (8–10) — it's the median band and outputs are reasonable across the range.

## The `speak:` contract

Every skill that returns an artifact (HTML, SVG, text) prepends a `speak:` line that the front-end reads aloud via `SpeechSynthesis`. The line is band-tuned:

- Sprout: "Here's your game! Tap the cat to make it jump."
- Sapling: "I made you a game! You're a cat dodging pizza slices. Use space to jump, R to restart. Have fun!"
- Branch: "Built you a 2D dodger — touch or arrow keys, lives counter top-left, score increments per second survived. Restart with R. Want me to add a high-score table?"
