
instance DIA_Addon_Saturas_EXIT(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 999;
	condition = DIA_Addon_Saturas_EXIT_Condition;
	information = DIA_Addon_Saturas_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Saturas_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Saturas_EXIT_Info()
{
	if((MIS_Addon_Saturas_BringRiordian2Me == FALSE) && (Npc_GetDistToWP(self,"NW_TROLLAREA_PORTALTEMPEL_STUDY_01") < 700))
	{
		if((MIS_Addon_Nefarius_BringMissingOrnaments == LOG_SUCCESS) || Npc_KnowsInfo(other,DIA_Addon_Saturas_Nefarius) || (VatrasLetterGivenToSaturas == TRUE) || Npc_KnowsInfo(other,DIA_Addon_Saturas_geheimbund) || (SaturasKnows_SC_IsRanger == TRUE))
		{
			if((MIS_Addon_Nefarius_BringMissingOrnaments == LOG_SUCCESS) || Npc_KnowsInfo(other,DIA_Addon_Saturas_Nefarius) || (VatrasLetterGivenToSaturas == TRUE))
			{
				AI_Output(self,other,"DIA_Addon_Saturas_auftrag_14_01");	//Since there's no way of stopping you from keeping the other Mages from doing their work, you might as well take a message from me to one of them.
			};
			AI_Output(self,other,"DIA_Addon_Saturas_auftrag_14_02");	//Tell Riordian that I wish to see him here.
			AI_Output(self,other,"DIA_Addon_Saturas_auftrag_14_03");	//He is in the rear part of the vault. You will find him there.
			MIS_Addon_Saturas_BringRiordian2Me = LOG_Running;
			Log_CreateTopic(TOPIC_Addon_HolRiordian,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_HolRiordian,LOG_Running);
			B_LogEntry(TOPIC_Addon_HolRiordian,"Saturas wants me to send the Water Mage Riordian to him. He should be in the rear area of the vaults at the excavation site.");
		};
	};
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Saturas_Nefarius(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 2;
	condition = DIA_Addon_Saturas_Nefarius_Condition;
	information = DIA_Addon_Saturas_Nefarius_Info;
	description = "I am supposed to find the lost parts of the ornament for Nefarius.";
};


func int DIA_Addon_Saturas_Nefarius_Condition()
{
	if(MIS_Addon_Nefarius_BringMissingOrnaments == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_Nefarius_Info()
{
	AI_Output (other, self, "DIA_ADDON_Saturas_Nefarius_15_00");	//I am supposed to find the lost parts of the ornament for Nefarius.
	AI_Output (self, other, "DIA_ADDON_Saturas_Nefarius_14_01");	//What? That is unbelievable! You are involved again?
	AI_Output (other, self, "DIA_ADDON_Saturas_Nefarius_15_02");	//Don't worry, I'll bring the things here.
	if ((ORNAMENT_SWITCHED_FOREST == FALSE) && Npc_HasItems (other, ItWr_Map_NewWorld_Ornaments_Addon))
	{
		Log_CreateTopic(TOPIC_Addon_Ornament,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_Ornament,LOG_Running);
		AI_Output (self, other, "DIA_ADDON_Saturas_Nefarius_14_03");	//(sighs) Do you at least know what you are looking for?
		AI_Output (other, self, "DIA_ADDON_Saturas_Nefarius_15_04");	//Nefarius gave me this map...
		AI_Output (self, other, "DIA_ADDON_Saturas_Nefarius_14_05");	//Show me!
		AI_PrintScreen("Given: Nefarius' Map",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
		B_UseFakeMap(2);
		AI_Output(self,other,"DIA_ADDON_Saturas_Nefarius_14_06");	//Hmmm. It is very dangerous in the big forest. You should not go alone.
		if(Kapitel < 3)
		{
			AI_Output(self,other,"DIA_ADDON_Saturas_Nefarius_14_07");	//Look for someone to accompany you in Khorinis.
			B_LogEntry(TOPIC_Addon_Ornament,"Saturas says I shouldn't go alone when I search for one of the ornament fragments in the big woods. I should go to Khorinis and look for someone to accompany me.");
		}
		else
		{
			B_LogEntry(TOPIC_Addon_Ornament,"Saturas warned me that the forest in which I'm to find the ornament could be very dangerous.");
		};
		AI_Output (self, other, "DIA_ADDON_Saturas_Nefarius_14_08");	//I do not want you eaten by monsters - and the ornament with you.
		AI_Output (self, other, "DIA_ADDON_Saturas_Nefarius_14_09");	//Here is your map back...
		AI_PrintScreen("Received: Nefarius' Map",-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
	};
};


instance DIA_Addon_Saturas_Hallo(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 2;
	condition = DIA_Addon_Saturas_Hallo_Condition;
	information = DIA_Addon_Saturas_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Saturas_Hallo_Condition()
{
	Npc_PerceiveAll(self);
	if(!Wld_DetectNpc(self,Gobbo_Skeleton,ZS_MM_Attack,-1))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_Hallo_YouKnow()
{
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_weißtdu_14_00");	//Do you have the slightest idea what you have done?
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_weißtdu_14_01");	//You have confused the structure of magic so much that it could be heard back in Khorinis.
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_weißtdu_14_02");	//Count yourself lucky that the Barrier simply collapsed one day.
	AI_Output (other, self, "DIA_Addon_Saturas_Hallo_weißtdu_15_03");	//What are you complaining about? It all worked out all right.
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_weißtdu_14_04");	//(ranting) Mind your tongue!
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_weißtdu_14_05");	//(boiling) What the blazes do you want here anyway?
	Info_ClearChoices (DIA_Addon_Saturas_Hallo);
};

func void DIA_Addon_Saturas_Hallo_Info()
{
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_14_00");	//Are you mad? Get out of here.
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_14_01");	//It is too dangerous in these vaults for a would-be adventurer.
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_14_02");	//(annoyed) But say, don't I know you? Of course. You bastard...
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_14_03");	//(annoyed) Don't think that I have forgotten how you betrayed us in the New Camp.
	Info_ClearChoices (DIA_Addon_Saturas_Hallo);
	Info_AddChoice (DIA_Addon_Saturas_Hallo, "(embarrassed) I...", DIA_Addon_Saturas_Hallo_Video);
};

func void DIA_Addon_Saturas_Hallo_Video()
{
	PlayVideo ("oreheap.bik");
	AI_Output (self, other, "DIA_Addon_Saturas_Video_14_00");	//(annoyed) You drained our mound of ore of all magic power and then simply disappeared!
	AI_Output (self, other, "DIA_Addon_Saturas_Video_14_01");	//(annoyed) What exactly did you think you were doing?
	Info_ClearChoices (DIA_Addon_Saturas_Hallo);
	Info_AddChoice (DIA_Addon_Saturas_Hallo, "I'm sorry. I didn't know what I was doing.", DIA_Addon_Saturas_Hallo_sorry);
	Info_AddChoice (DIA_Addon_Saturas_Hallo, "Your plan wouldn't have worked anyway.", DIA_Addon_Saturas_Hallo_Spott);
	Info_AddChoice (DIA_Addon_Saturas_Hallo, "It was necessary.", DIA_Addon_Saturas_Hallo_notwendig);
};

func void DIA_Addon_Saturas_Hallo_notwendig()
{
	AI_Output (other, self, "DIA_Addon_Saturas_Hallo_notwendig_15_00");	//It was necessary. Without the power of the ore, I could never have defeated the Sleeper.
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_notwendig_14_01");	//(angry) What sort of drivel is that? Sleeper? Defeated?
	DIA_Addon_Saturas_Hallo_YouKnow();
};

func void DIA_Addon_Saturas_Hallo_Spott()
{
	AI_Output (other, self, "DIA_Addon_Saturas_Hallo_Spott_15_00");	//Your plan wouldn't have worked anyway. Blowing up the Barrier with the ore mound is the biggest nonsense I ever heard.
	AI_Output (other, self, "DIA_Addon_Saturas_Hallo_Spott_15_01");	//Ultimately, you would have blown yourselves sky high.
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_Spott_14_02");	//(angry) That is the limit! Who gave you the right to judge us and our intentions?
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_Spott_14_03");	//If I were not such a peaceful man, I would bring down the wrath of Adanos on you, my boy.
	DIA_Addon_Saturas_Hallo_YouKnow();
};

func void DIA_Addon_Saturas_Hallo_sorry()
{
	AI_Output (other, self, "DIA_Addon_Saturas_Hallo_sorry_15_00");	//I'm sorry. I didn't know what I was doing.
	AI_Output (self, other, "DIA_Addon_Saturas_Hallo_sorry_14_01");	//Oh? And you think that settles it?
	DIA_Addon_Saturas_Hallo_YouKnow();
};


instance DIA_Addon_Saturas_keineAhnung(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_keineAhnung_Condition;
	information = DIA_Addon_Saturas_keineAhnung_Info;
	description = "I haven't a clue.";
};


func int DIA_Addon_Saturas_keineAhnung_Condition()
{
	if(MIS_Addon_Lares_Ornament2Saturas == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_keineAhnung_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_keineAhnung_15_00");	//I have no idea. I thought I'd just drop in.
	AI_Output (self, other, "DIA_Addon_Saturas_keineAhnung_14_01");	//You are wasting my time. Begone from here.
	AI_Output (self, other, "DIA_Addon_Saturas_keineAhnung_14_02");	//(to himself) I shall deal with you later.
	Log_CreateTopic (TOPIC_Addon_KDW, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_KDW, LOG_Running);
	B_LogEntry (TOPIC_Addon_KDW, "I have found the Water Mages at their excavation site. First I have to find out what the boys are actually doing here. Saturas was not prepared to tell me. He is still really uptight about the old stories from the penal colony.");
	AI_StopProcessInfos (self);
};


instance DIA_Addon_Saturas_raus(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_raus_Condition;
	information = DIA_Addon_Saturas_raus_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Addon_Saturas_raus_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Saturas_keineAhnung) && (MIS_Addon_Lares_Ornament2Saturas == FALSE) && Npc_IsInState(self,ZS_Talk) && !Npc_HasItems(other,ItMi_Ornament_Addon_Vatras))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_raus_Info()
{
	AI_Output (self, other, "DIA_Addon_Saturas_raus_14_00");	//Begone from here before something happens to you.
	AI_StopProcessInfos (self);
};


instance DIA_Addon_Saturas_Lares(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_Lares_Condition;
	information = DIA_Addon_Saturas_Lares_Info;
	description = "I came here with Lares.";
};


func int DIA_Addon_Saturas_Lares_Condition()
{
	if(Lares_Angekommen == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_Lares_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_Lares_15_00");	//I came here with Lares.
	AI_Output (self, other, "DIA_Addon_Saturas_Lares_14_01");	//(concerned) Lares? Really? Where is he?
	AI_Output (other, self, "DIA_Addon_Saturas_Lares_15_02");	//I am alone. Lares went back to the city.
	AI_Output (self, other, "DIA_Addon_Saturas_Lares_14_03");	//What? And he sent you to us alone? What was he thinking?
};


instance DIA_Addon_Saturas_Ornament(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_Ornament_Condition;
	information = DIA_Addon_Saturas_Ornament_Info;
	description = "I brought your ornament.";
};


func int DIA_Addon_Saturas_Ornament_Condition()
{
	if(Npc_HasItems(other,ItMi_Ornament_Addon_Vatras))
	{
		if(Lares_Angekommen == FALSE)
		{
			return TRUE;
		}
		else if(Npc_KnowsInfo(other,DIA_Addon_Saturas_Lares))
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Saturas_Ornament_Info()
{
	AI_Output(other,self,"DIA_Addon_Saturas_Ornament_15_00");	//I brought your ornament.
	B_GiveInvItems(other,self,ItMi_Ornament_Addon_Vatras,1);
	Npc_RemoveInvItem(self,ItMi_Ornament_Addon_Vatras);
	AI_Output(self,other,"DIA_Addon_Saturas_Ornament_ADD_14_00");	//What in all the world is that supposed to mean?
	if(Lares_Angekommen == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_Saturas_Ornament_14_01");	//Who gave you that? Don't tell me that Lares simply handed it over to you.
	};
	AI_Output (other, self, "DIA_Addon_Saturas_Ornament_15_02");	//Come off it now. I brought it to you. You do want it, don't you?
	AI_Output (self, other, "DIA_Addon_Saturas_Ornament_14_03");	//Certainly. But it disturbs me that YOU have your hand in the game once again.
	AI_Output (other, self, "DIA_Addon_Saturas_Ornament_15_04");	//Why are you making such a big deal about that old business with the ore mound?
	AI_Output (other, self, "DIA_Addon_Saturas_Ornament_15_05");	//After all, I already worked for you back then. And you can't say that I was unreliable.
	AI_Output (self, other, "DIA_Addon_Saturas_Ornament_14_06");	//(sighs) And what did it ultimately get me? Mpfh, just don't think that I trust you...
	MIS_Addon_Lares_Ornament2Saturas = LOG_SUCCESS;
	Wld_InsertNpc(Bloodfly,"FP_ROAM_NW_TROLLAREA_RUINS_07");
	Wld_InsertNpc(Giant_Bug,"FP_ROAM_NW_TROLLAREA_RUINS_03");
	Wld_InsertNpc(Lurker,"NW_TROLLAREA_RIVERSIDE_01");
	Wld_InsertNpc(Scavenger,"NW_TAVERNE_TROLLAREA_MONSTER_01_01");
	Wld_InsertNpc(Scavenger,"NW_TAVERNE_TROLLAREA_MONSTER_01_01");
	Wld_InsertNpc(Scavenger,"NW_TAVERNE_TROLLAREA_MONSTER_01_01");
	Wld_InsertNpc(Scavenger,"NW_TAVERNE_TROLLAREA_MONSTER_01_01");
	Wld_InsertNpc(Scavenger,"NW_TAVERNE_TROLLAREA_MONSTER_01_01");
	Wld_InsertNpc(Scavenger,"NW_TAVERNE_BIGFARM_MONSTER_01");
	Wld_InsertNpc(Scavenger,"NW_TAVERNE_BIGFARM_MONSTER_01");
	Wld_InsertNpc(Scavenger,"NW_FOREST_CONNECT_MONSTER");
	Wld_InsertNpc(Scavenger,"NW_FOREST_CONNECT_MONSTER");
	Wld_InsertNpc(Gobbo_Green,"NW_TROLLAREA_PORTALTEMPEL_02");
	Wld_InsertNpc(Gobbo_Green,"NW_TROLLAREA_PORTALTEMPEL_02");
	Wld_InsertNpc(Gobbo_Green,"NW_CITY_TO_FARM2_02");
	Wld_InsertNpc(Giant_Rat,"NW_TROLLAREA_RATS_01");
	Wld_InsertNpc(Giant_Rat,"NW_TROLLAREA_RATS_01");
	Wld_InsertNpc(Giant_Rat,"NW_TROLLAREA_RATS_01");
};


instance DIA_Addon_Saturas_geheimbund(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_geheimbund_Condition;
	information = DIA_Addon_Saturas_geheimbund_Info;
	description = "I want to join the 'Ring of Water'.";
};


func int DIA_Addon_Saturas_geheimbund_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_SUCCESS) && (SC_KnowsRanger == TRUE) && (SC_IsRanger == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_geheimbund_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_geheimbund_15_00");	//I want to join the 'Ring of Water'.
	if (Lares_Angekommen == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Saturas_geheimbund_14_01");	//(furious) WHAT? How do you know about that? Who...? LARES... I will kill him!
		AI_Output (self, other, "DIA_Addon_Saturas_geheimbund_14_02");	//He has broken our first rule. Speak to no one about the 'Ring of Water'.
	};
	AI_Output(self,other,"DIA_Addon_Saturas_geheimbund_14_03");	//(completely done in) I don't know what I should say. I only trust you where I can keep an eye on you.
	if(Npc_KnowsInfo(other,DIA_Addon_Vatras_WannaBeRanger) || (Vatras_ToldAboutDuty == TRUE))
	{
	AI_Output (other, self, "DIA_Addon_Saturas_geheimbund_15_04");	//It was Vatras who told me about the Ring.
	AI_Output (self, other, "DIA_Addon_Saturas_geheimbund_14_05");	//(resigned) What? Vatras? (sarcastically) Wonderful! Of all the Water Mages on the island, you run into the who DOESN'T know you.
		if(Lares_Angekommen == FALSE)
		{
			AI_Output(self,other,"DIA_Addon_Saturas_geheimbund_14_02");	//He has broken our first rule. Speak to no one about the 'Ring of Water'.
		};
		AI_Output(self,other,"DIA_Addon_Saturas_geheimbund_14_06");	//I'm warning you, don't do anything stupid this time.
		AI_Output(other,self,"DIA_Addon_Saturas_geheimbund_15_07");	//(drily) I'll make an effort...
	};
	Log_CreateTopic(TOPIC_Addon_RingOfWater,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_RingOfWater,LOG_Running);
	B_LogEntry(TOPIC_Addon_RingOfWater,"Saturas is not prepared to let me into the 'Ring of Water'.");
};


instance DIA_Addon_Saturas_wasmachstdu(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_wasmachstdu_Condition;
	information = DIA_Addon_Saturas_wasmachstdu_Info;
	description = "What are you doing down here?";
};


func int DIA_Addon_Saturas_wasmachstdu_Condition()
{
	if(MIS_Addon_Lares_Ornament2Saturas == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_wasmachstdu_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_wasmachstdu_15_00");	//What are you doing down here?
	AI_Output (self, other, "DIA_Addon_Saturas_wasmachstdu_14_01");	//(reverently) These halls conceal ancient secrets. Mysterious secrets.
	AI_Output (self, other, "DIA_Addon_Saturas_wasmachstdu_14_02");	//The inscriptions and murals indicate a very ancient culture.
	AI_Output (self, other, "DIA_Addon_Saturas_wasmachstdu_14_03");	//Everything you can see here is written in a language completely unknown to us.
	AI_Output (self, other, "DIA_Addon_Saturas_wasmachstdu_14_04");	//We are only just beginning to learn it and grasp its meaning.
};


instance DIA_Addon_Saturas_Erdbeben(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 6;
	condition = DIA_Addon_Saturas_Erdbeben_Condition;
	information = DIA_Addon_Saturas_Erdbeben_Info;
	description = "What sort of strange earthquakes are those?";
};


func int DIA_Addon_Saturas_Erdbeben_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_Addon_Saturas_wasmachstdu) && Npc_KnowsInfo(other,DIA_Addon_Merdarion_Bedrohung))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_Erdbeben_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_Erdbeben_15_00");	//What sort of strange earthquakes are those?
	AI_Output (self, other, "DIA_Addon_Saturas_Erdbeben_14_01");	//That is one of the puzzles I am trying to solve.
	AI_Output (self, other, "DIA_Addon_Saturas_Erdbeben_14_02");	//The structure of magic is being disturbed somewhere behind these mountains.
	AI_Output (self, other, "DIA_Addon_Saturas_Erdbeben_14_03");	//Quite obviously, someone is trying with all his might to break a powerful magic.
	AI_Output (self, other, "DIA_Addon_Saturas_Erdbeben_14_04");	//I fear it will not be long before the entire island is plagued by these tremors.
};


instance DIA_Addon_Saturas_WhatsOrnament(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_WhatsOrnament_Condition;
	information = DIA_Addon_Saturas_WhatsOrnament_Info;
	description = "Why is this ornament so important to you?";
};


func int DIA_Addon_Saturas_WhatsOrnament_Condition()
{
//	if((MIS_Addon_Lares_Ornament2Saturas == LOG_SUCCESS) && (SC_KnowsOrnament == FALSE) && (RitualRingRuns == 0))
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_SUCCESS) && (RitualRingRuns == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_WhatsOrnament_Info()
{
	AI_Output(other,self,"DIA_Addon_Saturas_WhatsOrnament_15_00");	//Why is this ornament so important to you?
	AI_Output(self,other,"DIA_Addon_Saturas_WhatsOrnament_14_01");	//(annoyed) It is the key to a portal.
	if(SaturasKnows_SC_IsRanger == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_Saturas_OpenPortal_14_09");	//If Nefarius is right, the portal will open as soon as you insert the ring there.
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Saturas_WhatsOrnament_14_02");	//I shall not tell you more.
	};
	if(SC_KnowsPortal == FALSE)
	{
		if(Npc_KnowsInfo(other,DIA_Addon_Riordian_Atlantis))
		{
			Log_CreateTopic(TOPIC_Addon_KDW,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_KDW,LOG_Running);
			B_LogEntry(TOPIC_Addon_KDW,"Mages of Water think there's an ancient city behind the portal.");
			SC_KnowsPortal = TRUE;
		};
	};
};


instance DIA_Addon_Saturas_ScRanger(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_ScRanger_Condition;
	information = DIA_Addon_Saturas_ScRanger_Info;
	permanent = TRUE;
	description = "I belong to the 'Ring of Water' now.";
};


func int DIA_Addon_Saturas_ScRanger_Condition()
{
	if((SaturasKnows_SC_IsRanger == FALSE) && (SC_IsRanger == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_ScRanger_Info()
{
	AI_Output(other,self,"DIA_Addon_Saturas_ScRanger_15_00");	//I belong to the 'Ring of Water' now..
	if((RangerRingIsMyRing == TRUE) || ArmorEquipped(other,ITAR_RANGER_Addon))
	{
		if(ArmorEquipped(other,ITAR_RANGER_Addon))
		{
			AI_Output(self,other,"DIA_Addon_Saturas_ScRanger_14_01");	//As I see, you wear the armor of our children.
		};
		if(RangerRingIsMyRing == TRUE)
		{
			AI_Output (self, other, "DIA_Addon_Saturas_ScRanger_14_02");	//As I see, you bear our secret sign. The aquamarine ring.
		};
		AI_Output (self, other, "DIA_Addon_Saturas_ScRanger_14_03");	//And I see in your eyes that you speak the truth.
		AI_Output (self, other, "DIA_Addon_Saturas_ScRanger_14_04");	//(mumbling) Very well. I shall accept your entrance into our ranks.
		AI_Output (self, other, "DIA_Addon_Saturas_ScRanger_14_05");	//But bear in mind that this comes with a great responsibility.
		AI_Output (self, other, "DIA_Addon_Saturas_ScRanger_14_06");	//And I hope for your sake that you will do it justice.
		SaturasKnows_SC_IsRanger = TRUE;
		B_LogEntry (TOPIC_Addon_RingOfWater, "Saturas has accepted my joining the 'Ring of Water'.");
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Saturas_ScRanger_14_07");	//And how can I tell that you are one of us now?
		if (RangerRingIsLaresRing == TRUE)
		{
			AI_Output (self, other, "DIA_Addon_Saturas_ScRanger_14_08");	//The aquamarine ring that you carry belongs to Lares. I can see that.
		};
		AI_Output (self, other, "DIA_Addon_Saturas_ScRanger_14_09");	//You are trying to trick me, aren't you? I expected nothing else.
		AI_StopProcessInfos (self);
	};
};


func void B_GiveVatrasLetterToSaturas()
{
	if(VatrasLetterGivenToSaturas == FALSE)
	{
		AI_Output(other,self,"DIA_Addon_Saturas_OpenPortal_15_03");	//I HAVE a message from Vatras for you.
		AI_WaitTillEnd(self,other);
		if(Vatras2Saturas_FindRaven_Open == TRUE)
		{
			B_GiveInvItems(other,self,ItWr_Vatras2Saturas_FindRaven_opened,1);
			B_UseFakeScroll();
			AI_Output (self, other, "DIA_Addon_Saturas_OpenPortal_14_04");	//(annoyed) I see. And of course you couldn't restrain yourself and you absolutely had to open it, yes?
			AI_Output (other, self, "DIA_Addon_Saturas_OpenPortal_15_05");	//Well, uhh...
			AI_Output (self, other, "DIA_Addon_Saturas_OpenPortal_14_06");	//(threatening) I hope for your sake that my still very delicate trust in you will not be shaken.
		}
		else
		{
			B_GiveInvItems(other,self,ItWr_Vatras2Saturas_FindRaven,1);
			B_UseFakeScroll();
			AI_Output(self,other,"DIA_Addon_Saturas_OpenPortal_14_07");	//(amazed) Very interesting. All right.
			B_GivePlayerXP(XP_Ambient);
		};
		VatrasLetterGivenToSaturas = TRUE;
	};
};

func void B_GivePortalRingToSC()
{
	AI_Output(self,other,"DIA_Addon_Saturas_OpenPortal_14_08");	//Here, take the ring. We shall gather at the portal and wait for you.
	CreateInvItems(self,ItMi_PortalRing_Addon,1);
	B_GiveInvItems(self,other,ItMi_PortalRing_Addon,1);
	AI_Output(self,other,"DIA_Addon_Saturas_OpenPortal_14_09");	//If Nefarius is right, the portal will open as soon as you insert the ring there.
	DIA_Addon_Saturas_OpenPortal_NoPerm = TRUE;
	B_LogEntry(TOPIC_Addon_Ornament,"Saturas gave me the ornamental ring. I'm now supposed to insert it into the mechanism in the portal and go through the portal.");
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"OpenPortal");
	B_StartOtherRoutine(Cronos_NW,"OpenPortal");
	B_StartOtherRoutine(Nefarius_NW,"OpenPortal");
	B_StartOtherRoutine(Myxir_NW,"OpenPortal");
	B_StartOtherRoutine(Riordian_NW,"OpenPortal");
	B_StartOtherRoutine(Merdarion_NW,"OpenPortal");
};

instance DIA_Addon_Saturas_GiveVatrasLetter(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_GiveVatrasLetter_Condition;
	information = DIA_Addon_Saturas_GiveVatrasLetter_Info;
	description = "I HAVE a message from Vatras for you.";
};

func int DIA_Addon_Saturas_GiveVatrasLetter_Condition()
{
	if((VatrasLetterGivenToSaturas == FALSE) && (RangerMeetingRunning == LOG_SUCCESS) && (Npc_HasItems(other,ItWr_Vatras2Saturas_FindRaven) || Npc_HasItems(other,ItWr_Vatras2Saturas_FindRaven_opened)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_GiveVatrasLetter_Info()
{
	B_GiveVatrasLetterToSaturas();
};


instance DIA_Addon_Saturas_OpenPortal(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 5;
	condition = DIA_Addon_Saturas_OpenPortal_Condition;
	information = DIA_Addon_Saturas_OpenPortal_Info;
	permanent = TRUE;
	description = "Give me the ring. I shall open the portal.";
};


func int DIA_Addon_Saturas_OpenPortal_Condition()
{
	if((RitualRingRuns == LOG_SUCCESS) && (DIA_Addon_Saturas_OpenPortal_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_OpenPortal_Info()
{
	AI_Output(other,self,"DIA_Addon_Saturas_OpenPortal_15_00");	//Give me the ring. I shall open the portal.
	if(SaturasKnows_SC_IsRanger == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_Saturas_OpenPortal_14_01");	//(slyly) Good! As a new member of our children, you should be granted this honor.
		if(VatrasLetterGivenToSaturas == TRUE)
		{
			B_GivePortalRingToSC();
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Saturas_OpenPortal_14_02");	//However, I am still waiting for a message from Vatras. Until I receive it, we cannot go.
			if((RangerMeetingRunning == LOG_SUCCESS) && (Npc_HasItems(other,ItWr_Vatras2Saturas_FindRaven) || Npc_HasItems(other,ItWr_Vatras2Saturas_FindRaven_opened)))
			{
				B_GiveVatrasLetterToSaturas();
				B_GivePortalRingToSC();
			}
			else
			{
				AI_StopProcessInfos(self);
			};
		};
	}
	else
	{
		if(VatrasLetterGivenToSaturas == TRUE)
		{
			AI_Output(self,other,"DIA_Addon_Saturas_ScRanger_14_07");	//And how can I tell that you are one of us now?
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Saturas_OpenPortal_14_10");	//As long as Vatras has not given me a clear sign that you are to be trusted, I shall keep the ring myself.
			if((RangerMeetingRunning == LOG_SUCCESS) && (Npc_HasItems(other,ItWr_Vatras2Saturas_FindRaven) || Npc_HasItems(other,ItWr_Vatras2Saturas_FindRaven_opened)))
			{
				B_GiveVatrasLetterToSaturas();
			}
			else
			{
				if(Saturas_WillVertrauensBeweis == FALSE)
				{
					B_LogEntry(TOPIC_Addon_Ornament,"Saturas won't give me the ring as long as he hasn't had a sign from Vatras that I can be trusted.");
					Saturas_WillVertrauensBeweis = TRUE;
				};
				AI_StopProcessInfos(self);
			};
		};
	};
};


instance DIA_Addon_Saturas_PERM(C_Info)
{
	npc = KDW_1400_Addon_Saturas_NW;
	nr = 99;
	condition = DIA_Addon_Saturas_PERM_Condition;
	information = DIA_Addon_Saturas_PERM_Info;
	permanent = TRUE;
	description = "Can you teach me anything about magic?";
};


func int DIA_Addon_Saturas_PERM_Condition()
{
	if((MIS_Addon_Lares_Ornament2Saturas == LOG_SUCCESS) || (MIS_Addon_Nefarius_BringMissingOrnaments == LOG_SUCCESS) || Npc_KnowsInfo(other,DIA_Addon_Saturas_Nefarius) || (VatrasLetterGivenToSaturas == TRUE) || (RitualRingRuns == LOG_SUCCESS) || Npc_KnowsInfo(other,DIA_Addon_Saturas_geheimbund) || (SaturasKnows_SC_IsRanger == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_PERM_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_PERM_15_00");	//Can you teach me anything about magic?
	AI_Output (self, other, "DIA_Addon_Saturas_PERM_14_01");	//So that you can once again interfere with the magical structure?
	AI_Output (self, other, "DIA_Addon_Saturas_PERM_14_02");	//No. I have no time for such games.
};

