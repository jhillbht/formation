#!/usr/bin/env bash

###############################################################################
# Worktree Creation Script for Newsense AI Projects
# Creates a new git worktree with proper Claude Code context
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
    echo "Examples:"
    echo "  $0 experiment/langchain-integration"
    echo "  $0 feature/advanced-prompting"
    echo "  $0 comparison/claude-vs-gpt4"
    echo "  $0 models/claude-3-opus"
    exit 1
fi

WORKTREE_NAME="$1"
PROJECT_NAME=$(basename "$(git rev-parse --show-toplevel)")
WORKTREES_DIR="../worktrees"
WORKTREE_PATH="$WORKTREES_DIR/${PROJECT_NAME}-${WORKTREE_NAME//\//-}"
BRANCH_NAME="worktree/${WORKTREE_NAME}"

print_info "Creating worktree for: $WORKTREE_NAME"
print_info "Branch: $BRANCH_NAME"
print_info "Path: $WORKTREE_PATH"

# Create worktrees directory if it doesn't exist
mkdir -p "$WORKTREES_DIR"

# Create and checkout new branch for the worktree
print_info "Creating branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

# Add the worktree
print_info "Adding worktree at: $WORKTREE_PATH"
git worktree add "$WORKTREE_PATH" "$BRANCH_NAME"

# Switch back to main branch
git checkout main 2>/dev/null || git checkout master 2>/dev/null || true

# Create worktree-specific CLAUDE.md context
CLAUDE_MD="$WORKTREE_PATH/CLAUDE.md"
print_info "Creating worktree-specific CLAUDE.md context"

# Determine context type based on worktree name
CONTEXT_TYPE=""
CONTEXT_DESCRIPTION=""

case "$WORKTREE_NAME" in
    experiment/*)
        CONTEXT_TYPE="Experiment"
        CONTEXT_DESCRIPTION="This worktree contains experimental work for: ${WORKTREE_NAME#experiment/}"
        ;;
    feature/*)
        CONTEXT_TYPE="Feature Development"
        CONTEXT_DESCRIPTION="This worktree is developing the feature: ${WORKTREE_NAME#feature/}"
        ;;
    comparison/*)
        CONTEXT_TYPE="Comparison Study"
        CONTEXT_DESCRIPTION="This worktree contains comparison work for: ${WORKTREE_NAME#comparison/}"
        ;;
    models/*)
        CONTEXT_TYPE="Model Integration"
        CONTEXT_DESCRIPTION="This worktree is testing the model: ${WORKTREE_NAME#models/}"
        ;;
    performance/*)
        CONTEXT_TYPE="Performance Optimization"
        CONTEXT_DESCRIPTION="This worktree is optimizing: ${WORKTREE_NAME#performance/}"
        ;;
    *)
        CONTEXT_TYPE="Development"
        CONTEXT_DESCRIPTION="This worktree is working on: $WORKTREE_NAME"
        ;;
esac

# Create the worktree-specific CLAUDE.md
cat > "$CLAUDE_MD" << EOF
# Claude Code Context for $CONTEXT_TYPE Worktree

## Worktree Information
- **Name**: $WORKTREE_NAME
- **Branch**: $BRANCH_NAME
- **Type**: $CONTEXT_TYPE
- **Created**: $(date '+%Y-%m-%d %H:%M:%S')

## Purpose
$CONTEXT_DESCRIPTION

## Development Focus
This is a **git worktree** for parallel development. Changes here are isolated from the main project until merged.

### Key Differences from Main Project
- Experimental changes and configurations
- Modified believe/ settings for this specific work
- Custom dependencies or requirements if needed
- Isolated testing and validation

### Merging Guidelines
When this work is complete:
1. Test thoroughly in this isolated environment
2. Update main project documentation
3. Merge changes back to main branch
4. Clean up this worktree

## Newsense AI Project Structure (Inherited)
This worktree inherits the full newsense project structure:
- \`believe/\` - Configuration files (may be modified for this work)
- \`src/\` - Source code with modular organization
- \`data/\` - Data management and storage
- \`examples/\` - Usage demonstrations
- \`notebooks/\` - Experimental work and analysis

## AI Development Context
All standard AI development patterns apply:
- Use Claude/OpenAI clients from \`src/llm/\`
- Configuration-driven development via \`believe/\`
- Proper error handling and logging
- Cache API responses appropriately
- Follow rate limiting best practices

## Worktree-Specific Notes
Add specific notes about what you're working on in this worktree:
- Current objectives
- Modified configurations
- Experimental approaches
- Results and findings

---

*This worktree provides isolated development space for $CONTEXT_TYPE while maintaining full Claude Code context awareness.*
EOF

print_success "Worktree-specific CLAUDE.md created"

# Copy any worktree-specific configurations if they exist
WORKTREE_CONFIG_DIR="believe/worktree-configs"
if [ -d "$WORKTREE_CONFIG_DIR" ]; then
    SPECIFIC_CONFIG="$WORKTREE_CONFIG_DIR/${WORKTREE_NAME//\//-}.yaml"
    if [ -f "$SPECIFIC_CONFIG" ]; then
        print_info "Copying worktree-specific configuration"
        cp "$SPECIFIC_CONFIG" "$WORKTREE_PATH/believe/model_config.yaml"
        print_success "Worktree-specific configuration applied"
    fi
fi

# Create a quick start script for this worktree
QUICKSTART_SCRIPT="$WORKTREE_PATH/start-worktree.sh"
cat > "$QUICKSTART_SCRIPT" << EOF
#!/usr/bin/env bash
# Quick start script for $WORKTREE_NAME worktree

echo "🌳 Starting $CONTEXT_TYPE worktree: $WORKTREE_NAME"
echo "📁 Location: $WORKTREE_PATH"
echo ""

# Activate virtual environment if it exists
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
    echo "✅ Virtual environment activated"
elif [ -f "../venv/bin/activate" ]; then
    source ../venv/bin/activate
    echo "✅ Virtual environment activated (from parent)"
fi

# Install any worktree-specific dependencies
if [ -f "requirements-worktree.txt" ]; then
    echo "📦 Installing worktree-specific dependencies..."
    pip install -r requirements-worktree.txt
fi

echo ""
echo "🚀 Ready for development! Next steps:"
echo "1. Review CLAUDE.md for worktree context"
echo "2. Modify believe/ configurations as needed"
echo "3. Start Claude Code: claude-code ."
echo "4. Begin your $CONTEXT_TYPE work"
EOF

chmod +x "$QUICKSTART_SCRIPT"

print_success "Worktree created successfully!"
print_info "Location: $WORKTREE_PATH"
print_info "Branch: $BRANCH_NAME"

echo ""
echo "🚀 Next steps:"
echo "1. cd $WORKTREE_PATH"
echo "2. ./start-worktree.sh  # Quick setup"
echo "3. claude-code .        # Start Claude Code in this worktree"
echo ""
echo "📋 Worktree commands:"
echo "• List worktrees: git worktree list"
echo "• Remove worktree: git worktree remove $WORKTREE_PATH"
echo "• Prune worktrees: git worktree prune"
echo ""
echo "🎯 When ready to merge:"
echo "1. git checkout main"
echo "2. git merge $BRANCH_NAME"
echo "3. git worktree remove $WORKTREE_PATH"
echo "4. git branch -d $BRANCH_NAME"
