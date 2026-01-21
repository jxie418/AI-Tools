# Task Complete - Mark Task as Done

You are marking a task or sub-task as complete.

## Arguments
$ARGUMENTS

Optional: Specify which task/sub-task to complete. If empty, completes current in-progress item.

## Process

### 1. Read Current State

Read `.claude/Tasks.md` to understand:
- Current active task(s)
- Which sub-tasks are complete/incomplete
- Current progress

### 2. Determine What to Complete

#### If no arguments:
- Find the current "in progress" sub-task (first `- [ ]` under active task)
- Mark it as complete `- [x]`
- Report what was completed

#### If argument is a sub-task name:
- Find matching sub-task under active task
- Mark it as complete
- Example: `/task complete "Write unit tests"`

#### If argument is `all`:
- Mark all remaining sub-tasks as complete
- Move task to "## Completed Tasks" section
- Clean up any temporary files

#### If argument is the radar ID:
- Mark entire task and all sub-tasks as complete
- Move to "## Completed Tasks" section
- Example: `/task complete radar://123456`

### 3. Update Tasks.md

Before:
```markdown
## Active Tasks

- [ ] radar://123456 - Add user authentication
  - [x] Create branch
  - [x] Gather requirements
  - [ ] Create system design
  - [ ] Implement solution
```

After completing "Create system design":
```markdown
## Active Tasks

- [ ] radar://123456 - Add user authentication
  - [x] Create branch
  - [x] Gather requirements
  - [x] Create system design
  - [ ] Implement solution
```

### 4. Check for Task Completion

If all sub-tasks are complete:
```markdown
## Active Tasks

(empty)

## Completed Tasks

- [x] radar://123456 - Add user authentication
  - [x] Create branch
  - [x] Gather requirements
  - [x] Create system design
  - [x] Implement solution
  - [x] Write unit tests
  - [x] Create manual test plan
  - [x] Run quality checks
  - [x] Create PR
  - [x] Address review comments
```

### 5. Cleanup Actions

When entire task is complete:
1. Move task to "Completed Tasks" section
2. Update agent-state.md (move agents to completed)
3. Optionally archive design documents
4. Report completion summary
5. **IMPORTANT**: Remind user to run `/clear` or `/compact` to save tokens

### 6. Next Steps

After completing a sub-task, suggest next action:
```
Completed: Create system design

Next step: Implement solution
Run: /task implement

Or check status: /task status
```

After completing entire task:
```
Task Complete: radar://123456 - Add user authentication

All sub-tasks finished:
- [x] Create branch
- [x] Gather requirements
- [x] Create system design
- [x] Implement solution
- [x] Write unit tests
- [x] Create manual test plan
- [x] Run quality checks
- [x] Create PR
- [x] Address review comments

Task moved to Completed Tasks section.

## Save Tokens

Run one of these commands to clear context and save tokens:
- /clear   - Clear conversation history completely
- /compact - Summarize and compact the conversation

## Next

Start a new task: /task new radar://ID description
```

## Error Handling

### No Active Task
```
No active task found in Tasks.md.
Start a new task with: /task new radar://ID description
```

### Task Not Found
```
Could not find task or sub-task matching: "<argument>"
Check Tasks.md for available tasks.
```

### Already Complete
```
"<sub-task>" is already marked as complete.
Current progress: 5/9 sub-tasks done.
```

## Output

1. Update `.claude/Tasks.md` with completion status
2. Report what was completed
3. Suggest next steps
4. If task fully complete, show summary

Now read Tasks.md and mark the appropriate item as complete.
