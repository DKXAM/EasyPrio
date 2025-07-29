ImmuneTracker = {}

-- Database to track immune targets and their immune spells
ImmuneTracker.immuneTargets = {}

local frame = CreateFrame("Frame", nil)
ImmuneTracker.frame = frame

-- Register multiple events to catch immune messages
frame:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
frame:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES") 
frame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
frame:RegisterEvent("CHAT_MSG_SYSTEM")

frame:SetScript('OnEvent', function()
	-- Check all events for immune messages only
	if arg1 and string.find(arg1, "immune") then
		ImmuneTracker:ProcessImmuneMessage(arg1)
	end
end)

function ImmuneTracker:ProcessImmuneMessage(message)
	-- Pattern for "Your [spell] failed. [target] is immune."
	local spellName, targetName = string.match(message, "Your (.+) failed%. (.+) is immune%.")
	
	if spellName and targetName then
		self:AddImmuneTarget(targetName, spellName)
	end
end

function ImmuneTracker:AddImmuneTarget(targetName, spellName)
	if not self.immuneTargets[targetName] then
		self.immuneTargets[targetName] = {}
	end
	
	-- Only add if not already tracked
	if not self.immuneTargets[targetName][spellName] then
		self.immuneTargets[targetName][spellName] = true
		DEFAULT_CHAT_FRAME:AddMessage("EasyPrio: " .. targetName .. " is immune to " .. spellName, 1, 1, 0)
	end
end

function ImmuneTracker:IsTargetImmuneToSpell(targetName, spellName)
	if not targetName or not spellName then
		return false
	end
	
	if not self.immuneTargets[targetName] then
		return false
	end
	
	return self.immuneTargets[targetName][spellName] or false
end

function ImmuneTracker:IsCurrentTargetImmuneToSpell(spellName)
	local targetName = UnitName("target")
	if not targetName then
		return false
	end
	
	return self:IsTargetImmuneToSpell(targetName, spellName)
end