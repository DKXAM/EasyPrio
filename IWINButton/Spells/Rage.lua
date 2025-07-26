
IWBRage = IWBSpellBase:New("Rage")


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
