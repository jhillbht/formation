# Scripts Directory

This directory contains helper scripts for managing git worktrees with Claude Code integration.

## 🌳 Git Worktree Scripts

### `worktree-create.sh`
Creates a new git worktree with proper Claude Code context.

```bash
chmod +x scripts/worktree-create.sh
./scripts/worktree-create.sh experiment/langchain-integration
./scripts/worktree-create.sh feature/advanced-prompting
./scripts/worktree-create.sh comparison/claude-vs-gpt4
```

**What it does:**
- Creates new git branch and worktree
- Generates worktree-specific CLAUDE.md context
- Sets up quick start script for the worktree
- Provides next-step instructions

### `worktree-code.sh`
Launches Claude Code in a specific git worktree.

```bash
chmod +x scripts/worktree-code.sh
./scripts/worktree-code.sh experiment/langchain-integration
```

**What it does:**
- Validates worktree exists
- Checks for uncommitted changes
- Shows git context and branch info
- Launches Claude Code with proper context

### `worktree-cleanup.sh`
Safely removes completed git worktrees.

```bash
chmod +x scripts/worktree-cleanup.sh
./scripts/worktree-cleanup.sh experiment/langchain-integration
```

**What it does:**
- Checks for uncommitted changes
- Offers to merge or stash changes
- Safely removes worktree and branch
- Cleans up directories

## 🚀 Quick Setup

Make all scripts executable:
```bash
chmod +x scripts/*.sh
```

## 📋 Worktree Naming Conventions

- **Experiments**: `experiment/feature-name`
- **Features**: `feature/feature-name`  
- **Comparisons**: `comparison/what-vs-what`
- **Performance**: `performance/optimization-type`
- **Models**: `models/model-name`

## 🎯 Common Workflows

### AI Model Comparison
```bash
./scripts/worktree-create.sh comparison/claude-vs-gpt4
./scripts/worktree-code.sh comparison/claude-vs-gpt4
# ... do comparison work ...
./scripts/worktree-cleanup.sh comparison/claude-vs-gpt4
```

### Parallel Development
```bash
# Terminal 1
./scripts/worktree-create.sh feature/vector-search
./scripts/worktree-code.sh feature/vector-search

# Terminal 2  
./scripts/worktree-create.sh feature/conversation-memory
./scripts/worktree-code.sh feature/conversation-memory
```

### Experimental Libraries
```bash
./scripts/worktree-create.sh experiment/langchain-integration
./scripts/worktree-code.sh experiment/langchain-integration
# Safe isolated environment for testing new dependencies
```

---

*These scripts implement the [Anthropic git worktrees tutorial](https://docs.anthropic.com/en/docs/claude-code/tutorials#run-parallel-claude-code-sessions-with-git-worktrees) as a standard development process.*
