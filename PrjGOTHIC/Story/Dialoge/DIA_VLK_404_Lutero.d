
instance DIA_Lutero_EXIT(C_Info)
{
	npc = VLK_404_Lutero;
	nr = 999;
	condition = DIA_Lutero_EXIT_Condition;
	information = DIA_Lutero_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Lutero_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Lutero_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
	if((Lutero_Krallen == LOG_Running) && (MIS_Fajeth_Kill_Snapper == LOG_SUCCESS) && !Npc_KnowsInfo(other,DIA_Bilgot_KNOWSLEADSNAPPER))
	{
		Lutero_Krallen = LOG_OBSOLETE;
		B_CheckLog();
	};
};


instance DIA_Lutero_Hallo(C_Info)
{
	npc = VLK_404_Lutero;
	nr = 5;
	condition = DIA_Lutero_Hallo_Condition;
	information = DIA_Lutero_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lutero_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		if((other.guild != GIL_NONE) && (other.guild != GIL_NOV))
		{
			return TRUE;
		}
		else if((Kapitel >= 2) && (GuildlessMode == TRUE))
		{
			return TRUE;
		};
	};
};

func void DIA_Lutero_Hallo_Info()
{
	AI_Output (self, other, "DIA_Lutero_Hallo_13_00");	//My name is Lutero. I buy and sell all kinds of things.
	AI_Output (other, self, "DIA_Lutero_Hallo_15_01");	//What wares do you have to offer?
	AI_Output (self, other, "DIA_Lutero_Hallo_13_02");	//Well, especially rare and unusual things. So far I have always managed to fulfill my customers' wishes.
	Log_CreateTopic (TOPIC_CityTrader, LOG_NOTE);
	B_LogEntry (TOPIC_CityTrader, "Lutero deals in unusual and rare objects in the upper quarter.");
};


instance DIA_Lutero_GetLost(C_Info)
{
	npc = VLK_404_Lutero;
	nr = 5;
	condition = DIA_Lutero_GetLost_Condition;
	information = DIA_Lutero_GetLost_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Lutero_GetLost_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		if((Kapitel >= 2) && (GuildlessMode == TRUE))
		{
			return FALSE;
		}
		else if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Lutero_GetLost_Info()
{
	if(other.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Lutero_GetLost_13_00");	//Scram, buster! Don't you have anything to do? Then go find work - but elsewhere!
	}
	else
	{
		AI_Output (self, other, "DIA_Lutero_GetLost_13_01");	//What do you want, novice? Shouldn't you be in the monastery?
	};
	AI_StopProcessInfos(self);
};


instance DIA_Lutero_Snapper(C_Info)
{
	npc = VLK_404_Lutero;
	nr = 5;
	condition = DIA_Lutero_Snapper_Condition;
	information = DIA_Lutero_Snapper_Info;
	permanent = FALSE;
	description = "Are you looking for anything in particular?";
};


func int DIA_Lutero_Snapper_Condition()
{
	if((other.guild != GIL_NONE) && (other.guild != GIL_NOV))
	{
		return TRUE;
	}
	else if((Kapitel >= 2) && (GuildlessMode == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Lutero_Snapper_Info()
{
	AI_Output (other, self, "DIA_Lutero_Snapper_15_00");	//Are you looking for anything in particular?
	AI_Output (self, other, "DIA_Lutero_Snapper_13_01");	//Yes, for my current assignment I need the claws of a snapper.
	AI_Output (self, other, "DIA_Lutero_Snapper_13_02");	//But not just any old claws. It would have to be something special - the claws of a mighty beast who has killed many men already, or something like that.
	AI_Output (other, self, "DIA_Lutero_Snapper_15_03");	//Where can I find snappers?
	AI_Output (self, other, "DIA_Lutero_Snapper_13_04");	//There are a few of them on this island, but most of them live in the Valley of Mines.
	AI_Output (other, self, "DIA_Lutero_Snapper_15_05");	//And what's in it for me?
	if (other.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_Lutero_Hello_13_06");	//I could find you a runestone.
	}
	else
	{
		AI_Output (self, other, "DIA_Lutero_Hello_13_07");	//I could get you a ring of invincibility.
	};
	AI_Output (other, self, "DIA_Lutero_Hello_15_08");	//I'll see what I can do.
	Log_CreateTopic (TOPIC_Lutero, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Lutero, LOG_Running);
	B_LogEntry (TOPIC_Lutero, "The merchant Lutero is looking for the claws of a particularly powerful snapper.");
	Lutero_Krallen = LOG_Running;
};


instance DIA_Lutero_Kralle(C_Info)
{
	npc = VLK_404_Lutero;
	nr = 5;
	condition = DIA_Lutero_Kralle_Condition;
	information = DIA_Lutero_Kralle_Info;
	permanent = FALSE;
	description = "I've got some special snapper claws for you.";
};


func int DIA_Lutero_Kralle_Condition()
{
	if(Npc_HasItems(other,ItAt_ClawLeader) && Npc_KnowsInfo(other,DIA_Lutero_Snapper))
	{
		return TRUE;
	};
};

func void DIA_Lutero_Kralle_Info()
{
	AI_Output(other,self,"DIA_Lutero_Kralle_15_00");	//I've got some special snapper claws for you.
	AI_Output(self,other,"DIA_Lutero_Kralle_13_01");	//My customer will be happy to hear that.
	B_GiveInvItems(other,self,ItAt_ClawLeader,1);
	Npc_RemoveInvItem(self,ItAt_ClawLeader);
	Lutero_Krallen = LOG_SUCCESS;
	B_GivePlayerXP(XP_Ambient);
	if(other.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_Lutero_Hello_13_02");	//I don't have the runestone here. But I know where it can be found.
		AI_Output (self, other, "DIA_Lutero_Hello_13_03");	//On your way from town to the inn, you'll pass under a bridge.
		AI_Output (self, other, "DIA_Lutero_Hello_13_04");	//There, in a cave, a friend of mine has deposited a runestone in a chest. Here's the key.
		B_GiveInvItems(self,other,ItKe_Rune_MIS,1);
	}
	else
	{
		AI_Output (self, other, "DIA_Lutero_Hello_13_05");	//Here's the ring I promised you.
		B_GiveInvItems (self, other, ItRi_Prot_Total_01, 1);
	};
};


instance DIA_Lutero_Trade(C_Info)
{
	npc = VLK_404_Lutero;
	nr = 5;
	condition = DIA_Lutero_Trade_Condition;
	information = DIA_Lutero_Trade_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Lutero_Trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lutero_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Lutero_Trade_Info()
{
	AI_Output(other,self,"DIA_Lutero_Trade_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Lutero_PICKPOCKET(C_Info)
{
	npc = VLK_404_Lutero;
	nr = 900;
	condition = DIA_Lutero_PICKPOCKET_Condition;
	information = DIA_Lutero_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Lutero_PICKPOCKET_Condition()
{
	return C_Beklauen(58,65);
};

func void DIA_Lutero_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Lutero_PICKPOCKET);
	Info_AddChoice(DIA_Lutero_PICKPOCKET,Dialog_Back,DIA_Lutero_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Lutero_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Lutero_PICKPOCKET_DoIt);
};

func void DIA_Lutero_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Lutero_PICKPOCKET);
};

func void DIA_Lutero_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Lutero_PICKPOCKET);
};

