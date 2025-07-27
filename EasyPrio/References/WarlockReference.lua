-- Warlock class spells
IWB_WARLOCK_SPELL_REF = {
	["Corruption"] = {["handler"] = IWBDebuffDot, ["duration"] = 15, ["target_hp"] = true},
	["Curse of Agony"] = {["handler"] = IWBDebuffDot, ["duration"] = 24, ["target_hp"] = true},
	["Curse of Recklessness"] = {["handler"] = IWBDebuff},
	["Curse of Shadow"] = {["handler"] = IWBDebuff},
	["Curse of Tongues"] = {["handler"] = IWBDebuff},
	["Curse of the Elements"] = {["handler"] = IWBDebuff},
	["Immolate"] = {["handler"] = IWBDebuffDot, ["duration"] = 15, ["target_hp"] = true},
	["Siphon Life"] = {["handler"] = IWBDebuff},
	["Curse of Exhaustion"] = {["handler"] = IWBDebuff},
	
	["Drain Life"] = {["handler"] = IWBChanneled},
	["Drain Mana"] = {["handler"] = IWBChanneled},
	["Drain Soul"] = {["handler"] = IWBChanneled},
	["Health Funnel"] = {["handler"] = IWBChanneled},
	["Mana Funnel"] = {["handler"] = IWBChanneled},
	["Dark Harvest"] = {["handler"] = IWBChanneled},
	
	["Demon Armor"] = {["handler"] = IWBBuff},
	["Detect Greater Invisibility"] = {["handler"] = IWBBuff},
	["Detect Invisibility"] = {["handler"] = IWBBuff},
	["Detect Lesser Invisibility"] = {["handler"] = IWBBuff},
	["Unending Breath"] = {["handler"] = IWBBuff},
}