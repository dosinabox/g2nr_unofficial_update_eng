
instance DIA_Fester_EXIT(C_Info)
{
	npc = SLD_816_Fester;
	nr = 999;
	condition = DIA_Fester_EXIT_Condition;
	information = DIA_Fester_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Fester_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Fester_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Fester_Hello(C_Info)
{
	npc = SLD_816_Fester;
	nr = 1;
	condition = DIA_Fester_Hello_Condition;
	information = DIA_Fester_Hello_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Fester_Hello_Condition()
{
	return TRUE;
};

func void DIA_Fester_Hello_Info()
{
	AI_Output (other, self, "DIA_Fester_Hello_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Fester_Hello_08_01");	//I am preparing for battle...
};


instance DIA_Fester_Auftrag(C_Info)
{
	npc = SLD_816_Fester;
	nr = 2;
	condition = DIA_Fester_Auftrag_Condition;
	information = DIA_Fester_Auftrag_Info;
	permanent = FALSE;
	description = "Why?";
};


func int DIA_Fester_Auftrag_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fester_Hello))
	{
		return TRUE;
	};
};

func void DIA_Fester_Auftrag_Info()
{
	AI_Output (other, self, "DIA_Fester_Auftrag_15_00");	//Why?
	AI_Output (self, other, "DIA_Fester_Auftrag_08_01");	//Lately the farmers have had more and more problems with field raiders.
	AI_Output (self, other, "DIA_Fester_Auftrag_08_02");	//A few of them even managed to get themselves eaten.
	AI_Output (self, other, "DIA_Fester_Auftrag_08_03");	//Fat Onar didn't exactly find that amusing. None of us got our pay for a week.
	AI_Output (self, other, "DIA_Fester_Auftrag_08_04");	//And it was more or less my fault. Now Lee wants me to wipe out the creatures' nest by myself.
	AI_Output (self, other, "DIA_Fester_Auftrag_08_05");	//And the other boys have already made bets on whether I'll survive ...
};


instance DIA_Fester_YouFight(C_Info)
{
	npc = SLD_816_Fester;
	nr = 3;
	condition = DIA_Fester_YouFight_Condition;
	information = DIA_Fester_YouFight_Info;
	permanent = FALSE;
	description = "Are you a good fighter?";
};


func int DIA_Fester_YouFight_Condition()
{
//	if((self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE) && Npc_KnowsInfo(other,DIA_Fester_Hello) && (MIS_Fester_KillBugs == FALSE))
	if((self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE) && Npc_KnowsInfo(other,DIA_Fester_Auftrag) && (MIS_Fester_KillBugs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Fester_YouFight_Info()
{
	AI_Output (other, self, "DIA_Fester_YouFight_15_00");	//Are you a good fighter?
	AI_Output (self, other, "DIA_Fester_YouFight_08_01");	//I'm fair with a sword, but with the bow I'm very good! Why do you ask?
};


instance DIA_Fester_WoNest(C_Info)
{
	npc = SLD_816_Fester;
	nr = 4;
	condition = DIA_Fester_WoNest_Condition;
	information = DIA_Fester_WoNest_Info;
	permanent = FALSE;
	description = "Where's the nest?";
};


func int DIA_Fester_WoNest_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fester_Auftrag) && (MIS_Fester_KillBugs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Fester_WoNest_Info()
{
	AI_Output (other, self, "DIA_Fester_WoNest_15_00");	//Where's the nest?
	AI_Output (self, other, "DIA_Fester_WoNest_08_01");	//In the middle of the field here, in the big rock.
};


var int Fester_Choice;
const int FC_Gold = 0;
const int FC_Join = 1;

instance DIA_Fester_Together(C_Info)
{
	npc = SLD_816_Fester;
	nr = 5;
	condition = DIA_Fester_Together_Condition;
	information = DIA_Fester_Together_Info;
	permanent = FALSE;
	description = "We could attack that nest together...";
};


func int DIA_Fester_Together_Condition()
{
	if((self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE) && Npc_KnowsInfo(other,DIA_Fester_Auftrag))
	{
		return TRUE;
	};
};

func void DIA_Fester_Together_Info()
{
	AI_Output (other, self, "DIA_Fester_Together_15_00");	//We could attack that nest together...
	AI_Output (self, other, "DIA_Fester_Together_08_01");	//You want to help me? Why?
	Info_ClearChoices (DIA_Fester_Together);
	Info_AddChoice (DIA_Fester_Together, "I want to see some gold!", DIA_Fester_Together_Gold);
	if (hero.guild == GIL_NONE)
	{
		Info_AddChoice (DIA_Fester_Together, "I want to join you!", DIA_Fester_Together_Join);
	};
};

func void DIA_Fester_Together_Join()
{
	AI_Output (other, self, "DIA_Fester_Together_Join_15_00");	//I want to join you!
	AI_Output (self, other, "DIA_Fester_Together_Join_08_01");	//Oh, so that's the way it is. You want to prove how good you are ..
	AI_Output (self, other, "DIA_Fester_Together_Join_08_02");	//(cunningly) All right, let's attack the beasts together.
	Fester_Choice = FC_Join;
	Info_ClearChoices(DIA_Fester_Together);
};

func void DIA_Fester_Together_Gold()
{
	AI_Output (other, self, "DIA_Fester_Together_Gold_15_00");	//I want to see some gold!
	AI_Output (self, other, "DIA_Fester_Together_Gold_08_01");	//(laughs) You bastard! You want to take advantage of my situation, huh?
	AI_Output (self, other, "DIA_Fester_Together_Gold_08_02");	//Either I pay you, or I bite the dust.
	AI_Output (self, other, "DIA_Fester_Together_Gold_08_03");	//All right. I can pay you 50 gold pieces - that's all I have.
	Fester_Choice = FC_Gold;
	Info_ClearChoices(DIA_Fester_Together);
};


var int Fester_Losgeh_Day;

instance DIA_Fester_TogetherNOW(C_Info)
{
	npc = SLD_816_Fester;
	nr = 6;
	condition = DIA_Fester_TogetherNOW_Condition;
	information = DIA_Fester_TogetherNOW_Info;
	permanent = TRUE;
	description = "Let's attack the nest!";
};


func int DIA_Fester_TogetherNOW_Condition()
{
	if((self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE) && Npc_KnowsInfo(other,DIA_Fester_Together) && (MIS_Fester_KillBugs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Fester_TogetherNOW_Info()
{
	AI_Output(other,self,"DIA_Fester_TogetherNOW_15_00");	//Let's attack the nest!
	if(Wld_IsTime(20,30,6,0))
	{
		AI_Output (self, other, "DIA_Fester_TogetherNOW_08_01");	//In the dark? No, no, we'd better do this by daylight.
	}
	else
	{
		AI_Output (self, other, "DIA_Fester_TogetherNOW_08_02");	//Right now? Or do you need to equip yourself first?
		AI_Output (self, other, "DIA_Fester_TogetherNOW_08_03");	//You could go back to the farm first...
		Info_ClearChoices (DIA_Fester_TogetherNOW);
		Info_AddChoice (DIA_Fester_TogetherNOW, "All right, let's wait a little longer...", DIA_Fester_TogetherNOW_Later);
		Info_AddChoice (DIA_Fester_TogetherNOW, "There's no time like the present.", DIA_Fester_TogetherNOW_NOW);
	};
};

func void DIA_Fester_TogetherNOW_NOW()
{
	AI_Output (other, self, "DIA_Fester_TogetherNOW_Now_15_00");	//There's no time like the present.
	AI_Output (self, other, "DIA_Fester_TogetherNOW_Now_08_01");	//Good, then let's see what you've got.
	self.npcType = NPCTYPE_FRIEND;
	Npc_ExchangeRoutine(self,"GUIDE");
	Fester_Losgeh_Day = B_GetDayPlus();
	MIS_Fester_KillBugs = LOG_Running;
	Log_CreateTopic (TOPIC_FesterRauber, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_FesterRauber, LOG_Running);
	B_LogEntry (TOPIC_FesterRauber, "I'm going to attack the field raiders' nest with Fester.");
	Info_ClearChoices (DIA_Fester_TogetherNOW);
	AI_StopProcessInfos (self);
};

func void DIA_Fester_TogetherNOW_Later()
{
	AI_Output (other, self, "DIA_Fester_TogetherNOW_Later_15_00");	//All right, let's wait a little longer...
	AI_Output (self, other, "DIA_Fester_TogetherNOW_Later_08_01");	//You know where to find me...
	Info_ClearChoices (DIA_Fester_TogetherNOW);
};


instance DIA_Fester_InCave(C_Info)
{
	npc = SLD_816_Fester;
	nr = 7;
	condition = DIA_Fester_InCave_Condition;
	information = DIA_Fester_InCave_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Fester_InCave_Condition()
{
	if((MIS_Fester_KillBugs == LOG_Running) && (Npc_GetDistToWP(self,"NW_BIGFARM_FELDREUBER4") <= 500))
	{
		self.aivar[AIV_LastFightComment] = TRUE;
		return TRUE;
	};
};

func void DIA_Fester_InCave_Info()
{
	if (Wld_GetDay () > Fester_Losgeh_Day)
	{
		AI_Output (self, other, "DIA_Fester_InCave_08_00");	//Where the devil have you been?
	}
	else
	{
		AI_Output (self, other, "DIA_Fester_InCave_08_01");	//So this is where they dragged the dead farmers. Disgusting.
	};
	AI_Output (self, other, "DIA_Fester_InCave_08_02");	//The filthy things should all be wiped out now.
	AI_Output (self, other, "DIA_Fester_InCave_08_03");	//Let's go back!
	if(Kapitel < 3)
	{
		Npc_ExchangeRoutine(self,"START");
	}
	else
	{
		Npc_ExchangeRoutine(self,"CH3");
	};
	AI_StopProcessInfos(self);
};


instance DIA_Fester_WasMitAbmachung(C_Info)
{
	npc = SLD_816_Fester;
	nr = 8;
	condition = DIA_Fester_WasMitAbmachung_Condition;
	information = DIA_Fester_WasMitAbmachung_Info;
	permanent = FALSE;
	description = "What about our agreement?";
};


func int DIA_Fester_WasMitAbmachung_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fester_InCave))
	{
		return TRUE;
	};
};

func void DIA_Fester_WasMitAbmachung_Info()
{
	AI_Output (other, self, "DIA_Fester_WasMitAbmachung_15_00");	//What about our agreement?
	if (Festers_Giant_Bug_Killed == 0)
	{
		AI_Output (self, other, "DIA_Fester_WasMitAbmachung_08_01");	//Are you kidding? You didn't do anything for it.
	}
	else if(Fester_Choice == FC_Join)
	{
		if(other.guild == GIL_NONE)
		{
			AI_Output (self, other, "DIA_Fester_WasMitAbmachung_08_02");	//Well, I could help you to get accepted with us, but I won't.
			AI_Output (other, self, "DIA_Fester_WasMitAbmachung_15_03");	//And why not?
		};
		AI_Output (self, other, "DIA_Fester_WasMitAbmachung_08_04");	//If I tell everybody that you helped me, they'll hit me with a new assignment.
		AI_Output (self, other, "DIA_Fester_WasMitAbmachung_08_05");	//You understand that I don't fancy that, don't you?
		AI_Output (self, other, "DIA_Fester_WasMitAbmachung_08_06");	//Well, tough luck, kid. I'm sure you'll find someone else to help you.
	}
	else
	{
		AI_Output (self, other, "DIA_Fester_WasMitAbmachung_08_07");	//Hey - you wanted to take advantage of my situation. Now I'm taking a bit of advantage of you.
		AI_Output (self, other, "DIA_Fester_WasMitAbmachung_08_08");	//But look at the bright side: you had a learning experience. That's something, isn't it?
	};
//	MIS_Fester_KillBugs = LOG_OBSOLETE;
	MIS_Fester_KillBugs = LOG_SUCCESS;
	B_CheckLog();
	Wld_InsertNpc(Giant_Bug,"NW_BIGFARM01_RIGHTFIELD_02_MONSTER");
	Wld_InsertNpc(Giant_Bug,"NW_BIGFARM01_RIGHTFIELD_02_MONSTER");
	Wld_InsertNpc(Giant_Bug,"NW_BIGFARM01_RIGHTFIELD_02_MONSTER");
	Wld_InsertNpc(Giant_Bug,"NW_BIGMILL_FIELD_MONSTER_04");
	Wld_InsertNpc(Giant_Bug,"NW_BIGMILL_FIELD_MONSTER_04");
};


var int Fester_Duell_Day;
var int Fester_FightVerarscht;
var int Fester_FightSylvio;
var int Fester_FightOnce;

instance DIA_Fester_PERMPruegel(C_Info)
{
	npc = SLD_816_Fester;
	nr = 9;
	condition = DIA_Fester_PERMPruegel_Condition;
	information = DIA_Fester_PERMPruegel_Info;
	permanent = TRUE;
	description = "I think your hide could do with another tanning.";
};


func int DIA_Fester_PERMPruegel_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Fester_WasMitAbmachung) || Npc_KnowsInfo(other,DIA_Jarvis_MissionKO) || (self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_NONE)) && (MIS_ReadyforChapter4 == FALSE))
	{
		if((Fester_FightOnce == TRUE) || (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST))
		{
			DIA_Fester_PERMPruegel.description = "I think your hide could do with another tanning.";
		}
		else
		{
			DIA_Fester_PERMPruegel.description = "I think your hide could do with tanning.";
		};
		return TRUE;
	};
};

func void DIA_Fester_PERMPruegel_Info()
{
	var int random;
	if((Fester_FightOnce == TRUE) || (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST))
	{
		AI_Output(other,self,"DIA_Fester_PERMPruegel_15_00");	//I think your hide could do with another tanning.
	}
	else
	{
		AI_Output(other,self,"DIA_Fester_PERMPruegel_15_00_add");	//I think your hide could do with tanning.
	};
	if(Fester_Duell_Day < Wld_GetDay())
	{
		random = Hlp_Random(11);
		CreateInvItems(self,ItMi_Gold,random);
		Fester_Duell_Day = Wld_GetDay();
	};
	if(Npc_KnowsInfo(other,DIA_Fester_WasMitAbmachung) && (Fester_FightVerarscht == FALSE))
	{
		AI_Output (other, self, "DIA_Fester_PERMPruegel_15_01");	//I don't like having my leg pulled.
		AI_Output (self, other, "DIA_Fester_PERMPruegel_08_02");	//I'm shaking, I'm shaking.
		Fester_FightVerarscht = TRUE;
	}
	else if(Npc_KnowsInfo(other,DIA_Jarvis_MissionKO) && (Fester_FightSylvio == FALSE))
	{
		AI_Output (other, self, "DIA_Fester_PERMPruegel_15_03");	//It wasn't a good idea for you to take up with Sylvio.
		AI_Output (self, other, "DIA_Fester_PERMPruegel_08_04");	//You're one of Lee's toadies, aren't you? You've come to the wrong man!
		Fester_FightSylvio = TRUE;
	}
	else if(self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST)
	{
		AI_Output (self, other, "DIA_Fester_PERMPruegel_08_05");	//What the devil do you want from me now?
		AI_Output (other, self, "DIA_Fester_PERMPruegel_15_06");	//I just love to watch you kiss the mud!
	}
	else
	{
		AI_Output (self, other, "DIA_Fester_PERMPruegel_08_07");	//You just don't get it, do you?
	};
	Fester_FightOnce = TRUE;
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};


instance DIA_Fester_PICKPOCKET(C_Info)
{
	npc = SLD_816_Fester;
	nr = 900;
	condition = DIA_Fester_PICKPOCKET_Condition;
	information = DIA_Fester_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Fester_PICKPOCKET_Condition()
{
	return C_Beklauen(27,45);
};

func void DIA_Fester_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Fester_PICKPOCKET);
	Info_AddChoice(DIA_Fester_PICKPOCKET,Dialog_Back,DIA_Fester_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Fester_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Fester_PICKPOCKET_DoIt);
};

func void DIA_Fester_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Fester_PICKPOCKET);
};

func void DIA_Fester_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Fester_PICKPOCKET);
};

