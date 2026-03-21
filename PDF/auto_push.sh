#!/bin/bash
cd /Users/andrea/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/PDF || exit

# Stage all PDFs
git add *.pdf

# Commit only if there are changes
git diff --cached --quiet || git commit -m "Auto update PDFs on $(date)"

# Push to GitHub
git push origin main
