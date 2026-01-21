# Task Test Run - Execute Tests

You are running tests and fixing any failures.

## Arguments
$ARGUMENTS

## Current Context

1. Read `.claude/Tasks.md` to identify the current active task
2. Detect testing framework in use
3. Run tests and analyze results

## Framework Detection

Check for testing framework:
```bash
# Node.js projects
cat package.json | grep -E "(jest|vitest|mocha|ava)"

# Python projects
ls pytest.ini pyproject.toml setup.cfg 2>/dev/null

# Go projects
ls *_test.go 2>/dev/null
```

## Test Execution

### Node.js/JavaScript
```bash
npm test
# or
npm run test
# or
npx jest
# or
npx vitest
```

### Python
```bash
pytest
# or
python -m pytest
# or
python -m unittest discover
```

### Go
```bash
go test ./...
```

## Process

### 1. Run All Tests
```
1. Execute test command
2. Capture output
3. Identify failures
```

### 2. Analyze Failures
For each failing test:
```
1. Read the test code
2. Read the implementation code
3. Understand expected vs actual
4. Determine if test or code is wrong
```

### 3. Fix Issues
```
1. If test is wrong: Fix the test
2. If code is wrong: Fix the implementation
3. Re-run to verify fix
```

### 4. Iterate
```
1. Run tests again
2. Repeat until all pass
3. Check for flaky tests
```

## Failure Analysis

### Common Failure Types

| Type | Symptom | Fix |
|------|---------|-----|
| Assertion | Expected vs actual mismatch | Fix code or update expectation |
| Timeout | Test hangs or times out | Add async handling, increase timeout |
| Import | Module not found | Fix imports, install deps |
| Mock | Mock not called/wrong args | Update mock setup |
| Type | Type mismatch | Fix types |
| Setup | Missing test data | Fix test setup |

### Debugging Steps
1. Read full error message
2. Check stack trace
3. Look at test code
4. Look at implementation
5. Add console.log if needed
6. Check test isolation

## Coverage Check

After tests pass, check coverage:
```bash
# Jest
npx jest --coverage

# Vitest
npx vitest --coverage

# pytest
pytest --cov

# Go
go test -cover ./...
```

## Output

1. Report test results summary
2. List any remaining issues
3. Update `.claude/Tasks.md` with test status
4. Note coverage percentage if available

## Success Criteria

- [ ] All tests pass
- [ ] No skipped tests (unless justified)
- [ ] Coverage meets threshold (if defined)
- [ ] No flaky tests

Now detect the testing framework and run the tests.
