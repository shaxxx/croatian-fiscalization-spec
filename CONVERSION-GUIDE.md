# PDF to Markdown Conversion Guide

**Purpose:** Convert the Croatian Fiscalization Technical Specification PDF to maintainable markdown documentation.

**Last Updated:** 2025-01-21
**For Specification Version:** 2.6 (2025-12-08)

---

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Conversion Process](#conversion-process)
4. [Content Standards](#content-standards)
5. [Quality Checklist](#quality-checklist)
6. [Automated Conversion Prompt](#automated-conversion-prompt)
7. [Troubleshooting](#troubleshooting)

---

## Overview

This guide describes the **exact, repeatable process** for converting the Croatian Fiscalization Technical Specification PDF into comprehensive markdown documentation.

### What Gets Extracted

- ✅ All chapter content (6 chapters)
- ✅ XML code examples (57 examples from Chapter 9)
- ✅ Flow diagrams (9 diagrams → Mermaid)
- ❌ XML schema visualizations (ignored per requirements)

### Output Structure

```
technical-specification/
├── VERSION.md                           # Version tracking
├── CONVERSION-GUIDE.md                  # This file
├── CHANGELOG.md                         # Document changes history
├── QUICKSTART.md                        # Quick reference
├── CONTRIBUTING.md                      # Contribution guidelines
├── update-documentation.sh                # Automation script
├── compare-versions.sh                   # Comparison tool
├── docs/                                # Documentation files
│   ├── 00-document-overview.md          # Statistics and inventory
│   ├── 01-02-introduction-and-solution.md
│   ├── 03-registration-authentication.md
│   ├── 04-electronic-signature.md
│   ├── 05-services-overview.md
│   ├── 06-11-services-detailed.md
│   ├── 12-message-examples.md
│   └── diagrams/                        # Mermaid flow diagrams
│       ├── flow-authentication.mermaid
│       ├── flow-certificate-chain.mermaid
│       ├── flow-certificate-validation.mermaid
│       ├── flow-fiskalizacija-racuna.mermaid
│       ├── flow-promjena-placanja.mermaid
│       ├── flow-response-structure.mermaid
│       ├── flow-signature-creation.mermaid
│       ├── flow-signature-soap.mermaid
│       └── flow-signature-verification.mermaid
└── code-examples/                       # 57 XML examples from Chapter 9
    ├── racun-*.xml                        # Invoice examples (9.1-9.6, 9.31-9.37, 9.38-9.41)
    ├── promjena-nacina-placanja-*.xml      # Payment change examples (9.7-9.14)
    ├── prodaja-samoposluzni-*.xml         # Self-service examples (9.15-9.20)
    ├── napojnica-*.xml                    # Tip/gratuity examples (9.21-9.28)
    ├── echo-metoda-*.xml                  # Echo method examples (9.29-9.30)
    └── radnog-vremena-*.xml               # Working hours examples (9.42-9.57)
```

---

---

## Prerequisites

### Required Tools

- AI Assistant with PDF reading capability (Claude Code, etc.)
- File system read/write access
- Markdown rendering support (for verification)
- Mermaid diagram support (for visualization)

### Source Files

- Original PDF: `Fiskalizacija - Tehnicka specifikacija za korisnike_vX.Y (DD.MM.YYYY.).pdf`
- Specification version and date from filename

---

## Conversion Process

### Step 1: Document Analysis

**Objective:** Understand the document structure and create an inventory.

**Actions:**

1. **Read the PDF** using Read tool
2. **Extract metadata:**
   - Total page count
   - Specification version (from filename)
   - Specification date (from filename)
   - Language (Croatian)

3. **Analyze Table of Contents:**
   - List all chapters with page ranges
   - Identify chapter titles
   - Note subsection structure

4. **Inventory all images:**
   - Count total images
   - Categorize by type:
     - **Code Examples:** XML snippets (extract as-is)
     - **Flow Diagrams:** Process flows (convert to Mermaid)
     - **Schema Visualizations:** XML schema hierarchy (ignore)

5. **Create document overview:**
   ```markdown
   ## Document Statistics
   - Total Pages: [N]
   - Total Chapters: [N]
   - Code Examples: [N]
   - Flow Diagrams: [N]
   - Schema Visualizations: [N] (ignored)
   ```

**Output:** Update `VERSION.md` with new version info.

---

### Step 2: Directory Structure Setup

**Objective:** Create the required directory structure.

**Commands:**

```bash
mkdir -p docs/diagrams
mkdir -p code-examples
```

**Expected Structure:**

```
technical-specification/
├── docs/
│   ├── diagrams/
└── code-examples/
```

---

### Step 3: Extract Code Examples from Chapter 9

**Objective:** Extract all XML code examples from Chapter 9 (pages 115-207) AS-IS with no conversions or optimizations.

**CRITICAL REQUIREMENTS:**
- ⚠️ Copy examples EXACTLY as they appear in the PDF
- ⚠️ NO character encoding conversions (keep Croatian characters: č, ć, š, ž, đ)
- ⚠️ NO formatting changes or prettification
- ⚠️ NO refactoring or optimization
- ⚠️ Preserve ALL original line breaks and spacing
- ⚠️ These are REFERENCE EXAMPLES from official specification

---

### 3.1 Locate Chapter 9 Examples

**Location:** Pages 115-207 of Technical Specification v2.6

**Structure:**
- Chapter 9 contains 57 complete XML message examples
- Each example is numbered: 9.1, 9.2, 9.3, ... 9.57
- Examples are in sequential order

**Example Numbering System:**
- `9.1` = First example in Chapter 9
- `9.2` = Second example in Chapter 9
- `9.57` = Fifty-seventh (last) example in Chapter 9
- The number after the dot (.) indicates the sequence within Chapter 9

---

### 3.2 Extraction Process - Step by Step

#### Phase 1: Extract All Examples to Single File

1. **Read the PDF** pages 115-207 (Chapter 9)
2. **Extract ALL text** containing XML examples to a single temporary file
3. **DO NOT** try to identify individual examples yet
4. **DO NOT** clean or modify content during extraction

#### Phase 2: Locate Example Boundaries

Each example starts with a **title/heading line** in Croatian, followed by XML content.

**How to identify example start:**
1. Look for lines like: `9.1`, `9.2`, `9.3`, etc.
2. The title is on the same or next line after the number
3. Title format: `9.X [Croatian description]`
4. Examples contain XML with `<soap:Envelope>` or `<soapenv:Envelope>`

**Example titles (for reference):**
- `9.1` - Račun - izvorni oblik - zahtjev
- `9.2` - Račun - s elektroničkim potpisom - zahtjev
- `9.3` - Račun - izvorni oblik - odgovor
- ...and so on through 9.57

#### Phase 3: Process Each Example

For each example found:

**Step 3.1: Extract XML Content**

1. Find the opening SOAP element:
   - `<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">` OR
   - `<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">`

2. Find the closing SOAP element:
   - `</soap:Envelope>` OR
   - `</soapenv:Envelope>`
   - NOTE: May have trailing space like `</soapenv:Envelope >`

3. Extract EVERYTHING from opening to closing tag (inclusive)

**Step 3.2: Clean the XML**

Apply these cleaning steps IN ORDER:

1. **Remove page markers** (if present):
   - Lines containing: `--- PAGE XXX ---`
   - Lines containing: `Stranica XXX od XXX`
   - Use regex or string replacement

2. **Remove empty/whitespace-only lines**:
   - Lines that contain only spaces, tabs, or are empty
   - Keep lines with XML content even if just a tag

3. **Trim leading whitespace from each line**:
   - Remove spaces/tabs at the START of each line
   - Do NOT remove trailing spaces (they might be intentional)
   - Do NOT remove spaces between XML elements and text content

4. **Trim spaces in element names ONLY**:
   - Inside opening tags: `< Racun >` → `<Racun>`
   - Inside closing tags: `</Racun >` → `</Racun>`
   - DO NOT trim spaces in element VALUES or attributes
   - Use regex pattern: `<\s*(/\s*)([^\s>]+)(\s*)>` → `<\1\2>`

**Step 3.3: Handle XML Declaration**

If `<?xml version="1.0" encoding="UTF-8"?>` is present:
- Keep it at the very top of the file
- If multiple examples have it, each file gets its own
- If NOT present in the example, DO NOT add it

**Step 3.4: Remove Non-XML Lines**

Remove lines that are NOT part of the XML structure:
- Title/description lines BEFORE the XML starts
- Explanatory text AFTER the XML ends
- Page numbers, section headers
- Keep ONLY the SOAP envelope and its contents

#### Phase 4: Generate Filename

**Filename Pattern:**
```
{croatian-description}-{example-number}-{direction}.xml
```

**Components:**

1. **{croatian-description}:** Extract from example title
   - Convert to lowercase
   - Replace spaces with hyphens
   - Keep Croatian characters (č, ć, š, ž, đ)
   - Examples:
     - "Račun - izvorni oblik" → `racun-izvorni-oblik`
     - "Promjena načina plaćanja" → `promjena-nacina-placanja`
     - "Napojnica" → `napojnica`

2. **{example-number}:** The number from 9.X
   - Extract the number after the dot
   - Examples: `91`, `92`, `93`, ... `957`

3. **{direction}:** From the title
   - `zahtjev` = Request
   - `odgovor` = Response
   - This is ALWAYS in the title

**Filename Examples:**
- Example 9.1 (Račun - izvorni oblik - zahtjev) → `racun-izvorni-oblik-91-zahtjev.xml`
- Example 9.2 (Račun - s elektroničkim potpisom - zahtjev) → `racun-s-elektronickim-potpisom-92-zahtjev.xml`
- Example 9.3 (Račun - izvorni oblik - odgovor) → `racun-izvorni-oblik-93-odgovor.xml`

**Special Cases:**
- If example title contains "Greška" (error), include it in filename
- Multiple examples with same base description: number makes them unique

#### Phase 5: Write Individual Files

1. Create file in `code-examples/` directory
2. Write the cleaned XML content
3. NO additional comments or headers
4. Content should start with XML declaration (if present) or SOAP envelope

---

### 3.3 Example Categories Reference

| Category | Example Range | Description |
|----------|---------------|-------------|
| Invoice (Racun) | 9.1-9.6, 9.31-9.37, 9.38-9.41 | Invoice fiscalization, check, change |
| Payment Change (Promjena načina plaćanja) | 9.7-9.14 | Payment method change operations |
| Self-Service (Prodaja samoposlužnih uređaja) | 9.15-9.20 | Self-service device sales |
| Tip/Gratuity (Napojnica) | 9.21-9.28 | Tip/gratuity fiscalization |
| Echo Method | 9.29-9.30 | Test/echo operations |
| Working Hours (Radno vrijeme) | 9.42-9.57 | Working hours operations |

---

### 3.4 Validation Checklist

After extracting all examples, verify:

- [ ] Total of 57 XML files created
- [ ] All filenames end with `-zahtjev.xml` or `-odgovor.xml`
- [ ] Each file contains valid XML (well-formed)
- [ ] SOAP envelope structure is intact
- [ ] Croatian characters are preserved (č, ć, š, ž, đ)
- [ ] No page markers or section headers in files
- [ ] XML declaration present if it was in original example
- [ ] Element names have no leading/trailing spaces
- [ ] No empty lines at start or end of files
- [ ] Examples are numbered 9.1 through 9.57 in sequence

---

### 3.5 Common Pitfalls to Avoid

❌ **WRONG:**
- Converting Croatian characters to ASCII (č → c, ć → c)
- Adding or removing line breaks
- Pretty-printing or indenting XML
- Adding comments or headers to files
- Removing trailing spaces in attribute values
- Changing element name casing
- Merging multiple examples into one file
- Splitting one example across multiple files

✅ **CORRECT:**
- Copy character-for-character from PDF
- Preserve original line structure
- Keep Croatian characters exactly as shown
- One example = one file
- Clean only page markers and truly empty lines
- Trim element name spaces ONLY
- Use exact Croatian text from title for filename

---

### 3.6 Automated Processing Script (Optional)

If using Python or similar:

```python
import re

def clean_example_content(raw_xml):
    """Clean raw XML example content."""
    lines = raw_xml.split('\n')
    cleaned = []

    for line in lines:
        # Remove page markers
        if 'PAGE' in line or 'Stranica' in line:
            continue

        # Skip empty/whitespace-only lines
        if not line.strip():
            continue

        # Trim leading whitespace
        line = line.lstrip()

        # Trim spaces in element names only
        line = re.sub(r'<(\s*/?\s*)([^\s>]+)(\s*)>', r'<\1\2>', line)

        cleaned.append(line)

    return '\n'.join(cleaned)

def extract_examples_from_chapter9(pdf_text):
    """Extract all examples from Chapter 9 text."""
    # Find all example boundaries using regex
    # Process each example according to steps above
    # Generate filenames from titles
    # Write individual files
    pass
```

**Output:** 57 XML files in `code-examples/` directory.

---

### Step 4: Convert Flow Diagrams

**Objective:** Convert all flow diagrams to Mermaid format.

**Process:**

For each flow diagram image in the PDF:

1. **Analyze the diagram:**
   - Identify all nodes (rectangles, diamonds, etc.)
   - Trace all connections/arrows
   - Note decision points
   - Identify success/error paths

2. **Convert to Mermaid syntax:**
   ```mermaid
   flowchart TD
       A[Start] --> B[Process]
       B --> C{Decision?}
       C -->|Yes| D[Success]
       C -->|No| E[Error]

       style D fill:#e1f5e1
       style E fill:#f5e1e1
   ```

3. **Apply consistent styling:**
   - **Green (#e1f5e1):** Success, terminal, completion nodes
   - **Red (#f5e1e1):** Error, failure, rejection nodes
   - **Yellow (#fff4e1):** Decision, processing, intermediate nodes

4. **Create Mermaid file:**
   - Name: `flow-{process-name}.mermaid`
   - Add comment header with source page
   - Use descriptive node labels

**Flow Diagrams to Convert:**

| # | Page | Description | Filename |
|---|------|-------------|----------|
| 1 | 13 | Invoice fiscalization flow | `flow-fiskalizacija-racuna.mermaid` |
| 2 | 14 | Payment method change flow | `flow-promjena-placanja.mermaid` |
| 3 | 28 | Response structure handling | `flow-response-structure.mermaid` |
| 4 | 44 | Authentication flow | `flow-authentication.mermaid` |
| 5 | 50 | Signature verification | `flow-signature-verification.mermaid` |
| 6 | 51 | Digital signature creation | `flow-signature-creation.mermaid` |
| 7 | 52 | Certificate validation | `flow-certificate-validation.mermaid` |
| 8 | 53 | Certificate chain validation | `flow-certificate-chain.mermaid` |
| 9 | 54 | Signature in SOAP message | `flow-signature-soap.mermaid` |

**Output:** 9 Mermaid files in `docs/diagrams/`.

---

### Step 5: Create Markdown Documentation

**Objective:** Create comprehensive markdown documentation for each chapter.

**Documentation Files:**

#### 5.1 `00-document-overview.md`
- Document statistics
- Table of contents
- Image inventory
- Key concepts (JIR, ZKI, CIS, FINA)
- Document structure
- Related resources

#### 5.2 `01-02-introduction-and-solution.md`
- Chapter 1: Introduction
- Chapter 2: Solution Description
- System architecture
- Fiscalization workflow
- Time synchronization
- Message structure
- Response structure

#### 5.3 `03-registration-authentication.md`
- Chapter 3: Registration and Authentication
- FINA system overview
- Registration process
- Certificate management
- Authentication process
- Certificate renewal
- Security best practices

#### 5.4 `04-electronic-signature.md`
- Chapter 4: Electronic Signature
- XML Signature standard
- Signature creation process
- Signature validation
- Certificate requirements
- Certificate chain validation
- Signature placement in SOAP

#### 5.5 `05-services-overview.md`
- All services overview
- Common request/response format
- Service endpoints
- SOAP actions
- Common error codes
- Time requirements
- Rate limiting

#### 5.6 `06-11-services-detailed.md`
- Service 5.1: Business Space
- Service 5.2: Invoice Fiscalization
- Service 5.3: Payment Method Change
- Service 5.4: ISSN
- Service 5.5: Invoice Report
- Service 5.6: Working Hours

For each service:
- Purpose
- Use cases
- Request structure (XML example)
- Key elements table
- Response structure
- Important notes

#### 5.7 `12-message-examples.md`
- Chapter 6: Message Examples
- Complete SOAP request/response examples for:
  - Business space registration
  - Invoice fiscalization
  - Payment method change
  - ISSN fiscalization
  - Invoice report
  - Working hours
- Error response examples
- SOAP fault examples

**Markdown Formatting Standards:**

```markdown
# Document Title

**Source:** Pages [N]-[N] of Technical Specification v[X.Y]

---

## Main Section

### Subsection

| Element | Type | Required | Description |
|---------|------|----------|-------------|

```xml
<!-- Code example -->
```

**Flow Diagram:**

![Description](diagrams/filename.mermaid)

**Related:**
- [Link to related doc](other-file.md)
```

**Output:** 8 markdown files in `docs/`.

---

### Step 6: Create Supporting Documentation

#### 6.1 `README.md` (Main Entry)

**Purpose:** Quick start guide and navigation.

**Contents:**
- Project description
- Quick start guide
- Directory structure
- Key concepts
- Documentation files table
- Flow diagrams table
- Code examples table
- Implementation guide
- Critical requirements
- Common errors
- Related resources
- AI context section

#### 6.2 `CHANGELOG.md`

**Purpose:** Track changes between specification versions.

**Format:**

```markdown
# Changelog

## [2.6] - 2025-12-08

### Added
- Initial documentation extraction from v2.6 specification
- All 6 chapters documented
- 8 XML code examples
- 9 Mermaid flow diagrams

### Changed
- N/A (initial version)

### Fixed
- N/A (initial version)
```

#### 6.3 `QUICKSTART.md`

**Purpose:** Quick reference for updating documentation.

**Contents:**
- One-command update instructions
- Manual steps checklist
- Files to touch vs auto-generated
- Verification checklist

---

## Content Standards

### Naming Conventions

- **Files:** kebab-case (e.g., `registration-authentication.md`)
- **Diagrams:** `flow-{service-name}.mermaid`
- **Code Examples:** `{croatian-description}-{number}-{direction}.xml`
  - Example: `racun-s-elektronickim-potpisom-92-zahtjev.xml`
  - Direction suffix: `-zahtjev` (request) or `-odgovor` (response)
- **Directories:** lowercase, hyphen-separated

### Markdown Standards

1. **Headers:**
   - H1: Document title (file name, once)
   - H2: Main sections
   - H3: Subsections
   - H4: Details (rare)

2. **Tables:**
   - Use for structured data
   - Include header row
   - Align columns appropriately

3. **Code Blocks:**
   - Specify language: ```xml, ```csharp, ```bash
   - Include comments for clarity

4. **Links:**
   - Use relative paths for internal links
   - Use full URLs for external resources
   - Test all links

5. **Emphasis:**
   - **Bold** for key terms, required elements
   - `Code` for technical terms, element names
   - ⚠️ for warnings
   - ✅ for completed items
   - ❌ for ignored/invalid items

### Language Guidelines

1. **Keep Croatian Terms:**
   - Organization names: FINA, PU, CIS
   - Technical terms: JIR, ZKI, OIB
   - Document titles: Keep Croatian, add English translation in parentheses

2. **Code Examples:**
   - Preserve Croatian comments
   - Keep original element names
   - No translation or localization

3. **Explanatory Text:**
   - Write in English (primary language of documentation)
   - Include Croatian terms in parentheses where helpful

---

## Quality Checklist

Before finalizing the documentation:

### Content Completeness

- [ ] All 6 chapters covered
- [ ] All code examples extracted (57 XML files from Chapter 9)
- [ ] All flow diagrams converted (9 Mermaid files)
- [ ] Schema visualizations intentionally ignored
- [ ] Version information updated in VERSION.md
- [ ] CHANGELOG.md updated

### Documentation Quality

- [ ] All markdown files have proper headers
- [ ] Source page numbers included
- [ ] Tables properly formatted
- [ ] Code blocks have language specified
- [ ] Internal links work correctly
- [ ] External links are valid

### Diagram Quality

- [ ] All Mermaid files are valid syntax
- [ ] Flow diagrams accurately represent original
- [ ] Nodes are consistently styled
- [ ] Decision points are clear
- [ ] Success/error paths are distinguished

### Code Examples

- [ ] XML files are well-formed
- [ ] Original formatting preserved
- [ ] Croatian comments retained
- [ ] No refactoring or optimization
- [ ] Source page reference included

### Validation

- [ ] All markdown files render correctly
- [ ] All Mermaid diagrams display
- [ ] All XML examples are valid
- [ ] No broken internal links
- [ ] No broken external links
- [ ] Version info consistent across files

---

## Automated Conversion Prompt

For AI assistants, use this prompt to regenerate documentation:

```
Convert the Croatian Fiscalization Technical Specification PDF at
[PATH_TO_PDF] to markdown documentation following the process in
CONVERSION-GUIDE.md.

Requirements:
1. Read the PDF and extract version/date from filename
2. Update VERSION.md with new version information
3. Follow the exact process in CONVERSION-GUIDE.md
4. Extract all code examples AS-IS (no optimization)
5. Convert all flow diagrams to Mermaid format
6. Create comprehensive markdown documentation for each chapter
7. Use the established naming conventions and formatting standards
8. Update CHANGELOG.md with version details
9. Ignore XML schema visualizations (as per requirements)

Source PDF: [PATH_TO_PDF]
Output Directory: [PATH_TO_DOCS]
```

---

## Troubleshooting

### Common Issues

**Issue: PDF contains text in images**

Solution: The PDF has been OCR'd. Use Read tool which handles both text and image layers.

**Issue: Cannot determine specification version**

Solution: Extract from filename: `Fiskalizacija - Tehnicka specifikacija za korisnike_vX.Y (DD.MM.YYYY.).pdf`

**Issue: Mermaid diagram not rendering**

Solution: Check syntax:
- Node labels: Use `[square brackets]` for text
- Styling: Must come after node definitions
- Connections: Use `-->` or `->`

**Issue: Broken internal links**

Solution: Use relative paths:
- Bad: `/full/path/to/file.md`
- Good: `../other-file.md` or `file.md`

**Issue: XML examples don't match specification**

Solution: You may have optimized or refactored. Re-extract AS-IS from PDF without changes.

### Getting Help

1. Check this guide for the correct process
2. Compare with existing documentation structure
3. Validate Mermaid syntax at https://mermaid.live
4. Test XML examples in a validator

---

## Version History

| Guide Version | Date | Changes |
|--------------|------|---------|
| 1.0 | 2025-01-21 | Initial guide created for specification v2.6 |

---

*This guide should be updated if the conversion process changes or improvements are made.*
