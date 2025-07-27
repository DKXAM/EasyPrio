-- Paladin class spells
IWB_PALADIN_SPELL_REF = {
	["Seal of Light"] = {["handler"] = IWBSeal, ["debuff"] = "Judgement of Light"},
	["Seal of Wisdom"] = {["handler"] = IWBSeal, ["debuff"] = "Judgement of Wisdom"},
	["Seal of the Crusader"] = {["handler"] = IWBSeal, ["debuff"] = "Judgement of the Crusader"},
	["Seal of Justice"] = {["handler"] = IWBSeal, ["debuff"] = "Judgement of Justice"},
	["Seal of Righteousness"] = {["handler"] = IWBSeal},
	["Seal of Command"] = {["handler"] = IWBSeal},
	
	["Blessing of Wisdom"] = {["handler"] = IWBBuff, ["alias"] = "Greater Blessing of Wisdom"},
	["Greater Blessing of Wisdom"] = {["handler"] = IWBBuff},
	["Blessing of Light"] = {["handler"] = IWBBuff},
	["Sense Undead"] = {["handler"] = IWBBuff},
	["Blessing of Salvation"] = {["handler"] = IWBBuff},
	["Concentration Aura"] = {["handler"] = IWBBuff},
	["Devotion Aura"] = {["handler"] = IWBBuff},
	["Righteous Fury"] = {["handler"] = IWBBuff},
										   
	["Divine Protection"] = {["handler"] = IWBBuffWithDebuff, ["debuff"] = "Forbearance"},
	["Divine Shield"] = {["handler"] = IWBBuffWithDebuff, ["debuff"] = "Forbearance"},
	["Hand of Protection"] = {["handler"] = IWBBuffWithDebuff, ["debuff"] = "Forbearance"},
	
	["Blessing of Kings"] = {["handler"] = IWBBuff, ["alias"] = "Greater Blessing of Kings"},
	["Greater Blessing of Kings"] = {["handler"] = IWBBuff},
	["Blessing of Might"] = {["handler"] = IWBBuff, ["alias"] = "Greater Blessing of Might"},
	["Greater Blessing of Might"] = {["handler"] = IWBBuff},
	["Retribution Aura"] = {["handler"] = IWBBuff},
	["Blessing of Sanctuary"] = {["handler"] = IWBBuff},
	
	["Holy Strike"] = {["handler"] = IWBNextMelee, ["auto_target"] = true},
	["Crusader Strike"] = {["handler"] = IWBSpellBase, ["auto_target"] = true},
	["Judgement"] = {["handler"] = IWBSpellBase, ["auto_target"] = true},
}