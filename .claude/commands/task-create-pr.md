# Task Create PR - Create Pull Request

You are creating a pull request with comprehensive quality checks.

## Arguments
$ARGUMENTS

## Current Context

1. Read `.claude/Tasks.md` to identify the current active task
2. Get the radar ID and task description
3. Verify all quality checks pass before PR creation

## Pre-PR Quality Checklist

Before creating PR, verify ALL of these:

### Code Quality
- [ ] **DRY Principle** - No duplicated code
- [ ] **Clean Code** - Readable, simple, well-structured
- [ ] **Naming Conventions** - Clear, consistent naming
- [ ] **Data Validation** - Inputs validated appropriately
- [ ] **Professional Code** - Production-ready quality
- [ ] **Single Responsibility** - Functions/classes have one purpose
- [ ] **Type Safety** - Proper types, no unsafe `any`
- [ ] **Reusability** - Code can be reused where appropriate
- [ ] **Maintainability** - Easy to understand and modify
- [ ] **Cleaner Routes** - API routes well-organized (if applicable)
- [ ] **Consistent Error Handling** - Errors handled uniformly

### Technical Checks
- [ ] **Lint passes** - No linting errors
- [ ] **Build passes** - Code compiles without errors
- [ ] **Tests pass** - All unit tests pass
- [ ] **No TypeScript errors** - Type checking passes
- [ ] **No security issues** - No obvious vulnerabilities

## Quality Check Execution

### 1. Run Linting
```bash
npm run lint
# or
npx eslint .
```

### 2. Run Build
```bash
npm run build
# or
npx tsc --noEmit
```

### 3. Run Tests
```bash
npm test
```

### 4. Code Review Scan
Manually review for:
- Hardcoded secrets
- Console.log statements
- TODO comments that should be addressed
- Commented-out code

## PR Creation Process

### 1. Prepare Changes
```bash
# Check status
git status

# Stage all changes
git add .

# Review what's being committed
git diff --cached
```

### 2. Create Commit
```bash
git commit -m "<task title>

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>"
```

### 3. Push Branch
```bash
git push -u origin <branch-name>
```

### 4. Create PR
```bash
gh pr create --base main --title "<task title>" --body "$(cat <<'EOF'
## Summary
[Brief description of changes]

## Changes Made
- [Change 1]
- [Change 2]
- [Change 3]

## Quality Checklist
- [x] Code follows DRY principle
- [x] Clean, readable code
- [x] Consistent naming conventions
- [x] Input validation implemented
- [x] Single responsibility principle followed
- [x] Type safety ensured
- [x] Error handling is consistent
- [x] Lint passes
- [x] Build passes
- [x] Tests pass

## Testing
- [How to test these changes]

## Screenshots (if applicable)
[Add screenshots for UI changes]

---
Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)
EOF
)"
```

## Failure Handling

### If Lint Fails
1. Run `npm run lint -- --fix` or equivalent
2. Manually fix remaining issues
3. Re-run quality checks

### If Build Fails
1. Read error messages
2. Fix type/compilation errors
3. Re-run build

### If Tests Fail
1. Use `/task test-run` to fix
2. Re-run tests until passing

## Output

1. Report PR URL when created
2. Update `.claude/Tasks.md`:
   - Mark "Create PR" sub-task as complete
   - Add PR URL to task notes
3. Start PR review monitoring (optional)

## Post-PR Actions

After PR is created:
1. Copy PR URL for sharing
2. Optionally start review monitor:
   ```bash
   node .claude/scripts/pr-review-monitor.js <PR_URL>
   ```

Now run quality checks and create the PR.
