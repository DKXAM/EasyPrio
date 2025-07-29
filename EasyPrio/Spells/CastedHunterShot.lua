-- Casted hunter shot handler for shots with cast times
-- Used for Aimed Shot, Multi-Shot, etc.

CastedHunterShot = IWBSpellBase:New("CastedHunterShot")

-- Cast time mapping for different shots
local CAST_TIMES = {
    ["Aimed Shot"] = 3.0,
    ["Multi-Shot"] = 0.5,
}

function CastedHunterShot:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if not isReady then 
        return false, slot 
    end
    
    -- Use AutoShotTracker for precise timing if available
    if AutoShotTracker and AutoShotTracker.IsReadyToCast then
        -- Get the cast time for this specific spell
        local castTime = CAST_TIMES[spell] or 1.5 -- Default to 1.5s if unknown
        local canCast = AutoShotTracker.IsReadyToCast(castTime)
        return canCast, slot
    end
    
    -- Fallback to original logic if AutoShotTracker not available
    return isReady, slot
end