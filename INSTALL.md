# Install kids-agent-skills

> **Status:** the five launch skills (`game-world-builder`, `story-spinner`, `character-creator`, `quest-generator`, `science-sandbox`) ship as `SKILL.md` files in this repo. Drop the folder into your Claude skills directory and you're done — no build step, no dependencies.

## Claude Desktop and Claude Code (same path)

Both apps read skills from `~/.claude/skills/`.

```bash
git clone https://github.com/ilarumk/kids-agent-skills.git
mkdir -p ~/.claude/skills

# install one skill
cp -r kids-agent-skills/skills/game-building/game-world-builder ~/.claude/skills/

# or install all five
find kids-agent-skills/skills -mindepth 2 -maxdepth 2 -type d \
  -exec cp -r {} ~/.claude/skills/ \;
```

Restart the app. The skill loads automatically when your kid's prompt matches the triggers in its `description` field.

| OS | Path |
|---|---|
| macOS | `~/.claude/skills/` |
| Linux | `~/.claude/skills/` |
| Windows | `C:\Users\<you>\.claude\skills\` |

## claude.ai (web)

Skills on the web app are available on **Pro, Max, Team, and Enterprise** plans — not Free ([Claude pricing](https://claude.com/pricing)).

1. Sign in to [claude.ai](https://claude.ai) on a paid plan.
2. **Settings → Capabilities → Skills → Upload skill.**
3. Zip the skill folder and upload it:
   ```bash
   cd kids-agent-skills/skills/game-building
   zip -r game-world-builder.zip game-world-builder
   ```
4. Toggle the skill on in the workspace where (with your supervision) your kid will use it.

## For parents — first-time setup

You don't need to be technical to use this. Here's the short version:

1. **Get a Claude account.** Free works for Claude Desktop / Claude Code; Pro or higher for the web app's Skills upload UI.
2. **Install one skill first.** `game-world-builder` is the best starter — it's the most demoable.
3. **Sit with your kid the first time.** Turn on voice. Ask them to say something into the prompt. Watch what comes back.
4. **Open the generated HTML file.** It runs offline — no further setup.
5. **If it doesn't work as expected,** [open an issue](https://github.com/ilarumk/kids-agent-skills/issues) with the prompt your kid used.

### What this library does NOT do

- It does not give your kid their own Claude account. **You operate the account** — Anthropic's Consumer Terms require Claude.ai users to be 18+. Details in [SAFETY.md](./SAFETY.md).
- It does not connect to the internet from inside the games or stories — every artifact runs offline once generated.
- It does not store your kid's voice, name, or anything they type. The browser does the voice-to-text locally; only the transcript goes to Claude.

### Age bands

Each skill is tuned to three bands. Pick what matches your kid:

| Band | Ages | Style |
|---|---|---|
| Sprout | 5–7 | Read-aloud, max 2 sentences per turn, lots of emoji, one choice at a time |
| Sapling | 8–10 | Short paragraphs, simple branching choices |
| Branch | 11–12 | Full responses, multi-step puzzles, code visible if requested |

Each skill states its target band in the `SKILL.md` frontmatter.

### Supervision

- **First five sessions:** sit nearby. Watch how your kid talks to Claude.
- **After that:** check in once a week, browse what they've made.
- **Boundaries:** skills are designed to refuse or redirect unsafe topics ([SAFETY.md](./SAFETY.md)). If a refusal didn't fire when it should have, please report it.

### Privacy

- Browser does voice-to-text locally; only the transcript goes to Claude.
- No skill writes your kid's name, school, address, or photos to disk.
- No skill makes network calls from generated artifacts.
- Anthropic's [privacy policy](https://www.anthropic.com/legal/privacy) governs anything sent to Claude.

## Uninstall

```bash
rm -rf ~/.claude/skills/<skill-name>
```
