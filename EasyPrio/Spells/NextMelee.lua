
IWBNextMelee = IWBSpellBase:New("NextMelee")


function IWBNextMelee:IsReady(spell)
    local isReady, slot = IWBSpellBase.IsReady(self, spell)
    if isReady and slot ~= nil then
        isReady = not IsCurrentAction(slot)
    end
    if isReady then
        local min_rage = GetSpellSetting(spell, "min_rage")
        local max_rage = GetSpellSetting(spell, "max_rage")
        local rage = UnitMana("player")
        if rage < min_rage or rage > max_rage then
            return false, slot
        end
    end
    return isReady, slot
end
