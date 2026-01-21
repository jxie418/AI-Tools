# Task Requirements - Deep Requirements Gathering

You are conducting comprehensive requirements gathering BEFORE implementation begins.

## Arguments
$ARGUMENTS

## Purpose

Ask ALL necessary questions upfront so that implementation can proceed without interruption. The goal is to gather enough information that Claude Code doesn't need to ask ANY questions during implementation.

## Current Context

1. Read `.claude/Tasks.md` to identify the current active task
2. Understand the high-level task description
3. Explore the codebase to understand existing patterns

## Requirements Categories

### 1. Functional Requirements
- What exactly should this feature/fix do?
- What is the expected input?
- What is the expected output?
- What are all the use cases?
- What are the edge cases?
- What should happen on errors?

### 2. Technical Requirements
- Which files/modules will be affected?
- What existing patterns should be followed?
- Are there dependencies to consider?
- What's the preferred technology/library?
- Are there performance requirements?
- Are there security considerations?

### 3. Integration Requirements
- How does this integrate with existing code?
- Are there API contracts to follow?
- Are there database changes needed?
- Are there configuration changes needed?

### 4. Testing Requirements
- What test coverage is expected?
- Are there specific test cases to include?
- Is manual testing needed?
- Are there E2E test requirements?

### 5. Quality Requirements
- Code style preferences?
- Documentation requirements?
- Error handling patterns to follow?
- Logging requirements?

## Question Template

Ask questions in this format:

```markdown
## Requirements Gathering: [Task Title]

I'll ask comprehensive questions to ensure smooth implementation.

### Functional Requirements

1. **Core Functionality**
   - [Specific question about what it should do]
   - [Question about inputs]
   - [Question about outputs]

2. **Edge Cases**
   - [Question about empty/null inputs]
   - [Question about invalid inputs]
   - [Question about boundary conditions]

3. **Error Handling**
   - [Question about failure scenarios]
   - [Question about error messages]

### Technical Requirements

4. **Architecture**
   - [Question about file structure]
   - [Question about module organization]

5. **Dependencies**
   - [Question about libraries to use]
   - [Question about existing utilities]

6. **Patterns**
   - [Question about coding patterns]
   - [Question about existing conventions]

### Integration

7. **APIs**
   - [Question about API design]
   - [Question about data formats]

8. **Data**
   - [Question about data models]
   - [Question about storage]

### Testing

9. **Test Coverage**
   - [Question about required tests]
   - [Question about test scenarios]

### Additional

10. **Constraints**
    - [Question about limitations]
    - [Question about deadlines]
    - [Question about priorities]
```

## Codebase Exploration

Before asking questions, explore:
```
1. Read related existing code
2. Understand current patterns
3. Identify relevant utilities
4. Check for similar implementations
```

This helps ask more informed, specific questions.

## Output

### Requirements Document
Save gathered requirements to:
`.claude/designs/radar-<ID>-requirements.md`

Format:
```markdown
# Requirements: [Task Title]
radar://[ID]

## Summary
[Brief description]

## Functional Requirements
- [Requirement 1]
- [Requirement 2]

## Technical Requirements
- [Requirement 1]
- [Requirement 2]

## Constraints
- [Constraint 1]

## Decisions Made
- [Decision 1]: [Rationale]

## Open Questions
- (none - all resolved)
```

### Update Tasks.md
Mark requirements gathering as complete.

## Mode: Batch vs Interactive

- **Interactive (default)**: Ask questions and wait for answers
- **Batch (--batch)**: Make reasonable assumptions, document them, proceed

Now begin comprehensive requirements gathering for the current task.
