
instance DIA_Albrecht_EXIT(C_Info)
{
	npc = PAL_202_Albrecht;
	nr = 999;
	condition = DIA_Albrecht_EXIT_Condition;
	information = DIA_Albrecht_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Albrecht_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Albrecht_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Albrecht_Hagen(C_Info)
{
	npc = PAL_202_Albrecht;
	nr = 1;
	condition = DIA_Albrecht_Hagen_Condition;
	information = DIA_Albrecht_Hagen_Info;
	permanent = FALSE;
	description = "I need to talk to Lord Hagen!";
};


func int DIA_Albrecht_Hagen_Condition()
{
	if(LordHagen.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Albrecht_Hagen_Info()
{
	AI_Output (other, self, "DIA_Albrecht_Hagen_15_00");	//I need to talk to Lord Hagen!
	AI_Output (self, other, "DIA_Albrecht_Hagen_03_01");	//He's in the great hall, straight through there.
	AI_Output (self, other, "DIA_Albrecht_Hagen_03_02");	//Whatever it is you want from him, keep it short - he is a busy man!
};


instance DIA_Albrecht_Hallo(C_Info)
{
	npc = PAL_202_Albrecht;
	nr = 2;
	condition = DIA_Albrecht_Hallo_Condition;
	information = DIA_Albrecht_Hallo_Info;
	permanent = FALSE;
	description = "What does it mean to be a paladin?";
};


func int DIA_Albrecht_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Albrecht_Hallo_Info()
{
	AI_Output (other, self, "DIA_Albrecht_Hallo_15_00");	//What does it mean to be a paladin?
	AI_Output (self, other, "DIA_Albrecht_Hallo_03_01");	//A paladin is a warrior of Innos. He lives in order to serve him, and fights in order to do him honor.
	AI_Output (self, other, "DIA_Albrecht_Hallo_03_02");	//In return, the gift of magic is bestowed upon us. The magic of runes - which we are granted as recognition for our deeds.
};


instance DIA_Albrecht_CanTeach(C_Info)
{
	npc = PAL_202_Albrecht;
	nr = 99;
	condition = DIA_Albrecht_CanTeach_Condition;
	information = DIA_Albrecht_CanTeach_Info;
	permanent = TRUE;
	description = "Can you teach me something?";
};


func int DIA_Albrecht_CanTeach_Condition()
{
	if(Albrecht_TeachMANA == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Albrecht_CanTeach_Info()
{
	AI_Output (other, self, "DIA_Albrecht_CanTeach_15_00");	//Can you teach me something?
	if (other.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Albrecht_CanTeach_03_01");	//If you prove yourself worthy, I shall bestow the magic runes of the paladins upon you.
		AI_Output (self, other, "DIA_Albrecht_CanTeach_03_02");	//Beyond that, I can teach you to increase your magic power.
		Albrecht_TeachMANA = TRUE;
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"The paladin Albrecht can help me increase my magic powers.");
	}
	else
	{
		AI_Output (self, other, "DIA_Albrecht_CanTeach_03_03");	//I only instruct paladins.
	};
};


instance DIA_Albrecht_TEACHPalRunes(C_Info)
{
	npc = PAL_202_Albrecht;
	nr = 100;
	condition = DIA_Albrecht_TEACHPalRunes_Condition;
	information = DIA_Albrecht_TEACHPalRunes_Info;
	permanent = TRUE;
	description = "Am I worthy of receiving a rune?";
};


func int DIA_Albrecht_TEACHPalRunes_Condition()
{
	if(Albrecht_TeachMANA == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Albrecht_TEACHPalRunes_Info()
{
	AI_Output (other, self, "DIA_Albrecht_TEACHPalRunes_15_00");	//Am I worthy of receiving a rune?
	if (PLAYER_TALENT_RUNES[SPL_PalLight] == FALSE)
	{
		AI_Output (self, other, "DIA_Albrecht_TEACHPalRunes_03_01");	//As a sign of your rank, I bestow upon you the Rune of Light. It is the symbol of truth and justice.
		AI_Output (self, other, "DIA_Albrecht_TEACHPalRunes_03_02");	//Light the way for all those who walk the path of Innos.
		AI_Output (self, other, "DIA_Albrecht_TEACHPalRunes_03_03");	//You must earn all other runes. Come again when you think you have proven yourself worthy.
		PLAYER_TALENT_RUNES[SPL_PalLight] = TRUE;
		CreateInvItems(self,ItRu_PalLight,1);
		B_GiveInvItems(self,other,ItRu_PalLight,1);
	}
	else
	{
		AI_Output (self, other, "DIA_Albrecht_TEACHPalRunes_03_04");	//Which way have you chosen?
		AI_Output (self, other, "DIA_Albrecht_TEACHPalRunes_03_05");	//The way of healing or the way of battle?
		Info_ClearChoices (DIA_Albrecht_TEACHPalRunes);
		Info_AddChoice (DIA_Albrecht_TEACHPalRunes, Dialog_Back, DIA_Albrecht_TEACHPalRunes_BACK);
		Info_AddChoice (DIA_Albrecht_TEACHPalRunes, "I choose the path of healing.", DIA_Albrecht_TEACHPalRunes_Heal);
		Info_AddChoice (DIA_Albrecht_TEACHPalRunes, "I choose the path of combat.", DIA_Albrecht_TEACHPalRunes_Combat);
	};
};

func void DIA_Albrecht_TEACHPalRunes_BACK()
{
	Info_ClearChoices(DIA_Albrecht_TEACHPalRunes);
};

func void B_Albrecht_YouAreNotWorthy()
{
	AI_Output (self, other, "B_Albrecht_YouAreNotWorthy_03_00");	//You are not yet worthy of receiving the next spell for this path.
};

func void DIA_Albrecht_TEACHPalRunes_Heal()
{
	AI_Output (other, self, "DIA_Albrecht_TEACHPalRunes_Heal_15_00");	//I choose the path of healing.
	if ((PLAYER_TALENT_RUNES[SPL_PalLightHeal] == FALSE) && (MIS_ReadyforChapter4 == TRUE))
	{
		Info_ClearChoices(DIA_Albrecht_TEACHPalRunes);
		Info_AddChoice(DIA_Albrecht_TEACHPalRunes,Dialog_Back,DIA_Albrecht_TEACHPalRunes_BACK);
		Info_AddChoice(DIA_Albrecht_TEACHPalRunes,B_BuildLearnString(NAME_SPL_PalLightHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalLightHeal)),DIA_Albrecht_TEACHPalRunes_PalLightHeal);
	}
	else if((PLAYER_TALENT_RUNES[SPL_PalMediumHeal] == FALSE) && (Kapitel >= 5))
	{
		Info_ClearChoices(DIA_Albrecht_TEACHPalRunes);
		Info_AddChoice(DIA_Albrecht_TEACHPalRunes,Dialog_Back,DIA_Albrecht_TEACHPalRunes_BACK);
		Info_AddChoice(DIA_Albrecht_TEACHPalRunes,B_BuildLearnString(NAME_SPL_PalMediumHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalMediumHeal)),DIA_Albrecht_TEACHPalRunes_PalMediumHeal);
	}
	else
	{
		B_Albrecht_YouAreNotWorthy();
	};
};

func void DIA_Albrecht_TEACHPalRunes_Combat()
{
	AI_Output (other, self, "DIA_Albrecht_TEACHPalRunes_Combat_15_00");	//I choose the path of combat.
	if ((PLAYER_TALENT_RUNES[SPL_PalHolyBolt] == FALSE) && (MIS_ReadyforChapter4 == TRUE))
	{
		Info_ClearChoices(DIA_Albrecht_TEACHPalRunes);
		Info_AddChoice(DIA_Albrecht_TEACHPalRunes,Dialog_Back,DIA_Albrecht_TEACHPalRunes_BACK);
		Info_AddChoice(DIA_Albrecht_TEACHPalRunes,B_BuildLearnString(NAME_SPL_PalHolyBolt,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalHolyBolt)),DIA_Albrecht_TEACHPalRunes_PalHolyBolt);
	}
	else if((PLAYER_TALENT_RUNES[SPL_PalRepelEvil] == FALSE) && (Kapitel >= 5))
	{
		Info_ClearChoices(DIA_Albrecht_TEACHPalRunes);
		Info_AddChoice(DIA_Albrecht_TEACHPalRunes,Dialog_Back,DIA_Albrecht_TEACHPalRunes_BACK);
		Info_AddChoice(DIA_Albrecht_TEACHPalRunes,B_BuildLearnString(NAME_SPL_PalRepelEvil,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_PalRepelEvil)),DIA_Albrecht_TEACHPalRunes_PalRepelEvil);
	}
	else
	{
		B_Albrecht_YouAreNotWorthy();
	};
};

func void DIA_Albrecht_TEACHPalRunes_PalLightHeal()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalLightHeal);
};

func void DIA_Albrecht_TEACHPalRunes_PalMediumHeal()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalMediumHeal);
};

func void DIA_Albrecht_TEACHPalRunes_PalHolyBolt()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalHolyBolt);
};

func void DIA_Albrecht_TEACHPalRunes_PalRepelEvil()
{
	B_TeachPlayerPalRunes(self,other,SPL_PalRepelEvil);
};


var int Albrecht_TeachMANA_NoPerm;

func void B_BuildLearnDialog_Albrecht()
{
	if(other.aivar[REAL_MANA_MAX] >= T_MED)
	{
		AI_Output(self,other,"DIA_Albrecht_Teach_03_00");	//If you want to increase your magic power even further, you must seek another teacher.
		Albrecht_TeachMANA_NoPerm = TRUE;
	}
	else
	{
		Info_ClearChoices(DIA_Albrecht_Teach);
		Info_AddChoice(DIA_Albrecht_Teach,Dialog_Back,DIA_Albrecht_Teach_BACK);
		Info_AddChoice(DIA_Albrecht_Teach,B_BuildLearnString(PRINT_LearnMANA1,B_GetLearnCostAttribute(other,ATR_MANA_MAX)),DIA_Albrecht_Teach_1);
		Info_AddChoice(DIA_Albrecht_Teach,B_BuildLearnString(PRINT_LearnMANA5,B_GetLearnCostAttribute(other,ATR_MANA_MAX) * 5),DIA_Albrecht_Teach_5);
	};
};

instance DIA_Albrecht_Teach(C_Info)
{
	npc = PAL_202_Albrecht;
	nr = 101;
	condition = DIA_Albrecht_Teach_Condition;
	information = DIA_Albrecht_Teach_Info;
	permanent = TRUE;
	description = "I want to increase my magic powers.";
};


func int DIA_Albrecht_Teach_Condition()
{
	if((Albrecht_TeachMANA == TRUE) && (Albrecht_TeachMANA_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Albrecht_Teach_Info()
{
	AI_Output(other,self,"DIA_Albrecht_Teach_15_00");	//I want to increase my magic power.
	B_BuildLearnDialog_Albrecht();
};

func void DIA_Albrecht_Teach_BACK()
{
	Info_ClearChoices(DIA_Albrecht_Teach);
};

func void DIA_Albrecht_Teach_1()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,1,T_MED))
	{
		B_BuildLearnDialog_Albrecht();
	};
};

func void DIA_Albrecht_Teach_5()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,5,T_MED))
	{
		B_BuildLearnDialog_Albrecht();
	};
};

instance DIA_Albrecht_PICKPOCKET(C_Info)
{
	npc = PAL_202_Albrecht;
	nr = 900;
	condition = DIA_Albrecht_PICKPOCKET_Condition;
	information = DIA_Albrecht_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Albrecht_PICKPOCKET_Condition()
{
	return C_Beklauen(41,160);
};

func void DIA_Albrecht_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Albrecht_PICKPOCKET);
	Info_AddChoice(DIA_Albrecht_PICKPOCKET,Dialog_Back,DIA_Albrecht_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Albrecht_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Albrecht_PICKPOCKET_DoIt);
};

func void DIA_Albrecht_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Albrecht_PICKPOCKET);
};

func void DIA_Albrecht_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Albrecht_PICKPOCKET);
};

