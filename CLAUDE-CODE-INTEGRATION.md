# 🤖 Claude Code Integration for Organized-AI

This document explains how **Claude Code** is integrated into the **Organized-AI** formation for optimal AI development workflows.

## 🎯 Overview

Claude Code uses **CLAUDE.md** files to provide context about your codebase, making AI assistance more accurate and project-aware. The Organized-AI formation automatically sets up Claude Code integration with:

- **Global context** for the entire Supabowl workspace
- **Project-specific context** for individual Newsense AI projects
- **Helper scripts** for easy project creation
- **Consistent naming conventions** across all contexts

## 📁 CLAUDE.md File Structure

### Global Context File
**Location**: `~/supabowl-workspace/CLAUDE.md`

Provides Claude Code with understanding of:
- Supabowl workspace organization
- Organized naming conventions (organized-ai, believe, jordaaan, newsense)
- Global development standards and patterns
- Technology stack and tool preferences
- Directory structure philosophy

### Project Context Files
**Location**: `{project-root}/CLAUDE.md`

Each Newsense AI project includes its own CLAUDE.md with:
- Project-specific structure and organization
- AI model configurations and usage patterns
- Coding standards and architectural patterns
- Common workflows and development tasks
- Testing and deployment guidelines

## 🚀 Quick Start with Claude Code

### 1. Set Up Organized-AI with Claude Integration
```bash
# Run the main setup
./organized-ai 2>&1 | tee ~/organized-ai.log

# Set up personal customizations (includes Claude Code setup)
cp sample-jordaaan-config ~/.jordaaan
chmod +x ~/.jordaaan
~/.jordaaan
```

### 2. Create a New AI Project with Claude Context
```bash
# Use the helper script for easy project creation
~/supabowl-workspace/claude-setup.sh my-new-ai-project

# Or manually copy the template
cd ~/supabowl-workspace/newsense-projects
cp -r ../believe-configs/templates/newsense-template my-new-ai-project
cd my-new-ai-project
```

### 3. Start Using Claude Code
```bash
# Navigate to your project
cd ~/supabowl-workspace/newsense-projects/my-new-ai-project

# Start Claude Code (if you have it installed)
claude-code .
```

## 🎨 Custom Context for Your Projects

### Extending Project CLAUDE.md
You can customize the CLAUDE.md file in your projects to include:

```markdown
# Additional Project Context

## Custom Requirements
- Specific AI models you're using
- Domain-specific terminology
- Custom workflows or processes
- Third-party integrations

## Project-Specific Guidelines
- Coding patterns unique to this project
- Data handling requirements
- Performance considerations
- Deployment specifics
```

### Global Context Customization
Modify `~/supabowl-workspace/CLAUDE.md` to include:
- Your organization's coding standards
- Preferred libraries and frameworks
- Custom development workflows
- Company-specific terminology

## 🛠 Advanced Configuration

### Helper Script Usage
The `claude-setup.sh` script provides an easy way to create new projects:

```bash
# Create a new project with full Claude Code context
~/supabowl-workspace/claude-setup.sh project-name

# What it does:
# 1. Creates project directory
# 2. Copies newsense template (including CLAUDE.md)
# 3. Initializes git repository
# 4. Sets up basic project structure
```

### Updating Context Files
When you evolve your development practices:

1. **Update templates**:
   ```bash
   # Edit the template
   code ~/supabowl-workspace/believe-configs/templates/newsense-template/CLAUDE.md
   ```

2. **Propagate to existing projects**:
   ```bash
   # Copy updated template to existing projects
   cp ~/supabowl-workspace/believe-configs/templates/newsense-template/CLAUDE.md \
      ~/supabowl-workspace/newsense-projects/existing-project/
   ```

### Integration with Development Tools

#### VS Code/Cursor Integration
The CLAUDE.md files work seamlessly with:
- **Cursor IDE**: Built-in Claude integration
- **VS Code**: With Claude or AI coding extensions
- **Command line**: Direct Claude Code usage

#### Git Integration
CLAUDE.md files are version controlled:
```bash
# Track changes to your context
git add CLAUDE.md
git commit -m "Update project context for new AI features"
```

## 📋 Best Practices

### Context File Maintenance
1. **Keep context current**: Update CLAUDE.md when project structure changes
2. **Be specific**: Include project-specific patterns and conventions
3. **Document decisions**: Explain why certain patterns are used
4. **Version control**: Track changes to context files

### Writing Effective Context
```markdown
# Good Context Examples

## Architecture Decision
We use the Claude client for all LLM interactions because:
- Better structured output handling
- More reliable rate limiting
- Consistent error handling patterns

## Specific Patterns
When creating new LLM clients:
1. Inherit from src/llm/base.py
2. Add configuration to believe/model_config.yaml
3. Include rate limiting and error handling
4. Write comprehensive tests
```

### Context Organization
- **Global**: Workspace-wide standards and conventions
- **Project**: Specific to the current AI project
- **Feature**: For complex features, consider inline documentation

## 🔧 Troubleshooting

### Context Not Loading
1. **Check file location**: Ensure CLAUDE.md is in the correct directory
2. **Verify permissions**: Make sure files are readable
3. **Validate format**: Ensure proper Markdown formatting

### Updating Context Templates
```bash
# Re-run jordaaan setup to update templates
~/.jordaaan

# Or manually update from the formation repo
cd ~/formation
git pull origin organized-codebase
cp templates/CLAUDE-global.md ~/supabowl-workspace/CLAUDE.md
```

### Context File Conflicts
If you have multiple CLAUDE.md files:
1. **Project-specific** takes precedence over global
2. **Most specific** context is used first
3. **Combine contexts** for comprehensive understanding

## 📚 Example Workflows

### Daily Development
```bash
# Start working on a project
cd ~/supabowl-workspace/newsense-projects/my-project

# Claude Code automatically uses CLAUDE.md context
# Ask Claude to help with development tasks
```

### Adding New Features
```bash
# Update context for new feature
echo "## New Feature: GPT-4 Integration" >> CLAUDE.md
echo "This project now uses GPT-4 for advanced reasoning tasks." >> CLAUDE.md

# Commit the context update
git add CLAUDE.md
git commit -m "Add GPT-4 integration context"
```

### Project Review
```bash
# Review all CLAUDE.md files for consistency
find ~/supabowl-workspace -name "CLAUDE.md" -exec echo "=== {} ===" \; -exec cat {} \;
```

## 🎯 Benefits of This Integration

### For Claude Code Users
- **Instant context**: Claude understands your project immediately
- **Consistent patterns**: Follows established conventions
- **Efficient development**: Reduced need to explain project structure
- **Better suggestions**: More relevant code and architecture advice

### For Teams
- **Shared understanding**: Consistent context across team members
- **Onboarding**: New team members get instant project context
- **Documentation**: Living documentation that stays current
- **Standards enforcement**: Automated adherence to coding standards

### For AI Development
- **Domain awareness**: Claude understands AI development patterns
- **Tool integration**: Knows about your specific AI stack
- **Best practices**: Follows AI development best practices
- **Rapid prototyping**: Quick setup for new AI experiments

---

**Ready to supercharge your AI development with Claude Code!** 🤖✨

*This integration makes Claude Code aware of your organized AI development environment, leading to more accurate assistance and faster development cycles.*
