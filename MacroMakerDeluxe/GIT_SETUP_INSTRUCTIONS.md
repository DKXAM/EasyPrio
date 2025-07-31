# Git Setup Instructions for MacroMakerDeluxe

## Quick Setup (Recommended)

### Step 1: Move to Parent Directory
```bash
# Copy this entire MacroMakerDeluxe folder to your parent GitHub directory
# From: C:\Users\david\Documents\GitHub\IWINButtonDKXAM\MacroMakerDeluxe
# To:   C:\Users\david\Documents\GitHub\MacroMakerDeluxe
```

### Step 2: Initialize Git Repository
```bash
cd C:\Users\david\Documents\GitHub\MacroMakerDeluxe

# Initialize new git repository
git init

# Add GitHub remote (create repository on GitHub first)
git remote add origin https://github.com/DKXAM/MacroMakerDeluxe.git
```

### Step 3: Initial Commit
```bash
# Add all files
git add .

# Create initial commit
git commit -m "feat: initialize MacroMakerDeluxe addon project

Universal spell rotation addon that solves the scalability problem of existing 
macro addons by working with ANY spell without hardcoding.

Key Features:
- Dynamic spell discovery from player's spellbook
- Universal condition system (resource, buffs, debuffs, health, etc.)
- Drag-and-drop GUI interface requiring no scripting knowledge
- Future-proof architecture - new spells work automatically
- Cross-class compatibility - same addon for all classes

Based on comprehensive research of EasyPrio, LazyScript, and CleveroidMacros
that identified fundamental limitations in existing approaches.

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push to GitHub
git push -u origin main
```

## Project Structure Overview

Your new repository will contain:

```
MacroMakerDeluxe/
├── README.md                     # Project overview and features
├── RESEARCH_FOUNDATION.md        # Analysis of existing addons and why they don't scale
├── IMPLEMENTATION_PLAN.md        # Technical roadmap and architecture
├── GIT_SETUP_INSTRUCTIONS.md     # This file
├── MacroMakerDeluxe.toc          # WoW addon metadata
├── MacroMakerDeluxe.lua          # Main addon initialization
├── Core/                         # Core systems (to be implemented)
├── GUI/                          # User interface (to be implemented)
├── Data/                         # Configuration management (to be implemented)
└── Localization/                 # Language support (to be implemented)
```

## Development Workflow

### Daily Development
```bash
# Make changes to files
# Test in-game

# Commit changes
git add .
git commit -m "feat: implement spell discovery system

- Add dynamic spellbook scanning
- Support for all spell ranks and textures
- Automatic refresh on spell changes

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"

git push
```

### Testing with Turtle WoW Launcher
1. Push changes to `main` branch
2. In Turtle WoW Launcher: Add GitHub addon
3. Use URL: `https://github.com/DKXAM/MacroMakerDeluxe`
4. Launcher will automatically update when you push changes

## Why This Approach is Better

### ✅ Clean Project Structure
- Dedicated repository for MacroMakerDeluxe
- Clear project focus and purpose
- Professional appearance for community adoption

### ✅ Preserved Research
- All analysis and ideation documented in RESEARCH_FOUNDATION.md
- Technical roadmap in IMPLEMENTATION_PLAN.md
- Future contributors understand the "why" behind decisions

### ✅ Independent Development
- Can continue using EasyPrio while developing MMD
- No conflicts between old and new approaches
- Easy to switch between projects

### ✅ Community Ready
- GitHub repository ready for community contributions
- Clear documentation for users and developers
- Easy installation via Turtle WoW Launcher

## Next Steps After Git Setup

1. **Implement Phase 1: Core Foundation**
   - Start with `Core/Utils.lua`
   - Then `Core/SpellDiscovery.lua`
   - Build and test incrementally

2. **Create Development Branch**
   ```bash
   git checkout -b development
   # Do daily development work here
   # Merge to main when features are complete
   ```

3. **Set Up Issue Tracking**
   - Use GitHub Issues for feature requests
   - Track development progress
   - Community feedback and bug reports

4. **Documentation**
   - Update README.md as features are implemented
   - Add screenshots and usage examples
   - Create user guides and tutorials

---

*This setup gives you a professional, community-ready project structure while preserving all the valuable research and analysis work.*