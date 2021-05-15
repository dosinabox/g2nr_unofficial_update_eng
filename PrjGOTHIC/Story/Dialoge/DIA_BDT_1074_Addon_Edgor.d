
var int Edgor_Exiteinmal;

instance DIA_Addon_Edgor_EXIT(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 999;
	condition = DIA_Addon_Edgor_EXIT_Condition;
	information = DIA_Addon_Edgor_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Edgor_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Edgor_EXIT_Info()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Edgor_Hi))
	{
		if(Edgor_Exiteinmal == FALSE)
		{
			AI_Output(self,other,"DIA_Addon_Edgor_EXIT_06_00");	//It was nice knowing you...
			Edgor_Exiteinmal = TRUE;
		};
	};
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Edgor_PICKPOCKET(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 900;
	condition = DIA_Addon_Edgor_PICKPOCKET_Condition;
	information = DIA_Addon_Edgor_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Addon_Edgor_PICKPOCKET_Condition()
{
	return C_Beklauen(10,7);
};

func void DIA_Addon_Edgor_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Edgor_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Edgor_PICKPOCKET,Dialog_Back,DIA_Addon_Edgor_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Edgor_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Edgor_PICKPOCKET_DoIt);
};

func void DIA_Addon_Edgor_PICKPOCKET_DoIt()
{
	B_Beklauen();
	B_Say(self,self,"$AWAKE");
	Info_ClearChoices(DIA_Addon_Edgor_PICKPOCKET);
};

func void DIA_Addon_Edgor_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Edgor_PICKPOCKET);
};


instance DIA_Addon_Edgor_Hi(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 2;
	condition = DIA_Addon_Edgor_Hi_Condition;
	information = DIA_Addon_Edgor_Hi_Info;
	permanent = FALSE;
	description = "How's it going?";
};


func int DIA_Addon_Edgor_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Edgor_Hi_Info()
{
	DIA_Common_HowsItGoing();
	AI_Output (self, other, "DIA_Addon_Edgor_Hi_06_01");	//You want to know how it's going? I'll tell you how it's going.
	AI_Output (self, other, "DIA_Addon_Edgor_Hi_06_02");	//First some pirates brought me here on a stormy night. Man, I barfed all over that nutshell.
	AI_Output (self, other, "DIA_Addon_Edgor_Hi_06_03");	//Then Raven locked up the mine because some idiots are too greedy for gold.
	AI_Output (self, other, "DIA_Addon_Edgor_Hi_06_04");	//And then Franco became the leader of the hunters, killing anybody who's against him.
	AI_Output (self, other, "DIA_Addon_Edgor_Hi_06_05");	//I'd say it's going pretty badly.
	if(SC_KnowsRavensGoldmine == FALSE)
	{
		B_LogEntries(TOPIC_Addon_RavenKDW,LogText_Addon_RavensGoldmine);
		B_LogNextEntry(TOPIC_Addon_Sklaven,LogText_Addon_RavensGoldmine);
		B_LogNextEntry(TOPIC_Addon_ScoutBandits,Log_Text_Addon_ScoutBandits);
	};
	SC_KnowsRavensGoldmine = TRUE;
};


instance DIA_Addon_Edgor_Franco(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 2;
	condition = DIA_Addon_Edgor_Franco_Condition;
	information = DIA_Addon_Edgor_Franco_Info;
	permanent = FALSE;
	description = "How did Franco get to be leader?";
};


func int DIA_Addon_Edgor_Franco_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Edgor_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Edgor_Franco_Info()
{
	AI_Output (other, self, "DIA_Addon_Edgor_Franco_15_00");	//How did Franco get to be leader?
	AI_Output (self, other, "DIA_Addon_Edgor_Franco_06_01");	//Quite simply. He killed Fletcher. He was the leader of the hunters before.
	AI_Output (self, other, "DIA_Addon_Edgor_Franco_06_02");	//Fletcher was okay. Franco's just jerking us all around.
};


instance DIA_Addon_Edgor_MIS2(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 4;
	condition = DIA_Addon_Edgor_MIS2_Condition;
	information = DIA_Addon_Edgor_MIS2_Info;
	permanent = FALSE;
	description = "Franco sent me about this stone tablet...";
};


func int DIA_Addon_Edgor_MIS2_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Edgor_Hi) && (MIS_HlpEdgor == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Edgor_MIS2_Info()
{
	AI_Output (other, self, "DIA_Addon_Edgor_MIS2_15_00");	//Franco sent me here about that stone tablet. Have you found it?
	AI_Output (self, other, "DIA_Addon_Edgor_MIS2_06_01");	//Man, I haven't even looked for it. All I know is it's supposed to be in this old building deep in the swamp.
	AI_Output (self, other, "DIA_Addon_Edgor_MIS2_06_02");	//And my inner voice tells me, 'Edgor, stay far away from old buildings deep in the swamp.'
	AI_Output (self, other, "DIA_Addon_Edgor_MIS2_06_03");	//I certainly won't risk my ass for that bum Franco!
	B_LogEntry (Topic_Addon_Stoneplate, "Edgor will never set out to look for the stone tablet. He says it is somewhere in an old building in the swamp.");
};


instance DIA_Addon_Edgor_Weg(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 4;
	condition = DIA_Addon_Edgor_Weg_Condition;
	information = DIA_Addon_Edgor_Weg_Info;
	permanent = TRUE;
	description = "Where exactly is this old building?";
};


func int DIA_Addon_Edgor_Weg_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Edgor_Found))
	{
		return FALSE;
	};
	if((SC_KnowsEdgorStoneLocation == TRUE) && Npc_HasItems(other,ItMi_Addon_Stone_04))
	{
		return FALSE;
	};
	if(Npc_KnowsInfo(other,DIA_Addon_Edgor_MIS2) && (MIS_HlpEdgor == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Edgor_Weg_Info()
{
	AI_Output (other, self, "DIA_Addon_Edgor_Weg_15_00");	//Where exactly is this old building?
	AI_Output (self, other, "DIA_Addon_Edgor_Weg_06_01");	//Just go left past the big rock here. After a while you'll come to another big rock.
	AI_Output (self, other, "DIA_Addon_Edgor_Weg_06_02");	//You have to go left or right past that one - I don't know any more, it was too long ago.
	AI_Output (self, other, "DIA_Addon_Edgor_Weg_06_03");	//But the ruins are supposed to be on some sort of rise. All but hidden among plants.
	AI_Output (self, other, "DIA_Addon_Edgor_Weg_06_04");	//Maybe you'll get lucky and you won't find it...
	SC_KnowsEdgorStoneLocation = TRUE;
};


instance DIA_Addon_Edgor_Found(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 4;
	condition = DIA_Addon_Edgor_Found_Condition;
	information = DIA_Addon_Edgor_Found_Info;
	permanent = FALSE;
	description = "I found the stone tablet!";
};


func int DIA_Addon_Edgor_Found_Condition()
{
	if((SC_KnowsEdgorStoneLocation == TRUE) && Npc_HasItems(other,ItMi_Addon_Stone_04))
	{
		return TRUE;
	};
};

func void DIA_Addon_Edgor_Found_Info()
{
	AI_Output (other, self, "DIA_Addon_Edgor_Found_15_00");	//I found the stone tablet!
	AI_Output (self, other, "DIA_Addon_Edgor_Found_06_01");	//(bored) Really? You must be a brave guy.
	if(!Npc_IsDead(Franco))
	{
		AI_Output(self,other,"DIA_Addon_Edgor_Found_06_02");	//(bored) Then you've certainly earned your way into the camp. (yawns)
	}
	else
	{
		MIS_HlpEdgor = LOG_SUCCESS;
		B_GivePlayerXP(XP_Addon_HlpEdgor / 2);
	};
};


instance DIA_Addon_Edgor_Teach(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 9;
	condition = DIA_Addon_Edgor_Teach_Condition;
	information = DIA_Addon_Edgor_Teach_Info;
	permanent = FALSE;
	description = "Can you teach me something?";
};


func int DIA_Addon_Edgor_Teach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Edgor_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Edgor_Teach_Info()
{
	AI_Output (other, self, "DIA_Addon_Edgor_Teach_15_00");	//Can you teach me something?
	AI_Output (self, other, "DIA_Addon_Edgor_Teach_06_01");	//I know a lot about bloodflies. I hate those miserable beasts even more than I hate Franco!
	AI_Output (self, other, "DIA_Addon_Edgor_Teach_06_02");	//But I know how to tear the stingers and wings from their dead bodies. (crazily) Yeah, tear them out...
	AI_Output (self, other, "DIA_Addon_Edgor_Teach_06_03");	//Besides that, I know how to remove the secretion from the stinger.
	AI_Output (self, other, "DIA_Addon_Edgor_Teach_06_04");	//If you want, I can teach you all that junk.
	AI_Output (self, other, "DIA_Addon_Edgor_Teach_06_05");	//Of course, nothing is for free out here...
	if(!Npc_KnowsInfo(other,DIA_Addon_Logan_Lern))
	{
		Log_CreateTopic(Topic_Addon_BDT_Teacher,LOG_NOTE);
		B_LogEntry(Topic_Addon_BDT_Teacher,Log_Text_Addon_EdgorTeach);
	};
};

func void B_Edgor_NotEnoughLP()
{
	PrintScreen(PRINT_NotEnoughLP,-1,-1,FONT_ScreenSmall,2);
	B_Say(self,other,"$NOLEARNNOPOINTS");
};

func void B_Edgor_NotEnoughGold()
{
	AI_Output(self,other,"DIA_Addon_Edgor_NotEnoughGold_06_00");	//Get me the gold. I only want coins, not nuggets.
};

var int DIA_Edgor_Teach_permanent;

instance DIA_Addon_Edgor_TrainStart(C_Info)
{
	npc = BDT_1074_Addon_Edgor;
	nr = 9;
	condition = DIA_Addon_Edgor_Start_Condition;
	information = DIA_Addon_Edgor_Start_Info;
	permanent = TRUE;
	description = "About the bloodflies...";
};


func int DIA_Addon_Edgor_Start_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Edgor_Teach) && (DIA_Edgor_Teach_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Edgor_Start_Info()
{
	AI_Output(other,self,"DIA_Addon_Edgor_TrainStart_SEKRET_15_00");	//About the bloodflies...
	if((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFSting] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFWing] == FALSE) || (Knows_Bloodfly == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_Edgor_TrainStart_SEKRET_06_01");	//What do you want to know?
		Info_ClearChoices(DIA_Addon_Edgor_TrainStart);
		Info_AddChoice(DIA_Addon_Edgor_TrainStart,Dialog_Back,DIA_Addon_Edgor_TrainStart_BACK);
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFSting] == FALSE)
		{
			Info_AddChoice(DIA_Addon_Edgor_TrainStart,ConcatStrings(NAME_TROPHY_BFSting," (1 LP, 100 gold)"),DIA_Addon_Edgor_TrainStart_Sting);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFWing] == FALSE)
		{
			Info_AddChoice(DIA_Addon_Edgor_TrainStart,ConcatStrings(NAME_TROPHY_BFWing," (1 LP, 100 gold)"),DIA_Addon_Edgor_TrainStart_Wing);
		};
		if(Knows_Bloodfly == FALSE)
		{
			Info_AddChoice(DIA_Addon_Edgor_TrainStart,ConcatStrings(NAME_TROPHY_BFPoison," (1 LP, 100 gold)"),DIA_Addon_Edgor_TrainStart_GIFT);
		};
	}
	else
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		DIA_Edgor_Teach_permanent = TRUE;
	};
};

func void DIA_Addon_Edgor_TrainStart_BACK()
{
	Info_ClearChoices(DIA_Addon_Edgor_TrainStart);
};

func void DIA_Addon_Edgor_TrainStart_Sting()
{
	AI_Output(other,self,"DIA_Addon_Edgor_TrainStart_Sting_15_00");	//How do I get the stingers from the bloodflies?
	if(other.lp < B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_BFSting))
	{
		B_Edgor_NotEnoughLP();
	}
	else if(B_GiveInvItems(other,self,ItMi_Gold,100))
	{
		B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_BFSting);
		AI_Output(self,other,"DIA_Addon_Edgor_TrainStart_Sting_06_01");	//Turn the dead beasts onto their belly and cut them open crosswise. Grasp the innards and cut through all the tissue at the back.
		AI_Output(self,other,"DIA_Addon_Edgor_TrainStart_Sting_06_02");	//Then you can remove the stinger with a jerk.
	}
	else
	{
		B_Edgor_NotEnoughGold();
	};
};

func void DIA_Addon_Edgor_TrainStart_Wing()
{
	AI_Output(other,self,"DIA_Addon_Edgor_TrainStart_Wing_15_00");	//How do I get the wings?
	if(other.lp < B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_BFWing))
	{
		B_Edgor_NotEnoughLP();
	}
	else if(B_GiveInvItems(other,self,ItMi_Gold,100))
	{
		B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_BFWing);
		AI_Output(self,other,"DIA_Addon_Edgor_TrainStart_Wing_06_01");	//Grab the wings with one hand. With the other you just cut them out along with the upper layer of skin.
	}
	else
	{
		B_Edgor_NotEnoughGold();
	};
};

func void DIA_Addon_Edgor_TrainStart_GIFT()
{
	AI_Output(other,self,"DIA_Addon_Edgor_TrainStart_GIFT_15_00");	//How do I remove the secretion from the bloodflies.
	if(other.lp < 1)
	{
		B_Edgor_NotEnoughLP();
	}
	else if(B_GiveInvItems(other,self,ItMi_Gold,100))
	{
		AI_Output(self,other,"DIA_Addon_Edgor_TrainStart_GIFT_06_01");	//Cut open the upper layer of the stinger lengthwise - then the healing secretion will flow right out.
		AI_Output(self,other,"DIA_Addon_Edgor_TrainStart_GIFT_06_02");	//That way it's completely safe to suck out a stinger - or use it for some potions.
		other.lp -= 1;
		Knows_Bloodfly = TRUE;
		PrintScreen(PRINT_ADDON_KNOWSBF,-1,-1,FONT_Screen,2);
		Log_CreateTopic(Topic_Bonus,LOG_NOTE);
		B_LogEntry(Topic_Bonus,PRINT_KnowsBloodfly);
	}
	else
	{
		B_Edgor_NotEnoughGold();
	};
};

