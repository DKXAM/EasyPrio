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

**Coding Patterns to Learn for IWINButton:**
- GUI window creation and frame management
- Drag and drop spell handling
- Buff/debuff condition checking
- Spell cooldown and availability detection
- Configuration persistence for spell lists
- Event-driven spell state monitoring