#!/bin/bash

# Claude Code Task Workflow Installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/<your-repo>/main/.claude/install.sh | bash
#   or
#   ./install.sh /path/to/target/project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Claude Code Task Workflow Installer${NC}"
echo "======================================"

# Determine source directory (where this script lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Determine target directory
if [ -n "$1" ]; then
    TARGET_DIR="$1"
else
    TARGET_DIR="$(pwd)"
fi

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

# Copy command files
echo -e "${GREEN}Copying task workflow commands...${NC}"
cp "$SCRIPT_DIR/commands/"*.md "$TARGET_DIR/.claude/commands/" 2>/dev/null || true

# Copy scripts
echo -e "${GREEN}Copying automation scripts...${NC}"
cp "$SCRIPT_DIR/scripts/"*.js "$TARGET_DIR/.claude/scripts/" 2>/dev/null || true
cp "$SCRIPT_DIR/scripts/"*.sh "$TARGET_DIR/.claude/scripts/" 2>/dev/null || true
cp "$SCRIPT_DIR/scripts/package.json" "$TARGET_DIR/.claude/scripts/" 2>/dev/null || true

# Copy template files
echo -e "${GREEN}Creating template files...${NC}"

# Tasks.md
cat > "$TARGET_DIR/.claude/Tasks.md" << 'EOF'
# Tasks

<!--
Task tracking file for Claude Code workflow.
Format:
- [ ] radar://ID - Task Title (main task)
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

# Copy README
cp "$SCRIPT_DIR/WORKFLOW_README.md" "$TARGET_DIR/.claude/" 2>/dev/null || true

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
echo -e "${GREEN}Quick Start:${NC}"
echo "  /task radar://123456 Your task description"
echo "  /task                 # Resume incomplete task"
echo "  /task status          # Check current status"
echo ""
echo -e "See ${YELLOW}.claude/WORKFLOW_README.md${NC} for full documentation."
