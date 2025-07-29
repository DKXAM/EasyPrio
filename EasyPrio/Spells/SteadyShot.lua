
IWBSteadyShot = IWBSpellBase:New("SteadyShot")

function IWBSteadyShot:IsReady(spell)
	local isReady, slot = IWBSpellBase.IsReady(self, spell)
	if not isReady then 
		DEFAULT_CHAT_FRAME:AddMessage("SteadyShot: Base check failed")
		return false, slot 
	end
	
	-- Use AutoShotTracker for precise timing if available
	if AutoShotTracker and AutoShotTracker.IsReadyToCast then
		DEFAULT_CHAT_FRAME:AddMessage("SteadyShot: Using AutoShotTracker")
		-- Steady Shot has ~1.5 second cast time
		local canCast = AutoShotTracker.IsReadyToCast(1.5)
		DEFAULT_CHAT_FRAME:AddMessage("SteadyShot: AutoShotTracker result=" .. tostring(canCast))
		return canCast, slot
	else
		DEFAULT_CHAT_FRAME:AddMessage("SteadyShot: AutoShotTracker not available, falling back")
	end
	
	-- Fallback to original logic if AutoShotTracker not available
	return isReady, slot
end
