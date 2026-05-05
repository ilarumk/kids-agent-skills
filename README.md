# kids-agent-skills

A voice-first [Claude Skills](https://www.anthropic.com/news/skills) library for kids ages **5–12**. Companion repo to the blog post *"My five-year-old is vibe coding. He can't read yet."*

## The five launch skills

| Skill | What a kid says | What they get |
|---|---|---|
| [Game World Builder](./skills/game-building/game-world-builder/SKILL.md) | *"I want a city with garbage trucks, a fire truck saving people, and a drone."* | A single-file HTML5 2D arcade game with the characters and rules they described. Touch + keyboard. Runs offline. |
| [Story Spinner](./skills/storytelling/story-spinner/SKILL.md) | *"Tell me a story about a sneaky fox who finds a spaceship."* | An illustrated multi-page interactive story with read-aloud and tap-to-advance. |
| [Character Creator](./skills/art-and-characters/character-creator/SKILL.md) | *"A hero who's part dragon and part chef."* | A printable A4 character sheet with inline-SVG art, stats, backstory, signature line. |
| [Quest Generator](./skills/game-building/quest-generator/SKILL.md) | *"I want to find a dragon."* | A 3–5 step branching adventure with choices, an inventory, and a victory screen. |
| [Science Sandbox](./skills/science-exploration/science-sandbox/SKILL.md) | *"What happens if I drop a watermelon from a rocket?"* | A small interactive simulation with sliders — not a lecture. |

All five share the same constraints:

- **Voice-first.** Kids speak. Output includes a `speak:` line tuned to age band.
- **Single self-contained HTML file.** No logins, no installs, no network calls. Runs offline on iPad Safari and Chromebook Chrome.
- **Operator model.** Anthropic's Consumer Terms require Claude.ai users to be 18+. The library is for adults running Claude on behalf of minors.

## Install

```bash
git clone https://github.com/ilarumk/kids-agent-skills.git
cp -r kids-agent-skills/skills/game-building/game-world-builder ~/.claude/skills/
```

Restart Claude Desktop or Claude Code. Hand the device to your kid, turn on voice, and let them describe what they want to build. Full instructions: [INSTALL.md](./INSTALL.md).

## Why this exists

Across the major Claude Skills aggregators (Anthropic's official repo, addyosmani/agent-skills, obra/superpowers, VoltAgent, and 1,000+ third-party listings), **zero are aimed at kids**.

A skill packages the line of context a kid can't supply — *"build this as an HTML5 2D arcade game so it runs in the browser"* — so the model applies it every time without anyone having to remember it. Full reasoning, citations, and the broader 18-skill plan: [`SKILLS_RESEARCH.md`](./SKILLS_RESEARCH.md).

## Repo layout

```
kids-agent-skills/
├── README.md
├── INSTALL.md
├── SAFETY.md
├── SKILLS_RESEARCH.md       # planning doc, ~4,600 words, cited
├── LICENSE
├── templates/SKILL.md       # canonical format
├── shared/age-bands.md      # Sprout / Sapling / Branch contract
├── scripts/
│   ├── new-skill.sh         # scaffolds a new skill folder
│   └── validate.sh          # checks a generated artifact for slop
└── skills/
    ├── game-building/
    │   ├── game-world-builder/SKILL.md
    │   └── quest-generator/SKILL.md
    ├── storytelling/story-spinner/SKILL.md
    ├── art-and-characters/character-creator/SKILL.md
    └── science-exploration/science-sandbox/SKILL.md
```

## Branches

| Branch | Scope |
|---|---|
| `main` | The five launch skills + scaffolding. |
| [`future/full-catalog`](https://github.com/ilarumk/kids-agent-skills/tree/future/full-catalog) | The broader 18-skill catalog from the research doc, plus longer-horizon ideas (MCP integrations, image gen behind a feature flag, audio output via Web Speech). |

## What's missing (next up)

- [ ] At least one worked example HTML per skill in `examples/`
- [ ] Kid-test logs in `references/voice-prompts.md` per skill
- [ ] A short demo video / GIF for each skill in this README

## License

MIT for code. CC-BY-SA-4.0 for skill content.
