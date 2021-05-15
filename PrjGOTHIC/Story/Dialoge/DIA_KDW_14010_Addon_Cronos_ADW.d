
instance DIA_Addon_Cronos_ADW_EXIT(C_Info)
{
	npc = KDW_14010_Addon_Cronos_ADW;
	nr = 999;
	condition = DIA_Addon_Cronos_ADW_EXIT_Condition;
	information = DIA_Addon_Cronos_ADW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Cronos_ADW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Cronos_ADW_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Cronos_ADWHello(C_Info)
{
	npc = KDW_14010_Addon_Cronos_ADW;
	nr = 1;
	condition = DIA_Addon_Cronos_ADWHello_Condition;
	information = DIA_Addon_Cronos_ADWHello_Info;
	important = TRUE;
};


func int DIA_Addon_Cronos_ADWHello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cronos_ADWHello_Info()
{
	AI_Output (self, other, "DIA_Addon_Cronos_ADWHello_04_00");	//Nice to see you. We feared the worst.
	AI_Output (other, self, "DIA_Addon_Cronos_ADWHello_15_01");	//It wasn't all that bad. How's it going?
	AI_Output (self, other, "DIA_Addon_Cronos_ADWHello_04_02");	//This is a very dangerous region here.
	AI_Output (self, other, "DIA_Addon_Cronos_ADWHello_04_03");	//Some of the animals in the area have never been seen by anyone before us.
	AI_Output (self, other, "DIA_Addon_Cronos_ADWHello_04_04");	//Close by there is a large swamp that managed to grow for several hundred years without anyone noticing.
	AI_Output (self, other, "DIA_Addon_Cronos_ADWHello_04_05");	//Not a day goes by that we aren't attacked by the beasts from the swamp.
	AI_Output (self, other, "DIA_Addon_Cronos_ADWHello_04_06");	//I advise you to be careful if you go for a stroll here.
};


instance DIA_Addon_Cronos_WaechterADW(C_Info)
{
	npc = KDW_14010_Addon_Cronos_ADW;
	nr = 5;
	condition = DIA_Addon_Cronos_WaechterADW_Condition;
	information = DIA_Addon_Cronos_WaechterADW_Info;
	description = "Is there anything new about the stone sentinels?";
};


func int DIA_Addon_Cronos_WaechterADW_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Addon_Cronos_Waechter))
	{
		DIA_Addon_Cronos_WaechterADW.description = "Tell me more about these stone sentinels.";
	}
	else
	{
		DIA_Addon_Cronos_WaechterADW.description = "Is there anything new about the stone sentinels?";
	};
	return TRUE;
};

func void DIA_Addon_Cronos_WaechterADW_Info()
{
	if(!Npc_KnowsInfo(other,DIA_Addon_Cronos_Waechter))
	{
		AI_Output(other,self,"DIA_Addon_Cronos_Waechter_15_00");	//Tell me more about these stone sentinels.
	}
	else
	{
		AI_Output(other,self,"DIA_Addon_Cronos_WaechterADW_15_00");	//Is there anything new about the stone sentinels?
	};
	AI_Output (self, other, "DIA_Addon_Cronos_WaechterADW_04_01");	//We have already managed to eliminate some of them.
	AI_Output (self, other, "DIA_Addon_Cronos_WaechterADW_04_02");	//They stand there, paralyzed like pillars of salt, and don't budge.
	AI_Output (self, other, "DIA_Addon_Cronos_WaechterADW_04_03");	//But appearances deceive. If you get too close, they'll attack you!
	AI_Output (self, other, "DIA_Addon_Cronos_WaechterADW_04_04");	//There's no doubt that the source of their power can be found here somewhere.
};


instance DIA_Addon_Cronos_ADW_Trade(C_Info)
{
	npc = KDW_14010_Addon_Cronos_ADW;
	nr = 99;
	condition = DIA_Addon_Cronos_ADW_Trade_Condition;
	information = DIA_Addon_Cronos_ADW_Trade_Info;
	trade = TRUE;
	permanent = TRUE;
	description = DIALOG_TRADE_v1;
};


func int DIA_Addon_Cronos_ADW_Trade_Condition()
{
	return TRUE;
};


var int DIA_Addon_Cronos_ADW_Trade_OneTime;

func void DIA_Addon_Cronos_ADW_Trade_Info()
{
	if(CronosTraded == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_KDWTrader,LOG_NOTE);
		B_LogEntry(TOPIC_Addon_KDWTrader,LogText_Addon_CronosTrade);
		CronosTraded = TRUE;
	};
	B_GiveTradeInv(self);
	B_Say(other,self,"$TRADE_1");
	Trade_IsActive = TRUE;
};

