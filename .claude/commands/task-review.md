# Task Review - Review a Pull Request

You are reviewing a pull request for code quality and correctness.

## Arguments
$ARGUMENTS

The argument should be a PR URL like: `https://github.com/owner/repo/pull/123`

## Review Process

### 1. Fetch PR Information
```bash
# Get PR details
gh pr view <PR_NUMBER> --json title,body,files,additions,deletions

# Get changed files
gh pr diff <PR_NUMBER>
```

### 2. Understand Context
- Read PR title and description
- Understand the purpose of changes
- Check linked issues/tasks

### 3. Review Code Changes

For each changed file:
1. Read the diff
2. Understand what changed
3. Evaluate against quality criteria

## Quality Review Criteria

### Code Quality Checklist
- [ ] **DRY Principle** - No unnecessary duplication
- [ ] **Clean Code** - Readable and well-structured
- [ ] **Naming Conventions** - Clear, consistent names
- [ ] **Data Validation** - Proper input validation
- [ ] **Professional Code** - Production-ready
- [ ] **Single Responsibility** - Focused functions/classes
- [ ] **Type Safety** - Proper typing, no unsafe `any`
- [ ] **Reusability** - Appropriately reusable
- [ ] **Maintainability** - Easy to maintain
- [ ] **Consistent Error Handling** - Uniform error patterns

### Security Checks
- [ ] No hardcoded secrets/credentials
- [ ] No SQL injection vulnerabilities
- [ ] No XSS vulnerabilities
- [ ] Input sanitization where needed
- [ ] Proper authentication/authorization

### Best Practices
- [ ] No console.log in production code
- [ ] No commented-out code
- [ ] No TODO comments that should be addressed
- [ ] Appropriate error messages
- [ ] No magic numbers/strings

## Review Output Format

### Summary
```markdown
## PR Review: [PR Title]

### Overview
[Brief summary of what this PR does]

### Approval Status
- [ ] Approved
- [ ] Approved with suggestions
- [ ] Changes requested

### Strengths
- [Good things about this PR]

### Issues Found

#### Critical (Must Fix)
1. **[Issue Title]** - `file.ts:line`
   - Problem: [Description]
   - Suggestion: [How to fix]

#### Suggestions (Nice to Have)
1. **[Suggestion Title]** - `file.ts:line`
   - Current: [What it is now]
   - Suggested: [What it could be]

### Code Quality Score
| Criteria | Score (1-5) | Notes |
|----------|-------------|-------|
| DRY | | |
| Clean Code | | |
| Naming | | |
| Type Safety | | |
| Error Handling | | |
| Overall | | |
```

## Commenting on PR

To leave review comments:
```bash
# Overall review comment
gh pr review <PR_NUMBER> --comment --body "Review comments here"

# Request changes
gh pr review <PR_NUMBER> --request-changes --body "Changes needed"

# Approve
gh pr review <PR_NUMBER> --approve --body "LGTM!"
```

## Review Depth Levels

### Quick Review
- Skim through changes
- Check for obvious issues
- ~5-10 minutes

### Standard Review
- Read all changes carefully
- Check against quality criteria
- Verify logic correctness
- ~15-30 minutes

### Deep Review
- Trace all code paths
- Check edge cases
- Verify security implications
- Run code locally if needed
- ~30-60 minutes

## Output

1. Generate review summary document
2. Optionally post review comments to PR
3. Save review to `.claude/reviews/pr-<number>-review.md`

Now fetch the PR and begin the review.
