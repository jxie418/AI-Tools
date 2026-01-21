# Task Test Manual - Manual Test Plans

You are creating manual test steps and scripts for the current task.

## Arguments
$ARGUMENTS

## Current Context

1. Read `.claude/Tasks.md` to identify the current active task
2. Understand the feature/change being tested
3. Create comprehensive manual test plan

## Output Location

All manual test documentation goes to:
`.claude/test-plans/radar-<ID>-manual-tests.md`

## Test Plan Structure

```markdown
# Manual Test Plan: [Task Title]
radar://[ID]

## Overview
[Brief description of what's being tested]

## Prerequisites
- [ ] [Required setup step 1]
- [ ] [Required setup step 2]
- [ ] [Environment requirements]

## Test Environment
- OS: [Required OS]
- Browser: [If applicable]
- Dependencies: [Required services/tools]

## Test Cases

### TC-001: [Test Case Name]
**Priority:** High/Medium/Low
**Type:** Functional/UI/Integration/E2E

**Preconditions:**
- [State required before test]

**Steps:**
1. [Action 1]
2. [Action 2]
3. [Action 3]

**Expected Result:**
- [What should happen]

**Actual Result:**
- [ ] Pass
- [ ] Fail: [Reason]

---

### TC-002: [Next Test Case]
...

## Edge Cases

### EC-001: [Edge Case Name]
**Steps:**
1. [Action with edge case input]

**Expected Result:**
- [Expected behavior for edge case]

---

## Error Scenarios

### ERR-001: [Error Scenario Name]
**Steps:**
1. [Action that should trigger error]

**Expected Result:**
- [Expected error handling behavior]

---

## Regression Tests

### REG-001: [Existing Feature to Verify]
**Steps:**
1. [Verify existing functionality still works]

**Expected Result:**
- [No change in existing behavior]

---

## Test Execution Log

| TC ID | Date | Tester | Result | Notes |
|-------|------|--------|--------|-------|
| TC-001 | | | | |

## Sign-off

- [ ] All critical tests passed
- [ ] All high-priority tests passed
- [ ] Known issues documented
- [ ] Ready for release
```

## Test Categories

### Functional Tests
- Core feature functionality
- Input validation
- Output verification
- State changes

### UI Tests (if applicable)
- Visual appearance
- Responsiveness
- Accessibility
- User interactions

### Integration Tests
- API interactions
- Database operations
- External service calls
- Component communication

### End-to-End Tests
- Complete user workflows
- Cross-feature scenarios
- Production-like conditions

## Script Generation

If automated scripts are needed, create them in:
`.claude/test-plans/scripts/`

### Script Types
- Shell scripts for CLI testing
- API test scripts (curl/httpie)
- Browser automation hints
- Data setup scripts

## Process

1. Analyze the feature/change
2. Identify all testable scenarios
3. Create test plan document
4. Generate any helper scripts
5. Update `.claude/Tasks.md`

Now create the manual test plan for the current task.
