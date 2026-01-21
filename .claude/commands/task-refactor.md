# Task Refactor

You are refactoring existing code to improve quality, maintainability, and adherence to best practices.

## Arguments
$ARGUMENTS

## Current Context

1. Read `.claude/Tasks.md` to identify the current active task
2. Identify files/code to be refactored from arguments or task context

## Refactoring Objectives

### Code Quality Improvements

#### DRY (Don't Repeat Yourself)
- Identify duplicated code patterns
- Extract common logic into shared functions
- Create utility modules for reusable code

#### Clean Code
- Simplify complex functions
- Reduce nesting depth
- Improve code readability
- Remove dead code

#### Naming
- Rename unclear variables/functions
- Use consistent naming patterns
- Make names self-documenting

#### Single Responsibility
- Split large functions into smaller ones
- Separate concerns into different modules
- Ensure each component has one purpose

#### Type Safety
- Add missing type annotations
- Replace `any` with specific types
- Create interfaces for data structures

#### Error Handling
- Standardize error handling patterns
- Improve error messages
- Add missing error cases

## Refactoring Process

### 1. Analysis Phase
```
1. Read target code thoroughly
2. Identify code smells and issues
3. List specific improvements needed
4. Create refactoring plan
```

### 2. Refactoring Phase
```
1. Make one type of change at a time
2. Preserve existing behavior (no feature changes)
3. Keep changes small and reviewable
4. Test after each significant change
```

### 3. Verification Phase
```
1. Ensure all tests still pass
2. Verify no functionality was broken
3. Review against quality checklist
```

## Code Smells to Address

- [ ] Long methods (>30 lines)
- [ ] Deep nesting (>3 levels)
- [ ] Duplicate code
- [ ] Magic numbers/strings
- [ ] God classes/modules
- [ ] Feature envy
- [ ] Primitive obsession
- [ ] Long parameter lists
- [ ] Inconsistent naming
- [ ] Missing error handling

## Quality Checklist

After refactoring, verify:
- [ ] All tests pass
- [ ] No functionality changed
- [ ] Code is more readable
- [ ] DRY principle followed
- [ ] Naming is clear
- [ ] Error handling is consistent
- [ ] Type safety improved
- [ ] No new bugs introduced

## Output

Update `.claude/Tasks.md` when complete.

Document significant refactoring decisions in commit message.

Now analyze the code and begin refactoring.
