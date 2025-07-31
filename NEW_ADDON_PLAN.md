# Universal Spell Manager - Implementation Plan

## Addon Name: **UniversalCaster**

### Project Structure
```
UniversalCaster/
├── UniversalCaster.toc
├── UniversalCaster.lua                 # Main addon entry point
├── Core/
│   ├── SpellDiscovery.lua             # Dynamic spell scanning
│   ├── ConditionSystem.lua            # Universal condition evaluators
│   ├── ExecutionEngine.lua            # Priority-based spell execution
│   └── Utils.lua                      # Helper functions
├── GUI/
│   ├── MainFrame.lua                  # Main interface window
│   ├── SpellSelector.lua              # Spell selection interface
│   ├── ConditionBuilder.lua           # Visual condition configuration
│   ├── PriorityList.lua               # Drag-and-drop priority management
│   └── Templates/
│       ├── SpellButton.lua            # Spell icon buttons
│       ├── ConditionRow.lua           # Condition configuration rows
│       └── UITemplates.lua            # Reusable UI components
├── Data/
│   ├── PlayerConfig.lua               # Save/load player configurations
│   └── Presets.lua                    # Community preset templates
└── README.md                          # User documentation
```

## Implementation Phases

### Phase 1: Core Foundation (Week 1-2)
**Priority: Critical**

#### 1.1 Dynamic Spell Discovery
```lua
-- SpellDiscovery.lua
UniversalCaster.SpellDiscovery = {
    ScanPlayerSpells = function()
        -- Scan all spellbook tabs
        -- Extract spell names, ranks, textures, IDs
        -- No hardcoding required
    end,
    
    GetSpellInfo = function(spellName)
        -- Return dynamic spell information
        -- ID, texture, rank, mana cost, etc.
    end
}
```

#### 1.2 Universal Condition System
```lua  
-- ConditionSystem.lua
UniversalCaster.Conditions = {
    -- Core conditions that work with ANY spell
    resource_min = function(spell, value),
    resource_max = function(spell, value), 
    buff_missing = function(spell, buffName, target),
    debuff_missing = function(spell, debuffName, target),
    target_health_min = function(spell, percent),
    target_health_max = function(spell, percent),
    cooldown_ready = function(spell),
    in_range = function(spell),
    swing_timer_ready = function(spell),
    mouseover_target = function(spell)
}
```

#### 1.3 Basic Execution Engine
```lua
-- ExecutionEngine.lua  
UniversalCaster.Engine = {
    ExecuteNextSpell = function(spellList)
        -- Iterate through priority list
        -- Check all conditions for each spell
        -- Execute first spell that passes all conditions
        -- Return success/failure
    end
}
```

### Phase 2: GUI Framework (Week 3-4)
**Priority: High**

#### 2.1 Main Interface Window
- Resizable frame with tabs
- Spell list panel (left side)
- Condition configuration panel (right side)
- Priority order visualization

#### 2.2 Spell Selection System
- Browse all known spells with icons
- Search/filter functionality
- Drag-and-drop to priority list
- Real-time spell information tooltips

#### 2.3 Visual Condition Builder
- Checkbox-based condition selection
- Slider/input fields for numeric values
- Target selection dropdown (player/target/mouseover)
- Real-time condition validation

### Phase 3: Advanced Features (Week 5-6)
**Priority: Medium**

#### 3.1 Configuration Management  
- Save/load multiple spell configurations
- Export/import functionality for sharing
- Per-character configuration storage

#### 3.2 Preset Templates
- Community-contributed configurations
- Class-specific starter templates
- One-click template application

#### 3.3 Advanced Conditions
- Combo point checking
- Stance/form detection  
- Party/raid member conditions
- Complex condition combinations (AND/OR logic)

## Technical Design Decisions

### 1. No External Dependencies
- Pure vanilla WoW 1.12.1 API
- No SuperWoW or other mod requirements
- Maximum compatibility

### 2. Event-Driven Architecture
```lua
-- Efficient spell state monitoring
local frame = CreateFrame("Frame")
frame:RegisterEvent("SPELLS_CHANGED")
frame:RegisterEvent("UNIT_MANA") 
frame:RegisterEvent("UNIT_HEALTH")
-- Update conditions only when relevant events occur
```

### 3. Modular Design
- Each system is independently testable
- Clear separation of concerns
- Easy to extend with new condition types

### 4. Performance Optimization
- Condition caching to avoid repeated API calls
- Lazy loading of spell information
- Efficient priority list traversal

## User Experience Goals

### For Beginners:
1. **5-Minute Setup:** From install to working rotation
2. **No Scripting:** Pure GUI configuration
3. **Instant Feedback:** Real-time condition validation
4. **Clear Documentation:** Built-in help and tooltips

### For Advanced Users:
1. **Full Flexibility:** Any spell, any condition combination
2. **Sharing Capabilities:** Export/import configurations
3. **Performance Tuning:** Advanced condition options
4. **Extensibility:** Easy to add custom conditions

## Success Metrics

### Technical Success:
- ✅ Works with 100% of player spells (no hardcoding)
- ✅ Handles new spells without updates
- ✅ Performs well with 20+ spell priority lists
- ✅ Zero configuration conflicts between characters/classes

### User Success:
- ✅ New users create working rotation in <5 minutes
- ✅ Advanced users prefer it over existing solutions
- ✅ Community adopts and shares configurations
- ✅ Positive feedback on ease of use

## Development Timeline

| Week | Focus | Deliverable |
|------|-------|-------------|
| 1 | Core spell discovery | Working spell scanner |
| 2 | Condition system | Basic condition evaluation |
| 3 | GUI framework | Main interface window |
| 4 | Spell selection | Drag-and-drop spell management |
| 5 | Advanced conditions | Complex condition support |
| 6 | Polish & testing | Release candidate |

## Risk Mitigation

### Technical Risks:
- **Performance with large spell lists:** Implement caching and optimization
- **API limitations in vanilla:** Research alternative approaches
- **Cross-class compatibility:** Test extensively with all classes

### User Adoption Risks:
- **Learning curve:** Provide excellent documentation and tutorials
- **Migration from existing addons:** Offer import tools where possible
- **Community support:** Engage with WoW addon community early

---

*This plan provides a clear roadmap for implementing the Universal Spell Manager concept while preserving all valuable research from the EasyPrio analysis.*