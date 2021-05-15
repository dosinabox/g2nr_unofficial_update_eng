
instance DIA_Fenia_EXIT(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 999;
	condition = DIA_Fenia_EXIT_Condition;
	information = DIA_Fenia_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Fenia_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Fenia_EXIT_Info()
{
	if((VisibleGuild(other) == GIL_KDF) || (VisibleGuild(other) == GIL_KDW))
	{
		AI_Output (self, other, "DIA_Fenia_EXIT_17_00");	//Have a nice day, Mr. Paladin.
	};
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Fenia_PICKPOCKET(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 900;
	condition = DIA_Fenia_PICKPOCKET_Condition;
	information = DIA_Fenia_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60_Female;
};


func int DIA_Fenia_PICKPOCKET_Condition()
{
	return C_Beklauen(50,75);
};

func void DIA_Fenia_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Fenia_PICKPOCKET);
	Info_AddChoice(DIA_Fenia_PICKPOCKET,Dialog_Back,DIA_Fenia_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Fenia_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Fenia_PICKPOCKET_DoIt);
};

func void DIA_Fenia_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Fenia_PICKPOCKET);
};

func void DIA_Fenia_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Fenia_PICKPOCKET);
};


instance DIA_Fenia_Hallo(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 3;
	condition = DIA_Fenia_Hallo_Condition;
	information = DIA_Fenia_Hallo_Info;
	important = TRUE;
};


func int DIA_Fenia_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Fenia_Hallo_Info()
{
	if((hero.guild == GIL_NONE) || (hero.guild == GIL_NOV))
	{
		AI_Output (self, other, "DIA_Fenia_Hallo_17_00");	//You look a little worse for wear. Haven't slept in a long time, have you?
		AI_Output (other, self, "DIA_Fenia_Hallo_15_01");	//Too long, I should say.
	};
	AI_Output (self, other, "DIA_Fenia_Hallo_17_02");	//Come on, step closer. With me, you'll find what you're looking for!
	Log_CreateTopic (TOPIC_CityTrader, LOG_NOTE);
	B_LogEntry (TOPIC_CityTrader, "Fenia sells food on the way to the harbor.");
};


instance DIA_Fenia_Hallo_Pal(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 4;
	condition = DIA_Fenia_Hallo_Pal_Condition;
	information = DIA_Fenia_Hallo_Pal_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Fenia_Hallo_Pal_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (VisibleGuild(other) == GIL_PAL) && Npc_KnowsInfo(other,DIA_Fenia_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Fenia_Hallo_Pal_Info()
{
	AI_Output(self,other,"DIA_Fenia_EXIT_17_00");	//Приветствую, мистер паладин.
};


var int Fenia_ItemsGiven_Paket;

instance DIA_Fenia_HANDELN(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 10;
	condition = DIA_Fenia_HANDELN_Condition;
	information = DIA_Fenia_HANDELN_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "Show me your wares.";
};


func int DIA_Fenia_HANDELN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fenia_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Fenia_HANDELN_Info()
{
	AI_Output(other,self,"DIA_Fenia_HANDELN_15_00");	//Show me your wares.
	if((MIS_Baltram_ScoutAkil == LOG_FAILED) && (Fenia_ItemsGiven_Paket == FALSE))
	{
		CreateInvItems(self,ItFo_Cheese,5);
		CreateInvItems(self,ItFo_Apple,10);
		CreateInvItems(self,ItFo_Beer,5);
		CreateInvItems(self,ItFo_Bacon,5);
		CreateInvItems(self,ItFo_Sausage,5);
		Fenia_ItemsGiven_Paket = TRUE;
	};
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Fenia_Infos(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 10;
	condition = DIA_Fenia_Infos_Condition;
	information = DIA_Fenia_Infos_Info;
	permanent = FALSE;
	description = "You said that you've got what I need. Does that include information?";
};


func int DIA_Fenia_Infos_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fenia_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Fenia_Infos_Info()
{
	AI_Output (other, self, "DIA_Fenia_Infos_15_00");	//You said that you've got what I need. Does that include information?
	AI_Output (self, other, "DIA_Fenia_Infos_17_01");	//But of course. What is it you want to know?
};


instance DIA_Fenia_MoreTraders(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 11;
	condition = DIA_Fenia_MoreTraders_Condition;
	information = DIA_Fenia_MoreTraders_Info;
	permanent = FALSE;
	description = "Are there any other traders here at the harbor?";
};


func int DIA_Fenia_MoreTraders_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fenia_Infos))
	{
		return TRUE;
	};
};

func void DIA_Fenia_MoreTraders_Info()
{
	AI_Output (other, self, "DIA_Fenia_Infos_haendler_15_00");	//Are there any other traders here at the harbor?
	AI_Output (self, other, "DIA_Fenia_Infos_haendler_17_01");	//If you keep to the left at the quay, you'll find Halvor, my husband. He sells fish.
	AI_Output (self, other, "DIA_Fenia_Infos_haendler_17_02");	//On the other side, there's Brahim, the cartographer.
};


instance DIA_Fenia_OV(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 13;
	condition = DIA_Fenia_OV_Condition;
	information = DIA_Fenia_OV_Info;
	permanent = FALSE;
	description = "Do you know anyone from the upper quarter?";
};


func int DIA_Fenia_OV_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fenia_Infos) && (Mil_305_schonmalreingelassen == FALSE))
	{
		if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Fenia_OV_Info()
{
	AI_Output (other, self, "DIA_Fenia_Infos_oberesViertel_15_00");	//Do you know anyone from the upper quarter?
	AI_Output (self, other, "DIA_Fenia_Infos_oberesViertel_17_01");	//(laughs) If I knew anyone up there I wouldn't be standing here, my boy.
};


instance DIA_Fenia_Interesting(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 14;
	condition = DIA_Fenia_Interesting_Condition;
	information = DIA_Fenia_Interesting_Info;
	permanent = FALSE;
	description = "What interesting things are there to see around the harbor?";
};


func int DIA_Fenia_Interesting_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fenia_Infos))
	{
		return TRUE;
	};
};

func void DIA_Fenia_Interesting_Info()
{
	AI_Output (other, self, "DIA_Fenia_Infos_interessantes_15_00");	//What interesting things are there to see about the harbor?
	AI_Output (self, other, "DIA_Fenia_Infos_interessantes_17_01");	//Well. If you're looking for some action, go on down to Kardif's pub at the quay. There's always something brewing there.
	if(!Npc_IsDead(Moe))
	{
		AI_Output(self,other,"DIA_Fenia_Infos_interessantes_17_02");	//You can hardly miss it. The guy standing by the entrance there will certainly draw your attention to it.
	};
	AI_Output (self, other, "DIA_Fenia_Infos_interessantes_17_03");	//Besides that, there's the large ship of the paladins. The King's stately war galley. That one's really worth seeing.
	AI_Output (self, other, "DIA_Fenia_Infos_interessantes_17_04");	//You'll find it if you keep left at the quay and then pass under the high rock face.
};


instance DIA_Fenia_Aufregend(C_Info)
{
	npc = VLK_476_Fenia;
	nr = 15;
	condition = DIA_Fenia_Aufregend_Condition;
	information = DIA_Fenia_Aufregend_Info;
	permanent = FALSE;
	description = "Has anything exciting happened here lately?";
};


func int DIA_Fenia_Aufregend_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fenia_Infos))
	{
		return TRUE;
	};
};

func void DIA_Fenia_Aufregend_Info()
{
	AI_Output(other,self,"DIA_Fenia_Add_15_00");	//Has anything exciting happened lately?
	if(MIS_Bosper_Bogen != LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Fenia_Add_17_01");	//You could say so. It wasn't that long ago.
	};
	AI_Output (self, other, "DIA_Fenia_Add_17_02");	//A thief ran by here. He must have stolen a bow in the lower part of the city.
	AI_Output (self, other, "DIA_Fenia_Add_17_03");	//Of course, the militia came way too late, like always.
	AI_Output (self, other, "DIA_Fenia_Add_17_04");	//He got away from them - just jumped into the harbor, and he was gone.
};

