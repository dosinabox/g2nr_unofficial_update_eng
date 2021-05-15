
instance DIA_Milten_DI_EXIT(C_Info)
{
	npc = PC_Mage_DI;
	nr = 999;
	condition = DIA_Milten_DI_EXIT_Condition;
	information = DIA_Milten_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Milten_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Milten_DI_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Milten_DI_Hello(C_Info)
{
	npc = PC_Mage_DI;
	nr = 3;
	condition = DIA_Milten_DI_Hello_Condition;
	information = DIA_Milten_DI_Hello_Info;
	description = "Just like in the old days.";
};


func int DIA_Milten_DI_Hello_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Milten_DI_Hello_Info()
{
	AI_Output (other, self, "DIA_Milten_DI_Hello_15_00");	//Just like in the old days.
	AI_Output (self, other, "DIA_Milten_DI_Hello_03_01");	//You said it. I'm curious to see whether you'll pull it off this time.
	AI_Output (other, self, "DIA_Milten_DI_Hello_15_02");	//What?
	AI_Output (self, other, "DIA_Milten_DI_Hello_03_03");	//To save your butt before all hell breaks loose around you again.
};


instance DIA_Milten_DI_TRADE(C_Info)
{
	npc = PC_Mage_DI;
	nr = 12;
	condition = DIA_Milten_DI_TRADE_Condition;
	information = DIA_Milten_DI_TRADE_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "Got a few potions to spare?";
};


func int DIA_Milten_DI_TRADE_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && Npc_KnowsInfo(other,DIA_Milten_DI_Hello))
	{
		return TRUE;
	};
};

func void DIA_Milten_DI_TRADE_Info()
{
	AI_Output (other, self, "DIA_Milten_DI_TRADE_15_00");	//Got a few potions to spare?
	B_GiveTradeInv (self);
	Npc_RemoveInvItems (self, ItPo_Health_02, Npc_HasItems (self, ItPo_Health_02));
	CreateInvItems (self, ItPo_Health_02, 15);
	Npc_RemoveInvItems (self, ItPo_Mana_02, Npc_HasItems (self, ItPo_Mana_02));
	CreateInvItems (self, ItPo_Mana_02, 15);
	AI_Output (self, other, "DIA_Milten_DI_TRADE_03_01");	//While supplies last.
	Trade_IsActive = TRUE;
};


instance DIA_Milten_DI_Rat(C_Info)
{
	npc = PC_Mage_DI;
	nr = 3;
	condition = DIA_Milten_DI_Rat_Condition;
	information = DIA_Milten_DI_Rat_Info;
	description = "What advice can you give me?";
};


func int DIA_Milten_DI_Rat_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && Npc_KnowsInfo(other,DIA_Milten_DI_Hello))
	{
		return TRUE;
	};
};

func void DIA_Milten_DI_Rat_Info()
{
	AI_Output (other, self, "DIA_Milten_DI_Rat_15_00");	//What advice can you give me?
	AI_Output (self, other, "DIA_Milten_DI_Rat_03_01");	//Mmh. It is a great honor that you should ask me, of all people, for advice. Only one thing has been on my mind the whole time.
	AI_Output (self, other, "DIA_Milten_DI_Rat_03_02");	//Did you bring the Eye of Innos?
	Info_ClearChoices(DIA_Milten_DI_Rat);
	if((SC_InnosEyeVergessen_DI == TRUE) && (XardasDIBagOpened == FALSE))
	{
		Info_AddChoice (DIA_Milten_DI_Rat, "No.", DIA_Milten_DI_Rat_nein);
	}
	else
	{
		Info_AddChoice (DIA_Milten_DI_Rat, "Of course.", DIA_Milten_DI_Rat_ja);
	};
};

func void DIA_Milten_DI_Rat_nein()
{
	AI_Output (other, self, "DIA_Milten_DI_Rat_nein_15_00");	//No.
	AI_Output (self, other, "DIA_Milten_DI_Rat_nein_03_01");	//(indignant) You are so ... What will you do then if you encounter dragons here on the island?
	AI_Output (self, other, "DIA_Milten_DI_Rat_nein_03_02");	//Haven't you gotten any wiser by now? We even have an alchemist's bench here, so we can reload the stupid thing.
	AI_Output (self, other, "DIA_Milten_DI_Rat_nein_03_03");	//And what are you doing? I can only hope your sloppiness doesn't cost us our heads.
	Info_ClearChoices (DIA_Milten_DI_Rat);
};

func void DIA_Milten_DI_Rat_ja()
{
	AI_Output (other, self, "DIA_Milten_DI_Rat_ja_15_00");	//Of course.
	AI_Output (self, other, "DIA_Milten_DI_Rat_ja_03_01");	//Sorry, I'm asking such stupid questions. I'm a bit nervous.
	if(SC_InnosEyeVergessen_DI == FALSE)
	{
		B_GivePlayerXP(XP_AmbientKap6);
	};
	Info_ClearChoices(DIA_Milten_DI_Rat);
};


instance DIA_Milten_DI_PEDROTOT(C_Info)
{
	npc = PC_Mage_DI;
	nr = 3;
	condition = DIA_Milten_DI_PEDROTOT_Condition;
	information = DIA_Milten_DI_PEDROTOT_Info;
	description = "I found Pedro.";
};


func int DIA_Milten_DI_PEDROTOT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Pedro_DI_YOU) || Npc_IsDead(Pedro_DI))
	{
		return TRUE;
	};
};

func void DIA_Milten_DI_PEDROTOT_Info()
{
	AI_Output (other, self, "DIA_Milten_DI_PEDROTOT_15_00");	//I found Pedro.
	AI_Output (self, other, "DIA_Milten_DI_PEDROTOT_03_01");	//(surprised) What? Where? Here on the island? Damn, but he is absolutely unbelievable.
	AI_Output (self, other, "DIA_Milten_DI_PEDROTOT_03_02");	//I really had no idea he was such a tough bastard.
	B_GivePlayerXP(XP_AmbientKap6);
	if(Npc_IsDead(Pedro_DI))
	{
		AI_Output (other, self, "DIA_Milten_DI_PEDROTOT_15_03");	//He's dead.
		AI_Output (self, other, "DIA_Milten_DI_PEDROTOT_03_04");	//So? All right. Peace on his soul. Although I can't say that I'm especially sorry, I would have liked to have a word with him nevertheless.
	}
	else
	{
		AI_Output (self, other, "DIA_Milten_DI_PEDROTOT_03_05");	//I've got a bone to pick with him, before too long.
	};
};


func void B_BuildLearnDialog_Milten_DI()
{
	Info_ClearChoices(DIA_Milten_DI_TeachMagic);
	Info_AddChoice(DIA_Milten_DI_TeachMagic,Dialog_Back,DIA_Milten_DI_TeachMagic_BACK);
	Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(PRINT_LearnMANA1,B_GetLearnCostAttribute(other,ATR_MANA_MAX)),DIA_Milten_DI_TeachMagic_MANA_1);
	Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(PRINT_LearnMANA5,B_GetLearnCostAttribute(other,ATR_MANA_MAX) * 5),DIA_Milten_DI_TeachMagic_MANA_5);
	if(hero.guild == GIL_KDF)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,"Create runes.",DIA_Milten_DI_TeachMagic_RUNES);
	}
	else if(hero.guild == GIL_PAL)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,Name_PaladinSpell,DIA_Milten_DI_TeachMagic_RUNES);
	};
};

func void DIA_Milten_RunesComment_01()
{
	AI_Output(self,other,"DIA_Milten_DI_TeachMagic_RUNES_03_00");	///Oh, no! That's really not my specialty, but we'll manage somehow.
};

func void DIA_Milten_RunesComment_02()
{
	AI_Output(self,other,"DIA_Milten_DI_TeachMagic_MANA_1_03_00");	//May the hand of Innos guide you.
};

func void DIA_Milten_RunesComment_03()
{
	AI_Output(self,other,"DIA_Milten_DI_TeachMagic_MANA_5_03_00");	//May the light of Innos illuminate you.
};

var int DIA_Milten_DI_TeachMagic_OneTime;

instance DIA_Milten_DI_TeachMagic(C_Info)
{
	npc = PC_Mage_DI;
	nr = 31;
	condition = DIA_Milten_DI_TeachMagic_Condition;
	information = DIA_Milten_DI_TeachMagic_Info;
	permanent = TRUE;
	description = "I want to improve my magic abilities.";
};


func int DIA_Milten_DI_TeachMagic_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && Npc_KnowsInfo(other,DIA_Milten_DI_Hello))
	{
		return TRUE;
	};
};

func void DIA_Milten_DI_TeachMagic_Info()
{
	AI_Output(other,self,"DIA_Milten_DI_TeachMagic_15_00");	//I want to improve my magic abilities.
	if(OrkSturmDI == FALSE)
	{
		AI_Output (self, other, "DIA_Milten_DI_TeachMagic_03_01");	//I'll do my best.
	}
	else if(DIA_Milten_DI_TeachMagic_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Milten_DI_TeachMagic_03_02");	//I'll help you, but only on the condition that you make sure the orcs stay where they are.
		DIA_Milten_DI_TeachMagic_OneTime = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Milten_DI_TeachMagic_03_03");	//Okay. What do you need?
	};
	B_BuildLearnDialog_Milten_DI();
};

func void DIA_Milten_DI_TeachMagic_MANA_1()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,1,T_HIGH))
	{
		DIA_Milten_RunesComment_02();
		B_BuildLearnDialog_Milten_DI();
	};
};

func void DIA_Milten_DI_TeachMagic_MANA_5()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,5,T_HIGH))
	{
		DIA_Milten_RunesComment_03();
		B_BuildLearnDialog_Milten_DI();
	};
};

func void DIA_Milten_DI_TeachMagic_RUNES()
{
	DIA_Common_WantToLearnNewRunes();
	if(hero.guild == GIL_PAL)
	{
		DIA_Milten_RunesComment_01();
		Info_ClearChoices(DIA_Milten_DI_TeachMagic);
		Info_AddChoice(DIA_Milten_DI_TeachMagic,Dialog_Back,DIA_Milten_DI_TeachMagic_BACK);
		if(PLAYER_TALENT_RUNES[SPL_PalLight] == FALSE)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_PalLight,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalLight)),DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalLight);
		};
		if(PLAYER_TALENT_RUNES[SPL_PalLightHeal] == FALSE)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_PalLightHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalLightHeal)),DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalLightHeal);
		};
		if(PLAYER_TALENT_RUNES[SPL_PalHolyBolt] == FALSE)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_PalHolyBolt,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalHolyBolt)),DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalHolyBolt);
		};
		if(PLAYER_TALENT_RUNES[SPL_PalMediumHeal] == FALSE)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_PalMediumHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalMediumHeal)),DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalMediumHeal);
		};
		if(PLAYER_TALENT_RUNES[SPL_PalRepelEvil] == FALSE)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_PalRepelEvil,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalRepelEvil)),DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalRepelEvil);
		};
		if(PLAYER_TALENT_RUNES[SPL_PalFullHeal] == FALSE)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_PalFullHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalFullHeal)),DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalFullHeal);
		};
		if(PLAYER_TALENT_RUNES[SPL_PalDestroyEvil] == FALSE)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_PalDestroyEvil,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalDestroyEvil)),DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalDestroyEvil);
		};
	}
	else if(Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) >= 4)
	{
		Info_ClearChoices(DIA_Milten_DI_TeachMagic);
		Info_AddChoice(DIA_Milten_DI_TeachMagic,Dialog_Back,DIA_Milten_DI_TeachMagic_BACK);
		Info_AddChoice(DIA_Milten_DI_TeachMagic,NAME_Circle_4,DIA_Milten_DI_TeachMagic_Runen_Circle_4);
		if(Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) >= 5)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,NAME_Circle_5,DIA_Milten_DI_TeachMagic_Runen_Circle_5);
		};
		if(Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) >= 6)
		{
			Info_AddChoice(DIA_Milten_DI_TeachMagic,NAME_Circle_6,DIA_Milten_DI_TeachMagic_Runen_Circle_6);
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Milten_DI_TeachMagic_RUNES_03_01");	//Oh. You still aren't quite ready. First learn the higher circles, then I can help you.
	};
};

func void DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalLight()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalLight);
};

func void DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalLightHeal()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalLightHeal);
};

func void DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalHolyBolt()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalHolyBolt);
};

func void DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalMediumHeal()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalMediumHeal);
};

func void DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalRepelEvil()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalRepelEvil);
};

func void DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalFullHeal()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalFullHeal);
};

func void DIA_Milten_DI_TeachMagic_Runen_Paladin_SPL_PalDestroyEvil()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalDestroyEvil);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_4()
{
	Info_ClearChoices(DIA_Milten_DI_TeachMagic);
	Info_AddChoice(DIA_Milten_DI_TeachMagic,Dialog_Back,DIA_Milten_DI_TeachMagic_BACK);
	if(PLAYER_TALENT_RUNES[SPL_SummonGolem] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_SummonGolem,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_SummonGolem)),DIA_Milten_DI_TeachMagic_Runen_Circle_4_SPL_SummonGolem);
	};
	if(PLAYER_TALENT_RUNES[SPL_DestroyUndead] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_DestroyUndead,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_DestroyUndead)),DIA_Milten_DI_TeachMagic_Runen_Circle_4_SPL_DestroyUndead);
	};
	if(PLAYER_TALENT_RUNES[SPL_LightningFlash] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_LightningFlash,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_LightningFlash)),DIA_Milten_DI_TeachMagic_Runen_Circle_4_SPL_LightningFlash);
	};
	if(PLAYER_TALENT_RUNES[SPL_ChargeFireball] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_ChargeFireball,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_ChargeFireball)),DIA_Milten_DI_TeachMagic_Runen_Circle_4_SPL_ChargeFireball);
	};
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_4_SPL_ChargeFireball()
{
	B_TeachPlayerTalentRunes(self,other,SPL_ChargeFireball);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_4_SPL_SummonGolem()
{
	B_TeachPlayerTalentRunes(self,other,SPL_SummonGolem);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_4_SPL_DestroyUndead()
{
	B_TeachPlayerTalentRunes(self,other,SPL_DestroyUndead);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_4_SPL_LightningFlash()
{
	B_TeachPlayerTalentRunes(self,other,SPL_LightningFlash);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_5()
{
	Info_ClearChoices(DIA_Milten_DI_TeachMagic);
	Info_AddChoice(DIA_Milten_DI_TeachMagic,Dialog_Back,DIA_Milten_DI_TeachMagic_BACK);
	if(PLAYER_TALENT_RUNES[SPL_IceWave] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_IceWave,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_IceWave)),DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_IceWave);
	};
	if(PLAYER_TALENT_RUNES[SPL_SummonDemon] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_SummonDemon,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_SummonDemon)),DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_SummonDemon);
	};
	if(PLAYER_TALENT_RUNES[SPL_FullHeal] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_FullHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_FullHeal)),DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_FullHeal);
	};
	if(PLAYER_TALENT_RUNES[SPL_Pyrokinesis] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_Pyrokinesis,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Pyrokinesis)),DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_Pyrokinesis);
	};
	if(PLAYER_TALENT_RUNES[SPL_Shrink] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_Shrink,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Shrink)),DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_Shrink);
	};
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_Pyrokinesis()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Pyrokinesis);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_IceWave()
{
	B_TeachPlayerTalentRunes(self,other,SPL_IceWave);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_SummonDemon()
{
	B_TeachPlayerTalentRunes(self,other,SPL_SummonDemon);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_FullHeal()
{
	B_TeachPlayerTalentRunes(self,other,SPL_FullHeal);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_5_SPL_Shrink()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Shrink);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_6()
{
	Info_ClearChoices(DIA_Milten_DI_TeachMagic);
	Info_AddChoice(DIA_Milten_DI_TeachMagic,Dialog_Back,DIA_Milten_DI_TeachMagic_BACK);
	if(PLAYER_TALENT_RUNES[SPL_Firerain] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_Firerain,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Firerain)),DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_Firerain);
	};
	if(PLAYER_TALENT_RUNES[SPL_BreathOfDeath] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_BreathOfDeath,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_BreathOfDeath)),DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_BreathOfDeath);
	};
	if(PLAYER_TALENT_RUNES[SPL_MassDeath] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_MassDeath,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_MassDeath)),DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_MassDeath);
	};
	if(PLAYER_TALENT_RUNES[SPL_ArmyOfDarkness] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_ArmyOfDarkness,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_ArmyOfDarkness)),DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_ArmyOfDarkness);
	};
	/*if(PLAYER_TALENT_RUNES[SPL_Shrink] == FALSE)
	{
		Info_AddChoice(DIA_Milten_DI_TeachMagic,B_BuildLearnString(NAME_SPL_Shrink,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Shrink)),DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_Shrink);
	};*/
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_Firerain()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Firerain);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_BreathOfDeath()
{
	B_TeachPlayerTalentRunes(self,other,SPL_BreathOfDeath);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_MassDeath()
{
	B_TeachPlayerTalentRunes(self,other,SPL_MassDeath);
};

func void DIA_Milten_DI_TeachMagic_Runen_Circle_6_SPL_ArmyOfDarkness()
{
	B_TeachPlayerTalentRunes(self,other,SPL_ArmyOfDarkness);
};

func void DIA_Milten_DI_TeachMagic_BACK()
{
	Info_ClearChoices(DIA_Milten_DI_TeachMagic);
};


instance DIA_Milten_DI_DementorObsessionBook(C_Info)
{
	npc = PC_Mage_DI;
	nr = 99;
	condition = DIA_Milten_DI_DementorObsessionBook_Condition;
	information = DIA_Milten_DI_DementorObsessionBook_Info;
	description = "Does this book, Almanac of the Possessed, ring a bell?";
};


func int DIA_Milten_DI_DementorObsessionBook_Condition()
{
	if(Npc_HasItems(other,ITWR_DementorObsessionBook_MIS))
	{
		return TRUE;
	};
};

func void DIA_Milten_DI_DementorObsessionBook_Info()
{
	AI_Output (other, self, "DIA_Milten_DI_DementorObsessionBook_15_00");	//Does this book, Almanac of the Possessed, ring a bell?
	AI_Output (self, other, "DIA_Milten_DI_DementorObsessionBook_03_01");	//Pyrokar is the expert on this type of books.
	AI_Output (self, other, "DIA_Milten_DI_DementorObsessionBook_03_02");	//Sorry. I know too little to be able to say anything intelligent about that.
	B_GivePlayerXP(XP_AmbientKap6);
};


instance DIA_Milten_DI_DragonEgg(C_Info)
{
	npc = PC_Mage_DI;
	nr = 99;
	condition = DIA_Milten_DI_DragonEgg_Condition;
	information = DIA_Milten_DI_DragonEgg_Info;
	description = "Do you have experience with dragon eggs?";
};


func int DIA_Milten_DI_DragonEgg_Condition()
{
	if(Npc_HasItems(other,ItAt_DragonEgg_MIS))
	{
		return TRUE;
	};
};

func void DIA_Milten_DI_DragonEgg_Info()
{
	AI_Output (other, self, "DIA_Milten_DI_DragonEgg_15_00");	//Do you have experience with dragon eggs?
	AI_Output (self, other, "DIA_Milten_DI_DragonEgg_03_01");	//No, not really. I have heard that a clever alchemist once managed to brew a powerful potion from it.
	AI_Output (self, other, "DIA_Milten_DI_DragonEgg_03_02");	//But please don't ask me for the recipe. I have no idea.
	B_GivePlayerXP(XP_AmbientKap6);
};


instance DIA_Milten_DI_UndeadDragonDead(C_Info)
{
	npc = PC_Mage_DI;
	nr = 31;
	condition = DIA_Milten_DI_UndeadDragonDead_Condition;
	information = DIA_Milten_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "All right. That's it!";
};


func int DIA_Milten_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};


var int DIA_Milten_DI_UndeadDragonDead_OneTime;

func void DIA_Milten_DI_UndeadDragonDead_Info()
{
	AI_Output (other, self, "DIA_Milten_DI_UndeadDragonDead_15_00");	//All right. That's it! The temple is now deprived of its power.
	if (DIA_Milten_DI_UndeadDragonDead_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Milten_DI_UndeadDragonDead_03_01");	//How do you always pull it off, hm?
		AI_Output (other, self, "DIA_Milten_DI_UndeadDragonDead_15_02");	//Damned if I know.
		AI_Output (self, other, "DIA_Milten_DI_UndeadDragonDead_03_03");	//(laughs) Are we ever going to get any peace? We've certainly deserved it.
		if (hero.guild == GIL_KDF)
		{
			AI_Output (other, self, "DIA_Milten_DI_UndeadDragonDead_15_04");	//What will you do now?
			AI_Output (self, other, "DIA_Milten_DI_UndeadDragonDead_03_05");	//I'm thinking about founding my own academy and preaching our faith. But it could turn out otherwise.
			AI_Output (self, other, "DIA_Milten_DI_UndeadDragonDead_03_06");	//I have never regretted becoming a Magician of Fire. How do you feel about it?
			AI_Output (other, self, "DIA_Milten_DI_UndeadDragonDead_15_07");	//I'm not so sure.
			AI_Output (self, other, "DIA_Milten_DI_UndeadDragonDead_03_08");	//(laughs) Dry, as always. Hey, man. You just saved the world. Isn't that a reason to rejoice?
			AI_Output (other, self, "DIA_Milten_DI_UndeadDragonDead_15_09");	//Mmh. Maybe.
		};
		AI_Output (self, other, "DIA_Milten_DI_UndeadDragonDead_03_10");	//Come on, my friend, I think the first thing you need now is forty winks.
		DIA_Milten_DI_UndeadDragonDead_OneTime = TRUE;
	};
	AI_Output (self, other, "DIA_Milten_DI_UndeadDragonDead_03_11");	//You should go straight to the captain and tell him to weigh anchor.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Start");
};


instance DIA_Mage_DI_PICKPOCKET(C_Info)
{
	npc = PC_Mage_DI;
	nr = 900;
	condition = DIA_Mage_DI_PICKPOCKET_Condition;
	information = DIA_Mage_DI_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Mage_DI_PICKPOCKET_Condition()
{
	return C_Beklauen(45,120);
};

func void DIA_Mage_DI_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Mage_DI_PICKPOCKET);
	Info_AddChoice(DIA_Mage_DI_PICKPOCKET,Dialog_Back,DIA_Mage_DI_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Mage_DI_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Mage_DI_PICKPOCKET_DoIt);
};

func void DIA_Mage_DI_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Mage_DI_PICKPOCKET);
};

func void DIA_Mage_DI_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Mage_DI_PICKPOCKET);
};


