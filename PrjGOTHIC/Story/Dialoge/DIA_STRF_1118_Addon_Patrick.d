
instance DIA_Addon_Patrick_EXIT(C_Info)
{
	npc = STRF_1118_Addon_Patrick;
	nr = 999;
	condition = DIA_Addon_Patrick_EXIT_Condition;
	information = DIA_Addon_Patrick_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Patrick_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Patrick_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Patrick_Hi(C_Info)
{
	npc = STRF_1118_Addon_Patrick;
	nr = 2;
	condition = DIA_Addon_Patrick_Hi_Condition;
	information = DIA_Addon_Patrick_Hi_Info;
	permanent = FALSE;
	description = "I've been sent by the Water Mages. I've come to free you.";
};


func int DIA_Addon_Patrick_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Patrick_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_Patrick_Hi_15_00");	//I've been sent by the Water Mages. I've come to free you.
	AI_Output (self, other, "DIA_Addon_Patrick_Hi_07_01");	//(warily) Really? And why should I believe you?
	AI_Output (other, self, "DIA_Addon_Patrick_Hi_15_02");	//Do you want to get out of here, or not?
	AI_Output (self, other, "DIA_Addon_Patrick_Hi_07_03");	//Of course I want to get out - but ...
	AI_Output (other, self, "DIA_Addon_Patrick_Hi_15_04");	//Vatras sent me. If that's not enough for you, you can all rot in this hole for all I care.
	AI_Output (self, other, "DIA_Addon_Patrick_Hi_07_05");	//(hastily) All right, I believe you.
	AI_Output (other, self, "DIA_Addon_Patrick_Hi_15_06");	//(baffled) Really? Wow, that went faster than I thought. Okay, now all we need is a plan.
	AI_Output (self, other, "DIA_Addon_Patrick_Hi_07_07");	//Trying to flee poses a great risk. William tried, and he bought it.
	AI_Output (self, other, "DIA_Addon_Patrick_Hi_07_08");	//The prisoners are peasants and workers - they trust me, but they won't dare to mount an escape.
	if(FoundDeadWilliam == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
		B_LogEntry(TOPIC_Addon_MissingPeople,"Patrick tole me that one of the slaves called William died while attempting to escape.");
	};
	FoundDeadWilliam = TRUE;
	Info_ClearChoices(DIA_Addon_Patrick_Hi);
	Info_AddChoice(DIA_Addon_Patrick_Hi,"What do you want me to do - get you a pardon from Raven?",DIA_Addon_Patrick_Hi_Raven);
	Info_AddChoice(DIA_Addon_Patrick_Hi,"Will I have to kill all the bandits before you'll budge at all?",DIA_Addon_Patrick_Hi_Kill);
};

func void B_Say_Patrick_Plan()
{
	AI_Output (self, other, "DIA_Addon_Patrick_Plan_07_00");	//But that can't be the plan.
	AI_Output (self, other, "DIA_Addon_Patrick_Plan_07_01");	//Just see to it that the guards don't attack us, and then we'll get out of here.
	AI_Output (other, self, "DIA_Addon_Patrick_Plan_15_02");	//Okay, I'll handle that. Tell the others to get ready.
	B_LogEntry (TOPIC_Addon_Sklaven, "The slaves will not dare attempt to escape. I have to find a way to let them leave the camp unmolested.");
};

func void DIA_Addon_Patrick_Hi_Raven()
{
	AI_Output (other, self, "DIA_Addon_Patrick_Hi_Raven_15_00");	//What do you want me to do - get you a pardon from Raven?
	AI_Output (self, other, "DIA_Addon_Patrick_Hi_Raven_07_01");	//(grinning) Not a bad idea.
	B_Say_Patrick_Plan ();
	Info_ClearChoices (DIA_Addon_Patrick_Hi);
};

func void DIA_Addon_Patrick_Hi_Kill()
{
	AI_Output (other, self, "DIA_Addon_Patrick_Hi_Kill_15_00");	//Will I have to kill all the bandits before you'll budge at all?
	AI_Output (self, other, "DIA_Addon_Patrick_Hi_Kill_07_01");	//(scared) But that would be insane!
	B_Say_Patrick_Plan ();
	Info_ClearChoices (DIA_Addon_Patrick_Hi);
};


instance DIA_Addon_Patrick_ready(C_Info)
{
	npc = STRF_1118_Addon_Patrick;
	nr = 2;
	condition = DIA_Addon_Patrick_ready_Condition;
	information = DIA_Addon_Patrick_ready_Info;
	permanent = FALSE;
	description = "All's well, you can make yourselves scarce.";
};


func int DIA_Addon_Patrick_ready_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Patrick_Hi))
	{
		if(Ready_Togo == TRUE)
		{
			return TRUE;
		}
		else if(Npc_IsDead(PrisonGuard) && Npc_IsDead(Bloodwyn))
		{
			if(Npc_KnowsInfo(other,DIA_Addon_Thorus_Answer))
			{
				return TRUE;
			}
			else if(Npc_IsDead(Thorus))
			{
				return TRUE;
			};
		};
	};
};

func void DIA_Addon_Patrick_ready_Info()
{
	AI_Output (other, self, "DIA_Addon_Patrick_ready_15_00");	//All's well, you can make yourselves scarce.
	AI_Output (self, other, "DIA_Addon_Patrick_ready_07_01");	//Great. I know a cave in the swamp where we can gather for now. But then what?
	AI_Output (other, self, "DIA_Addon_Patrick_ready_15_02");	//Leave the swamp towards the south-west. The Water Mages have set up their camp near the ruins of the old temple.
	AI_Output (other, self, "DIA_Addon_Patrick_ready_15_03");	//They're going to show you the way out of this valley.
	AI_Output (self, other, "DIA_Addon_Patrick_ready_07_04");	//Thanks, thank you so much. (commencing) We are all very deeply ...
	AI_Output (other, self, "DIA_Addon_Patrick_ready_15_05");	//Never mind.
	Sklaven_Flucht = TRUE;
	B_GivePlayerXP(XP_Addon_Flucht);
	Info_ClearChoices(DIA_Addon_Patrick_ready);
	Info_AddChoice(DIA_Addon_Patrick_ready,Dialog_Ende,DIA_Addon_Patrick_ready_END);
};

func void DIA_Addon_Patrick_ready_END()
{
	var C_NPC Slave_1;
	var C_NPC Slave_2;
	var C_NPC Slave_3;
	var C_NPC Slave_4;
	var C_NPC Slave_5;
	var C_NPC Slave_6;
	var C_NPC Slave_7;
	var C_Npc Buddler_1;
	var C_Npc Buddler_2;
	var C_Npc Buddler_3;
	var C_Npc Buddler_4;
	Slave_1 = Hlp_GetNpc(STRF_1128_Addon_Sklave);
	Slave_2 = Hlp_GetNpc(STRF_1129_Addon_Sklave);
	Slave_3 = Hlp_GetNpc(STRF_1130_Addon_Sklave);
	Slave_4 = Hlp_GetNpc(STRF_1137_Addon_Sklave);
	Slave_5 = Hlp_GetNpc(STRF_1138_Addon_Sklave);
	Slave_6 = Hlp_GetNpc(STRF_1139_Addon_Sklave);
	Slave_7 = Hlp_GetNpc(STRF_1140_Addon_Sklave);
	Buddler_1 = Hlp_GetNpc(BDT_10027_Addon_Buddler);
	Buddler_2 = Hlp_GetNpc(BDT_10028_Addon_Buddler);
	Buddler_3 = Hlp_GetNpc(BDT_10029_Addon_Buddler);
	Buddler_4 = Hlp_GetNpc(BDT_10030_Addon_Buddler);
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"FLUCHT");
	B_StartOtherRoutine(Telbor,"FLUCHT");
	B_StartOtherRoutine(Tonak,"FLUCHT");
	B_StartOtherRoutine(Pardos,"FLUCHT");
	B_StartOtherRoutine(Monty,"FLUCHT");
	B_StartOtherRoutine(Slave_1,"FLUCHT");
	B_StartOtherRoutine(Slave_2,"FLUCHT");
	B_StartOtherRoutine(Slave_3,"FLUCHT");
	B_StartOtherRoutine(Slave_4,"FLUCHT");
	B_StartOtherRoutine(Slave_5,"FLUCHT");
	B_StartOtherRoutine(Slave_6,"FLUCHT");
	B_StartOtherRoutine(Slave_7,"FLUCHT");
	B_StartOtherRoutine(Buddler_1,"WORK");
	B_StartOtherRoutine(Buddler_2,"WORK");
	B_StartOtherRoutine(Buddler_3,"WORK");
	B_StartOtherRoutine(Buddler_4,"WORK");
};


instance DIA_Addon_Patrick_Killer(C_Info)
{
	npc = STRF_1118_Addon_Patrick;
	nr = 2;
	condition = DIA_Addon_Patrick_Killer_Condition;
	information = DIA_Addon_Patrick_Killer_Info;
	permanent = FALSE;
	description = "The guard is done for, you can go now.";
};


func int DIA_Addon_Patrick_Killer_Condition()
{
	if(Npc_IsDead(PrisonGuard) && (Ready_Togo == FALSE) && Npc_KnowsInfo(other,DIA_Addon_Patrick_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Patrick_Killer_Info()
{
	AI_Output (other, self, "DIA_Addon_Patrick_Killer_15_00");	//The guard is done for, you can go now.
	AI_Output (self, other, "DIA_Addon_Patrick_Killer_07_01");	//And what happens once we leave the mine? The other guards will slaughter us then. No, that's too risky.
};


instance DIA_Addon_Patrick_Hoehle(C_Info)
{
	npc = STRF_1118_Addon_Patrick;
	nr = 2;
	condition = DIA_Addon_Patrick_Hoehle_Condition;
	information = DIA_Addon_Patrick_Hoehle_Info;
	permanent = TRUE;
	description = "Don't you want to leave?";
};


func int DIA_Addon_Patrick_Hoehle_Condition()
{
	if(Npc_GetDistToWP(self,"ADW_BL_HOEHLE_05") <= 1000)
	{
		return TRUE;
	};
};

func void DIA_Addon_Patrick_Hoehle_Info()
{
	AI_Output (other, self, "DIA_Addon_Patrick_Hoehle_15_00");	//Don't you want to leave?
	AI_Output (self, other, "DIA_Addon_Patrick_Hoehle_07_01");	//Of course we do. We're only waiting for the right moment.
};

