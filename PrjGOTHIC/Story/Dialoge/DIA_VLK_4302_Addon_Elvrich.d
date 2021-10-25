
instance DIA_Addon_Elvrich_EXIT(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 999;
	condition = DIA_Addon_Elvrich_EXIT_Condition;
	information = DIA_Addon_Elvrich_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Elvrich_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Elvrich_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Elvrich_PICKPOCKET(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 900;
	condition = DIA_Addon_Elvrich_PICKPOCKET_Condition;
	information = DIA_Addon_Elvrich_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Addon_Elvrich_PICKPOCKET_Condition()
{
	return C_Beklauen(62,110);
};

func void DIA_Addon_Elvrich_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Elvrich_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Elvrich_PICKPOCKET,Dialog_Back,DIA_Addon_Elvrich_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Elvrich_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Elvrich_PICKPOCKET_DoIt);
};

func void DIA_Addon_Elvrich_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Elvrich_PICKPOCKET);
};

func void DIA_Addon_Elvrich_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Elvrich_PICKPOCKET);
};


instance DIA_Addon_Elvrich_BanditsThere(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_BanditsThere_Condition;
	information = DIA_Addon_Elvrich_BanditsThere_Info;
	important = TRUE;
	permanent = TRUE;
};


var int DIA_Addon_Elvrich_BanditsThere_NoPerm;

func int DIA_Addon_Elvrich_BanditsThere_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (DIA_Addon_Elvrich_BanditsThere_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_BanditsThere_Info()
{
	if(Npc_IsDead(BDT_10307_Addon_RangerBandit_M) && Npc_IsDead(BDT_10308_Addon_RangerBandit_L) && Npc_IsDead(BDT_10309_Addon_RangerBandit_L) && Npc_IsDead(BDT_10310_Addon_RangerBandit_M))
	{
		AI_Output (self, other, "DIA_Addon_Elvrich_BanditsThere_04_00");	//Thank goodness. The bandits are done for. You have saved my life.
		DIA_Addon_Elvrich_BanditsThere_NoPerm = TRUE;
		self.aivar[AIV_NoFightParker] = FALSE;
	}
	else
	{
		B_Say(self,other,"$NOTNOW");
		AI_StopProcessInfos(self);
	};
};


instance DIA_Addon_Elvrich_Wer(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_Wer_Condition;
	information = DIA_Addon_Elvrich_Wer_Info;
	description = "Who are you?";
};


func int DIA_Addon_Elvrich_Wer_Condition()
{
	return TRUE;
};

func void DIA_Addon_Elvrich_Wer_Info()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_Wer_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Addon_Elvrich_Wer_04_01");	//My name is Elvrich. I come from town.
	if (MIS_Thorben_BringElvrichBack == LOG_Running)
	{
		AI_Output (other, self, "DIA_Addon_Elvrich_Wer_15_02");	//Master Thorben told me that you had disappeared.
	};
	AI_Output (self, other, "DIA_Addon_Elvrich_Wer_04_03");	//Those lowly scum dragged me off here and were keeping me prisoner.
};


instance DIA_Addon_Elvrich_MissingPeople(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_MissingPeople_Condition;
	information = DIA_Addon_Elvrich_MissingPeople_Info;
	description = "Lots of people are missing in town.";
};


func int DIA_Addon_Elvrich_MissingPeople_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Elvrich_Wer) && (SC_HearedAboutMissingPeople == TRUE) && (SCKnowsMissingPeopleAreInAddonWorld == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_MissingPeople_15_00");	//Lots of people are missing in town.
	AI_Output (self, other, "DIA_Addon_Elvrich_MissingPeople_04_01");	//I don't know anything about missing people. I can only tell you what happened to ME.
};


var int Elvrich_AskedLucia;
var int Elvrich_AskedPirates;

instance DIA_Addon_Elvrich_WhatExactly(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_WhatExactly_Condition;
	information = DIA_Addon_Elvrich_WhatExactly_Info;
	description = "What exactly happened to you?";
};


func int DIA_Addon_Elvrich_WhatExactly_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Elvrich_Wer))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_WhatExactly_Info()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_WhatExactly_15_00");	//What exactly happened to you?
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_04_01");	//I was on my way to the rendezvous I had set up with my girl.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_04_02");	//Her name is Lucia. We had been planning to get away to the mountains. Away from the town and all those who live there.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_04_03");	//I had just arrived at the meeting point when suddenly some of these bandits sprang out from the underbrush and captured us both.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_04_04");	//I put up a fight, of course, but to no avail. There were just too many of them. You didn't happen to see them?
	LuciaMentionedInKhorinis = TRUE;
	Info_ClearChoices(DIA_Addon_Elvrich_WhatExactly);
	Info_AddChoice(DIA_Addon_Elvrich_WhatExactly,"Tell me about Lucia.",DIA_Addon_Elvrich_WhatExactly_lucia);
	Info_AddChoice(DIA_Addon_Elvrich_WhatExactly,"What did the bandits want with you?",DIA_Addon_Elvrich_WhatExactly_Want);
};

func void DIA_Addon_Elvrich_WhatExactly_Want()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_WhatExactly_Want_15_00");	//What did the bandits want with you?
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Want_04_01");	//Sometimes I could overhear them at night. I didn't get everything, but I think they wanted to make us slaves.
	Info_AddChoice (DIA_Addon_Elvrich_WhatExactly, "Where were they going to take you?", DIA_Addon_Elvrich_WhatExactly_Pirates);
};

func void DIA_Addon_Elvrich_WhatExactly_Pirates()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_WhatExactly_Pirates_15_00");	//Where were they going to take you?
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Pirates_04_01");	//To a place somewhere here, on the island of Khorinis. But I think one can't get there without a ship.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Pirates_04_02");	//They brought me to a mooring place on the coast. Some pirates were camped out there.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Pirates_04_03");	//One of the bandits approached the pirates to negotiate. They were having a fierce argument.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Pirates_04_04");	//I think that the bandit wanted the pirates to ferry him somewhere, along with me.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Pirates_04_05");	//But the pirates wouldn't have it. So the bandits withdrew, and we've been sitting around here ever since.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Pirates_04_06");	//They seemed to be rather at a loss. And then you came.
	Elvrich_SCKnowsPirats = TRUE;
	Log_CreateTopic (TOPIC_Addon_WhoStolePeople, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_WhoStolePeople, LOG_Running);
	B_LogEntry (TOPIC_Addon_WhoStolePeople, "Elvrich, the apprentice of Thorben the carpenter from Khorinis, was kidnapped by bandits. The pirates seem to be in cahoots with the bandits.");
	Info_AddChoice (DIA_Addon_Elvrich_WhatExactly, "Pirates in Khorinis?", DIA_Addon_Elvrich_WhatExactly_Here);
	Info_AddChoice (DIA_Addon_Elvrich_WhatExactly, "Where's the pirates' mooring place?", DIA_Addon_Elvrich_WhatExactly_pirat);
};

func void DIA_Addon_Elvrich_WhatExactly_Here()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_WhatExactly_Here_15_00");	//Pirates in Khorinis?
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Here_04_01");	//I don't know very much about them. I first clapped eyes on one of them at the mooring place.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Here_04_02");	//They always stay in the background. Every single one of them is a wanted criminal in Khorinis.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_Here_04_03");	//They're afraid of the gallows. That's why you're never going to meet one of them in town.
	Elvrich_AskedPirates = TRUE;
};

func void DIA_Addon_Elvrich_WhatExactly_lucia()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_WhatExactly_lucia_15_00");	//Tell me about Lucia.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_lucia_04_01");	//A girl from the harbor district. She used to work for that horrible Bromor. She's very pretty.
	Elvrich_AskedLucia = TRUE;
};

func void DIA_Addon_Elvrich_WhatExactly_pirat()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_WhatExactly_pirat_15_00");	//Where's the pirates' mooring place?
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_pirat_04_01");	//Not far from the harbor of Khorinis.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_pirat_04_02");	//When you stand on the quay and look out to sea, all you need to do is get a boat and go to the right, along the coast.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhatExactly_pirat_04_03");	//The first small bay you come across is the mooring place I was talking about.
	Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
	B_LogEntry(TOPIC_Addon_WhoStolePeople,"To get to the pirates' mooring one has to go to the harbor of Khorinis. If you stand on the quay wall and look towards the sea, you have to swim to the right along the coast.");
	Info_ClearChoices(DIA_Addon_Elvrich_WhatExactly);
	Info_AddChoice(DIA_Addon_Elvrich_WhatExactly,Dialog_Back,DIA_Addon_Elvrich_WhatExactly_Back);
	if(Elvrich_AskedLucia == FALSE)
	{
		Info_AddChoice(DIA_Addon_Elvrich_WhatExactly,"Tell me about Lucia.",DIA_Addon_Elvrich_WhatExactly_lucia);
	};
	if(Elvrich_AskedPirates == FALSE)
	{
		Info_AddChoice(DIA_Addon_Elvrich_WhatExactly,"Pirates in Khorinis?",DIA_Addon_Elvrich_WhatExactly_Here);
	};
};

func void DIA_Addon_Elvrich_WhatExactly_Back()
{
	Info_ClearChoices(DIA_Addon_Elvrich_WhatExactly);
};


instance DIA_Addon_Elvrich_Bromor(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_Bromor_Condition;
	information = DIA_Addon_Elvrich_Bromor_Info;
	description = "Bromor says Lucia walked off with a golden dish ...";
};


func int DIA_Addon_Elvrich_Bromor_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Elvrich_WhatExactly) && (MIS_Bromor_LuciaStoleGold == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_Bromor_Info()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_Bromor_15_00");	//Bromor says Lucia walked off with a golden dish ...
	AI_Output (self, other, "DIA_Addon_Elvrich_Bromor_04_01");	//Well. If Lucia really stole from Bromor, the bandits will certainly have taken the thing from her.
	Log_CreateTopic (TOPIC_Addon_BromorsGold, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_BromorsGold, LOG_Running);
	B_LogEntry (TOPIC_Addon_BromorsGold, "Bromor's golden bowl is probably now in possession of the bandits in the northern woods behind Sekob's farm.");
};


instance DIA_Addon_Elvrich_WhereIsLucia(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_WhereIsLucia_Condition;
	information = DIA_Addon_Elvrich_WhereIsLucia_Info;
	description = "Where's Lucia now?";
};


func int DIA_Addon_Elvrich_WhereIsLucia_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Elvrich_WhatExactly) && (MIS_LuciasLetter != LOG_SUCCESS) && (MIS_LookingForLucia != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_WhereIsLucia_Info()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_WhereIsLucia_15_00");	//Where's Lucia now?
	AI_Output (self, other, "DIA_Addon_Elvrich_WhereIsLucia_04_01");	//We parted ways at the big crossroads in front of Onar's farm.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhereIsLucia_04_02");	//The bandits dragged Lucia off to the woods behind Sekob's farm.
	AI_Output (self, other, "DIA_Addon_Elvrich_WhereIsLucia_04_03");	//May Innos protect her.
	if(MIS_LookingForLucia == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_Lucia,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_Lucia,LOG_Running);
		MIS_LookingForLucia = LOG_Running;
	};
	if(MIS_LookingForLucia == LOG_Running)
	{
		B_LogEntry(TOPIC_Addon_Lucia,"Lucia was dragged off by the bandits to the woods behind Sekob's farm somewhere in the north.");
	};
	SC_KnowsLuciaCaughtByBandits = TRUE;
};


instance DIA_Addon_Elvrich_FernandosWaffen(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_FernandosWaffen_Condition;
	information = DIA_Addon_Elvrich_FernandosWaffen_Info;
	description = "Did the bandits who held you captive receive a shipment of weapons?";
};


func int DIA_Addon_Elvrich_FernandosWaffen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Elvrich_WhatExactly) && (MIS_Vatras_FindTheBanditTrader == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_FernandosWaffen_Info()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_FernandosWaffen_15_00");	//Did the bandits who held you captive receive a shipment of weapons?
	AI_Output (self, other, "DIA_Addon_Elvrich_FernandosWaffen_04_01");	//Oh yes. So many that they could barely carry them.
	AI_Output (self, other, "DIA_Addon_Elvrich_FernandosWaffen_04_02");	//They took the whole kaboodle and disappeared towards Sekob's farm.
	B_GivePlayerXP (XP_Ambient);
	Log_CreateTopic (TOPIC_Addon_Bandittrader, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Bandittrader, LOG_Running);
	B_LogEntry (TOPIC_Addon_Bandittrader, "The trail leads me to the woods behind Sekob's farm somewhere in the north. They say there are bandits there who have received a lot of weapons.");
};


instance DIA_Addon_Elvrich_LuciaLetter(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 4;
	condition = DIA_Addon_Elvrich_LuciaLetter_Condition;
	information = DIA_Addon_Elvrich_LuciaLetter_Info;
	description = "I found a letter from your Lucia.";
};


func int DIA_Addon_Elvrich_LuciaLetter_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Elvrich_WhatExactly) && Npc_HasItems(other,ItWr_LuciasLoveLetter_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_LuciaLetter_Info()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_LuciaLetter_15_00");	//I found a letter from your Lucia.
	AI_Output (self, other, "DIA_Addon_Elvrich_LuciaLetter_04_01");	//(excited) What? Give it here!
	AI_PrintScreen("Lucia's farewell letter given",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	B_UseFakeScroll();
	AI_Output (self, other, "DIA_Addon_Elvrich_LuciaLetter_04_02");	//(desperate) NO! I don't believe this. No. I just can't believe it.
	AI_Output (self, other, "DIA_Addon_Elvrich_LuciaLetter_04_03");	//(desperate) She can't just leave me behind like this.
	AI_Output (self, other, "DIA_Addon_Elvrich_LuciaLetter_04_04");	//(desperate) Take this letter back. I don't want it. I firmly believe that she's going to come back to me some day.
	AI_PrintScreen("Lucia's farewell letter given",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	MIS_LuciasLetter = LOG_SUCCESS;
	if(MIS_LookingForLucia == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_Lucia,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_Lucia,LOG_Running);
		MIS_LookingForLucia = LOG_Running;
	};
	if((MIS_LookingForLucia == LOG_Running) || (MIS_LookingForLucia == LOG_SUCCESS))
	{
		B_LogEntry(TOPIC_Addon_Lucia,"Elvrich doesn't want to believe that Lucia went with the bandits voluntarily. He still hopes for her return, in spite of the farewell letter she wrote him..");
	};
	B_GivePlayerXP(XP_Addon_LuciasLetter);
};


instance DIA_Addon_Elvrich_WasNun(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_WasNun_Condition;
	information = DIA_Addon_Elvrich_WasNun_Info;
	permanent = FALSE;
	description = "You should get yourself back to town in a hurry!";
};


func int DIA_Addon_Elvrich_WasNun_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Elvrich_WhereIsLucia) || (MIS_LuciasLetter == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_WasNun_Info()
{
	AI_Output (other, self, "DIA_Addon_Elvrich_WasNun_15_00");	//You should get yourself back to town in a hurry!
	AI_Output (self, other, "DIA_Addon_Elvrich_WasNun_04_01");	//What else would I be doing? I'm going straight back to my Master Thorben.
	AI_Output (self, other, "DIA_Addon_Elvrich_WasNun_04_02");	//Will you go look for the bandits?
	AI_Output (other, self, "DIA_Addon_Elvrich_WasNun_15_03");	//Well, yes, I think so ...
	AI_Output (self, other, "DIA_Addon_Elvrich_WasNun_04_04");	//If you find Lucia, get her safely back to town, will you?
	AI_Output (other, self, "DIA_Addon_Elvrich_WasNun_15_05");	//I'll see what I can do.
	//AI_Output(self,other,"OUTRO_Xardas_04_00");	//До встречи!
	CreateInvItem(self,ItMw_1h_Vlk_Axe);
	AI_EquipBestMeleeWeapon(self);
	if(MissingPeopleReturnedHome == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
	};
	B_LogEntry(TOPIC_Addon_MissingPeople,"Elvrich has gone back to the master carpenter Thorben.");
	Elvrich_GoesBack2Thorben = TRUE;
	AI_EquipBestMeleeWeapon(self);
	Npc_ExchangeRoutine(self,"BACKINTHECITY");
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Elvrich_PERM(C_Info)
{
	npc = VLK_4302_Addon_Elvrich;
	nr = 5;
	condition = DIA_Addon_Elvrich_PERM_Condition;
	information = DIA_Addon_Elvrich_PERM_Info;
	permanent = TRUE;
//	important = TRUE;
	description = "Are you all right?";
};


func int DIA_Addon_Elvrich_PERM_Condition()
{
	if((Elvrich_GoesBack2Thorben == TRUE) && Npc_IsInState(self,ZS_Talk) && (MIS_LuciasLetter != LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Elvrich_PERM_Info()
{
	DIA_Common_IsEverythingOk();
	AI_Output(self,other,"DIA_Addon_Elvrich_PERM_04_00");	//Thanks for saving me!
	AI_StopProcessInfos(self);
};

