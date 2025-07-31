# Macro Maker Deluxe

**Universal spell rotation addon for World of Warcraft 1.12.1 (Vanilla)**

Macro Maker Deluxe solves the fundamental scalability problem of existing rotation addons by working with ANY spell without hardcoding. Create complex priority-based rotations through a simple drag-and-drop GUI interface.

## 🌟 Key Features

- **🔮 Universal Spell Support** - Works with any spell you know, no hardcoding required
- **🎯 Priority-Based Rotations** - Execute highest priority available spell automatically  
- **🖱️ Drag & Drop Interface** - No scripting knowledge needed
- **⚡ Future-Proof** - New spells work immediately without addon updates
- **🎭 All Classes** - Same addon works for warrior, mage, rogue, priest, etc.
- **🔧 Advanced Conditions** - Resource, buffs, debuffs, health, cooldowns, range, swing timers

## 🚀 Quick Start

1. Install addon to `Interface/AddOns/MacroMakerDeluxe/`
2. Type `/mmd` in-game to open the interface
3. Drag spells from your spellbook into the priority list
4. Configure conditions for each spell (optional)
5. Create macro with `/mmd run` and place on action bar
6. Press macro to execute highest priority available spell

## 💡 The Innovation

Unlike existing rotation addons that require hardcoded spell databases, Macro Maker Deluxe uses **universal conditions** that work with any spell:

```lua
-- Instead of hardcoding every spell:
["Rend"] = {handler = DebuffHandler, target_hp = true}

-- We use universal conditions:
conditions.debuff_missing(spellName, target) -- Works with ANY debuff spell
conditions.resource_check(spellName, min, max) -- Works with ANY resource-using spell
```

This makes the addon:
- ✅ **Scalable** - No maintenance for new spells
- ✅ **Universal** - Same system for all classes  
- ✅ **Future-proof** - Works with custom server content
- ✅ **User-friendly** - Visual configuration instead of scripting

## 📋 Supported Conditions

- **Resource Management** - Minimum/maximum mana, rage, energy
- **Buff Checking** - Cast only when buff missing/present
- **Debuff Checking** - Apply debuffs when missing, avoid overwriting
- **Health Thresholds** - Target health percentage conditions
- **Cooldown Ready** - Only cast when spell is available
- **Range Checking** - Ensure target is in range
- **Swing Timer** - Coordinate with auto-attack timing
- **Mouseover Casting** - Cast on mouseover targets
- **Combat State** - In/out of combat conditions

## 🎯 Use Cases

### For Beginners
- Simple spell priority without complex macros
- Visual spell management - no scripting required
- One-click rotation setup

### For Advanced Players  
- Complex multi-condition rotations
- Resource optimization (rage, mana, energy)
- Perfect buff/debuff management
- Swing timer coordination

### For All Classes
- **Warriors** - Rage management, stance dancing, debuff application
- **Rogues** - Combo point optimization, stealth openers
- **Mages** - Mana efficiency, crowd control priorities  
- **Priests** - Healing priorities, buff management
- **And more** - Works with any class automatically

## 🛠️ Development Status

**Current Phase:** Core Foundation Development

- [x] Research and design analysis
- [ ] Dynamic spell discovery system
- [ ] Universal condition framework
- [ ] Basic GUI interface
- [ ] Priority execution engine
- [ ] Advanced condition types
- [ ] Configuration save/load
- [ ] Community preset system

## 📖 Background & Research

This addon was born from analyzing the limitations of existing solutions:

- **EasyPrio** - Good GUI but hardcoded spell definitions
- **LazyScript** - Powerful but requires spell abbreviations ("ss", "riposte")  
- **CleveroidMacros** - Advanced conditions but complex syntax

See `RESEARCH_FOUNDATION.md` for detailed analysis of why existing addons don't scale and how Macro Maker Deluxe solves these fundamental problems.

## 🤝 Contributing

We welcome contributions! The addon is designed with clean, modular architecture:

- `Core/` - Spell discovery and condition evaluation
- `GUI/` - User interface components  
- `Data/` - Configuration management

## 📄 License

MIT License - Feel free to use, modify, and distribute.

## 🎮 Compatibility  

- **Client:** World of Warcraft 1.12.1 (Vanilla)
- **Servers:** Turtle WoW, other vanilla servers
- **Dependencies:** None (pure vanilla API)
- **Conflicts:** None known

---

*Macro Maker Deluxe - Making complex rotations simple for everyone.*