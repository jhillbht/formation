#!/usr/bin/env bash

###############################################################################
# Checkpoint Command - Create workflow checkpoints for safe experimentation
# Enables quick rollback of multiple file changes in AI development
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
CHECKPOINT_NAME=""
INCLUDE_DATA="false"

while [[ $# -gt 0 ]]; do
    case $1 in
        --name)
            CHECKPOINT_NAME="$2"
            shift 2
            ;;
        --include-data)
            INCLUDE_DATA="$2"
            shift 2
            ;;
        *)
            if [ -z "$CHECKPOINT_NAME" ]; then
                CHECKPOINT_NAME="$1"
                shift
            else
                echo "Unknown parameter: $1"
                exit 1
            fi
            ;;
    esac
done

if [ -z "$CHECKPOINT_NAME" ]; then
    print_error "Checkpoint name is required"
    echo "Usage: /checkpoint \"checkpoint-name\" [--include-data true/false]"
    exit 1
fi

# Ensure we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "Not in a git repository. Checkpoints require git."
    exit 1
fi

print_header "Creating Workflow Checkpoint"
print_info "Name: $CHECKPOINT_NAME"
print_info "Include data: $INCLUDE_DATA"
echo ""

# Create checkpoints directory
CHECKPOINT_DIR=".claude/checkpoints"
mkdir -p "$CHECKPOINT_DIR"

# Generate checkpoint timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
CHECKPOINT_ID="${TIMESTAMP}_${CHECKPOINT_NAME// /_}"
CHECKPOINT_PATH="$CHECKPOINT_DIR/$CHECKPOINT_ID"

print_info "Creating checkpoint: $CHECKPOINT_ID"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    print_warning "Uncommitted changes detected"
    
    # Show what's changed
    echo ""
    echo "Modified files:"
    git status --porcelain | sed 's/^/  /'
    echo ""
    
    # Auto-commit changes for checkpoint
    print_info "Auto-committing changes for checkpoint..."
    git add .
    git commit -m "Auto-commit for checkpoint: $CHECKPOINT_NAME

Created by /checkpoint command at $TIMESTAMP
Include data: $INCLUDE_DATA"
    
    print_success "Changes committed for checkpoint"
fi

# Get current commit hash
CURRENT_COMMIT=$(git rev-parse HEAD)
CURRENT_BRANCH=$(git branch --show-current)

# Create checkpoint metadata
cat > "$CHECKPOINT_PATH.yaml" << EOF
# Checkpoint Metadata
name: "$CHECKPOINT_NAME"
id: "$CHECKPOINT_ID"
created: "$TIMESTAMP"
commit: "$CURRENT_COMMIT"
branch: "$CURRENT_BRANCH"
include_data: $INCLUDE_DATA
project: "$(basename "$(pwd)")"

# Git state
git_state:
  commit_hash: "$CURRENT_COMMIT"
  branch: "$CURRENT_BRANCH"
  clean_working_tree: true
  
# Project state
project_state:
  believe_configs: $(find believe -name "*.yaml" | wc -l || echo 0)
  source_files: $(find src -name "*.py" | wc -l || echo 0)
  example_files: $(find examples -name "*.py" | wc -l || echo 0)
  notebook_files: $(find notebooks -name "*.ipynb" | wc -l || echo 0)

# File checksums (for integrity verification)
file_checksums:
EOF

# Add file checksums for critical files
CRITICAL_FILES=(
    "CLAUDE.md"
    "believe/*.yaml"
    "src/**/*.py"
    "examples/*.py"
    ".claude/claude-commands.json"
)

for pattern in "${CRITICAL_FILES[@]}"; do
    if ls $pattern 1> /dev/null 2>&1; then
        for file in $pattern; do
            if [ -f "$file" ]; then
                CHECKSUM=$(shasum -a 256 "$file" 2>/dev/null | cut -d' ' -f1 || echo "unknown")
                echo "  \"$file\": \"$CHECKSUM\"" >> "$CHECKPOINT_PATH.yaml"
            fi
        done
    fi
done

# Create checkpoint bundle
print_info "Creating checkpoint bundle..."

BUNDLE_PATH="$CHECKPOINT_PATH.bundle"

# Export git bundle
git bundle create "$BUNDLE_PATH" HEAD ^HEAD~10 2>/dev/null || \
git bundle create "$BUNDLE_PATH" HEAD --all

print_success "Git bundle created: $BUNDLE_PATH"

# Create file snapshot (if including data)
if [ "$INCLUDE_DATA" = "true" ]; then
    print_info "Including data directory in checkpoint..."
    
    SNAPSHOT_PATH="$CHECKPOINT_PATH.tar.gz"
    
    # Create tar archive excluding git and cache
    tar -czf "$SNAPSHOT_PATH" \
        --exclude='.git' \
        --exclude='node_modules' \
        --exclude='__pycache__' \
        --exclude='.claude/checkpoints' \
        --exclude='*.pyc' \
        --exclude='*.log' \
        . 2>/dev/null
    
    print_success "Data snapshot created: $SNAPSHOT_PATH"
fi

# Update checkpoint registry
REGISTRY_PATH="$CHECKPOINT_DIR/registry.yaml"

if [ ! -f "$REGISTRY_PATH" ]; then
    cat > "$REGISTRY_PATH" << EOF
# Checkpoint Registry
checkpoints: []
EOF
fi

# Add checkpoint to registry
python3 -c "
import yaml
import sys

try:
    with open('$REGISTRY_PATH', 'r') as f:
        registry = yaml.safe_load(f) or {'checkpoints': []}
    
    checkpoint = {
        'id': '$CHECKPOINT_ID',
        'name': '$CHECKPOINT_NAME',
        'timestamp': '$TIMESTAMP',
        'commit': '$CURRENT_COMMIT',
        'branch': '$CURRENT_BRANCH',
        'include_data': $INCLUDE_DATA,
        'files': {
            'metadata': '$CHECKPOINT_PATH.yaml',
            'bundle': '$BUNDLE_PATH'
        }
    }
    
    if '$INCLUDE_DATA' == 'true':
        checkpoint['files']['snapshot'] = '$CHECKPOINT_PATH.tar.gz'
    
    registry['checkpoints'].append(checkpoint)
    
    # Keep only last 20 checkpoints
    registry['checkpoints'] = registry['checkpoints'][-20:]
    
    with open('$REGISTRY_PATH', 'w') as f:
        yaml.dump(registry, f, default_flow_style=False)
        
    print('Registry updated successfully')
    
except Exception as e:
    print(f'Error updating registry: {e}', file=sys.stderr)
    sys.exit(1)
" 2>/dev/null || {
    # Fallback if python/yaml not available
    echo "  - id: $CHECKPOINT_ID" >> "$REGISTRY_PATH"
    echo "    name: $CHECKPOINT_NAME" >> "$REGISTRY_PATH"
    echo "    timestamp: $TIMESTAMP" >> "$REGISTRY_PATH"
    echo "    commit: $CURRENT_COMMIT" >> "$REGISTRY_PATH"
}

# Create restore script
RESTORE_SCRIPT="$CHECKPOINT_PATH.restore.sh"
cat > "$RESTORE_SCRIPT" << EOF
#!/usr/bin/env bash
# Restore script for checkpoint: $CHECKPOINT_NAME
# Created: $TIMESTAMP

set -e

echo "🔄 Restoring checkpoint: $CHECKPOINT_NAME"
echo "📅 Created: $TIMESTAMP"
echo "📝 Commit: $CURRENT_COMMIT"
echo ""

# Check if we're in the right directory
if [ ! -f "CLAUDE.md" ] || [ ! -d "believe" ]; then
    echo "❌ Not in a Newsense AI project directory"
    exit 1
fi

# Warn about uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "⚠️  You have uncommitted changes!"
    echo "Current changes will be lost. Continue? [y/N]"
    read -n 1 -r
    echo
    if [[ ! \$REPLY =~ ^[Yy]\$ ]]; then
        echo "Restore cancelled"
        exit 1
    fi
fi

# Reset to checkpoint commit
echo "🔄 Resetting to checkpoint commit..."
git reset --hard $CURRENT_COMMIT

# Restore data if available
if [ -f "$CHECKPOINT_PATH.tar.gz" ]; then
    echo "📦 Restoring data snapshot..."
    tar -xzf "$CHECKPOINT_PATH.tar.gz" --overwrite
fi

echo "✅ Checkpoint restored successfully!"
echo ""
echo "Restored state:"
echo "  📝 Commit: $CURRENT_COMMIT"
echo "  🌿 Branch: $CURRENT_BRANCH"
echo "  📅 Timestamp: $TIMESTAMP"
EOF

chmod +x "$RESTORE_SCRIPT"

# Summary
print_success "Checkpoint created successfully!"
echo ""
print_header "📋 Checkpoint Summary"
echo "  🆔 ID: $CHECKPOINT_ID"
echo "  📝 Name: $CHECKPOINT_NAME"
echo "  📅 Created: $TIMESTAMP"
echo "  📍 Commit: ${CURRENT_COMMIT:0:8}"
echo "  🌿 Branch: $CURRENT_BRANCH"
echo "  💾 Include data: $INCLUDE_DATA"

echo ""
print_header "📁 Checkpoint Files"
echo "  📄 Metadata: $CHECKPOINT_PATH.yaml"
echo "  📦 Git bundle: $BUNDLE_PATH"
if [ "$INCLUDE_DATA" = "true" ]; then
    echo "  💾 Data snapshot: $CHECKPOINT_PATH.tar.gz"
fi
echo "  🔄 Restore script: $RESTORE_SCRIPT"

echo ""
print_header "🔄 Restore Options"
echo "Quick restore:"
echo "  $RESTORE_SCRIPT"
echo ""
echo "Manual restore:"
echo "  git reset --hard $CURRENT_COMMIT"
if [ "$INCLUDE_DATA" = "true" ]; then
    echo "  tar -xzf $CHECKPOINT_PATH.tar.gz"
fi

echo ""
print_header "📚 Checkpoint Management"
echo "List checkpoints:"
echo "  /checkpoint-list"
echo ""
echo "Create new checkpoint:"
echo "  /checkpoint \"my-checkpoint-name\""
echo ""
echo "Include data in checkpoint:"
echo "  /checkpoint \"with-data\" --include-data true"

# Add to .gitignore if not already there
if [ -f ".gitignore" ]; then
    if ! grep -q ".claude/checkpoints" ".gitignore"; then
        echo "" >> .gitignore
        echo "# Claude Code checkpoints" >> .gitignore
        echo ".claude/checkpoints/*.bundle" >> .gitignore
        echo ".claude/checkpoints/*.tar.gz" >> .gitignore
        print_info "Added checkpoint files to .gitignore"
    fi
fi

print_success "Checkpoint workflow ready! Safe experimentation enabled. 🧪"
