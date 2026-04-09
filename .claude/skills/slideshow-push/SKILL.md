---
name: slideshow-push
description: Push local deck changes back to the Slideshow Platform. Use when the user wants to push, upload, or save changes to a deck. Args: optional deck directory path (defaults to current/most recently pulled deck).
---

# Slideshow Push

Push local file changes back to the Slideshow Platform.

## Workflow

### Step 1: Determine deck directory and ID

If the user provided a path, use it. Otherwise look for a `decks/` directory and find the most recently modified one. Read `.deck-id` from that directory to get the deck UUID.

If no `.deck-id` file is found, ask the user for the deck ID.

### Step 2: Compute file hashes

For each file in the deck directory (excluding `.deck-id`), compute:
- SHA-256 hash of the file content
- File size in bytes

Use bash:
```bash
sha256sum path/to/file
wc -c < path/to/file
```

### Step 3: Get upload session

Call `push_deck` with the deck ID and the file manifest (array of `{path, sha, size}` objects). This returns an upload token and URL.

### Step 4: Upload each file

For each file, run:
```bash
curl -s -X PUT \
  -H "X-Upload-Token: {token}" \
  -H "X-File-Path: {path}" \
  --data-binary @"{localPath}" \
  "{url}"
```

### Step 5: Commit

Call `commit_upload` with the deck ID, upload token, and a descriptive commit message summarising what changed.

### Step 6: Report

Tell the user:
> Pushed **{N} file(s)** to **{deck title}** — build triggered.
>
> View at: `{platform URL}/decks/{deckId}`

If they want to submit for review, suggest `/slideshow-submit`.
