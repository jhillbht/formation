# 🤖 Organized-AI: Supabowl AI Development Formation

> A customized macOS setup script for AI development, based on [Mina Markham's Formation](https://github.com/minamarkham/formation) with personalized naming conventions and AI-specific configurations.

**Organized-AI** is a shell script to set up a macOS laptop for AI development and general productivity. It can be run multiple times on the same machine safely. It installs, upgrades, or skips packages based on what is already installed on the machine.

## 🎯 What Makes This Different

This is a **customized fork** of Formation that introduces:

- **🤖 AI-First Configuration**: Optimized for machine learning and AI development
- **📁 Newsense Project Structure**: Organized directory structure for AI projects  
- **⚙️ Believe Configuration System**: Custom config management (renamed from `swag`)
- **🎨 Jordaaan Personalizations**: Custom user configurations (renamed from `hot-sauce`)
- **🏠 Supabowl Workspace**: Dedicated development environment setup
- **🐍 Python AI Stack**: Pre-configured with Claude, OpenAI, Jupyter, PyTorch, and more

## 🚀 Quick Start

### ⚠️ Important Warning
**I advise against running this script unless you understand what it's doing to your computer.** This is customized based on specific AI development preferences; your mileage may vary.

### Download the script:
```bash
git clone https://github.com/jhillbht/formation.git
cd formation
git checkout organized-codebase
```

### Review the script (please don't run scripts you don't understand):
```bash
less organized-ai
```

### Run Organized-AI:
```bash
chmod +x organized-ai
./organized-ai 2>&1 | tee ~/organized-ai.log
```

### Follow the prompts and you'll be fine! 👌

Once the script is done, quit and relaunch Terminal.

It is highly recommended to run the script regularly to keep your computer up to date.

Your last Organized-AI run will be saved to `~/organized-ai.log`. To review it, run `less ~/organized-ai.log`.

**That's it!** ✨

## 📁 Directory Structure Created

The script creates a comprehensive AI development workspace:

```
~/supabowl-workspace/
├── newsense-projects/           # Your AI projects
│   ├── personal/
│   ├── work/
│   └── experiments/
├── believe-configs/             # Configuration templates
│   ├── templates/
│   └── custom/
├── models/                      # AI model storage
│   ├── llama/
│   ├── claude/
│   └── openai/
├── datasets/                    # Training and test data
│   ├── training/
│   ├── testing/
│   └── validation/
├── experiments/                 # ML experiments
├── notebooks/                   # Jupyter notebooks
│   ├── research/
│   └── tutorials/
├── screenshots/                 # Demo screenshots
└── demos/                       # Project demonstrations
```

## 🛠 What Gets Installed

### 📦 Core Development Tools
- **XCode Command Line Tools** for developer essentials
- **Homebrew** for managing operating system libraries
- **Python 3.11** via pyenv for AI development
- **Node.js** via NVM for web development
- **Docker** for containerization
- **Git LFS** for large model files

### 🧠 AI Development Stack
- **Anthropic Claude SDK** for Claude API integration
- **OpenAI Python SDK** for GPT models
- **Jupyter Notebook** for interactive development
- **PyTorch** for deep learning
- **Transformers** by Hugging Face
- **LangChain** for LLM applications
- **Streamlit & Gradio** for AI app interfaces

### 💻 Applications (via Homebrew Cask)
- **Visual Studio Code** & **Cursor** for AI-enhanced coding
- **Docker Desktop** for containerization
- **Postman & Insomnia** for API testing
- **iTerm2** for terminal enhancement
- **Notion & Obsidian** for knowledge management
- **Rectangle & Raycast** for productivity

### 📱 Mac App Store Apps
- **Xcode** for iOS development
- **1Password** for secure credential management
- **Things 3** for task management
- **Fantastical** for calendar management

## ⚙️ Believe Configuration System

The `believe/` directory contains configuration files that determine what gets installed:

- **`believe/brews`** - Homebrew formula packages
- **`believe/casks`** - Homebrew Cask applications  
- **`believe/apps`** - Mac App Store applications
- **`believe/npm`** - Node.js packages

You can customize these files to add or remove packages according to your needs.

## 🎨 Jordaaan Personalizations

### Setting Up Your Personal Configuration

Copy the sample configuration:
```bash
cp sample-jordaaan-config ~/.jordaaan
chmod +x ~/.jordaaan
```

Your `~/.jordaaan` file can include:
- Additional AI Python packages
- Custom directory structures
- Font installations
- Git configurations
- Environment variables
- Personal aliases and shortcuts

### Example Jordaaan Configuration

The sample includes configurations for:
- **Advanced AI packages**: LangChain, Streamlit, Gradio, Weights & Biases
- **Nerd Fonts**: Better terminal and coding fonts
- **Git setup**: AI development-specific Git configurations
- **Environment variables**: Python paths and AI workspace variables
- **Newsense project templates**: Ready-to-use AI project structures

## 🏗 Newsense AI Project Structure

When you create new AI projects, use this recommended structure:

```
my-ai-project/
├── believe/                     # Configuration files
│   ├── model_config.yaml
│   ├── prompt_templates.yaml
│   └── logging_config.yaml
├── src/
│   ├── llm/                     # LLM client implementations
│   ├── prompt_engineering/      # Prompt templates and chains
│   └── utils/                   # Utilities (rate limiting, caching)
├── data/                        # Data storage
├── examples/                    # Usage examples
├── notebooks/                   # Jupyter notebooks
└── handlers/                    # Error handling
```

## 🔧 Customization

### Believe Configurations

Organized-AI functions such as `step` and `install_brews` can be used in your `~/.jordaaan`.

### Troubleshooting

**Cask does not recognize applications installed outside of Homebrew Cask** – in the case that the script fails, you can either:
1. Remove the application from the install list, or  
2. Uninstall the application causing the failure and try again.

### Understanding the Scripts

- **`organized-ai`** - Main setup script (replaces Formation's `slay`)
- **`twirl`** - Helper functions library (unchanged from Formation)
- **`believe/`** - Configuration directory (replaces Formation's `swag/`)
- **`~/.jordaaan`** - Personal customizations (replaces Formation's `~/.hot-sauce`)

## 🤝 Inspiration and Credits

This project is built upon the excellent work of:
- **[Mina Markham's Formation](https://github.com/minamarkham/formation)** - The original macOS setup script
- **[Brij Kishore Pandey's AI Project Structure](https://github.com/brijkishore)** - Generative AI project organization
- Various other macOS setup scripts and AI development best practices

## 📋 Naming Convention Reference

| Original Formation | Organized-AI | Purpose |
|-------------------|-------------|---------|
| `slay` | `organized-ai` | Main setup script |
| `~/.hot-sauce` | `~/.jordaaan` | Personal customizations |
| `swag/` | `believe/` | Configuration directory |
| Project naming | `newsense` | AI project structure |
| Environment | `supabowl` | Development workspace |

## 🚀 Getting Started with AI Development

After running Organized-AI:

1. **Restart your terminal** to load new environment variables
2. **Activate your Python environment**:
   ```bash
   cd ~/supabowl-workspace
   pyenv local 3.11.0
   ```
3. **Create your first Newsense AI project**:
   ```bash
   cp -r believe-configs/templates/newsense-template my-first-ai-project
   cd my-first-ai-project
   ```
4. **Set up your API keys**:
   ```bash
   export ANTHROPIC_API_KEY="your-key-here"
   export OPENAI_API_KEY="your-key-here"
   ```
5. **Start building!** 🎉

## 📚 Additional Resources

- **[Anthropic Claude Documentation](https://docs.anthropic.com/)**
- **[OpenAI API Documentation](https://platform.openai.com/docs/)**
- **[Jupyter Notebook Documentation](https://jupyter.org/documentation)**
- **[Docker Documentation](https://docs.docker.com/)**
- **[Python AI Development Guide](https://docs.python-guide.org/)**

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details.

---

**Happy AI Building!** 🤖✨

*Built with ❤️ for the AI development community*
