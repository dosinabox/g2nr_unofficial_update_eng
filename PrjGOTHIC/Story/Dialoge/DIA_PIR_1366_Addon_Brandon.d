
instance DIA_Addon_Brandon_EXIT(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 999;
	condition = DIA_Addon_Brandon_EXIT_Condition;
	information = DIA_Addon_Brandon_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Brandon_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Brandon_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Brandon_Hello(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 1;
	condition = DIA_Addon_Brandon_Hello_Condition;
	information = DIA_Addon_Brandon_Hello_Info;
	important = TRUE;
};


func int DIA_Addon_Brandon_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Brandon_Hello_Info()
{
	AI_Output (self, other, "DIA_Addon_Brandon_Hello_04_00");	//Looky there. A newbie.
	AI_Output (self, other, "DIA_Addon_Brandon_Hello_04_01");	//And a landlubber at that!
	AI_Output (self, other, "DIA_Addon_Brandon_Hello_04_02");	//You're a bit scrawny for a pirate.
};


instance DIA_Addon_Brandon_AnyNews(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 99;
	condition = DIA_Addon_Brandon_AnyNews_Condition;
	information = DIA_Addon_Brandon_AnyNews_Info;
	permanent = TRUE;
	description = "Anything new?";
};


func int DIA_Addon_Brandon_AnyNews_Condition()
{
	return TRUE;
};

func void DIA_Addon_Brandon_AnyNews_Info()
{
	AI_Output (other, self, "DIA_Addon_Brandon_AnyNews_15_00");	//Anything new?
	if (self.aivar[AIV_PARTYMEMBER] == TRUE)
	{
		if(self.attribute[ATR_HITPOINTS] < 100)
		{
			AI_Output (self, other, "DIA_Addon_Brandon_Alright_04_01");	//You can say that. I'm injured. Have you got a healing potion to spare?
		}
		else if(!C_AllCanyonRazorDead())
		{
			AI_Output (self, other, "DIA_Addon_Brandon_Alright_04_02");	//What now? Are we going to clobber those beasts, or not?
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Brandon_Alright_04_03");	//The questions you ask! I don't think there's a single razor left in the whole damn canyon.
		};
	}
	else if((GregIsBack == TRUE) && !Npc_IsDead(Greg) && (MIS_Addon_Greg_ClearCanyon != LOG_SUCCESS))
	{
		AI_Output (self, other, "DIA_Addon_Brandon_AnyNews_04_04");	//No, but now that Greg is back, I hope that is bound to change soon.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Brandon_AnyNews_04_06");	//(conspiratorial) Wait a moment.
		AI_PlayAni (self, "T_SEARCH");
		AI_Output (self, other, "DIA_Addon_Brandon_AnyNews_04_07");	//(laughs) Not as far as I can see. Same old, same old!
	};
};


instance DIA_Addon_Brandon_WannaLearn(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 11;
	condition = DIA_Addon_Brandon_WannaLearn_Condition;
	information = DIA_Addon_Brandon_WannaLearn_Info;
	description = "Can you teach me something?";
};


func int DIA_Addon_Brandon_WannaLearn_Condition()
{
	return TRUE;
};

func void DIA_Addon_Brandon_WannaLearn_Info()
{
	AI_Output (other, self, "DIA_Addon_Brandon_WannaLearn_15_00");	//Can you teach me something?
	AI_Output (self, other, "DIA_Addon_Brandon_WannaLearn_04_01");	//Teach you? You bet! I could teach you to become stronger and improve your dexterity.
	AI_Output (self, other, "DIA_Addon_Brandon_WannaLearn_04_02");	//But why would I want to do that?
	AI_Output (other, self, "DIA_Addon_Pir_7_HenrysCrew_OfferDrink_15_00");	//Because I'll buy you a drink?
	AI_Output (self, other, "DIA_Addon_Brandon_WannaLearn_04_03");	//(grinning) Not bad, kiddo! Got it - first try.
	AI_Output (self, other, "DIA_Addon_Brandon_WannaLearn_04_04");	//But don't even bother to bring me some cheap rotgut.
	MIS_Brandon_BringHering = LOG_Running;
	Log_CreateTopic(TOPIC_Addon_BrandonBooze,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_BrandonBooze,LOG_Running);
	B_LogEntry(TOPIC_Addon_BrandonBooze,"I am to buy Brandon a drink. Then he will be ready to teach me.");
};


instance DIA_Addon_Brandon_HoleGrog(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 12;
	condition = DIA_Addon_Brandon_HoleGrog_Condition;
	information = DIA_Addon_Brandon_HoleGrog_Info;
	description = "I'll get you some grog.";
};


func int DIA_Addon_Brandon_HoleGrog_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Brandon_WannaLearn))
	{
		return TRUE;
	};
};

func void DIA_Addon_Brandon_HoleGrog_Info()
{
	AI_Output (other, self, "DIA_Addon_Pir_7_HenrysCrew_BringGrog_15_00");	//I'll get you some grog.
	AI_Output (self, other, "DIA_Addon_Brandon_HoleGrog_04_01");	//Are you trying to poison me???
	AI_Output (self, other, "DIA_Addon_Brandon_HoleGrog_04_02");	//I'm NOT touching that muck! Do you have any idea what's IN there?
	AI_Output (self, other, "DIA_Addon_Brandon_HoleGrog_04_03");	//Old Samuel has some GOOD stuff as well! Go get me some of THAT!
	if (Player_KnowsSchnellerHering == TRUE)
	{
		AI_Output (other, self, "DIA_Addon_Brandon_Hello_15_05");	//You're talking about his 'Hasty Herring'?
		AI_Output (self, other, "DIA_Addon_Brandon_HoleGrog_04_04");	//Aye, that's what I mean.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Brandon_HoleGrog_04_05");	//Have you ever tried Samuel's special recipe?
		AI_Output (other, self, "DIA_Addon_Brandon_Hello_15_07");	//No, not yet.
		AI_Output (self, other, "DIA_Addon_Brandon_HoleGrog_04_06");	//Then have a go at it. It's a MUST-try!
	};
	AI_Output (self, other, "DIA_Addon_Brandon_HoleGrog_04_08");	//How I LOVE this concoction!
	B_LogEntry (TOPIC_Addon_BrandonBooze, "Grog isn't enough for Brandon. He wants a 'Hasty Herring'. Only Samuel has the stuff.");
};


instance DIA_Addon_Brandon_SchnellerHering(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 13;
	condition = DIA_Addon_Brandon_SchnellerHering_Condition;
	information = DIA_Addon_Brandon_SchnellerHering_Info;
	description = "Take this Hasty Herring!";
};


func int DIA_Addon_Brandon_SchnellerHering_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Brandon_HoleGrog) && Npc_HasItems(other,ItFo_Addon_SchnellerHering))
	{
		return TRUE;
	};
};

func void DIA_Addon_Brandon_SchnellerHering_Info()
{
	AI_Output(other,self,"DIA_Addon_Pir_7_HenrysCrew_GiveGrog_15_00");	//Here you go.
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItFo_Addon_SchnellerHering,1);
	B_UseItem(self,ItFo_Addon_SchnellerHering);
	AI_Output(self,other,"DIA_Addon_Brandon_GiveGrog_04_01");	//Ahh! Down the hatch like liquid fire!
	B_LogEntries(TOPIC_Addon_BrandonBooze,"I have given Brandon that awful rotgut. Now he is ready to train me.");
	Log_CreateTopic(Topic_Addon_PIR_Teacher,LOG_NOTE);
	B_LogNextEntry(Topic_Addon_PIR_Teacher,Log_Text_Addon_BrandonTeach);
	MIS_Brandon_BringHering = LOG_SUCCESS;
	B_GivePlayerXP(XP_Ambient);
};


var int Brandon_Merke_Str;
var int Brandon_Merke_Dex;

func void B_BuildLearnDialog_Brandon()
{
	Info_ClearChoices(DIA_Addon_Brandon_TeachPlayer);
	Info_AddChoice(DIA_Addon_Brandon_TeachPlayer,Dialog_Back,DIA_Addon_Brandon_TeachPlayer_Back);
	Info_AddChoice(DIA_Addon_Brandon_TeachPlayer,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_Addon_Brandon_TeachPlayer_DEX_1);
	Info_AddChoice(DIA_Addon_Brandon_TeachPlayer,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_Addon_Brandon_TeachPlayer_DEX_5);
	Info_AddChoice(DIA_Addon_Brandon_TeachPlayer,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_Addon_Brandon_TeachPlayer_STR_1);
	Info_AddChoice(DIA_Addon_Brandon_TeachPlayer,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_Addon_Brandon_TeachPlayer_STR_5);
};

instance DIA_Addon_Brandon_TeachPlayer(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 776;
	condition = DIA_Addon_Brandon_TeachPlayer_Condition;
	information = DIA_Addon_Brandon_TeachPlayer_Info;
	permanent = TRUE;
	description = "Teach me something!";
};


func int DIA_Addon_Brandon_TeachPlayer_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Brandon_WannaLearn))
	{
		return TRUE;
	};
};

func void DIA_Addon_Brandon_TeachPlayer_Info()
{
	AI_Output(other,self,"DIA_Addon_Francis_TeachPlayer_15_00");	//Teach me something!
	if(MIS_Brandon_BringHering == LOG_SUCCESS)
	{
		Brandon_Merke_Str = other.aivar[REAL_STRENGTH];
		Brandon_Merke_Dex = other.aivar[REAL_DEXTERITY];
		B_BuildLearnDialog_Brandon();
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Brandon_TeachPlayer_04_01");	//You were going to get me something decent to drink, boy!
	};
};

func void DIA_Addon_Brandon_TeachPlayer_Back()
{
	if(other.aivar[REAL_STRENGTH] > Brandon_Merke_Str)
	{
		AI_Output (self, other, "DIA_Addon_Brandon_TeachPlayer_Back_04_00");	//All right, lad! You've gotten quite a bit stronger already.
	};
	if(other.aivar[REAL_DEXTERITY] > Brandon_Merke_Dex)
	{
		AI_Output (self, other, "DIA_Addon_Brandon_TeachPlayer_Back_04_01");	//The more dexterous you are, the better you'll hit your target.
	};
	Info_ClearChoices(DIA_Addon_Brandon_TeachPlayer);
};

func void DIA_Addon_Brandon_TeachPlayer_DEX_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MED))
	{
		B_BuildLearnDialog_Brandon();
	};
};

func void DIA_Addon_Brandon_TeachPlayer_DEX_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MED))
	{
		B_BuildLearnDialog_Brandon();
	};
};

func void DIA_Addon_Brandon_TeachPlayer_STR_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_MED))
	{
		B_BuildLearnDialog_Brandon();
	};
};

func void DIA_Addon_Brandon_TeachPlayer_STR_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_MED))
	{
		B_BuildLearnDialog_Brandon();
	};
};

instance DIA_Addon_Brandon_Anheuern(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 11;
	condition = DIA_Addon_Brandon_Anheuern_Condition;
	information = DIA_Addon_Brandon_Anheuern_Info;
	permanent = FALSE;
	description = "Ты должен мне помочь.";
};


func int DIA_Addon_Brandon_Anheuern_Condition()
{
	if(MIS_Addon_Greg_ClearCanyon == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Brandon_Anheuern_Info()
{
	AI_Output (other, self, "DIA_Addon_Brandon_FollowMe_15_00");	//You're supposed to help me.
	AI_Output (self, other, "DIA_Addon_Brandon_Anheuern_04_01");	//That's news to me. Says who?
	AI_Output (other, self, "DIA_Addon_Brandon_FollowMe_15_02");	//Says Greg. We're off to hunt razors in the canyon.
	AI_Output (self, other, "DIA_Addon_Brandon_Anheuern_04_03");	//(grinning) Finally, something's happening around here!
	AI_Output (self, other, "DIA_Addon_Brandon_Anheuern_04_04");	//Then let's go right away, the sooner we do in those beasts, the sooner we get to be back here.
};


instance DIA_Addon_Brandon_ComeOn(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 12;
	condition = DIA_Addon_Brandon_ComeOn_Condition;
	information = DIA_Addon_Brandon_ComeOn_Info;
	permanent = TRUE;
	description = "Come with me.";
};


func int DIA_Addon_Brandon_ComeOn_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == FALSE) && (MIS_Addon_Greg_ClearCanyon == LOG_Running) && Npc_KnowsInfo(other,DIA_Addon_Brandon_Anheuern))
	{
		return TRUE;
	};
};

func void DIA_Addon_Brandon_ComeOn_Info()
{
	AI_Output(other,self,"DIA_Addon_Brandon_Weiter_15_00");	//Come with me.
	if(C_GregsPiratesTooFar())
	{
		AI_Output (self, other, "DIA_Addon_Brandon_ComeOn_04_02");	//Let's go back a little first.
		AI_StopProcessInfos (self);
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Brandon_ComeOn_04_01");	//I'm right here!
		AI_StopProcessInfos (self);
		B_Addon_PiratesFollowAgain ();
		Npc_ExchangeRoutine (self, "FOLLOW");
		self.aivar[AIV_PARTYMEMBER] = TRUE;
	};
};


instance DIA_Addon_Brandon_GoHome(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 13;
	condition = DIA_Addon_Brandon_GoHome_Condition;
	information = DIA_Addon_Brandon_GoHome_Info;
	permanent = TRUE;
	description = "I no longer need you.";
};


func int DIA_Addon_Brandon_GoHome_Condition()
{
	if(self.aivar[AIV_PARTYMEMBER] == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Brandon_GoHome_Info()
{
	AI_Output (other, self, "DIA_Addon_Brandon_DontNeedYou_15_00");	//I no longer need you.
	AI_Output (self, other, "DIA_Addon_Brandon_GoHome_04_01");	//All right, no problem.
	AI_Output (self, other, "DIA_Addon_Brandon_GoHome_04_02");	//Maybe we can have a drink together some time.
	AI_StopProcessInfos (self);
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
};


instance DIA_Addon_Brandon_TooFar(C_Info)
{
	npc = PIR_1366_Addon_Brandon;
	nr = 14;
	condition = DIA_Addon_Brandon_TooFar_Condition;
	information = DIA_Addon_Brandon_TooFar_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Brandon_TooFar_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == TRUE) && C_GregsPiratesTooFar())
	{
		return TRUE;
	};
};

func void DIA_Addon_Brandon_TooFar_Info()
{
	AI_Output (self, other, "DIA_Addon_Brandon_TooFar_04_00");	//Enough already! Are you trying to depopulate the whole island?
	if (C_HowManyPiratesInParty () >= 2)
	{
		AI_Output (self, other, "DIA_Addon_Brandon_TooFar_04_01");	//We're headed back to the camp.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Brandon_TooFar_04_02");	//I'm headed back to the camp.
	};
	B_Addon_PiratesGoHome();
	AI_StopProcessInfos(self);
};

