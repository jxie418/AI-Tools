# Task Test - Unit Tests

You are adding unit tests for new or modified code in the current task.

## Arguments
$ARGUMENTS

## Current Context

1. Read `.claude/Tasks.md` to identify the current active task
2. Identify files that were added or modified in this task
3. Determine appropriate testing framework based on project

## Test Discovery

### Find Changed Files
```bash
git diff --name-only main...HEAD
```

### Identify Testable Code
- New functions/methods
- Modified functions/methods
- New classes/modules
- API endpoints
- Utility functions

## Testing Strategy

### Unit Test Principles
1. **Isolated** - Test one unit at a time
2. **Fast** - Tests should run quickly
3. **Repeatable** - Same result every time
4. **Self-validating** - Clear pass/fail
5. **Timely** - Written close to code

### Test Coverage Goals
- All public functions/methods
- All edge cases
- Error handling paths
- Boundary conditions
- Happy path scenarios

## Test Structure

### Standard Test Format
```
describe('[Module/Function Name]', () => {
  describe('[method/scenario]', () => {
    it('should [expected behavior] when [condition]', () => {
      // Arrange
      // Act
      // Assert
    });
  });
});
```

### Test Categories
1. **Happy Path** - Normal expected behavior
2. **Edge Cases** - Boundary conditions
3. **Error Cases** - Invalid inputs, failures
4. **Integration** - Component interactions

## Implementation Process

### 1. Analysis
```
1. List all new/modified files
2. Identify functions needing tests
3. Determine test file locations
4. Plan test cases
```

### 2. Test Creation
```
1. Create/update test files
2. Write test cases for each function
3. Include positive and negative tests
4. Mock external dependencies
```

### 3. Verification
```
1. Run all tests
2. Check coverage
3. Fix any failing tests
4. Ensure no regressions
```

## Test Checklist

For each function, ensure tests cover:
- [ ] Normal input returns expected output
- [ ] Empty/null inputs handled
- [ ] Invalid inputs throw appropriate errors
- [ ] Boundary values (min, max, zero)
- [ ] Async behavior (if applicable)
- [ ] Error conditions

## Framework Detection

Detect testing framework from project:
- `jest.config.js` or `jest` in package.json → Jest
- `vitest.config.js` or `vitest` in package.json → Vitest
- `mocha` in package.json → Mocha
- `*.test.ts` or `*.spec.ts` patterns → Follow existing convention
- Python: pytest, unittest
- Go: built-in testing

## Output

1. Create test files following project conventions
2. Update `.claude/Tasks.md` marking test sub-task complete
3. Report test coverage summary

Now identify changed files and create comprehensive unit tests.
