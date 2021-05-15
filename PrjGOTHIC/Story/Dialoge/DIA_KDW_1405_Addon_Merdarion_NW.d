
instance DIA_Addon_Merdarion_EXIT(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 999;
	condition = DIA_Addon_Merdarion_EXIT_Condition;
	information = DIA_Addon_Merdarion_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Merdarion_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Merdarion_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Merdarion_Hallo(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 5;
	condition = DIA_Addon_Merdarion_Hallo_Condition;
	information = DIA_Addon_Merdarion_Hallo_Info;
	description = "Busy?";
};


func int DIA_Addon_Merdarion_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Addon_Merdarion_Hallo_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_Hallo_15_00");	//Busy?
	AI_Output (self, other, "DIA_Addon_Merdarion_Hallo_06_01");	//These vaults are one big mystery for me. It's hard to imagine that no one else should have found them before now.
	AI_Output (self, other, "DIA_Addon_Merdarion_Hallo_06_02");	//We were able to uncover the entrance without difficulty.
	AI_Output (self, other, "DIA_Addon_Merdarion_Hallo_06_03");	//People are so occupied with their daily routine that no one looked more closely at this structure.
	AI_Output (self, other, "DIA_Addon_Merdarion_Hallo_06_04");	//I have no other explanation for it.
};


instance DIA_Addon_Merdarion_Aufgabe(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 5;
	condition = DIA_Addon_Merdarion_Aufgabe_Condition;
	information = DIA_Addon_Merdarion_Aufgabe_Info;
	description = "What is your task here?";
};


func int DIA_Addon_Merdarion_Aufgabe_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_Aufgabe_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_Aufgabe_15_00");	//What is your task here?
	AI_Output (self, other, "DIA_Addon_Merdarion_Aufgabe_06_01");	//I am trying to find out where this round portal leads.
	if(MIS_Addon_Nefarius_BringMissingOrnaments != LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Addon_Merdarion_Aufgabe_06_02");	//Besides that, I help Nefarius look for the missing ornament.
		if(!Npc_KnowsInfo(other,DIA_Addon_Nefarius_SCbringOrnaments))
		{
			B_LogEntry(TOPIC_Addon_KDW,"Nefarius is looking for a missing ornament.");
		};
	};
	AI_Output(self,other,"DIA_Addon_Merdarion_Aufgabe_06_03");	//It is certain that this portal leads to another part of the island that we do not yet know.
	AI_Output(self,other,"DIA_Addon_Merdarion_Aufgabe_06_04");	//(considering) I can't remember ever having heard or read about that...
	Npc_ExchangeRoutine(self,"START");
	B_StartOtherRoutine(Cronos_NW,"START");
	if(SC_KnowsPortal == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_KDW,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_KDW,LOG_Running);
		if(Npc_KnowsInfo(other,DIA_Addon_Riordian_Atlantis))
		{
			B_LogEntry(TOPIC_Addon_KDW,"The Water Mages suspect that an ancient lost city lies behind the portal.");
		}
		else
		{
			B_LogEntry(TOPIC_Addon_KDW,"The Water Mages have found a portal that is supposed to lead to an unexplored part of Khorinis.");
		};
		SC_KnowsPortal = TRUE;
	};
};


instance DIA_Addon_Merdarion_DaDurch(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 5;
	condition = DIA_Addon_Merdarion_DaDurch_Condition;
	information = DIA_Addon_Merdarion_DaDurch_Info;
	description = "You really want to go through the portal?";
};


func int DIA_Addon_Merdarion_DaDurch_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_Aufgabe))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_DaDurch_Info()
{
	AI_Output(other,self,"DIA_Addon_Merdarion_DaDurch_15_00");	//You really want to go through the portal?
	if(MIS_Addon_Nefarius_BringMissingOrnaments != LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Addon_Merdarion_DaDurch_06_01");	//Of course. Assuming we find the missing ornament, that is.
	};
	AI_Output(self,other,"DIA_Addon_Merdarion_DaDurch_06_02");	//I admit, it is a somewhat risky business.
	AI_Output(self,other,"DIA_Addon_Merdarion_DaDurch_06_03");	//But we absolutely must find out what it has to do with these constant earthquakes.
};


instance DIA_Addon_Merdarion_Bedrohung(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 5;
	condition = DIA_Addon_Merdarion_Bedrohung_Condition;
	information = DIA_Addon_Merdarion_Bedrohung_Info;
	description = "What do you know about the earthquakes?";
};


func int DIA_Addon_Merdarion_Bedrohung_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_DaDurch))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_Bedrohung_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_Bedrohung_15_00");	//What do you know about the earthquakes?
	AI_Output (self, other, "DIA_Addon_Merdarion_Bedrohung_06_01");	//Something on the other side is causing them.
	AI_Output (self, other, "DIA_Addon_Merdarion_Bedrohung_06_02");	//This source is probably also causing the stone sentinels to awaken.
	AI_Output (self, other, "DIA_Addon_Merdarion_Bedrohung_06_03");	//But that isn't my job. Saturas and Cronos can tell you more about that.
};


instance DIA_Addon_Merdarion_Wasdahinter2(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 5;
	condition = DIA_Addon_Merdarion_Wasdahinter2_Condition;
	information = DIA_Addon_Merdarion_Wasdahinter2_Info;
	description = "What do you think you will find over there?";
};


func int DIA_Addon_Merdarion_Wasdahinter2_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_Aufgabe))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_Wasdahinter2_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_Wasdahinter2_15_00");	//What do you think you will find over there?
	AI_Output (self, other, "DIA_Addon_Merdarion_Wasdahinter2_06_01");	//I'm really not sure.
	AI_Output (self, other, "DIA_Addon_Merdarion_Wasdahinter2_06_02");	//I suspect that, on the other side, there will be a structure similar to this one. And a counterpart to this portal.
	AI_Output (self, other, "DIA_Addon_Merdarion_Wasdahinter2_06_03");	//Everything else we shall see when we get there.
};


instance DIA_Addon_Merdarion_PERM(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 99;
	condition = DIA_Addon_Merdarion_PERM_Condition;
	information = DIA_Addon_Merdarion_PERM_Info;
	permanent = TRUE;
	description = "Can you teach me anything about magic?";
};


func int DIA_Addon_Merdarion_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_Aufgabe))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_PERM_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_PERM_15_00");	//Can you teach me anything about magic?
	AI_Output (self, other, "DIA_Addon_Merdarion_PERM_06_01");	//Once we're over there, I'll be at your disposal.
};


instance DIA_Addon_Merdarion_Teleportstein(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 5;
	condition = DIA_Addon_Merdarion_Teleportstein_Condition;
	information = DIA_Addon_Merdarion_Teleportstein_Info;
	description = "What is the fastest way back to the city?";
};


func int DIA_Addon_Merdarion_Teleportstein_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_Aufgabe) && (MIS_Addon_Lares_Ornament2Saturas == LOG_SUCCESS))
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_Aufgabe))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_Teleportstein_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_Teleportstein_15_00");	//What is the fastest way back to the city?
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_06_01");	//I recommend you go back the same way you came.
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_06_02");	//(considering) But you could also... No. That would be too dangerous.
	AI_Output (other, self, "DIA_Addon_Merdarion_Teleportstein_15_03");	//Out with it.
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_06_04");	//Well. The builders of these halls had their own method of travelling.
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_06_05");	//As far as we can tell, they could teleport.
	AI_Output (other, self, "DIA_Addon_Merdarion_Teleportstein_15_06");	//That's nothing special.
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_06_07");	//The teleporter stones that we have found here in Khorinis are special indeed.
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_06_08");	//It seems as though the teleporter stone here in these halls might lead to the harbor city.
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_06_09");	//However, none of us has had the courage to try it.
	Info_ClearChoices (DIA_Addon_Merdarion_Teleportstein);
	Info_AddChoice (DIA_Addon_Merdarion_Teleportstein, "What if I were to try to use it?", DIA_Addon_Merdarion_Teleportstein_ich);
	Info_AddChoice (DIA_Addon_Merdarion_Teleportstein, "Where is this teleporter stone?", DIA_Addon_Merdarion_Teleportstein_wo);
};

func void DIA_Addon_Merdarion_Teleportstein_wo()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_Teleportstein_wo_15_00");	//Where is this teleporter stone?
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_wo_06_01");	//There is a door in the basin room. I have locked it up behind there.
	Info_AddChoice (DIA_Addon_Merdarion_Teleportstein, "Give me the key. I want to take a look at this thing.", DIA_Addon_Merdarion_Teleportstein_key);
};

func void DIA_Addon_Merdarion_Teleportstein_ich()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_Teleportstein_ich_15_00");	//What if I were to try to use it?
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_ich_06_01");	//No idea. We know too little about it. It is possible that you wouldn't survive.
};

func void DIA_Addon_Merdarion_Teleportstein_key()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_Teleportstein_key_15_00");	//Give me the key. I want to take a look at this thing.
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_key_06_01");	//(unsure) Really? But I take no responsibility for it.
	AI_Output (other, self, "DIA_Addon_Merdarion_Teleportstein_key_15_02");	//Give it here.
	AI_Output (self, other, "DIA_Addon_Merdarion_Teleportstein_key_06_03");	//If you say so. Here it is.
	CreateInvItems(self,ItKe_PortalTempelWalkthrough_Addon,1);
	B_GiveInvItems(self,other,ItKe_PortalTempelWalkthrough_Addon,1);
	SC_GotPortalTempelWalkthroughKey = TRUE;
	Log_CreateTopic (TOPIC_Addon_TeleportsNW, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_TeleportsNW, LOG_Running);
	B_LogEntry (TOPIC_Addon_TeleportsNW, "Merdarion gave me the key to a locked door in the vaults of the portal. Behind it is a teleporter stone that should take me back to the seaport.");
	Info_ClearChoices (DIA_Addon_Merdarion_Teleportstein);
};


instance DIA_Addon_Merdarion_WHereOtherTeleports(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 5;
	condition = DIA_Addon_Merdarion_WHereOtherTeleports_Condition;
	information = DIA_Addon_Merdarion_WHereOtherTeleports_Info;
	description = "Where are the other teleporter stones?";
};


func int DIA_Addon_Merdarion_WHereOtherTeleports_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_Teleportstein) && (SCUsed_NW_TELEPORTSTATION_MAYA == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_WHereOtherTeleports_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_WHereOtherTeleports_15_00");	//Where are the other teleporter stones?
	AI_Output (self, other, "DIA_Addon_Merdarion_WHereOtherTeleports_06_01");	//So far, we have only found one other somewhere in the middle of Khorinis.
	AI_Output (self, other, "DIA_Addon_Merdarion_WHereOtherTeleports_06_02");	//Near the Dead Harpy tavern.
	if(!Npc_KnowsInfo(other,DIA_Addon_Orlan_Teleportstein))
	{
		B_LogEntry(TOPIC_Addon_TeleportsNW,"There should be another teleporter stone near the Dead Harpy tavern.");
	};
};


instance DIA_Addon_Merdarion_TeleportsteinSuccess(C_Info)
{
	npc = KDW_1405_Addon_Merdarion_NW;
	nr = 5;
	condition = DIA_Addon_Merdarion_TeleportsteinSuccess_Condition;
	information = DIA_Addon_Merdarion_TeleportsteinSuccess_Info;
	description = "The teleporter stones seem to work nicely.";
};


func int DIA_Addon_Merdarion_TeleportsteinSuccess_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_Teleportstein) && (SCUsed_AllNWTeleporststones == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_TeleportsteinSuccess_Info()
{
	B_GivePlayerXP (XP_Ambient);
	AI_Output (other, self, "DIA_Addon_Merdarion_TeleportsteinSuccess_15_00");	//The teleporter stones seem to work nicely.
	AI_Output (self, other, "DIA_Addon_Merdarion_TeleportsteinSuccess_06_01");	//You actually did it? You really went in?
	AI_Output (other, self, "DIA_Addon_Merdarion_TeleportsteinSuccess_15_02");	//Yes. They obviously still work.
	AI_Output (self, other, "DIA_Addon_Merdarion_TeleportsteinSuccess_06_03");	//(fascinated) Unbelievable. I'll have to look at this more closely later.
};

