# Claude Code Context for Newsense AI Projects

## Project Overview
This is a **Newsense AI project** using the **Supabowl development environment** with **Believe configurations**. The project follows the organized AI development structure created by the `organized-ai` formation script.

## 🎯 Core Naming Conventions
- **organized-ai**: Main setup script (replaces Formation's `slay`)
- **believe/**: Configuration directory (replaces `swag/`)
- **jordaaan**: Personal customizations (replaces `hot-sauce`)
- **newsense**: AI project structure template
- **supabowl**: Development workspace environment

## 📁 Project Structure
```
project-root/
├── believe/                     # Configuration files
│   ├── model_config.yaml       # AI model settings
│   ├── prompt_templates.yaml   # Reusable prompts
│   └── logging_config.yaml     # Logging setup
├── src/
│   ├── llm/                     # LLM client implementations
│   │   ├── base.py             # Base LLM client class
│   │   ├── claude_client.py    # Claude API client
│   │   ├── gpt_client.py       # OpenAI GPT client
│   │   └── utils.py            # LLM utilities
│   ├── prompt_engineering/      # Prompt engineering tools
│   │   ├── templates.py        # Template management
│   │   ├── few_shot.py         # Few-shot learning
│   │   └── chainer.py          # Chain-of-thought prompting
│   └── utils/                   # General utilities
│       ├── rate_limiter.py     # API rate limiting
│       ├── token_counter.py    # Token counting
│       ├── cache.py            # Response caching
│       └── logger.py           # Logging utilities
├── handlers/
│   └── error_handler.py        # Error handling framework
├── data/                        # Data storage and management
├── examples/                    # Usage examples and demos
├── notebooks/                   # Jupyter notebooks for experiments
├── scripts/                     # Development helper scripts
│   ├── worktree-create.sh      # Create git worktrees for parallel development
│   ├── worktree-code.sh        # Launch Claude Code in specific worktrees
│   └── worktree-cleanup.sh     # Clean up completed worktrees
├── CLAUDE.md                   # This context file
└── WORKTREES.md                # Git worktrees documentation
```

## 🛠 Technology Stack
- **Python 3.11** with pyenv for version management
- **Anthropic Claude SDK** for Claude API integration
- **OpenAI Python SDK** for GPT models
- **Jupyter Notebook** for interactive development
- **Docker** for containerization
- **YAML** for configuration management
- **pytest** for testing
- **black + isort** for code formatting

## 🌳 Git Worktrees for Parallel Development

This project includes **git worktree support** for running parallel Claude Code sessions:

### Quick Worktree Commands
```bash
# Create experimental worktrees
./scripts/worktree-create.sh experiment/langchain-integration
./scripts/worktree-create.sh feature/advanced-prompting
./scripts/worktree-create.sh comparison/claude-vs-gpt4

# Launch Claude Code in specific worktrees
./scripts/worktree-code.sh experiment/langchain-integration
./scripts/worktree-code.sh feature/advanced-prompting

# Clean up completed worktrees
./scripts/worktree-cleanup.sh experiment/langchain-integration
```

### Worktree Benefits for AI Development
- **Parallel experiments**: Test different AI models simultaneously
- **Feature isolation**: Work on multiple features without conflicts
- **A/B testing**: Compare different prompt engineering approaches
- **Model comparison**: Run different LLM configurations side-by-side
- **Safe experimentation**: Isolate risky changes in separate trees

### Worktree Context Awareness
Each worktree gets its own **CLAUDE.md** file with context specific to that experiment or feature. This allows Claude Code to understand the purpose and focus of each parallel development session.

## 🎯 Development Guidelines

### Code Style
- Use **Black** for Python formatting with 88-character line length
- Use **isort** for import sorting
- Follow **PEP 8** naming conventions
- Use **type hints** for all function parameters and return values
- Write **docstrings** for all modules, classes, and functions

### Architecture Patterns
- **Configuration-driven development**: All settings in `believe/` YAML files
- **Modular LLM clients**: Separate clients for each AI provider
- **Error handling first**: Always implement proper error handling
- **Caching by default**: Cache API responses to reduce costs
- **Rate limiting**: Respect API limits with built-in limiters

### File Naming Conventions
- **Python files**: `snake_case.py`
- **Configuration files**: `descriptive_name.yaml`
- **Notebooks**: `descriptive_purpose.ipynb`
- **Data files**: Store in appropriate `data/` subdirectories

### Import Standards
```python
# Standard library imports
import os
import sys
from pathlib import Path

# Third-party imports
import yaml
import anthropic
import openai

# Local imports
from src.llm.claude_client import ClaudeClient
from src.utils.cache import ResponseCache
```

### Configuration Loading Pattern
```python
def load_config():
    """Load configuration from believe/model_config.yaml"""
    config_path = Path(__file__).parent.parent / "believe" / "model_config.yaml"
    with open(config_path, 'r') as f:
        return yaml.safe_load(f)
```

### Error Handling Pattern
```python
try:
    response = client.complete(prompt)
    logger.info(f"Successful completion: {len(response)} characters")
    return response
except Exception as e:
    logger.error(f"Completion failed: {e}")
    raise
```

## 🤖 AI Development Patterns

### LLM Client Usage
- Always use configuration from `believe/model_config.yaml`
- Implement retry logic with exponential backoff
- Cache responses when appropriate
- Log all API interactions for debugging

### Prompt Engineering
- Store reusable prompts in `believe/prompt_templates.yaml`
- Use the template system in `src/prompt_engineering/`
- Implement few-shot examples for complex tasks
- Version control your prompts in the `data/prompts/` directory

### Data Management
- **Raw data**: `data/raw/`
- **Processed data**: `data/processed/`
- **Cached responses**: `data/cache/`
- **Generated outputs**: `data/outputs/`
- **Vector embeddings**: `data/embeddings/`

## 🔧 Common Tasks

### Adding a New LLM Client
1. Create new client in `src/llm/new_provider_client.py`
2. Inherit from base client in `src/llm/base.py`
3. Add configuration to `believe/model_config.yaml`
4. Update examples and documentation

### Creating a New Prompt Template
1. Add template to `believe/prompt_templates.yaml`
2. Use template manager in `src/prompt_engineering/templates.py`
3. Test with examples in `examples/` directory
4. Document usage in notebooks

### Setting Up Environment
```bash
# Load environment variables
cp .env.example .env
# Edit .env with your API keys

# Install dependencies
pip install -r requirements.txt

# Run basic test
python examples/basic_completion.py
```

### Parallel Development Workflow
```bash
# Create worktree for new experiment
./scripts/worktree-create.sh experiment/my-experiment

# Start Claude Code in the worktree
./scripts/worktree-code.sh experiment/my-experiment

# When experiment is complete
./scripts/worktree-cleanup.sh experiment/my-experiment
```

## 📝 Documentation Standards
- All modules should have comprehensive docstrings
- Use **Google-style docstrings** for consistency
- Include usage examples in docstrings
- Maintain README.md files in each major directory
- Document configuration options in YAML comments

## 🧪 Testing Guidelines
- Write tests for all new functionality
- Use **pytest** as the testing framework
- Mock external API calls in tests
- Test configuration loading and validation
- Include integration tests for complete workflows

## 🚀 Deployment Considerations
- Use **Docker** for containerization
- Environment variables for configuration
- Health checks for API services
- Logging for production monitoring
- Rate limiting for API protection

## 🔍 Debugging Tips
- Check logs in the configured log directory
- Verify API keys in environment variables
- Test configuration loading independently
- Use cached responses for faster debugging
- Monitor API usage and rate limits

## 📚 Resources
- **Anthropic Claude Documentation**: https://docs.anthropic.com/
- **OpenAI API Documentation**: https://platform.openai.com/docs/
- **Git Worktrees Tutorial**: https://docs.anthropic.com/en/docs/claude-code/tutorials#run-parallel-claude-code-sessions-with-git-worktrees
- **Project Planning Document**: [Link to your planning docs]
- **Supabowl Workspace**: `~/supabowl-workspace/`

---

*This context helps Claude Code understand the organized AI development environment, support for parallel development with git worktrees, and the established patterns and conventions.*
