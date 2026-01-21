#!/bin/bash

# Export Claude Code Task Workflow to a portable archive
#
# Creates a .tar.gz that can be shared and installed anywhere

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXPORT_NAME="claude-task-workflow"
EXPORT_DIR="/tmp/$EXPORT_NAME"
OUTPUT_FILE="${1:-$HOME/Downloads/$EXPORT_NAME.tar.gz}"

echo "Exporting Claude Code Task Workflow..."

# Clean up any previous export
rm -rf "$EXPORT_DIR"
mkdir -p "$EXPORT_DIR"

# Copy files
mkdir -p "$EXPORT_DIR/commands"
mkdir -p "$EXPORT_DIR/scripts"

cp "$SCRIPT_DIR/commands/"*.md "$EXPORT_DIR/commands/"
cp "$SCRIPT_DIR/scripts/"*.js "$EXPORT_DIR/scripts/" 2>/dev/null || true
cp "$SCRIPT_DIR/scripts/"*.sh "$EXPORT_DIR/scripts/" 2>/dev/null || true
cp "$SCRIPT_DIR/scripts/package.json" "$EXPORT_DIR/scripts/" 2>/dev/null || true
cp "$SCRIPT_DIR/WORKFLOW_README.md" "$EXPORT_DIR/"
cp "$SCRIPT_DIR/install.sh" "$EXPORT_DIR/"

# Create archive
tar -czf "$OUTPUT_FILE" -C /tmp "$EXPORT_NAME"

# Clean up
rm -rf "$EXPORT_DIR"

echo ""
echo "Exported to: $OUTPUT_FILE"
echo ""
echo "To install on another machine:"
echo "  1. Copy $OUTPUT_FILE to target machine"
echo "  2. Extract: tar -xzf $EXPORT_NAME.tar.gz"
echo "  3. Run: cd $EXPORT_NAME && ./install.sh /path/to/project"
echo ""
echo "Or share via GitHub and install with:"
echo "  curl -fsSL https://raw.githubusercontent.com/<repo>/main/.claude/install.sh | bash"
