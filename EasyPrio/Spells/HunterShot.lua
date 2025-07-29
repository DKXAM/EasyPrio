-- Generic hunter shot handler that prevents auto shot clipping
-- Used for instant shots like Multi-Shot, Aimed Shot, etc.

HunterShot = IWBSpellBase:New("HunterShot")

function HunterShot:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if not isReady then 
        return false, slot 
    end
    
    -- Use AutoShotTracker for precise timing if available
    if AutoShotTracker and AutoShotTracker.IsReadyToCast then
        -- For instant shots, we need minimal cast time
        local canCast = AutoShotTracker.IsReadyToCast(0.1)
        return canCast, slot
    end
    
    -- Fallback to original logic if AutoShotTracker not available
    return isReady, slot
end