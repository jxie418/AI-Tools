# Task Parallel - Run Multiple Sub-Tasks

You are orchestrating parallel execution of multiple sub-tasks.

## Arguments
$ARGUMENTS

Arguments format: `<cmd1> <cmd2> [cmd3...]`
Example: `parallel test lint` or `parallel "implement --no-confirm" test`

## Parallel Execution

### Supported Parallel Combinations

| Combination | Use Case |
|-------------|----------|
| `test lint` | Run tests and linting simultaneously |
| `test-run test-manual` | Unit tests + manual test plan |
| `security performance` | Security and performance reviews |
| `docs test` | Documentation and testing |

### Not Recommended in Parallel

| Combination | Reason |
|-------------|--------|
| `implement test` | Tests depend on implementation |
| `create-pr *` | PR should be last step |
| `fix-comments *` | Sequential by nature |

## Execution Process

### 1. Parse Commands
```
1. Split arguments into individual commands
2. Validate each command exists
3. Check for dependencies between commands
```

### 2. Register Agents
Update `.claude/agent-state.md`:
```markdown
## Active Agents
- agent-<cmd1> | radar://[ID] | starting | [timestamp]
- agent-<cmd2> | radar://[ID] | starting | [timestamp]
```

### 3. Launch Agents
Use the Task tool to spawn parallel agents:
```
For each command:
1. Create agent with name: agent-<command>
2. Set task: Execute /task <command>
3. Run in background
```

### 4. Monitor Progress
```
1. Periodically check agent-state.md
2. Update status as agents complete
3. Collect results from each agent
```

### 5. Aggregate Results
```
1. Wait for all agents to complete
2. Collect output from each
3. Update Tasks.md with combined results
4. Report summary to user
```

## Agent Communication

### State File Format
`.claude/agent-state.md`:
```markdown
## Active Agents
- agent-test | radar://123 | running tests | 2026-01-21 10:00
- agent-lint | radar://123 | running linter | 2026-01-21 10:00

## Completed Agents
- agent-test | radar://123 | completed: 15 tests passed | 2026-01-21 10:05
- agent-lint | radar://123 | completed: no issues | 2026-01-21 10:03

## Agent Communication
### agent-test → coordinator
Tests completed successfully. Coverage: 85%

### agent-lint → coordinator
Linting passed. No issues found.
```

## Output Format

```markdown
# Parallel Execution Results

## Commands Executed
1. `test` - ✅ Completed
2. `lint` - ✅ Completed

## Results

### test
- 15 tests passed
- Coverage: 85%
- Duration: 5 minutes

### lint
- No issues found
- Duration: 30 seconds

## Summary
All parallel tasks completed successfully.
```

## Error Handling

### If One Agent Fails
```
1. Let other agents continue
2. Mark failed agent in state file
3. Report failure in final summary
4. Suggest fix actions
```

### If All Agents Fail
```
1. Collect all error messages
2. Analyze for common cause
3. Report comprehensive error summary
```

## Cleanup

After all agents complete:
```
1. Move agents from Active to Completed
2. Update Tasks.md with results
3. Clear agent communication messages
```

Now parse the commands and execute them in parallel.
