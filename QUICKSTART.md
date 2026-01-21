# Quick Start: Updating Documentation

**Purpose:** Fast reference for updating documentation when a new specification is released.

---

## 🚀 One-Command Update (Linux/Mac)

```bash
./update-documentation.sh ~/Downloads/Fiskalizacija-v2.7-2026-06-01.pdf
```

This will:
1. Backup current documentation
2. Prompt you to confirm
3. Display instructions for AI assistant

---

## 📋 Manual Update Process

### Step 1: Prepare New PDF

1. Download the new specification PDF
2. Note the version and date from filename
3. Place PDF in accessible location

**Example filename:** `Fiskalizacija - Tehnicka specifikacija za korisnike_v2.7 (01.06.2026.).pdf`
- Version: 2.7
- Date: 2026-06-01

### Step 2: Backup Current Documentation

```bash
# Create timestamped backup
BACKUP_DIR="backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp -r docs code-examples "$BACKUP_DIR/"
echo "Backup: $BACKUP_DIR"
```

### Step 3: Update VERSION.md

Edit `VERSION.md` and update the "Current Version" section:

```markdown
## Current Version

| Field | Value |
|-------|-------|
| **Specification Version** | 2.7 |
| **Specification Date** | 2026-06-01 |
| **Documentation Generated** | [TODAY'S DATE] |
| **Source File** | Fiskalizacija-v2.7-2026-06-01.pdf |
```

Add entry to version history table:

```markdown
| 2.7 | 2026-06-01 | 2025-01-21 | Updated to specification v2.7 |
```

### Step 4: Regenerate Documentation

**Tell AI Assistant:**

> Convert the Croatian Fiscalization Technical Specification PDF at
> [PATH_TO_NEW_PDF] to markdown documentation following the process in
> CONVERSION-GUIDE.md. The specification version is 2.7 dated 2026-06-01.

**The AI will:**
- Read and analyze the PDF
- Extract code examples
- Convert flow diagrams to Mermaid
- Generate markdown documentation
- Update all necessary files

### Step 5: Verify Changes

```bash
# Compare with backup
./compare-versions.sh backup-[TIMESTAMP]/ .
```

**Verification Checklist:**
- [ ] All markdown files render correctly
- [ ] All Mermaid diagrams display properly
- [ ] All XML examples are well-formed
- [ ] No broken internal links
- [ ] No broken external links
- [ ] Version info consistent across files
- [ ] CHANGELOG.md updated

### Step 6: Commit Changes

```bash
git add .
git commit -m "Update to specification v2.7 (2026-06-01)"
git push
```

---

## 📁 Files Explained

### ✅ Files YOU Edit (Manual)

| File | Purpose | When to Edit |
|------|---------|--------------|
| `VERSION.md` | Track spec version | Every update |
| `CHANGELOG.md` | Document changes | Every update |
| `source/*.pdf` | Store original PDFs | Every update |

### ❌ Files AI Edits (Auto-Generated)

| Directory | Contents | Edit Manually? |
|-----------|----------|----------------|
| `docs/*.md` | Documentation | ❌ NO |
| `docs/diagrams/*.mermaid` | Flow diagrams | ❌ NO |
| `code-examples/*.xml` | XML examples | ❌ NO |

**Rule:** If a file is in `docs/` or `code-examples/`, do NOT edit it manually. Regenerate from PDF instead.

---

## 🎯 Quick Reference Commands

### Check Current Version
```bash
grep "Specification Version" VERSION.md
```

### Backup Before Update
```bash
cp -r docs backup-spec-$(date +%Y%m%d)
cp -r code-examples backup-spec-$(date +%Y%m%d)
```

### Validate Mermaid Files
```bash
for f in docs/diagrams/*.mermaid; do
    echo "Checking: $f"
    cat "$f" | head -5
done
```

### Validate XML Files
```bash
for f in code-examples/*.xml; do
    echo "Validating: $f"
    xmllint --noout "$f" 2>&1 || echo "ERROR in $f"
done
```

### Count Files
```bash
echo "Markdown files: $(find docs -name "*.md" | wc -l)"
echo "Diagrams: $(find docs/diagrams -name "*.mermaid" | wc -l)"
echo "Code examples: $(find code-examples -name "*.xml" | wc -l)"
```

---

## ⚠️ Common Mistakes

### ❌ Don't: Edit Generated Files

**Wrong:**
```bash
vim docs/03-registration-authentication.md
# Make manual edits
```

**Right:**
```bash
# Update the source PDF
# Regenerate documentation from PDF
# Only edit VERSION.md and CHANGELOG.md manually
```

### ❌ Don't: Mix Versions

**Wrong:**
```bash
# Keep old v2.6 files alongside new v2.7 files
# Result: Confusion about which is current
```

**Right:**
```bash
# Replace all generated files with new version
# Keep old version in backup/ or git history
```

### ❌ Don't: Skip Verification

**Wrong:**
```bash
# Generate and commit without checking
git add .
git commit -m "Update docs"
```

**Right:**
```bash
# Generate
# Verify: Check links, diagrams, examples
# Test: Render markdown, validate XML
# Then commit
```

---

## 🆘 Troubleshooting

### Problem: AI Won't Read PDF

**Solution:**
- Ensure PDF is accessible (not password protected)
- Check file path is correct
- Try copying PDF to project directory first

### Problem: Mermaid Diagrams Don't Render

**Solution:**
```bash
# Validate syntax
cat docs/diagrams/flow-authentication.mermaid | head -20
# Check for: proper flowchart keyword, node connections, styling
```

### Problem: Broken Links After Update

**Solution:**
```bash
# Find broken links
grep -r "](.*\.md)" docs/ | grep -v "exists"

# Fix by updating link references
# Most common: Change old chapter numbers to new
```

### Problem: Version Info Inconsistent

**Solution:**
```bash
# Check all files for version references
grep -r "2\.6" docs/
grep -r "2025-12-08" docs/

# Update VERSION.md first, then regenerate
```

---

## 📞 Getting Help

1. **Read** `CONVERSION-GUIDE.md` for detailed process
2. **Check** `VERSION.md` for current version info
3. **Review** `CHANGELOG.md` for change history
4. **Compare** with backup to see what changed
5. **Ask AI** to follow CONVERSION-GUIDE.md explicitly

---

## ✅ Pre-Update Checklist

Before starting an update:

- [ ] New specification PDF downloaded
- [ ] Version and date noted from filename
- [ ] Backup of current documentation created
- [ ] Sufficient disk space for backup
- [ ] Git repository clean (no uncommitted changes)
- [ ] Read relevant section of CONVERSION-GUIDE.md

---

## ✅ Post-Update Checklist

After completing an update:

- [ ] VERSION.md updated with new version
- [ ] CHANGELOG.md updated with changes
- [ ] All markdown files render correctly
- [ ] All Mermaid diagrams display
- [ ] All XML examples valid
- [ ] No broken links (tested)
- [ ] Compared with backup (reviewed changes)
- [ ] Changes committed to git
- [ ] Pushed to remote repository

---

*For detailed conversion process, see [CONVERSION-GUIDE.md](CONVERSION-GUIDE.md)*
*For version information, see [VERSION.md](VERSION.md)*
