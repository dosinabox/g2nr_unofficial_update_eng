
instance DIA_DiegoOw_EXIT(C_Info)
{
	npc = PC_ThiefOW;
	nr = 999;
	condition = DIA_DiegoOw_EXIT_Condition;
	information = DIA_DiegoOw_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_DiegoOw_EXIT_Condition()
{
	return TRUE;
};

func void DIA_DiegoOw_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_DiegoOw_Hallo(C_Info)
{
	npc = PC_ThiefOW;
	nr = 1;
	condition = DIA_DiegoOw_Hallo_Condition;
	information = DIA_DiegoOw_Hallo_Info;
	important = TRUE;
};


func int DIA_DiegoOw_Hallo_Condition()
{
	return TRUE;
};

func void DIA_DiegoOw_Hallo_Info()
{
	AI_Output (self, other, "DIA_DiegoOw_Hallo_11_00");	//Hey, I thought you were dead.
	AI_Output (other, self, "DIA_DiegoOw_Hallo_15_01");	//Yes... so I was.
	AI_Output (other, self, "DIA_DiegoOw_Hallo_15_02");	//But now I'm back, and looking for proof of the arrival of the dragons.
	AI_Output (self, other, "DIA_DiegoOw_Hallo_11_03");	//Who are you doing that for?
	AI_Output (other, self, "DIA_DiegoOw_Hallo_15_04");	//I work for Lord Hagen. With the help of the paladins, the dragons can be stopped.
	AI_Output (self, other, "DIA_DiegoOw_Hallo_11_05");	//The paladins? Let me tell you something. After I managed to flee from here, I went to Khorinis.
	AI_Output (self, other, "DIA_DiegoOw_Hallo_11_06");	//I wanted to warn the paladins about the dragons. Heaven knows why I even tried.
	AI_Output (self, other, "DIA_DiegoOw_Hallo_11_07");	//That puffed-up Lothar didn't even listen to me - and certainly didn't let me talk to Lord Hagen.
	AI_Output (self, other, "DIA_DiegoOw_Hallo_11_08");	//Instead, they sent me back here with the expedition. So don't talk to me about paladins ...
	AI_Output (other, self, "DIA_DiegoOw_Hallo_15_09");	//The important thing is to stop the dragons as long as there's still time - no matter who helps us achieve that.
	AI_Output (self, other, "DIA_DiegoOw_Hallo_11_10");	//Stop them? We should get our asses out of this valley as long as we still have time for THAT.
	AI_Output (self, other, "DIA_DiegoOw_Silvestro_11_03");	//Say - how did you manage to get across the pass? I thought that it was swarming with orcs.
	if(PlayerPassedAbandonedMine == TRUE)
	{
		AI_Output (other, self, "DIA_DiegoOw_Silvestro_15_04");	//There is a path through the abandoned mine which isn't held by orcs.
		AI_Output (self, other, "DIA_DiegoOw_Silvestro_11_05");	//That's good to know. Then I will head for Khorinis before long - I've got a few old accounts to settle there.
	}
	else
	{
		B_PC_Thief_JustLucky();
	};
};


instance DIA_DiegoOw_Beweise(C_Info)
{
	npc = PC_ThiefOW;
	nr = 2;
	condition = DIA_DiegoOw_Beweise_Condition;
	information = DIA_DiegoOw_Beweise_Info;
	description = "Listen, I need this proof.";
};


func int DIA_DiegoOw_Beweise_Condition()
{
	if(Kapitel == 2)
	{
		return TRUE;
	};
};

func void DIA_DiegoOw_Beweise_Info()
{
	AI_Output (other, self, "DIA_DiegoOw_Hallo_15_11");	//Listen, I need this proof.
	if (MIS_ScoutMine == LOG_Running)
	{
		AI_Output(self,other,"DIA_DiegoOw_Hallo_11_14");	//All right, I'll help you if I can. But I'm not going to stick my neck out for anyone.
		AI_Output (other, self, "DIA_DiegoOw_Garond_15_00");	//I'm traveling on behalf of Garond. He needs to know how much ore has been mined so far.
		AI_Output (self, other, "DIA_DiegoOw_Garond_11_01");	//And then he will give you the proof you want?
		AI_Output (other, self, "DIA_DiegoOw_Garond_15_02");	//That's right. So - can you tell me anything about it?
		if(Npc_KnowsInfo(other,DIA_Parcival_Diego))
		{
			AI_Output(self,other,"DIA_DiegoOw_Garond_11_03");	//Sure, what do you want to know?
			AI_Output(other,self,"DIA_DiegoOw_Silvestro_15_00");	//What do you know about Silvestro's ore.
		};
		B_LogEntry(TOPIC_ScoutMine,"Diego has brought FOUR crates of ore mined by Silvestro's scrapers to safety.");
	}
	else
	{
		AI_Output (self, other, "DIA_DiegoOw_Hallo_11_12");	//All right, if that's your mission - go talk to Commander Garond.
		AI_Output (self, other, "DIA_DiegoOw_Hallo_11_13");	//If anyone knows anything about the dragon attacks, it will be the boys in the castle.
		AI_Output(self,other,"DIA_Addon_DiegoOw_Garond_11_01");	//And while you're in the castle, you can tell Garond something that should interest him a lot:
	};
	if(Npc_GetDistToWP(self,"LOCATION_02_05") <= 1000)
	{
		AI_Output (self, other, "DIA_DiegoOw_Silvestro_11_01");	//There are FOUR chests of ore here in the back of the cave. Silvestro's people mined them.
		AI_Output (self, other, "DIA_DiegoOw_Silvestro_11_02");	//Garond is welcome to come and get them - but I won't be here then.
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_DiegoOw_Silvestro_11_01");	//In the cave close to where I hid he'll find the FOUR crates of ore. Silvestro's men mined them.
		AI_Output(self,other,"DIA_Addon_DiegoOw_Silvestro_11_02");	//Garond is welcome to go and get them. I have no use for them anyway.
	};
	Silvestro_Ore = TRUE;
};


instance DIA_DiegoOw_Mine(C_Info)
{
	npc = PC_ThiefOW;
	nr = 3;
	condition = DIA_DiegoOw_Mine_Condition;
	information = DIA_DiegoOw_Mine_Info;
	permanent = FALSE;
	description = "How did you come by the ore?";
};


func int DIA_DiegoOw_Mine_Condition()
{
	if(Npc_KnowsInfo(other,DIA_DiegoOw_Beweise))
	{
		return TRUE;
	};
};

func void DIA_DiegoOw_Mine_Info()
{
	AI_Output (other, self, "DIA_DiegoOw_Mine_15_00");	//How did you come by the ore?
	AI_Output (self, other, "DIA_DiegoOw_Mine_11_01");	//I was with Silvestro's group. We had been prospecting for several days when Silvestro suddenly became nervous.
	AI_Output (self, other, "DIA_DiegoOw_Mine_11_02");	//He said that we should take the ore to a safe place.
	AI_Output (self, other, "DIA_DiegoOw_Mine_11_03");	//Well, since I was planning to skedaddle anyway, I volunteered to hide the ore.
	AI_Output (self, other, "DIA_DiegoOw_Mine_11_04");	//And that was lucky for me. Because the scrapers met with a few minecrawlers. And none of them survived.
};


instance DIA_DiegoOw_Ritter(C_Info)
{
	npc = PC_ThiefOW;
	nr = 4;
	condition = DIA_DiegoOw_Ritter_Condition;
	information = DIA_DiegoOw_Ritter_Info;
	permanent = FALSE;
	description = "What about the two dead knights...";
};


func int DIA_DiegoOw_Ritter_Condition()
{
	if(Npc_KnowsInfo(other,DIA_DiegoOw_Hallo))
	{
		return TRUE;
	};
};

func void DIA_DiegoOw_Ritter_Info()
{
	AI_Output (other, self, "DIA_DiegoOw_Ritter_15_00");	//What about the two dead knights in front of your hideout?
	AI_Output (self, other, "DIA_DiegoOw_Ritter_11_01");	//They met their doom during a fight with a group of snappers.
	AI_Output (self, other, "DIA_DiegoOw_Ritter_11_02");	//Well, the Valley of Mines has its own rules. I told them so. But they wouldn't listen to me.
};


instance DIA_DiegoOw_Perm(C_Info)
{
	npc = PC_ThiefOW;
	nr = 5;
	condition = DIA_DiegoOw_Perm_Condition;
	information = DIA_DiegoOw_Perm_Info;
	permanent = FALSE;
	description = "What do I need to know about the valley?";
};


func int DIA_DiegoOw_Perm_Condition()
{
	return TRUE;
};

func void DIA_DiegoOw_Perm_Info()
{
	AI_Output (other, self, "DIA_DiegoOw_Perm_15_00");	//What do I need to know about the valley?
	AI_Output (self, other, "DIA_DiegoOw_Perm_11_01");	//Since the fall of the Barrier, a few things have changed around here. The orcs are now in charge.
	AI_Output (self, other, "DIA_DiegoOw_Perm_11_02");	//We humans are nothing but fodder for the true rulers of the valley: the dragons.
	AI_Output (self, other, "DIA_DiegoOw_Perm_11_03");	//Stay away from anything that is stronger than you - and avoid everything that resembles a dragon.
};


instance DIA_DiegoOw_Gorn(C_Info)
{
	npc = PC_ThiefOW;
	nr = 6;
	condition = DIA_DiegoOw_Gorn_Condition;
	information = DIA_DiegoOw_Gorn_Info;
	permanent = FALSE;
	description = "I want to buy Gorn his freedom ...";
};


func int DIA_DiegoOw_Gorn_Condition()
{
	if(MIS_RescueGorn == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_DiegoOw_Gorn_Info()
{
	AI_Output (other, self, "DIA_DiegoOw_Gorn_15_00");	//I want to buy Gorn his freedom, but Garond is asking 1000 pieces of gold.
	AI_Output (self, other, "DIA_DiegoOw_Gorn_11_01");	//A tidy sum of gold. I've got 300 gold pieces on me, you can take them. The rest is up to you.
	B_GiveInvItems (self, other, ItMi_Gold, 300);
	B_LogEntry (TOPIC_RescueGorn, "Diego has paid 300 pieces of gold to help free Gorn.");
};


var int Diego_MerkeDEX;
var int Diego_MerkeSTR;

func void B_BuildLearnDialog_Diego_OW()
{
	Info_ClearChoices(DIA_DiegoOw_Teach);
	Info_AddChoice(DIA_DiegoOw_Teach,Dialog_Back,DIA_DiegoOw_TEACH_BACK);
	Info_AddChoice(DIA_DiegoOw_Teach,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_DiegoOw_TEACHDEX_1);
	Info_AddChoice(DIA_DiegoOw_Teach,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_DiegoOw_TEACHDEX_5);
	Info_AddChoice(DIA_DiegoOw_Teach,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_DiegoOw_TEACHSTR_1);
	Info_AddChoice(DIA_DiegoOw_Teach,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_DiegoOw_TEACHSTR_5);
};

instance DIA_DiegoOw_Teach(C_Info)
{
	npc = PC_ThiefOW;
	nr = 100;
	condition = DIA_DiegoOw_Teach_Condition;
	information = DIA_DiegoOw_Teach_Info;
	permanent = TRUE;
	description = "Can you teach me something?";
};


func int DIA_DiegoOw_Teach_Condition()
{
	return TRUE;
};

func void DIA_DiegoOw_Teach_Info()
{
	AI_Output (other, self, "DIA_DiegoOw_Teach_15_00");	//Can you teach me something?
	AI_Output (self, other, "DIA_Addon_DiegoOw_Teach_11_01");	//Sure, what would you like to know?
	if(DiegoOW_Teach == FALSE)
	{
		Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_OutTeacher,"Diego can help me to increase my strength and dexterity.");
		DiegoOW_Teach = TRUE;
	};
	Diego_MerkeDEX = other.aivar[REAL_DEXTERITY];
	Diego_MerkeSTR = other.aivar[REAL_STRENGTH];
	B_BuildLearnDialog_Diego_OW();
};

func void DIA_DiegoOw_TEACH_BACK()
{
	if(other.aivar[REAL_DEXTERITY] > Diego_MerkeDEX)
	{
		AI_Output (self, other, "DIA_Addon_DiegoOw_Teach_11_02");	//You have gained a little dexterity already.
	};
	if(other.aivar[REAL_STRENGTH] > Diego_MerkeSTR)
	{
		AI_Output (self, other, "DIA_Addon_DiegoOw_Teach_11_03");	//(appraisingly) Good. Your strength has increased.
	};
	Info_ClearChoices(DIA_DiegoOw_Teach);
};

func void DIA_DiegoOw_TEACHDEX_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MAX))
	{
		B_BuildLearnDialog_Diego_OW();
	};
};

func void DIA_DiegoOw_TEACHDEX_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MAX))
	{
		B_BuildLearnDialog_Diego_OW();
	};
};

func void DIA_DiegoOw_TEACHSTR_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_MED))
	{
		B_BuildLearnDialog_Diego_OW();
	};
};

func void DIA_DiegoOw_TEACHSTR_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_MED))
	{
		B_BuildLearnDialog_Diego_OW();
	};
};

instance DIA_ThiefOW_PICKPOCKET(C_Info)
{
	npc = PC_ThiefOW;
	nr = 900;
	condition = DIA_ThiefOW_PICKPOCKET_Condition;
	information = DIA_ThiefOW_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_120;
};


func int DIA_ThiefOW_PICKPOCKET_Condition()
{
	return C_Beklauen(120,600);
};

func void DIA_ThiefOW_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_ThiefOW_PICKPOCKET);
	Info_AddChoice(DIA_ThiefOW_PICKPOCKET,Dialog_Back,DIA_ThiefOW_PICKPOCKET_BACK);
	Info_AddChoice(DIA_ThiefOW_PICKPOCKET,DIALOG_PICKPOCKET,DIA_ThiefOW_PICKPOCKET_DoIt);
};

func void DIA_ThiefOW_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_ThiefOW_PICKPOCKET);
};

func void DIA_ThiefOW_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_ThiefOW_PICKPOCKET);
};


instance DIA_Addon_ThiefOW_Together(C_Info)
{
	npc = PC_ThiefOW;
	nr = 11;
	condition = DIA_Addon_ThiefOW_Together_Condition;
	information = DIA_Addon_ThiefOW_Together_Info;
	description = "Let's go together.";
};


func int DIA_Addon_ThiefOW_Together_Condition()
{
	return TRUE;
};

func void DIA_Addon_ThiefOW_Together_Info()
{
	DIA_Common_LetsGoTogether();
	AI_Output (self, other, "DIA_Addon_Diego_Together_11_01");	//To the pass? Why not...
	AI_Output (self, other, "DIA_Addon_Diego_Together_11_02");	//You go first. You've only just come from there.
	AI_Output (self, other, "DIA_Addon_Diego_Together_11_03");	//But don't even think about going too close to the castle, or to the orc wall.
	AI_Output (self, other, "DIA_Addon_Diego_Together_11_04");	//Also, we need to avoid all fortified camps of the paladins.
	AI_Output (self, other, "DIA_Addon_Diego_Together_11_05");	//I have just escaped from one, and I don't intend to go back to toiling in one of the mines.
	AI_Output (self, other, "DIA_Addon_Diego_Together_11_06");	//And it goes without saying that we're not going near any dragons.
	AI_Output (self, other, "DIA_Addon_Diego_Together_11_07");	//Let me know when you're ready.
};


instance DIA_Addon_ThiefOW_ComeOn(C_Info)
{
	npc = PC_ThiefOW;
	nr = 12;
	condition = DIA_Addon_ThiefOW_ComeOn_Condition;
	information = DIA_Addon_ThiefOW_ComeOn_Info;
	permanent = TRUE;
	description = "Come with me.";
};


func int DIA_Addon_ThiefOW_ComeOn_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == FALSE) && Npc_KnowsInfo(other,DIA_Addon_ThiefOW_Together) && (Diego_angekommen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_ThiefOW_ComeOn_Info()
{
	AI_Output (other, self, "DIA_Addon_Diego_ComeOn_15_00");	//Come with me.
	if (C_DiegoTooFar (0))
	{
		AI_Output (self, other, "DIA_Addon_Diego_ComeOn_11_01");	//That's the wrong direction!
		AI_StopProcessInfos (self);
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Diego_ComeOn_11_02");	//All right.
		AI_StopProcessInfos (self);
		Npc_ExchangeRoutine (self, "FOLLOW");
		self.aivar[AIV_PARTYMEMBER] = TRUE;
	};
};


instance DIA_Addon_ThiefOW_GoHome(C_Info)
{
	npc = PC_ThiefOW;
	nr = 13;
	condition = DIA_Addon_ThiefOW_GoHome_Condition;
	information = DIA_Addon_ThiefOW_GoHome_Info;
	permanent = TRUE;
	description = "Wait here.";
};


func int DIA_Addon_ThiefOW_GoHome_Condition()
{
	if(self.aivar[AIV_PARTYMEMBER] == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_ThiefOW_GoHome_Info()
{
	AI_Output (other, self, "DIA_Addon_Diego_WarteHier_15_00");	//Wait here!
	if (Npc_GetDistToWP (self, "LOCATION_02_05") < 2000)
	{
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_01");	//Okay.
		AI_StopProcessInfos (self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"START");
	}
	else if(Npc_GetDistToWP(self,"DT_E1_04") < (1500 + 1000))
	{
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_02");	//I'll wait by the tower outside.
		AI_StopProcessInfos (self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"XARDAS");
	}
	else if(Npc_GetDistToWP(self,"OW_NEWMINE_11") < (4000 + 1000))
	{
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_03");	//I'll wait near the mine.
		AI_StopProcessInfos (self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"FAJETH");
	}
	else if(Npc_GetDistToWP(self,"OW_MINE3_OUT") < (1200 + 1000))
	{
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_04");	//I'll wait in front of the mine.
		AI_StopProcessInfos (self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"SILVESTRO");
	}
	else if(Npc_GetDistToWP(self,"OW_PATH_266") < (3000 + 1000))
	{
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_05");	//I'll wait close by.
		AI_StopProcessInfos (self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"GRIMES");
	}
	else if(Npc_GetDistToWP(self,"LOCATION_02_05") < 15000)
	{
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_06");	//No. I'm going back to the cave.
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_07");	//Come and see me when you're done here.
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_08");	//But don't wait too long, or I'm going back by myself.
		AI_StopProcessInfos (self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"START");
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_09");	//You've got to be kidding. We're supposed to split up? Here?
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_10");	//Over my dead body!
		AI_Output (self, other, "DIA_Addon_Diego_GoHome_11_11");	//We're going to the pass now - together.
	};
};

func void B_Addon_Diego_WillWaitOutside()
{
	AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_00");	//Go ahead and take a look around - I'll be waiting outside.
};

func void B_Addon_Diego_PassOtherDirection()
{
	AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_01");	//To get to the pass, we'll have to go in the other direction.
};


var int Diego_TooFarComment;
var int Diego_BurgVariation;
var int Diego_FajethVariation;
var int Diego_SilvestroVariation;
var int Diego_GrimesVariation;
var int Diego_XardasVariation;
var int Diego_IceVariation;

instance DIA_Addon_ThiefOW_TooFar(C_Info)
{
	npc = PC_ThiefOW;
	nr = 14;
	condition = DIA_Addon_ThiefOW_TooFar_Condition;
	information = DIA_Addon_ThiefOW_TooFar_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_ThiefOW_TooFar_Condition()
{
	if(self.aivar[AIV_PARTYMEMBER] == TRUE)
	{
		if(C_DiegoTooFar(0))
		{
			if(Diego_TooFarComment == FALSE)
			{
				return TRUE;
			};
		}
		else
		{
			Diego_TooFarComment = FALSE;
		};
	};
	return FALSE;
};

func void DIA_Addon_ThiefOW_TooFar_Info()
{
	if(C_DiegoTooFar(1000) == LOC_ANGAR)
	{
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_02");	//There's something eerie about this old tomb.
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_03");	//Let's rather walk around it.
	}
	else if(C_DiegoTooFar(1000) == LOC_ICE)
	{
		if(Diego_IceVariation == 0)
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_04");	//That's the entrance to the former New Camp.
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_05");	//I'm sure that a dragon has made himself at home in there.
			B_Addon_Diego_PassOtherDirection ();
			Diego_IceVariation = 1;
		}
		else
		{
			B_Addon_Diego_PassOtherDirection();
		};
	}
	else if(C_DiegoTooFar(1000) == LOC_SWAMP)
	{
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_06");	//This swamp is a dead end.
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_07");	//I wouldn't be surprised if there's even a dragon lurking for us inside.
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_08");	//Let's not go in there.
	}
	else if(C_DiegoTooFar(1000) == LOC_FIRE)
	{
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_09");	//If we keep walking up the mountain, we're sure to meet a dragon.
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_10");	//And I would love to get to Khorinis ALIVE.
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_11");	//Let's take a different path.
	}
	else if(C_DiegoTooFar(1000) == LOC_LAKE)
	{
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_12");	//This lake doesn't lead us anywhere.
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_13");	//To get to the pass, we'll have to go in the other direction!
	}
	else if(C_DiegoTooFar(1000) == LOC_XARDAS)
	{
		if(Diego_XardasVariation == 0)
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_14");	//This is the old tower of Xardas. He made himself scarce long ago, of course.
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_15");	//I'm sure there must be some nasty surprises waiting in there.
			B_Addon_Diego_WillWaitOutside ();
			Diego_XardasVariation = 1;
		}
		else
		{
			B_Addon_Diego_WillWaitOutside();
			AI_StopProcessInfos(self);
			self.aivar[AIV_PARTYMEMBER] = FALSE;
			Npc_ExchangeRoutine(self,"XARDAS");
		};
	}
	else if(C_DiegoTooFar(1000) == LOC_FAJETHMINE)
	{
		if(Diego_FajethVariation == 0)
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_16");	//That's Fajeth's mine back there.
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_17");	//If you want to go there, count me out!
			Diego_FajethVariation = 1;
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_18");	//I shall give that mine a wide berth!
		};
	}
	else if(C_DiegoTooFar(1000) == LOC_SILVESTROMINE)
	{
		if(Diego_SilvestroVariation == 0)
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_19");	//That's the mine where they took me when I came back with the penal convoy.
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_20");	//I'm sure that NOBODY'S still alive in there.
			B_Addon_Diego_WillWaitOutside ();
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_Add_11_20");	//But if you take too long, I'll just go back to my camp.
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_Add_11_21");	//Unless you want me to wait here for you.
			Diego_SilvestroVariation = 1;
		}
		else
		{
			B_Addon_Diego_WillWaitOutside();
			AI_StopProcessInfos(self);
			self.aivar[AIV_PARTYMEMBER] = FALSE;
			Npc_ExchangeRoutine(self,"SILVESTRO");
		};
	}
	else if(C_DiegoTooFar(1000) == LOC_GRIMESMINE)
	{
		if(Diego_GrimesVariation == 0)
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_21");	//This is one of the new mines of the paladins.
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_22");	//I've never been there - and I'm not going to go there either.
			Diego_GrimesVariation = 1;
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_23");	//Let's give that mine a wide berth.
		};
	}
	else if(C_DiegoTooFar(1000) == LOC_BURG)
	{
		if(Diego_BurgVariation == 0)
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_24");	//Suicidal, are you? Just stay well away from that castle.
			Diego_BurgVariation = 1;
		}
		else if(Diego_BurgVariation == 1)
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_25");	//Hey, are you even listening to me?! Stay away from the castle!
			Diego_BurgVariation = 2;
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_26");	//What part of 'Stay away from the castle' is unclear?
			Diego_BurgVariation = 1;
		};
	}
	else if(C_DiegoTooFar(1000) == LOC_ORCBARRIER)
	{
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_27");	//We can't continue here. The orc barrier is too dangerous.
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_28");	//I think it would be better if we headed west again and walked around to the other side.
	}
	else if(C_DiegoTooFar(1000) == LOC_ORCBARRIER_FAR)
	{
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_29");	//If we continue in this direction, we'll only end up at the orc barrier again.
		AI_Output (self, other, "DIA_Addon_Diego_TooFar_11_30");	//Let's go to the pass!
	}
	else if(C_DiegoTooFar(1000) == LOC_ROCK)
	{
		AI_Output(self,other,"DIA_Addon_Diego_TooFar_11_09");	//If we keep walking up the mountain, we're sure to meet a dragon.
		AI_Output(self,other,"DIA_Addon_Diego_TooFar_11_08");	//Let's not go in there.
	};
	Diego_TooFarComment = TRUE;
};

func void B_Diego_WirSindDa()
{
	AI_Output (self, other, "DIA_Addon_Diego_Angekommen_11_02");	//I shall go the rest of the way by myself.
	AI_Output (self, other, "DIA_Addon_Diego_Angekommen_11_03");	//I have a few things to take care of before I can return to Khorinis.
	AI_Output (self, other, "DIA_Addon_Diego_Angekommen_11_04");	//Thank you, my friend. I'll see you in town.
	AI_StopProcessInfos (self);
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"PASS");
	Diego_angekommen = TRUE;
};


instance DIA_Addon_ThiefOW_Angekommen(C_Info)
{
	npc = PC_ThiefOW;
	nr = 1;
	condition = DIA_Addon_ThiefOW_Angekommen_Condition;
	information = DIA_Addon_ThiefOW_Angekommen_Info;
	important = TRUE;
};


func int DIA_Addon_ThiefOW_Angekommen_Condition()
{
	if((Npc_GetDistToWP(self,"OW_VM_ENTRANCE") < 800) && !Npc_KnowsInfo(other,DIA_Addon_ThiefOW_Nostalgie))
	{
		return TRUE;
	};
};

func void DIA_Addon_ThiefOW_Angekommen_Info()
{
	AI_Output (self, other, "DIA_Addon_Diego_Angekommen_11_01");	//Right, here we are.
	B_GivePlayerXP (500);
	B_Diego_WirSindDa ();
};


instance DIA_Addon_ThiefOW_Nostalgie(C_Info)
{
	npc = PC_ThiefOW;
	nr = 1;
	condition = DIA_Addon_ThiefOW_Nostalgie_Condition;
	information = DIA_Addon_ThiefOW_Nostalgie_Info;
	important = TRUE;
};


func int DIA_Addon_ThiefOW_Nostalgie_Condition()
{
	if(Npc_GetDistToWP(self,"WP_INTRO14") < 2000)
	{
		return TRUE;
	};
};

func void DIA_Addon_ThiefOW_Nostalgie_Info()
{
	AI_Output (self, other, "DIA_Addon_Diego_Nostalgie_11_01");	//Remember, back then?
	AI_Output (self, other, "DIA_Addon_Diego_Nostalgie_11_02");	//When we met here for the first time?
	AI_Output (self, other, "DIA_Addon_Diego_Nostalgie_11_03");	//It's been ages ...
	AI_Output (self, other, "DIA_Addon_Diego_Nostalgie_11_04");	//There was something ELSE in this place - hmm - damn! I just can't remember.
	AI_Output (self, other, "DIA_Addon_Diego_Nostalgie_11_05");	//Whatever...
	Diego_Nostalgie = TRUE;
	B_GivePlayerXP(1000);
//	hero.exp += 500;
	PrintScreen(NAME_Addon_NostalgieBonus,-1,57,FONT_Screen,2);
	B_Diego_WirSindDa();
};


instance DIA_Addon_ThiefOW_PERM(C_Info)
{
	npc = PC_ThiefOW;
	nr = 10;
	condition = DIA_Addon_ThiefOW_PERM_Condition;
	information = DIA_Addon_ThiefOW_PERM_Info;
	permanent = TRUE;
	description = "Everything all right?";
};


func int DIA_Addon_ThiefOW_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_DiegoOw_Perm) && Npc_KnowsInfo(other,DIA_Addon_ThiefOW_Together))
	{
		return TRUE;
	};
};

func void DIA_Addon_ThiefOW_PERM_Info()
{
	AI_Output (other, self, "DIA_Addon_Diego_PERM_15_00");	//How's it going?
	if (self.attribute[ATR_HITPOINTS] <= (self.attribute[ATR_HITPOINTS_MAX] / 2))
	{
		AI_Output (self, other, "DIA_Addon_Diego_PERM_11_01");	//I could use a healing potion. You wouldn't happen to have one for me?
	}
	else if((self.aivar[AIV_PARTYMEMBER] == FALSE) && (Diego_angekommen == FALSE))
	{
		AI_Output (self, other, "DIA_Addon_Diego_PERM_11_02");	//Let me know when you want to get started.
	}
	else if(Diego_angekommen == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Diego_PERM_11_03");	//Fine. I'm just taking a brief rest.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Diego_PERM_11_04");	//Fine.
	};
};

