
IWBRage = IWBSpellBase:New("Rage")


function IWBRage:CreateFrame()
	IWBSpellBase.CreateFrame(self)

	local rageCond = CreateFrame("Frame", nil, self.frame)
	rageCond:SetWidth(90)
	rageCond:SetHeight(22)
	rageCond:SetPoint("TOPLEFT", self.frame, "BOTTOMLEFT", 0, 0)

	local artLayer = rageCond:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	artLayer:SetText("Rage")
	artLayer:SetPoint("TOPLEFT", 0, 0)

	local artLayer2 = rageCond:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	artLayer2:SetText(">=")
	artLayer2:SetPoint("TOPLEFT", 90, 0)

	local editBox = CreateFrame("EditBox", nil, rageCond)
	editBox:SetWidth(15)
	editBox:SetHeight(32)
	editBox:SetPoint("LEFT", 120, 5)
	editBox:SetNumeric(true)
	editBox:SetMaxLetters(2)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject("GameFontHighlightSmall")
	rageCond.editBox = editBox

	local leftTex = editBox:CreateTexture(nil, "BACKGROUND")
	leftTex:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left")
	leftTex:SetWidth(25)
	leftTex:SetHeight(32)
	leftTex:SetPoint("LEFT", -10, 0)
	leftTex:SetTexCoord(0, 0.29296875, 0, 1.0)

	local rightTex = editBox:CreateTexture(nil, "BACKGROUND")
	rightTex:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
	rightTex:SetWidth(25)
	rightTex:SetHeight(32)
	rightTex:SetPoint("RIGHT", 10, 0)
	rightTex:SetTexCoord(0.70703125, 1.0, 0, 1.0)

	editBox:SetScript("OnEnterPressed", function()
		this:ClearFocus()
	end)

	editBox:SetScript("OnTextChanged", function()
		self.spell["rage"] = this:GetText()
	end)
	
	self.frame.rageCond = rageCond

	-- Min/Max rage for Execute only
	local minMaxRageFrame = CreateFrame("Frame", nil, self.frame)
	minMaxRageFrame:SetWidth(180)
	minMaxRageFrame:SetHeight(22)
	minMaxRageFrame:SetPoint("TOPLEFT", rageCond, "BOTTOMLEFT", 0, 0)
	minMaxRageFrame:Hide() -- Only show for Execute

	local minLabel = minMaxRageFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	minLabel:SetText("Min Rage:")
	minLabel:SetPoint("LEFT", minMaxRageFrame, "LEFT", 0, 0)

	local minEdit = CreateFrame("EditBox", nil, minMaxRageFrame)
	minEdit:SetWidth(25)
	minEdit:SetHeight(22)
	minEdit:SetPoint("LEFT", minLabel, "RIGHT", 5, 0)
	minEdit:SetNumeric(true)
	minEdit:SetMaxLetters(3)
	minEdit:SetAutoFocus(false)
	minEdit:SetFontObject("GameFontHighlightSmall")
	minEdit:SetScript("OnEnterPressed", function() this:ClearFocus() end)
	minEdit:SetScript("OnTextChanged", function() self.spell["min_rage"] = this:GetText() end)
	minMaxRageFrame.minEdit = minEdit

	local maxLabel = minMaxRageFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	maxLabel:SetText("Max Rage:")
	maxLabel:SetPoint("LEFT", minEdit, "RIGHT", 10, 0)

	local maxEdit = CreateFrame("EditBox", nil, minMaxRageFrame)
	maxEdit:SetWidth(25)
	maxEdit:SetHeight(22)
	maxEdit:SetPoint("LEFT", maxLabel, "RIGHT", 5, 0)
	maxEdit:SetNumeric(true)
	maxEdit:SetMaxLetters(3)
	maxEdit:SetAutoFocus(false)
	maxEdit:SetFontObject("GameFontHighlightSmall")
	maxEdit:SetScript("OnEnterPressed", function() this:ClearFocus() end)
	maxEdit:SetScript("OnTextChanged", function() self.spell["max_rage"] = this:GetText() end)
	minMaxRageFrame.maxEdit = maxEdit

	self.frame.minMaxRageFrame = minMaxRageFrame
end

function IWBRage:ShowConfig(spell, onChange)
	local lastFrame = IWBSpellBase.ShowConfig(self, spell, onChange)
	
	self.frame.rageCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
	if spell["rage"] == nil or spell["rage"] == "" then
		spell["rage"] = 0
	end
	self.frame.rageCond.editBox:SetText(spell["rage"])

	-- Only show min/max rage for Execute
	if spell["name"] == "Execute" then
		self.frame.minMaxRageFrame:Show()
		if spell["min_rage"] == nil or spell["min_rage"] == "" then
			spell["min_rage"] = 0
		end
		if spell["max_rage"] == nil or spell["max_rage"] == "" then
			spell["max_rage"] = 100
		end
		self.frame.minMaxRageFrame.minEdit:SetText(spell["min_rage"])
		self.frame.minMaxRageFrame.maxEdit:SetText(spell["max_rage"])
	else
		self.frame.minMaxRageFrame:Hide()
	end
end

function IWBRage:IsReady(spell)
	local isReady, slot = IWBSpellBase.IsReady(self, spell)
	if isReady then
		local rage = UnitMana("player")
		isReady = rage >= (tonumber(spell["rage"]) or 0)
		if spell["name"] == "Execute" then
			local min_rage = tonumber(spell["min_rage"]) or 0
			local max_rage = tonumber(spell["max_rage"]) or 100
			isReady = isReady and (rage >= min_rage) and (rage <= max_rage)
		end
	end
	return isReady, slot
end
