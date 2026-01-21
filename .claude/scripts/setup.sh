#!/bin/bash

# Setup script for Claude Code workflow automation
# This installs necessary dependencies for the PR review monitoring

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up Claude Code workflow automation..."
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

echo "✓ Node.js found: $(node --version)"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed"
    exit 1
fi

echo "✓ npm found: $(npm --version)"

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed"
    echo "Please install it from https://cli.github.com/"
    exit 1
fi

echo "✓ GitHub CLI found: $(gh --version | head -n 1)"

# Install Node.js dependencies
echo ""
echo "Installing Node.js dependencies..."
cd "$SCRIPT_DIR"
npm install

echo ""
echo "Installing Playwright browsers..."
npx playwright install chromium

echo ""
echo "✓ Setup completed successfully!"
echo ""
echo "You can now use the /task command in Claude Code to start the workflow."
echo ""
