
IWBDebuff = IWBSpellBase:New("Debuff")

function IWBDebuff:CreateFrame()
	IWBSpellBase.CreateFrame(self)
	-- No custom UI for target_hp or min_rage; handled by unified settings system
end

function IWBDebuff:ShowConfig(spell, onChange)
	local lastFrame = IWBSpellBase.ShowConfig(self, spell, onChange)
	
	-- Clean up existing debuff setting frames if they exist
	if self.frame.debuffSettings then
		for _, frame in pairs(self.frame.debuffSettings) do
			frame:Hide()
			frame:SetParent(nil)
		end
	end
	self.frame.debuffSettings = {}
	
	-- Only create UI for settings relevant to Debuff (target_hp, min_rage, max_rage)
	local spellType = GetSpellType(spell)
	local schema = SPELL_TYPE_SCHEMAS[spellType]
	
	if schema then
		for settingName, settingSchema in pairs(schema) do
			if settingName == "target_hp" or settingName == "min_rage" or settingName == "max_rage" then
				local settingFrame = CreateSettingControl(self.frame, settingName, settingSchema, spell, onChange)
				if lastFrame and lastFrame.SetPoint then
					settingFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
				else
					settingFrame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
				end
				lastFrame = settingFrame
				table.insert(self.frame.debuffSettings, settingFrame)
			end
		end
	end
	
	return lastFrame
end

function IWBDebuff:IsReady(spell)
	local isReady, slot = IWBSpellBase.IsReady(self, spell)
	if isReady then
		local target_hp = GetSpellSetting(spell, "target_hp")
		local hp = UnitHealth("target")
		local maxhp = UnitHealthMax("target")
		local percent = (maxhp > 0) and (hp / maxhp * 100) or 0
		isReady = (not IWBUtils:FindDebuff(spell["name"], "target")) and (percent >= target_hp)

		local min_rage = GetSpellSetting(spell, "min_rage")
		local max_rage = GetSpellSetting(spell, "max_rage")
		local rage = UnitMana("player")
		if rage < min_rage or rage > max_rage then
			return false, slot
		end
	end
	return isReady, slot
end




