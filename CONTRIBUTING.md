# Contributing to Croatian Fiscalization Documentation

Thank you for your interest in contributing to the Croatian Fiscalization Technical Specification documentation!

---

## 📋 About This Documentation

This repository contains **auto-generated documentation** extracted from the official Croatian Government technical specification for the fiscalization system.

**Important:** The markdown files, Mermaid diagrams, and XML code examples are **automatically generated** from the PDF specification. They should NOT be manually edited except to fix generation errors.

---

## 🚀 How to Contribute

### Reporting Issues

If you find errors in the documentation:

1. **Check the source:** Verify the error exists in the official PDF specification
2. **Search existing issues:** Check if someone already reported it
3. **Create an issue:** Include:
   - Specification version
   - Page number (if applicable)
   - Description of the error
   - Expected vs actual content
   - Screenshot (if helpful)

### Suggesting Improvements

We welcome suggestions for:
- Better conversion process
- Improved documentation structure
- Additional automation tools
- Enhanced verification scripts

**Process:**
1. Open an issue describing your suggestion
2. Discuss with maintainers
3. Submit PR for approved changes

### Updating Documentation

When a new specification version is released:

1. **Download the new PDF** from the official source
2. **Run the update script:**
   ```bash
   ./update-documentation.sh ~/Downloads/Fiskalizacija-vX.Y-DD.MM.YYYY.pdf
   ```
3. **Follow the AI prompts** to regenerate documentation
4. **Verify changes** using the comparison script
5. **Submit a pull request** with the update

See [QUICKSTART.md](QUICKSTART.md) for detailed instructions.

---

## 📁 What You Can and Cannot Edit

### ✅ Files You CAN Edit

| File | Purpose | Example Changes |
|------|---------|-----------------|
| `VERSION.md` | Version tracking | Update version number, add history |
| `CHANGELOG.md` | Change history | Add version changelog entry |
| `CONVERSION-GUIDE.md` | Process documentation | Improve conversion instructions |
| `QUICKSTART.md` | Quick reference | Update commands, add tips |
| `CONTRIBUTING.md` | This file | Update guidelines |
| `*.sh` scripts | Automation | Fix bugs, add features |

### ❌ Files You CANNOT Edit (Auto-Generated)

| Directory | Contents | What To Do Instead |
|-----------|----------|-------------------|
| `docs/*.md` | Documentation | Regenerate from PDF |
| `docs/diagrams/*.mermaid` | Flow diagrams | Regenerate from PDF |
| `code-examples/*.xml` | XML examples | Regenerate from PDF |

**If you find errors in auto-generated files:**

1. **Verify the error** is in the source PDF
2. **Report an issue** with page number and details
3. **Do NOT manually fix** - it will be overwritten in next update
4. **Exception:** You can fix obvious conversion bugs (typos from OCR, formatting issues)

---

## 🔧 Development Setup

### Prerequisites

- Git
- Bash shell (for scripts)
- AI assistant with PDF reading capability (for updates)
- Markdown renderer (for testing)
- Mermaid diagram support (for viewing diagrams)

### Repository Structure

```
.
├── VERSION.md                    # Version tracking (EDITABLE)
├── CONVERSION-GUIDE.md           # Conversion process (EDITABLE)
├── CHANGELOG.md                  # Change history (EDITABLE)
├── QUICKSTART.md                 # Quick reference (EDITABLE)
├── CONTRIBUTING.md               # This file (EDITABLE)
├── README-REPOSITORY.md          # Repository summary (EDITABLE)
├── LICENSE.md                    # License & disclaimer (EDITABLE)
├── update-documentation.sh       # Update script (EDITABLE)
├── compare-versions.sh           # Compare script (EDITABLE)
├── README.md                     # Main entry point (EDITABLE)
├── docs/                         # Auto-generated (DO NOT EDIT)
│   ├── 00-document-overview.md
│   ├── 01-02-introduction-and-solution.md
│   ├── 03-registration-authentication.md
│   ├── 04-electronic-signature.md
│   ├── 05-services-overview.md
│   ├── 06-11-services-detailed.md
│   ├── 12-message-examples.md
│   └── diagrams/
│       └── *.mermaid
└── code-examples/                # Auto-generated (DO NOT EDIT)
    └── *.xml
```

---

## 🧪 Testing Your Changes

### For Script Changes

If you modify `update-documentation.sh` or `compare-versions.sh`:

1. **Test on backup:**
   ```bash
   ./update-documentation.sh test-pdf.pdf
   ./compare-versions.sh backup-20250121/ .
   ```

2. **Check error handling:**
   - Test with missing arguments
   - Test with non-existent files
   - Test with invalid PDFs

3. **Verify output:**
   - Scripts should exit with proper error codes
   - Messages should be clear and helpful
   - Backup should be created successfully

### For Documentation Changes

If you improve `CONVERSION-GUIDE.md` or other guides:

1. **Follow your own instructions:**
   - Can you perform the task using only your guide?
   - Are any steps unclear or missing?

2. **Test with AI assistant:**
   - Give the AI your guide
   - Does it produce correct results?

3. **Get feedback:**
   - Ask others to try your instructions
   - Incorporate their suggestions

---

## 📝 Pull Request Process

### Before Submitting

1. **Update VERSION.md** if changing version
2. **Update CHANGELOG.md** with your changes
3. **Test your changes** thoroughly
4. **Check formatting** (markdown, shell scripts)
5. **Verify links** work correctly

### Submitting PR

1. **Create branch** from `main`:
   ```bash
   git checkout -b feature/update-to-v2.7
   ```

2. **Make your changes** following guidelines above

3. **Commit with clear message:**
   ```bash
   git commit -m "Update to specification v2.7 (2026-06-01)

   - Regenerated all documentation from new PDF
   - Updated VERSION.md and CHANGELOG.md
   - Verified all links and examples"
   ```

4. **Push and create PR:**
   ```bash
   git push origin feature/update-to-v2.7
   ```

5. **Fill PR template:**
   - What version are you updating from/to?
   - What changed in the specification?
   - How did you verify the conversion?
   - Any issues or concerns?

### PR Review Process

Maintainers will review your PR for:
- ✅ Correct version information
- ✅ Complete documentation (no missing files)
- ✅ Valid Mermaid diagrams
- ✅ Well-formed XML examples
- ✅ No broken links
- ✅ Consistent formatting

---

## 🎯 Priority Areas for Contribution

We especially welcome help with:

1. **Automation improvements**
   - Better update scripts
   - Automated testing
     - Link validation
     - XML validation
     - Mermaid syntax checking

2. **Documentation quality**
   - Better conversion guide
   - More examples
   - Language translations

3. **Tools and utilities**
   - Version comparison tools
   - Validation scripts
   - Format converters

4. **Testing infrastructure**
   - CI/CD pipelines
   - Automated testing
   - Deployment scripts

---

## 🤖 AI-Assisted Contributions

This documentation is designed to work well with AI assistants. When using AI:

**For updates:**
> "Convert the PDF at [path] following CONVERSION-GUIDE.md"

**For verification:**
> "Check all links in docs/ directory"
> "Validate all XML files in code-examples/"
> "Verify Mermaid syntax in docs/diagrams/"

**For improvements:**
> "Suggest improvements to CONVERSION-GUIDE.md based on latest conversion"

---

## 📜 License

By contributing, you agree that your contributions will be licensed under the same license as the project (see LICENSE file).

---

## 🙏 Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md file
- Release notes for their contributions
- Project documentation

---

## 📧 Contact

For questions:
- Open an issue for bugs or feature requests
- Start a discussion for general questions
- Check existing issues first

---

**Thank you for contributing!** 🎉

Every contribution helps make this documentation more useful for developers working with the Croatian fiscalization system.
