# Claude Code Task Workflow

This directory contains a comprehensive task automation workflow for Claude Code CLI.

## Overview

The `/task` command system provides a modular, composable workflow for software development:

1. **Task Management** - Track tasks with auto-resume capability
2. **Requirements Gathering** - Comprehensive upfront questions
3. **System Design** - Architecture diagrams and API contracts
4. **Implementation** - Code with quality standards
5. **Testing** - Unit tests and manual test plans
6. **Code Review** - PR creation and review iteration
7. **Parallel Execution** - Run multiple sub-tasks concurrently

## Quick Start

### Start a New Task
```
/task radar://123456 Add user authentication feature
```

### Resume Incomplete Task
```
/task
```

### Run Specific Sub-Command
```
/task requirements    # Deep requirements gathering
/task design          # Create system design
/task implement       # Implement code
/task test            # Add unit tests
/task create-pr       # Create PR with quality checks
```

## Available Commands

| Command | Description |
|---------|-------------|
| `/task` | Auto-resume incomplete task from Tasks.md |
| `/task radar://ID description` | Start new task |
| `/task requirements` | Deep requirements gathering |
| `/task design` | Create system design document |
| `/task implement [--no-confirm]` | Implement code |
| `/task refactor` | Refactor existing code |
| `/task test` | Add unit tests |
| `/task test-manual` | Create manual test plan |
| `/task test-run` | Run tests and fix failures |
| `/task create-pr` | Create PR with quality checks |
| `/task review <PR_URL>` | Review a PR |
| `/task fix-comments` | Fix PR review comments |
| `/task status` | Show current status |
| `/task parallel <cmd1> <cmd2>` | Run commands in parallel |

## File Structure

```
.claude/
├── Tasks.md              # Task tracking (main task list)
├── agent-state.md        # Active/completed agents
├── commands/             # Skill files for each sub-command
│   ├── task.md           # Main router
│   ├── task-requirements.md
│   ├── task-design.md
│   ├── task-implement.md
│   ├── task-refactor.md
│   ├── task-test.md
│   ├── task-test-manual.md
│   ├── task-test-run.md
│   ├── task-create-pr.md
│   ├── task-review.md
│   ├── task-fix-comments.md
│   ├── task-status.md
│   └── task-parallel.md
├── designs/              # Design documents
│   └── radar-<ID>-design.md
├── test-plans/           # Manual test plans
│   └── radar-<ID>-manual-tests.md
├── codereview/           # PR review screenshots
├── scripts/              # Automation scripts
│   ├── capture-pr-screenshots.js
│   └── pr-review-monitor.js
└── WORKFLOW_README.md    # This file
```

## Task Format

Tasks in `Tasks.md`:
```markdown
## Active Tasks

- [ ] radar://123456 - Add user authentication
  - [x] Create branch
  - [x] Gather requirements
  - [x] Create design
  - [ ] Implement feature
  - [ ] Write tests
  - [ ] Create PR
  - [ ] Address review comments

## Completed Tasks

- [x] radar://123455 - Fix login bug
```

## Workflow Phases

### Phase 1: Task Setup
```bash
/task radar://123456 Add new feature
```
- Parses radar ID
- Creates branch `radar_123456`
- Adds task to Tasks.md

### Phase 2: Requirements
```bash
/task requirements
```
- Asks comprehensive questions upfront
- Creates `.claude/designs/radar-123456-requirements.md`
- Goal: No questions needed during implementation

### Phase 3: Design
```bash
/task design
```
- Creates architecture diagrams (Mermaid)
- Defines API contracts
- Documents data models
- Output: `.claude/designs/radar-123456-design.md`

### Phase 4: Implementation
```bash
/task implement
# or
/task implement --no-confirm
```
- Follows design document
- Applies quality standards
- Updates Tasks.md progress

### Phase 5: Testing
```bash
/task test           # Unit tests
/task test-manual    # Manual test plan
/task test-run       # Run and fix tests
```

### Phase 6: PR Creation
```bash
/task create-pr
```
Quality checks before PR:
- DRY Principle
- Clean Code
- Naming Conventions
- Data Validation
- Single Responsibility
- Type Safety
- Consistent Error Handling
- Lint/Build passes
- Tests pass

### Phase 7: Review Iteration
```bash
/task fix-comments
```
- Fetches review comments
- Addresses valid feedback
- Single commit for all fixes
- Requests re-review

## Mode Flags

### Interactive Mode (default)
- Asks for confirmation on decisions
- Clarifies ambiguous requirements

### Batch Mode
```bash
/task implement --no-confirm
```
- Uses best judgment for simple decisions
- Still asks for complex situations
- Documents assumptions

## Parallel Execution

Run multiple commands simultaneously:
```bash
/task parallel test lint
/task parallel "test-run" "test-manual"
```

Agent coordination via `.claude/agent-state.md`:
```markdown
## Active Agents
- agent-test | radar://123 | running | 2026-01-21 10:00
- agent-lint | radar://123 | running | 2026-01-21 10:00

## Completed Agents
- agent-test | radar://123 | passed | 2026-01-21 10:05
```

## Code Quality Standards

All implementations must follow:

| Standard | Description |
|----------|-------------|
| DRY | No duplicated code |
| Clean Code | Readable, simple, well-structured |
| Naming | Clear, consistent conventions |
| Validation | Inputs validated at boundaries |
| Single Responsibility | One purpose per function |
| Type Safety | Proper types, no unsafe `any` |
| Error Handling | Consistent patterns, meaningful messages |
| Maintainability | Easy to understand and modify |

## PR Review Automation

### Capture Screenshots
```bash
node .claude/scripts/capture-pr-screenshots.js <PR_URL> .claude/codereview
```

### Monitor for Reviews
```bash
node .claude/scripts/pr-review-monitor.js <PR_URL>
```

### After Fixing Comments
1. Stage changes: `git add .`
2. Commit: `git commit -m "Address code review feedback"`
3. Push: `git push`
4. Clean screenshots: `rm -rf .claude/codereview/*.png`
5. Request re-review: `gh pr comment --body "@devai review"`

## Setup

### Prerequisites
- Node.js (v16+)
- GitHub CLI (`gh`) authenticated
- Git repository with `main` branch

### Install Dependencies
```bash
cd .claude/scripts
./setup.sh
```

## Tips

1. **Use `/task` to resume** - Just type `/task` to continue where you left off
2. **Deep requirements first** - Use `/task requirements` to avoid interruptions
3. **Design before code** - `/task design` creates clear blueprints
4. **Quality checks automatic** - PR creation runs all checks
5. **Parallel when possible** - Use `/task parallel test lint` to save time

## Troubleshooting

### Task not resuming
- Check `Tasks.md` has incomplete tasks with `- [ ]`
- Ensure radar ID format: `radar://123456`

### Agent not coordinating
- Check `agent-state.md` for stuck agents
- Clear completed agents section

### PR creation failing
- Run quality checks manually: `npm run lint && npm test`
- Check git status for uncommitted changes

## License

Part of the AI-Tools project.
