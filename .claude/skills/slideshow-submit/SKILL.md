---
name: slideshow-submit
description: Submit a deck for manager approval on the Slideshow Platform. Use when the user wants to submit, publish, or send a deck for review. Args: deck ID or local deck directory.
---

# Slideshow Submit

Submit a deck for manager approval. This creates a branch and pull request for review on the platform.

## Workflow

### Step 1: Determine deck ID

If the user provided a deck ID (UUID), use it directly.

If they provided a local directory path (or none), look for `.deck-id` in the most recently worked-on deck under `decks/`.

If no deck ID can be found, ask the user.

### Step 2: Get deck info

Call `get_deck` to retrieve the deck title and current state. Confirm with the user which deck they're submitting.

### Step 3: Prompt for submission details

Ask (or infer from context):
- **Title**: A short title for the submission/PR (e.g. "Update Azure section with new pricing")
- **Description** (optional): What changed and why

### Step 4: Submit

Call `submit_for_approval` with the deck ID, title, and optional description.

### Step 5: Report

Tell the user:
> Submitted **{deck title}** for approval.
>
> PR: **{submission title}**
>
> A manager will review your changes. You'll be notified when it's approved or feedback is provided.
