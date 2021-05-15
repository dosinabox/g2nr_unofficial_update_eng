
instance DIA_Rick_EXIT(C_Info)
{
	npc = MIL_336_Rick;
	nr = 999;
	condition = DIA_Rick_EXIT_Condition;
	information = DIA_Rick_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Rick_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Rick_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Rick_HALLO(C_Info)
{
	npc = MIL_336_Rick;
	nr = 1;
	condition = DIA_Rick_HALLO_Condition;
	information = DIA_Rick_HALLO_Info;
	permanent = TRUE;
	description = "What's up?";
};


func int DIA_Rick_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Rick_HALLO_Info()
{
	AI_Output(other,self,"DIA_Rick_HALLO_15_00");	//How's it going?
	if(Hlp_IsValidNpc(Rumbold) && !Npc_IsDead(Rumbold) && (MIS_Torlof_BengarMilizKlatschen == LOG_Running) && (ScaredRick == FALSE) && (Kapitel < 3))
	{
		AI_Output(self,other,"DIA_Rick_HALLO_10_01");	//If you want to talk, talk to Rumbold. I'm just here in case anyone makes trouble.
	}
	else
	{
		B_Say(self,other,"$NOTNOW");
	};
	AI_StopProcessInfos(self);
};


instance DIA_Rick_PICKPOCKET(C_Info)
{
	npc = MIL_336_Rick;
	nr = 900;
	condition = DIA_Rick_PICKPOCKET_Condition;
	information = DIA_Rick_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Rick_PICKPOCKET_Condition()
{
	return C_Beklauen(10,45);
};

func void DIA_Rick_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Rick_PICKPOCKET);
	Info_AddChoice(DIA_Rick_PICKPOCKET,Dialog_Back,DIA_Rick_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Rick_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Rick_PICKPOCKET_DoIt);
};

func void DIA_Rick_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Rick_PICKPOCKET);
};

func void DIA_Rick_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Rick_PICKPOCKET);
};

