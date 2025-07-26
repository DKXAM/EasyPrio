-- Unified Spell Settings System
-- This file defines schemas for different spell types and provides helper functions
-- for generating UI and validating settings.

-- Schema definitions for different spell types
SPELL_TYPE_SCHEMAS = {
    DebuffStack = {
        max_stacks = { 
            type = "number", 
            min = 1, 
            max = 5, 
            default = 5,
            label = "Max Stacks",
            width = 30,
            maxLetters = 1
        },
        min_rage = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 0,
            label = "Min Rage",
            width = 30,
            maxLetters = 3
        },
        max_rage = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 100,
            label = "Max Rage",
            width = 30,
            maxLetters = 3
        },
        target_hp = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 0,
            label = "Target HP (%)",
            width = 30,
            maxLetters = 10
        }
    },
    
    Debuff = {
        min_rage = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 0,
            label = "Min Rage",
            width = 30,
            maxLetters = 3
        },
        max_rage = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 100,
            label = "Max Rage",
            width = 30,
            maxLetters = 3
        },
        target_hp = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 0,
            label = "Target HP (%)",
            width = 30,
            maxLetters = 10
        }
    },
    
    Rage = {
        modifier = {
            type = "modifier",
            default = "None",
            label = "Modifier",
            options = {"None", "Shift", "Ctrl", "Alt", "Shift+Ctrl", "Shift+Alt", "Ctrl+Alt", "Shift+Ctrl+Alt"}
        },
        min_rage = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 0,
            label = "Min Rage",
            width = 25,
            maxLetters = 3
        },
        max_rage = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 100,
            label = "Max Rage",
            width = 25,
            maxLetters = 3
        }
    },
    
    Base = {
        -- Base spell type has no additional settings
    },
    
    NextMelee = {
        min_rage = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 0,
            label = "Min Rage",
            width = 25,
            maxLetters = 3
        },
        max_rage = { 
            type = "number", 
            min = 0, 
            max = 100, 
            default = 100,
            label = "Max Rage",
            width = 25,
            maxLetters = 3
        }
    }
}

-- Helper function to get a setting value with proper defaults
function GetSpellSetting(spell, settingName)
    local spellType = GetSpellType(spell)
    local schema = SPELL_TYPE_SCHEMAS[spellType]
    
    if not schema or not schema[settingName] then
        return nil
    end
    
    -- Initialize settings table if it doesn't exist
    if not spell.settings then
        spell.settings = {}
    end
    
    -- Return the setting value or the default
    return spell.settings[settingName] or schema[settingName].default
end

-- Helper function to set a setting value
function SetSpellSetting(spell, settingName, value)
    if not spell.settings then
        spell.settings = {}
    end
    spell.settings[settingName] = value
end

-- Helper function to determine spell type from spell name
function GetSpellType(spell)
    if IWB_SPELL_REF[spell.name] then
        local handler = IWB_SPELL_REF[spell.name].handler
        if handler == IWBDebuffStack then
            return "DebuffStack"
        elseif handler == IWBDebuff then
            return "Debuff"
        elseif handler == IWBRage then
            return "Rage"
        elseif handler == IWBRageNextMelee then
            return "NextMelee"
        elseif handler == IWBNextMelee then
            return "NextMelee"
        else
            return "Base"
        end
    end
    return "Base"
end

-- Helper function to validate a setting value
function ValidateSetting(spell, settingName, value)
    local spellType = GetSpellType(spell)
    local schema = SPELL_TYPE_SCHEMAS[spellType]
    
    if not schema or not schema[settingName] then
        return false
    end
    
    local settingSchema = schema[settingName]
    
    if settingSchema.type == "number" then
        local numValue = tonumber(value)
        if not numValue then
            return false
        end
        return numValue >= settingSchema.min and numValue <= settingSchema.max
    end
    
    return true
end

-- Helper function to create a setting UI control
function CreateSettingControl(parent, settingName, settingSchema, spell, onChange)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(120)
    frame:SetHeight(22)
    
    local label = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetText(settingSchema.label)
    label:SetPoint("TOPLEFT", 0, 0)
    
    if settingSchema.type == "number" then
        local editBox = CreateFrame("EditBox", nil, frame)
        editBox:SetWidth(settingSchema.width)
        editBox:SetHeight(22)
        editBox:SetPoint("LEFT", label, "RIGHT", 10, 0)
        editBox:SetNumeric(true)
        editBox:SetMaxLetters(settingSchema.maxLetters)
        editBox:SetAutoFocus(false)
        editBox:SetFontObject("GameFontHighlightSmall")
        
        -- Add backdrop for better visibility
        editBox:SetBackdrop({
            bgFile = "Interface\\Glues\\Common\\Glue-Tooltip-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }
        })
        editBox:SetBackdropColor(0, 0, 0, 0.5)
        
        -- Set initial value
        local currentValue = GetSpellSetting(spell, settingName)
        editBox:SetText(tostring(currentValue))
        
        editBox:SetScript("OnEnterPressed", function() 
            this:ClearFocus() 
        end)
        
        editBox:SetScript("OnTextChanged", function()
            local val = tonumber(this:GetText())
            if val and ValidateSetting(spell, settingName, val) then
                SetSpellSetting(spell, settingName, val)
                if onChange then 
                    onChange() 
                end
            end
        end)
        
        frame.editBox = editBox
    end
    
    return frame
end 