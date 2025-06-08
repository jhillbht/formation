#!/usr/bin/env bash

###############################################################################
# Setup MCP (Model Context Protocol) Servers for Newsense AI Projects
# Configures remote MCP servers with organized AI conventions
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }

# Parse arguments
PROVIDER="anthropic"
ENDPOINT=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --provider)
            PROVIDER="$2"
            shift 2
            ;;
        --endpoint)
            ENDPOINT="$2"
            shift 2
            ;;
        *)
            echo "Unknown parameter: $1"
            exit 1
            ;;
    esac
done

print_info "Setting up MCP servers for Newsense AI project"
print_info "Provider: $PROVIDER"

# Ensure .claude/config directory exists
mkdir -p .claude/config

# Create MCP servers configuration
MCP_CONFIG=".claude/config/mcp-servers.yaml"

case "$PROVIDER" in
    "anthropic")
        print_info "Configuring Anthropic MCP server"
        cat > "$MCP_CONFIG" << EOF
# MCP Servers Configuration for Newsense AI Project
servers:
  anthropic:
    name: "Anthropic Claude MCP"
    endpoint: "${ENDPOINT:-https://api.anthropic.com/v1/mcp}"
    auth:
      type: "api_key"
      key_env: "ANTHROPIC_API_KEY"
    capabilities:
      - "completion"
      - "chat"
      - "function_calling"
    config:
      model: "claude-3-sonnet-20240229"
      max_tokens: 4096
      temperature: 0.7
    
  # Organized AI specific tools
  newsense_tools:
    name: "Newsense AI Development Tools"
    endpoint: "local://tools"
    capabilities:
      - "file_analysis"
      - "believe_config_management"
      - "ai_client_helpers"
      - "prompt_engineering"
    config:
      workspace: "./supabowl-workspace"
      project_type: "newsense"
EOF
        ;;
    "openai")
        print_info "Configuring OpenAI MCP server"
        cat > "$MCP_CONFIG" << EOF
# MCP Servers Configuration for Newsense AI Project
servers:
  openai:
    name: "OpenAI MCP"
    endpoint: "${ENDPOINT:-https://api.openai.com/v1/mcp}"
    auth:
      type: "api_key"
      key_env: "OPENAI_API_KEY"
    capabilities:
      - "completion"
      - "chat"
      - "function_calling"
    config:
      model: "gpt-4"
      max_tokens: 4096
      temperature: 0.7
      
  # Organized AI specific tools
  newsense_tools:
    name: "Newsense AI Development Tools"
    endpoint: "local://tools"
    capabilities:
      - "file_analysis"
      - "believe_config_management"
      - "ai_client_helpers"
      - "prompt_engineering"
EOF
        ;;
    "custom")
        if [ -z "$ENDPOINT" ]; then
            print_error "Custom provider requires --endpoint parameter"
            exit 1
        fi
        print_info "Configuring custom MCP server: $ENDPOINT"
        cat > "$MCP_CONFIG" << EOF
# MCP Servers Configuration for Newsense AI Project
servers:
  custom:
    name: "Custom MCP Server"
    endpoint: "$ENDPOINT"
    auth:
      type: "api_key"
      key_env: "CUSTOM_MCP_API_KEY"
    capabilities:
      - "completion"
      - "chat"
    config:
      max_tokens: 4096
      temperature: 0.7
EOF
        ;;
    *)
        print_error "Unknown provider: $PROVIDER"
        print_info "Supported providers: anthropic, openai, custom"
        exit 1
        ;;
esac

print_success "MCP server configuration created: $MCP_CONFIG"

# Create local tools configuration for Newsense AI features
TOOLS_CONFIG=".claude/config/local-tools.yaml"
cat > "$TOOLS_CONFIG" << EOF
# Local Tools Configuration for Newsense AI Development
tools:
  believe_analyzer:
    description: "Analyze and validate believe/ configurations"
    script: ".claude/tools/analyze-believe.sh"
    
  ai_client_validator:
    description: "Validate AI client implementations"
    script: ".claude/tools/validate-ai-clients.sh"
    
  prompt_optimizer:
    description: "Optimize prompt templates and engineering"
    script: ".claude/tools/optimize-prompts.sh"
    
  context_mapper:
    description: "Map AI context usage and relationships"
    script: ".claude/tools/map-context.sh"
    
  supabowl_sync:
    description: "Sync with supabowl workspace conventions"
    script: ".claude/tools/sync-supabowl.sh"
EOF

# Create environment configuration template
ENV_TEMPLATE=".claude/config/mcp-environment.example"
cat > "$ENV_TEMPLATE" << EOF
# MCP Environment Configuration
# Copy to .env and configure your API keys

# Anthropic Configuration
ANTHROPIC_API_KEY=your_anthropic_api_key_here

# OpenAI Configuration  
OPENAI_API_KEY=your_openai_api_key_here

# Custom MCP Configuration
CUSTOM_MCP_API_KEY=your_custom_mcp_key_here
CUSTOM_MCP_ENDPOINT=https://your-custom-mcp-server.com

# Newsense AI Project Configuration
NEWSENSE_PROJECT_NAME=$(basename "$(pwd)")
SUPABOWL_WORKSPACE=$HOME/supabowl-workspace
BELIEVE_CONFIG_PATH=./believe
AI_MODEL_PREFERENCE=claude
DEFAULT_TEMPERATURE=0.7
MAX_TOKENS=4096

# Context Management
CONTEXT_PRESERVATION_STRATEGY=preserve-ai-context
AUTO_COMPACT_THRESHOLD=0.8
CHECKPOINT_AUTO_FREQUENCY=30m
EOF

print_success "Local tools configuration created: $TOOLS_CONFIG"
print_success "Environment template created: $ENV_TEMPLATE"

# Check if .env file exists, if not suggest copying template
if [ ! -f ".env" ]; then
    print_warning "No .env file found"
    print_info "Copy the template and configure your API keys:"
    echo "  cp $ENV_TEMPLATE .env"
    echo "  # Edit .env with your actual API keys"
fi

# Validate current environment
print_info "Validating environment setup..."

# Check for API keys
if [ -f ".env" ]; then
    source .env
    
    case "$PROVIDER" in
        "anthropic")
            if [ -n "$ANTHROPIC_API_KEY" ] && [ "$ANTHROPIC_API_KEY" != "your_anthropic_api_key_here" ]; then
                print_success "Anthropic API key configured"
            else
                print_warning "Anthropic API key not configured"
            fi
            ;;
        "openai")
            if [ -n "$OPENAI_API_KEY" ] && [ "$OPENAI_API_KEY" != "your_openai_api_key_here" ]; then
                print_success "OpenAI API key configured"
            else
                print_warning "OpenAI API key not configured"
            fi
            ;;
    esac
fi

# Check project structure
if [ -d "believe" ]; then
    print_success "Believe configuration directory found"
else
    print_warning "Believe configuration directory not found - is this a Newsense AI project?"
fi

if [ -f "CLAUDE.md" ]; then
    print_success "Claude context file found"
else
    print_warning "CLAUDE.md not found - consider adding project context"
fi

print_success "MCP server setup complete!"
print_info "Configuration files created:"
echo "  📄 $MCP_CONFIG - MCP server configuration"
echo "  🛠️  $TOOLS_CONFIG - Local tools configuration"
echo "  📝 $ENV_TEMPLATE - Environment template"

print_info "Next steps:"
echo "1. Configure your API keys in .env file"
echo "2. Restart Claude Code to load new MCP configuration"
echo "3. Test MCP connection with /ai-overview command"
