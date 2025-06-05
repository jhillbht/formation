# 🤖 Custom Claude Code Slash Commands for Newsense AI Projects

This project includes **custom slash commands** that integrate with the organized AI development workflow and naming conventions.

## 📋 Available Commands

### 🔧 **Setup & Configuration**
- `/setup-mcp` - Configure remote MCP servers for this project
- `/install-deps` - Install project dependencies intelligently
- `/sync-believe` - Sync believe configurations from templates

### 🧠 **Codebase Understanding**
- `/understand` - Analyze and explain the current codebase structure
- `/context-map` - Generate a context map of key files and relationships
- `/ai-overview` - Get an AI-focused overview of model integrations

### 🔄 **Refactoring & Code Quality**
- `/refactor` - Intelligent refactoring suggestions and execution
- `/code-review` - Comprehensive code review with AI best practices
- `/optimize` - Performance and efficiency optimization suggestions

### 📝 **Context & Planning**
- `/compact` - Auto-compact context window (early compression)
- `/planning` - Enter planning mode (no codebase changes)
- `/roadmap` - Generate development roadmap based on current state

### 🐛 **Debugging & Quality**
- `/bug-hunt` - Systematic bug detection and analysis
- `/test-suggest` - Suggest comprehensive test coverage
- `/lint-ai` - AI-specific linting and best practices check

### 💾 **Version Control & Checkpoints**
- `/checkpoint` - Create workflow checkpoint for safe experimentation
- `/revert-files` - Quick file reversion to previous versions
- `/stash-work` - Intelligent work stashing with context preservation

### 🌳 **Worktree Integration**
- `/worktree-status` - Show all worktrees and their status
- `/worktree-sync` - Sync changes between worktrees safely
- `/merge-experiment` - Merge experimental work from worktrees

## 🚀 Quick Start

### Enable Commands
All commands are automatically available in any Newsense AI project. Just start typing `/` in Claude Code to see available options.

### Example Usage
```
/understand
# Analyzes your newsense project structure and AI integrations

/setup-mcp --provider anthropic --endpoint https://api.anthropic.com
# Configures remote MCP server for Claude integration

/checkpoint "before-major-refactor"
# Creates a safe restore point before making large changes

/refactor src/llm/claude_client.py --pattern "extract-interface"
# Suggests interface extraction for better modularity

/compact --strategy preserve-ai-context
# Compresses context while preserving AI development context
```

## 📁 Command Implementation

Commands are implemented as shell scripts in the `.claude/commands/` directory:

```
.claude/
├── commands/
│   ├── setup-mcp.sh
│   ├── install-deps.sh
│   ├── understand.sh
│   ├── refactor.sh
│   ├── compact.sh
│   ├── planning.sh
│   ├── bug-hunt.sh
│   ├── checkpoint.sh
│   ├── revert-files.sh
│   └── [other commands]
├── config/
│   ├── mcp-servers.yaml
│   ├── refactor-patterns.yaml
│   └── planning-templates.yaml
└── claude-commands.json
```

## 🎯 Integration with Organized AI

These commands are designed specifically for the organized AI environment:

- **Understand believe/ configurations** automatically
- **Work with newsense project structure** intelligently  
- **Integrate with supabowl workspace** conventions
- **Support jordaaan customizations** and extensions
- **Leverage organized-ai patterns** and best practices

## 🔧 Customization

### Adding Custom Commands
Create new commands in `.claude/commands/`:

```bash
#!/usr/bin/env bash
# .claude/commands/my-custom-command.sh

echo "🤖 Custom command for organized AI development"
# Your custom logic here
```

### Extending Existing Commands
Commands respect jordaaan customizations via:
- `~/.jordaaan-commands/` - Personal command extensions
- `.claude/config/local/` - Project-specific customizations
- Environment variables for configuration

---

*These custom slash commands transform Claude Code into a specialized AI development assistant that understands your organized codebase structure and conventions.*
