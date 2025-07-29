
IWBSteadyShot = IWBSpellBase:New("SteadyShot")

function IWBSteadyShot:IsReady(spell)
	local isReady, slot = IWBSpellBase.IsReady(self, spell)
	if not isReady then 
		return false, slot 
	end
	
	-- Use AutoShotTracker for precise timing if available
	if AutoShotTracker and AutoShotTracker.IsReadyToCast then
		-- Steady Shot has ~1.5 second cast time
		local canCast = AutoShotTracker.IsReadyToCast(1.5)
		return canCast, slot
	end
	
	-- Fallback to original logic if AutoShotTracker not available
	return isReady, slot
end
