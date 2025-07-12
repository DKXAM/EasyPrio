
IWBDebuffOrSpell = IWBSpellBase:New("DebuffOrSpell")

function IWBDebuffOrSpell:CreateFrame()
	IWBSpellBase.CreateFrame(self)
	
	local behaviorCond = CreateFrame("Frame", nil, self.frame)
	behaviorCond:SetWidth(90)
	behaviorCond:SetHeight(22)

	local titleTxt = behaviorCond:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	titleTxt:SetPoint("TOPLEFT", 0, 0)
	titleTxt:SetText("Type")
	behaviorCond.titleTxt = titleTxt
	
	local listEl = DropDownTemplate:new()
	listEl:CreateFrame("IWBDebuffOrSpell"..self.name, behaviorCond)
	listEl:SetWidth(80)
	listEl.frame:SetPoint("LEFT", titleTxt, "LEFT", 70, 0)
	listEl:SetOnChange(function() self:SetBehavior(listEl:GetSelected())  end)
	listEl:SetList({"Spell", "Debuff"}, self.spell["behavior"])

	behaviorCond.listEl = listEl
	self.frame.behaviorCond = behaviorCond
end

function IWBDebuffOrSpell:SetBehavior(v)
	if v ~= self.spell["behavior"] then
		self.spell["behavior"] = v
		if self.onChange ~= nil then
			self.onChange()
		end
	end
end

function IWBDebuffOrSpell:ShowConfig(spell, onChange)
	local lastFrame = IWBSpellBase.ShowConfig(self, spell, onChange)
	
	self.frame.behaviorCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
	if spell["behavior"] == nil or spell["behavior"] == "" then
		spell["behavior"] = "Spell"
	end
	self.frame.behaviorCond.listEl:SetSelected(spell["behavior"])
end

function IWBDebuffOrSpell:IsReady(spell)
	local isReady, slot = IWBSpellBase.IsReady(self, spell)
	if spell["name"] == "Demoralizing Shout" then
		if UnitIsDead("target") or not UnitCanAttack("player", "target") then
			return false, slot
		end
	end
	if isReady and (spell["behavior"] == "Debuff") then
		isReady = not IWBUtils:FindDebuff(spell["name"], "target")
	end
	return isReady, slot
end




