
IWBDebuffStack = IWBDebuff:New("DebuffStack")

function IWBDebuffStack:ShowConfig(spell, onChange)
    local lastFrame = IWBDebuff.ShowConfig(self, spell, onChange)

    -- Only create the max_stacks UI for DebuffStack
    local spellType = GetSpellType(spell)
    local schema = SPELL_TYPE_SCHEMAS[spellType]
    if schema and schema.max_stacks then
        local settingFrame = CreateSettingControl(self.frame, "max_stacks", schema.max_stacks, spell, onChange)
        if lastFrame and lastFrame.SetPoint then
            settingFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
        else
            settingFrame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
        end
        lastFrame = settingFrame
    end

    return lastFrame
end

function IWBDebuffStack:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if isReady then
        local min_rage = GetSpellSetting(spell, "min_rage")
        local max_rage = GetSpellSetting(spell, "max_rage")
        local rage = UnitMana("player")
        if rage < min_rage or rage > max_rage then
            return false, slot
        end
        
        local target_hp = GetSpellSetting(spell, "target_hp")
        local hp = UnitHealth("target")
        local maxhp = UnitHealthMax("target")
        local percent = (maxhp > 0) and (hp / maxhp * 100) or 0
        
        local isFound, count = IWBUtils:FindDebuff(spell["name"], "target")
        local maxStacks = GetSpellSetting(spell, "max_stacks")
        
        if not isFound then
            isReady = (percent >= target_hp)
        else
            isReady = (count < maxStacks) and (percent >= target_hp)
        end
    end
    return isReady, slot
end
