
IWBRage = IWBSpellBase:New("Rage")

function IWBRage:ShowConfig(spell, onChange)
    local lastFrame = IWBSpellBase.ShowConfig(self, spell, onChange)

    -- Only create UI for settings relevant to Rage (min_rage, max_rage)
    local spellType = GetSpellType(spell)
    local schema = SPELL_TYPE_SCHEMAS[spellType]
    if schema then
        for settingName, settingSchema in pairs(schema) do
            if settingName == "min_rage" or settingName == "max_rage" then
                local settingFrame = CreateSettingControl(self.frame, settingName, settingSchema, spell, onChange)
                if lastFrame and lastFrame.SetPoint then
                    settingFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
                else
                    settingFrame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
                end
                lastFrame = settingFrame
            end
        end
    end
    return lastFrame
end

function IWBRage:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if isReady then
        local rage = UnitMana("player")
        local min_rage = GetSpellSetting(spell, "min_rage")
        local max_rage = GetSpellSetting(spell, "max_rage")
        isReady = (rage >= min_rage) and (rage <= max_rage)
    end
    return isReady, slot
end
