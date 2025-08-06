#!/bin/bash

# Script to push web compatibility fixes
echo "Pushing web compatibility fixes..."

# Reset any merge conflicts
git reset --hard HEAD

# Add all changes
git add .

# Commit the changes
git commit -m "Fix web loading issue: Add platform-specific question loading

- Add kIsWeb checks in DatabaseService for web compatibility
- Load questions directly from assets/data/questions.json on web
- Keep SQLite for mobile with fallback to assets
- Add loading and error states to QuizProvider
- Update HomeScreen to show loading/error states with retry button
- Fix infinite loading issue on web platform"

# Force push to overcome any conflicts
git push origin main --force

echo "Changes pushed successfully!"