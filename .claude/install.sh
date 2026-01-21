#!/bin/bash

# Claude Code Task Workflow Installer
#
# Usage:
#   ./install.sh /path/to/target/project [--prefix jira]
#   ./install.sh /path/to/target/project --prefix ticket
#   curl -fsSL https://raw.githubusercontent.com/<your-repo>/main/.claude/install.sh | bash -s -- --prefix jira

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default task prefix
TASK_PREFIX="radar"

# Parse arguments
TARGET_DIR=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --prefix|-p)
            TASK_PREFIX="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: ./install.sh [target_directory] [--prefix PREFIX]"
            echo ""
            echo "Options:"
            echo "  --prefix, -p    Task ID prefix (default: radar)"
            echo "                  Examples: jira, ticket, issue, task, bug"
            echo ""
            echo "Examples:"
            echo "  ./install.sh /path/to/project"
            echo "  ./install.sh /path/to/project --prefix jira"
            echo "  ./install.sh . --prefix ticket"
            exit 0
            ;;
        *)
            if [ -z "$TARGET_DIR" ]; then
                TARGET_DIR="$1"
            fi
            shift
            ;;
    esac
done

# Default target directory to current if not specified
if [ -z "$TARGET_DIR" ]; then
    TARGET_DIR="$(pwd)"
fi

echo -e "${GREEN}Claude Code Task Workflow Installer${NC}"
echo "======================================"
echo -e "Task prefix: ${CYAN}${TASK_PREFIX}://${NC}"
echo ""

# Determine source directory (where this script lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if target is a git repo
if [ ! -d "$TARGET_DIR/.git" ]; then
    echo -e "${YELLOW}Warning: $TARGET_DIR is not a git repository${NC}"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create .claude directory structure
echo -e "\n${GREEN}Creating .claude directory structure...${NC}"
mkdir -p "$TARGET_DIR/.claude/commands"
mkdir -p "$TARGET_DIR/.claude/designs"
mkdir -p "$TARGET_DIR/.claude/test-plans"
mkdir -p "$TARGET_DIR/.claude/codereview"
mkdir -p "$TARGET_DIR/.claude/scripts"

# Copy and transform command files (replace radar:// with custom prefix)
echo -e "${GREEN}Copying task workflow commands (prefix: ${TASK_PREFIX}://)...${NC}"
for file in "$SCRIPT_DIR/commands/"*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        # Replace radar:// with custom prefix
        sed "s/radar:\/\//${TASK_PREFIX}:\/\//g" "$file" > "$TARGET_DIR/.claude/commands/$filename"
    fi
done

# Copy scripts
echo -e "${GREEN}Copying automation scripts...${NC}"
cp "$SCRIPT_DIR/scripts/"*.js "$TARGET_DIR/.claude/scripts/" 2>/dev/null || true
cp "$SCRIPT_DIR/scripts/"*.sh "$TARGET_DIR/.claude/scripts/" 2>/dev/null || true
cp "$SCRIPT_DIR/scripts/package.json" "$TARGET_DIR/.claude/scripts/" 2>/dev/null || true

# Copy and transform template files
echo -e "${GREEN}Creating template files...${NC}"

# Tasks.md with custom prefix
cat > "$TARGET_DIR/.claude/Tasks.md" << EOF
# Tasks

<!--
Task tracking file for Claude Code workflow.
Format:
- [ ] ${TASK_PREFIX}://ID - Task Title (main task)
  - [x] Sub-task completed
  - [ ] Sub-task pending

Mark complete with [x] or [X]
-->

## Active Tasks

<!-- Add new tasks here -->

## Completed Tasks

<!-- Move completed tasks here -->
EOF

# agent-state.md
cat > "$TARGET_DIR/.claude/agent-state.md" << 'EOF'
# Agent State

<!--
Agent coordination file for parallel task execution.
Format: agent-<name> | <task-id> | <status> | <started/completed>
-->

## Active Agents

<!-- Currently running agents -->

## Completed Agents

<!-- Finished agents with results -->

## Agent Communication

<!-- Messages between agents -->
EOF

# Copy and transform README
if [ -f "$SCRIPT_DIR/WORKFLOW_README.md" ]; then
    sed "s/radar:\/\//${TASK_PREFIX}:\/\//g" "$SCRIPT_DIR/WORKFLOW_README.md" > "$TARGET_DIR/.claude/WORKFLOW_README.md"
fi

# Save the prefix configuration
echo "$TASK_PREFIX" > "$TARGET_DIR/.claude/.task-prefix"

# Make scripts executable
chmod +x "$TARGET_DIR/.claude/scripts/"*.sh 2>/dev/null || true
chmod +x "$TARGET_DIR/.claude/scripts/"*.js 2>/dev/null || true

# Install npm dependencies if package.json exists
if [ -f "$TARGET_DIR/.claude/scripts/package.json" ]; then
    echo -e "${GREEN}Installing script dependencies...${NC}"
    cd "$TARGET_DIR/.claude/scripts"
    npm install --silent 2>/dev/null || echo -e "${YELLOW}Note: npm install skipped (run manually if needed)${NC}"
    cd - > /dev/null
fi

# Add to .gitignore if needed
if [ -f "$TARGET_DIR/.gitignore" ]; then
    if ! grep -q ".claude/codereview" "$TARGET_DIR/.gitignore"; then
        echo -e "\n# Claude Code workflow\n.claude/codereview/*.png\n.claude/scripts/node_modules/" >> "$TARGET_DIR/.gitignore"
        echo -e "${GREEN}Updated .gitignore${NC}"
    fi
fi

echo -e "\n${GREEN}Installation complete!${NC}"
echo ""
echo "Installed files:"
echo "  .claude/commands/     - Task workflow commands"
echo "  .claude/scripts/      - Automation scripts"
echo "  .claude/designs/      - Design documents"
echo "  .claude/test-plans/   - Manual test plans"
echo "  .claude/Tasks.md      - Task tracking"
echo "  .claude/agent-state.md - Agent coordination"
echo ""
echo -e "${GREEN}Task Prefix:${NC} ${CYAN}${TASK_PREFIX}://${NC}"
echo ""
echo -e "${GREEN}Quick Start:${NC}"
echo "  /task ${TASK_PREFIX}://123456 Your task description"
echo "  /task                 # Resume incomplete task"
echo "  /task status          # Check current status"
echo ""
echo -e "See ${YELLOW}.claude/WORKFLOW_README.md${NC} for full documentation."
