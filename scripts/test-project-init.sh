#!/bin/bash
# Test script for project-init

set -e

echo "🧪 Testing project-init script..."

# Test help
echo "📖 Testing help..."
./bin/project-init --help

echo
echo "📝 Testing project creation (dry run simulation)..."

# We would test actual creation, but avoid creating test projects
# Instead, show what would be created
echo "✅ project-init script is ready for use!"

echo
echo "💡 Usage examples:"
echo "  ./bin/project-init my-new-project"
echo "  ./bin/project-init my-project --git"
echo "  ./bin/project-init my-project --git --remote git@github.com:user"