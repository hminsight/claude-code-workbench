---
name: slideshow-find
description: Search for decks and slides on the Slideshow Platform. Use when the user wants to browse, search, or find decks. Args: optional search query or filter terms.
---

# Slideshow Find

Browse and search the Slideshow Platform deck library.

The user may provide a search query, filters (practice area, industry, scope), or just want to browse.

## Workflow

### Step 1: Determine search intent

If the user provided a query (e.g. "find decks about Azure"), use `search_slides` with that query.

If they want to browse by category, call `list_sections` to show available practices and industries first, then `list_decks` with appropriate filters.

If they want to see their own decks, call `list_decks` with `view: "my-decks"`.

If they want to see what's shared with them, call `list_decks` with `view: "shared-with-me"`.

For a general browse, call `list_decks` with `view: "library"`.

### Step 2: Display results

Show results in a table:

| Title | Scope | Practice | ID |
|-------|-------|----------|----|
| ... | ... | ... | `uuid` |

Show the deck ID so the user can use it with `/slideshow-pull`.

### Step 3: Offer next steps

> Found **{N} decks**. To pull one locally:
> `/slideshow-pull {deck-id}`
>
> To refine the search, try filtering by practice or industry.

If no results, suggest alternate queries or browsing by section.
