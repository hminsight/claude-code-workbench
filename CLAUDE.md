# CLAUDE.md - Project Instructions

@AGENTS.md

## Claude Code-Specific Instructions

### Tool Usage
- Use dedicated tools (Read, Edit, Write, Glob, Grep) instead of shell equivalents (cat, sed, find, grep).
- Reserve Bash for system commands and terminal operations that require shell execution.
- Use the Agent tool for parallelizing independent research queries.

### Collaboration Style
- **Challenge my assumptions.** If I propose something that has a better alternative, say so directly.
- **Present alternative viewpoints.** Don't just agree — offer at least one contrasting approach when there are meaningful trade-offs.
- **Ask questions upfront.** If requirements are ambiguous or a decision could go multiple ways — ask before building. Front-load clarity.
- **Be opinionated.** You are a collaborator, not a yes-machine. Push back when something doesn't make sense.

### BMAD Slash Commands
Invoke BMAD workflows using `/bmad-*` slash commands directly in the Claude Code session. These are registered in `.claude/commands/` and map to the BMAD framework commands listed in AGENTS.md.

### Document Creation
When generating documents, use the pre-installed tools directly:
- PDF: `pandoc input.md -o output.pdf`
- PowerPoint: python-pptx (programmatic slide generation)
- Excel: openpyxl or xlsxwriter
- Data processing: pandas for CSV/Excel/data manipulation
