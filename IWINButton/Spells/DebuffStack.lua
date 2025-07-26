
IWBDebuffStack = IWBDebuff:New("DebuffStack")

-- Helper to check if a frame is a descendant of another
local function IsDescendant(child, parent)
    while child do
        if child == parent then
            return true
        end
        child = child.GetParent and child:GetParent() or nil
    end
    return false
end

function IWBDebuffStack:ShowConfig(spell, onChange)
    local lastFrame = IWBDebuff.ShowConfig(self, spell, onChange)

    -- Max Stacks UI
    if spell["name"] == "Sunder Armor" then
        if not self.frame.maxStackCond then
            local maxStackCond = CreateFrame("Frame", nil, self.frame)
            maxStackCond:SetWidth(120)
            maxStackCond:SetHeight(22)
            if lastFrame and lastFrame.SetPoint then
                maxStackCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
            else
                maxStackCond:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
            end

            local label = maxStackCond:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            label:SetText("Max Stacks")
            label:SetPoint("TOPLEFT", 0, 0)

            local editBox = CreateFrame("EditBox", nil, maxStackCond)
            editBox:SetWidth(30)
            editBox:SetHeight(22)
            editBox:SetPoint("LEFT", label, "RIGHT", 10, 0)
            editBox:SetNumeric(true)
            editBox:SetMaxLetters(1)
            editBox:SetAutoFocus(false)
            editBox:SetFontObject("GameFontHighlightSmall")
            maxStackCond.editBox = editBox

            editBox:SetScript("OnEnterPressed", function() this:ClearFocus() end)
            editBox:SetScript("OnTextChanged", function()
                local val = tonumber(editBox:GetText())
                if val and val >= 1 and val <= 5 then
                    spell["max_stacks"] = val
                    if onChange then onChange() end
                end
            end)

            self.frame.maxStackCond = maxStackCond
        end
            self.frame.maxStackCond:Show()
    if lastFrame and lastFrame.SetPoint and not IsDescendant(self.frame.maxStackCond, lastFrame) then
        self.frame.maxStackCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
    else
        self.frame.maxStackCond:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
    end
        self.frame.maxStackCond.editBox:SetText(spell["max_stacks"] or 5)
        lastFrame = self.frame.maxStackCond
    else
        if self.frame.maxStackCond then self.frame.maxStackCond:Hide() end
    end

    -- Min Rage UI
    if not self.frame.minRageCond then
        local minRageCond = CreateFrame("Frame", nil, self.frame)
        minRageCond:SetWidth(90)
        minRageCond:SetHeight(22)
        if lastFrame and lastFrame.SetPoint then
            minRageCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
        else
            minRageCond:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
        end
        local minRageLabel = minRageCond:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        minRageLabel:SetText("Min Rage")
        minRageLabel:SetPoint("TOPLEFT", 0, 0)
        local minRageEdit = CreateFrame("EditBox", nil, minRageCond)
        minRageEdit:SetWidth(30)
        minRageEdit:SetHeight(22)
        minRageEdit:SetPoint("LEFT", minRageLabel, "RIGHT", 10, 0)
        minRageEdit:SetNumeric(true)
        minRageEdit:SetMaxLetters(3)
        minRageEdit:SetAutoFocus(false)
        minRageEdit:SetFontObject("GameFontHighlightSmall")
        minRageCond.editBox = minRageEdit
        minRageEdit:SetScript("OnEnterPressed", function() this:ClearFocus() end)
        minRageEdit:SetScript("OnTextChanged", function() spell["min_rage"] = this:GetText() end)
        self.frame.minRageCond = minRageCond
    end
    self.frame.minRageCond:Show()
    if lastFrame and lastFrame.SetPoint and not IsDescendant(self.frame.minRageCond, lastFrame) then
        self.frame.minRageCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
    else
        self.frame.minRageCond:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
    end
    if spell["min_rage"] == nil or spell["min_rage"] == "" then
        spell["min_rage"] = 0
    end
    self.frame.minRageCond.editBox:SetText(spell["min_rage"])
    lastFrame = self.frame.minRageCond

    return lastFrame
end

function IWBDebuffStack:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if isReady then
        local min_rage = tonumber(spell["min_rage"]) or 0
        if UnitMana("player") < min_rage then
            return false, slot
        end
        if spell["target_hp"] == nil or spell["target_hp"] == "" then
            spell["target_hp"] = 0
        end
        local hp = UnitHealth("target")
        local maxhp = UnitHealthMax("target")
        local percent = (maxhp > 0) and (hp / maxhp * 100) or 0
        local isFound, count = IWBUtils:FindDebuff(spell["name"], "target")
        local maxStacks = tonumber(spell["max_stacks"]) or 5
        if not isFound then
            isReady = (percent >= tonumber(spell["target_hp"]))
        else
            isReady = (count < maxStacks) and (percent >= tonumber(spell["target_hp"]))
        end
    end
    return isReady, slot
end
