-- Generic hunter shot handler that prevents auto shot clipping
-- Used for instant shots like Multi-Shot, Aimed Shot, etc.

HunterShot = IWBSpellBase:New("HunterShot")

function HunterShot:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if not isReady then 
        DEFAULT_CHAT_FRAME:AddMessage("HunterShot (" .. tostring(spell.name) .. "): Base check failed")
        return false, slot 
    end
    
    -- Use AutoShotTracker for precise timing if available
    if AutoShotTracker and AutoShotTracker.IsReadyToCast then
        DEFAULT_CHAT_FRAME:AddMessage("HunterShot (" .. tostring(spell.name) .. "): Using AutoShotTracker")
        -- For instant shots, we need minimal cast time
        local canCast = AutoShotTracker.IsReadyToCast(0.1)
        DEFAULT_CHAT_FRAME:AddMessage("HunterShot (" .. tostring(spell.name) .. "): result=" .. tostring(canCast))
        return canCast, slot
    else
        DEFAULT_CHAT_FRAME:AddMessage("HunterShot (" .. tostring(spell.name) .. "): AutoShotTracker not available")
    end
    
    -- Fallback to original logic if AutoShotTracker not available
    return isReady, slot
end