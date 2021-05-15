
instance DIA_Vanja_EXIT(C_Info)
{
	npc = VLK_491_Vanja;
	nr = 999;
	condition = DIA_Vanja_EXIT_Condition;
	information = DIA_Vanja_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Vanja_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Vanja_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Vanja_PICKPOCKET(C_Info)
{
	npc = VLK_491_Vanja;
	nr = 900;
	condition = DIA_Vanja_PICKPOCKET_Condition;
	information = DIA_Vanja_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20_Female;
};


func int DIA_Vanja_PICKPOCKET_Condition()
{
	return C_Beklauen(20,10);
};

func void DIA_Vanja_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Vanja_PICKPOCKET);
	Info_AddChoice(DIA_Vanja_PICKPOCKET,Dialog_Back,DIA_Vanja_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Vanja_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Vanja_PICKPOCKET_DoIt);
};

func void DIA_Vanja_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Vanja_PICKPOCKET);
};

func void DIA_Vanja_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Vanja_PICKPOCKET);
};


instance DIA_Vanja_STANDARD(C_Info)
{
	npc = VLK_491_Vanja;
	condition = DIA_Vanja_STANDARD_Condition;
	information = DIA_Vanja_STANDARD_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Vanja_STANDARD_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Vanja_STANDARD_Info()
{
	AI_Output(self,other,"DIA_Vanja_STANDARD_17_00");	//I'm busy.
	if(!Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) || (self.aivar[AIV_PlayerHasPickedMyPocket] == TRUE))
	{
		if((MIS_Andre_REDLIGHT != LOG_Running) || (Knows_Borka_Dealer == TRUE))
		{
			AI_StopProcessInfos(self);
		};
	};
};


instance DIA_Vanja_DOPE(C_Info)
{
	npc = VLK_491_Vanja;
	nr = 3;
	condition = DIA_Vanja_DOPE_Condition;
	information = DIA_Vanja_DOPE_Info;
	permanent = FALSE;
	description = "Where can I find myself some weed?";
};


func int DIA_Vanja_DOPE_Condition()
{
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Vanja_DOPE_Info()
{
	AI_Output(other,self,"DIA_Vanja_DOPE_15_00");	//Where can I find myself some weed??
	AI_Output(self,other,"DIA_Vanja_DOPE_17_01");	//No idea. Better keep your fingers off of that stuff.
	if(C_LawArmorEquipped(other))
	{
		AI_Output(self,other,"DIA_Vanja_DOPE_17_02");	//Because, if you keep asking about it, you might burn them...
	};
};

