-- Priest class spells
IWB_PRIEST_SPELL_REF = {
	["Divine Spirit"] = {["handler"] = IWBBuff, ["alias"] = "Prayer of Spirit"},
	["Fear Ward"] = {["handler"] = IWBBuff, ["self_only"] = true},
	["Inner Fire"] = {["handler"] = IWBBuff, ["self_only"] = true},
	["Power Word: Fortitude"] = {["handler"] = IWBBuff, ["alias"] = "Prayer of Fortitude", ["self_only"] = true},
	["Power Word: Shield"] = {["handler"] = IWBBuffWithDebuff, ["debuff"] = "Weakened Soul", ["self_only"] = true},
	["Prayer of Fortitude"] = {["handler"] = IWBBuff, ["self_only"] = true},
	["Prayer of Spirit"] = {["handler"] = IWBBuff, ["self_only"] = true},
	["Shadow Protection"] = {["handler"] = IWBBuff, ["self_only"] = true},
	["Prayer of Shadow Protection"] = {["handler"] = IWBBuff, ["self_only"] = true},
	["Mind Flay"] = {["handler"] = IWBChanneled},
	["Holy Fire"] = {["handler"] = IWBDebuffOrSpell},
	["Shadow Word: Pain"] = {["handler"] = IWBDebuffDot, ["duration"] = 18, ["target_hp"] = true},
}