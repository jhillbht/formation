# 🌳 Git Worktrees + Claude Code: Parallel AI Development

This template includes **git worktree support** for running parallel Claude Code sessions, enabling simultaneous work on multiple features, experiments, or AI model variations.

## 🎯 Why Git Worktrees for AI Development?

- **Parallel experiments**: Test different AI models simultaneously
- **Feature isolation**: Work on multiple features without conflicts
- **A/B testing**: Compare different prompt engineering approaches
- **Model comparison**: Run different LLM configurations side-by-side
- **Safe experimentation**: Isolate risky changes in separate trees

## 🛠 Worktree Scripts Included

### `scripts/worktree-create.sh`
Creates a new worktree with proper Claude Code context:
```bash
./scripts/worktree-create.sh feature-name
./scripts/worktree-create.sh experiment/new-model
./scripts/worktree-create.sh comparison/claude-vs-gpt
```

### `scripts/worktree-code.sh`
Starts Claude Code in a specific worktree:
```bash
./scripts/worktree-code.sh feature-name
```

### `scripts/worktree-cleanup.sh`
Safely removes completed worktrees:
```bash
./scripts/worktree-cleanup.sh feature-name
```

## 🚀 Quick Start with Parallel Development

### 1. Create Multiple Worktrees for Different Experiments
```bash
# Main development
cd ~/supabowl-workspace/newsense-projects/my-ai-project

# Create experimental worktrees
./scripts/worktree-create.sh experiment/langchain-integration
./scripts/worktree-create.sh experiment/streamlit-ui
./scripts/worktree-create.sh comparison/claude-vs-gpt4
./scripts/worktree-create.sh feature/advanced-prompting
```

### 2. Start Parallel Claude Code Sessions
```bash
# Terminal 1: Work on LangChain integration
./scripts/worktree-code.sh experiment/langchain-integration

# Terminal 2: Build Streamlit UI
./scripts/worktree-code.sh experiment/streamlit-ui

# Terminal 3: Compare AI models
./scripts/worktree-code.sh comparison/claude-vs-gpt4

# Terminal 4: Develop advanced prompting
./scripts/worktree-code.sh feature/advanced-prompting
```

### 3. Each Session Has Isolated Context
- **Separate file changes**: No conflicts between experiments
- **Independent Claude contexts**: Each worktree can have custom CLAUDE.md
- **Isolated dependencies**: Different requirements.txt if needed
- **Branch-specific configs**: Unique believe/ configurations per experiment

## 📁 Worktree Directory Structure
```
my-ai-project/                           # Main worktree
├── CLAUDE.md                           # Main project context
├── believe/                            # Main configurations
└── src/

../worktrees/
├── my-ai-project-experiment-langchain-integration/
│   ├── CLAUDE.md                       # Experiment-specific context
│   ├── believe/                        # LangChain-specific configs
│   └── src/                           # Modified for LangChain
├── my-ai-project-experiment-streamlit-ui/
│   ├── CLAUDE.md                       # UI-focused context
│   ├── believe/                        # Streamlit configurations
│   └── src/                           # UI-specific modifications
└── my-ai-project-comparison-claude-vs-gpt4/
    ├── CLAUDE.md                       # Model comparison context
    ├── believe/                        # Comparison configurations
    └── src/                           # Comparison utilities
```

## 🎯 AI Development Patterns with Worktrees

### Model Experimentation
```bash
# Compare different AI models
./scripts/worktree-create.sh models/claude-3-opus
./scripts/worktree-create.sh models/gpt-4-turbo
./scripts/worktree-create.sh models/local-llama

# Each worktree can have different model configs in believe/
```

### Prompt Engineering Variations
```bash
# Test different prompting strategies
./scripts/worktree-create.sh prompts/few-shot
./scripts/worktree-create.sh prompts/chain-of-thought
./scripts/worktree-create.sh prompts/role-based

# Isolated prompt templates and configurations
```

### Feature Development
```bash
# Parallel feature development
./scripts/worktree-create.sh features/vector-search
./scripts/worktree-create.sh features/conversation-memory
./scripts/worktree-create.sh features/tool-integration

# Independent development without conflicts
```

### Performance Testing
```bash
# Different optimization approaches
./scripts/worktree-create.sh performance/caching
./scripts/worktree-create.sh performance/streaming
./scripts/worktree-create.sh performance/batch-processing

# Isolated performance optimizations
```

## 🔧 Worktree-Specific CLAUDE.md Context

Each worktree can have customized context:

### Main Project CLAUDE.md
```markdown
# Main AI Project Context
This is the primary development branch with stable configurations.
```

### Experiment Worktree CLAUDE.md
```markdown
# LangChain Integration Experiment
This worktree is testing LangChain integration for advanced AI workflows.

## Experiment Goals
- Integrate LangChain for prompt chaining
- Test memory capabilities
- Compare performance with direct API calls

## Current Focus
Working on agent-based interactions with multiple LLM calls.
```

### Comparison Worktree CLAUDE.md  
```markdown
# Claude vs GPT-4 Comparison
This worktree contains utilities for comparing Claude and GPT-4 responses.

## Comparison Methodology
- Same prompts to both models
- Response quality analysis
- Performance benchmarking
- Cost comparison

## Current Status
Implementing automated testing framework for model comparison.
```

## 🚀 Advanced Worktree Workflows

### Merge Successful Experiments
```bash
# After successful experiment
cd my-ai-project  # main worktree
git merge experiment/langchain-integration
./scripts/worktree-cleanup.sh experiment/langchain-integration
```

### Share Configurations Between Worktrees
```bash
# Copy successful configs to main
cp ../worktrees/my-ai-project-experiment-langchain-integration/believe/model_config.yaml \
   believe/model_config_langchain.yaml
```

### Collaborative Development
```bash
# Team member works on UI while you work on backend
./scripts/worktree-create.sh features/api-improvements
# Teammate: ./scripts/worktree-create.sh features/frontend-redesign
```

## 📋 Best Practices

### Worktree Naming Conventions
- **experiments/**: `experiment/feature-name`
- **Features**: `feature/feature-name`
- **Comparisons**: `comparison/what-vs-what`
- **Performance**: `performance/optimization-type`
- **Models**: `models/model-name`

### Context Management
- **Inherit main context**: Start with main project CLAUDE.md
- **Customize for purpose**: Add experiment-specific details
- **Document goals**: Clear experiment objectives
- **Track changes**: Note modifications from main branch

### Resource Management
- **Monitor usage**: Multiple Claude Code sessions use resources
- **Close unused sessions**: Clean up completed experiments
- **Batch similar work**: Group related experiments
- **Regular cleanup**: Remove merged worktrees

### Collaboration Guidelines
- **Communicate experiments**: Share what worktrees are active
- **Coordinate merges**: Plan integration of successful experiments
- **Share learnings**: Document experiment results
- **Update templates**: Improve based on experiment outcomes

---

**Parallel AI development with git worktrees enables rapid experimentation while maintaining project stability!** 🌳🤖

*Each worktree becomes an isolated laboratory for AI experimentation with its own Claude Code context.*
