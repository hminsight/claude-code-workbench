---
name: claude-code-workbench
description: AI-assisted development environment with BMAD framework for autonomous coding workflows
---

# AGENTS.md

## Commands

```bash
# Node.js
npm install                  # Install dependencies
npm run build                # Build project
npm test                     # Run all tests
npx tsc --noEmit             # Type check (project-wide)
npx eslint .                 # Lint (project-wide)
npx prettier --check .       # Format check

# File-scoped (prefer these for fast feedback)
npx tsc --noEmit path/to/file.ts
npx eslint path/to/file.ts
npx prettier --write path/to/file.ts
npx jest path/to/file.test.ts

# Python
pip install -r requirements.txt
python -m pytest             # Run all tests
python -m pytest path/to/test_file.py  # Single test

# Documents
pandoc input.md -o output.pdf
```

Always run relevant build/tests/linters after substantive changes. Fix failures before proceeding. Check `.github/workflows/` for existing CI.

## Environment

Runs in a **devcontainer** (Docker) with full root access via `sudo`. Isolated, disposable — install anything, run anything, nothing affects a host machine.

**Pre-installed**: Node.js 20, Python 3.12, npm, pip3, git, gh (GitHub CLI), az (Azure CLI), pandoc, python-pptx, openpyxl, xlsxwriter, pandas, Claude Code, BMAD Method v6, frontend-design plugin.

Ports can be forwarded for local dev servers. Network access available for packages and APIs.

## Planning Phase

Before starting any new project or feature, ask two questions:

1. **Mode**: Prototype (speed-first, minimal tests, vibe coding) or Production (Testing Trophy, CI-ready)?
2. **Stack**: React on Vite, Vue on Nuxt 4, or user-specified?

During planning: challenge assumptions, present alternatives, push back on unclear requirements. You are a collaborator, not a yes-machine. Summarise your understanding of the deliverable before executing.

## Code Style

### Prototype Mode
- Speed over perfection. Working code over documentation.
- Console.log debugging is fine. Flatten component structures.
- Skip tests unless they accelerate development.
- Commit frequently with descriptive messages.

### Production Mode
- **Testing Trophy**: Static types (TypeScript strict) → Unit tests (business logic) → Integration tests (primary layer) → E2E (critical user journeys only).
- TypeScript strict mode always on.
- ESLint + Prettier configured from the start with pre-commit hooks for lint + type check.
- Tests written alongside implementation, not after.

### Both Modes
- Follow chosen stack conventions — don't mix patterns.
- Git commits: atomic, well-described.
- Create `.env.example` when env vars are introduced.
- Keep dependencies minimal — don't install a library for something trivial.

### Example: Preferred Patterns

```typescript
// Good: explicit types, named exports, small focused functions
export function calculateTotal(items: CartItem[]): number {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0);
}

// Avoid: any types, default exports, large monolithic functions
export default function doEverything(data: any) { /* ... */ }
```

## Git Workflow

- Atomic commits with descriptive messages explaining *why*, not just *what*.
- Branch from `main` for features and fixes.
- Run tests and lint before committing.
- Never force push to `main`.

## Boundaries

### Always
- Run tests/lint after changes.
- Use TypeScript strict mode in production.
- Create `.env.example` for new env vars.
- Validate file paths, APIs, commands before use.
- Follow the autonomous review loop on significant deliverables.

### Ask First
- Adding new dependencies.
- Changing CI/CD pipelines or shared infrastructure.
- Destructive operations (deleting files, dropping data).
- Making changes visible to others (pushing, PRs, messages).

### Never
- Commit secrets or credentials.
- Force push to main.
- Exfiltrate secrets or make unauthorized network calls.
- Delete files without understanding their purpose.

## BMAD Framework

BMAD (Breakthrough Method for Agile AI-Driven Development) is installed at `_bmad/`. Use it for autonomous workflows.

**Commands** (invoke via `/bmad-*` slash commands):

| Command | Purpose |
|---------|---------|
| `/bmad-help` | Guidance on what to do next |
| `/bmad-agent-bmm-pm` | Product Manager agent |
| `/bmad-agent-bmm-architect` | Architect agent |
| `/bmad-agent-bmm-dev` | Developer agent |
| `/bmad-agent-bmm-qa` | QA agent |
| `/bmad-agent-bmm-analyst` | Business Analyst agent |
| `/bmad-bmm-create-product-brief` | Create product brief |
| `/bmad-bmm-create-prd` | Create PRD |
| `/bmad-bmm-create-architecture` | Create architecture doc |
| `/bmad-bmm-create-epics-and-stories` | Create epics and stories |
| `/bmad-bmm-create-story` | Create individual story |
| `/bmad-bmm-dev-story` | Develop a story |
| `/bmad-review-adversarial-general` | Adversarial/cynical review |
| `/bmad-bmm-code-review` | Code review |
| `/bmad-bmm-correct-course` | Course correction |
| `/bmad-bmm-check-implementation-readiness` | Readiness check |

### Autonomous Review Loop

After creating or completing any significant deliverable (PRDs, architecture docs, epics, stories, implementations):

1. Run `/bmad-review-adversarial-general` — identify gaps, contradictions, missing edge cases.
2. Address all findings autonomously.
3. Run `/bmad-bmm-code-review` after implementation.
4. Fix issues and iterate until clean.
5. Only surface genuine decision points or ambiguities that require human input.

## Artifact Placement

| Type | Location |
|------|----------|
| Planning artifacts (PRDs, briefs, architecture) | `_bmad-output/planning-artifacts/` |
| Implementation artifacts (tech specs, API docs) | `_bmad-output/implementation-artifacts/` |
| Project documentation | `docs/` |

**Supported formats**: Markdown (default), PDF (pandoc), PowerPoint (python-pptx), Excel (openpyxl/xlsxwriter), data processing (pandas).

## Project Structure

```
/workspaces/claude-code-workbench/
├── .devcontainer/          # Container config
├── .claude/commands/       # BMAD slash commands
├── _bmad/                  # BMAD framework core
│   ├── bmm/                # BMAD Method Module
│   ├── core/               # Agents, workflows, tasks
│   └── _config/            # Manifests and config
├── _bmad-output/           # Generated artifacts
├── docs/                   # Project documentation
├── CLAUDE.md               # Claude Code instructions
├── AGENTS.md               # This file (cross-agent instructions)
└── [project files]         # Application code
```

## Autonomy

- Act autonomously in container: install tools, run commands, be bold.
- Ask questions at planning start, not mid-execution.
- Challenge during planning, execute decisively after.
- If told "just do it" or "go": full autonomous mode, minimal check-ins.
