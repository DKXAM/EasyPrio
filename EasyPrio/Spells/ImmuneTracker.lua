ImmuneTracker = {}

-- Database to track immune targets and their immune spells
ImmuneTracker.immuneTargets = {}

local frame = CreateFrame("Frame", nil)
ImmuneTracker.frame = frame

frame:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")

frame:SetScript('OnEvent', function()
	if event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER" then
		-- Debug: Show all spell failure messages
		DEFAULT_CHAT_FRAME:AddMessage("EasyPrio Debug: Spell failed message: " .. tostring(arg1), 0.5, 0.5, 1)
		ImmuneTracker:ProcessImmuneMessage(arg1)
	end
end)

function ImmuneTracker:ProcessImmuneMessage(message)
	-- Pattern for "Your [spell] failed. [target] is immune."
	local spellName, targetName = string.match(message, "Your (%w+) failed%. (.+) is immune%.")
	
	if spellName and targetName then
		DEFAULT_CHAT_FRAME:AddMessage("EasyPrio Debug: Matched immune pattern - Spell: " .. spellName .. ", Target: " .. targetName, 0.5, 1, 0.5)
		self:AddImmuneTarget(targetName, spellName)
	else
		-- Try alternative patterns
		spellName, targetName = string.match(message, "Your (.+) failed%. (.+) is immune%.")
		if spellName and targetName then
			DEFAULT_CHAT_FRAME:AddMessage("EasyPrio Debug: Matched immune pattern (alt) - Spell: " .. spellName .. ", Target: " .. targetName, 0.5, 1, 0.5)
			self:AddImmuneTarget(targetName, spellName)
		else
			DEFAULT_CHAT_FRAME:AddMessage("EasyPrio Debug: No immune pattern matched", 1, 0.5, 0.5)
		end
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