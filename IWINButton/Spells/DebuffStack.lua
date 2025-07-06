
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

        -- Refresh Window UI
        if not self.frame.refreshWindowCond then
            local refreshWindowCond = CreateFrame("Frame", nil, self.frame)
            refreshWindowCond:SetWidth(160)
            refreshWindowCond:SetHeight(22)
            refreshWindowCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)

            local label = refreshWindowCond:CreateFontString(nil, "ARTWORK", "GameFontNormal")
            label:SetText("Refresh Window (s)")
            label:SetPoint("TOPLEFT", 0, 0)

            local editBox = CreateFrame("EditBox", nil, refreshWindowCond)
            editBox:SetWidth(30)
            editBox:SetHeight(22)
            editBox:SetPoint("LEFT", label, "RIGHT", 10, 0)
            editBox:SetNumeric(true)
            editBox:SetMaxLetters(2)
            editBox:SetAutoFocus(false)
            editBox:SetFontObject("GameFontHighlightSmall")
            refreshWindowCond.editBox = editBox

            editBox:SetScript("OnEnterPressed", function() this:ClearFocus() end)
            editBox:SetScript("OnTextChanged", function()
                local val = tonumber(editBox:GetText())
                if val and val >= 0 and val <= 30 then
                    spell["refresh_window"] = val
                    if onChange then onChange() end
                end
            end)

            self.frame.refreshWindowCond = refreshWindowCond
        end
        self.frame.refreshWindowCond:Show()
        self.frame.refreshWindowCond:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
        self.frame.refreshWindowCond.editBox:SetText(spell["refresh_window"] or 5)
        lastFrame = self.frame.refreshWindowCond
    else
        if self.frame.maxStackCond then self.frame.maxStackCond:Hide() end
        if self.frame.refreshWindowCond then self.frame.refreshWindowCond:Hide() end
    end

    return lastFrame
end

function IWBDebuffStack:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if isReady then
        local isFound, count, timeLeft = IWBUtils:FindDebuff(spell["name"], "target")
        local maxStacks = spell["max_stacks"] or 5
        local refreshWindow = spell["refresh_window"] or 5
        if not isFound then
            isReady = true
        else
            if count < maxStacks then
                isReady = true
            else
                -- Check time left for refresh window
                if timeLeft and timeLeft < refreshWindow then
                    isReady = true
                else
                    isReady = false
                end
            end
        end
    end
    return isReady, slot
end
