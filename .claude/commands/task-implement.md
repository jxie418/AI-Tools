# Task Implement - Code Implementation

You are implementing code for the current task.

## Arguments
$ARGUMENTS

Flags:
- `--no-confirm` or `--batch`: Skip confirmation prompts for simple decisions, use best judgment

## Current Context

1. Read `.claude/Tasks.md` to identify the current active task
2. Read design from `.claude/designs/radar-<ID>-design.md` if exists
3. Read requirements from `.claude/designs/radar-<ID>-requirements.md` if exists

## Permissions

You have permission to:
- Read/write all files under the project folder
- Execute shell commands (git, npm, build tools)
- Create new files as needed
- Modify existing files

## Implementation Mode

### Interactive Mode (default)
- Ask for confirmation on significant decisions
- Clarify ambiguous requirements
- Propose approaches before implementing

### Batch Mode (--no-confirm)
- Use best judgment for simple decisions
- Still ask for complex/ambiguous situations
- Document assumptions made
- Proceed without confirmation when confident

## Implementation Process

### 1. Preparation
```
1. Review requirements and design documents
2. Understand existing code patterns
3. Plan implementation steps
4. Create task breakdown with TodoWrite
```

### 2. Implementation
```
For each component/feature:
1. Create/modify files
2. Follow existing patterns
3. Ensure type safety
4. Add error handling
5. Keep code clean and DRY
```

### 3. Verification
```
1. Check code compiles/lints
2. Verify functionality works
3. Ensure no regressions
```

## Code Quality Standards

### MUST Follow

#### DRY Principle
- Extract repeated code into functions
- Use shared utilities
- Avoid copy-paste coding

#### Clean Code
- Keep functions small (<30 lines ideal)
- Limit nesting depth (max 3 levels)
- Use early returns
- Clear logic flow

#### Naming Conventions
- Descriptive variable names
- Consistent naming patterns
- Self-documenting code

#### Data Validation
- Validate inputs at boundaries
- Type check where needed
- Handle edge cases

#### Single Responsibility
- One purpose per function
- One purpose per class/module
- Separate concerns

#### Type Safety
- Use proper TypeScript types
- Avoid `any` unless necessary
- Create interfaces for data structures

#### Reusability
- Design for reuse where appropriate
- Don't over-engineer for hypothetical futures
- Balance flexibility with simplicity

#### Maintainability
- Code should be easy to understand
- Easy to modify
- Well-organized

#### Error Handling
- Consistent error patterns
- Meaningful error messages
- Proper error propagation

## Implementation Guidelines

### DO
- Follow existing project patterns
- Use existing utilities when available
- Write self-documenting code
- Handle errors appropriately
- Keep changes focused on the task

### DON'T
- Over-engineer solutions
- Add unnecessary features
- Change unrelated code
- Leave debug code
- Ignore existing patterns

## File Organization

Follow project conventions for:
- File naming
- Directory structure
- Import ordering
- Export patterns

## Progress Tracking

Update `.claude/Tasks.md` as you progress:
```markdown
- [ ] radar://123 - Task title
  - [x] Create branch
  - [x] Gather requirements
  - [x] Create design
  - [ ] Implement feature  ← Current
    - [x] Create types
    - [x] Implement service
    - [ ] Add component
    - [ ] Connect integration
  - [ ] Write tests
  - [ ] Create PR
```

## Error Recovery

If you encounter errors:
1. Read the error message carefully
2. Understand the root cause
3. Fix the issue
4. Verify the fix
5. Continue implementation

## Commit Strategy

Don't commit during implementation unless:
- Reaching a significant milestone
- User requests a checkpoint
- About to make risky changes

## Output

1. Implement the required functionality
2. Update `.claude/Tasks.md` with progress
3. Report summary of changes made
4. List any issues encountered

Now begin implementation based on the requirements and design.
