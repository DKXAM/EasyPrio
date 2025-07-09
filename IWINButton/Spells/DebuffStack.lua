
IWBDebuffStack = IWBDebuff:New("DebuffStack")

function IWBDebuffStack:ShowConfig(spell, onChange)
    local lastFrame = IWBSpellBase.ShowConfig(self, spell, onChange)

    -- Max Stacks UI
    if spell["name"] == "Sunder Armor" then
        if not self.frame.maxStackCond then
            local maxStackCond = CreateFrame("Frame", nil, self.frame)
            maxStackCond:SetWidth(120)
            maxStackCond:SetHeight(22)
            maxStackCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)

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
        self.frame.maxStackCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
        self.frame.maxStackCond.editBox:SetText(spell["max_stacks"] or 5)
        lastFrame = self.frame.maxStackCond
    else
        if self.frame.maxStackCond then self.frame.maxStackCond:Hide() end
    end

    return lastFrame
end

function IWBDebuffStack:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if isReady then
        if spell["target_hp"] == nil or spell["target_hp"] == "" then
            spell["target_hp"] = 0
        end
        local isFound, count = IWBUtils:FindDebuff(spell["name"], "target")
        local maxStacks = tonumber(spell["max_stacks"]) or 5
        if not isFound then
            isReady = (UnitHealth("target") >= tonumber(spell["target_hp"]))
        else
            isReady = (count < maxStacks) and (UnitHealth("target") >= tonumber(spell["target_hp"]))
        end
    end
    return isReady, slot
end
