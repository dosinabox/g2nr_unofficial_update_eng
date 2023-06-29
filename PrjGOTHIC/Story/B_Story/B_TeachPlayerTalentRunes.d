
func string B_BuildRunesIngredientsText(var string spell,var string ingredients)
{
	var string text;
	text = ConcatStrings("Ingretients for the rune '",spell);
	text = ConcatStrings(text,"': ");
	text = ConcatStrings(text,ingredients);
	return text;
};

func int B_TeachPlayerTalentRunes(var C_Npc slf,var C_Npc oth,var int spell)
{
	var int kosten;
	var C_Npc ScrollTrader;
	var string text;
	kosten = B_GetLearnCostTalent(oth,NPC_TALENT_RUNES,spell);
	if(oth.lp < kosten)
	{
		PrintScreen(PRINT_NotEnoughLP,-1,-1,FONT_ScreenSmall,2);
		B_Say(slf,oth,"$NOLEARNNOPOINTS");
		return FALSE;
	};
	oth.lp -= kosten;
	if(Npc_GetTalentSkill(oth,NPC_TALENT_RUNES) == 0)
	{
		Npc_SetTalentSkill(oth,NPC_TALENT_RUNES,1);
		Log_CreateTopic(TOPIC_TalentRunes,LOG_NOTE);
		Log_AddEntry(TOPIC_TalentRunes,"To create a rune I need the scroll for the spell and certain ingredients for each rune. Using those ingredients and a blank runestone I can create the desired rune at a rune table.");
	};
	if(CurrentLevel == NEWWORLD_ZEN)
	{
		if(!Npc_IsDead(Gorax))
		{
			ScrollTrader = Hlp_GetNpc(Gorax);
		}
		else if(!Npc_IsDead(Isgaroth))
		{
			ScrollTrader = Hlp_GetNpc(Isgaroth);
		}
		else if(!Npc_IsDead(Orlan))
		{
			ScrollTrader = Hlp_GetNpc(Orlan);
		};
	}
	else if(CurrentLevel == OLDWORLD_ZEN)
	{
		if(!Npc_IsDead(Engor))
		{
			ScrollTrader = Hlp_GetNpc(Engor);
		};
	}
	else if(CurrentLevel == ADDONWORLD_ZEN)
	{
		if(!Npc_IsDead(Cronos_ADW))
		{
			ScrollTrader = Hlp_GetNpc(Cronos_ADW);
		};
	};
	if(spell == SPL_Light)
	{
		PLAYER_TALENT_RUNES[SPL_Light] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Light))
		{
			CreateInvItems(ScrollTrader,ItSc_Light,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Light,"1 Gold Coin."));
	};
	if(spell == SPL_Firebolt)
	{
		PLAYER_TALENT_RUNES[SPL_Firebolt] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Firebolt))
		{
			CreateInvItems(ScrollTrader,ItSc_Firebolt,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Firebolt,"1 Sulfur."));
	};
	if(spell == SPL_Icebolt)
	{
		PLAYER_TALENT_RUNES[SPL_Icebolt] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Icebolt))
		{
			CreateInvItems(ScrollTrader,ItSc_Icebolt,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Icebolt,"1 Glacier Quartz."));
	};
	if(spell == SPL_LightHeal)
	{
		PLAYER_TALENT_RUNES[SPL_LightHeal] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_LightHeal))
		{
			CreateInvItems(ScrollTrader,ItSc_LightHeal,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_LightHeal,"1 Healing Herb."));
	};
	if(spell == SPL_SummonGoblinSkeleton)
	{
		PLAYER_TALENT_RUNES[SPL_SummonGoblinSkeleton] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_SumGobSkel))
		{
			CreateInvItems(ScrollTrader,ItSc_SumGobSkel,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_SummonGoblinSkeleton,"1 Goblin Bone."));
	};
	if(spell == SPL_InstantFireball)
	{
		PLAYER_TALENT_RUNES[SPL_InstantFireball] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_InstantFireball))
		{
			CreateInvItems(ScrollTrader,ItSc_InstantFireball,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_InstantFireball,"1 Pitch."));
	};
	if(spell == SPL_Zap)
	{
		PLAYER_TALENT_RUNES[SPL_Zap] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Zap))
		{
			CreateInvItems(ScrollTrader,ItSc_Zap,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Zap,"1 Rock Crystal."));
	};
	if(spell == SPL_SummonWolf)
	{
		PLAYER_TALENT_RUNES[SPL_SummonWolf] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_SumWolf))
		{
			CreateInvItems(ScrollTrader,ItSc_SumWolf,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_SummonWolf,"1 Wolf Skin."));
	};
	if(spell == SPL_WindFist)
	{
		PLAYER_TALENT_RUNES[SPL_WindFist] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Windfist))
		{
			CreateInvItems(ScrollTrader,ItSc_Windfist,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_WindFist,"1 Coal."));
	};
	if(spell == SPL_Sleep)
	{
		PLAYER_TALENT_RUNES[SPL_Sleep] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Sleep))
		{
			CreateInvItems(ScrollTrader,ItSc_Sleep,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Sleep,"1 Swampweed."));
	};
	if(spell == SPL_MediumHeal)
	{
		PLAYER_TALENT_RUNES[SPL_MediumHeal] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_MediumHeal))
		{
			CreateInvItems(ScrollTrader,ItSc_MediumHeal,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_MediumHeal,"1 Healing Plant."));
	};
	if(spell == SPL_LightningFlash)
	{
		PLAYER_TALENT_RUNES[SPL_LightningFlash] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_LightningFlash))
		{
			CreateInvItems(ScrollTrader,ItSc_LightningFlash,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_LightningFlash,"1 Rock Crystal and 1 Glacier Quartz."));
	};
	if(spell == SPL_ChargeFireball)
	{
		PLAYER_TALENT_RUNES[SPL_ChargeFireball] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_ChargeFireBall))
		{
			CreateInvItems(ScrollTrader,ItSc_ChargeFireBall,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_ChargeFireball,"1 Sulfur and 1 Pitch."));
	};
	if(spell == SPL_SummonSkeleton)
	{
		PLAYER_TALENT_RUNES[SPL_SummonSkeleton] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_SumSkel))
		{
			CreateInvItems(ScrollTrader,ItSc_SumSkel,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_SummonSkeleton,"1 Skeleton Bone."));
	};
	if(spell == SPL_Fear)
	{
		PLAYER_TALENT_RUNES[SPL_Fear] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Fear))
		{
			CreateInvItems(ScrollTrader,ItSc_Fear,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Fear,"1 Black Pearl."));
	};
	if(spell == SPL_IceCube)
	{
		PLAYER_TALENT_RUNES[SPL_IceCube] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_IceCube))
		{
			CreateInvItems(ScrollTrader,ItSc_IceCube,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_IceCube,"1 Glacier Quartz and 1 Aquamarine."));
	};
	if(spell == SPL_ChargeZap)
	{
		PLAYER_TALENT_RUNES[SPL_ChargeZap] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_ThunderBall))
		{
			CreateInvItems(ScrollTrader,ItSc_ThunderBall,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_ChargeZap,"1 Sulfur and 1 Rock Crystal."));
	};
	if(spell == SPL_SummonGolem)
	{
		PLAYER_TALENT_RUNES[SPL_SummonGolem] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_SumGol))
		{
			CreateInvItems(ScrollTrader,ItSc_SumGol,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_SummonGolem,"1 Heart of a Stone Golem."));
	};
	if(spell == SPL_DestroyUndead)
	{
		PLAYER_TALENT_RUNES[SPL_DestroyUndead] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_HarmUndead))
		{
			CreateInvItems(ScrollTrader,ItSc_HarmUndead,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_DestroyUndead,"1 Holy Water."));
	};
	if(spell == SPL_Pyrokinesis)
	{
		PLAYER_TALENT_RUNES[SPL_Pyrokinesis] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Pyrokinesis))
		{
			CreateInvItems(ScrollTrader,ItSc_Pyrokinesis,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Pyrokinesis,"1 Sulfur and 1 Tongue of Fire."));
	};
	if(spell == SPL_Firestorm)
	{
		PLAYER_TALENT_RUNES[SPL_Firestorm] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Firestorm))
		{
			CreateInvItems(ScrollTrader,ItSc_Firestorm,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Firestorm,"1 Sulfur and 1 pitch."));
	};
	if(spell == SPL_IceWave)
	{
		PLAYER_TALENT_RUNES[SPL_IceWave] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_IceWave))
		{
			CreateInvItems(ScrollTrader,ItSc_IceWave,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_IceWave,"1 Glacier Quartz and 1 Aquamarine"));
	};
	if(spell == SPL_SummonDemon)
	{
		PLAYER_TALENT_RUNES[SPL_SummonDemon] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_SumDemon))
		{
			CreateInvItems(ScrollTrader,ItSc_SumDemon,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_SummonDemon,"1 Demon Heart."));
	};
	if(spell == SPL_FullHeal)
	{
		PLAYER_TALENT_RUNES[SPL_FullHeal] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_FullHeal))
		{
			CreateInvItems(ScrollTrader,ItSc_FullHeal,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_FullHeal,"1 Healing Root."));
	};
	if(spell == SPL_Firerain)
	{
		PLAYER_TALENT_RUNES[SPL_Firerain] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Firerain))
		{
			CreateInvItems(ScrollTrader,ItSc_Firerain,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Firerain,"1 Pitch, 1 Sulfur and 1 Tongue of Fire."));
	};
	if(spell == SPL_BreathOfDeath)
	{
		PLAYER_TALENT_RUNES[SPL_BreathOfDeath] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_BreathOfDeath))
		{
			CreateInvItems(ScrollTrader,ItSc_BreathOfDeath,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_BreathOfDeath,"1 Skeletonbone and 1 Black Perl"));
	};
	if(spell == SPL_MassDeath)
	{
		PLAYER_TALENT_RUNES[SPL_MassDeath] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_MassDeath))
		{
			CreateInvItems(ScrollTrader,ItSc_MassDeath,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_MassDeath,"1 Skeletonbone and 1 Black Perl"));
	};
	if(spell == SPL_ArmyOfDarkness)
	{
		PLAYER_TALENT_RUNES[SPL_ArmyOfDarkness] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_ArmyOfDarkness))
		{
			CreateInvItems(ScrollTrader,ItSc_ArmyOfDarkness,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_ArmyOfDarkness,"1 Skeletonbone and 1 Black Perl, 1 Heart of a Stone Golem and 1 Demon Heart."));
	};
	if(spell == SPL_Shrink)
	{
		PLAYER_TALENT_RUNES[SPL_Shrink] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Shrink))
		{
			CreateInvItems(ScrollTrader,ItSc_Shrink,1);
		};
		if(!Npc_IsDead(Constantino) && !Npc_HasItems(Constantino,ItAt_GoblinBone))
		{
			CreateInvItems(Constantino,ItAt_GoblinBone,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Shrink,"1 Goblinbone and 1 Trolltooth"));
	};
	if(spell == SPL_Whirlwind)
	{
		PLAYER_TALENT_RUNES[SPL_Whirlwind] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Whirlwind))
		{
			CreateInvItems(ScrollTrader,ItSc_Whirlwind,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Whirlwind,"1 wing from a Bloodfly."));
	};
	if(spell == SPL_WaterFist)
	{
		PLAYER_TALENT_RUNES[SPL_WaterFist] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Waterfist))
		{
			CreateInvItems(ScrollTrader,ItSc_Waterfist,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_WaterFist,"1 Aquamarine and 1 Rock Crystal."));
	};
	if(spell == SPL_IceLance)
	{
		PLAYER_TALENT_RUNES[SPL_IceLance] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Icelance))
		{
			CreateInvItems(ScrollTrader,ItSc_Icelance,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_IceLance,"1 Glacier Quartz."));
	};
	if(spell == SPL_Geyser)
	{
		PLAYER_TALENT_RUNES[SPL_Geyser] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Geyser))
		{
			CreateInvItems(ScrollTrader,ItSc_Geyser,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Geyser,"1 Aquamarine."));
	};
	if(spell == SPL_Thunderstorm)
	{
		PLAYER_TALENT_RUNES[SPL_Thunderstorm] = TRUE;
		if(!Npc_HasItems(ScrollTrader,ItSc_Thunderstorm))
		{
			CreateInvItems(ScrollTrader,ItSc_Thunderstorm,1);
		};
		B_LogEntry(TOPIC_TalentRunes,B_BuildRunesIngredientsText(NAME_SPL_Thunderstorm,"1 Glacier Quartz and 1 wing from a Bloodfly."));
	};
	PrintScreen(PRINT_LearnRunes,-1,-1,FONT_Screen,2);
	return TRUE;
};


func int B_TeachPlayerPalRunes(var C_Npc slf,var C_Npc oth,var int spell)
{
	var int kosten;
	kosten = B_GetLearnCostTalent(oth,NPC_TALENT_RUNES,spell);
	if(oth.lp < kosten)
	{
		PrintScreen(PRINT_NotEnoughLP,-1,-1,FONT_ScreenSmall,2);
		B_Say(slf,oth,"$NOLEARNNOPOINTS");
		return FALSE;
	};
	oth.lp -= kosten;
	if(spell == SPL_PalLight)
	{
		PLAYER_TALENT_RUNES[SPL_PalLight] = TRUE;
		CreateInvItems(slf,ItRu_PalLight,1);
		B_GiveInvItems(slf,oth,ItRu_PalLight,1);
	};
	if(spell == SPL_PalLightHeal)
	{
		PLAYER_TALENT_RUNES[SPL_PalLightHeal] = TRUE;
		CreateInvItems(slf,ItRu_PalLightHeal,1);
		B_GiveInvItems(slf,oth,ItRu_PalLightHeal,1);
	};
	if(spell == SPL_PalHolyBolt)
	{
		PLAYER_TALENT_RUNES[SPL_PalHolyBolt] = TRUE;
		CreateInvItems(slf,ItRu_PalHolyBolt,1);
		B_GiveInvItems(slf,oth,ItRu_PalHolyBolt,1);
	};
	if(spell == SPL_PalMediumHeal)
	{
		PLAYER_TALENT_RUNES[SPL_PalMediumHeal] = TRUE;
		CreateInvItems(slf,ItRu_PalMediumHeal,1);
		B_GiveInvItems(slf,oth,ItRu_PalMediumHeal,1);
	};
	if(spell == SPL_PalRepelEvil)
	{
		PLAYER_TALENT_RUNES[SPL_PalRepelEvil] = TRUE;
		CreateInvItems(slf,ItRu_PalRepelEvil,1);
		B_GiveInvItems(slf,oth,ItRu_PalRepelEvil,1);
	};
	if(spell == SPL_PalFullHeal)
	{
		PLAYER_TALENT_RUNES[SPL_PalFullHeal] = TRUE;
		CreateInvItems(slf,ItRu_PalFullHeal,1);
		B_GiveInvItems(slf,oth,ItRu_PalFullHeal,1);
	};
	if(spell == SPL_PalDestroyEvil)
	{
		PLAYER_TALENT_RUNES[SPL_PalDestroyEvil] = TRUE;
		CreateInvItems(slf,ItRu_PalDestroyEvil,1);
		B_GiveInvItems(slf,oth,ItRu_PalDestroyEvil,1);
	};
	return TRUE;
};

