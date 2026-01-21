#!/bin/bash
# compare-versions.sh
#
# Script to compare old and new documentation to verify changes.
#
# Usage: ./compare-versions.sh <old-dir> <new-dir>
#
# Example: ./compare-versions.sh backup-20250121-100000 .

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}=== $1 ===${NC}"
}

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

# Check arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <old-dir> <new-dir>"
    echo ""
    echo "Example:"
    echo "  $0 backup-20250121-100000 ."
    exit 1
fi

OLD_DIR="$1"
NEW_DIR="$2"

# Check directories exist
if [ ! -d "$OLD_DIR" ]; then
    echo "Error: Old directory not found: $OLD_DIR"
    exit 1
fi

if [ ! -d "$NEW_DIR" ]; then
    echo "Error: New directory not found: $NEW_DIR"
    exit 1
fi

print_header "Comparing Documentation Versions"
echo ""
echo "Old: $OLD_DIR"
echo "New: $NEW_DIR"
echo ""

# Count files
print_header "File Count Comparison"

OLD_MD=$(find "$OLD_DIR" -name "*.md" 2>/dev/null | wc -l)
NEW_MD=$(find "$NEW_DIR" -name "*.md" 2>/dev/null | wc -l)

OLD_MERMAID=$(find "$OLD_DIR" -name "*.mermaid" 2>/dev/null | wc -l)
NEW_MERMAID=$(find "$NEW_DIR" -name "*.mermaid" 2>/dev/null | wc -l)

OLD_XML=$(find "$OLD_DIR" -name "*.xml" 2>/dev/null | wc -l)
NEW_XML=$(find "$NEW_DIR" -name "*.xml" 2>/dev/null | wc -l)

echo "Markdown files: $OLD_MD → $NEW_MD"
echo "Mermaid diagrams: $OLD_MERMAID → $NEW_MERMAID"
echo "XML examples: $OLD_XML → $NEW_XML"
echo ""

# File structure changes
print_header "File Structure Changes"

echo "Files added in new version:"
comm -13 <(cd "$OLD_DIR" && find . -type f | sort) <(cd "$NEW_DIR" && find . -type f | sort) | while read file; do
    echo "  + $file"
done
echo ""

echo "Files removed in old version:"
comm -23 <(cd "$OLD_DIR" && find . -type f | sort) <(cd "$NEW_DIR" && find . -type f | sort) | while read file; do
    echo "  - $file"
done
echo ""

# Compare markdown files
print_header "Markdown File Changes"

for file in $(cd "$NEW_DIR" && find . -name "*.md" | sort); do
    if [ -f "$OLD_DIR/$file" ]; then
        if ! diff -q "$OLD_DIR/$file" "$NEW_DIR/$file" > /dev/null 2>&1; then
            echo "Changed: $file"
            # Show first 20 lines of diff
            diff -u "$OLD_DIR/$file" "$NEW_DIR/$file" | head -30 || true
            echo "..."
            echo ""
        fi
    fi
done

# Compare Mermaid files
print_header "Mermaid Diagram Changes"

for file in $(cd "$NEW_DIR" && find . -name "*.mermaid" | sort); do
    if [ -f "$OLD_DIR/$file" ]; then
        if ! diff -q "$OLD_DIR/$file" "$NEW_DIR/$file" > /dev/null 2>&1; then
            echo "Changed: $file"
            diff -u "$OLD_DIR/$file" "$NEW_DIR/$file" | head -20 || true
            echo "..."
            echo ""
        fi
    fi
done

# Compare XML files
print_header "XML Example Changes"

for file in $(cd "$NEW_DIR" && find . -name "*.xml" | sort); do
    if [ -f "$OLD_DIR/$file" ]; then
        if ! diff -q "$OLD_DIR/$file" "$NEW_DIR/$file" > /dev/null 2>&1; then
            echo "Changed: $file"
            diff -u "$OLD_DIR/$file" "$NEW_DIR/$file" | head -20 || true
            echo "..."
            echo ""
        fi
    fi
done

# Version file comparison
print_header "Version Information"

if [ -f "$OLD_DIR/VERSION.md" ] && [ -f "$NEW_DIR/VERSION.md" ]; then
    echo "Old version:"
    grep "Specification Version:" "$OLD_DIR/VERSION.md" || echo "  Not found"
    echo ""
    echo "New version:"
    grep "Specification Version:" "$NEW_DIR/VERSION.md" || echo "  Not found"
    echo ""
fi

print_header "Comparison Complete"

echo "Summary:"
echo "  - Review the changes above"
echo "  - Verify file counts are as expected"
echo "  - Check that new files were added and old ones removed appropriately"
echo "  - Validate content changes in markdown, mermaid, and XML files"
echo ""
