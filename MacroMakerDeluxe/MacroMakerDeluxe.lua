-- Macro Maker Deluxe - Main addon initialization
-- Universal spell rotation addon for World of Warcraft 1.12.1

-- Global addon namespace
MMD = {
    version = "0.1.0-alpha",
    name = "MacroMakerDeluxe",
    
    -- Core systems (initialized by respective files)
    Utils = {},
    SpellDiscovery = {},
    Conditions = {},
    Engine = {},
    
    -- GUI systems  
    UI = {
        MainFrame = {},
        SpellSelector = {},
        ConditionBuilder = {},
        PriorityList = {}
    },
    
    -- Data management
    PlayerConfig = {},
    Presets = {},
    
    -- Runtime state
    isInitialized = false,
    debug = false
}

-- Create main frame for event handling
local frame = CreateFrame("Frame", "MMDEventFrame")

-- Event handlers
function frame:ADDON_LOADED()
    if arg1 == "MacroMakerDeluxe" then
        MMD:Initialize()
    end
end

function frame:VARIABLES_LOADED()
    MMD:LoadSavedVariables()
end

function frame:SPELLS_CHANGED()
    if MMD.isInitialized then
        MMD.SpellDiscovery:RefreshSpellData()
    end
end

function frame:PLAYER_AURAS_CHANGED()
    if MMD.isInitialized then
        MMD.Engine:InvalidateConditionCache()
    end
end

-- Register events
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("VARIABLES_LOADED") 
frame:RegisterEvent("SPELLS_CHANGED")
frame:RegisterEvent("PLAYER_AURAS_CHANGED")

-- Set event handler
frame:SetScript("OnEvent", function()
    if this[event] then
        this[event]()
    end
end)

-- Main initialization
function MMD:Initialize()
    if self.isInitialized then
        return
    end
    
    MMD:Print("Initializing Macro Maker Deluxe v" .. self.version)
    
    -- Initialize core systems
    self.Utils:Initialize()
    self.SpellDiscovery:Initialize()
    self.Conditions:Initialize()
    self.Engine:Initialize()
    
    -- Initialize data management
    self.PlayerConfig:Initialize()
    self.Presets:Initialize()
    
    -- Initialize GUI (but don't show)
    self.UI.MainFrame:Initialize()
    
    -- Register slash commands
    self:RegisterSlashCommands()
    
    self.isInitialized = true
    MMD:Print("Initialization complete! Type /mmd to open the interface.")
end

-- Load saved variables
function MMD:LoadSavedVariables()
    if MMD_GlobalConfig then
        -- Load global settings
        self.debug = MMD_GlobalConfig.debug or false
    end
    
    if MMD_PlayerConfig then
        -- Load character-specific configurations
        self.PlayerConfig:LoadFromSavedVariables(MMD_PlayerConfig)
    end
end

-- Slash command registration
function MMD:RegisterSlashCommands()
    SLASH_MMD1 = "/mmd"
    SLASH_MMD2 = "/macromakerdeluxe"
    
    SlashCmdList["MMD"] = function(msg)
        MMD:HandleSlashCommand(msg)
    end
end

-- Slash command handler
function MMD:HandleSlashCommand(msg)
    local command = string.lower(msg or "")
    
    if command == "" or command == "show" or command == "open" then
        -- Open main interface
        if self.UI.MainFrame.Show then
            self.UI.MainFrame:Show()
        else
            MMD:Print("Interface not yet implemented. Coming soon!")
        end
        
    elseif command == "run" or command == "execute" then
        -- Execute spell rotation
        self.Engine:Execute()
        
    elseif command == "debug" then
        -- Toggle debug mode
        self.debug = not self.debug
        MMD:Print("Debug mode " .. (self.debug and "enabled" or "disabled"))
        
    elseif command == "reload" or command == "refresh" then
        -- Refresh spell data
        self.SpellDiscovery:RefreshSpellData()
        MMD:Print("Spell data refreshed")
        
    elseif command == "help" then
        -- Show help information
        MMD:ShowHelp()
        
    else
        MMD:Print("Unknown command: " .. command)
        MMD:ShowHelp()
    end
end

-- Help information
function MMD:ShowHelp()
    MMD:Print("Macro Maker Deluxe v" .. self.version .. " - Commands:")
    MMD:Print("/mmd - Open the main interface")
    MMD:Print("/mmd run - Execute your spell rotation")  
    MMD:Print("/mmd debug - Toggle debug mode")
    MMD:Print("/mmd refresh - Refresh spell data")
    MMD:Print("/mmd help - Show this help")
end

-- Utility print function
function MMD:Print(msg)
    if msg then
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00[MMD]|r " .. tostring(msg))
    end
end

-- Debug print function
function MMD:Debug(msg)
    if self.debug and msg then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00[MMD Debug]|r " .. tostring(msg))
    end
end

-- Global function for macro execution (for easy macro creation)
function MMD_Execute()
    if MMD and MMD.Engine then
        MMD.Engine:Execute()
    end
end