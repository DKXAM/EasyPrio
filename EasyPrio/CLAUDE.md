# IWINButton - World of Warcraft 1.12.1 Addon

## Project Overview
A World of Warcraft vanilla (1.12.1) addon that simplifies macro creation by providing a GUI for building priority-based spell sequences. Users can drag spells into a window to create ordered priority lists, with the macro executing spells from top to bottom based on conditions (e.g., "don't cast Rend if target already has Rend debuff").

**Core Features:**
- Visual spell priority list builder
- Conditional spell casting (buff/debuff checks, cooldowns, etc.)
- Automated macro generation from spell sequences
- Easy reordering and management of spell priorities

## Reference Addons

### pfUI by Shagu
**Location:** `reference-addons/pfUI/`
**Purpose:** Complete UI replacement addon - excellent reference for 1.12.1 addon development

**Key Learning Areas:**
- **Modular Structure**: Well-organized module system in `/modules/` directory
- **API Usage**: Comprehensive vanilla API usage examples in `/api/` and `/libs/`
- **Event Handling**: Event-driven architecture throughout modules
- **Frame Management**: Advanced frame creation and management patterns
- **Configuration System**: Robust config system in `api/config.lua`
- **Compatibility**: Version handling in `/compat/` for vanilla/TBC differences
- **UI Widgets**: Custom widget implementations in `api/ui-widgets.lua`
- **Drag & Drop**: Examples of item/spell dragging in various modules
- **Spell Detection**: Buff/debuff scanning in `libs/libdebuff.lua`

**Key Files to Reference:**
- `pfUI.lua` - Main addon initialization and structure
- `api/api.lua` - Core API functions and utilities
- `api/config.lua` - Configuration management system
- `api/ui-widgets.lua` - Custom UI widget implementations
- `modules/actionbar.lua` - Action bar implementation with drag/drop
- `modules/buff.lua` - Buff frame handling and detection
- `modules/gui.lua` - GUI window creation and management
- `libs/libdebuff.lua` - Debuff detection and management
- `libs/libspell.lua` - Spell information and utilities
- `compat/vanilla.lua` - Vanilla-specific compatibility code

**Coding Patterns to Learn for EasyPrio:**
- GUI window creation and frame management
- Drag and drop spell handling
- Buff/debuff condition checking
- Spell cooldown and availability detection
- Configuration persistence for spell lists
- Event-driven spell state monitoring

## Naming Conventions

**IMPORTANT**: Do NOT use "IWB" prefixes anymore. Use descriptive names instead:
- Instead of `IWBSomething`, use descriptive names like `ImmuneTracker`, `SpellRotationHandler`, `MainConfigFrame`, etc.
- Avoid generic prefixes - use meaningful, descriptive class/module names
- The only remaining "IWB" references should be legacy code that hasn't been refactored yet

## Combat Log Events Reference

For vanilla WoW 1.12.1, combat log messages appear as chat events:
- `CHAT_MSG_SPELL_FAILED_LOCALPLAYER` - For spell failures including immune messages
- `CHAT_MSG_SPELL_SELF_DAMAGE` - For damage dealt by player spells  
- `CHAT_MSG_COMBAT_SELF_MISSES` - For player combat misses

Reference library: https://github.com/refaim/Vanilla-WoW-1.12-Addon-Development-Libraries-Archive

## Development & Testing Workflow

### Branch Strategy
- **main**: Stable, tested features
- **feature branches**: New development (e.g., `immune-detection`, `tooltip-improvements`)
- **testing**: Branch for in-game testing

### Testing Process
1. **Develop on feature branch**: Create feature branch from main for new work
2. **Commit and push to testing**: When ready to test, commit changes and push to testing branch
3. **In-game testing**: Use Turtle WoW launcher with GitHub link pointing to testing branch
4. **Avoid local folder issues**: This workflow prevents addon folder corruption that can occur when restarting WoW with local file changes
5. **Merge to main**: Once tested and stable, merge feature branch to main

### Commands for Testing
```bash
git add .
git commit -m "feat: add immune detection system"
git push origin testing
```

Then configure Turtle WoW launcher to use: `https://github.com/DKXAM/EasyPrio/tree/testing`