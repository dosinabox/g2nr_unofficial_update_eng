
instance DIA_None_101_Mario_EXIT(C_Info)
{
	npc = NONE_101_Mario;
	nr = 999;
	condition = DIA_None_101_Mario_EXIT_Condition;
	information = DIA_None_101_Mario_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_None_101_Mario_EXIT_Condition()
{
	return TRUE;
};

func void DIA_None_101_Mario_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_None_101_Mario_Job(C_Info)
{
	npc = NONE_101_Mario;
	nr = 4;
	condition = DIA_None_101_Mario_Job_Condition;
	information = DIA_None_101_Mario_Job_Info;
	permanent = TRUE;
	description = "What are you doing here?";
};


func int DIA_None_101_Mario_Job_Condition()
{
	if((Kapitel == 5) && (MIS_SCKnowsWayToIrdorath == FALSE) && !Npc_KnowsInfo(other,DIA_None_101_Mario_YouNeedMe))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_Job_Info()
{
	AI_Output (other, self, "DIA_None_101_Mario_Job_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_None_101_Mario_Job_07_01");	//I hope it won't be too long before a ship comes in where I can hire on.
	AI_Output (self, other, "DIA_None_101_Mario_Job_07_02");	//This hanging around is really getting on my nerves.
};


instance DIA_None_101_Mario_YouNeedMe(C_Info)
{
	npc = NONE_101_Mario;
	nr = 4;
	condition = DIA_None_101_Mario_YouNeedMe_Condition;
	information = DIA_None_101_Mario_YouNeedMe_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_None_101_Mario_YouNeedMe_Condition()
{
	if((Kapitel == 5) && (MIS_SCKnowsWayToIrdorath == TRUE))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_YouNeedMe_Info()
{
	AI_Output (self, other, "DIA_None_101_Mario_YouNeedMe_07_00");	//I've heard that you're looking for people for your ship?
	AI_Output (other, self, "DIA_None_101_Mario_YouNeedMe_15_01");	//And?
	AI_Output (self, other, "DIA_None_101_Mario_YouNeedMe_07_02");	//I'm in!
	B_LogEntry(Topic_Crew,"Mario, a former marine, spoke to me in the harbor pub. He wants to come on the ship.");
};


instance DIA_None_101_Mario_WhyNeedYou(C_Info)
{
	npc = NONE_101_Mario;
	nr = 5;
	condition = DIA_None_101_Mario_WhyNeedYou_Condition;
	information = DIA_None_101_Mario_WhyNeedYou_Info;
	permanent = FALSE;
	description = "Why would I take you along?";
};


func int DIA_None_101_Mario_WhyNeedYou_Condition()
{
	if(Npc_KnowsInfo(other,DIA_None_101_Mario_YouNeedMe) && (Mario_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_WhyNeedYou_Info()
{
	AI_Output (other, self, "DIA_None_101_Mario_WhyNeedYou_15_00");	//Why would I take you along?
	AI_Output (self, other, "DIA_None_101_Mario_WhyNeedYou_07_01");	//Quite simply, because you need me.
	AI_Output (self, other, "DIA_None_101_Mario_WhyNeedYou_07_02");	//I'm ... I was a lieutenant with the royal navy.
	AI_Output (self, other, "DIA_None_101_Mario_WhyNeedYou_07_03");	//I've served as a marine on the King Rhobar and the Pride of Myrtana.
	AI_Output (self, other, "DIA_None_101_Mario_WhyNeedYou_07_04");	//In the Battle of the Eastern Archipelago, I single-handedly sent two dozen orcs back to Beliar's realm.
	AI_Output (self, other, "DIA_None_101_Mario_WhyNeedYou_07_05");	//Unfortunately, there were too few of us after our flagship sank, and we were forced to retreat.
	B_LogEntry(Topic_Crew,"Mario claims he's a former sailor from the royal navy.");
};


instance DIA_None_101_Mario_WhyHere(C_Info)
{
	npc = NONE_101_Mario;
	nr = 7;
	condition = DIA_None_101_Mario_WhyHere_Condition;
	information = DIA_None_101_Mario_WhyHere_Info;
	permanent = FALSE;
	description = "Why are you here, then?";
};


func int DIA_None_101_Mario_WhyHere_Condition()
{
	if(Npc_KnowsInfo(other,DIA_None_101_Mario_WhyNeedYou) && (Mario_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_WhyHere_Info()
{
	AI_Output (other, self, "DIA_None_101_Mario_WhyHere_15_00");	//Why are you here, then?
	AI_Output (self, other, "DIA_None_101_Mario_WhyHere_07_01");	//The fleet is routed, and the payroll coffers are empty.
	AI_Output (self, other, "DIA_None_101_Mario_WhyHere_07_02");	//After my discharge I wound up stranded in this dump, and I'm looking for a new berth.
};


instance DIA_None_101_Mario_Abilities(C_Info)
{
	npc = NONE_101_Mario;
	nr = 8;
	condition = DIA_None_101_Mario_Abilities_Condition;
	information = DIA_None_101_Mario_Abilities_Info;
	permanent = FALSE;
	description = "What can you do?";
};


func int DIA_None_101_Mario_Abilities_Condition()
{
	if(Npc_KnowsInfo(other,DIA_None_101_Mario_WhyNeedYou) && (Mario_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_Abilities_Info()
{
	AI_Output (other, self, "DIA_None_101_Mario_Abilities_15_00");	//What can you do?
	AI_Output (self, other, "DIA_None_101_Mario_Abilities_07_01");	//I'm trained for boarding and close combat, plus I'm a passable shot with the ship's cannon.
	AI_Output (self, other, "DIA_None_101_Mario_Abilities_07_02");	//I bet there's a thing or two that I can teach you on the trip.
	B_LogEntry (Topic_Crew, "Mario seems to be a dab hand at naval warfare. He may be able to teach me a thing or two.");
};


instance DIA_None_101_Mario_YourPrice(C_Info)
{
	npc = NONE_101_Mario;
	nr = 9;
	condition = DIA_None_101_Mario_YourPrice_Condition;
	information = DIA_None_101_Mario_YourPrice_Info;
	permanent = FALSE;
	description = "What are you asking?";
};


func int DIA_None_101_Mario_YourPrice_Condition()
{
	if(Npc_KnowsInfo(other,DIA_None_101_Mario_YouNeedMe) && (Mario_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_YourPrice_Info()
{
	AI_Output (other, self, "DIA_None_101_Mario_YourPrice_15_00");	//What are you asking?
	AI_Output (self, other, "DIA_None_101_Mario_YourPrice_07_01");	//What can I ask? I'd be glad to get away from here.
	AI_Output (self, other, "DIA_None_101_Mario_YourPrice_07_02");	//A hand for a bunk. I help you and you take me along.
};


instance DIA_None_101_Mario_CouldBeDangerous(C_Info)
{
	npc = NONE_101_Mario;
	nr = 10;
	condition = DIA_None_101_Mario_CouldBeDangerous_Condition;
	information = DIA_None_101_Mario_CouldBeDangerous_Info;
	permanent = FALSE;
	description = "The journey may be perilous.";
};


func int DIA_None_101_Mario_CouldBeDangerous_Condition()
{
	if(Npc_KnowsInfo(other,DIA_None_101_Mario_YourPrice) && (Mario_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_CouldBeDangerous_Info()
{
	AI_Output (other, self, "DIA_None_101_Mario_CouldBeDangerous_15_00");	//The journey may be perilous.
	AI_Output (self, other, "DIA_None_101_Mario_CouldBeDangerous_07_01");	//I'm used to danger. When you're out there, every day is dangerous.
	AI_Output (self, other, "DIA_None_101_Mario_CouldBeDangerous_07_02");	//The next storm could be your death, and the monsters of the deep could swallow your ship whole.
	AI_Output (self, other, "DIA_None_101_Mario_CouldBeDangerous_07_03");	//And I don't need to mention the orcish galleys, do I? Believe me, there's nothing I'm afraid of. A sailor who's afraid is already dead.
};


instance DIA_None_101_Mario_DontNeedYou(C_Info)
{
	npc = NONE_101_Mario;
	nr = 13;
	condition = DIA_None_101_Mario_DontNeedYou_Condition;
	information = DIA_None_101_Mario_DontNeedYou_Info;
	permanent = FALSE;
	description = "I have no use for you.";
};


func int DIA_None_101_Mario_DontNeedYou_Condition()
{
	if(Npc_KnowsInfo(other,DIA_None_101_Mario_YouNeedMe) && (Mario_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_DontNeedYou_Info()
{
	AI_Output (other, self, "DIA_None_101_Mario_DontNeedYou_15_00");	//I have no use for you.
	AI_Output (self, other, "DIA_None_101_Mario_DontNeedYou_07_01");	//I'm the best sailor you'll find here.
	AI_Output (self, other, "DIA_None_101_Mario_DontNeedYou_07_02");	//From the look of you, you don't know the first thing about navigation.
	AI_Output (self, other, "DIA_None_101_Mario_DontNeedYou_07_03");	//So think twice before you trust anyone.
};


instance DIA_None_101_Mario_NeedGoodMen(C_Info)
{
	npc = NONE_101_Mario;
	nr = 2;
	condition = DIA_None_101_Mario_NeedGoodMen_Condition;
	information = DIA_None_101_Mario_NeedGoodMen_Info;
	permanent = FALSE;
	description = "I can always use good people.";
};


func int DIA_None_101_Mario_NeedGoodMen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_None_101_Mario_YouNeedMe) && (Mario_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_None_101_Mario_NeedGoodMen_Info()
{
	AI_Output (other, self, "DIA_None_101_Mario_NeedGoodMen_15_00");	//I can always use good people.
	AI_Output (self, other, "DIA_None_101_Mario_NeedGoodMen_07_01");	//Sure thing, I'll see you on the ship.
	B_JoinShip(self);
};


instance DIA_Mario_LeaveMyShip(C_Info)
{
	npc = NONE_101_Mario;
	nr = 11;
	condition = DIA_Mario_LeaveMyShip_Condition;
	information = DIA_Mario_LeaveMyShip_Info;
	permanent = TRUE;
	description = "I can't use you after all!";
};


func int DIA_Mario_LeaveMyShip_Condition()
{
	if((Mario_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Mario_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_Mario_LeaveMyShip_15_00");	//I can't use you after all!
	AI_Output (self, other, "DIA_Mario_LeaveMyShip_07_01");	//As you like. You know where to find me!
	Mario_IsOnBoard = LOG_OBSOLETE;
	CrewmemberFree_Count -= 1;
	AI_StopProcessInfos(self);
	Mario_Nerver += 1;
	Npc_ExchangeRoutine(self,"ShipOff");
};


instance DIA_Mario_StillNeedYou(C_Info)
{
	npc = NONE_101_Mario;
	nr = 11;
	condition = DIA_Mario_StillNeedYou_Condition;
	information = DIA_Mario_StillNeedYou_Info;
	permanent = TRUE;
	description = "I can use you after all!";
};


func int DIA_Mario_StillNeedYou_Condition()
{
	if((Mario_IsOnBoard == LOG_OBSOLETE) || (Mario_IsOnBoard == LOG_FAILED))
	{
		return TRUE;
	};
};

func void DIA_Mario_StillNeedYou_Info()
{
	AI_Output(other,self,"DIA_Mario_StillNeedYou_15_00");	//I can use you after all!
	if((Mario_IsOnBoard == LOG_OBSOLETE) && (Mario_Nerver <= 2))
	{
		AI_Output(self,other,"DIA_Mario_StillNeedYou_07_01");	//I knew it! I'll see you on the ship!
		B_JoinShip(self);
	}
	else
	{
		AI_Output(self,other,"DIA_Mario_StillNeedYou_07_02");	//You can't treat me like that. I'll gut you!
		AI_StopProcessInfos(self);
		Mario_IsOnBoard = LOG_FAILED;
		self.flags = 0;
		B_Attack(self,other,AR_NONE,1);
	};
	B_CheckLog();
};


instance DIA_MARIO_PICKPOCKET(C_Info)
{
	npc = NONE_101_Mario;
	nr = 900;
	condition = DIA_MARIO_PICKPOCKET_Condition;
	information = DIA_MARIO_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_MARIO_PICKPOCKET_Condition()
{
	return C_Beklauen(71,220);
};

func void DIA_MARIO_PICKPOCKET_Info()
{
	Info_ClearChoices(dia_mario_pickpocket);
	Info_AddChoice(dia_mario_pickpocket,Dialog_Back,dia_mario_pickpocket_back);
	Info_AddChoice(dia_mario_pickpocket,DIALOG_PICKPOCKET,DIA_MARIO_PICKPOCKET_DoIt);
};

func void DIA_MARIO_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(dia_mario_pickpocket);
};

func void dia_mario_pickpocket_back()
{
	Info_ClearChoices(dia_mario_pickpocket);
};

