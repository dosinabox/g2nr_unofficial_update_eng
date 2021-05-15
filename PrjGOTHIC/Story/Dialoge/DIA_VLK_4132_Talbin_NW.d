
instance DIA_Talbin_NW_EXIT(C_Info)
{
	npc = VLK_4132_Talbin_NW;
	nr = 999;
	condition = DIA_Talbin_NW_EXIT_Condition;
	information = DIA_Talbin_NW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Talbin_NW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Talbin_NW_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Talbin_NW_MOVING(C_Info)
{
	npc = VLK_4132_Talbin_NW;
	nr = 1;
	condition = DIA_Talbin_NW_MOVING_Condition;
	information = DIA_Talbin_NW_MOVING_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Talbin_NW_MOVING_Condition()
{
	if((Npc_GetDistToWP(self,"NW_GREATPEASENT_TO_PASS") > 2100) && (MIS_Talbin_Runs == LOG_Running) && (Npc_IsInState(self,ZS_Talk)))
	{
		return TRUE;
	};
};

func void DIA_Talbin_NW_MOVING_Info()
{
	AI_Output(self,other,"DIA_Talbin_WOHIN_ok_07_01");	//Thank you. When you cross, I'll simply follow you.
	AI_StopProcessInfos(self);
};


instance DIA_Talbin_NW(C_Info)
{
	npc = VLK_4132_Talbin_NW;
	nr = 1;
	condition = DIA_Talbin_NW_Condition;
	information = DIA_Talbin_NW_Info;
	permanent = FALSE;
	important = TRUE;
//	description = "The pass wasn't all that bad, was it?";
};


func int DIA_Talbin_NW_Condition()
{
	if(Npc_GetDistToWP(self,"NW_GREATPEASENT_TO_PASS") <= 2100)
	{
		return TRUE;
	};
};

func void DIA_Talbin_NW_Info()
{
	AI_Output (self, other, "DIA_Talbin_NW_07_01");	//Thanks for rescuing me.
	AI_Output (self, other, "DIA_Talbin_NW_07_02");	//Here. I found this raw stone on the pass. I think it may be of use to you.
	if(hero.guild == GIL_KDF)
	{
		AI_Output(self,other,"DIA_Talbin_NW_07_03");	//I assume it's a runestone.
		AI_WaitTillEnd(other,self);
		B_GiveInvItems(self,other,ItMi_RuneBlank,1);
	}
	else
	{
		AI_Output(self,other,"DIA_Talbin_NW_07_04");	//I assume it's a piece of ore.
		AI_WaitTillEnd(other,self);
		B_GiveInvItems(self,other,ItMi_Nugget,1);
	};
	AI_Output(other,self,"DIA_Talbin_NW_15_00");	//The pass wasn't all that bad, was it?
	AI_Output(self,other,"DIA_Talbin_NW_07_05");	//May Innos protect you.
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Farm");
	MIS_Talbin_Runs = LOG_SUCCESS;
	B_GivePlayerXP(XP_SavedTalbin);
};


instance DIA_Talbin_NW_PERM(C_Info)
{
	npc = VLK_4132_Talbin_NW;
	nr = 15;
	condition = DIA_Talbin_NW_PERM_Condition;
	information = DIA_Talbin_NW_PERM_Info;
	permanent = TRUE;
	description = "Everything all right?";
};


func int DIA_Talbin_NW_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_NW))
	{
		return TRUE;
	};
};

func void DIA_Talbin_NW_PERM_Info()
{
	AI_Output(other,self,"DIA_Talbin_NW_PERM_15_00");	//Everything all right?
	AI_Output(self,other,"DIA_Talbin_NW_PERM_07_01");	//Yes, thank you. Just go now. I'll be okay.
	AI_StopProcessInfos(self);
};

instance DIA_Talbin_TEACHHUNTING_NW(C_Info)
{
	npc = VLK_4132_Talbin_NW;
	nr = 16;
	condition = DIA_Talbin_TEACHHUNTING_NW_Condition;
	information = DIA_Talbin_TEACHHUNTING_NW_Info;
	permanent = TRUE;
	description = "What can you teach me?";
};


func int DIA_Talbin_TEACHHUNTING_NW_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_NW) || (Talbin_TeachAnimalTrophy == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_TEACHHUNTING_NW_Info()
{
	DIA_Common_WhatCanYouTeachMe();
	if((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ShadowHorn] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Heart] == FALSE))
	{
		AI_Output(self,other,"DIA_Talbin_TEACHHUNTING_07_01");	//What do you want to know?
		if(Talbin_TeachAnimalTrophy == FALSE)
		{
			Talbin_TeachAnimalTrophy = TRUE;
			Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
			B_LogEntry(TOPIC_OutTeacher,"Talbin can teach me to take animal trophies.");
			B_CheckLog();
		};
		Info_AddChoice(DIA_Talbin_TEACHHUNTING_NW,Dialog_Back,DIA_Talbin_TEACHHUNTING_NW_BACK);
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE)
		{
			Info_AddChoice(DIA_Talbin_TEACHHUNTING_NW,B_BuildLearnString(NAME_TROPHY_Claws,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Claws)),DIA_Talbin_TEACHHUNTING_Claws);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE)
		{
			Info_AddChoice(DIA_Talbin_TEACHHUNTING_NW,B_BuildLearnString(NAME_TROPHY_Fur,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_Fur)),DIA_Talbin_TEACHHUNTING_Fur);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ShadowHorn] == FALSE)
		{
			Info_AddChoice(DIA_Talbin_TEACHHUNTING_NW,B_BuildLearnString(NAME_TROPHY_ShadowHorn,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_ShadowHorn)),DIA_Talbin_TEACHHUNTING_ShadowHorn);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Heart] == FALSE)
		{
			Info_AddChoice(DIA_Talbin_TEACHHUNTING_NW,B_BuildLearnString(NAME_TROPHY_Heart,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Heart)),DIA_Talbin_TEACHHUNTING_Heart);
		};
	}
	else
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
	};
};

func void DIA_Talbin_TEACHHUNTING_NW_BACK()
{
	Info_ClearChoices(DIA_Talbin_TEACHHUNTING_NW);
};

