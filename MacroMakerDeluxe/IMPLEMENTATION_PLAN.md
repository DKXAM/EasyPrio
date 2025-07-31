# Macro Maker Deluxe - Implementation Plan

## Project Overview

**Addon Name:** MacroMakerDeluxe  
**Command:** `/mmd` (Macro Maker Deluxe)  
**Execution:** `/mmd run` or macro with `/script MMD:Execute()`

## Technical Architecture

### Directory Structure
```
MacroMakerDeluxe/
├── MacroMakerDeluxe.toc              # Addon metadata and load order
├── MacroMakerDeluxe.lua              # Main addon initialization
├── Core/
│   ├── SpellDiscovery.lua            # Dynamic spell scanning system
│   ├── ConditionSystem.lua           # Universal condition evaluators  
│   ├── ExecutionEngine.lua           # Priority-based spell execution
│   └── Utils.lua                     # Helper functions and utilities
├── GUI/
│   ├── MainFrame.lua                 # Main interface window
│   ├── SpellSelector.lua             # Spell browsing and selection
│   ├── ConditionBuilder.lua          # Visual condition configuration
│   ├── PriorityList.lua              # Drag-and-drop priority management
│   └── Templates/
│       ├── SpellButton.lua           # Reusable spell icon buttons
│       ├── ConditionRow.lua          # Condition configuration UI
│       └── UITemplates.lua           # Common UI components
├── Data/
│   ├── PlayerConfig.lua              # Configuration persistence
│   ├── Presets.lua                   # Community preset templates
│   └── Migration.lua                 # Config version migration
└── Localization/
    ├── enUS.lua                      # English text strings
    └── (future language support)
```

## Implementation Phases

### Phase 1: Core Foundation (Priority: Critical)
**Goal:** Basic functionality working end-to-end

#### 1.1 Dynamic Spell Discovery System
```lua
-- SpellDiscovery.lua
MMD.SpellDiscovery = {
    ScanPlayerSpells = function()
        local spells = {}
        for i = 1, GetNumSpellTabs() do
            local name, texture, offset, numSpells = GetSpellTabInfo(i)
            for j = offset + 1, offset + numSpells do
                local spellName, spellRank = GetSpellName(j, BOOKTYPE_SPELL)
                if spellName then
                    spells[spellName] = {
                        id = j,
                        rank = spellRank,
                        texture = GetSpellTexture(j, BOOKTYPE_SPELL),
                        -- Dynamic properties - no hardcoding
                    }
                end
            end
        end
        return spells
    end,
    
    GetSpellInfo = function(spellName)
        -- Return all available information about a spell
        -- Mana cost, cast time, range, etc.
    end,
    
    RefreshSpellData = function()
        -- Update spell information when spells change
        -- Handles learning new spells, ranking up, etc.
    end
}
```

#### 1.2 Universal Condition System
```lua
-- ConditionSystem.lua
MMD.Conditions = {
    -- Resource conditions (mana, rage, energy)
    resource_min = function(spell, minValue)
        local current = UnitMana("player")
        return current >= (minValue or 0)
    end,
    
    resource_max = function(spell, maxValue)
        local current = UnitMana("player")  
        return current <= (maxValue or 9999)
    end,
    
    -- Buff conditions
    buff_missing = function(spell, buffName, target)
        target = target or "player"
        buffName = buffName or spell.name
        return not MMD.Utils:FindBuff(buffName, target)
    end,
    
    buff_present = function(spell, buffName, target)
        target = target or "player"
        buffName = buffName or spell.name
        return MMD.Utils:FindBuff(buffName, target)
    end,
    
    -- Debuff conditions  
    debuff_missing = function(spell, debuffName, target)
        target = target or "target"
        debuffName = debuffName or spell.name
        return not MMD.Utils:FindDebuff(debuffName, target)
    end,
    
    debuff_present = function(spell, debuffName, target)
        target = target or "target"
        debuffName = debuffName or spell.name
        return MMD.Utils:FindDebuff(debuffName, target)
    end,
    
    -- Health conditions
    target_health_min = function(spell, minPercent)
        local hp = UnitHealth("target")
        local maxhp = UnitHealthMax("target")
        local percent = (maxhp > 0) and (hp / maxhp * 100) or 0
        return percent >= (minPercent or 0)
    end,
    
    target_health_max = function(spell, maxPercent)
        local hp = UnitHealth("target")
        local maxhp = UnitHealthMax("target")  
        local percent = (maxhp > 0) and (hp / maxhp * 100) or 100
        return percent <= (maxPercent or 100)
    end,
    
    -- Combat conditions
    cooldown_ready = function(spell)
        local spellId = MMD.SpellDiscovery:GetSpellId(spell.name, spell.rank)
        return spellId and GetSpellCooldown(spellId, "spell") == 0
    end,
    
    in_range = function(spell, target)
        target = target or "target"
        -- Use spell's inherent range checking
        local spellId = MMD.SpellDiscovery:GetSpellId(spell.name, spell.rank)
        return spellId and IsActionInRange(spellId) ~= 0
    end,
    
    -- Advanced conditions for Phase 2+
    swing_timer_ready = function(spell)
        -- Integration with swing timer addons if available
        return true -- Placeholder
    end,
    
    mouseover_target = function(spell)
        return UnitExists("mouseover") and UnitCanAttack("player", "mouseover")
    end
}
```

#### 1.3 Basic Execution Engine
```lua
-- ExecutionEngine.lua
MMD.Engine = {
    Execute = function()
        local config = MMD.PlayerConfig:GetCurrentConfig()
        if not config or not config.spells then
            MMD.UI:ShowMessage("No spell configuration found. Use /mmd to configure.")
            return
        end
        
        -- Iterate through priority list (top to bottom)
        for priority, spellConfig in ipairs(config.spells) do
            if MMD.Engine:EvaluateSpell(spellConfig) then
                if MMD.Engine:CastSpell(spellConfig) then
                    return -- Successfully cast, stop here
                end
            end
        end
        
        -- No spells were available/ready
        -- Silent failure - don't spam chat
    end,
    
    EvaluateSpell = function(spellConfig)
        -- Check all conditions for this spell
        for conditionType, conditionValue in pairs(spellConfig.conditions) do
            local conditionFunc = MMD.Conditions[conditionType]
            if conditionFunc and not conditionFunc(spellConfig, conditionValue) then
                return false -- This condition failed
            end
        end
        return true -- All conditions passed
    end,
    
    CastSpell = function(spellConfig)
        local spellId = MMD.SpellDiscovery:GetSpellId(spellConfig.name, spellConfig.rank)
        if spellId then
            CastSpell(spellId, "spell")
            return true
        end
        return false
    end
}
```

### Phase 2: GUI Framework (Priority: High)
**Goal:** Intuitive visual interface for spell configuration

#### 2.1 Main Interface Window
```lua
-- MainFrame.lua
MMD.UI.MainFrame = {
    Create = function()
        local frame = CreateFrame("Frame", "MMDMainFrame", UIParent)
        frame:SetWidth(800)
        frame:SetHeight(600)
        frame:SetPoint("CENTER")
        frame:SetMovable(true)
        frame:EnableMouse(true)
        
        -- Title bar
        local titleBar = CreateFrame("Frame", nil, frame)
        titleBar:SetHeight(30)
        titleBar:SetPoint("TOPLEFT")
        titleBar:SetPoint("TOPRIGHT")
        titleBar:SetScript("OnMouseDown", function() frame:StartMoving() end)
        titleBar:SetScript("OnMouseUp", function() frame:StopMovingOrSizing() end)
        
        -- Content areas
        local spellList = CreateFrame("Frame", nil, frame) -- Left panel
        local conditionPanel = CreateFrame("Frame", nil, frame) -- Right panel
        
        return frame
    end
}
```

#### 2.2 Spell Selection System
- Browse all known spells with icons and tooltips
- Search/filter functionality 
- Drag-and-drop to priority list
- Real-time spell availability indicators

#### 2.3 Visual Condition Builder
- Checkbox-based condition selection
- Slider/input fields for numeric values (resource amounts, health percentages)
- Dropdown for target selection (player/target/mouseover)
- Real-time condition validation with helpful error messages

### Phase 3: Advanced Features (Priority: Medium)
**Goal:** Power user features and community integration

#### 3.1 Configuration Management
```lua
-- PlayerConfig.lua
MMD.PlayerConfig = {
    Save = function(configName, spellList)
        -- Save to SavedVariables with character-specific storage
    end,
    
    Load = function(configName)
        -- Load saved configuration
    end,
    
    Export = function(configName)
        -- Generate shareable string
    end,
    
    Import = function(configString)
        -- Parse and validate imported configuration
    end
}
```

#### 3.2 Community Preset System
- Built-in preset templates for common rotations
- Easy sharing of configurations between players
- Community-contributed presets with rating/feedback
- One-click preset application with customization options

#### 3.3 Advanced Condition Types
- Combo point checking for rogues
- Stance/form detection for druids and warriors
- Party/raid member health conditions for healing
- Complex condition combinations (AND/OR logic)
- Integration with swing timer addons

## User Experience Design

### For Beginners (5-Minute Setup Goal):
1. **Install addon** - Standard addon installation
2. **Open interface** - Type `/mmd` in-game
3. **Quick setup wizard** - "Create your first rotation"
4. **Drag 3-5 spells** - From spellbook to priority list
5. **Basic conditions** - Check a few boxes (cooldown ready, in range)
6. **Create macro** - Addon generates `/mmd run` macro automatically
7. **Test rotation** - Fight training dummy or mob

### For Advanced Users:
1. **Complex conditions** - Multiple simultaneous checks per spell
2. **Resource optimization** - Fine-tuned mana/rage/energy thresholds
3. **Multiple configurations** - Different setups for PvP/PvE/dungeons/raids
4. **Sharing and importing** - Community preset integration
5. **Performance tuning** - Advanced condition timing and priorities

## Technical Implementation Details

### Event Handling
```lua
-- Efficient event-driven updates
local frame = CreateFrame("Frame")
frame:RegisterEvent("SPELLS_CHANGED")     -- Spell learning/ranking
frame:RegisterEvent("UNIT_MANA")          -- Resource changes
frame:RegisterEvent("UNIT_HEALTH")        -- Health changes  
frame:RegisterEvent("PLAYER_AURAS_CHANGED") -- Buff/debuff changes

frame:SetScript("OnEvent", function()
    if event == "SPELLS_CHANGED" then
        MMD.SpellDiscovery:RefreshSpellData()
    elseif event == "UNIT_MANA" and arg1 == "player" then
        MMD.Engine:InvalidateResourceCache()
    end
    -- Update UI and condition cache efficiently
end)
```

### Performance Optimization
- **Condition Caching** - Cache expensive API calls (buff scanning, etc.)
- **Lazy Loading** - Load spell data only when needed
- **Efficient Iteration** - Optimize priority list traversal
- **Memory Management** - Clean up unused configurations and caches

### Error Handling and Validation
- **Graceful Degradation** - Continue working even if some spells are unavailable
- **User Feedback** - Clear error messages and suggestions
- **Configuration Validation** - Detect and fix common configuration issues
- **Debug Mode** - Optional verbose logging for troubleshooting

## Success Metrics

### Technical Success Criteria:
- ✅ Works with 100% of player spells without hardcoding
- ✅ Handles new spells automatically (no addon updates needed)  
- ✅ Smooth performance with 20+ spell priority lists
- ✅ Zero configuration conflicts between characters/classes
- ✅ Compatible with all vanilla servers (Turtle WoW, etc.)

### User Experience Success Criteria:
- ✅ New users create working rotation in under 5 minutes
- ✅ Advanced users prefer it over existing solutions
- ✅ Community actively shares and rates configurations
- ✅ Positive feedback on ease of use and power
- ✅ Low support burden (intuitive design reduces questions)

## Development Timeline

| Phase | Duration | Focus | Key Deliverable |
|-------|----------|-------|-----------------|
| 1.1 | Week 1 | Spell Discovery | Working spell scanner |
| 1.2 | Week 2 | Condition System | Basic condition evaluation |
| 1.3 | Week 3 | Execution Engine | End-to-end spell casting |
| 2.1 | Week 4 | Main GUI | Interface framework |
| 2.2 | Week 5 | Spell Selection | Drag-and-drop spell management |
| 2.3 | Week 6 | Condition Builder | Visual condition configuration |
| 3.1 | Week 7 | Config Management | Save/load/share configurations |
| 3.2 | Week 8 | Community Features | Preset system and sharing |
| Polish | Week 9-10 | Testing & Refinement | Release candidate |

## Risk Mitigation

### Technical Risks:
- **Performance Issues** - Implement caching and optimization early
- **API Limitations** - Research vanilla API thoroughly, have fallback plans
- **Cross-Class Edge Cases** - Test extensively with all classes

### User Adoption Risks:
- **Learning Curve** - Prioritize intuitive design and excellent documentation
- **Migration from Existing Addons** - Provide clear comparison and migration guides
- **Community Buy-In** - Engage with WoW addon community during development

### Development Risks:
- **Scope Creep** - Stick to core functionality first, advanced features later
- **Over-Engineering** - Keep architecture simple and maintainable
- **Burnout Prevention** - Set realistic timeline with buffer time

---

*This implementation plan provides a clear roadmap for creating the world's first truly universal and scalable rotation addon for World of Warcraft.*