# Claude Code Workbench

A devcontainer template for instant AI-powered development environments with Claude Code, GitHub Copilot, and comprehensive CLI tooling — ready to go in minutes.

## Prerequisites

Before you start, you need **Docker** running on your machine and a **devcontainer-compatible IDE** (VS Code, Cursor, etc.).

### Windows

1. **Install WSL 2** (Windows Subsystem for Linux):
   - Open PowerShell as Administrator and run:
     ```powershell
     wsl --install
     ```
   - Restart your computer when prompted.
   - After restart, WSL will finish setup and ask you to create a Linux username and password.
   - Verify with `wsl --version` — you should see version 2.x.

2. **Install Docker Desktop**:
   - Download from [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/).
   - During installation, ensure **"Use WSL 2 based engine"** is checked.
   - After install, open Docker Desktop > Settings > Resources > WSL Integration and enable your distro.
   - Verify with `docker --version` in a terminal.

3. **Install VS Code** (or your preferred IDE):
   - Download from [code.visualstudio.com](https://code.visualstudio.com/).
   - Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

### macOS

1. **Install Docker Desktop**:
   - Download from [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/).
   - Open the `.dmg`, drag Docker to Applications, and launch it.
   - Grant permissions when prompted and wait for Docker to start (whale icon in menu bar).
   - Verify with `docker --version` in Terminal.

2. **Install VS Code** (or your preferred IDE):
   - Download from [code.visualstudio.com](https://code.visualstudio.com/).
   - Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

### Linux

1. **Install Docker Engine**:
   - Follow the official guide for your distro: [docs.docker.com/engine/install](https://docs.docker.com/engine/install/).
   - Add your user to the docker group: `sudo usermod -aG docker $USER` (log out and back in).
   - Verify with `docker --version`.

2. **Install VS Code** and the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

## Quick Start

### Option 1: GitHub Codespaces (no local setup needed)

Click **Use this template** > **Create a new repository**, then open it in a Codespace. Everything runs in the cloud — no Docker or WSL required.

### Option 2: VS Code Dev Containers

1. Clone the repo:
   ```bash
   git clone https://github.com/Insight-Services-APAC/claude-code-workbench.git
   cd claude-code-workbench
   ```
2. Open in VS Code:
   ```bash
   code .
   ```
3. When prompted, click **Reopen in Container** (or run `Dev Containers: Reopen in Container` from the command palette).

### Option 3: CLI

```bash
devcontainer up --workspace-folder .
```

Everything installs automatically on first launch via `post-create.sh`. No manual setup needed.

## What You Get

Once the container starts, you have a fully configured environment with:

### AI Assistants
- **Claude Code** — Anthropic's CLI agent for autonomous software engineering
- **GitHub Copilot** — AI pair programming in VS Code
- **BMAD Method v6** — Agile AI-driven development framework with 10 specialized agents and 25 workflows
- **Frontend Design Plugin** — UI/UX best practices baked into Claude Code

### Development Runtimes
- **Node.js 20** — JavaScript/TypeScript runtime
- **Python 3.12** — With pip and venv

### Document Creation
- **pandoc** — Convert between Markdown, PDF, DOCX, HTML, and more
- **python-pptx** — Programmatic PowerPoint generation
- **openpyxl / xlsxwriter** — Excel spreadsheet creation and manipulation
- **pandas** — Data processing and analysis

### CLI Tools
- **git** — Version control
- **gh** — GitHub CLI for PRs, issues, releases
- **az** — Azure CLI

## Project Structure

```
.devcontainer/
  devcontainer.json       # Container definition with Node.js 20 + Python 3.12
  post-create.sh          # Auto-installs Claude Code, BMAD, pandoc, doc tools
CLAUDE.md                 # Claude Code instructions (imports AGENTS.md)
AGENTS.md                 # Shared AI agent instructions (works with any AI coding agent)
.gitignore                # Pre-configured for Node, Python, BMAD artifacts
```

## How It Works

This workbench uses two instruction files to guide AI coding agents:

- **`AGENTS.md`** — The single source of truth for all AI agents. Contains environment setup, commands, code style, boundaries, and BMAD workflows. Works with Claude Code, GitHub Copilot, Cursor, Codex, and any agent that supports the [AGENTS.md standard](https://agents.md/).
- **`CLAUDE.md`** — Claude Code-specific instructions. Imports `AGENTS.md` and adds Claude Code-specific behaviour (tool usage, collaboration style, slash commands).

### What the AI agents do

- **Know they're in a container** — install packages, run commands, and operate autonomously without hesitation.
- **Collaborate during planning** — challenge assumptions, present alternatives, ask clarifying questions upfront.
- **Ask your preferred mode** before starting:
  - **Prototype** — speed-first, fast iterations, minimal tests.
  - **Production** — Testing Trophy methodology, CI-ready, fully tested.
- **Execute autonomously** using BMAD workflows — create artifacts, run adversarial reviews, fix issues without hand-holding.
- **Create documents** — PDFs, PowerPoints, Excel files, not just code.

## BMAD Method

[BMAD](https://github.com/bmad-code-org/BMAD-METHOD) (Breakthrough Method for Agile AI-Driven Development) provides structured workflows for the full development lifecycle:

| Workflow | What it does |
|----------|-------------|
| Product Brief | Define the product vision |
| PRD | Detailed product requirements |
| Architecture | Technical architecture design |
| Epics & Stories | Break work into deliverables |
| Dev Story | Implement a story end-to-end |
| Adversarial Review | Cynical review to find gaps |
| Code Review | Automated code quality checks |
| Course Correction | Pivot when things go off track |

All available as `/bmad-*` slash commands inside Claude Code.

## Customising for Your Project

1. **Edit `AGENTS.md`** — Add project-specific context, architectural decisions, API details, conventions (applies to all AI agents).
2. **Edit `CLAUDE.md`** — Add Claude Code-specific preferences (applies only to Claude Code sessions).
3. **Choose your stack** — The agent will ask whether you want React/Vite, Vue/Nuxt 4, or your own.
4. **Pick your mode** — Prototype (fast) or Production (tested).
5. **Start building** — The AI handles the rest.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Reopen in Container" not showing | Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) in VS Code |
| Docker not running on Windows | Open Docker Desktop and ensure WSL 2 integration is enabled in Settings > Resources |
| Container build fails | Check Docker has enough resources: Settings > Resources > increase memory to 4GB+ |
| `claude` command not found | Run `curl -fsSL https://claude.ai/install.sh \| bash` inside the container |
| BMAD not installed | Run `npx --yes bmad-method install --modules bmm --tools claude-code --yes` inside the container |

## License

MIT
