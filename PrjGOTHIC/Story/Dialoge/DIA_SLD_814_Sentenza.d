
instance DIA_Sentenza_EXIT(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 999;
	condition = DIA_Sentenza_EXIT_Condition;
	information = DIA_Sentenza_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Sentenza_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Sentenza_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


var int Sentenza_Wants50;
var int Sentenza_SearchDay;

instance DIA_Sentenza_Hello(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 1;
	condition = DIA_Sentenza_Hello_Condition;
	information = DIA_Sentenza_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Sentenza_Hello_Condition()
{
	if((self.aivar[AIV_DefeatedByPlayer] == FALSE) && (Npc_HasItems(self,ItMi_Gold) < 50) && (other.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Sentenza_Hello_Info()
{
	AI_Output (self, other, "DIA_Sentenza_Hello_09_00");	//Where do you think you're going?!
	self.aivar[AIV_LastFightComment] = TRUE;
	Sentenza_SearchDay = B_GetDayPlus ();
	Info_ClearChoices (DIA_Sentenza_Hello);
	Info_AddChoice (DIA_Sentenza_Hello, "How would that be any concern of yours?", DIA_Sentenza_Hello_NotYourBusiness);
	Info_AddChoice (DIA_Sentenza_Hello, "I wanted to have a look around, that's all.", DIA_Sentenza_Hello_JustLooking);
};

func void DIA_Sentenza_Hello_JustLooking()
{
	AI_Output (other, self, "DIA_Sentenza_Hello_JustLooking_15_00");	//I wanted to have a look around, that's all.
	AI_Output (self, other, "DIA_Sentenza_Hello_JustLooking_09_01");	//(laughs) There's a heap of trouble here for men like you! Are you telling me you just want to look around?
	if(other.guild != GIL_SLD)
	{
		AI_Output(self,other,"DIA_Sentenza_Hello_JustLooking_09_02");	//Ha! You're headed for the court! Why else would you have trudged all the way here, hm?
	};
	AI_Output(self,other,"DIA_Sentenza_Hello_JustLooking_09_03");	//So don't give me any of that bullshit and let me search you, and you can go on your way.
	Info_ClearChoices(DIA_Sentenza_Hello);
	Info_AddChoice (DIA_Sentenza_Hello, "Just keep your fingers to yourself!", DIA_Sentenza_Hello_HandsOff);
	Info_AddChoice (DIA_Sentenza_Hello, "Suit yourself. Search me, then!", DIA_Sentenza_Hello_SearchMe);
};

func void DIA_Sentenza_Hello_NotYourBusiness()
{
	AI_Output (other, self, "DIA_Sentenza_Hello_NotYourBusiness_15_00");	//How would that be any concern of yours?
	AI_Output (self, other, "DIA_Sentenza_Hello_NotYourBusiness_09_01");	//(sighs) Then I'll have to explain it to you carefully.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void B_Sentenza_SearchMe()
{
	var int playerGold;
	playerGold = Npc_HasItems (other, ItMi_Gold);
	AI_Output (other, self, "DIA_Sentenza_Hello_SearchMe_15_00");	//Suit yourself. Search me, then!
	AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_01");	//Now then, let's see what we have here...
	AI_GotoNpc(self,hero);
	if (playerGold >= 50)
	{
		AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_02");	//Ah! Gold! It can be very dangerous carrying so much gold around.
		AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_03");	//A lot of mercenaries are real cutthroats. Not honest fellows, like me.
		B_GiveInvItems (other, self, ItMi_Gold, 50);
		Sentenza_GoldTaken = TRUE;
	}
	else if(playerGold > 0)
	{
		AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_04");	//Well, that isn't much that you have there.
		AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_05");	//I'll come back to you later.
	}
	else
	{
		AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_06");	//You came all this way without any gold?
		AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_07");	//It doesn't look to me like you're starving. You must have hidden the dough somewhere, right?
		AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_08");	//Anyway, you aren't stupid. I'm sure we'll meet again. Watch out for yourself until then.
		AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_09");	//You're probably the only one who knows where all your gold is!
	};
	Sentenza_Wants50 = TRUE;
	AI_Output (self, other, "DIA_Sentenza_Hello_SearchMe_09_10");	//I only want 50 gold pieces from you - that's the toll here. And you only need to pay once. That's fair, isn't it?
};

func void DIA_Sentenza_Hello_SearchMe()
{
	B_Sentenza_SearchMe();
	AI_StopProcessInfos(self);
};

func void DIA_Sentenza_Hello_HandsOff()
{
	AI_Output (other, self, "DIA_Sentenza_Hello_HandsOff_15_00");	//Just keep your fingers to yourself!
	AI_Output (self, other, "DIA_Sentenza_Hello_HandsOff_09_01");	//(threatening) Or what?
	Info_ClearChoices (DIA_Sentenza_Hello);
	Info_AddChoice (DIA_Sentenza_Hello, "Or nothing. Search me, then!", DIA_Sentenza_Hello_SearchMe);
	Info_AddChoice (DIA_Sentenza_Hello, "Or you won't be able to search anyone for quite a while!", DIA_Sentenza_Hello_OrElse);
};

func void DIA_Sentenza_Hello_OrElse()
{
	AI_Output (other, self, "DIA_Sentenza_Hello_OrElse_15_00");	//Or you won't be able to search anyone for quite a while!
	AI_Output (self, other, "DIA_Sentenza_Hello_OrElse_09_01");	//We'll see about that!
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};


instance DIA_Sentenza_Vzwei(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 2;
	condition = DIA_Sentenza_Vzwei_Condition;
	information = DIA_Sentenza_Vzwei_Info;
//	permanent = FALSE;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Sentenza_Vzwei_Condition()
{
	if((self.aivar[AIV_DefeatedByPlayer] == FALSE) && (Sentenza_GoldTaken == FALSE) && (Sentenza_GoldGiven == FALSE) && (Sentenza_SearchDay < Wld_GetDay()) && (Npc_HasItems(self,ItMi_Gold) < 50) && (other.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Sentenza_Vzwei_Info()
{
	AI_Output (self, other, "DIA_Sentenza_Vzwei_09_00");	//Here you are again. Let's see what you have on you this time!
	self.aivar[AIV_LastFightComment] = TRUE;
	Sentenza_SearchDay = B_GetDayPlus ();
	Info_ClearChoices (DIA_Sentenza_Vzwei);
	Info_AddChoice (DIA_Sentenza_Vzwei, "Take your grubby paws off of me!", DIA_Sentenza_Vzwei_HandsOff);
	Info_AddChoice (DIA_Sentenza_Vzwei, "Suit yourself. Search me, then!", DIA_Sentenza_Vzwei_SearchMe);
};

func void DIA_Sentenza_Vzwei_SearchMe()
{
	B_Sentenza_SearchMe();
	AI_StopProcessInfos(self);
};

func void DIA_Sentenza_Vzwei_HandsOff()
{
	AI_Output (other, self, "DIA_Sentenza_Vzwei_HandsOff_15_00");	//Take your grubby paws off of me!
	AI_Output (self, other, "DIA_Sentenza_Vzwei_HandsOff_09_01");	//(menacing) So? Apparently you've got a bit more on you this time!
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};


instance DIA_Sentenza_WannaJoin(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 3;
	condition = DIA_Sentenza_WannaJoin_Condition;
	information = DIA_Sentenza_WannaJoin_Info;
	permanent = FALSE;
	description = "I have come to join you!";
};


func int DIA_Sentenza_WannaJoin_Condition()
{
	if(hero.guild == GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_Sentenza_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Sentenza_WannaJoin_15_00");	//I have come to join you!
	AI_Output (self, other, "DIA_Sentenza_WannaJoin_09_01");	//Nice for you.
	AI_Output (self, other, "DIA_Sentenza_WannaJoin_09_02");	//(casual) Do you understand that the mercenaries are going to vote whether you get to join them or not?
	SCKnowsSLDVotes = TRUE;
};


instance DIA_Sentenza_Vote(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 4;
	condition = DIA_Sentenza_Vote_Condition;
	information = DIA_Sentenza_Vote_Info;
	permanent = TRUE;
	description = "Will you vote for me?";
};


func int DIA_Sentenza_Vote_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Sentenza_WannaJoin) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Sentenza_Vote_Info()
{
	AI_Output (other, self, "DIA_Sentenza_Vote_15_00");	//Will you vote for me?
	if (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST)
	{
		AI_Output(self,other,"DIA_Sentenza_Vote_09_01");	//Just because you beat me? (laughs) No.
	};
	if((Npc_HasItems(self,ItMi_Gold) >= 50) && ((Sentenza_GoldTaken == TRUE) || (Sentenza_GoldGiven == TRUE)))
	{
		AI_Output(self,other,"DIA_Sentenza_Vote_09_02");	//But then, why not? 50 gold pieces is a fair price for a vote, don't you think?
		if(Sentenza_Stimme == FALSE)
		{
			if(Torlof_GenugStimmen == FALSE)
			{
				Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
				Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
			};
			B_LogEntry(TOPIC_SLDRespekt,"Sentenza doesn't mind if I join the mercenaries.");
		};
		Sentenza_Stimme = TRUE;
	}
	else if((Sentenza_Stimme == TRUE) && (Npc_HasItems(self,ItMi_Gold) < 50))
	{
		AI_Output(self,other,"DIA_Sentenza_Vote_09_03");	//After you took my gold away again? I don't think so, my boy.
		Sentenza_Wants50 = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Sentenza_Vote_09_04");	//It doesn't work that way, boy! If I'm expected to vote for you, you're going to have to send some gold my way.
		AI_Output (other, self, "DIA_Sentenza_Vote_15_05");	//How much?
		AI_Output (self, other, "DIA_Sentenza_Vote_09_06");	//50 gold pieces. That's the toll you would have paid anyway.
		Sentenza_Wants50 = TRUE;
	};
};


var int Sentenza_GoldGiven;

instance DIA_Sentenza_Pay50(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 5;
	condition = DIA_Sentenza_Pay50_Condition;
	information = DIA_Sentenza_Pay50_Info;
	permanent = TRUE;
	description = "Here's your 50 gold pieces.";
};


func int DIA_Sentenza_Pay50_Condition()
{
	if((Sentenza_Wants50 == TRUE) && (Npc_HasItems(self,ItMi_Gold) < 50))
	{
		return TRUE;
	};
};

func void DIA_Sentenza_Pay50_Info()
{
	AI_Output (other, self, "DIA_Sentenza_Pay50_15_00");	//Here's your 50 gold pieces.
	if (B_GiveInvItems (other, self, ItMi_Gold, 50))
	{
		AI_Output (self, other, "DIA_Sentenza_Pay50_09_01");	//Well thanks, that'll do.
		Sentenza_GoldGiven = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Sentenza_Pay50_09_02");	//Don't mess with me. 50 and not one piece less, got it?
	};
};


//var int Sentenza_Einmal;

instance DIA_Sentenza_GoldBack(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 6;
	condition = DIA_Sentenza_GoldBack_Condition;
	information = DIA_Sentenza_GoldBack_Info;
	permanent = TRUE;
	description = "Gimme back my gold!";
};


func int DIA_Sentenza_GoldBack_Condition()
{
	if(Npc_HasItems(self,ItMi_Gold) >= 50)
	{
		/*if((Sentenza_GoldGiven == FALSE) || (other.guild == GIL_SLD))
		{
			return TRUE;
		};*/
		return TRUE;
	};
};

func void DIA_Sentenza_GoldBack_Info()
{
	AI_Output(other,self,"DIA_Sentenza_GoldBack_15_00");	//Gimme back my gold!
//	if((other.guild == GIL_SLD) && (Torlof_SentenzaCounted == TRUE) && (Sentenza_Einmal == FALSE))
	if(Torlof_SentenzaCounted == TRUE)
	{
		AI_Output (self, other, "DIA_Sentenza_GoldBack_09_01");	//Now that I've given you my vote?
		AI_Output (self, other, "DIA_Sentenza_GoldBack_09_02");	//You rotten little beggar!
//		Sentenza_Einmal = TRUE;
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_NONE,1);
	}
	else
	{
		AI_Output (self, other, "DIA_Sentenza_GoldBack_09_03");	//Relax! I'll only keep an eye on it for a while...
	};
};


instance DIA_Sentenza_AufsMaul(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 7;
	condition = DIA_Sentenza_AufsMaul_Condition;
	information = DIA_Sentenza_AufsMaul_Info;
	permanent = FALSE;
	description = "Say, is that a face you have at the front of your head, or is it a butt? ";
};


func int DIA_Sentenza_AufsMaul_Condition()
{
	if((Npc_HasItems(self,ItMi_Gold) >= 50) || Npc_KnowsInfo(other,DIA_Jarvis_MissionKO))
	{
		return TRUE;
	};
};

func void DIA_Sentenza_AufsMaul_Info()
{
	AI_Output (other, self, "DIA_Sentenza_AufsMaul_15_00");	//Say, is that a face you have at the front of your head, or is it a butt?
	AI_Output (self, other, "DIA_Sentenza_AufsMaul_09_01");	//(laughs angrily) Okay, that's the way you want it...
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};


instance DIA_Sentenza_AufsMaulAgain(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 8;
	condition = DIA_Sentenza_AufsMaulAgain_Condition;
	information = DIA_Sentenza_AufsMaulAgain_Info;
	permanent = TRUE;
	description = "It's thrashing time once again!";
};


func int DIA_Sentenza_AufsMaulAgain_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Sentenza_AufsMaul) && (MIS_ReadyforChapter4 == FALSE))
	{
		if((Npc_HasItems(self,ItMi_Gold) >= 50) || Npc_KnowsInfo(other,DIA_Jarvis_MissionKO))
		{
			return TRUE;
		};
	};
};

func void DIA_Sentenza_AufsMaulAgain_Info()
{
	AI_Output (other, self, "DIA_Sentenza_AufsMaulAgain_15_00");	//It's thrashing time once again!
	AI_Output (self, other, "DIA_Sentenza_AufsMaulAgain_09_01");	//If you say so...
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};


instance DIA_Sentenza_PERM(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 1;
	condition = DIA_Sentenza_PERM_Condition;
	information = DIA_Sentenza_PERM_Info;
	permanent = TRUE;
	description = "And, how are things?";
};


func int DIA_Sentenza_PERM_Condition()
{
	return TRUE;
};

func void DIA_Sentenza_PERM_Info()
{
	AI_Output (other, self, "DIA_Sentenza_PERM_15_00");	//And, how are things?
	AI_Output (self, other, "DIA_Sentenza_PERM_09_01");	//Not many people come this way, but up to now every one of them has paid my toll.
	if (Npc_HasItems (self, ItMi_Gold) < 50)
	{
		AI_Output (self, other, "DIA_Sentenza_PERM_09_02");	//Except you. (grins)
	};
};


instance DIA_Sentenza_PICKPOCKET(C_Info)
{
	npc = SLD_814_Sentenza;
	nr = 900;
	condition = DIA_Sentenza_PICKPOCKET_Condition;
	information = DIA_Sentenza_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be risky to steal his ring.)";
};


func int DIA_Sentenza_PICKPOCKET_Condition()
{
//	return C_Beklauen(56,65);
	if(Npc_HasItems(self,ItMi_SilverRing))
	{
		return C_StealItem(56);
	};
	return FALSE;
};

func void DIA_Sentenza_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Sentenza_PICKPOCKET);
	Info_AddChoice(DIA_Sentenza_PICKPOCKET,Dialog_Back,DIA_Sentenza_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Sentenza_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Sentenza_PICKPOCKET_DoIt);
};

func void DIA_Sentenza_PICKPOCKET_DoIt()
{
//	B_Beklauen();
	B_StealItem(56,Hlp_GetInstanceID(ItMi_SilverRing));
	Info_ClearChoices(DIA_Sentenza_PICKPOCKET);
};

func void DIA_Sentenza_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Sentenza_PICKPOCKET);
};

