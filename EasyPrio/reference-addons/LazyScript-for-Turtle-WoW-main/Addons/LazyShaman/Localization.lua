﻿lazyShamanLoad.metadata:updateRevisionFromKeyword("$Revision: 474 $")

function lazyShamanLoad.LoadShamanLocalization(locale)

	lazyShamanLocale.enUS.ACTION_TTS.bloodlust            = "Bloodlust"
	lazyShamanLocale.enUS.ACTION_TTS.earthShock           = "Earth Shock"
	lazyShamanLocale.enUS.ACTION_TTS.earthShield          = "Earth Shield"
	lazyShamanLocale.enUS.ACTION_TTS.flameShock           = "Flame Shock"
	lazyShamanLocale.enUS.ACTION_TTS.frostShock           = "Frost Shock"
	lazyShamanLocale.enUS.ACTION_TTS.rockbiter            = "Rockbiter Weapon"
	lazyShamanLocale.enUS.ACTION_TTS.flametongue          = "Flametongue Weapon"
	lazyShamanLocale.enUS.ACTION_TTS.frostbrand           = "Frostbrand Weapon"
	lazyShamanLocale.enUS.ACTION_TTS.windfury             = "Windfury Weapon"
	lazyShamanLocale.enUS.ACTION_TTS.chainHeal            = "Chain Heal"
	lazyShamanLocale.enUS.ACTION_TTS.chainLight           = "Chain Lightning"
	lazyShamanLocale.enUS.ACTION_TTS.cureDisease          = "Cure Disease"
	lazyShamanLocale.enUS.ACTION_TTS.curePoison           = "Cure Poison"
	lazyShamanLocale.enUS.ACTION_TTS.elemMastery          = "Elemental Mastery"
	lazyShamanLocale.enUS.ACTION_TTS.ghostWolf            = "Ghost Wolf"
	lazyShamanLocale.enUS.ACTION_TTS.heal                 = "Healing Wave"
	lazyShamanLocale.enUS.ACTION_TTS.lesserHeal           = "Lesser Healing Wave"
	lazyShamanLocale.enUS.ACTION_TTS.lightBolt            = "Lightning Bolt"
	lazyShamanLocale.enUS.ACTION_TTS.lightShield          = "Lightning Shield"
	lazyShamanLocale.enUS.ACTION_TTS.natureSwift          = "Nature's Swiftness"
	lazyShamanLocale.enUS.ACTION_TTS.purge                = "Purge"
	lazyShamanLocale.enUS.ACTION_TTS.fbdj                 = "Stormstrike"
	lazyShamanLocale.enUS.ACTION_TTS.sddj                 = "Lightning Strike"
	lazyShamanLocale.enUS.ACTION_TTS.lhlj                 = "Spirit Link"
	lazyShamanLocale.enUS.ACTION_TTS.totemRecall          = "Totemic Recall"
	lazyShamanLocale.enUS.ACTION_TTS.waterShield          = "Water Shield"

	lazyShamanLocale.enUS.ACTION_TTS.diseaseTotem         = "Disease Cleansing Totem"
	lazyShamanLocale.enUS.ACTION_TTS.bindTotem            = "Earthbind Totem"
	lazyShamanLocale.enUS.ACTION_TTS.fireNovaTotem        = "Fire Nova Totem"
	lazyShamanLocale.enUS.ACTION_TTS.fireResistTotem      = "Fire Resistance Totem"
	lazyShamanLocale.enUS.ACTION_TTS.flameTotem           = "Flametongue Totem"
	lazyShamanLocale.enUS.ACTION_TTS.frostResistTotem     = "Frost Resistance Totem"
	lazyShamanLocale.enUS.ACTION_TTS.graceTotem           = "Grace of Air Totem"
	lazyShamanLocale.enUS.ACTION_TTS.groundingTotem       = "Grounding Totem"
	lazyShamanLocale.enUS.ACTION_TTS.hsTotem              = "Healing Stream Totem"
	lazyShamanLocale.enUS.ACTION_TTS.magmaTotem           = "Magma Totem"
	lazyShamanLocale.enUS.ACTION_TTS.msTotem              = "Mana Spring Totem"
	lazyShamanLocale.enUS.ACTION_TTS.mtTotem              = "Mana Tide Totem"
	lazyShamanLocale.enUS.ACTION_TTS.natureResistTotem    = "Nature Resistance Totem"
	lazyShamanLocale.enUS.ACTION_TTS.poisonTotem          = "Poison Cleansing Totem"
	lazyShamanLocale.enUS.ACTION_TTS.searingTotem         = "Searing Totem"
	lazyShamanLocale.enUS.ACTION_TTS.sentryTotem          = "Sentry Totem"
	lazyShamanLocale.enUS.ACTION_TTS.clawTotem            = "Stoneclaw Totem"
	lazyShamanLocale.enUS.ACTION_TTS.skinTotem            = "Stoneskin Totem"
	lazyShamanLocale.enUS.ACTION_TTS.strengthTotem        = "Strength of Earth Totem"
	lazyShamanLocale.enUS.ACTION_TTS.tranquilTotem        = "Tranquil Air Totem"
	lazyShamanLocale.enUS.ACTION_TTS.tremorTotem          = "Tremor Totem"
	lazyShamanLocale.enUS.ACTION_TTS.wfTotem              = "Windfury Totem"
	lazyShamanLocale.enUS.ACTION_TTS.windwallTotem        = "Windwall Totem"

	-- LazyShaman.lua
	SHAMAN_ADDON_LOADED = " loaded. Powered by "

	-- ParseShaman.lua
	function lazyShaman.CustomLocaleHelp() return [[<H2>Shaman Criteria:</H2>]] end

	if (locale == "zhCN") then
		lazyShamanLocale.zhCN.ACTION_TTS.bloodlust            = "嗜血"
		lazyShamanLocale.zhCN.ACTION_TTS.earthShock           = "地震术"
		lazyShamanLocale.zhCN.ACTION_TTS.earthShield          = "大地之盾"
		lazyShamanLocale.zhCN.ACTION_TTS.flameShock           = "烈焰震击"
		lazyShamanLocale.zhCN.ACTION_TTS.frostShock           = "冰霜震击"
		lazyShamanLocale.zhCN.ACTION_TTS.rockbiter            = "石化武器"
		lazyShamanLocale.zhCN.ACTION_TTS.flametongue          = "火舌武器"
		lazyShamanLocale.zhCN.ACTION_TTS.frostbrand           = "冰封武器"
		lazyShamanLocale.zhCN.ACTION_TTS.windfury             = "风怒武器"
		lazyShamanLocale.zhCN.ACTION_TTS.chainHeal            = "治疗链"
		lazyShamanLocale.zhCN.ACTION_TTS.chainLight           = "闪电链"
		lazyShamanLocale.zhCN.ACTION_TTS.cureDisease          = "祛病术"
		lazyShamanLocale.zhCN.ACTION_TTS.curePoison           = "消毒术"
		lazyShamanLocale.zhCN.ACTION_TTS.elemMastery          = "元素掌握"
		lazyShamanLocale.zhCN.ACTION_TTS.ghostWolf            = "幽魂之狼"
		lazyShamanLocale.zhCN.ACTION_TTS.heal                 = "治疗波"
		lazyShamanLocale.zhCN.ACTION_TTS.lesserHeal           = "次级治疗波"
		lazyShamanLocale.zhCN.ACTION_TTS.lightBolt            = "闪电箭"
		lazyShamanLocale.zhCN.ACTION_TTS.lightShield          = "闪电之盾"
		lazyShamanLocale.zhCN.ACTION_TTS.natureSwift          = "自然迅捷"
		lazyShamanLocale.zhCN.ACTION_TTS.purge                = "净化术"
		lazyShamanLocale.zhCN.ACTION_TTS.fbdj                 = "风暴打击"
		lazyShamanLocale.zhCN.ACTION_TTS.sddj                 = "闪电打击"
		lazyShamanLocale.zhCN.ACTION_TTS.lhlj                 = "灵魂链接"
		lazyShamanLocale.zhCN.ACTION_TTS.totemRecall          = "收回图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.waterShield          = "水之护盾"

		lazyShamanLocale.zhCN.ACTION_TTS.diseaseTotem         = "祛病图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.bindTotem            = "地缚图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.fireNovaTotem        = "火焰新星图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.fireResistTotem      = "火焰抗性"
		lazyShamanLocale.zhCN.ACTION_TTS.flameTotem           = "火舌图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.frostResistTotem     = "抗寒图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.graceTotem           = "风之优雅图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.groundingTotem       = "根基图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.hsTotem              = "治疗之泉图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.magmaTotem           = "熔岩图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.msTotem              = "法力之泉图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.mtTotem              = "法力之潮图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.natureResistTotem    = "自然抗性图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.poisonTotem          = "清毒图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.searingTotem         = "灼热图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.sentryTotem          = "岗哨图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.clawTotem            = "石爪图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.skinTotem            = "石肤图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.strengthTotem        = "大地之力图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.tranquilTotem        = "宁静之风图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.tremorTotem          = "战栗图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.wfTotem              = "风怒图腾"
		lazyShamanLocale.zhCN.ACTION_TTS.windwallTotem        = "风墙图腾"

	end
end
