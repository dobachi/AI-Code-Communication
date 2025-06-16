#!/bin/bash
# Cleanup temporary files and logs

set -e

echo "🧹 Cleaning up temporary files..."

# Remove old temporary files (older than 7 days)
find tmp/ -name "*.json" -mtime +7 -delete 2>/dev/null || true
find logs/ -name "*.log" -mtime +7 -delete 2>/dev/null || true

# Clean up worker temporary files
find projects/*/workspace/worker*/tmp/ -name "*_done.txt" -mtime +1 -delete 2>/dev/null || true

echo "✅ Cleanup completed!"