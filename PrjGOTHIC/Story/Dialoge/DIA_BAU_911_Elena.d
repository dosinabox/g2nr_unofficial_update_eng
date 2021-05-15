
instance DIA_Elena_EXIT(C_Info)
{
	npc = BAU_911_Elena;
	nr = 999;
	condition = DIA_Elena_EXIT_Condition;
	information = DIA_Elena_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Elena_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Elena_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Elena_HALLO(C_Info)
{
	npc = BAU_911_Elena;
	nr = 1;
	condition = DIA_Elena_HALLO_Condition;
	information = DIA_Elena_HALLO_Info;
	permanent = FALSE;
	description = "Hello, pretty girl.";
};


func int DIA_Elena_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Elena_HALLO_Info()
{
	AI_Output (other, self, "DIA_Elena_HALLO_15_00");	//Hello, pretty girl.
	if (other.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Elena_HALLO_16_01");	//Hm. Just where did you escape from?
	}
	else
	{
		AI_Output (self, other, "DIA_Elena_HALLO_16_02");	//What did you want?
	};
};


instance DIA_Elena_Aufstand(C_Info)
{
	npc = BAU_911_Elena;
	nr = 2;
	condition = DIA_Elena_Aufstand_Condition;
	information = DIA_Elena_Aufstand_Info;
	permanent = FALSE;
	description = "They say you are revolting against the King?";
};


func int DIA_Elena_Aufstand_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Elena_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Elena_Aufstand_Info()
{
	AI_Output (other, self, "DIA_Elena_Aufstand_15_00");	//They say you are revolting against the King?
	AI_Output (self, other, "DIA_Elena_Aufstand_16_01");	//My father has decided that it's time we defended ourselves.
	if (other.guild != GIL_MIL)
	{
		AI_Output (self, other, "DIA_Elena_Aufstand_16_02");	//The militia never helped us anyway. They only came here to drag off our provisions.
	};
};


instance DIA_Elena_Arbeit(C_Info)
{
	npc = BAU_911_Elena;
	nr = 3;
	condition = DIA_Elena_Arbeit_Condition;
	information = DIA_Elena_Arbeit_Info;
	permanent = FALSE;
	description = "What kind of work is to be had here on the farm?";
};


func int DIA_Elena_Arbeit_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Elena_HALLO) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Elena_Arbeit_Info()
{
	AI_Output (other, self, "DIA_Elena_Arbeit_15_00");	//What kind of work is to be had here on the farm?
	AI_Output (self, other, "DIA_Elena_Arbeit_16_01");	//My father pays money to all the men who help defend the farm.
	AI_Output (self, other, "DIA_Elena_Arbeit_16_02");	//Are you interested? You don't look like someone who has a passion for field labor.
	AI_Output (other, self, "DIA_Elena_Arbeit_15_03");	//How much does your father pay?
	AI_Output (self, other, "DIA_Elena_Arbeit_16_04");	//You'd have to negotiate that with him.
	AI_Output (self, other, "DIA_Elena_Arbeit_16_05");	//All I know is that each mercenary here gets paid every day.
};


instance DIA_Elena_Regeln(C_Info)
{
	npc = BAU_911_Elena;
	nr = 4;
	condition = DIA_Elena_Regeln_Condition;
	information = DIA_Elena_Regeln_Info;
	permanent = FALSE;
	description = "Are there any rules here that I should stick to?";
};


func int DIA_Elena_Regeln_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Elena_HALLO) && ((other.guild == GIL_NONE) || (other.guild == GIL_SLD)))
	{
		return TRUE;
	};
};

func void DIA_Elena_Regeln_Info()
{
	AI_Output (other, self, "DIA_Elena_Regeln_15_00");	//Are there any rules here that I should stick to?
	AI_Output (self, other, "DIA_Elena_Regeln_16_01");	//You don't touch anything here that isn't yours.
	AI_Output (self, other, "DIA_Elena_Regeln_16_02");	//You stay away from areas that are none of your business.
	AI_Output (self, other, "DIA_Elena_Regeln_16_03");	//And if you must pick a fight, stick to the mercenaries.
	AI_Output (self, other, "DIA_Elena_Regeln_16_04");	//If you start a brawl with the farmers, everybody here will be against you.
};


instance DIA_Elena_AUFGABE(C_Info)
{
	npc = BAU_911_Elena;
	nr = 5;
	condition = DIA_Elena_AUFGABE_Condition;
	information = DIA_Elena_AUFGABE_Info;
	permanent = FALSE;
	description = "What's your job here?";
};


func int DIA_Elena_AUFGABE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Elena_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Elena_AUFGABE_Info()
{
	AI_Output (other, self, "DIA_Elena_AUFGABE_15_00");	//What's your job here?
	AI_Output (self, other, "DIA_Elena_AUFGABE_16_01");	//I sell the goods that we produce. If you want to buy something, just let me know.
	AI_Output (self, other, "DIA_Elena_AUFGABE_16_02");	//But let me warn you. I won't stand for either haggling or stealing, understood?
	Log_CreateTopic (Topic_SoldierTrader, LOG_NOTE);
	B_LogEntry (Topic_SoldierTrader, "Elena sells goods on Onar's farm.");
};


var int Elena_Trade_mit_mir;

instance DIA_Elena_TRADE(C_Info)
{
	npc = BAU_911_Elena;
	nr = 7;
	condition = DIA_Elena_TRADE_Condition;
	information = DIA_Elena_TRADE_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Elena_TRADE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Elena_AUFGABE) || (Elena_Trade_mit_mir == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Elena_TRADE_Info()
{
	AI_Output(other,self,"DIA_Elena_TRADE_15_00");	//Show me your wares!
	B_GiveTradeInv(self);
	AI_Output(self,other,"DIA_Elena_TRADE_16_01");	//What can I offer you?
	if(MIS_Serpentes_MinenAnteil_KDF == LOG_Running)
	{
		ElenaMinenAnteil = TRUE;
	};
	Trade_IsActive = TRUE;
};


instance DIA_Elena_PERM(C_Info)
{
	npc = BAU_911_Elena;
	nr = 900;
	condition = DIA_Elena_PERM_Condition;
	information = DIA_Elena_PERM_Info;
	permanent = TRUE;
	description = "Has anything significant happened lately?";
};


func int DIA_Elena_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Elena_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Elena_PERM_Info()
{
	AI_Output (other, self, "DIA_Elena_PERM_15_00");	//Has anything significant happened lately?
	if (Kapitel <= 1)
	{
		AI_Output (self, other, "DIA_Elena_PERM_16_01");	//A few days ago, my father decreed that we're no longer allowed to sell anything in town.
		AI_Output (self, other, "DIA_Elena_PERM_16_02");	//So now I'm staying here on the farm and selling my wares to visitors only.
		Elena_Trade_mit_mir = TRUE;
	}
	else if(Kapitel == 2)
	{
		AI_Output (self, other, "DIA_Elena_PERM_16_03");	//The militia attacks on the neighboring farms are getting more frequent. Only a question of time until my father will intervene.
	}
	else if(Kapitel == 3)
	{
		AI_Output (self, other, "DIA_Elena_PERM_16_04");	//The land has become quite unsafe. Now no one ventures beyond his own fields. It's been a long time since any of us has been to town.
	}
	else if(Kapitel == 4)
	{
		AI_Output (self, other, "DIA_Elena_PERM_16_05");	//The mercenaries have become more and more restless. But since Sylvio and his boys have left, they seem to relax a little.
	}
	else
	{
		AI_Output (self, other, "DIA_Elena_PERM_16_06");	//Everybody keeps talking about the impending orc attack. But I don't really believe in that. I think we're safe from them here on the farm.
	};
};


instance DIA_Elena_MINENANTEIL(C_Info)
{
	npc = BAU_911_Elena;
	nr = 2;
	condition = DIA_Elena_MINENANTEIL_Condition;
	information = DIA_Elena_MINENANTEIL_Info;
	description = "You're selling mine shares?";
};


func int DIA_Elena_MINENANTEIL_Condition()
{
//	if((hero.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running) && Npc_KnowsInfo(other,DIA_Elena_HALLO))
//	if((hero.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running) && Npc_KnowsInfo(other,DIA_Elena_TRADE))
	if((hero.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running) && (ElenaMinenAnteil == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Elena_MINENANTEIL_Info()
{
	AI_Output (other, self, "DIA_Elena_MINENANTEIL_15_00");	//You're selling mine shares?
	AI_Output (self, other, "DIA_Elena_MINENANTEIL_16_01");	//So what. I paid an arm and a leg for them myself.
	B_GivePlayerXP (XP_Ambient);
};


instance DIA_Elena_PICKPOCKET(C_Info)
{
	npc = BAU_911_Elena;
	nr = 900;
	condition = DIA_Elena_PICKPOCKET_Condition;
	information = DIA_Elena_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40_Female;
};


func int DIA_Elena_PICKPOCKET_Condition()
{
	return C_Beklauen(30,35);
};

func void DIA_Elena_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Elena_PICKPOCKET);
	Info_AddChoice(DIA_Elena_PICKPOCKET,Dialog_Back,DIA_Elena_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Elena_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Elena_PICKPOCKET_DoIt);
};

func void DIA_Elena_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Elena_PICKPOCKET);
};

func void DIA_Elena_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Elena_PICKPOCKET);
};

