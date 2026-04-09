---
name: slideshow-pull
description: Pull a deck from the Slideshow Platform to local disk for editing. Use when the user wants to pull, download, or edit a deck locally. Args: deck ID (UUID).
---

# Slideshow Pull

Pull a deck from the Slideshow Platform to local disk so the user can edit it.

The user provides a deck ID (UUID). If they haven't provided one, ask for it or suggest using `/slideshow-find` to locate a deck first.

## Workflow

### Step 1: Get deck metadata

Call `get_deck` with the provided deck ID to retrieve the deck title, scope, and other metadata. Use the title to name the local directory.

### Step 2: Get file manifest

Call `pull_deck` with the deck ID. This returns a list of files with their paths, SHAs, sizes, and encodings.

### Step 3: Determine local path

Store the deck locally at:
```
decks/{slug}/
```
Where `{slug}` is the deck title lowercased with spaces replaced by hyphens (e.g., `decks/my-deck-title/`). Also write a `.deck-id` file in that directory containing the deck UUID so push can find it later.

If the directory already exists, compare SHAs — only download files that differ.

### Step 4: Download each file

For each file in the manifest, read its content using the MCP resource:
```
slideshow://decks/{deckId}/files/{path}
```

Use `ReadMcpResourceTool` to read each file. Write the content to disk at `decks/{slug}/{path}`. Handle both `utf-8` and `base64` encodings.

### Step 5: Report

Tell the user:
> Pulled **{title}** → `decks/{slug}/`
>
> Files:
> - `slides.md` — main slide content
> - (list other files)
>
> Edit `decks/{slug}/slides.md` and run `/slideshow-push` when ready.
