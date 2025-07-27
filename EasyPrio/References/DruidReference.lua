-- Druid class spells
IWB_DRUID_SPELL_REF = {
    ["Entangling Roots"] = {["handler"] = IWBDebuff},
    ["Faerie Fire"] = {["handler"] = IWBDebuff},
    ["Demoralizing Roar"] = {["handler"] = IWBDebuff},
    ["Faerie Fire (Feral)"] = {["handler"] = IWBDebuff},
	["Insect Swarm"] = {["handler"] = IWBDebuffDot, ["duration"] = 18, ["target_hp"] = true},
    ["Moonfire"] = {["handler"] = IWBDebuffDot, ["duration"] = 18, ["target_hp"] = true},
    
    ["Wrath"] = {["handler"] = IWBIfBuff, ["buff_list"] = {"None", "Natural Boon", "Nature Eclipse"}},
    ["Starfire"] = {["handler"] = IWBIfBuff, ["buff_list"] = {"None", "Astral Boon", "Arcane Eclipse"}},
  
    ["Thorns"] = {["handler"] = IWBBuff},
    ["Aquatic Form"] = {["handler"] = IWBBuff},
    ["Cat Form"] = {["handler"] = IWBBuff},
    ["Dire Bear Form"] = {["handler"] = IWBBuff},
    ["Bear Form"] = {["handler"] = IWBBuff},
    ["Prowl"] = {["handler"] = IWBBuff},
    ["Travel Form"] = {["handler"] = IWBBuff},
    ["Abolish Poison"] = {["handler"] = IWBBuff},
    ["Gift of the Wild"] = {["handler"] = IWBBuff},
    ["Mark of the Wild"] = {["handler"] = IWBBuff, ["alias"] = "Gift of the Wild"},
    ["Moonkin Form"] = {["handler"] = IWBBuff},
    ["Tree of Life Form"] = {["handler"] = IWBBuff},
    
    -- Cat Form (combo point abilities)
    ["Ferocious Bite"] = {["handler"] = IWBCombopoint, ["no_rank"] = true, ["auto_target"] = true},
    ["Rip"] = {["handler"] = IWBCombopointAndDebuff, ["no_rank"] = true, ["auto_target"] = true},
    
    -- Bear Form (rage abilities)
    ["Savage Bite"] = {["handler"] = IWBRage, ["no_rank"] = true, ["auto_target"] = true},
    ["Swipe"] = {["handler"] = IWBRage, ["no_rank"] = true, ["auto_target"] = true},
    ["Maul"] = {["handler"] = IWBRageNextMelee, ["no_rank"] = true, ["auto_target"] = true},
    
    -- Feral abilities
    ["Bash"] = {["handler"] = IWBSpellBase, ["auto_target"] = true},
    ["Claw"] = {["handler"] = IWBSpellBase, ["auto_target"] = true},
    ["Rake"] = {["handler"] = IWBSpellBase, ["auto_target"] = true},
    ["Ravage"] = {["handler"] = IWBSpellBase, ["auto_target"] = true},
    ["Shred"] = {["handler"] = IWBSpellBase, ["auto_target"] = true},
}