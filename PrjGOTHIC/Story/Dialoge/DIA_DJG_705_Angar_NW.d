
instance DIA_Angar_NW_KAP5_EXIT(C_Info)
{
	npc = DJG_705_Angar_NW;
	nr = 999;
	condition = DIA_Angar_NW_KAP5_EXIT_Condition;
	information = DIA_Angar_NW_KAP5_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Angar_NW_KAP5_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Angar_NW_KAP5_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Angar_NW_AllDragonsDead(C_Info)
{
	npc = DJG_705_Angar_NW;
	nr = 59;
	condition = DIA_Angar_NW_AllDragonsDead_Condition;
	information = DIA_Angar_NW_AllDragonsDead_Info;
	description = "How's it going?";
};


func int DIA_Angar_NW_AllDragonsDead_Condition()
{
	return TRUE;
};

func void DIA_Angar_NW_AllDragonsDead_Info()
{
	AI_Output (other, self, "DIA_Angar_NW_AllDragonsDead_15_00");	//How's it going?
	AI_Output (self, other, "DIA_Angar_NW_AllDragonsDead_04_01");	//Quite well. But I still have these miserable headaches, although they've gotten better since I'm no longer in the Valley of the Mines.
	if (Angar_IsOnBoard != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Angar_NW_AllDragonsDead_04_02");	//I'll stay here. Then you'll know where to find me if you need me.
	};
};


instance DIA_Angar_NW_KnowWhereEnemy(C_Info)
{
	npc = DJG_705_Angar_NW;
	nr = 55;
	condition = DIA_Angar_NW_KnowWhereEnemy_Condition;
	information = DIA_Angar_NW_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "I'm going to leave Khorinis. Would you like to join me?";
};


func int DIA_Angar_NW_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (Angar_IsOnBoard == FALSE) && Npc_KnowsInfo(other,DIA_Angar_NW_AllDragonsDead))
	{
		return TRUE;
	};
};

func void DIA_Angar_NW_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_Angar_NW_KnowWhereEnemy_15_00");	//I'm going to leave Khorinis. Would you like to join me?
	AI_Output (self, other, "DIA_Angar_NW_KnowWhereEnemy_04_01");	//The farther I get from the Valley of Mines, the better. When do we go?
	if(SCToldAngarHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"Angar's grateful for every mile he can put between himself and the Valley of Mines. He's offered to come with me on my journey.");
		SCToldAngarHeKnowWhereEnemy = TRUE;
	};
	if(Crewmember_Count >= Max_Crew)
	{
		AI_Output (other, self, "DIA_Angar_NW_KnowWhereEnemy_15_02");	//Right now, I've got enough people to man the ship. Maybe I'll get back to you later.
		AI_Output (self, other, "DIA_Angar_NW_KnowWhereEnemy_04_03");	//Fine. I'm here if you need me.
	}
	else
	{
		Info_ClearChoices (DIA_Angar_NW_KnowWhereEnemy);
		Info_AddChoice (DIA_Angar_NW_KnowWhereEnemy, "I'll let you know when it's time to go.", DIA_Angar_NW_KnowWhereEnemy_No);
		Info_AddChoice (DIA_Angar_NW_KnowWhereEnemy, "Go to the harbor, then. I'll meet you there later.", DIA_Angar_NW_KnowWhereEnemy_Yes);
	};
};

func void DIA_Angar_NW_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_Angar_NW_KnowWhereEnemy_Yes_15_00");	//Go to the harbor, then. I'll meet you there later.
	AI_Output (self, other, "DIA_Angar_NW_KnowWhereEnemy_Yes_04_01");	//On my way.
	B_JoinShip(self);
};

func void DIA_Angar_NW_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_Angar_NW_KnowWhereEnemy_No_15_00");	//I'll let you know when it's time to go.
	AI_Output (self, other, "DIA_Angar_NW_KnowWhereEnemy_No_04_01");	//Good.
	Angar_IsOnBoard = LOG_OBSOLETE;
	Info_ClearChoices(DIA_Angar_NW_KnowWhereEnemy);
};


instance DIA_Angar_NW_LeaveMyShip(C_Info)
{
	npc = DJG_705_Angar_NW;
	nr = 55;
	condition = DIA_Angar_NW_LeaveMyShip_Condition;
	information = DIA_Angar_NW_LeaveMyShip_Info;
	permanent = TRUE;
	description = "Stay here and take care of your pain.";
};


func int DIA_Angar_NW_LeaveMyShip_Condition()
{
	if((Angar_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Angar_NW_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_Angar_NW_LeaveMyShip_15_00");	//Stay here and take care of your pain.
	AI_Output (self, other, "DIA_Angar_NW_LeaveMyShip_04_01");	//All right. I'll go back. Maybe it's better that way.
	Angar_IsOnBoard = LOG_OBSOLETE;
	Crewmember_Count -= 1;
	Npc_ExchangeRoutine(self,"Start");
};


instance DIA_Angar_NW_StillNeedYou(C_Info)
{
	npc = DJG_705_Angar_NW;
	nr = 55;
	condition = DIA_Angar_NW_StillNeedYou_Condition;
	information = DIA_Angar_NW_StillNeedYou_Info;
	permanent = TRUE;
	description = "Come back on board.";
};


func int DIA_Angar_NW_StillNeedYou_Condition()
{
	if(((Angar_IsOnBoard == LOG_OBSOLETE) || (Angar_IsOnBoard == LOG_FAILED)) && (Crewmember_Count < Max_Crew))
	{
		if(Angar_WasOnBoard == TRUE)
		{
			DIA_Angar_NW_StillNeedYou.description = "Come back on board.";
		}
		else
		{
			DIA_Angar_NW_StillNeedYou.description = "I need you.";
		};
		return TRUE;
	};
};

func void DIA_Angar_NW_StillNeedYou_Info()
{
	if(Angar_WasOnBoard == TRUE)
	{
		AI_Output(other,self,"DIA_Angar_NW_StillNeedYou_15_00");	//Come back on board.
		AI_Output(self,other,"DIA_Angar_NW_StillNeedYou_04_01");	//You're worse than I am. A bit more decisiveness would do you good. See you later.
	}
	else
	{
		DIA_Common_INeedYou();
		AI_Output(self,other,"DIA_Angar_NW_KnowWhereEnemy_Yes_04_01");	//On my way.
	};
	B_JoinShip(self);
};


instance DIA_Angar_NW_PICKPOCKET(C_Info)
{
	npc = DJG_705_Angar_NW;
	nr = 900;
	condition = DIA_Angar_NW_PICKPOCKET_Condition;
	information = DIA_Angar_NW_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Angar_NW_PICKPOCKET_Condition()
{
	return C_Beklauen(47,34);
};

func void DIA_Angar_NW_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Angar_NW_PICKPOCKET);
	Info_AddChoice(DIA_Angar_NW_PICKPOCKET,Dialog_Back,DIA_Angar_NW_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Angar_NW_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Angar_NW_PICKPOCKET_DoIt);
};

func void DIA_Angar_NW_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Angar_NW_PICKPOCKET);
};

func void DIA_Angar_NW_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Angar_NW_PICKPOCKET);
};


instance DIA_Angar_NW_FOUNDAMULETT(C_Info)
{
	npc = DJG_705_Angar_NW;
	nr = 7;
	condition = DIA_Angar_NW_FOUNDAMULETT_Condition;
	information = DIA_Angar_NW_FOUNDAMULETT_Info;
	description = "I found your amulet.";
};


func int DIA_Angar_NW_FOUNDAMULETT_Condition()
{
	if(Npc_HasItems(other,ItAm_Mana_Angar_MIS) && Npc_KnowsInfo(other,DIA_Angar_WIEKOMMSTDUHIERHER) && (DJG_AngarGotAmulett == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Angar_NW_FOUNDAMULETT_Info()
{
	B_AngarsAmulettAbgeben();
};


instance DIA_Angar_SCTellsAngarAboutMadPsi2_NW(C_Info)
{
	npc = DJG_705_Angar_NW;
	nr = 8;
	condition = DIA_Angar_SCTellsAngarAboutMadPsi2_NW_Condition;
	information = DIA_Angar_SCTellsAngarAboutMadPsi2_NW_Info;
	description = "Братство Спящего было порабощено Злом.@@@";
};


func int DIA_Angar_SCTellsAngarAboutMadPsi2_NW_Condition()
{
	if((SC_KnowsMadPsi == TRUE) && (Angar_KnowsMadPsi == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Angar_SCTellsAngarAboutMadPsi2_NW_Info()
{
	B_SCTellsAngarAboutMadPsi();
	B_SCTellsAngarAboutMadPsi2();
};

