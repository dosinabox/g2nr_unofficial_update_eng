
instance DIA_Biff_NW_EXIT(C_Info)
{
	npc = DJG_713_Biff_NW;
	nr = 999;
	condition = DIA_Biff_NW_EXIT_Condition;
	information = DIA_Biff_NW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Biff_NW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Biff_NW_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Biff_NW_HAfen(C_Info)
{
	npc = DJG_713_Biff_NW;
	nr = 5;
	condition = DIA_Biff_NW_HAfen_Condition;
	information = DIA_Biff_NW_HAfen_Info;
	permanent = TRUE;
	description = "OK. Not much longer now.";
};


func int DIA_Biff_NW_HAfen_Condition()
{
	if(Biff_IsOnBoard != LOG_FAILED)
	{
		return TRUE;
	};
};

func void DIA_Biff_NW_HAfen_Info()
{
	AI_Output (other, self, "DIA_Biff_NW_HAfen_15_00");	//OK. Not much longer now.
	AI_Output (self, other, "DIA_Biff_NW_HAfen_07_01");	//I can't wait.
	if (MIS_ReadyforChapter6 == TRUE)
	{
		Npc_ExchangeRoutine(self,"SHIP");
	}
	else
	{
		Npc_ExchangeRoutine(self,"WAITFORSHIP");
	};
	AI_StopProcessInfos(self);
};


instance DIA_Biff_NW_QUIT(C_Info)
{
	npc = DJG_713_Biff_NW;
	nr = 6;
	condition = DIA_Biff_NW_QUIT_Condition;
	information = DIA_Biff_NW_QUIT_Info;
	permanent = FALSE;
	description = "�����, ������ ���� ���� ����������.@@@";
};


func int DIA_Biff_NW_QUIT_Condition()
{
	if(MIS_ReadyforChapter6 == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Biff_NW_QUIT_Info()
{
	DIA_Common_ImAfraidThatsTheEndForUs();
	B_Biff_Verarschen();
	Biff_IsOnBoard = LOG_FAILED;
	Crewmember_Count -= 1;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Quit");
	B_Attack(self,other,AR_NONE,1);
};


instance DIA_Biff_NW_ATTACK(C_Info)
{
	npc = DJG_713_Biff_NW;
	nr = 1;
	condition = DIA_Biff_NW_ATTACK_Condition;
	information = DIA_Biff_NW_ATTACK_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Biff_NW_ATTACK_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Biff_IsOnBoard == LOG_FAILED))
	{
		return TRUE;
	};
};

func void DIA_Biff_NW_ATTACK_Info()
{
	B_Say(self,other,"$NOTNOW");
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};


instance DIA_Biff_NW_PICKPOCKET(C_Info)
{
	npc = DJG_713_Biff_NW;
	nr = 900;
	condition = DIA_Biff_NW_PICKPOCKET_Condition;
	information = DIA_Biff_NW_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Biff_NW_PICKPOCKET_Condition()
{
	return C_Beklauen(92,250);
};

func void DIA_Biff_NW_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Biff_NW_PICKPOCKET);
	Info_AddChoice(DIA_Biff_NW_PICKPOCKET,Dialog_Back,DIA_Biff_NW_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Biff_NW_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Biff_NW_PICKPOCKET_DoIt);
};

func void DIA_Biff_NW_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Biff_NW_PICKPOCKET);
};

func void DIA_Biff_NW_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Biff_NW_PICKPOCKET);
};

