---
name: slideshow-compose
description: Compose a new deck by combining slides from existing decks on the Slideshow Platform. Use when the user wants to create a new deck, assemble slides from multiple sources, or clone and customise an existing deck. Args: optional description of what to compose.
---

# Slideshow Compose

Create a new deck by assembling content from existing decks, or create a fresh deck from scratch.

## Workflow

### Step 1: Understand the goal

Ask the user (or infer from context):
- What is the new deck for? (audience, purpose, topic)
- Should it be built from existing library slides, cloned from a specific deck, or created fresh?

### Step 2A: Compose from library slides

If the user wants to pull slides from multiple existing decks:

1. Use `search_slides` or `list_decks` to find relevant source decks
2. Show the user candidate decks and confirm which to draw from
3. Pull each source deck's manifest via `pull_deck` and read `slides.md` via the MCP resource `slideshow://decks/{deckId}/files/slides.md`
4. Extract the relevant slide sections (Slidev slides are separated by `---`)
5. Assemble a new `slides.md` combining the selected sections
6. Create the new deck via `create_deck` with the assembled content

### Step 2B: Clone and customise

If the user wants to start from an existing deck:

1. Find the source deck (search or use provided ID)
2. Call `clone_deck` with a new title
3. Pull the cloned deck locally with `/slideshow-pull` instructions
4. Tell the user what to edit

### Step 2C: Create from scratch

If creating a new deck:

1. Ask for: title, scope (default: `user`), practice area (optional)
2. Draft a `slides.md` outline based on the user's topic
3. Call `create_deck` with the content

### Step 3: Report

Tell the user:
> Created **{title}** (ID: `{deckId}`)
>
> Pull it locally to edit:
> `/slideshow-pull {deckId}`
