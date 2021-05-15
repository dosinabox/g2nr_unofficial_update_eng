
instance DIA_Addon_Cronos_EXIT(C_Info)
{
	npc = KDW_1401_Addon_Cronos_NW;
	nr = 999;
	condition = DIA_Addon_Cronos_EXIT_Condition;
	information = DIA_Addon_Cronos_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Cronos_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Cronos_EXIT_Info()
{
	if(Trade_IsActive == TRUE)
	{
		Trade_IsActive = FALSE;
	};
	if(Cronos_NW_ItemsGiven_Chapter_1 == TRUE)
	{
		Cronos_NW_ItMi_Flask_Count = Npc_HasItems(self,ItMi_Flask);
		Cronos_NW_ItMi_Sulfur_Count = Npc_HasItems(self,ItMi_Sulfur);
		Cronos_NW_ItMi_Pitch_Count = Npc_HasItems(self,ItMi_Pitch);
		Cronos_NW_ItPo_Mana_01_Count = Npc_HasItems(self,ItPo_Mana_01);
		Cronos_NW_ItPo_Health_01_Count = Npc_HasItems(self,ItPo_Health_01);
		Cronos_NW_ItSc_Light_Count = Npc_HasItems(self,ItSc_Light);
		Cronos_NW_ItSc_Firebolt_Count = Npc_HasItems(self,ItSc_Firebolt);
		Cronos_NW_ItSc_Zap_Count = Npc_HasItems(self,ItSc_Zap);
		Cronos_NW_ItSc_LightHeal_Count = Npc_HasItems(self,ItSc_LightHeal);
		Cronos_NW_ItSc_SumGobSkel_Count = Npc_HasItems(self,ItSc_SumGobSkel);
		Cronos_NW_ItSc_Icelance_Count = Npc_HasItems(self,ItSc_Icelance);
		Cronos_NW_ItSc_Whirlwind_Count = Npc_HasItems(self,ItSc_Whirlwind);
	};
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Cronos_Hallo(C_Info)
{
	npc = KDW_1401_Addon_Cronos_NW;
	nr = 5;
	condition = DIA_Addon_Cronos_Hallo_Condition;
	information = DIA_Addon_Cronos_Hallo_Info;
	description = "May I bother you for a moment?";
};


func int DIA_Addon_Cronos_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Addon_Cronos_Hallo_Info()
{
	AI_Output (other, self, "DIA_Addon_Cronos_Hallo_15_00");	//May I bother you for a moment?
	AI_Output (self, other, "DIA_Addon_Cronos_Hallo_04_01");	//(surprised) It's YOU. I never thought I would see your face again.
	AI_Output (self, other, "DIA_Addon_Cronos_Hallo_04_02");	//It's very brave of you to show up here. There was a time we would have skinned you alive.
	AI_Output (self, other, "DIA_Addon_Cronos_Hallo_04_03");	//You can be glad that was a few weeks ago and we've all calmed down.
};


instance DIA_Addon_Cronos_WasMachstdu(C_Info)
{
	npc = KDW_1401_Addon_Cronos_NW;
	nr = 5;
	condition = DIA_Addon_Cronos_WasMachstdu_Condition;
	information = DIA_Addon_Cronos_WasMachstdu_Info;
	description = "What are you doing here?";
};


func int DIA_Addon_Cronos_WasMachstdu_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cronos_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cronos_WasMachstdu_Info()
{
	AI_Output (other, self, "DIA_Addon_Cronos_WasMachstdu_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Addon_Cronos_WasMachstdu_04_01");	//(confused) My task is to find out more about the guardians of the temple.
	AI_Output (self, other, "DIA_Addon_Cronos_WasMachstdu_04_02");	//That is a tough nut, let me tell you. These stone sentinels have a characteristic that is utterly foreign to me.
	AI_Output (self, other, "DIA_Addon_Cronos_WasMachstdu_04_03");	//One moment they're standing around completely lifeless and the next they're attacking you like they're possessed.
	AI_Output (self, other, "DIA_Addon_Cronos_WasMachstdu_04_04");	//I still haven't been able to determine their driving power, but one thing is sure. It is of magical origin.
};


instance DIA_Addon_Cronos_Waechter(C_Info)
{
	npc = KDW_1401_Addon_Cronos_NW;
	nr = 5;
	condition = DIA_Addon_Cronos_Waechter_Condition;
	information = DIA_Addon_Cronos_Waechter_Info;
	description = "Tell me more about these stone sentinels.";
};


func int DIA_Addon_Cronos_Waechter_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cronos_WasMachstdu))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cronos_Waechter_Info()
{
	AI_Output (other, self, "DIA_Addon_Cronos_Waechter_15_00");	//Tell me more about these stone sentinels.
	AI_Output (self, other, "DIA_Addon_Cronos_Waechter_04_01");	//(confused) I can't tell you much so far. Unfortunately, we have had to destroy them. Now they aren't dangerous.
	AI_Output (self, other, "DIA_Addon_Cronos_Waechter_04_02");	//When we came here, they attacked us.
	AI_Output (self, other, "DIA_Addon_Cronos_Waechter_04_03");	//We could only defeat them with our combined power, and I'm afraid there are even more waiting for us behind the portal.
	AI_Output (self, other, "DIA_Addon_Cronos_Waechter_04_04");	//There must be a way to banish their driving force, so that they remain nothing more than statues.
};


instance DIA_Addon_Cronos_NW_Trade(C_Info)
{
	npc = KDW_1401_Addon_Cronos_NW;
	nr = 5;
	condition = DIA_Addon_Cronos_NW_Trade_Condition;
	information = DIA_Addon_Cronos_NW_Trade_Info;
	trade = TRUE;
	permanent = TRUE;
	description = "Can you sell me some equipment?";
};


func int DIA_Addon_Cronos_NW_Trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cronos_WasMachstdu))
	{
		return TRUE;
	};
};


//var int DIA_Addon_Cronos_NW_Trade_OneTime;

func void DIA_Addon_Cronos_NW_Trade_Info()
{
	AI_Output(other,self,"DIA_Addon_Cronos_NW_Trade_15_00");	//Can you sell me some equipment?
	B_GiveTradeInv(self);
	if(CronosTraded == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Cronos_NW_Trade_04_01");	//Why not? If I remember correctly, we've already done business.
		Log_CreateTopic(TOPIC_Addon_KDWTrader,LOG_NOTE);
		B_LogEntry(TOPIC_Addon_KDWTrader,LogText_Addon_CronosTrade);
		CronosTraded = TRUE;
	};
	AI_Output(self,other,"DIA_Addon_Cronos_NW_Trade_04_02");	//Tell me what you need.
	Trade_IsActive = TRUE;
};

