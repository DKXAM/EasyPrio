ImmuneTracker = {}

-- Database to track immune targets and their immune spells
ImmuneTracker.immuneTargets = {}

local frame = CreateFrame("Frame", nil)
ImmuneTracker.frame = frame

frame:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")

frame:SetScript('OnEvent', function()
	if event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER" then
		ImmuneTracker:ProcessImmuneMessage(arg1)
	end
end)

function ImmuneTracker:ProcessImmuneMessage(message)
	-- Pattern for "Your [spell] failed. [target] is immune."
	local spellName, targetName = string.match(message, "Your (%w+) failed%. (.+) is immune%.")
	
	if spellName and targetName then
		self:AddImmuneTarget(targetName, spellName)
	end
end

function ImmuneTracker:AddImmuneTarget(targetName, spellName)
	if not self.immuneTargets[targetName] then
		self.immuneTargets[targetName] = {}
	end
	
	self.immuneTargets[targetName][spellName] = true
	
	-- Debug output (can remove later)
	DEFAULT_CHAT_FRAME:AddMessage("EasyPrio: " .. targetName .. " is immune to " .. spellName, 1, 1, 0)
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