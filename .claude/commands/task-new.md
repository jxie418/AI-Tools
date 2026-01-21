# Task New - Create New Task

You are creating a new task and setting up the development environment.

## Arguments
$ARGUMENTS

Expected format: `radar://ID description of the task`
Example: `radar://123456 Create a new API for user authentication`

## Process

### 1. Parse Task Information

Extract from arguments:
- **Radar ID**: The number after `radar://` (e.g., `123456`)
- **Task Title**: Full argument string (e.g., `radar://123456 Create a new API`)
- **Branch Name**: `radar_<ID>` (e.g., `radar_123456`)

### 2. Validate Input

If arguments don't start with `radar://`:
```
Error: Task must start with radar://ID
Example: /task new radar://123456 Create a new API
```

### 3. Check for Existing Task

Read `.claude/Tasks.md` and check if task already exists:
- If exists and incomplete: Ask if user wants to resume instead
- If exists and complete: Ask if user wants to create duplicate
- If not exists: Proceed with creation

### 4. Git Setup

```bash
# Ensure we're on latest main
git checkout main
git pull origin main

# Create new branch
git checkout -b radar_<ID>
```

### 5. Add Task to Tasks.md

Add new task entry under "## Active Tasks":

```markdown
- [ ] radar://<ID> - <Description>
  - [ ] Create branch
  - [ ] Gather requirements
  - [ ] Create system design
  - [ ] Implement solution
  - [ ] Write unit tests
  - [ ] Create manual test plan
  - [ ] Run quality checks
  - [ ] Create PR
  - [ ] Address review comments
```

### 6. Mark Branch Creation Complete

Update Tasks.md:
```markdown
- [ ] radar://<ID> - <Description>
  - [x] Create branch
  - [ ] Gather requirements
  ...
```

### 7. Next Steps

After task creation, inform the user:

```
Task created successfully!

**Task:** radar://<ID> - <Description>
**Branch:** radar_<ID>

## Next Steps

1. **Gather requirements** (recommended):
   /task requirements

2. **Create system design**:
   /task design

3. **Or jump straight to implementation**:
   /task implement

4. **Check status anytime**:
   /task status
```

## Error Handling

### Invalid Format
```
Please provide a task in the format:
/task new radar://123456 Description of the task
```

### Git Errors
- If branch already exists: Ask to checkout existing or create new name
- If not on git repo: Inform user to initialize git first
- If uncommitted changes: Warn and ask how to proceed

### Tasks.md Missing
Create the file with template if it doesn't exist.

## Output

1. Create git branch
2. Update `.claude/Tasks.md` with new task
3. Report success with next step suggestions

Now parse the arguments and create the new task.
