#!/usr/bin/env bash

###############################################################################
# Claude Code Worktree Launcher
# Starts Claude Code in a specific git worktree with proper context
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "Not in a git repository. Please run this from your project root."
    exit 1
fi

# Get the worktree name from argument
if [ $# -eq 0 ]; then
    print_error "Usage: $0 <worktree-name>"
    echo ""
    echo "Available worktrees:"
    git worktree list | grep -v "$(git rev-parse --show-toplevel)" | sed 's/^/  /'
    exit 1
fi

WORKTREE_NAME="$1"
PROJECT_NAME=$(basename "$(git rev-parse --show-toplevel)")
WORKTREES_DIR="../worktrees"
WORKTREE_PATH="$WORKTREES_DIR/${PROJECT_NAME}-${WORKTREE_NAME//\//-}"

# Check if worktree exists
if [ ! -d "$WORKTREE_PATH" ]; then
    print_error "Worktree not found: $WORKTREE_PATH"
    echo ""
    echo "Available worktrees:"
    git worktree list | grep -v "$(git rev-parse --show-toplevel)" | sed 's/^/  /'
    echo ""
    echo "Create a new worktree with:"
    echo "  ./scripts/worktree-create.sh $WORKTREE_NAME"
    exit 1
fi

print_info "Starting Claude Code in worktree: $WORKTREE_NAME"
print_info "Path: $WORKTREE_PATH"

# Check if Claude Code is available
if ! command -v claude-code &> /dev/null; then
    print_warning "Claude Code (claude-code) command not found."
    print_info "You can still navigate to the worktree manually:"
    echo "  cd $WORKTREE_PATH"
    echo ""
    print_info "Or if you have a different Claude Code setup, adjust this script accordingly."
    exit 1
fi

# Check if there's a CLAUDE.md file in the worktree
CLAUDE_MD="$WORKTREE_PATH/CLAUDE.md"
if [ -f "$CLAUDE_MD" ]; then
    print_success "Found worktree-specific CLAUDE.md context"
else
    print_warning "No CLAUDE.md found in worktree, will use default context"
fi

# Check for virtual environment
VENV_PATH=""
if [ -f "$WORKTREE_PATH/venv/bin/activate" ]; then
    VENV_PATH="$WORKTREE_PATH/venv/bin/activate"
    print_info "Found virtual environment in worktree"
elif [ -f "../venv/bin/activate" ]; then
    VENV_PATH="../venv/bin/activate"
    print_info "Found shared virtual environment"
fi

# Check for quick start script
QUICKSTART_SCRIPT="$WORKTREE_PATH/start-worktree.sh"
if [ -f "$QUICKSTART_SCRIPT" ]; then
    print_info "Found worktree quick start script"
    echo ""
    read -p "Run quick start script first? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Running quick start script..."
        cd "$WORKTREE_PATH"
        ./start-worktree.sh
        cd - > /dev/null
    fi
fi

# Provide environment setup information
echo ""
print_info "Environment setup for this worktree:"

if [ -n "$VENV_PATH" ]; then
    echo "  💻 Virtual environment: $VENV_PATH"
fi

if [ -f "$WORKTREE_PATH/requirements-worktree.txt" ]; then
    echo "  📦 Worktree-specific dependencies: requirements-worktree.txt"
fi

if [ -f "$WORKTREE_PATH/believe/model_config.yaml" ]; then
    echo "  ⚙️  Configuration: believe/model_config.yaml"
fi

echo ""

# Show current git information
cd "$WORKTREE_PATH"
CURRENT_BRANCH=$(git branch --show-current)
COMMIT_INFO=$(git log -1 --oneline)
print_info "Git context:"
echo "  🌳 Branch: $CURRENT_BRANCH"
echo "  📝 Latest commit: $COMMIT_INFO"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    print_warning "Uncommitted changes detected in this worktree"
fi

echo ""

# Ask user if they want to start Claude Code or just navigate
echo "Choose an action:"
echo "1. Start Claude Code in this worktree"
echo "2. Just navigate to worktree directory"
echo "3. Show worktree status and exit"
echo ""
read -p "Enter choice [1-3]: " -n 1 -r
echo

case $REPLY in
    1)
        print_info "Starting Claude Code in $WORKTREE_PATH..."
        cd "$WORKTREE_PATH"
        
        # Start Claude Code
        # Note: Adjust this command based on your Claude Code setup
        exec claude-code .
        ;;
    2)
        print_info "Navigating to worktree directory..."
        echo "Run this command to navigate:"
        echo "  cd $WORKTREE_PATH"
        
        # Open a new shell in the worktree directory
        cd "$WORKTREE_PATH"
        exec "$SHELL"
        ;;
    3)
        print_info "Worktree Status:"
        echo ""
        echo "📍 Location: $WORKTREE_PATH"
        echo "🌳 Branch: $CURRENT_BRANCH" 
        echo "📝 Latest commit: $COMMIT_INFO"
        
        if [ -f "$CLAUDE_MD" ]; then
            echo "🤖 Claude context: Available (CLAUDE.md)"
        else
            echo "🤖 Claude context: Default"
        fi
        
        if [ -n "$VENV_PATH" ]; then
            echo "🐍 Python environment: $VENV_PATH"
        fi
        
        echo ""
        echo "File structure:"
        cd "$WORKTREE_PATH"
        find . -maxdepth 2 -type f -name "*.py" -o -name "*.yaml" -o -name "*.md" -o -name "*.txt" | head -10 | sed 's/^/  /'
        
        TOTAL_FILES=$(find . -type f | wc -l)
        echo "  ... ($TOTAL_FILES total files)"
        ;;
    *)
        print_error "Invalid choice. Exiting."
        exit 1
        ;;
esac
