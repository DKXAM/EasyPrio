
-- Dynamic spell reference system
-- Loads base spells + class-specific spells based on player class

-- Initialize the main spell reference table
IWB_SPELL_REF = {}

-- Function to merge spell tables
local function MergeSpellTables(base, class)
    local merged = {}
    
    -- Add base spells first
    if base then
        for spellName, spellData in pairs(base) do
            merged[spellName] = spellData
        end
    end
    
    -- Add class spells (will override base if same name)
    if class then
        for spellName, spellData in pairs(class) do
            merged[spellName] = spellData
        end
    end
    
    return merged
end

-- Function to load appropriate class reference
local function LoadClassReference()
    local playerClass = UnitClass("player")
    local classRef = nil
    
    if playerClass == "Warrior" and IWB_WARRIOR_SPELL_REF then
        classRef = IWB_WARRIOR_SPELL_REF
    elseif playerClass == "Rogue" and IWB_ROGUE_SPELL_REF then
        classRef = IWB_ROGUE_SPELL_REF
    elseif playerClass == "Priest" and IWB_PRIEST_SPELL_REF then
        classRef = IWB_PRIEST_SPELL_REF
    elseif playerClass == "Warlock" and IWB_WARLOCK_SPELL_REF then
        classRef = IWB_WARLOCK_SPELL_REF
    elseif playerClass == "Mage" and IWB_MAGE_SPELL_REF then
        classRef = IWB_MAGE_SPELL_REF
    elseif playerClass == "Druid" and IWB_DRUID_SPELL_REF then
        classRef = IWB_DRUID_SPELL_REF
    elseif playerClass == "Shaman" and IWB_SHAMAN_SPELL_REF then
        classRef = IWB_SHAMAN_SPELL_REF
    elseif playerClass == "Hunter" and IWB_HUNTER_SPELL_REF then
        classRef = IWB_HUNTER_SPELL_REF
    elseif playerClass == "Paladin" and IWB_PALADIN_SPELL_REF then
        classRef = IWB_PALADIN_SPELL_REF
    end
    
    -- Merge base and class references
    IWB_SPELL_REF = MergeSpellTables(IWB_BASE_SPELL_REF, classRef)
end

-- Load the appropriate reference when this file is loaded
LoadClassReference()

