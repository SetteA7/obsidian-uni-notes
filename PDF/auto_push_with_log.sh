#!/bin/bash

# Check if a commit message was provided
if [ -z "$1" ]; then
    echo "Usage: ./auto_push_with_log.sh \"Your update message\""
    exit 1
fi

# Navigate to your notes folder
cd /Users/andrea/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/PDF  || exit

# Stage all PDFs
git add *.pdf

# Commit with the provided message
git commit -m "$1" || { echo "No changes to commit"; exit 0; }

# Push to GitHub
git push origin main
