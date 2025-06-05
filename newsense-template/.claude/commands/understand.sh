#!/usr/bin/env bash

###############################################################################
# Understand Command - Analyze Newsense AI Project Structure
# Provides comprehensive understanding of the organized AI codebase
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_header() { echo -e "${CYAN}🎯 $1${NC}"; }

# Parse arguments
FOCUS="all"

while [[ $# -gt 0 ]]; do
    case $1 in
        --focus)
            FOCUS="$2"
            shift 2
            ;;
        *)
            echo "Unknown parameter: $1"
            exit 1
            ;;
    esac
done

print_header "Analyzing Newsense AI Project Structure"
print_info "Focus: $FOCUS"
echo ""

# Project identification
PROJECT_NAME=$(basename "$(pwd)")
print_info "Project: $PROJECT_NAME"

# Check if this is a Newsense AI project
if [ -f "CLAUDE.md" ] && [ -d "believe" ]; then
    print_success "✓ Confirmed Newsense AI project structure"
else
    print_warning "⚠ This may not be a standard Newsense AI project"
fi

echo ""

# Analyze project structure
if [[ "$FOCUS" == "all" || "$FOCUS" == "structure" ]]; then
    print_header "📁 Project Structure Analysis"
    
    echo "Core directories:"
    
    if [ -d "believe" ]; then
        CONFIG_COUNT=$(find believe -name "*.yaml" -o -name "*.yml" | wc -l)
        print_success "  believe/ - Configuration system ($CONFIG_COUNT config files)"
        
        if [ -f "believe/model_config.yaml" ]; then
            echo "    🤖 Model configurations found"
        fi
        if [ -f "believe/prompt_templates.yaml" ]; then
            echo "    📝 Prompt templates found"
        fi
        if [ -f "believe/logging_config.yaml" ]; then
            echo "    📊 Logging configuration found"
        fi
    else
        print_warning "  believe/ - Configuration directory missing"
    fi
    
    if [ -d "src" ]; then
        SRC_FILES=$(find src -name "*.py" | wc -l)
        print_success "  src/ - Source code ($SRC_FILES Python files)"
        
        if [ -d "src/llm" ]; then
            LLM_CLIENTS=$(find src/llm -name "*_client.py" | wc -l)
            echo "    🧠 LLM clients: $LLM_CLIENTS found"
        fi
        if [ -d "src/prompt_engineering" ]; then
            PROMPT_FILES=$(find src/prompt_engineering -name "*.py" | wc -l)
            echo "    ✍️  Prompt engineering: $PROMPT_FILES modules"
        fi
        if [ -d "src/utils" ]; then
            UTIL_FILES=$(find src/utils -name "*.py" | wc -l)
            echo "    🛠️  Utilities: $UTIL_FILES modules"
        fi
    else
        print_warning "  src/ - Source directory missing"
    fi
    
    if [ -d "data" ]; then
        DATA_DIRS=$(find data -type d | wc -l)
        print_success "  data/ - Data management ($DATA_DIRS subdirectories)"
        
        [ -d "data/cache" ] && echo "    💾 Cache directory"
        [ -d "data/prompts" ] && echo "    📝 Prompts storage"
        [ -d "data/outputs" ] && echo "    📤 Outputs directory"
        [ -d "data/embeddings" ] && echo "    🎯 Embeddings storage"
    else
        print_warning "  data/ - Data directory missing"
    fi
    
    if [ -d "examples" ]; then
        EXAMPLE_COUNT=$(find examples -name "*.py" | wc -l)
        print_success "  examples/ - Usage examples ($EXAMPLE_COUNT files)"
    fi
    
    if [ -d "notebooks" ]; then
        NOTEBOOK_COUNT=$(find notebooks -name "*.ipynb" | wc -l)
        print_success "  notebooks/ - Jupyter notebooks ($NOTEBOOK_COUNT files)"
    fi
    
    if [ -d "scripts" ]; then
        SCRIPT_COUNT=$(find scripts -name "*.sh" | wc -l)
        print_success "  scripts/ - Helper scripts ($SCRIPT_COUNT files)"
        
        [ -f "scripts/worktree-create.sh" ] && echo "    🌳 Git worktree support"
    fi
    
    echo ""
fi

# Analyze AI model integrations
if [[ "$FOCUS" == "all" || "$FOCUS" == "ai-models" ]]; then
    print_header "🤖 AI Model Integration Analysis"
    
    # Check believe configurations
    if [ -f "believe/model_config.yaml" ]; then
        echo "Model configurations:"
        
        if grep -q "claude" "believe/model_config.yaml"; then
            print_success "  🔵 Claude integration configured"
        fi
        
        if grep -q "openai" "believe/model_config.yaml"; then
            print_success "  🟢 OpenAI integration configured"
        fi
        
        if grep -q "rate_limits" "believe/model_config.yaml"; then
            echo "    ⏱️  Rate limiting configured"
        fi
        
        if grep -q "cache" "believe/model_config.yaml"; then
            echo "    💾 Response caching enabled"
        fi
    else
        print_warning "  No model configuration found"
    fi
    
    # Check LLM client implementations
    if [ -d "src/llm" ]; then
        echo ""
        echo "LLM client implementations:"
        
        if [ -f "src/llm/claude_client.py" ]; then
            print_success "  🔵 Claude client implementation"
        fi
        
        if [ -f "src/llm/gpt_client.py" ]; then
            print_success "  🟢 GPT client implementation"
        fi
        
        if [ -f "src/llm/base.py" ]; then
            echo "    🏗️  Base client abstraction"
        fi
    fi
    
    # Check examples
    if [ -d "examples" ]; then
        echo ""
        echo "AI usage examples:"
        
        [ -f "examples/basic_completion.py" ] && echo "    📝 Basic completion example"
        [ -f "examples/chat_session.py" ] && echo "    💬 Chat session example"
        [ -f "examples/chain_prompts.py" ] && echo "    🔗 Chain prompting example"
    fi
    
    echo ""
fi

# Analyze configurations
if [[ "$FOCUS" == "all" || "$FOCUS" == "configs" ]]; then
    print_header "⚙️ Configuration Analysis"
    
    # Environment configuration
    if [ -f ".env" ]; then
        print_success "Environment configuration (.env) found"
        
        if grep -q "ANTHROPIC_API_KEY" ".env"; then
            echo "    🔵 Anthropic API key configured"
        fi
        
        if grep -q "OPENAI_API_KEY" ".env"; then
            echo "    🟢 OpenAI API key configured"
        fi
    else
        if [ -f ".env.example" ]; then
            print_warning "Environment template found, but .env missing"
        else
            print_warning "No environment configuration found"
        fi
    fi
    
    # Python dependencies
    if [ -f "requirements.txt" ]; then
        DEPS_COUNT=$(wc -l < requirements.txt)
        print_success "Python dependencies (requirements.txt): $DEPS_COUNT packages"
        
        if grep -q "anthropic" "requirements.txt"; then
            echo "    🔵 Anthropic SDK"
        fi
        
        if grep -q "openai" "requirements.txt"; then
            echo "    🟢 OpenAI SDK"
        fi
        
        if grep -q "jupyter" "requirements.txt"; then
            echo "    📓 Jupyter support"
        fi
        
        if grep -q "streamlit\|fastapi" "requirements.txt"; then
            echo "    🌐 Web framework support"
        fi
    fi
    
    # Docker configuration
    if [ -f "Dockerfile" ]; then
        print_success "Docker configuration found"
    fi
    
    echo ""
fi

# Git worktree analysis
if [[ "$FOCUS" == "all" ]]; then
    print_header "🌳 Git Worktree Status"
    
    if command -v git &> /dev/null && git rev-parse --git-dir > /dev/null 2>&1; then
        WORKTREE_COUNT=$(git worktree list | wc -l)
        echo "Total worktrees: $WORKTREE_COUNT"
        
        if [ $WORKTREE_COUNT -gt 1 ]; then
            echo "Active worktrees:"
            git worktree list | while read -r line; do
                if [[ "$line" == *"$(pwd)"* ]]; then
                    echo "    🏠 $line (current)"
                else
                    echo "    🌳 $line"
                fi
            done
        else
            echo "    No additional worktrees (single development line)"
        fi
    else
        print_warning "Not in a git repository"
    fi
    
    echo ""
fi

# Development tools analysis
if [[ "$FOCUS" == "all" ]]; then
    print_header "🛠️ Development Tools"
    
    # Claude Code integration
    if [ -f ".claude/claude-commands.json" ]; then
        COMMANDS_COUNT=$(jq '.commands | length' .claude/claude-commands.json 2>/dev/null || echo "unknown")
        print_success "Claude Code custom commands: $COMMANDS_COUNT available"
    fi
    
    if [ -f "CLAUDE.md" ]; then
        print_success "Claude Code context file present"
    fi
    
    if [ -f "WORKTREES.md" ]; then
        echo "    🌳 Git worktree documentation"
    fi
    
    if [ -f "CUSTOM-COMMANDS.md" ]; then
        echo "    ⚡ Custom commands documentation"
    fi
    
    echo ""
fi

# Code quality analysis
if [[ "$FOCUS" == "all" ]]; then
    print_header "📊 Code Quality Indicators"
    
    # Check for common issues
    if [ -d "src" ]; then
        # Count Python files
        PY_FILES=$(find src -name "*.py" | wc -l)
        
        # Check for __init__.py files
        INIT_FILES=$(find src -name "__init__.py" | wc -l)
        
        # Check for docstrings
        DOCSTRING_FILES=$(find src -name "*.py" -exec grep -l '"""' {} \; | wc -l)
        
        echo "Code structure:"
        echo "    📄 Python files: $PY_FILES"
        echo "    📦 Package markers (__init__.py): $INIT_FILES"
        echo "    📝 Files with docstrings: $DOCSTRING_FILES"
        
        if [ $DOCSTRING_FILES -gt $((PY_FILES / 2)) ]; then
            print_success "    Good documentation coverage"
        else
            print_warning "    Consider adding more docstrings"
        fi
    fi
    
    echo ""
fi

# Summary and recommendations
print_header "🎯 Summary & Recommendations"

echo "Project Health Score:"

SCORE=0
MAX_SCORE=10

# Core structure
[ -d "believe" ] && [ -d "src" ] && SCORE=$((SCORE + 2))

# AI integrations
[ -f "believe/model_config.yaml" ] && SCORE=$((SCORE + 2))

# Examples and documentation
[ -d "examples" ] && [ -f "CLAUDE.md" ] && SCORE=$((SCORE + 2))

# Environment setup
[ -f ".env" ] || [ -f ".env.example" ] && SCORE=$((SCORE + 1))

# Development tools
[ -f ".claude/claude-commands.json" ] && SCORE=$((SCORE + 1))

# Git worktree support
[ -f "scripts/worktree-create.sh" ] && SCORE=$((SCORE + 1))

# Dependencies
[ -f "requirements.txt" ] && SCORE=$((SCORE + 1))

echo "    Score: $SCORE/$MAX_SCORE"

if [ $SCORE -ge 8 ]; then
    print_success "    Excellent Newsense AI project setup!"
elif [ $SCORE -ge 6 ]; then
    print_success "    Good project structure with minor improvements needed"
elif [ $SCORE -ge 4 ]; then
    print_warning "    Basic structure present, consider enhancements"
else
    print_warning "    Project needs significant setup improvements"
fi

echo ""
echo "Quick commands to try:"
echo "    /setup-mcp --provider anthropic    # Configure MCP servers"
echo "    /install-deps --type all           # Install dependencies"
echo "    /ai-overview --detail comprehensive # Detailed AI analysis"
echo "    /checkpoint \"analysis-complete\"     # Create development checkpoint"
