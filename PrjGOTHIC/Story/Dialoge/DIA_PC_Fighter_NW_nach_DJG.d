
instance DIA_GornNW_nach_DJG_KAP5_EXIT(C_Info)
{
	npc = PC_Fighter_NW_nach_DJG;
	nr = 999;
	condition = DIA_GornNW_nach_DJG_KAP5_EXIT_Condition;
	information = DIA_GornNW_nach_DJG_KAP5_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_GornNW_nach_DJG_KAP5_EXIT_Condition()
{
	return TRUE;
};

func void DIA_GornNW_nach_DJG_KAP5_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_GornNW_nach_DJG_AllDragonsDead(C_Info)
{
	npc = PC_Fighter_NW_nach_DJG;
	nr = 59;
	condition = DIA_GornNW_nach_DJG_AllDragonsDead_Condition;
	information = DIA_GornNW_nach_DJG_AllDragonsDead_Info;
	permanent = TRUE;
	description = "Are you relaxed?";
};


func int DIA_GornNW_nach_DJG_AllDragonsDead_Condition()
{
	if(Gorn_IsOnBoard != LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_GornNW_nach_DJG_AllDragonsDead_Info()
{
	AI_Output (other, self, "DIA_GornNW_nach_DJG_AllDragonsDead_15_00");	//Are you relaxed?
	AI_Output (self, other, "DIA_GornNW_nach_DJG_AllDragonsDead_12_01");	//Sure, why not? The dragons are dead, aren't they?
	AI_Output (other, self, "DIA_GornNW_nach_DJG_AllDragonsDead_15_02");	//The case is a little more complicated.
	AI_Output (self, other, "DIA_GornNW_nach_DJG_AllDragonsDead_12_03");	//(laughs) Well. Like always. Let me know when you need my axe.
};


instance DIA_GornNW_nach_DJG_KnowWhereEnemy(C_Info)
{
	npc = PC_Fighter_NW_nach_DJG;
	nr = 55;
	condition = DIA_GornNW_nach_DJG_KnowWhereEnemy_Condition;
	information = DIA_GornNW_nach_DJG_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "I could use you and your axe.";
};


func int DIA_GornNW_nach_DJG_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (Gorn_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_GornNW_nach_DJG_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_GornNW_nach_DJG_KnowWhereEnemy_15_00");	//I could use you and your axe.
	AI_Output (self, other, "DIA_GornNW_nach_DJG_KnowWhereEnemy_12_01");	//Well. I'm not surprised. What can I do for you?
	AI_Output (other, self, "DIA_GornNW_nach_DJG_KnowWhereEnemy_15_02");	//Would you sail to an island with me and kick some enemy butt?
	AI_Output (self, other, "DIA_GornNW_nach_DJG_KnowWhereEnemy_12_03");	//(laughs) Sure. Right away. Just tell me what to do.
	if(SCToldGornHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"Gorn was all for it when I told him about the island. If I need an axe, I should take him along.");
		SCToldGornHeKnowWhereEnemy = TRUE;
	};
	if(Crewmember_Count >= Max_Crew)
	{
		AI_Output (other, self, "DIA_GornNW_nach_DJG_KnowWhereEnemy_15_04");	//At the moment, my crew is already complete, but I'll think about taking you on board, too.
		AI_Output (self, other, "DIA_GornNW_nach_DJG_KnowWhereEnemy_12_05");	//If you have to kick someone else off your crew because of me, then take the weakest.
		AI_Output (self, other, "DIA_GornNW_nach_DJG_KnowWhereEnemy_12_06");	//In these rough times, you need every man who can lend a hand.
	}
	else
	{
		Info_ClearChoices (DIA_GornNW_nach_DJG_KnowWhereEnemy);
		Info_AddChoice (DIA_GornNW_nach_DJG_KnowWhereEnemy, "I'll let you know when it's time.", DIA_GornNW_nach_DJG_KnowWhereEnemy_No);
		Info_AddChoice (DIA_GornNW_nach_DJG_KnowWhereEnemy, "Come aboard with me. Wait for me at the harbor.", DIA_GornNW_nach_DJG_KnowWhereEnemy_Yes);
	};
};

func void DIA_GornNW_nach_DJG_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_GornNW_nach_DJG_KnowWhereEnemy_Yes_15_00");	//Come aboard with me. Wait for me at the harbor.
	AI_Output (self, other, "DIA_GornNW_nach_DJG_KnowWhereEnemy_Yes_12_01");	//A ship? Ha! I can say one thing for you. It's never boring with you. See you soon.
	B_JoinShip(self);
};

func void DIA_GornNW_nach_DJG_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_GornNW_nach_DJG_KnowWhereEnemy_No_15_00");	//I'll let you know when it's time.
	AI_Output (self, other, "DIA_GornNW_nach_DJG_KnowWhereEnemy_No_12_01");	//All right.
	Gorn_IsOnBoard = LOG_OBSOLETE;
	Info_ClearChoices(DIA_GornNW_nach_DJG_KnowWhereEnemy);
};


instance DIA_GornNW_nach_DJG_LeaveMyShip(C_Info)
{
	npc = PC_Fighter_NW_nach_DJG;
	nr = 55;
	condition = DIA_GornNW_nach_DJG_LeaveMyShip_Condition;
	information = DIA_GornNW_nach_DJG_LeaveMyShip_Info;
	permanent = TRUE;
	description = "Maybe you had better stay here.";
};


func int DIA_GornNW_nach_DJG_LeaveMyShip_Condition()
{
	if((Gorn_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_GornNW_nach_DJG_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_GornNW_nach_DJG_LeaveMyShip_15_00");	//Maybe you had better stay here.
	AI_Output (self, other, "DIA_GornNW_nach_DJG_LeaveMyShip_12_01");	//I'm supposed to let you go alone? Mmh. It's not easy for me, but it's your war. Come to me if you want me to follow you after all.
	Gorn_IsOnBoard = LOG_OBSOLETE;
	Crewmember_Count -= 1;
	Npc_ExchangeRoutine(self,"Start");
};


instance DIA_GornNW_nach_DJG_StillNeedYou(C_Info)
{
	npc = PC_Fighter_NW_nach_DJG;
	nr = 55;
	condition = DIA_GornNW_nach_DJG_StillNeedYou_Condition;
	information = DIA_GornNW_nach_DJG_StillNeedYou_Info;
	permanent = TRUE;
	description = "Come back. I need you.";
};


func int DIA_GornNW_nach_DJG_StillNeedYou_Condition()
{
	if(((Gorn_IsOnBoard == LOG_OBSOLETE) || (Gorn_IsOnBoard == LOG_FAILED)) && (Crewmember_Count < Max_Crew))
	{
		if(Gorn_WasOnBoard == TRUE)
		{
			DIA_GornNW_nach_DJG_StillNeedYou.description = "Come back. I need you.";
		}
		else
		{
			DIA_GornNW_nach_DJG_StillNeedYou.description = "I could use your help.";
		};
		return TRUE;
	};
};

func void DIA_GornNW_nach_DJG_StillNeedYou_Info()
{
	if(Gorn_WasOnBoard == TRUE)
	{
		AI_Output(other,self,"DIA_GornNW_nach_DJG_StillNeedYou_15_00");	//Come back. I need you.
	}
	else
	{
		DIA_Common_INeedYourHelp();
	};
	AI_Output(self,other,"DIA_GornNW_nach_DJG_StillNeedYou_12_01");	//There you are. And I thought you wanted to let me rot here while you had all the fun. See you later.
	B_JoinShip(self);
};


instance DIA_Fighter_nach_DJG_PICKPOCKET(C_Info)
{
	npc = PC_Fighter_NW_nach_DJG;
	nr = 900;
	condition = DIA_Fighter_nach_DJG_PICKPOCKET_Condition;
	information = DIA_Fighter_nach_DJG_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Fighter_nach_DJG_PICKPOCKET_Condition()
{
	return C_Beklauen(10,25);
};

func void DIA_Fighter_nach_DJG_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Fighter_nach_DJG_PICKPOCKET);
	Info_AddChoice(DIA_Fighter_nach_DJG_PICKPOCKET,Dialog_Back,DIA_Fighter_nach_DJG_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Fighter_nach_DJG_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Fighter_nach_DJG_PICKPOCKET_DoIt);
};

func void DIA_Fighter_nach_DJG_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Fighter_nach_DJG_PICKPOCKET);
};

func void DIA_Fighter_nach_DJG_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Fighter_nach_DJG_PICKPOCKET);
};

