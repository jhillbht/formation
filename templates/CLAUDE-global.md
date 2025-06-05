# Claude Code Context for Supabowl AI Development Environment

## 🏠 Supabowl Workspace Overview
This is a **Supabowl AI development environment** set up by the **organized-ai** formation script. This workspace is optimized for AI development with custom naming conventions and organized project structures.

## 🎯 Global Naming Conventions

### Core System Names
- **organized-ai**: Main macOS setup script (replaces Formation's `slay`)
- **believe/**: Configuration system (replaces Formation's `swag/`)
- **jordaaan**: Personal customizations (replaces Formation's `~/.hot-sauce`)
- **newsense**: AI project structure template
- **supabowl**: Development workspace environment

### Directory Structure Philosophy
```
~/supabowl-workspace/
├── newsense-projects/           # AI development projects
│   ├── personal/               # Personal AI experiments
│   ├── work/                   # Professional AI projects
│   └── experiments/            # Research and testing
├── believe-configs/             # Configuration templates and customs
│   ├── templates/              # Reusable project templates
│   └── custom/                 # Personal configuration overrides
├── models/                      # AI model storage and management
│   ├── llama/                  # Local LLaMA models
│   ├── claude/                 # Claude-specific resources
│   └── openai/                 # OpenAI-specific resources
├── datasets/                    # Data management
│   ├── training/               # Training datasets
│   ├── testing/                # Test datasets
│   └── validation/             # Validation datasets
├── experiments/                 # ML/AI experiment tracking
├── notebooks/                   # Jupyter notebook collection
│   ├── research/               # Research notebooks
│   └── tutorials/              # Learning and tutorial notebooks
├── screenshots/                 # Demo and documentation images
└── demos/                       # Project demonstrations
```

## 🛠 Technology Stack Standards

### Core Development Tools
- **Python 3.11** managed via pyenv
- **Node.js** managed via nvm
- **Docker** for containerization
- **Git** with LFS for large model files
- **Homebrew** for package management

### AI Development Stack
- **Anthropic Claude SDK** for Claude API integration
- **OpenAI Python SDK** for GPT models
- **Jupyter Notebook** for interactive development
- **Streamlit** for rapid AI app prototyping
- **FastAPI** for production AI services
- **PyTorch** for deep learning (when needed)
- **Transformers** by Hugging Face for model work

### Development Environment
- **Visual Studio Code** with AI extensions
- **Cursor** for AI-assisted coding
- **iTerm2** with enhanced terminal features
- **Docker Desktop** for containerization
- **Postman/Insomnia** for API testing

## 🎨 Global Development Guidelines

### Code Organization
- **Use newsense project structure** for all AI projects
- **Believe configurations** for all settings and parameters
- **Modular design** with clear separation of concerns
- **Environment variable management** via .env files
- **Configuration-driven development** using YAML files

### Coding Standards
- **Python**: Black formatting, isort imports, type hints, docstrings
- **JavaScript/TypeScript**: Prettier formatting, ESLint rules
- **YAML**: Consistent indentation, meaningful comments
- **Markdown**: Clear structure, proper linking

### File and Directory Naming
- **Python files**: `snake_case.py`
- **JavaScript files**: `camelCase.js` or `kebab-case.js`
- **Configuration files**: `descriptive_name.yaml`
- **Directories**: `kebab-case` or `snake_case`
- **Environment files**: `.env.environment_name`

### Git Workflow
- **Branch naming**: `feature/descriptive-name`, `fix/issue-description`
- **Commit messages**: Conventional commits format
- **Large files**: Use Git LFS for models, datasets, and binaries
- **Ignore patterns**: Comprehensive .gitignore for AI projects

## 🤖 AI Development Patterns

### Project Initialization
1. Copy from newsense template: `cp -r believe-configs/templates/newsense-template new-project`
2. Set up environment: `cp .env.example .env`
3. Install dependencies: `pip install -r requirements.txt`
4. Initialize git: `git init && git add . && git commit -m "Initial project setup"`

### Configuration Management
- **Global configs**: `~/supabowl-workspace/believe-configs/`
- **Project configs**: `project-root/believe/`
- **Personal overrides**: Via jordaaan customizations
- **Environment variables**: `.env` files with proper security

### API Client Pattern
```python
# Standard client initialization
from src.llm.claude_client import ClaudeClient
from src.utils.config import load_config

config = load_config()
client = ClaudeClient(config["models"]["claude"])
response = client.complete(prompt)
```

### Error Handling Standards
```python
# Consistent error handling across projects
try:
    result = api_operation()
    logger.info(f"Operation successful: {result}")
    return result
except APIError as e:
    logger.error(f"API error: {e}")
    raise
except Exception as e:
    logger.error(f"Unexpected error: {e}")
    raise
```

## 📁 Project Templates

### Newsense AI Project Structure
Every AI project should follow the newsense structure:
- `believe/` for configurations
- `src/` for source code with modular organization
- `data/` for data management and storage
- `examples/` for usage demonstrations
- `notebooks/` for experimental work
- `handlers/` for error management

### Configuration Templates
- **Model configs**: API settings, rate limits, retry logic
- **Prompt templates**: Reusable prompt patterns
- **Logging configs**: Consistent logging across projects
- **Environment templates**: Secure credential management

## 🔧 Common Workflows

### Starting a New AI Project
```bash
cd ~/supabowl-workspace/newsense-projects
cp -r ../believe-configs/templates/newsense-template my-new-project
cd my-new-project
cp .env.example .env
# Edit .env with your API keys
pip install -r requirements.txt
python examples/basic_completion.py
```

### Working with Models
- **Local models**: Store in `~/supabowl-workspace/models/`
- **API-based models**: Configure in `believe/model_config.yaml`
- **Caching**: Use built-in caching for API responses
- **Rate limiting**: Respect API limits with automatic throttling

### Data Management
- **Raw data**: `data/raw/` - never modify
- **Processed data**: `data/processed/` - cleaned and prepared
- **Generated outputs**: `data/outputs/` - model results
- **Cached responses**: `data/cache/` - API response caching

## 🧪 Testing and Quality Assurance

### Testing Standards
- **Unit tests**: pytest for all modules
- **Integration tests**: Full workflow testing
- **API tests**: Mock external services
- **Configuration tests**: Validate YAML and environment setup

### Code Quality
- **Linting**: flake8, pylint for Python
- **Formatting**: black, isort for Python
- **Type checking**: mypy for static type analysis
- **Documentation**: Comprehensive docstrings and README files

## 🚀 Deployment and Production

### Containerization
- **Docker**: Use provided Dockerfile templates
- **Environment**: Container-specific environment management
- **Health checks**: API and service health monitoring
- **Scaling**: Design for horizontal scaling

### Monitoring and Logging
- **Centralized logging**: Consistent log format across projects
- **API monitoring**: Track usage, errors, and performance
- **Cost tracking**: Monitor API usage and costs
- **Alerting**: Set up alerts for failures and limits

## 🔐 Security and Best Practices

### API Key Management
- **Never commit**: API keys should never be in git
- **Environment variables**: Use .env files for development
- **Production secrets**: Use proper secret management
- **Rotation**: Regular API key rotation

### Data Privacy
- **Sensitive data**: Handle according to privacy requirements
- **Cache management**: Secure caching of API responses
- **Logging**: Avoid logging sensitive information
- **Compliance**: Follow relevant data protection regulations

## 📚 Learning and Resources

### Documentation
- **Anthropic Claude**: https://docs.anthropic.com/
- **OpenAI API**: https://platform.openai.com/docs/
- **Organized AI formation**: Repository README and docs
- **Individual projects**: Project-specific CLAUDE.md files

### Development Tools
- **Claude Code**: Use this CLAUDE.md for context
- **Jupyter**: For interactive development and research
- **VS Code/Cursor**: Primary development environments
- **Docker**: For consistent deployment environments

---

*This global context helps Claude Code understand the entire Supabowl AI development environment, naming conventions, and organizational structure across all projects.*
