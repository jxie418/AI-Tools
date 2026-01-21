# Task Workflow Router

You are a task workflow orchestrator. This is the main entry point for `/task` command with sub-command routing.

## Arguments
$ARGUMENTS

## Sub-Command Routing

Parse the arguments and route to the appropriate sub-command:

| Command | Action |
|---------|--------|
| (empty) | Auto-resume: Read `.claude/Tasks.md`, find first incomplete task, continue workflow |
| `requirements` | Deep requirements gathering - ask comprehensive questions upfront |
| `design` | Create system design document with architecture and API contracts |
| `implement [--no-confirm]` | Implement code (--no-confirm skips confirmations for simple decisions) |
| `refactor` | Refactor existing code with quality improvements |
| `test` | Add unit tests for new/touched code |
| `test-manual` | Create manual test steps/scripts |
| `test-run` | Run tests and fix failures |
| `create-pr` | Create PR with quality checks |
| `review <PR_URL>` | Review a PR |
| `fix-comments` | Fix PR review comments |
| `lint` | Run linting and fix issues |
| `docs` | Generate/update documentation |
| `security` | Security review of changes |
| `performance` | Performance review/optimization |
| `status` | Show current task and agent status |
| `parallel <cmd1> <cmd2>` | Run multiple sub-tasks in parallel |
| `<radar://ID> <description>` | Start new task with given ID |

## Auto-Resume Logic

When no arguments provided:
1. Read `.claude/Tasks.md`
2. Find first task matching `- [ ] radar://` (incomplete main task)
3. Within that task, find first incomplete sub-task `- [ ]`
4. Resume from that step

## New Task Logic

When argument starts with `radar://`:
1. Extract radar ID from argument
2. Check if task exists in Tasks.md
3. If not, add new task entry
4. Run: `git checkout main && git pull origin main && git checkout -b radar_<ID>`
5. Proceed to requirements gathering

## Permissions

You have permission to:
- Read/write all files under the project folder
- Execute shell commands for git, npm, linting, testing
- Create/modify files in `.claude/` folder
- Search and edit files in the project

## Execution Flow

Based on the arguments, execute the appropriate workflow:

### If no arguments (auto-resume):
```
1. Read .claude/Tasks.md
2. Parse to find incomplete task
3. Determine current step
4. Execute that step's workflow
5. Update Tasks.md on completion
```

### If new task (radar://...):
```
1. Parse radar ID
2. Add to Tasks.md if not exists
3. Create branch
4. Start requirements gathering
5. Update Tasks.md progress
```

### If sub-command:
```
1. Validate sub-command
2. Execute sub-command workflow
3. Update Tasks.md on completion
```

## Agent Coordination

For any step that uses agents:
1. Register agent in `.claude/agent-state.md`
2. Execute the task
3. Update agent status on completion
4. Update `.claude/Tasks.md` with results

## Mode Flags

- `--no-confirm` or `--batch`: Skip confirmation prompts, use best judgment for simple decisions, still ask clarifying questions for complex ones
- `--interactive` (default): Ask as needed during execution

Now analyze the arguments and execute the appropriate workflow.
