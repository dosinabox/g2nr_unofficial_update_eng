
instance DIA_Gaertner_EXIT(C_Info)
{
	npc = VLK_411_Gaertner;
	nr = 999;
	condition = DIA_Gaertner_EXIT_Condition;
	information = DIA_Gaertner_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Gaertner_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Gaertner_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Gaertner_PICKPOCKET(C_Info)
{
	npc = VLK_411_Gaertner;
	nr = 900;
	condition = DIA_Gaertner_PICKPOCKET_Condition;
	information = DIA_Gaertner_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Gaertner_PICKPOCKET_Condition()
{
	return C_Beklauen(40,50);
};

func void DIA_Gaertner_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Gaertner_PICKPOCKET);
	Info_AddChoice(DIA_Gaertner_PICKPOCKET,Dialog_Back,DIA_Gaertner_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Gaertner_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Gaertner_PICKPOCKET_DoIt);
};

func void DIA_Gaertner_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Gaertner_PICKPOCKET);
};

func void DIA_Gaertner_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Gaertner_PICKPOCKET);
};


instance DIA_Gaertner_Job(C_Info)
{
	npc = VLK_411_Gaertner;
	nr = 5;
	condition = DIA_Gaertner_Job_Condition;
	information = DIA_Gaertner_Job_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Gaertner_Job_Condition()
{
	return TRUE;
};

func void DIA_Gaertner_Job_Info()
{
	AI_Output (other, self, "DIA_Gaertner_Job_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Gaertner_Job_09_01");	//What do you think, hm? I'm a gardener, I take care of the garden.
	AI_Output (other, self, "DIA_Gaertner_Job_15_02");	//You're pretty much by yourself here, aren't you?
	AI_Output (self, other, "DIA_Gaertner_Job_09_03");	//Yes, and it should stay that way. I'm glad that I have some peace here.
	AI_Output (self, other, "DIA_Gaertner_Job_09_04");	//Once, they wanted to send me to the penal colony because I did some guy in.
	AI_Output (self, other, "DIA_Gaertner_Job_09_05");	//But Larius the governor needed another gardener, and so I could stay here.
	AI_Output (self, other, "DIA_Gaertner_Job_09_06");	//Over time, this garden has become my home. And I'm content with that.
	Player_KnowsLariusAsGovernor = TRUE;
};


instance DIA_Gaertner_Plants(C_Info)
{
	npc = VLK_411_Gaertner;
	nr = 5;
	condition = DIA_Gaertner_Plants_Condition;
	information = DIA_Gaertner_Plants_Info;
	permanent = FALSE;
	description = "Are you growing herbs as well?";
};


func int DIA_Gaertner_Plants_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaertner_Job))
	{
		return TRUE;
	};
};

func void DIA_Gaertner_Plants_Info()
{
	AI_Output (other, self, "DIA_Gaertner_Plants_15_00");	//Are you growing herbs as well?
	AI_Output (self, other, "DIA_Gaertner_Plants_09_01");	//A few. I'm growing fireweed and fire nettles. I also tried swampweed, but that doesn't really thrive here.
	AI_Output (self, other, "DIA_Gaertner_Plants_09_02");	//Well, I just harvested. So, if you want to buy something...
	Log_CreateTopic (TOPIC_CityTrader, LOG_NOTE);
	B_LogEntry (TOPIC_CityTrader, "The governor's gardener can sell me plants.");
};


instance DIA_Gaertner_Trade(C_Info)
{
	npc = VLK_411_Gaertner;
	nr = 5;
	condition = DIA_Gaertner_Trade_Condition;
	information = DIA_Gaertner_Trade_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Gaertner_Trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaertner_Plants))
	{
		return TRUE;
	};
};

func void DIA_Gaertner_Trade_Info()
{
	AI_Output(other,self,"DIA_Gaertner_Trade_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Gaertner_Krautabak(C_Info)
{
	npc = VLK_411_Gaertner;
	nr = 6;
	condition = DIA_Gaertner_Krautabak_Condition;
	information = DIA_Gaertner_Krautabak_Info;
	permanent = FALSE;
	description = "I've got some weed tobacco here.";
};


func int DIA_Gaertner_Krautabak_Condition()
{
	if(Npc_HasItems(other,ItMi_SumpfTabak) && Npc_KnowsInfo(other,DIA_Gaertner_Plants))
	{
		return TRUE;
	};
};

func void DIA_Gaertner_Krautabak_Info()
{
	AI_Output (other, self, "DIA_Gaertner_Krautabak_15_00");	//I've got some weed tobacco here. Want a smoke?
	AI_Output (self, other, "DIA_Gaertner_Krautabak_09_01");	//I don't know it - but sure, give it here. I'll roll myself a smoke.
	B_GiveInvItems(other,self,ItMi_SumpfTabak,1);
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	Npc_RemoveInvItem(self,ItMi_SumpfTabak);
	CreateInvItem(self,ItMi_Joint);
	B_UseItem(self,ItMi_Joint);
	AI_PlayAni(self,"T_MAGRUN_2_HEASHOOT");
	AI_Output(self,other,"DIA_Gaertner_Krautabak_09_02");	//Ack...ackack....
	AI_PlayAni(self,"T_HEASHOOT_2_STAND");
	AI_Output(self,other,"DIA_Gaertner_Krautabak_09_03");	//Harsh stuff. I think I'd better not smoke any more of it.
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Gaertner_Sign(C_Info)
{
	npc = VLK_411_Gaertner;
	nr = 800;
	condition = DIA_Gaertner_Sign_Condition;
	information = DIA_Gaertner_Sign_Info;
	permanent = FALSE;
	description = DIALOG_SecretSign;
};


func int DIA_Gaertner_Sign_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaertner_Job) && (Knows_SecretSign == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Gaertner_Sign_Info()
{
	AI_PlayAni(other,"T_YES");
	CreateInvItems(self,ItKe_Lockpick,3);
	AI_Output(self,other,"DIA_Gaertner_Sign_09_00");	//So you're one of us. Then I've got some useful information for you.
	AI_Output(self,other,"DIA_Gaertner_Sign_09_01");	//Some of the houses up here have secret panels that can only be opened by hidden switches.
	AI_Output(self,other,"DIA_Gaertner_Sign_09_02");	//People guard their valuables behind them.
};

instance DIA_Gaertner_FreeLockpicks(C_Info)
{
	npc = VLK_411_Gaertner;
	nr = 8;
	condition = DIA_Gaertner_FreeLockpicks_Condition;
	information = DIA_Gaertner_FreeLockpicks_Info;
	permanent = FALSE;
	description = "No more lock picks...";
};


func int DIA_Gaertner_FreeLockpicks_Condition()
{
	if(!Npc_HasItems(other,ItKe_Lockpick) && !Npc_HasItems(self,ItKe_Lockpick) && Npc_KnowsInfo(other,DIA_Gaertner_Sign))
	{
		return TRUE;
	};
};

func void DIA_Gaertner_FreeLockpicks_Info()
{
	B_Say(other,self,"$NOMOREPICKS");
	B_Say(self,other,"$ABS_GOOD");
	CreateInvItems(self,ItKe_Lockpick,3);
	B_GiveInvItems(self,other,ItKe_Lockpick,3);
};

