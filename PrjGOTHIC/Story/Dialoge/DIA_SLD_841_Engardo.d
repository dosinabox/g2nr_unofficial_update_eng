
instance DIA_Engardo_EXIT(C_Info)
{
	npc = SLD_841_Engardo;
	nr = 999;
	condition = DIA_Engardo_EXIT_Condition;
	information = DIA_Engardo_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Engardo_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Engardo_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Engardo_HALLO(C_Info)
{
	npc = SLD_841_Engardo;
	nr = 4;
	condition = DIA_Engardo_HALLO_Condition;
	information = DIA_Engardo_HALLO_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Engardo_HALLO_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Kapitel < 4) && (ScaredEngardo == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Engardo_HALLO_End()
{
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_SuddenEnemyInferno,1);
};

var int Chance;

func void DIA_Engardo_HALLO_Info()
{
	if(Chance == 0)
	{
		if(other.guild == GIL_NONE)
		{
			AI_Output(self,other,"DIA_Engardo_HALLO_13_00");	//Hey, yokel, have you lost your way? Go back to your field and pull up a few turnips.
		}
		else
		{
			B_Say(self,other,"$GETOUTOFHERE");
		};
		if(Akils_SLDStillthere == FALSE)
		{
			Log_CreateTopic(TOPIC_AkilsSLDStillthere,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_AkilsSLDStillthere,LOG_Running);
			B_LogEntry(TOPIC_AkilsSLDStillthere,"Akil's farm is threatened by mercenaries.");
			Akils_SLDStillthere = TRUE;
		};
		Chance = 1;
		if(!Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) || (other.attribute[ATR_DEXTERITY] < 24) || (self.aivar[AIV_PlayerHasPickedMyPocket] == TRUE))
		{
			AI_StopProcessInfos(self);
		};
	}
	else if(Chance == 1)
	{
		AI_Output(self,other,"DIA_Engardo_HALLO_13_01");	//You're at the wrong place at the wrong time...
		AI_Output(self,other,"DIA_Engardo_HALLO_13_02");	//... so I guess that if you want to live, you had better hit the road now, get it?
		Chance = 2;
		if(!Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) || (other.attribute[ATR_DEXTERITY] < 24) || (self.aivar[AIV_PlayerHasPickedMyPocket] == TRUE))
		{
			AI_StopProcessInfos(self);
		};
	}
	else if(Chance == 2)
	{
		AI_Output(self,other,"DIA_Engardo_HALLO_13_03");	//Is there anything wrong with your ears, or do you have a death wish? (callously) Well - it's too late now.
		Info_ClearChoices(DIA_Engardo_HALLO);
		Info_AddChoice(DIA_Engardo_HALLO,Dialog_Ende,DIA_Engardo_HALLO_End);
	};
};


instance DIA_Engardo_PICKPOCKET(C_Info)
{
	npc = SLD_841_Engardo;
	nr = 900;
	condition = DIA_Engardo_PICKPOCKET_Condition;
	information = DIA_Engardo_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Engardo_PICKPOCKET_Condition()
{
	return C_Beklauen(34,45);
};

func void DIA_Engardo_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Engardo_PICKPOCKET);
	Info_AddChoice(DIA_Engardo_PICKPOCKET,Dialog_Back,DIA_Engardo_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Engardo_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Engardo_PICKPOCKET_DoIt);
};

func void DIA_Engardo_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Engardo_PICKPOCKET);
};

func void DIA_Engardo_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Engardo_PICKPOCKET);
};

