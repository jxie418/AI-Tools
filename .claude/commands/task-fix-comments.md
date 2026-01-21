# Task Fix Comments - Address PR Review Feedback

You are addressing code review comments on the current PR.

## Arguments
$ARGUMENTS

## Current Context

1. Read `.claude/Tasks.md` to identify the current active task and PR
2. Fetch review comments from the PR
3. Analyze and address each comment

## Fetch Review Comments

### Get PR Comments
```bash
# Get PR number from current branch
PR_NUMBER=$(gh pr view --json number -q .number)

# Get all review comments
gh api repos/{owner}/{repo}/pulls/$PR_NUMBER/comments

# Get review threads
gh pr view $PR_NUMBER --comments
```

### Alternative: Screenshots
If screenshots are available in `.claude/codereview/`:
1. Read the screenshot images
2. Extract review comments from them

## Comment Analysis Process

### 1. Categorize Comments

| Category | Action |
|----------|--------|
| Valid improvement | Implement the change |
| Incorrect suggestion | Explain why and don't change |
| Clarification needed | Ask for more details |
| Style preference | Discuss or implement |
| Bug found | Fix immediately |

### 2. For Each Comment

```
1. Read the comment carefully
2. Understand the context (file, line, surrounding code)
3. Evaluate if the suggestion is valid
4. If valid: Make the change
5. If not: Document why
```

## Implementation Guidelines

### Making Changes
- Fix ALL valid comments before committing
- Group related changes together
- Ensure fixes don't break other code
- Run tests after changes

### Quality Standards
When fixing, maintain:
- [ ] DRY Principle
- [ ] Clean Code
- [ ] Naming Conventions
- [ ] Type Safety
- [ ] Consistent Error Handling

### What NOT to Change
- Don't make changes that reduce code quality
- Don't blindly follow suggestions without understanding
- Don't change unrelated code
- Don't introduce new bugs

## Commit Process

After addressing all comments:

### 1. Stage Changes
```bash
git add .
```

### 2. Create Commit
```bash
git commit -m "Address code review feedback

- [Summary of change 1]
- [Summary of change 2]
- [Summary of change 3]

Generated with [Claude Code](https://claude.ai/code)
via [Happy](https://happy.engineering)

Co-Authored-By: Claude <noreply@anthropic.com>
Co-Authored-By: Happy <yesreply@happy.engineering>"
```

### 3. Push Changes
```bash
git push
```

### 4. Request Re-review
```bash
gh pr comment --body "@reviewer Changes have been addressed. Ready for re-review."
```

## Response Template

For each comment addressed:
```markdown
### Comment: [Original comment summary]
**File:** `path/to/file.ts:line`
**Action:** Implemented / Declined / Clarified

**Changes Made:**
- [Description of what was changed]

**Reason:**
- [Why this change was made or why suggestion was declined]
```

## Cleanup

After pushing:
```bash
# Clean up screenshots if used
rm -rf .claude/codereview/*.png
```

## Output

1. List all comments addressed
2. Note any comments declined with reasons
3. Update `.claude/Tasks.md`
4. Report push status

Now fetch the review comments and begin addressing them.
