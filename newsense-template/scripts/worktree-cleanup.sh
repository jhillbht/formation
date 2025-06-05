#!/usr/bin/env bash

###############################################################################
# Worktree Cleanup Script for Newsense AI Projects
# Safely removes completed git worktrees and cleans up branches
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

# Function to show current worktrees
show_worktrees() {
    echo ""
    print_info "Current worktrees:"
    git worktree list | while read -r line; do
        if [[ "$line" == *"$(git rev-parse --show-toplevel)"* ]]; then
            echo "  🏠 $line (main)"
        else
            echo "  🌳 $line"
        fi
    done
    echo ""
}

# Function to check for uncommitted changes
check_uncommitted_changes() {
    local worktree_path="$1"
    cd "$worktree_path"
    
    if ! git diff-index --quiet HEAD --; then
        print_warning "Uncommitted changes detected!"
        echo ""
        echo "Modified files:"
        git status --porcelain | sed 's/^/  /'
        echo ""
        return 1
    fi
    
    return 0
}

# Function to check if branch is merged
check_if_merged() {
    local branch_name="$1"
    local main_branch
    
    # Determine main branch name
    if git branch | grep -q "main"; then
        main_branch="main"
    elif git branch | grep -q "master"; then
        main_branch="master"
    else
        print_warning "Could not determine main branch (main/master)"
        return 1
    fi
    
    # Check if branch is merged
    if git branch --merged "$main_branch" | grep -q "$branch_name"; then
        return 0  # Branch is merged
    else
        return 1  # Branch is not merged
    fi
}

# Main cleanup function
cleanup_worktree() {
    local worktree_name="$1"
    local project_name=$(basename "$(git rev-parse --show-toplevel)")
    local worktrees_dir="../worktrees"
    local worktree_path="$worktrees_dir/${project_name}-${worktree_name//\//-}"
    local branch_name="worktree/${worktree_name}"
    
    print_info "Cleaning up worktree: $worktree_name"
    print_info "Path: $worktree_path"
    print_info "Branch: $branch_name"
    
    # Check if worktree exists
    if [ ! -d "$worktree_path" ]; then
        print_error "Worktree not found: $worktree_path"
        return 1
    fi
    
    # Store current directory
    local original_dir=$(pwd)
    
    # Check for uncommitted changes
    print_info "Checking for uncommitted changes..."
    if ! check_uncommitted_changes "$worktree_path"; then
        echo ""
        echo "Options:"
        echo "1. Commit changes before cleanup"
        echo "2. Stash changes"
        echo "3. Discard changes (DESTRUCTIVE)"
        echo "4. Cancel cleanup"
        echo ""
        read -p "Choose option [1-4]: " -n 1 -r
        echo
        
        case $REPLY in
            1)
                cd "$worktree_path"
                print_info "Please commit your changes manually, then run cleanup again."
                exec "$SHELL"
                return 1
                ;;
            2)
                cd "$worktree_path"
                git stash push -m "Stashed before worktree cleanup on $(date)"
                print_success "Changes stashed"
                ;;
            3)
                cd "$worktree_path"
                git reset --hard HEAD
                git clean -fd
                print_warning "Uncommitted changes discarded"
                ;;
            4)
                print_info "Cleanup cancelled"
                return 1
                ;;
            *)
                print_error "Invalid choice. Cleanup cancelled."
                return 1
                ;;
        esac
    else
        print_success "No uncommitted changes found"
    fi
    
    # Return to original directory
    cd "$original_dir"
    
    # Check if branch should be merged
    print_info "Checking merge status..."
    if ! check_if_merged "$branch_name"; then
        print_warning "Branch '$branch_name' is not merged into main branch"
        echo ""
        echo "Options:"
        echo "1. Merge branch before cleanup"
        echo "2. Delete branch without merging (LOSE CHANGES)"
        echo "3. Cancel cleanup"
        echo ""
        read -p "Choose option [1-3]: " -n 1 -r
        echo
        
        case $REPLY in
            1)
                # Determine main branch
                local main_branch
                if git branch | grep -q "main"; then
                    main_branch="main"
                elif git branch | grep -q "master"; then
                    main_branch="master"
                else
                    print_error "Could not determine main branch"
                    return 1
                fi
                
                print_info "Merging $branch_name into $main_branch..."
                git checkout "$main_branch"
                git merge "$branch_name"
                print_success "Branch merged successfully"
                ;;
            2)
                print_warning "Branch will be deleted without merging"
                ;;
            3)
                print_info "Cleanup cancelled"
                return 1
                ;;
            *)
                print_error "Invalid choice. Cleanup cancelled."
                return 1
                ;;
        esac
    else
        print_success "Branch is already merged"
    fi
    
    # Final confirmation
    echo ""
    print_warning "About to remove worktree and branch:"
    echo "  📂 Worktree: $worktree_path"
    echo "  🌳 Branch: $branch_name"
    echo ""
    read -p "Are you sure? [y/N]: " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Cleanup cancelled"
        return 1
    fi
    
    # Remove the worktree
    print_info "Removing worktree..."
    git worktree remove "$worktree_path"
    print_success "Worktree removed"
    
    # Delete the branch
    print_info "Deleting branch..."
    git branch -D "$branch_name"
    print_success "Branch deleted"
    
    # Clean up any remaining directories
    if [ -d "$worktree_path" ]; then
        print_info "Cleaning up remaining directory..."
        rm -rf "$worktree_path"
    fi
    
    print_success "Worktree cleanup completed!"
}

# Main script logic
if [ $# -eq 0 ]; then
    show_worktrees
    
    echo "Usage: $0 <worktree-name>"
    echo "   or: $0 --prune    (clean up all stale worktrees)"
    echo "   or: $0 --list     (show current worktrees)"
    echo ""
    echo "Examples:"
    echo "  $0 experiment/langchain-integration"
    echo "  $0 feature/advanced-prompting"
    exit 1
fi

case "$1" in
    --prune)
        print_info "Pruning stale worktrees..."
        git worktree prune
        print_success "Stale worktrees pruned"
        show_worktrees
        ;;
    --list)
        show_worktrees
        ;;
    *)
        WORKTREE_NAME="$1"
        cleanup_worktree "$WORKTREE_NAME"
        ;;
esac
