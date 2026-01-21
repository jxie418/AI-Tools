# AI-Tools

Claude Code Task Workflow - A comprehensive automation system for software development with Claude Code CLI.

## Quick Install

### Option 1: Clone and Install (Recommended)

```bash
# Clone the repo
git clone https://github.com/jxie418/AI-Tools.git

# Install to your project
./AI-Tools/.claude/install.sh /path/to/your/project
```

### Option 2: One-Line Install from GitHub

```bash
# Install directly to current directory
curl -fsSL https://raw.githubusercontent.com/jxie418/AI-Tools/main/.claude/install.sh | bash
```

### Option 3: Manual Copy

```bash
# Copy .claude folder to your project
cp -r AI-Tools/.claude /path/to/your/project/

# Install dependencies
cd /path/to/your/project/.claude/scripts
npm install
```

## What Gets Installed

```
your-project/
└── .claude/
    ├── commands/           # Task workflow commands
    │   ├── task.md         # Main router
    │   ├── task-new.md     # Create new task
    │   ├── task-requirements.md
    │   ├── task-design.md
    │   ├── task-implement.md
    │   ├── task-test.md
    │   ├── task-create-pr.md
    │   └── ...
    ├── scripts/            # Automation scripts
    ├── designs/            # Design documents
    ├── test-plans/         # Manual test plans
    ├── Tasks.md            # Task tracking
    └── agent-state.md      # Agent coordination
```

## Usage

### Start a New Task

```bash
/task radar://123456 Add user authentication feature
```

This will:
1. Create branch `radar_123456` from main
2. Add task to `Tasks.md`
3. Start requirements gathering

### Resume Incomplete Task

```bash
/task
```

Automatically finds and resumes the first incomplete task.

### Available Commands

| Command | Description |
|---------|-------------|
| `/task` | Auto-resume incomplete task |
| `/task new radar://ID desc` | Create new task |
| `/task requirements` | Deep requirements gathering |
| `/task design` | System design with diagrams |
| `/task implement [--no-confirm]` | Code implementation |
| `/task test` | Add unit tests |
| `/task test-manual` | Manual test plans |
| `/task test-run` | Run tests & fix failures |
| `/task create-pr` | PR with quality checks |
| `/task review <URL>` | Review a PR |
| `/task fix-comments` | Fix review comments |
| `/task status` | Show current status |
| `/task complete` | Mark task done |
| `/task parallel cmd1 cmd2` | Run in parallel |

### Workflow Phases

```
/task new radar://123456 Feature description
    ↓
/task requirements    # Ask all questions upfront
    ↓
/task design          # Architecture & API contracts
    ↓
/task implement       # Write code
    ↓
/task test            # Unit tests
    ↓
/task create-pr       # Quality checks + PR
    ↓
/task fix-comments    # Address review feedback
    ↓
/task complete        # Mark done, save tokens
```

## Sharing to Another Computer

### Export Workflow

```bash
# Create portable archive
.claude/export.sh

# Output: ~/Downloads/claude-task-workflow.tar.gz
```

### Install from Archive

```bash
# On target machine
tar -xzf claude-task-workflow.tar.gz
cd claude-task-workflow
./install.sh /path/to/project
```

## Requirements

- Node.js v16+
- GitHub CLI (`gh`) installed and authenticated
- Git repository with `main` branch

## Documentation

See [.claude/WORKFLOW_README.md](.claude/WORKFLOW_README.md) for detailed documentation.

## License

MIT
