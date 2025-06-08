# Formation: Organized AI Development Framework

**🍋 Get in Formation for AI Development 🤖**

Formation is an organized AI development framework that sets up a comprehensive **Supabowl workspace environment** optimized for building AI applications with Claude, OpenAI, and other LLM providers. It provides structured naming conventions, automated workflows, and seamless Claude Code integration.

## 🎯 Core Philosophy

Formation replaces traditional development setup with **organized naming conventions** specifically designed for AI development:

- **organized-ai**: Main setup script (replaces "slay")
- **believe/**: Configuration system (replaces "swag/")  
- **newsense**: AI project structure template
- **jordaaan**: Personal customizations (replaces "~/.hot-sauce")
- **supabowl**: Development workspace environment

## 🏗 Supabowl Workspace Structure

Formation creates an organized workspace at `~/supabowl-workspace/` with everything you need for AI development:

```
~/supabowl-workspace/
├── newsense-projects/           # AI development projects
│   ├── personal/               # Personal AI experiments  
│   ├── work/                   # Professional AI projects
│   └── experiments/            # Research and testing
├── believe-configs/             # Configuration templates and customs
│   ├── templates/              # Reusable project templates
│   │   └── newsense-template/  # Standard AI project structure
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
│   └── tutorials/              # Learning notebooks
├── screenshots/                 # Demo and documentation images
├── demos/                       # Project demonstrations
├── CLAUDE.md                    # Global Claude Code context
└── claude-setup.sh              # Helper script for new projects
```

## 🚀 Quick Start

### 1. Install Formation Framework

```bash
# Clone the organized-codebase branch
git clone -b organized-codebase https://github.com/jhillbht/formation.git
cd formation

# Run the organized-ai setup script
./organized-ai
```

### 2. Apply Personal Customizations (Optional)

```bash
# Copy the sample jordaaan configuration
cp sample-jordaaan-config ~/.jordaaan
chmod +x ~/.jordaaan

# Run personal customizations
~/.jordaaan
```

### 3. Set Up PRD Creation (MCP Integration)

```bash
# Install PRD-MCP-Server for native PRD creation
npx -y prd-creator-mcp

# Add to your Claude Desktop config (if not already configured)
# The server will integrate with your existing MCP setup
```

### 4. Create Your First AI Project

```bash
# Use the helper script to create a new project
~/supabowl-workspace/claude-setup.sh my-ai-project

# Navigate to your project
cd ~/supabowl-workspace/newsense-projects/my-ai-project

# Set up environment and dependencies
cp .env.example .env
# Edit .env with your API keys (ANTHROPIC_API_KEY, OPENAI_API_KEY)
pip install -r requirements.txt

# Test your setup
python examples/basic_completion.py
```

## 🎨 Newsense Project Template

Every AI project follows the **newsense structure** for consistency and best practices:

```
my-ai-project/
├── believe/                     # Configuration files
│   ├── model_config.yaml      # AI model settings and API configs
│   ├── logging_config.yaml    # Logging configuration
│   └── prompt_templates.yaml  # Reusable prompt patterns
├── src/                         # Source code with modular organization
│   ├── llm/                    # LLM client implementations
│   ├── prompt_engineering/     # Prompt management and optimization
│   └── utils/                  # Shared utilities and helpers
├── data/                        # Data management and storage
│   ├── cache/                  # API response caching
│   ├── prompts/                # Prompt templates and examples
│   ├── outputs/                # Generated content and results
│   └── embeddings/             # Vector embeddings and indexes
├── handlers/                    # Error management and recovery
├── examples/                    # Usage demonstrations and tutorials
├── notebooks/                   # Experimental and research work
├── requirements.txt             # Python dependencies
├── .env.example                # Environment variables template
├── .gitignore                  # Git ignore patterns for AI projects
├── README.md                   # Project-specific documentation
├── PRD.md                      # Product Requirements Document
└── CLAUDE.md                   # Claude Code context for this project
```

## 📋 Native PRD Creation with MCP Integration

Formation includes seamless **PRD creation** using the open-source PRD-MCP-Server that integrates directly with Claude Desktop:

### PRD-MCP-Server Features
- **Native Claude Integration**: Generate PRDs directly in Claude Desktop
- **Multiple AI Providers**: OpenAI, Anthropic Claude, Google Gemini, local models
- **Template Management**: Customizable templates for different project types
- **Requirements Extraction**: Extract requirements from stakeholder feedback
- **Validation Tools**: Ensure PRD completeness and quality
- **Formation Compatible**: Works seamlessly with supabowl workspace structure

### PRD Generation Workflow
```bash
# PRDs are generated using Claude Desktop with MCP tools:
# 1. Open Claude Desktop (with PRD-MCP-Server configured)
# 2. Use generate_prd tool with Formation context
# 3. Save directly to newsense project structure
# 4. Version control with git as part of normal workflow

# Example: Generate Formation Framework PRD
# Use Claude Desktop with prompts like:
# "Generate a PRD for the Formation AI development framework using 
#  our organized naming conventions and supabowl workspace structure"
```

### Claude Desktop Configuration
```json
{
  "mcpServers": {
    "prd-creator": {
      "command": "npx",
      "args": ["-y", "prd-creator-mcp"]
    }
  }
}
```

## 🧠 Claude Code Integration

Formation includes seamless **Claude Code integration** with automated context management:

### Global Context
- **Global CLAUDE.md**: Located at `~/supabowl-workspace/CLAUDE.md`
- Contains workspace-wide context, naming conventions, and development guidelines
- Shared across all projects in your supabowl workspace

### Project-Specific Context  
- **Project CLAUDE.md**: Each newsense project gets its own context file
- Contains project-specific goals, configurations, and implementation details
- Automatically created when using `claude-setup.sh`

### Worktree-Specific Context
- **Experiment CLAUDE.md**: Each git worktree gets dedicated context
- Enables parallel development with isolated Claude environments
- Perfect for A/B testing and model comparisons

## 🌳 Git Worktrees for Parallel Claude Code Sessions

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
- **PRD Development**: Create PRDs for different approaches in parallel worktrees

### Standard Worktree Patterns

- **Model Comparison**: `comparison/claude-vs-gpt4`, `comparison/llama-vs-mistral`
- **Feature Development**: `feature/vector-search`, `feature/conversation-memory`
- **Experimental Libraries**: `experiment/langchain-integration`, `experiment/llamaindex`
- **Prompt Engineering**: `experiment/chain-of-thought`, `experiment/few-shot-learning`
- **PRD Variations**: `prd/enterprise-version`, `prd/community-edition`

## ⚙️ Believe Configuration System

The **believe configuration system** provides centralized, YAML-based configuration management:

### Model Configuration (`believe/model_config.yaml`)
```yaml
models:
  claude:
    api_key: ${ANTHROPIC_API_KEY}
    model: "claude-3-sonnet-20240229"
    max_tokens: 4096
    temperature: 0.7
  
  openai:
    api_key: ${OPENAI_API_KEY}
    model: "gpt-4"
    max_tokens: 4096
    temperature: 0.7

rate_limits:
  requests_per_minute: 60
  tokens_per_minute: 100000

cache:
  enabled: true
  ttl: 3600  # 1 hour
```

### PRD Configuration (`believe/prd_config.yaml`)
```yaml
prd:
  provider: "anthropic"  # or openai, gemini, local
  template: "formation"  # Use Formation-specific template
  validation_rules:
    - "has-introduction"
    - "minimum-length"
    - "technical-requirements"
  
formation:
  naming_conventions:
    use_organized_terms: true
    workspace: "supabowl"
    projects: "newsense"
    configs: "believe"
```

### Configuration Templates
- **Global configs**: `~/supabowl-workspace/believe-configs/templates/`
- **Project configs**: `project-root/believe/`
- **Personal overrides**: Via jordaaan customizations
- **Environment variables**: Secure `.env` file management

## 🎯 Jordaaan Personal Customizations

The **jordaaan customization system** allows for personal development preferences:

### Additional AI Packages
- **Python**: langchain, streamlit, gradio, huggingface-hub, datasets, transformers
- **Node.js**: @anthropic-ai/sdk, openai, @langchain packages
- **Development**: wandb, mlflow, tensorboard for experiment tracking

### Enhanced Development Experience
- **Nerd Fonts**: FiraCode, JetBrainsMono, Hack for better terminal experience
- **Git Integration**: Specialized aliases for AI development workflows
- **Environment Setup**: Automated PATH and PYTHONPATH configuration

### Custom Git Aliases
```bash
git ai-commit     # Specialized commits for AI work
git model-add     # Add model files with proper LFS
git data-add      # Add datasets and training data
git prd-update    # Update PRD with git tracking
```

## 🛠 Technology Stack

### Core Development Tools
- **Python 3.11** managed via pyenv
- **Node.js** managed via nvm
- **Docker** for containerization
- **Git with LFS** for large model files
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
- **Claude Desktop** with MCP server integration

### PRD Creation Tools
- **PRD-MCP-Server** for native PRD generation
- **Multiple AI Providers** for flexible PRD creation
- **Template Management** for consistent documentation
- **Validation Tools** for quality assurance

## 🎨 Development Guidelines

### Coding Standards
- **Python**: Black formatting, isort imports, type hints, comprehensive docstrings
- **JavaScript/TypeScript**: Prettier formatting, ESLint rules
- **YAML**: Consistent indentation, meaningful comments
- **Markdown**: Clear structure, proper linking
- **PRDs**: Use Formation naming conventions and newsense structure

### File Naming Conventions
- **Python files**: `snake_case.py`
- **JavaScript files**: `camelCase.js` or `kebab-case.js`
- **Configuration files**: `descriptive_name.yaml`
- **Directories**: `kebab-case` or `snake_case`
- **Environment files**: `.env.environment_name`
- **PRD files**: `PRD.md` (standard location in project root)

### Git Workflow
- **Branch naming**: `feature/descriptive-name`, `fix/issue-description`, `experiment/research-topic`
- **Commit messages**: Conventional commits format
- **Large files**: Use Git LFS for models, datasets, and binaries
- **PRD Updates**: Track PRD changes with descriptive commit messages

## 🔐 Security and Best Practices

### API Key Management
- **Never commit API keys** to version control
- **Use .env files** for development environments
- **Environment variables** for production deployments
- **Regular rotation** of API keys and secrets

### Data Privacy
- **Handle sensitive data** according to privacy requirements
- **Secure caching** of API responses
- **No sensitive logging** - avoid logging personal or confidential information
- **Compliance** with relevant data protection regulations

### PRD Security
- **Sensitive requirements**: Handle proprietary product information securely
- **Access control**: Limit PRD access based on team roles
- **Version control**: Track PRD changes without exposing sensitive data
- **Export controls**: Secure handling of PRD exports and sharing

## 📚 Usage Examples

### Basic Claude API Usage
```python
from src.llm.claude_client import ClaudeClient
from src.utils.config import load_config

# Load configuration
config = load_config()
client = ClaudeClient(config["models"]["claude"])

# Generate completion
response = client.complete(
    prompt="Explain quantum computing in simple terms",
    max_tokens=1000
)
print(response.content)
```

### Prompt Template Usage
```python
from src.prompt_engineering.template_manager import TemplateManager

# Load and use prompt templates
templates = TemplateManager()
prompt = templates.render("explain_concept", {
    "topic": "machine learning",
    "audience": "beginners",
    "length": "brief"
})

response = client.complete(prompt)
```

### Configuration Management
```python
from src.utils.config import load_config

# Load environment-specific configuration
config = load_config(environment="development")

# Access model settings
claude_config = config["models"]["claude"]
rate_limits = config["rate_limits"]
```

### PRD Generation with MCP
```python
# PRD generation happens through Claude Desktop MCP integration
# Example workflow in Claude Desktop:

# 1. Use generate_prd tool:
# generate_prd(
#   productName="Formation Framework",
#   productDescription="AI development framework with organized conventions",
#   targetAudience="AI developers and technical teams",
#   coreFeatures=["supabowl workspace", "newsense templates", "believe configs"],
#   templateName="formation",
#   providerId="anthropic"
# )

# 2. Save output to project PRD.md
# 3. Validate with validate_prd tool
# 4. Version control with git
```

## 🧪 Testing and Quality Assurance

### Testing Standards
- **Unit tests**: pytest for all modules
- **Integration tests**: Full workflow testing
- **API tests**: Mock external services
- **Configuration tests**: Validate YAML and environment setup
- **PRD tests**: Validate generated PRDs meet quality standards

### Code Quality Tools
- **Linting**: flake8, pylint for Python
- **Formatting**: black, isort for Python
- **Type checking**: mypy for static type analysis
- **Documentation**: Comprehensive docstrings and README files
- **PRD Quality**: Use validation tools to ensure PRD completeness

## 🚀 Deployment and Production

### Containerization
```dockerfile
# Standard Dockerfile pattern for newsense projects
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "src/main.py"]
```

### Environment Management
- **Development**: Local `.env` files
- **Staging**: Environment-specific configurations
- **Production**: Secure secret management systems

### PRD Deployment
- **Documentation Sync**: Keep PRDs updated with implementation
- **Stakeholder Access**: Provide appropriate access to PRD documentation
- **Version Control**: Maintain PRD history alongside code changes

## 📖 Learning Resources

### Documentation
- **Anthropic Claude**: https://docs.anthropic.com/
- **OpenAI API**: https://platform.openai.com/docs/
- **Formation Repository**: Comprehensive examples and templates
- **Claude Code Integration**: https://docs.anthropic.com/en/docs/claude-code/
- **PRD-MCP-Server**: https://github.com/Saml1211/PRD-MCP-Server

### Development Tools
- **Claude Code**: Integrated development with context-aware assistance
- **Jupyter**: Interactive development and research
- **VS Code/Cursor**: Primary development environments with AI extensions
- **PRD-MCP-Server**: Native PRD creation within development workflow

## 🤝 Contributing

Formation is designed to be extensible and customizable:

1. **Fork the repository** and create your feature branch
2. **Follow the newsense structure** for any new templates
3. **Use believe configurations** for all settings
4. **Include proper CLAUDE.md context** for Claude Code integration
5. **Add comprehensive tests** and documentation
6. **Create PRDs** for new features using the MCP integration

## 📋 PRD Creation Guidelines

### Using PRD-MCP-Server
1. **Configure MCP Server**: Ensure PRD-MCP-Server is configured in Claude Desktop
2. **Use Formation Templates**: Create PRDs using Formation-specific templates
3. **Follow Naming Conventions**: Use organized-ai, believe, newsense, supabowl terminology
4. **Version Control**: Track PRD changes with git
5. **Validate Quality**: Use validation tools to ensure PRD completeness

### PRD Best Practices
- **Technical Focus**: PRDs should address developer and technical team needs
- **Clear Requirements**: Specify technical requirements and implementation guidelines
- **Integration Context**: Include MCP and Claude Code integration details
- **Formation Alignment**: Ensure PRDs align with Formation framework philosophy

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

**Formation: Because you slay at AI development! 🍋🤖**

*Get in formation and build the future with organized, efficient AI development workflows and native PRD creation.*