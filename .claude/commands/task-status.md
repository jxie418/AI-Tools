# Task Status - Show Current Status

You are displaying the current task and agent status.

## Arguments
$ARGUMENTS

## Status Report

Generate a comprehensive status report by reading:
1. `.claude/Tasks.md` - Task progress
2. `.claude/agent-state.md` - Agent status
3. Git status - Working directory state

## Information to Display

### 1. Current Task
```markdown
## Current Task

**Task:** radar://[ID] - [Title]
**Branch:** radar_[ID]
**Status:** [In Progress / Blocked / Ready for PR]

### Progress
- [x] Completed step 1
- [x] Completed step 2
- [ ] Current step (in progress)
- [ ] Pending step
```

### 2. Git Status
```bash
git status --short
git log --oneline -5
```

### 3. Active Agents
```markdown
## Active Agents

| Agent | Task | Status | Started |
|-------|------|--------|---------|
| agent-implement | radar://123 | Running | 10:00 |
```

### 4. Recent Activity
```markdown
## Recent Activity

- [timestamp] Completed: [step]
- [timestamp] Started: [step]
- [timestamp] Agent finished: [agent-name]
```

## Output Format

```markdown
# Task Status Report
Generated: [timestamp]

## Summary
- **Active Tasks:** [count]
- **Active Agents:** [count]
- **Uncommitted Changes:** [yes/no]

---

## Current Task

**radar://[ID]** - [Title]

### Branch
`radar_[ID]` (tracking origin/radar_[ID])

### Progress (X/Y complete)

- [x] Create branch
- [x] Gather requirements
- [ ] **→ Implement solution** (current)
- [ ] Write tests
- [ ] Create PR
- [ ] Address review comments

### Files Changed
```
M  src/file1.ts
A  src/file2.ts
```

---

## Agents

### Active
| Name | Task | Duration |
|------|------|----------|
| (none) | | |

### Recently Completed
| Name | Task | Completed |
|------|------|-----------|
| agent-design | radar://123 | 2 hours ago |

---

## Quick Actions

- Resume current step: `/task`
- Run tests: `/task test-run`
- Create PR: `/task create-pr`
- View all tasks: See `.claude/Tasks.md`
```

## Data Sources

### Tasks.md Parsing
```
- [ ] radar://ID - Title     → Incomplete main task
  - [x] Sub-task 1           → Completed sub-task
  - [ ] Sub-task 2           → Incomplete sub-task
```

### Agent State Parsing
```
## Active Agents
- agent-name | task-id | status | timestamp

## Completed Agents
- agent-name | task-id | completed | timestamp
```

## No Active Task

If no active task found:
```markdown
# Task Status Report

## No Active Task

No incomplete tasks found in `.claude/Tasks.md`.

### Quick Actions
- Start new task: `/task radar://123456 task description`
- View task history: See `.claude/Tasks.md`
```

Now read the status files and generate the report.
