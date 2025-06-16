#!/bin/bash
# Instructions selector script
# Switches between challenge and stable instruction sets

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTRUCTIONS_DIR="$SCRIPT_DIR"
CLAUDE_MD_PATH="$(dirname "$SCRIPT_DIR")/CLAUDE.md"

# Help function
show_help() {
    cat << EOF
🔧 Claude Code Communication - Instructions Selector

USAGE:
    ./instructions/select.sh <mode> [options]

MODES:
    challenge    Use challenge-type instructions (creative, innovative)
    stable       Use stable-type instructions (reliable, efficient)
    status       Show current instruction mode

OPTIONS:
    -h, --help   Show this help message

EXAMPLES:
    ./instructions/select.sh challenge
    ./instructions/select.sh stable
    ./instructions/select.sh status

The script will update CLAUDE.md to reference the selected instruction set.
EOF
}

# Check current instruction mode
check_current_mode() {
    if [[ -f "$CLAUDE_MD_PATH" ]]; then
        if grep -q "@instructions/challenge/" "$CLAUDE_MD_PATH" 2>/dev/null; then
            echo "challenge"
        elif grep -q "@instructions/stable/" "$CLAUDE_MD_PATH" 2>/dev/null; then
            echo "stable"
        else
            echo "unknown"
        fi
    else
        echo "none"
    fi
}

# Update CLAUDE.md with selected instruction mode
update_claude_md() {
    local mode="$1"
    
    if [[ ! -f "$CLAUDE_MD_PATH" ]]; then
        echo -e "${RED}Error: CLAUDE.md not found at $CLAUDE_MD_PATH${NC}" >&2
        exit 1
    fi
    
    # Create backup
    cp "$CLAUDE_MD_PATH" "${CLAUDE_MD_PATH}.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Update instruction references
    case "$mode" in
        challenge)
            sed -i 's|@instructions/stable/|@instructions/challenge/|g' "$CLAUDE_MD_PATH"
            sed -i 's|@instructions/president\.md|@instructions/challenge/president.md|g' "$CLAUDE_MD_PATH"
            sed -i 's|@instructions/boss\.md|@instructions/challenge/boss.md|g' "$CLAUDE_MD_PATH"
            sed -i 's|@instructions/worker\.md|@instructions/challenge/worker.md|g' "$CLAUDE_MD_PATH"
            ;;
        stable)
            sed -i 's|@instructions/challenge/|@instructions/stable/|g' "$CLAUDE_MD_PATH"
            sed -i 's|@instructions/president\.md|@instructions/stable/president.md|g' "$CLAUDE_MD_PATH"
            sed -i 's|@instructions/boss\.md|@instructions/stable/boss.md|g' "$CLAUDE_MD_PATH"
            sed -i 's|@instructions/worker\.md|@instructions/stable/worker.md|g' "$CLAUDE_MD_PATH"
            ;;
    esac
}

# Show status
show_status() {
    local current_mode=$(check_current_mode)
    
    echo -e "${BLUE}📋 Current Instruction Mode Status${NC}"
    echo
    
    case "$current_mode" in
        challenge)
            echo -e "Current mode: ${YELLOW}CHALLENGE${NC} 🚀"
            echo "Description: Creative, innovative, ambitious approach"
            echo "Best for: Experimental projects, brainstorming, innovation"
            ;;
        stable)
            echo -e "Current mode: ${GREEN}STABLE${NC} 🎯"
            echo "Description: Reliable, efficient, systematic approach"
            echo "Best for: Production projects, deadlines, stability"
            ;;
        unknown)
            echo -e "Current mode: ${RED}UNKNOWN${NC} ❓"
            echo "CLAUDE.md exists but mode cannot be determined"
            ;;
        none)
            echo -e "Current mode: ${RED}NONE${NC} ❌"
            echo "CLAUDE.md not found"
            ;;
    esac
    
    echo
    echo -e "${BLUE}Available instruction sets:${NC}"
    echo "  challenge/  - Creative and innovative instructions"
    echo "  stable/     - Reliable and systematic instructions"
}

# Main logic
MODE="$1"

# Parse arguments
case "$MODE" in
    -h|--help)
        show_help
        exit 0
        ;;
    status)
        show_status
        exit 0
        ;;
    challenge|stable)
        # Validate instruction directories exist
        if [[ ! -d "$INSTRUCTIONS_DIR/$MODE" ]]; then
            echo -e "${RED}Error: Instruction directory '$MODE' not found${NC}" >&2
            echo "Available: challenge, stable"
            exit 1
        fi
        
        # Check if files exist
        for file in president.md boss.md worker.md; do
            if [[ ! -f "$INSTRUCTIONS_DIR/$MODE/$file" ]]; then
                echo -e "${RED}Error: Missing instruction file: $MODE/$file${NC}" >&2
                exit 1
            fi
        done
        ;;
    "")
        echo -e "${RED}Error: Mode is required${NC}" >&2
        echo "Use --help for usage information."
        exit 1
        ;;
    *)
        echo -e "${RED}Error: Unknown mode '$MODE'${NC}" >&2
        echo "Available modes: challenge, stable, status"
        echo "Use --help for usage information."
        exit 1
        ;;
esac

# Get current mode before change
current_mode=$(check_current_mode)

echo -e "${BLUE}🔧 Switching instruction mode to: ${YELLOW}$MODE${NC}"
echo

# Update CLAUDE.md
update_claude_md "$MODE"

# Verify the change
new_mode=$(check_current_mode)
if [[ "$new_mode" == "$MODE" ]]; then
    echo -e "${GREEN}✅ Successfully switched to $MODE mode${NC}"
    echo
    
    case "$MODE" in
        challenge)
            echo -e "${YELLOW}🚀 CHALLENGE MODE ACTIVATED${NC}"
            echo "  • Creative and innovative approach"
            echo "  • Ambitious goal setting"
            echo "  • Experimental solutions encouraged"
            echo "  • Best for: brainstorming, innovation, experimentation"
            ;;
        stable)
            echo -e "${GREEN}🎯 STABLE MODE ACTIVATED${NC}"
            echo "  • Reliable and systematic approach"
            echo "  • Efficient and proven methods"
            echo "  • Quality and deadline focused"
            echo "  • Best for: production, deadlines, mission-critical projects"
            ;;
    esac
    
    echo
    echo -e "${BLUE}📝 CLAUDE.md has been updated${NC}"
    echo "  Previous mode: $current_mode"
    echo "  New mode: $new_mode"
    echo "  Backup created: CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
    
else
    echo -e "${RED}❌ Failed to switch mode${NC}" >&2
    echo "Expected: $MODE, Got: $new_mode"
    exit 1
fi

echo
echo -e "${BLUE}🔄 Next steps:${NC}"
echo "  1. Restart Claude sessions for the changes to take effect"
echo "  2. Use ./bin/setup to restart all agents"
echo "  3. Verify the new instructions are loaded correctly"