### Git Worktrees with Parallel Claude Code Sessions

Following the **[Anthropic tutorial](https://docs.anthropic.com/en/docs/claude-code/tutorials#run-parallel-claude-code-sessions-with-git-worktrees)**, this integration includes **git worktree support** as a standard development process for AI projects.

#### Why Git Worktrees for AI Development?
- **Parallel experiments**: Test different AI models simultaneously
- **Feature isolation**: Work on multiple features without conflicts  
- **A/B testing**: Compare different prompt engineering approaches
- **Model comparison**: Run different LLM configurations side-by-side
- **Safe experimentation**: Isolate risky changes in separate trees

#### Automated Worktree Scripts
Every Newsense AI project includes these helper scripts:

```bash
# Create new worktrees with proper Claude context
./scripts/worktree-create.sh experiment/langchain-integration
./scripts/worktree-create.sh feature/advanced-prompting
./scripts/worktree-create.sh comparison/claude-vs-gpt4

# Launch Claude Code in specific worktrees
./scripts/worktree-code.sh experiment/langchain-integration

# Clean up completed worktrees safely
./scripts/worktree-cleanup.sh experiment/langchain-integration
```

#### Worktree-Specific Context
Each worktree automatically gets its own **CLAUDE.md** file with:
- Experiment-specific context and goals
- Modified configurations for that use case
- Isolated development guidelines
- Purpose-specific Claude Code awareness

#### Standard Worktree Workflows
```bash
# AI Model Comparison Workflow
./scripts/worktree-create.sh comparison/claude-vs-gpt4
./scripts/worktree-code.sh comparison/claude-vs-gpt4
# ... do comparison work ...
./scripts/worktree-cleanup.sh comparison/claude-vs-gpt4

# Parallel Feature Development
./scripts/worktree-create.sh feature/vector-search
./scripts/worktree-create.sh feature/conversation-memory
# Work on both features simultaneously in different terminals

# Experimental AI Libraries
./scripts/worktree-create.sh experiment/langchain-integration
# Isolated environment for testing new dependencies
```

This makes parallel AI development with multiple Claude Code sessions a standard, automated workflow rather than a manual setup process.

