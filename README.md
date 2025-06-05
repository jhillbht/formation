### 🌳 Git Worktrees for Parallel Claude Code Sessions

Following **[Anthropic's recommended workflow](https://docs.anthropic.com/en/docs/claude-code/tutorials#run-parallel-claude-code-sessions-with-git-worktrees)**, every Newsense AI project includes **automated git worktree support**:

```bash
# Create parallel development environments
./scripts/worktree-create.sh experiment/langchain-integration
./scripts/worktree-create.sh feature/advanced-prompting
./scripts/worktree-create.sh comparison/claude-vs-gpt4

# Launch Claude Code in specific worktrees  
./scripts/worktree-code.sh experiment/langchain-integration

# Clean up completed work
./scripts/worktree-cleanup.sh experiment/langchain-integration
```

**Benefits for AI Development:**
- **Parallel experiments**: Test different AI models simultaneously
- **Feature isolation**: Work on multiple features without conflicts
- **A/B testing**: Compare prompt engineering approaches
- **Safe experimentation**: Isolated environments with dedicated Claude contexts

