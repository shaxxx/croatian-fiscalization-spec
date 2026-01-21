#!/bin/bash
# update-documentation.sh
#
# Script to update documentation from new PDF version of the
# Croatian Fiscalization Technical Specification.
#
# Usage: ./update-documentation.sh <path-to-new-pdf>
#
# Example: ./update-documentation.sh ~/Downloads/Fiskalizacija-v2.7-2026-06-01.pdf

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check arguments
if [ $# -eq 0 ]; then
    print_error "No PDF file specified"
    echo ""
    echo "Usage: $0 <path-to-new-pdf>"
    echo ""
    echo "Example:"
    echo "  $0 ~/Downloads/Fiskalizacija-v2.7-2026-06-01.pdf"
    exit 1
fi

NEW_PDF="$1"

# Check if PDF exists
if [ ! -f "$NEW_PDF" ]; then
    print_error "PDF file not found: $NEW_PDF"
    exit 1
fi

# Get current version
CURRENT_VERSION=$(grep "Specification Version:" VERSION.md 2>/dev/null | awk '{print $3}' || echo "unknown")

print_info "Current documentation version: $CURRENT_VERSION"
print_info "New PDF: $NEW_PDF"
echo ""

# Confirm with user
read -p "Do you want to continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_warning "Update cancelled"
    exit 0
fi

# Create backup
BACKUP_DIR="backup-$(date +%Y%m%d-%H%M%S)"
print_info "Creating backup: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Backup documentation directories
if [ -d "docs" ]; then
    cp -r docs "$BACKUP_DIR/"
    print_info "Backed up docs/"
fi

if [ -d "code-examples" ]; then
    cp -r code-examples "$BACKUP_DIR/"
    print_info "Backed up code-examples/"
fi

# Backup VERSION.md
if [ -f "VERSION.md" ]; then
    cp VERSION.md "$BACKUP_DIR/"
    print_info "Backed up VERSION.md"
fi

print_info "Backup created successfully"
echo ""

# Extract version info from filename
print_info "Analyzing PDF filename..."
FILENAME=$(basename "$NEW_PDF")

# Try to extract version from filename (format: v2.6 or v2.7 etc)
VERSION=$(echo "$FILENAME" | grep -oP "v\K[0-9]+\.[0-9]+" || echo "unknown")

# Try to extract date from filename (format: (DD.MM.YYYY.)
DATE=$(echo "$FILENAME" | grep -oP "\(\K[0-9]+\.[0-9]+\.[0-9]+" || echo "unknown")

# Convert DD.MM.YYYY to YYYY-MM-DD
if [ "$DATE" != "unknown" ]; then
    DATE_CONVERTED=$(echo "$DATE" | awk -F. '{print $3"-"$2"-"$1}')
else
    DATE_CONVERTED="unknown"
fi

print_info "Detected version: $VERSION"
print_info "Detected date: $DATE_CONVERTED"
echo ""

# Instructions for AI
echo "=========================================="
print_info "NEXT STEPS FOR AI ASSISTANT"
echo "=========================================="
echo ""
echo "1. Read the new PDF:"
echo "   $NEW_PDF"
echo ""
echo "2. Update VERSION.md with:"
echo "   - Specification Version: $VERSION"
echo "   - Specification Date: $DATE_CONVERTED"
echo "   - Documentation Generated: $(date +%Y-%m-%d)"
echo ""
echo "3. Follow CONVERSION-GUIDE.md to regenerate documentation:"
echo "   - Extract code examples AS-IS"
echo "   - Convert flow diagrams to Mermaid"
echo "   - Generate markdown documentation"
echo "   - Update CHANGELOG.md"
echo ""
echo "4. Verify changes:"
echo "   ./compare-versions.sh $BACKUP_DIR ."
echo ""
echo "5. Test documentation:"
echo "   - Check all markdown files render"
echo "   - Verify Mermaid diagrams display"
echo "   - Validate XML examples"
echo "   - Test all links"
echo ""
echo "6. Commit changes:"
echo "   git add ."
echo "   git commit -m \"Update to specification $VERSION ($DATE_CONVERTED)\""
echo "   git push"
echo ""
echo "=========================================="
echo ""

# Prompt for AI assistant
read -p "Ready to start AI conversion? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_info "Exiting. Backup preserved at: $BACKUP_DIR"
    exit 0
fi

# Launch AI assistant instructions
print_info "Starting AI conversion process..."
echo ""
echo "Please tell your AI assistant:"
echo ""
echo "--- COPY BELOW ---"
echo "Convert the Croatian Fiscalization Technical Specification PDF at"
echo "'$NEW_PDF' to markdown documentation following the process in"
echo "CONVERSION-GUIDE.md."
echo ""
echo "Specification version: $VERSION"
echo "Specification date: $DATE_CONVERTED"
echo ""
echo "Requirements:"
echo "1. Update VERSION.md with new version information"
echo "2. Extract all code examples AS-IS (no optimization)"
echo "3. Convert all flow diagrams to Mermaid format"
echo "4. Create comprehensive markdown documentation for each chapter"
echo "5. Update CHANGELOG.md with version details"
echo "6. Ignore XML schema visualizations"
echo ""
echo "Source PDF: $NEW_PDF"
echo "Current documentation: $CURRENT_VERSION"
echo "Backup location: $BACKUP_DIR"
echo "--- END COPY ---"
echo ""

print_info "Waiting for AI to complete conversion..."
echo ""
print_info "After AI finishes:"
echo "  1. Verify: ./compare-versions.sh $BACKUP_DIR ."
echo "  2. Test: Check links, diagrams, examples"
echo "  3. Commit: git add . && git commit -m 'Update to v$VERSION'"
