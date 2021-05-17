
var int Vatras_LaresExit;
//var int Vatras_MORE;

func int C_Vatras_Away()
{
	if(MIS_RitualInnosEyeRepair == LOG_Running)
	{
		return TRUE;
	};
	if(Vatras_IsOnBoard == LOG_SUCCESS)
	{
		return TRUE;
	};
	return FALSE;
};

func void B_Vatras_ListenersControl()
{
	var string pos;
	if(C_Vatras_Away())
	{
		pos = "VATRASAWAY";
	}
	else
	{
		pos = "START";
	};
	if(Vatras_Listeners_ReadyToGo == TRUE)
	{
		B_StartOtherRoutine(Valentino,pos);
		B_StartOtherRoutine(VLK_426_Buergerin,pos);
		B_StartOtherRoutine(VLK_428_Buergerin,pos);
		B_StartOtherRoutine(VLK_450_Buerger,pos);
		B_StartOtherRoutine(VLK_454_Buerger,pos);
		B_StartOtherRoutine(VLK_455_Buerger,pos);
		Vatras_Listeners_ReadyToGo = FALSE;
	};
};

instance DIA_Addon_Vatras_KillerWarning(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_KillerWarning_Condition;
	information = DIA_Addon_Vatras_KillerWarning_Info;
	important = TRUE;
};


func int DIA_Addon_Vatras_KillerWarning_Condition()
{
	if((Kapitel >= 5) && (MadKillerCount >= 3) && (MadKillerCount < 7) && (VatrasPissedOffForever == FALSE) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_KillerWarning_Info()
{
	AI_Output (self, other, "DIA_Addon_Vatras_KillerWarning_ADD_05_00");	//There are many rumors about you in Khorinis.
	AI_Output (self, other, "DIA_Addon_Vatras_KillerWarning_ADD_05_01");	//They say you were involved in the murder of innocent people.
	AI_Output (self, other, "DIA_Addon_Vatras_KillerWarning_ADD_05_02");	//If that's truly the case, I can only warn you, son.
	AI_Output (self, other, "DIA_Addon_Vatras_KillerWarning_ADD_05_03");	//Do not leave the path of balance and preservation of this world, or you will have to bear the consequences.
	AI_Output (self, other, "DIA_Addon_Vatras_KillerWarning_ADD_05_04");	//Tell me. What can I do to help you?
};


instance DIA_Addon_Vatras_LastWarning(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_LastWarning_Condition;
	information = DIA_Addon_Vatras_LastWarning_Info;
	important = TRUE;
};


func int DIA_Addon_Vatras_LastWarning_Condition()
{
	if((Kapitel >= 5) && (MadKillerCount >= 7) && (VatrasPissedOffForever == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_LastWarning_Info()
{
	B_LastWarningVatras ();
	AI_Output (self, other, "DIA_Addon_Vatras_LastWarning_ADD_05_06");	//What have you got to say for yourself?
	Info_ClearChoices (DIA_Addon_Vatras_LastWarning);
	Info_AddChoice (DIA_Addon_Vatras_LastWarning, "Kiss my ass.", DIA_Addon_Vatras_LastWarning_Arsch);
	Info_AddChoice (DIA_Addon_Vatras_LastWarning, "I'm sorry. I didn't know what I was doing.", DIA_Addon_Vatras_LastWarning_Reue);
};

func void DIA_Addon_Vatras_LastWarning_Arsch()
{
	AI_Output (other, self, "DIA_Addon_Vatras_LastWarning_Arsch_ADD_15_00");	//Get stuffed.
	AI_Output (self, other, "DIA_Addon_Vatras_LastWarning_Arsch_ADD_05_00");	//There isn't a trace of remorse in your words.
	AI_Output (self, other, "DIA_Addon_Vatras_LastWarning_Arsch_ADD_05_01");	//You leave me no choice.
	if(C_Vatras_Away())
	{
		Vatras_Listeners_ReadyToGo = TRUE;
	};
	Info_ClearChoices(DIA_Addon_Vatras_LastWarning);
	B_VatrasPissedOff();
};

func void DIA_Addon_Vatras_LastWarning_Reue()
{
	AI_Output (other, self, "DIA_Addon_Vatras_LastWarning_Reue_ADD_15_00");	//I'm sorry. I didn't know what I was doing.
	AI_Output (self, other, "DIA_Addon_Vatras_LastWarning_Reue_ADD_05_00");	//I shall pray for you and hope that you will come to your senses again.
	AI_Output (self, other, "DIA_Addon_Vatras_LastWarning_Reue_ADD_05_01");	//Woe betide you if I hear of another murder that you've had a hand in.
	Info_ClearChoices (DIA_Addon_Vatras_LastWarning);
	VatrasMadKillerCount = MadKillerCount;
};


instance DIA_Addon_Vatras_PissedOff(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 5;
	condition = DIA_Addon_Vatras_PissedOff_Condition;
	information = DIA_Addon_Vatras_PissedOff_Info;
	important = TRUE;
};


func int DIA_Addon_Vatras_PissedOff_Condition()
{
	if((MadKillerCount > VatrasMadKillerCount) && Npc_KnowsInfo(other,DIA_Addon_Vatras_LastWarning) && (Kapitel >= 5))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_PissedOff_Info()
{
	AI_Output (self, other, "DIA_Addon_Vatras_PissedOff_ADD_05_00");	//Your words are as false as your deeds.
	AI_Output (self, other, "DIA_Addon_Vatras_PissedOff_ADD_05_01");	//You just won't cease your pointless killing.
	AI_Output (self, other, "DIA_Addon_Vatras_PissedOff_ADD_05_02");	//You leave me no choice.
	if(C_Vatras_Away())
	{
		Vatras_Listeners_ReadyToGo = TRUE;
	};
	B_VatrasPissedOff();
};


instance DIA_Vatras_EXIT(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 999;
	condition = DIA_Vatras_EXIT_Condition;
	information = DIA_Vatras_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Vatras_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Vatras_EXIT_Info()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Vatras_HowToJoin) && (Vatras_LaresExit == FALSE))
	{
		AI_Output (self, other, "DIA_Addon_Vatras_LaresExit_05_00");	//Wait!
		if (Vatras_GehZuLares == TRUE)
		{
			AI_Output (self, other, "DIA_Addon_Vatras_LaresExit_05_01");	//If you see Lares ...
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Vatras_LaresExit_05_02");	//I'd like you to do me a little favor.
			AI_Output (self, other, "DIA_Addon_Vatras_LaresExit_05_03");	//Go down to the harbor. You'll find a man there named Lares.
			Vatras_GehZuLares = TRUE;
		};
		AI_Output(self,other,"DIA_Addon_Vatras_LaresExit_05_04");	//Give him this ornament and tell him that it needs to be returned. He'll know what to do with it.
		CreateInvItems(self,ItMi_Ornament_Addon_Vatras,1);
		B_GiveInvItems(self,other,ItMi_Ornament_Addon_Vatras,1);
		Vatras_LaresExit = TRUE;
	};
	AI_StopProcessInfos(self);
	B_Vatras_ListenersControl();
//	Vatras_MORE = FALSE;
};


instance DIA_Vatras_PICKPOCKET(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 900;
	condition = DIA_Vatras_PICKPOCKET_Condition;
	information = DIA_Vatras_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Vatras_PICKPOCKET_Condition()
{
	return C_Beklauen(91,250);
};

func void DIA_Vatras_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Vatras_PICKPOCKET);
	Info_AddChoice(DIA_Vatras_PICKPOCKET,Dialog_Back,DIA_Vatras_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Vatras_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Vatras_PICKPOCKET_DoIt);
};

func void DIA_Vatras_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Vatras_PICKPOCKET);
};

func void DIA_Vatras_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Vatras_PICKPOCKET);
};


instance DIA_Vatras_GREET(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Vatras_GREET_Condition;
	information = DIA_Vatras_GREET_Info;
	important = TRUE;
};


func int DIA_Vatras_GREET_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_GREET_Info()
{
	AI_Output (self, other, "DIA_Vatras_GREET_05_00");	//Adanos be with you.
	AI_Output (other, self, "DIA_Vatras_GREET_15_01");	//Who are you?
	AI_Output (self, other, "DIA_Vatras_GREET_05_02");	//I am Vatras, a servant of Adanos, the guardian of the divine and earthly equilibrium.
	AI_Output (self, other, "DIA_Vatras_GREET_05_03");	//What can I do for you?
};


instance DIA_Addon_Vatras_Cavalorn(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_Cavalorn_Condition;
	information = DIA_Addon_Vatras_Cavalorn_Info;
	description = "Here, I've got a letter for you.";
};


func int DIA_Addon_Vatras_Cavalorn_Condition()
{
	if((Npc_HasItems(other,ItWr_SaturasFirstMessage_Addon_Sealed) && (MIS_Addon_Cavalorn_Letter2Vatras == LOG_Running)) || Npc_HasItems(other,ItWr_SaturasFirstMessage_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_Cavalorn_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Cavalorn_15_00");	//Here, I've got a letter for you.
	AI_Output (self, other, "DIA_Addon_Vatras_Cavalorn_05_01");	//For me?
	if (SaturasFirstMessageOpened == FALSE)
	{
		B_GivePlayerXP(XP_Addon_Cavalorn_Letter2Vatras);
		B_GiveInvItems(other,self,ItWr_SaturasFirstMessage_Addon_Sealed,1);
		Npc_RemoveInvItem(self,ItWr_SaturasFirstMessage_Addon_Sealed);
		CreateInvItems(self,ItWr_SaturasFirstMessage_Addon,1);
	}
	else
	{
		B_GivePlayerXP(XP_Addon_Cavalorn_Letter2Vatras / 4);
		B_GiveInvItems(other,self,ItWr_SaturasFirstMessage_Addon,1);
		AI_Output(self,other,"DIA_Addon_Vatras_Cavalorn_05_02");	//Yes, but ... it's been opened. I hope it didn't fall into the wrong hands.
	};
	B_UseFakeScroll();
	AI_Output (self, other, "DIA_Addon_Vatras_Cavalorn_05_03");	//Indeed. This is an important message you're bringing me.
	AI_Output (self, other, "DIA_Addon_Vatras_Cavalorn_05_04");	//I wonder how you got hold of this letter.
	Info_ClearChoices(DIA_Addon_Vatras_Cavalorn);
	Info_AddChoice(DIA_Addon_Vatras_Cavalorn,"I took it from some bandits.",DIA_Addon_Vatras_Cavalorn_Bandit);
	if(MIS_Addon_Cavalorn_KillBrago == LOG_SUCCESS)
	{
		Info_AddChoice (DIA_Addon_Vatras_Cavalorn, "From Cavalorn the hunter.", DIA_Addon_Vatras_Cavalorn_Cavalorn);
	};
	MIS_Addon_Cavalorn_Letter2Vatras = LOG_SUCCESS;
};

func void DIA_Addon_Vatras_Cavalorn_Bandit()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Cavalorn_Bandit_15_00");	//I took it from some bandits.
	AI_Output (self, other, "DIA_Addon_Vatras_Cavalorn_Bandit_05_01");	//(worried) By Adanos. That's not good. That's not good at all.
	AI_Output (self, other, "DIA_Addon_Vatras_Cavalorn_Bandit_05_02");	//If what you say is true, we've got a huge problem.
	AI_Output (self, other, "DIA_Addon_Vatras_Cavalorn_Bandit_05_03");	//I shall have to take care of it as soon as possible.
	Info_ClearChoices (DIA_Addon_Vatras_Cavalorn);
};

func void DIA_Addon_Vatras_Cavalorn_Cavalorn()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Cavalorn_Cavalorn_15_00");	//I got it from Cavalorn, the hunter.
	AI_Output (self, other, "DIA_Addon_Vatras_Cavalorn_Cavalorn_05_01");	//(surprised) Cavalorn? Where is he?
	AI_Output (other, self, "DIA_Addon_Vatras_Cavalorn_Cavalorn_15_02");	//He told me to tell you he couldn't make it and is headed for the meeting point. Whatever he means by that.
	AI_Output (self, other, "DIA_Addon_Vatras_Cavalorn_Cavalorn_05_03");	//I see that you've gained Cavalorn's trust. That speaks in your favor.
	B_GivePlayerXP (XP_Addon_CavalornTrust);
	Info_ClearChoices (DIA_Addon_Vatras_Cavalorn);
};


var int Vatras_Why;

instance DIA_Addon_Vatras_CavalornSentMe(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 1;
	condition = DIA_Addon_Vatras_CavalornSentMe_Condition;
	information = DIA_Addon_Vatras_CavalornSentMe_Info;
	permanent = FALSE;
	description = "Cavalorn sent me to you!";
};


func int DIA_Addon_Vatras_CavalornSentMe_Condition()
{
	if((SC_KnowsRanger == TRUE) && (SC_IsRanger == FALSE) && Npc_KnowsInfo(other,DIA_Addon_Cavalorn_Ring) && (Vatras_Why == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_CavalornSentMe_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Add_15_00");	//Cavalorn sent me to you!
	AI_Output (self, other, "DIA_Addon_Vatras_Add_05_01");	//(cunningly) And what did he tell you?
	AI_Output (other, self, "DIA_Addon_Vatras_Add_15_02");	//He said you're in dire need of more good people.
	AI_Output (self, other, "DIA_Addon_Vatras_Add_05_03");	//(smiles) Aha ... So you want to JOIN us, son?
};


var int Vatras_ToldAboutDuty;
var int Vatras_ToldAboutOtherKDW;
var int Vatras_ToldAboutUnexplored;

instance DIA_Addon_Vatras_TellMe(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 1;
	condition = DIA_Addon_Vatras_TellMe_Condition;
	information = DIA_Addon_Vatras_TellMe_Info;
	permanent = TRUE;
	description = "Tell me about the Ring of Water.";
};


func int DIA_Addon_Vatras_TellMe_Condition()
{
	if((SC_KnowsRanger == TRUE) && (SC_IsRanger == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_TellMe_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_TellMe_15_00");	//Tell me about the Ring of Water.
	if (!Npc_KnowsInfo (other, DIA_Addon_Vatras_WannaBeRanger))
	{
		AI_Output (self, other, "DIA_Addon_Vatras_TellMe_05_01");	//(expectantly) And why would I do that?
		Vatras_Why = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Vatras_TellMe_05_02");	//Since you are not yet a member of our community, I cannot tell you EVERYTHING, of course.
		AI_Output (self, other, "DIA_Addon_Vatras_TellMe_05_03");	//But I shall tell you what I may.
		Info_ClearChoices (DIA_Addon_Vatras_TellMe);
		Info_AddChoice (DIA_Addon_Vatras_TellMe, Dialog_Back, DIA_Addon_Vatras_TellMe_BACK);
		Info_AddChoice (DIA_Addon_Vatras_TellMe, "What exactly is it that you do?", DIA_Addon_Vatras_TellMe_Philo);
		Info_AddChoice (DIA_Addon_Vatras_TellMe, "Where are the other Water Mages?", DIA_Addon_Vatras_TellMe_OtherKdW);
		Info_AddChoice (DIA_Addon_Vatras_TellMe, "Who are the members of the Ring of Water, then?", DIA_Addon_Vatras_TellMe_WerNoch);
	};
};

func void DIA_Addon_Vatras_TellMe_BACK()
{
	Info_ClearChoices(DIA_Addon_Vatras_TellMe);
};

func void DIA_Addon_Vatras_TellMe_Philo()
{
	AI_Output (other, self, "DIA_Addon_Vatras_TellMe_Philo_15_00");	//What exactly is it that you do?
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Philo_05_01");	//We stand between the order of Innos and the chaos of Beliar.
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Philo_05_02");	//If one of the two sides should gain the upper hand, it will mean either total loss of freedom, or deadly chaos.
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Philo_05_03");	//Therefore, we guard the balance between the two. That's what makes life in this world possible at all.
	Vatras_ToldAboutDuty = TRUE;
};

func void DIA_Addon_Vatras_TellMe_OtherKdW()
{
	AI_Output(other,self,"DIA_Addon_Vatras_TellMe_OtherKdW_15_00");	//Where are the other Water Mages?
	AI_Output(self,other,"DIA_Addon_Vatras_TellMe_OtherKdW_05_01");	//They are exploring the ruins of an old culture north-east of Khorinis.
	AI_Output(self,other,"DIA_Addon_Vatras_TellMe_OtherKdW_05_02");	//We suspect that those ruins might contain a passage to a part of the island which is as yet uncharted.
	if(Vatras_ToldAboutOtherKDW == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_KDW,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_KDW,LOG_Running);
		B_LogEntry(TOPIC_Addon_KDW,"The other Water Mages are exploring the ruins of an old culture north-east of Khorinis. There might be an entry to an uncharted part of Khorinis.");
	};
	Vatras_ToldAboutOtherKDW = TRUE;
	Info_AddChoice(DIA_Addon_Vatras_TellMe,"Tell me more about that uncharted area.",DIA_Addon_Vatras_TellMe_Unexplored);
};

func void DIA_Addon_Vatras_TellMe_Unexplored()
{
	AI_Output(other,self,"DIA_Addon_Vatras_TellMe_Unexplored_15_00");	//Tell me more about that uncharted area.
	AI_Output(self,other,"DIA_Addon_Vatras_TellMe_Unexplored_05_01");	//If you're interested in joining the expedition, I could send you to Saturas with a letter.
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Unexplored_05_02");	//You can only participate, of course, as long as you're one of us.
	AI_Output (other, self, "DIA_Addon_Vatras_TellMe_Unexplored_15_03");	//Of course.
	if(Vatras_ToldAboutUnexplored == FALSE)
	{
		B_LogEntry(TOPIC_Addon_KDW,"Vatras wants me to become a member of the 'Ring of Water' before I can join the Water Mages' expedition.");
	};
	Vatras_ToldAboutUnexplored = TRUE;
};

func void DIA_Addon_Vatras_TellMe_WerNoch()
{
	AI_Output (other, self, "DIA_Addon_Vatras_TellMe_WerNoch_15_00");	//Who are the members of the Ring of Water, then?
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_WerNoch_05_01");	//I cannot tell you that until you join the Ring.
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_WerNoch_05_02");	//But you will certainly already have met some of them by that time.
};


instance DIA_Addon_Vatras_Bandittrader(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_Bandittrader_Condition;
	information = DIA_Addon_Vatras_Bandittrader_Info;
	description = "And what does that mean?";
};


func int DIA_Addon_Vatras_Bandittrader_Condition()
{
	if((Vatras_ToldAboutDuty == TRUE) || (SC_IsRanger == TRUE))
	{
		return TRUE;
	};
};


func void DIA_Addon_Vatras_Bandittrader_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_TellMe_Konkret_15_00");	//(frowning) And what does that mean in concrete terms?
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Konkret_05_01");	//The fall of the barrier has evoked numerous threats.
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Konkret_05_02");	//The bandits are probably the most obvious one.
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Konkret_05_03");	//Not only has it become all but impossible to travel the island without being attacked ...
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Konkret_05_04");	//... there's somebody in town, too, who supports the bandits!
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Add_05_00");	//We have found out that the bandits receive regular deliveries from a weapons merchant in Khorinis.
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Konkret_05_05");	//We try to find such people and keep them from endangering the city.
	AI_Output (self, other, "DIA_Addon_Vatras_TellMe_Konkret_05_06");	//If you can find out anything about this, let me know.
	MIS_Vatras_FindTheBanditTrader = LOG_Running;
	Log_CreateTopic(TOPIC_Addon_Bandittrader,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_Bandittrader,LOG_Running);
	B_LogEntries(TOPIC_Addon_Bandittrader,"There is a weapons dealer in Khorinis who is supporting the bandits. Vatras wants me to investigate the matter.");
	B_LogNextEntry(TOPIC_Addon_RingOfWater,"The 'Ring of Water' is taking care of the bandit problem in Khorinis.");
};


instance DIA_Addon_Vatras_WannaBeRanger(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_WannaBeRanger_Condition;
	information = DIA_Addon_Vatras_WannaBeRanger_Info;
	description = "I want to join the 'Ring of Water'!";
};


func int DIA_Addon_Vatras_WannaBeRanger_Condition()
{
	if(SC_KnowsRanger == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_WannaBeRanger_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_WannaBeRanger_15_00");	//I want to join the 'Ring of Water'!
	if (Npc_KnowsInfo (other, DIA_Addon_Cavalorn_Ring))
	{
		AI_Output (self, other, "DIA_Addon_Vatras_WannaBeRanger_05_01");	//You do? That means you have already fulfilled the first requirement.
		AI_Output (other, self, "DIA_Addon_Vatras_WannaBeRanger_15_02");	//What do you mean by that?
		AI_Output (self, other, "DIA_Addon_Vatras_WannaBeRanger_05_03");	//I mean that there must be someone among us who trusts you. Otherwise, you wouldn't even know about it.
	};
	if((Vatras_First == TRUE) && (Vatras_Second == TRUE) && (Vatras_Third == TRUE))
	{
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_01");	//Хорошо, давай подытожим:@@@
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_02");	//You are a former prisoner, ...
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_04");	//... who has been told by Xardas the necromancer ...
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_06");	//... that dragons have come to conquer the country.
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_08");	//And you have come to report this to the paladins ...
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_09");	//That all sounds rather fantastic, but I cannot perceive that you are lying to me.
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_10");	//Therefore I must assume that your motives are honorable.
		AI_Output(self,other,"DIA_ADDON_Vatras_INFLUENCE_REPEAT_05_11");	//I want to give you a chance to join the Ring of Water.
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Vatras_WannaBeRanger_05_04");	//But I know nothing about you at all ...
		AI_Output(other,self,"DIA_Vatras_INFLUENCE_15_04");	//What do you want to know?
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_05_05");	//Well, you could tell me where you come from and why you have come to the city.
		AI_Output(other,self,"DIA_Vatras_INFLUENCE_15_06");	//I carry an important message for the leader of the paladins.
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_05_07");	//What is this message?
		Info_ClearChoices(DIA_Addon_Vatras_WannaBeRanger);
		Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"Dragons have come ...",DIA_Vatras_INFLUENCE_FIRST_TRUTH);
		Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"Terrible things are bound to happen soon.",DIA_Vatras_INFLUENCE_FIRST_LIE);
	};
};

func void B_Vatras_First_Truth()
{
	AI_Output (other, self, "DIA_Vatras_INFLUENCE_FIRST_TRUTH_15_00");	//A large army is gathering as we talk, led by dragons and determined to conquer the country.
	if (Vatras_First == TRUE)
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_FIRST_TRUTH_05_01");	//If that is indeed true, the balance of the earth will be disturbed. Who told you this?
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_FIRST_TRUTH_05_02");	//(considering) Dragons? You speak of beings which, until now, have only been mentioned in legends. How do you know this?
	};
	Vatras_First = TRUE;
	if(Npc_KnowsInfo(other,DIA_Lothar_Dragons) && Wld_IsTime(5,5,20,10))
	{
		Player_TalkedAboutDragonsToSomeone = TRUE;
	};
};

func void B_Vatras_First_Lie()
{
	AI_Output (other, self, "DIA_Vatras_INFLUENCE_FIRST_LIE_15_00");	//Terrible things are bound to happen soon.
	if (Vatras_First == 2)
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_FIRST_LIE_05_01");	//(angry) Aha. And who has told you this?
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_FIRST_LIE_05_02");	//Terrible things, hm ... how do you know this?
	};
	Vatras_First = 2;
};

func void B_Vatras_Second_Truth()
{
	AI_Output (other, self, "DIA_Vatras_INFLUENCE_SECOND_TRUTH_15_00");	//Xardas the magician told me. He sent me to warn the paladins.
	if (Vatras_Second == TRUE)
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_SECOND_TRUTH_05_01");	//I know this man as a wise and mighty master of magic. And where do you come from?
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_SECOND_TRUTH_05_02");	//The necromancer ... So he lives ... (considers) and he sent you? Who are you really?
	};
	Vatras_Second = TRUE;
};

func void B_Vatras_Second_Lie()
{
	AI_Output (other, self, "DIA_Vatras_INFLUENCE_SECOND_LIE_15_00");	//Oh, I heard rumors somewhere ...
	if (Vatras_Second == 2)
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_SECOND_LIE_05_01");	//(annoyed) Do you at least remember where you come from?
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_SECOND_LIE_05_02");	//Aha. And that is why you have made this journey. Who are you really?
	};
	Vatras_Second = 2;
};

func void B_Vatras_Third_Truth()
{
	AI_Output(other,self,"DIA_Vatras_INFLUENCE_THIRD_TRUTH_15_00");	//I'm a former convict from the penal colony of Khorinis.
	Vatras_Third = TRUE;
};

func void B_Vatras_Third_Lie()
{
	AI_Output(other,self,"DIA_Vatras_INFLUENCE_THIRD_LIE_15_00");	//I'm just an adventurer from down south...
	Vatras_Third = FALSE;
};

func void B_Vatras_REPEAT()
{
	AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_01");	//Хорошо, давай подытожим:@@@
	if(Vatras_Third == TRUE)
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_REPEAT_05_02");	//You are a former prisoner, ...
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_REPEAT_05_03");	//You are an adventurer from down south ...
	};
	if(Vatras_Second == TRUE)
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_REPEAT_05_04");	//... who has been told by Xardas the necromancer ...
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_REPEAT_05_05");	//... who heard rumors ...
	};
	if(Vatras_First == TRUE)
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_REPEAT_05_06");	//... that dragons have come to conquer the country.
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_INFLUENCE_REPEAT_05_07");	//... that terrible things are going to happen.
	};
	AI_Output (self, other, "DIA_Vatras_INFLUENCE_REPEAT_05_08");	//And you have come to report this to the paladins ...
	if ((Vatras_First == TRUE) && (Vatras_Second == TRUE) && (Vatras_Third == TRUE))
	{
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_09");	//That all sounds rather fantastic, but I cannot perceive that you are lying to me.
	};
};

func void B_Vatras_PLEASEDONTLIE()
{
	AI_Output(self,other,"DIA_Vatras_Add_05_00");	//I think there's something you're not telling me.
	AI_Output (self, other, "DIA_Vatras_Add_05_01");	//If you're worried I might pass on what you tell me, then let me reassure you.
	AI_Output (self, other, "DIA_Vatras_Add_05_02");	//I have sworn to keep all secrets I am entrusted with to myself.
	if(Wld_IsTime(5,5,20,10))
	{
		AI_Output(other,self,"DIA_Vatras_Add_15_03");	//And what about all the people here?
		AI_Output(self,other,"DIA_Vatras_Add_05_04");	//They only understand half of what I PREACH to them. So don't fret.
	};
	AI_Output(self,other,"DIA_Vatras_Add_05_05");	//Let's start over at the beginning. What's that message?
};

func void B_Vatras_INFLUENCE_REPEAT()
{
	B_Vatras_REPEAT();
	if((Vatras_First == TRUE) && (Vatras_Second == TRUE) && (Vatras_Third == TRUE))
	{
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_10");	//Therefore I must assume that your motives are honorable.
		AI_Output(self,other,"DIA_ADDON_Vatras_INFLUENCE_REPEAT_05_11");	//I want to give you a chance to join the Ring of Water.
		Info_ClearChoices(DIA_Addon_Vatras_WannaBeRanger);
	}
	else
	{
		B_Vatras_PLEASEDONTLIE();
		Info_ClearChoices(DIA_Addon_Vatras_WannaBeRanger);
		Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"Dragons have come ...",DIA_Vatras_INFLUENCE_FIRST_TRUTH);
		Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"Terrible things are bound to happen soon.",DIA_Vatras_INFLUENCE_FIRST_LIE);
	};
};

func void DIA_Vatras_INFLUENCE_FIRST_TRUTH()
{
	B_Vatras_First_Truth();
	Info_ClearChoices(DIA_Addon_Vatras_WannaBeRanger);
	Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"Oh, I heard rumors somewhere...",DIA_Vatras_INFLUENCE_SECOND_LIE);
	Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"Xardas the magician told me.",DIA_Vatras_INFLUENCE_SECOND_TRUTH);
};

func void DIA_Vatras_INFLUENCE_FIRST_LIE()
{
	B_Vatras_First_Lie();
	Info_ClearChoices(DIA_Addon_Vatras_WannaBeRanger);
	Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"Oh, I heard rumors somewhere...",DIA_Vatras_INFLUENCE_SECOND_LIE);
	Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"Xardas the magician told me. He sent me to warn the paladins.",DIA_Vatras_INFLUENCE_SECOND_TRUTH);
};

func void DIA_Vatras_INFLUENCE_SECOND_TRUTH()
{
	B_Vatras_Second_Truth();
	Info_ClearChoices(DIA_Addon_Vatras_WannaBeRanger);
	Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"I'm an adventurer from down south...",DIA_Vatras_INFLUENCE_THIRD_LIE);
	Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"I'm a former convict...",DIA_Vatras_INFLUENCE_THIRD_TRUTH);
};

func void DIA_Vatras_INFLUENCE_SECOND_LIE()
{
	B_Vatras_Second_Lie();
	Info_ClearChoices(DIA_Addon_Vatras_WannaBeRanger);
	Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"I'm an adventurer from down south...",DIA_Vatras_INFLUENCE_THIRD_LIE);
	Info_AddChoice(DIA_Addon_Vatras_WannaBeRanger,"I'm a former convict...",DIA_Vatras_INFLUENCE_THIRD_TRUTH);
};

func void DIA_Vatras_INFLUENCE_THIRD_TRUTH()
{
	B_Vatras_Third_Truth();
	B_Vatras_INFLUENCE_REPEAT();
};

func void DIA_Vatras_INFLUENCE_THIRD_LIE()
{
	B_Vatras_Third_Lie();
	B_Vatras_INFLUENCE_REPEAT();
};

instance DIA_Addon_Vatras_HowToJoin(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 5;
	condition = DIA_Addon_Vatras_HowToJoin_Condition;
	information = DIA_Addon_Vatras_HowToJoin_Info;
	description = "What must I do in order to join the Ring?";
};


func int DIA_Addon_Vatras_HowToJoin_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Vatras_WannaBeRanger))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_HowToJoin_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_HowToJoin_15_00");	//What must I do in order to join the Ring?
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_05_01");	//Know that you take on great responsibility by joining the ring.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_05_02");	//I do not let just anyone join who comes to us and asks.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_05_03");	//If you want to join the Ring, you will have to prove that you act like one of us.
	AI_Output (other, self, "DIA_Addon_Vatras_HowToJoin_15_04");	//And that means?
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_05_05");	//Before we let a young man join our ranks, he must have done a great deed for the Ring.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_05_06");	//Only then can I begin to consider letting you help preserve the balance of forces on this island.
	Info_ClearChoices (DIA_Addon_Vatras_HowToJoin);
	Info_AddChoice (DIA_Addon_Vatras_HowToJoin, "So what would be an appropriate deed that might convince you?", DIA_Addon_Vatras_HowToJoin_WhatsGreat);
	Info_AddChoice (DIA_Addon_Vatras_HowToJoin, "I have freed many people. The barrier is gone.", DIA_Addon_Vatras_HowToJoin_FreedMen);
	Info_AddChoice (DIA_Addon_Vatras_HowToJoin, "I have vanquished the Sleeper. Isn't that a great enough deed?", DIA_Addon_Vatras_HowToJoin_Sleeper);
};

func void DIA_Addon_Vatras_HowToJoin_Sleeper()
{
	AI_Output (other, self, "DIA_Addon_Vatras_HowToJoin_Sleeper_15_00");	//I have vanquished the Sleeper. Isn't that a great enough deed?
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_Sleeper_05_01");	//My ears hear many a tale these days.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_Sleeper_05_02");	//Including the story about the banning of the beast called Sleeper.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_Sleeper_05_03");	//I have not heard that this was achieved by a single man, although your eyes tell me that you are convinced you did this.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_Sleeper_05_04");	//That confuses me slightly, but I cannot be sure that my senses might not deceive me sometimes.
};

func void DIA_Addon_Vatras_HowToJoin_FreedMen()
{
	AI_Output (other, self, "DIA_Addon_Vatras_WannaBeRanger_FreedMen_15_00");	//I have freed many people. The barrier is gone.
	AI_Output (self, other, "DIA_Addon_Vatras_WannaBeRanger_FreedMen_05_01");	//Even if you can REALLY claim responsibility for that ...
	AI_Output (self, other, "DIA_Addon_Vatras_WannaBeRanger_FreedMen_05_02");	//The great event in the Valley of Mines has not only set free the Water Mages and other upright citizens.
	AI_Output (self, other, "DIA_Addon_Vatras_WannaBeRanger_FreedMen_05_03");	//All the criminals of the entire country are roaming Khorinis these days, harassing the population.
	AI_Output (self, other, "DIA_Addon_Vatras_WannaBeRanger_FreedMen_05_04");	//The bandits have already taken over large areas of land outside of the city. It has become all but impossible to leave the town and return unharmed.
};

func void DIA_Addon_Vatras_HowToJoin_WhatsGreat()
{
	AI_Output (other, self, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_15_00");	//So what would be an appropriate deed that might convince you?
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_05_01");	//Khorinis is facing a great enigma these days.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_05_02");	//The number of people missing from the town seems to increase almost daily.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_05_03");	//If you can explain to me what happened to them, you shall have your place within the 'Ring of Water'.
	Log_CreateTopic (TOPIC_Addon_RingOfWater, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_RingOfWater, LOG_Running);
	B_LogEntry (TOPIC_Addon_RingOfWater, LogText_Addon_KDWRight);
	B_LogEntry (TOPIC_Addon_RingOfWater, "Vatras is only going to let me join the 'Ring of Water' if I find out first where the missing people are.");
	if (SC_HearedAboutMissingPeople == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
		B_LogEntry(TOPIC_Addon_WhoStolePeople,LogText_Addon_SCKnowsMisspeapl);
	};
	MIS_Addon_Vatras_WhereAreMissingPeople = LOG_Running;
	SC_HearedAboutMissingPeople = TRUE;
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_05_04");	//However ...
	AI_Output (other, self, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_15_05");	//Yes?
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_05_06");	//... you should take your message to the paladins first.
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_05_07");	//I consider it a matter of utmost importance!
	AI_Output (self, other, "DIA_Addon_Vatras_HowToJoin_WhatsGreat_05_08");	//Talk to Lord Hagen.
	Player_KnowsLordHagen = TRUE;
	B_LogEntry (TOPIC_Addon_RingOfWater, "Vatras wants me to take an important message to Lord Hagen.");
	Info_ClearChoices(DIA_Addon_Vatras_HowToJoin);
};


instance DIA_Addon_Vatras_GuildBypass(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 1;
	condition = DIA_Addon_Vatras_GuildBypass_Condition;
	information = DIA_Addon_Vatras_GuildBypass_Info;
	description = "But Lord Hagen is not going to receive me!";
};


func int DIA_Addon_Vatras_GuildBypass_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Vatras_HowToJoin) && ((other.guild == GIL_NONE) || (other.guild == GIL_NOV)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_GuildBypass_Info()
{
	AI_Output(other,self,"DIA_Addon_Vatras_GuildBypass_15_00");	//But Lord Hagen is not going to receive me!
	if(other.guild == GIL_NOV)
	{
		AI_Output(self,other,"DIA_Vatras_PERMKAP3_05_02");	//Speak to Pyrokar, he will explain everything else to you.
	}
	else
	{
	AI_Output (self, other, "DIA_Addon_Vatras_GuildBypass_05_01");	//Yes, he will, no doubt about it. PROVIDED you become a member of a powerful community first.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildBypass_05_02");	//The Ring has far-reaching connections.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildBypass_05_03");	//We shall assist you in conveying your message as soon as possible.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildBypass_05_04");	//You should talk about this to Lares, whom I trust. He will help you.
	B_LogEntry (TOPIC_Addon_RingOfWater, "In order to get through to see Lord Hagen, I must join one of the powerful communities in Khorinis.");
		Info_ClearChoices(DIA_Addon_Vatras_GuildBypass);
		Info_AddChoice(DIA_Addon_Vatras_GuildBypass,"I shall do that.",DIA_Addon_Vatras_GuildBypass_BACK);
		Info_AddChoice(DIA_Addon_Vatras_GuildBypass,"What community should I join?",DIA_Addon_Vatras_GuildBypass_WhichGuild);
	};
};

func void DIA_Addon_Vatras_GuildBypass_BACK()
{
	AI_Output (other, self, "DIA_Addon_Vatras_GuildBypass_BACK_15_00");	//I shall do that.
	Vatras_GehZuLares = TRUE;
	Info_ClearChoices(DIA_Addon_Vatras_GuildBypass);
};

func void DIA_Addon_Vatras_GuildBypass_WhichGuild()
{
	AI_Output (other, self, "DIA_Addon_Vatras_GuildBypass_WhichGuild_15_00");	//What community should I join?
	AI_Output (self, other, "DIA_Addon_Vatras_GuildBypass_WhichGuild_05_01");	//There are only three communities that have enough influence.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildBypass_WhichGuild_05_02");	//These are: the city militia, the monastery of the Fire Magicians, and the troop of mercenaries on the landowner's farm.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildBypass_WhichGuild_05_03");	//The choice is yours, son.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildBypass_WhichGuild_05_04");	//Lares can certainly assist you with this difficult decision. Talk to him about it.
	B_LogEntry (TOPIC_Addon_RingOfWater, "Powerful communities include the FIRE MAGICIANS, the MILITIA and the MERCENARIES on the landowner's farm.");
	Info_ClearChoices (DIA_Addon_Vatras_GuildBypass);
	Info_AddChoice (DIA_Addon_Vatras_GuildBypass, "I shall do that.", DIA_Addon_Vatras_GuildBypass_BACK);
};


instance DIA_Addon_Vatras_NowRanger(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 5;
	condition = DIA_Addon_Vatras_NowRanger_Condition;
	information = DIA_Addon_Vatras_NowRanger_Info;
	permanent = TRUE;
	description = "I am ready to join the Ring of Water!";
};


func int DIA_Addon_Vatras_NowRanger_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Vatras_HowToJoin) && (SC_IsRanger == FALSE) && (MIS_Addon_Vatras_WhereAreMissingPeople == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_NowRanger_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_NowRanger_15_00");	//I am ready to join the Ring of Water!
	AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_01");	//So you delivered your message to Lord Hagen?
	if (Kapitel >= 2)
	{
		AI_Output (other, self, "DIA_Addon_Vatras_NowRanger_15_02");	//Yes.
		if (MIS_OLDWORLD != LOG_SUCCESS)
		{
			AI_Output (other, self, "DIA_Addon_Vatras_NowRanger_15_03");	//But he sent me to the Valley of Mines so I could get him proof for my words!
			AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_04");	//YOU must decide what you want to do next.
			AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_05");	//To me, it was important that he should get the message. Now it's up to him to act, or to wait for your proof.
			AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_06");	//As far as you are concerned ...
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_07");	//Good.
		};
		AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_08");	//You have proven that you are indispensable to us. You shall be one of our children and go forth into the world in our name to do the bidding of Adanos.
		AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_09");	//I consign to you this Ring of Water. May it help you find your allies and, together with them, preserve the balance of this world.
		CreateInvItems (self, ItRi_Ranger_Addon, 1);
		B_GiveInvItems (self, other, ItRi_Ranger_Addon, 1);
		if (hero.guild == GIL_KDF)
		{
			AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_10");	//You are the first Fire Magician among our children. I am especially happy about that.
		};
		AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_11");	//May Adanos protect you. And now go and meet your brothers.
		AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_12");	//They will await you in the tavern 'The Dead Harpy' and accept you into our community.
		AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_13");	//You probably know the tavern. It lies on the way to Onar's farm.
		AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_14");	//Do not forget to wear your ring, so your brothers will recognize you as one of their own.
		B_LogEntry (TOPIC_Addon_RingOfWater, "I now belong to the 'Ring of Water', and I am to meet my brothers in the 'Dead Harpy' tavern.");
		SC_IsRanger = TRUE;
		Lares_CanBringScToPlaces = TRUE;
		MIS_Addon_Lares_ComeToRangerMeeting = LOG_Running;
		B_GivePlayerXP(XP_Addon_SC_IsRanger);
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Vatras_NowRanger_15_15");	//No. Not yet.
		AI_Output (self, other, "DIA_Addon_Vatras_NowRanger_05_16");	//Make haste, then. Go to him. I think your message is very important!
	};
};


instance DIA_Addon_Vatras_CloseMeeting(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 5;
	condition = DIA_Addon_Vatras_CloseMeeting_Condition;
	information = DIA_Addon_Vatras_CloseMeeting_Info;
	description = "The brothers of the 'Ring' have sent me to you.";
};


func int DIA_Addon_Vatras_CloseMeeting_Condition()
{
	if(Lares_TakeFirstMissionFromVatras == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_CloseMeeting_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_CloseMeeting_15_00");	//The brothers of the 'Ring' have sent me to you.
	AI_Output (self, other, "DIA_Addon_Vatras_CloseMeeting_05_01");	//Good! I've been awaiting you!
	AI_Output (self, other, "DIA_Addon_Vatras_CloseMeeting_05_02");	//I shall send you through the portal together with the other Water Mages.
	AI_Output (self, other, "DIA_Addon_Vatras_CloseMeeting_05_03");	//You are to track down the former ore baron Raven and find out why he has taken the citizens of Khorinis.
	AI_Output (self, other, "DIA_Addon_Vatras_CloseMeeting_05_04");	//We here shall continue to try and deal with the threat posed by the bandits.
	AI_Output (self, other, "DIA_Addon_Vatras_CloseMeeting_05_05");	//Bring this letter to Saturas. He will set your tasks from now on.
	if((MIS_Addon_Lares_Ornament2Saturas != LOG_SUCCESS) && (Kapitel < 3))
	{
		AI_Output (self, other, "DIA_Addon_Vatras_CloseMeeting_05_08");	//Lares will take you to him if he hasn't already delivered the ornament.
	};
	CreateInvItems (self, ItWr_Vatras2Saturas_FindRaven, 1);
	B_GiveInvItems (self, other, ItWr_Vatras2Saturas_FindRaven, 1);
	AI_Output (self, other, "DIA_Addon_Vatras_CloseMeeting_05_06");	//May Adanos guide you.
	B_LogEntry (TOPIC_Addon_KDW, "Vatras gave me a letter to take to Saturas. I am supposed to go through the portal with the other Water Mages and follow the trail of the former ore baron Raven.");
	Log_CreateTopic (TOPIC_Addon_Sklaven, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Sklaven, LOG_Running);
	B_LogEntry (TOPIC_Addon_Sklaven, "I am to find out why Raven captured the citizens of Khorinis.");
	RangerMeetingRunning = LOG_SUCCESS;
	B_SchlussMitRangerMeeting();
	B_GivePlayerXP(XP_AmbientKap3);
	SC_KnowsPortal = TRUE;
};


var int MISSINGPEOPLEINFO[20];

instance DIA_Addon_Vatras_MissingPeople(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_MissingPeople_Condition;
	information = DIA_Addon_Vatras_MissingPeople_Info;
	permanent = TRUE;
	description = "About the missing people...";
};


func int DIA_Addon_Vatras_MissingPeople_Condition()
{
	if(MIS_Addon_Vatras_WhereAreMissingPeople == LOG_Running)
	{
		return TRUE;
	};
};


var int DIA_Addon_Vatras_MissingPeople_Wo_NoPerm;

func void DIA_Addon_Vatras_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_MissingPeople_15_00");	//About those missing people ...
	AI_Output (self, other, "DIA_Addon_Vatras_MissingPeople_05_01");	//Yes?
	Info_ClearChoices(DIA_Addon_Vatras_MissingPeople);
	Info_AddChoice(DIA_Addon_Vatras_MissingPeople,Dialog_Back,DIA_Addon_Vatras_MissingPeople_BACK);
	Info_AddChoice(DIA_Addon_Vatras_MissingPeople,"Let me tell you what I know...",DIA_Addon_Vatras_MissingPeople_Report);
	if(SCKnowsMissingPeopleAreInAddonWorld == TRUE)
	{
		Info_AddChoice(DIA_Addon_Vatras_MissingPeople,"I know where they are!",DIA_Addon_Vatras_MissingPeople_Success);
	};
	if((DIA_Addon_Vatras_MissingPeople_Wo_NoPerm == FALSE) && (SCKnowsMissingPeopleAreInAddonWorld == FALSE))
	{
		Info_AddChoice(DIA_Addon_Vatras_MissingPeople,"Where should I start looking for them?",DIA_Addon_Vatras_MissingPeople_Wo);
	};
};

func void DIA_Addon_Vatras_MissingPeople_BACK()
{
	Info_ClearChoices(DIA_Addon_Vatras_MissingPeople);
};

func void DIA_Addon_Vatras_MissingPeople_Wo()
{
	AI_Output (other, self, "DIA_Addon_Vatras_HintMissingPeople_Wo_15_00");	//Where should I start looking for them?
	AI_Output (self, other, "DIA_Addon_Vatras_HintMissingPeople_Wo_05_01");	//Most of those people disappeared down by the harbor. That's probably where you should start your search.
	Log_CreateTopic (TOPIC_Addon_WhoStolePeople, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_WhoStolePeople, LOG_Running);
	B_LogEntry (TOPIC_Addon_WhoStolePeople, "Most people went missing by the harbor in Khorinis. That's where I am to start my search.");
	DIA_Addon_Vatras_MissingPeople_Wo_NoPerm = TRUE;
};

func void DIA_Addon_Vatras_MissingPeople_Report()
{
	var int Vatras_MissingPeopleReports;
	var int XP_Vatras_MissingPeopleReports;
	Vatras_MissingPeopleReports = 0;
	AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_00");	//Let me tell you what I know ...
	if(((MIS_Akil_BringMissPeopleBack != FALSE) || (MIS_Bengar_BringMissPeopleBack != FALSE)) && (MISSINGPEOPLEINFO[1] == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_01");	//The farmers have lost some people as well.
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[1] = TRUE;
	};
	if(((Elvrich_GoesBack2Thorben == TRUE) || (Elvrich_SCKnowsPirats == TRUE) || (SC_KnowsDexterAsKidnapper == TRUE)) && (MISSINGPEOPLEINFO[2] == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_02");	//I have found out that the bandits are responsible for the disappearances here.
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[2] = TRUE;
	};
	if((Elvrich_SCKnowsPirats == TRUE) && (MISSINGPEOPLEINFO[3] == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_03");	//Elvrich, Master Thorben's apprentice, told me that the bandits take the kidnapped people out of Khorinis by sea.
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[3] = TRUE;
	};
	if((Elvrich_SCKnowsPirats == TRUE) && (MISSINGPEOPLEINFO[4] == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_04");	//Some pirates are involved in this somehow. I haven't quite figured out their role yet.
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[4] = TRUE;
	};
	if((Elvrich_GoesBack2Thorben == TRUE) && (MISSINGPEOPLEINFO[5] == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_05");	//I rescued Elvrich from the bandits.
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[5] = TRUE;
	};
	if((SC_KnowsLuciaCaughtByBandits == TRUE) && (MISSINGPEOPLEINFO[6] == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_06");	//The bandits dragged off a girl named Lucia.
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[6] = TRUE;
	};
	if(((MIS_LuciasLetter == LOG_Running) || (MIS_LuciasLetter == LOG_SUCCESS)) && (MISSINGPEOPLEINFO[7] == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_07");	//Lucia, the girl that was kidnapped by the bandits, has decided to join them.
		if(MIS_LuciasLetter == LOG_SUCCESS)
		{
			AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Report_15_08");	//It certainly looks like she did this out of her own free will.
		};
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[7] = TRUE;
	};
	if((SC_KnowsDexterAsKidnapper == TRUE) && (MISSINGPEOPLEINFO[8] == FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Vatras_MissingPeople_Report_15_09");	//The leader of the bandits is named Dexter. He is responsible for the kidnappings.
		AI_Output (other, self, "DIA_Addon_Vatras_MissingPeople_Report_15_10");	//I knew Dexter back in the penal colony. He was working for the ore baron Gomez then.
		AI_Output (self, other, "DIA_Addon_Vatras_MissingPeople_Report_05_11");	//He will certainly remember you. You should be careful.
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[8] = TRUE;
	};
	if(Vatras_MissingPeopleReports != 0)
	{
		AI_Output (self, other, "DIA_Addon_Vatras_MissingPeople_Report_05_12");	//I think you're on the right track. Carry on.
		XP_Vatras_MissingPeopleReports = XP_Addon_Vatras_MissingPeopleReport * Vatras_MissingPeopleReports;
		B_GivePlayerXP(XP_Vatras_MissingPeopleReports);
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Vatras_MissingPeople_Report_05_13");	//What have you found out?
		DIA_Common_NothingImportantYet();
	};
};

func void DIA_Addon_Vatras_MissingPeople_Success()
{
	var int Vatras_MissingPeopleReports;
	var int XP_Vatras_MissingPeopleReports;
	AI_Output (other, self, "DIA_Addon_Vatras_MissingPeople_Success_15_00");	//I know where the missing people are.
	AI_Output (self, other, "DIA_Addon_Vatras_MissingPeople_Success_05_01");	//What have you found out?
	AI_Output (other, self, "DIA_Addon_Vatras_MissingPeople_Success_15_02");	//A man named Raven dragged them off to a remote part of Khorinis.
	AI_Output (self, other, "DIA_Addon_Vatras_MissingPeople_Success_05_03");	//What makes you so sure?
	AI_Output (other, self, "DIA_Addon_Vatras_MissingPeople_Success_15_04");	//I read his orders. He's got the local bandits working for him.
	if(Npc_HasItems(other,ItWr_RavensKidnapperMission_Addon))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_MissingPeople_Success_15_05");	//Here.
		B_GiveInvItems(other,self,ItWr_RavensKidnapperMission_Addon,1);
		B_UseFakeScroll();
	};
	AI_Output (self, other, "DIA_Addon_Vatras_MissingPeople_Success_05_06");	//Good. You did a great job. I had feared that we might have to resign ourselves to never knowing.
	MIS_Addon_Vatras_WhereAreMissingPeople = LOG_SUCCESS;
	MIS_Steckbriefe = LOG_SUCCESS;
	Vatras_MissingPeopleReports = 0;
	if(((MIS_Akil_BringMissPeopleBack != FALSE) || (MIS_Bengar_BringMissPeopleBack != FALSE)) && (MISSINGPEOPLEINFO[1] == FALSE))
	{
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[1] = TRUE;
	};
	if(((Elvrich_GoesBack2Thorben == TRUE) || (Elvrich_SCKnowsPirats == TRUE) || (SC_KnowsDexterAsKidnapper == TRUE)) && (MISSINGPEOPLEINFO[2] == FALSE))
	{
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[2] = TRUE;
	};
	if((Elvrich_SCKnowsPirats == TRUE) && (MISSINGPEOPLEINFO[3] == FALSE))
	{
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[3] = TRUE;
	};
	if((Elvrich_SCKnowsPirats == TRUE) && (MISSINGPEOPLEINFO[4] == FALSE))
	{
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[4] = TRUE;
	};
	if((Elvrich_GoesBack2Thorben == TRUE) && (MISSINGPEOPLEINFO[5] == FALSE))
	{
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[5] = TRUE;
	};
	if((SC_KnowsLuciaCaughtByBandits == TRUE) && (MISSINGPEOPLEINFO[6] == FALSE))
	{
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[6] = TRUE;
	};
	if((Npc_HasItems(other,ItWr_LuciasLoveLetter_Addon) || (MIS_LuciasLetter == LOG_SUCCESS)) && (MISSINGPEOPLEINFO[7] == FALSE))
	{
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[7] = TRUE;
	};
	if((SC_KnowsDexterAsKidnapper == TRUE) && (MISSINGPEOPLEINFO[8] == FALSE))
	{
		Vatras_MissingPeopleReports += 1;
		MISSINGPEOPLEINFO[8] = TRUE;
	};
	XP_Vatras_MissingPeopleReports = XP_Addon_Vatras_MissingPeopleReport * Vatras_MissingPeopleReports;
	XP_Vatras_MissingPeopleReports += XP_Addon_Vatras_WhereAreMissingPeople;
	B_GivePlayerXP(XP_Vatras_MissingPeopleReports);
};


instance DIA_Addon_Vatras_Free(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_Free_Condition;
	information = DIA_Addon_Vatras_Free_Info;
	permanent = FALSE;
	description = "The missing people are back!";
};


func int DIA_Addon_Vatras_Free_Condition()
{
	if(MissingPeopleReturnedHome == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_Free_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Free_15_00");	//The missing people have come back.
	AI_Output (self, other, "DIA_Addon_Vatras_Free_05_01");	//Yes, you did it. Their journey has come to a good end.
	AI_Output (self, other, "DIA_Addon_Vatras_Free_05_02");	//But your own journey must go on. So go with the blessing of Adanos.
	AI_Output (self, other, "DIA_Addon_Vatras_Free_05_03");	//(praying) Adanos, bless this man. Light his path and grant him the strength to withstand all dangers.
	B_RaiseAttribute (other, ATR_MANA_MAX, 3);
	other.attribute[ATR_MANA] = other.attribute[ATR_MANA_MAX];
	other.attribute[ATR_HITPOINTS] = other.attribute[ATR_HITPOINTS_MAX];
	Snd_Play("LEVELUP");
};


instance DIA_Addon_Vatras_Waffen(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_Waffen_Condition;
	information = DIA_Addon_Vatras_Waffen_Info;
	permanent = TRUE;
	description = "About this weapons dealer...";
};


func int DIA_Addon_Vatras_Waffen_Condition()
{
	if(MIS_Vatras_FindTheBanditTrader == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_Waffen_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Waffen_15_00");	//About this weapons dealer ...
	Info_ClearChoices (DIA_Addon_Vatras_Waffen);
	Info_AddChoice (DIA_Addon_Vatras_Waffen, Dialog_Back, DIA_Addon_Vatras_Waffen_BACK);
	if ((Fernando_ImKnast == TRUE) || (Fernando_HatsZugegeben == TRUE))
	{
		Info_AddChoice (DIA_Addon_Vatras_Waffen, "I know the dealer who's been selling weapons to the bandits!", DIA_Addon_Vatras_Waffen_Success);
	}
	else
	{
		Info_AddChoice (DIA_Addon_Vatras_Waffen, "What do you know about the weapons dealer so far?", DIA_Addon_Vatras_Waffen_ToMartin);
	};
};

func void DIA_Addon_Vatras_Waffen_BACK()
{
	Info_ClearChoices(DIA_Addon_Vatras_Waffen);
};

func void DIA_Addon_Vatras_Waffen_ToMartin()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Waffen_ToMartin_15_00");	//How much do you know about the weapons dealer?
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_ToMartin_05_01");	//Ask Martin, the provisions master of the paladins, about this. He should be able to tell you more.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_ToMartin_05_02");	//He has been tasked with unmasking the weapons dealer.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_ToMartin_05_03");	//You can find Martin in the harbor district. If you see a heap of crates, provisions and paladins, Martin won't be far.
	if(Vatras_ToMartin == FALSE)
	{
		B_LogEntry(TOPIC_Addon_Bandittrader,"Martin, the paladins' provision master, is looking into the business with the weapons dealer. I can find him down by the harbor where the paladins store their supplies.");
	};
	Vatras_ToMartin = TRUE;
};

func void DIA_Addon_Vatras_Waffen_Success()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Waffen_Success_15_00");	//I know the dealer who's been selling weapons to the bandits!
	AI_Output (other, self, "DIA_Addon_Vatras_Waffen_Success_15_01");	//His name is Fernando.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_Success_05_02");	//Very good. Has Martin taken the necessary steps to stop him from delivering any more?
	if (Fernando_ImKnast == TRUE)
	{
		AI_Output (other, self, "DIA_Addon_Vatras_Waffen_Success_15_03");	//Yes. Martin will see to it that he won't be leaving the dungeon any time soon.
		AI_Output (self, other, "DIA_Addon_Vatras_Waffen_Success_05_04");	//Well done, son.
		if (Npc_KnowsInfo (other, DIA_Addon_Vatras_WannaBeRanger) && (SC_IsRanger == FALSE))
		{
			AI_Output (other, self, "DIA_Addon_Vatras_Waffen_Success_15_05");	//(cheekily) Does that mean that you're going to let me join the 'Ring of Water' now?
			AI_Output (self, other, "DIA_Addon_Vatras_Waffen_Success_05_06");	//(smiles) THAT was not what we agreed upon - and you know it.
		};
		AI_Output (self, other, "DIA_Addon_Vatras_Waffen_Success_05_07");	//May Adanos light your path.
		MIS_Vatras_FindTheBanditTrader = LOG_SUCCESS;
		B_GivePlayerXP(XP_Addon_Vatras_FindTheBanditTrader);
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Vatras_CaughtFernando_15_09");	//Not yet.
		AI_Output (self, other, "DIA_Addon_Vatras_CaughtFernando_05_10");	//Then make haste and report to him at once. It must be stopped right now.
		Vatras_ToMartin = TRUE;
	};
};


instance DIA_Addon_Vatras_WISP(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 5;
	condition = DIA_Addon_Vatras_WISP_Condition;
	information = DIA_Addon_Vatras_WISP_Info;
	description = "Is there anything that could help me with my search?";
};


func int DIA_Addon_Vatras_WISP_Condition()
{
	if(MIS_Vatras_FindTheBanditTrader != FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_WISP_Info()
{
	AI_Output(other,self,"DIA_Addon_Vatras_Waffen_WISP_15_00");	//Is there anything that could help me with my search?
	if((MIS_Vatras_FindTheBanditTrader == LOG_Running) || (MIS_Vatras_FindTheBanditTrader == LOG_FAILED))
	{
		AI_Output(self,other,"DIA_Addon_Vatras_Waffen_WISP_05_01");	//You are very persistent, young man. But I actually can think of something that could make your tasks easier for you.
	};
	AI_Output(self,other,"DIA_Addon_Vatras_Waffen_WISP_05_02");	//I shall give you this ore amulet. You'll certainly be able to use it.
	CreateInvItems(self,ItAm_Addon_WispDetector,1);
	B_GiveInvItems(self,other,ItAm_Addon_WispDetector,1);
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_WISP_05_03");	//It is an amulet of the searching will-o'-the-wisps.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_WISP_05_04");	//There are only very few of them. The will-o'-the-wisp that inhabits this amulet has very special properties.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_WISP_05_05");	//It can help you find things that normally elude the naked eye.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_WISP_05_06");	//You summon it by simply wearing the amulet.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_WISP_05_07");	//If it loses its power or you cannot find it, simply put on the amulet again, and it will reappear.
	B_LogEntry (TOPIC_Addon_Bandittrader, "Vatras gave me an 'amulet of the searching will-o'-the-wisp' to help me in my search for the weapons dealer.");
	Log_CreateTopic(TOPIC_WispDetector,LOG_NOTE);
	B_LogEntry(TOPIC_WispDetector,LogText_Addon_WispLearned);
	B_LogEntry(TOPIC_WispDetector,LogText_Addon_WispLearned_NF);
	AI_Output(self,other,"DIA_Addon_Vatras_Waffen_WISP_05_08");	//The will-o'-the-wisp can detect weapons.
	if((MIS_Vatras_FindTheBanditTrader == LOG_Running) || (MIS_Vatras_FindTheBanditTrader == LOG_FAILED))
	{
		AI_Output(self,other,"DIA_Addon_Vatras_Waffen_WISP_05_09");	//It could be very helpful to you in investigating the weapons deliveries to the bandits.
	};
	AI_Output(self,other,"DIA_Addon_Vatras_Waffen_WISP_05_10");	//Treat it well, and it will never fail you.
	Info_ClearChoices(DIA_Addon_Vatras_WISP);
	Info_AddChoice(DIA_Addon_Vatras_WISP,"Thank you! I shall take good care of it.",DIA_Addon_Vatras_WISP_Thanks);
	Info_AddChoice(DIA_Addon_Vatras_WISP,"Can the will-o'-the-wisp do more than that?",DIA_Addon_Vatras_WISP_MoreWISP);
	Info_AddChoice(DIA_Addon_Vatras_WISP,"A will-o'-the-wisp in an amulet?",DIA_Addon_Vatras_WISP_Amulett);
	SC_GotWisp = TRUE;
};

func void DIA_Addon_Vatras_WISP_Thanks()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Waffen_Thanks_15_00");	//Thank you! I shall take good care of it.
	Info_ClearChoices (DIA_Addon_Vatras_WISP);
};

func void DIA_Addon_Vatras_WISP_MoreWISP()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Waffen_MoreWISP_15_00");	//Can the will-o'-the-wisp do more than that?
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_MoreWISP_05_01");	//More than look for close-combat weapons? Not unless you teach it.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_MoreWISP_05_02");	//I think Riordian knows how to teach these beings. He is one of us, currently traveling with Saturas.
	AI_Output (self, other, "DIA_Addon_Vatras_Waffen_MoreWISP_05_03");	//Perhaps he can tell you more.
	if (MIS_Vatras_FindTheBanditTrader == LOG_Running)
	{
		B_LogEntry (TOPIC_Addon_Bandittrader, "My searching will-o'-the-wisp can do more than just find close-combat weapons. Riordian the Water Mage can teach it to look for other things as well.");
	};
};

func void DIA_Addon_Vatras_WISP_Amulett()
{
	AI_Output (other, self, "DIA_Addon_Vatras_WISPDETECTOR_was_15_00");	//A will-o'-the-wisp in an amulet?
	AI_Output (self, other, "DIA_Addon_Vatras_WISPDETECTOR_was_05_01");	//Will-o'-the-wisps are admirable creatures. They consist of pure magical energy.
	AI_Output (self, other, "DIA_Addon_Vatras_WISPDETECTOR_was_05_02");	//They are bound to the magical ore in this world. It is their origin. It gives them their strength.
	AI_Output (self, other, "DIA_Addon_Vatras_WISPDETECTOR_was_05_03");	//I am not surprised that you have never heard of them. They only appear to the person who bears the ore to which they belong.
	AI_Output (self, other, "DIA_Addon_Vatras_WISPDETECTOR_was_05_04");	//Will-o'-the-wisps living in the wild have been forcefully removed from their sources. They will attack anyone who approaches them.
	AI_Output (self, other, "DIA_Addon_Vatras_WISPDETECTOR_was_05_05");	//There is no way to help those pitiful creatures. You had better stay away from them.
};


instance DIA_Addon_Vatras_Stoneplate(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 5;
	condition = DIA_Addon_Vatras_Stoneplate_Condition;
	information = DIA_Addon_Vatras_Stoneplate_Info;
	description = "I've got this stone tablet...";
};


func int DIA_Addon_Vatras_Stoneplate_Condition()
{
	if(C_ScHasMagicStonePlate() || Npc_HasItems(other,ItWr_StonePlateCommon_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_Stoneplate_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_Stoneplate_15_00");	//I've got this stone tablet. Can you tell me more about it?
	AI_Output (self, other, "DIA_Addon_Vatras_Stoneplate_05_01");	//Those are artifacts from the old culture which we have been investigating for some time.
	AI_Output (self, other, "DIA_Addon_Vatras_Stoneplate_05_02");	//There are several kinds of them. Some contain information about the history of the ancient people.
	AI_Output (self, other, "DIA_Addon_Vatras_Stoneplate_05_03");	//And that is the kind I am interested in. Bring me all of those that you can find.
	AI_Output (self, other, "DIA_Addon_Vatras_Stoneplate_05_04");	//I shall give you an appropriate reward.
	if(TOPIC_End_Stoneplates == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_Stoneplates,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_Stoneplates,LOG_Running);
	};
	if(Erol_AskedKDW == FALSE)
	{
		B_LogEntries(TOPIC_Addon_Stoneplates,LogText_Addon_VatrasTrade);
		if(CurrentLevel != DRAGONISLAND_ZEN)
		{
			Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
			B_LogNextEntry(TOPIC_CityTrader,LogText_Addon_VatrasTrade);
		}
		else
		{
			B_LogNextEntry(TOPIC_MyCrew,"Vatras is interested in these stone tablets.");
		};
	}
	else
	{
		B_LogEntry(TOPIC_Addon_Stoneplates,LogText_Addon_VatrasTrade);
	};
};


instance DIA_Addon_Vatras_SellStonplate(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 5;
	condition = DIA_Addon_Vatras_SellStonplate_Condition;
	information = DIA_Addon_Vatras_SellStonplate_Info;
	permanent = TRUE;
	description = "I've got more stone tablets for you...";
};


func int DIA_Addon_Vatras_SellStonplate_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Addon_Vatras_Stoneplate) || Npc_KnowsInfo(other,DIA_Addon_Vatras_DI_Stoneplate)) && Npc_HasItems(other,ItWr_StonePlateCommon_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_SellStonplate_Info()
{
	var int anzahl;
	anzahl = Npc_HasItems(other,ItWr_StonePlateCommon_Addon);
	TotalStoneplatesForVatras += anzahl;
	AI_Output(other,self,"DIA_Addon_Vatras_SellStonplate_15_00");	//I've got another stone tablet for you...
	if((TotalStoneplatesForVatras > 25) && (MIS_Addon_Erol_BanditStuff == LOG_Running) && (CurrentLevel != DRAGONISLAND_ZEN))
	{
		MIS_Addon_Erol_BanditStuff = LOG_FAILED;
		B_CheckLog();
	};
	B_GiveInvItems(other,self,ItWr_StonePlateCommon_Addon,anzahl);
	AI_Output(self,other,"DIA_Addon_Vatras_SellStonplate_05_01");	//Great!
	if(anzahl >= 10)
	{
		AI_Output(self,other,"DIA_Addon_Vatras_SellStonplate_05_02");	//I shall increase your magical power!
		B_RaiseAttribute(other,ATR_MANA_MAX,anzahl);
	}
	else if(anzahl >= 5)
	{
		AI_Output(self,other,"DIA_Addon_Vatras_SellStonplate_05_04");	//Here, take a few spell scrolls as a reward...
		if(!Npc_HasItems(other,ItRu_InstantFireball))
		{
			CreateInvItems(self,ItSc_InstantFireball,anzahl);
			B_GiveInvItems(self,other,ItSc_InstantFireball,anzahl);
		}
		else if(!Npc_HasItems(other,ItRu_Icelance))
		{
			CreateInvItems(self,ItSc_Icelance,anzahl);
			B_GiveInvItems(self,other,ItSc_Icelance,anzahl);
		}
		else
		{
			CreateInvItems(self,ItSc_SumSkel,anzahl);
			B_GiveInvItems(self,other,ItSc_SumSkel,anzahl);
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Vatras_SellStonplate_05_03");	//Here, take a few potions as a reward...
		CreateInvItems(self,ItPo_Health_03,anzahl + 1);
		B_GiveInvItems(self,other,ItPo_Health_03,anzahl + 1);
	};
	Npc_RemoveInvItems(self,ItWr_StonePlateCommon_Addon,Npc_HasItems(self,ItWr_StonePlateCommon_Addon));
	B_GivePlayerXP(XP_Addon_VatrasStonplate * anzahl);
};


var int Vatras_SentToDaron;

instance DIA_Addon_Vatras_GuildHelp(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 5;
	condition = DIA_Addon_Vatras_GuildHelp_Condition;
	information = DIA_Addon_Vatras_GuildHelp_Info;
	description = "Lares says that you can help me get into the monastery of the Fire Magicians.";
};


func int DIA_Addon_Vatras_GuildHelp_Condition()
{
	if((RangerHelp_gildeKDF == TRUE) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_GuildHelp_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_GuildHelp_15_00");	//Lares said that you could help me get into the monastery of the Fire Magicians.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_01");	//Is that your choice? The Way of the Fire?
	AI_Output (other, self, "DIA_Addon_Vatras_GuildHelp_15_02");	//Yes. I want to become a Fire Magician.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_03");	//As far as I know, they gladly accept novices in their monastery. So why would you need my help?
	if(Npc_KnowsInfo(other,DIA_Pedro_TEMPEL))
	{
		AI_Output (other, self, "DIA_Addon_Vatras_GuildHelp_15_04");	//The novice in front of the monastery wants me to pay a tribute to enter. A sheep and a load of gold.
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Vatras_GuildHelp_15_05");	//Lares mentioned that they demand a tribute before they let anyone into the monastery.
	};
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_06");	//I cannot grant you entry into the monastery myself. I am a Water Mage, as you know. But I am very well acquainted with Daron the Fire Magician.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_07");	//He spends most of his time in the marketplace, collecting alms for his church.
	Vatras_SentToDaron = TRUE;
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_08");	//But I have heard that he is not only in town to raise some funds.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_09");	//He told me about a statuette that was stolen from him.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_10");	//It was very important to him. He will surely allow you to enter the monastery if you can get it back for him.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_11");	//Of course, if you should decide to join the Circle of Fire, you can still become a member of the Ring.
	AI_Output (self, other, "DIA_Addon_Vatras_GuildHelp_05_12");	//If you prove yourself worthy, that is.
	MIS_Addon_Vatras_Go2Daron = LOG_Running;
//	Log_CreateTopic(TOPIC_Addon_RangerHelpKDF,LOG_MISSION);
//	Log_SetTopicStatus(TOPIC_Addon_RangerHelpKDF,LOG_Running);
	B_LogEntry(TOPIC_Addon_RangerHelpKDF,"Daron, the Fire Magician in the marketplace, will help me get into the monastery if I find his stolen statuette for him.");
};


/*instance DIA_Vatras_MORE(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 998;
	condition = DIA_Vatras_MORE_Condition;
	information = DIA_Vatras_MORE_Info;
	permanent = TRUE;
	description = "(More)";
};


func int DIA_Vatras_MORE_Condition()
{
	if(Vatras_MORE == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Vatras_MORE_Info()
{
	Vatras_MORE = TRUE;
};*/

func void B_Vatras_Segen()
{
	if((MIS_Thorben_GetBlessings == LOG_Running) && (Vatras_Blessing == FALSE))
	{
		B_LogEntry(TOPIC_Thorben,"Vatras the Water Mage has blessed me.");
	};
	Vatras_Segen += 1;
	if((MadKillerCount > 0) && (VatrasMadKillerCount == 0) && (Vatras_Segen > 9))
	{
		MadKillerCount -= 1;
		Vatras_Segen = 0;
	};
	Snd_Play("LEVELUP");
	Vatras_Blessing = TRUE;
};

func void B_Vatras_NoMoreBlessing()
{
	AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_13");	//I have now given you TWO chances to tell me the truth, but you apparently do not want to. I shall NOT give you my blessing!
	AI_StopProcessInfos(self);
};

func void B_Vatras_Blessing()
{
	AI_Output(self,other,"DIA_Vatras_INFLUENCE_REPEAT_05_11");	//Go with the blessing of Adanos, my son!
	B_GivePlayerXP(XP_VatrasTruth);
	B_Vatras_Segen();
	Info_ClearChoices(DIA_Vatras_INFLUENCE);
};

instance DIA_Vatras_INFLUENCE(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 92;
	condition = DIA_Vatras_INFLUENCE_Condition;
	information = DIA_Vatras_INFLUENCE_Info;
	permanent = TRUE;
	description = "I am asking your blessing.";
};


func int DIA_Vatras_INFLUENCE_Condition()
{
//	if((MIS_Thorben_GetBlessings == LOG_Running) && (Player_IsApprentice == APP_NONE) && (Vatras_MORE == TRUE))
	if((MIS_Thorben_GetBlessings == LOG_Running) && (Player_IsApprentice == APP_NONE) && (Vatras_Blessing == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_INFLUENCE_Info()
{
	AI_Output(other,self,"DIA_Vatras_INFLUENCE_15_00");	//I am asking your blessing.
	if(Npc_KnowsInfo(other,DIA_Addon_Vatras_WannaBeRanger))
	{
		B_Vatras_Blessing();
	}
	else if(Vatras_Chance == TRUE)
	{
		B_Vatras_NoMoreBlessing();
	}
	else 
	{
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_05_01");	//Why should I give you my blessing, stranger?
		AI_Output(other,self,"DIA_Vatras_INFLUENCE_15_02");	//I want to start an apprenticeship with one of the masters in the lower part of town.
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_05_03");	//I may give you my blessing, stranger, but I know nothing about you. Tell me about yourself.
		AI_Output(other,self,"DIA_Vatras_INFLUENCE_15_04");	//What do you want to know?
		AI_Output(self,other,"DIA_Vatras_INFLUENCE_05_05");	//Well, you could tell me where you come from and why you have come to the city.
		AI_Output (other, self, "DIA_Vatras_INFLUENCE_15_06");	//I carry an important message for the leader of the paladins.
	AI_Output (self, other, "DIA_Vatras_INFLUENCE_05_07");	//What is this message?
		Info_ClearChoices(DIA_Vatras_INFLUENCE);
		Info_AddChoice(DIA_Vatras_INFLUENCE,"Dragons have come...",DIA_Vatras_BLESSING_FIRST_TRUTH);
		Info_AddChoice(DIA_Vatras_INFLUENCE,"Terrible things are bound to happen soon.",DIA_Vatras_BLESSING_FIRST_LIE);
	};
};


func void B_Vatras_BLESSING_REPEAT()
{
	B_Vatras_REPEAT();
	if((Vatras_First == TRUE) && (Vatras_Second == TRUE) && (Vatras_Third == TRUE))
	{
		AI_Output(other,self,"DIA_Vatras_INFLUENCE_REPEAT_15_00");	//And will you give me your blessing now?
		B_Vatras_Blessing();
	}
	else if(Vatras_Chance == FALSE)
	{
		B_Vatras_PLEASEDONTLIE();
		Vatras_Chance = TRUE;
		Info_ClearChoices(DIA_Vatras_INFLUENCE);
		Info_AddChoice(DIA_Vatras_INFLUENCE,"Dragons have come...",DIA_Vatras_BLESSING_FIRST_TRUTH);
		Info_AddChoice(DIA_Vatras_INFLUENCE,"Terrible things are bound to happen soon.",DIA_Vatras_BLESSING_FIRST_LIE);
	}
	else
	{
		B_Vatras_NoMoreBlessing();
	};
};

func void DIA_Vatras_BLESSING_FIRST_TRUTH()
{
	B_Vatras_First_Truth();
	Info_ClearChoices(DIA_Vatras_INFLUENCE);
	Info_AddChoice(DIA_Vatras_INFLUENCE,"Oh, I heard rumors somewhere...",DIA_Vatras_BLESSING_SECOND_LIE);
	Info_AddChoice(DIA_Vatras_INFLUENCE,"Xardas the magician told me...",DIA_Vatras_BLESSING_SECOND_TRUTH);
};

func void DIA_Vatras_BLESSING_FIRST_LIE()
{
	B_Vatras_First_Lie();
	Info_ClearChoices(DIA_Vatras_INFLUENCE);
	Info_AddChoice(DIA_Vatras_INFLUENCE,"Oh, I heard rumors somewhere...",DIA_Vatras_BLESSING_SECOND_LIE);
	Info_AddChoice(DIA_Vatras_INFLUENCE,"Xardas the magician told me...",DIA_Vatras_BLESSING_SECOND_TRUTH);
};

func void DIA_Vatras_BLESSING_SECOND_TRUTH()
{
	B_Vatras_Second_Truth();
	Info_ClearChoices(DIA_Vatras_INFLUENCE);
	Info_AddChoice(DIA_Vatras_INFLUENCE,"I'm just an adventurer from down south...",DIA_Vatras_BLESSING_THIRD_LIE);
	Info_AddChoice(DIA_Vatras_INFLUENCE,"I'm a former convict...",DIA_Vatras_BLESSING_THIRD_TRUTH);
};

func void DIA_Vatras_BLESSING_SECOND_LIE()
{
	B_Vatras_Second_Lie();
	Info_ClearChoices(DIA_Vatras_INFLUENCE);
	Info_AddChoice(DIA_Vatras_INFLUENCE,"I'm just an adventurer from down south...",DIA_Vatras_BLESSING_THIRD_LIE);
	Info_AddChoice(DIA_Vatras_INFLUENCE,"I'm a former convict...",DIA_Vatras_BLESSING_THIRD_TRUTH);
};

func void DIA_Vatras_BLESSING_THIRD_TRUTH()
{
	B_Vatras_Third_Truth();
	B_Vatras_BLESSING_REPEAT();
};

func void DIA_Vatras_BLESSING_THIRD_LIE()
{
	B_Vatras_Third_Lie();
	B_Vatras_BLESSING_REPEAT();
};

instance DIA_Vatras_WoKdF(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 93;
	condition = DIA_Vatras_WoKdF_Condition;
	information = DIA_Vatras_WoKdF_Info;
	permanent = FALSE;
	description = "Where can I find a priest of Innos?";
};


func int DIA_Vatras_WoKdF_Condition()
{
//	if((MIS_Thorben_GetBlessings == LOG_Running) && (Vatras_Segen > 0) && (Vatras_SentToDaron == FALSE) && !Npc_KnowsInfo(other,DIA_Daron_Hallo) && (Vatras_MORE == TRUE))
	if((MIS_Thorben_GetBlessings == LOG_Running) && (Vatras_Blessing == TRUE) && (Vatras_SentToDaron == FALSE) && (GotInnosBlessingForThorben == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_WoKdF_Info()
{
	AI_Output (other, self, "DIA_Vatras_WoKdF_15_00");	//Where can I find a priest of Innos?
	AI_Output (self, other, "DIA_Vatras_WoKdF_05_01");	//The best thing would be to look around the marketplace. You will find an emissary of the monastery there.
};


var int Vatras_Spende;
var int Vatras_Spende_Day;
var int Vatras_Spende_Day_First;

instance DIA_Vatras_Spende(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 94;
	condition = DIA_Vatras_Spende_Condition;
	information = DIA_Vatras_Spende_Info;
	permanent = TRUE;
	description = "I want to make a donation to Adanos!";
};


func int DIA_Vatras_Spende_Condition()
{
//	if(Vatras_MORE == TRUE)
//	if((Vatras_MORE == TRUE) && (Vatras_First == TRUE) && (Vatras_Second == TRUE) && (Vatras_Third == TRUE))
	if(((Vatras_First == TRUE) && (Vatras_Second == TRUE) && (Vatras_Third == TRUE)) || (Vatras_Chance == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_Spende_Info()
{
	if((Vatras_Spende_Day_First == TRUE) && (Vatras_Spende_Day < Wld_GetDay()))
	{
		Vatras_Spende = 0;
	};
	AI_Output (other, self, "DIA_Vatras_Spende_15_00");	//I want to make a donation to Adanos!
	AI_Output (self, other, "DIA_Vatras_Spende_05_01");	//A donation to the church of Adanos would alleviate a part of the sins which you may have committed, my son.
	AI_Output (self, other, "DIA_Vatras_Spende_05_02");	//How much can you give?
	Info_ClearChoices(DIA_Vatras_Spende);
	Info_AddChoice(DIA_Vatras_Spende,"I haven't got anything to spare right now...",DIA_Vatras_Spende_BACK);
	if(Npc_HasItems(other,ItMi_Gold) >= 50)
	{
		Info_AddChoice(DIA_Vatras_Spende,"I've got 50 gold pieces...",DIA_Vatras_Spende_50);
	};
	if(Npc_HasItems(other,ItMi_Gold) >= 100)
	{
		Info_AddChoice(DIA_Vatras_Spende,"I've got 100 gold pieces...",DIA_Vatras_Spende_100);
	};
};

func void DIA_Vatras_Spende_BACK()
{
	AI_Output(other,self,"DIA_Vatras_Spende_BACK_15_00");	//I haven't got anything to spare right now...
	AI_Output(self,other,"DIA_Vatras_Spende_BACK_05_01");	//That is not a problem, you can act upon your good intentions later, my son.
	Info_ClearChoices(DIA_Vatras_Spende);
};

func void B_Vatras_Spende_Check()
{
	if(Vatras_Spende < 100)
	{
		AI_Output(self,other,"DIA_Vatras_Spende_50_05_01");	//I thank you in the name of Adanos, my son. Your gold will be distributed among the needy.
	}
	else
	{
		AI_Output(self,other,"DIA_Vatras_Spende_100_05_01");	//I bless you in the name of Adanos for this generous act!
		AI_Output(self,other,"DIA_Vatras_Spende_100_05_02");	//May the path you follow be blessed by Adanos!
		B_Vatras_Segen();
		Vatras_Spende = 0;
	};
	Info_ClearChoices(DIA_Vatras_Spende);
};

func void DIA_Vatras_Spende_50()
{
	AI_Output(other,self,"DIA_Vatras_Spende_50_15_00");	//I've got 50 gold pieces...
	B_GiveInvItems(other,self,ItMi_Gold,50);
	if(Vatras_Spende_Day == 0)
	{
		Vatras_Spende += 50;
		Vatras_Spende_Day_First = TRUE;
	}
	else if(Vatras_Spende_Day >= Wld_GetDay())
	{
		Vatras_Spende += 50;
	};
	Vatras_Spende_Day = B_GetDayPlus();
	B_Vatras_Spende_Check();
};

func void DIA_Vatras_Spende_100()
{
	AI_Output(other,self,"DIA_Vatras_Spende_100_15_00");	//I've got 100 gold pieces...
	B_GiveInvItems(other,self,ItMi_Gold,100);
	Vatras_Spende += 100;
	B_Vatras_Spende_Check();
};


instance DIA_Vatras_CanTeach(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 95;
	condition = DIA_Vatras_CanTeach_Condition;
	information = DIA_Vatras_CanTeach_Info;
	permanent = FALSE;
	description = "Can you teach me something about magic?";
};


func int DIA_Vatras_CanTeach_Condition()
{
	/*if(Vatras_MORE == TRUE)
	{
		return TRUE;
	};*/
	return TRUE;
};

func void DIA_Vatras_CanTeach_Info()
{
	AI_Output (other, self, "DIA_Vatras_CanTeach_15_00");	//Can you teach me something about magic?
	AI_Output (self, other, "DIA_Vatras_CanTeach_05_01");	//Only the Chosen of Innos and the Chosen of Adanos are permitted to work rune magic.
	AI_Output (self, other, "DIA_Vatras_CanTeach_05_02");	//But common mortals can also work magic with the help of spell scrolls.
	AI_Output (self, other, "DIA_Vatras_CanTeach_05_03");	//I can show you how you can channel and expand your magic powers.
	Vatras_TeachMANA = TRUE;
	Log_CreateTopic (TOPIC_CityTeacher, LOG_NOTE);
	B_LogEntry (TOPIC_CityTeacher, "Vatras the Water Mage can help me increase my magic powers.");
};


var int Vatras_TeachMANA_NoPerm;

func void B_BuildLearnDialog_Vatras()
{
	if(other.aivar[REAL_MANA_MAX] >= T_HIGH)
	{
		AI_Output(self,other,"DIA_Vatras_Teach_05_00");	//Your magical power has grown beyond my ability to teach you.
		Vatras_TeachMANA_NoPerm = TRUE;
	}
	else
	{
		Info_ClearChoices(DIA_Vatras_Teach);
		Info_AddChoice(DIA_Vatras_Teach,Dialog_Back,DIA_Vatras_Teach_BACK);
		Info_AddChoice(DIA_Vatras_Teach,B_BuildLearnString(PRINT_LearnMANA1,B_GetLearnCostAttribute(other,ATR_MANA_MAX)),DIA_Vatras_Teach_1);
		Info_AddChoice(DIA_Vatras_Teach,B_BuildLearnString(PRINT_LearnMANA5,B_GetLearnCostAttribute(other,ATR_MANA_MAX) * 5),DIA_Vatras_Teach_5);
	};
};

instance DIA_Vatras_Teach(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 100;
	condition = DIA_Vatras_Teach_Condition;
	information = DIA_Vatras_Teach_Info;
	permanent = TRUE;
	description = "I want to increase my magic powers.";
};


func int DIA_Vatras_Teach_Condition()
{
//	if((Vatras_TeachMANA == TRUE) && (Vatras_MORE == TRUE))
	if((Vatras_TeachMANA == TRUE) && (Vatras_TeachMANA_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_Teach_Info()
{
	AI_Output(other,self,"DIA_Vatras_Teach_15_00");	//I want to increase my magic powers.
	B_BuildLearnDialog_Vatras();
};

func void DIA_Vatras_Teach_BACK()
{
	Info_ClearChoices(DIA_Vatras_Teach);
};

func void DIA_Vatras_Teach_1()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,1,T_HIGH))
	{
		B_BuildLearnDialog_Vatras();
	};
};

func void DIA_Vatras_Teach_5()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,5,T_HIGH))
	{
		B_BuildLearnDialog_Vatras();
	};
};

instance DIA_Vatras_GODS(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 98;
	condition = DIA_Vatras_GODS_Condition;
	information = DIA_Vatras_GODS_Info;
	permanent = TRUE;
	description = "Tell me about the gods.";
};


func int DIA_Vatras_GODS_Condition()
{
	/*if(Vatras_MORE == TRUE)
	{
		return TRUE;
	};*/
	return TRUE;
};

func void DIA_Vatras_GODS_Info()
{
	AI_Output (other, self, "DIA_Vatras_GODS_15_00");	//Tell me about the gods.
	AI_Output (self, other, "DIA_Vatras_GODS_05_01");	//What exactly would you like to know?
	Info_ClearChoices (DIA_Vatras_GODS);
	Info_AddChoice (DIA_Vatras_GODS, Dialog_Back, DIA_Vatras_GODS_BACK);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Innos.", DIA_Vatras_GODS_INNOS);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Adanos.", DIA_Vatras_GODS_ADANOS);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Beliar.", DIA_Vatras_GODS_BELIAR);
};

func void DIA_Vatras_GODS_BACK()
{
	Info_ClearChoices(DIA_Vatras_GODS);
};

func void DIA_Vatras_GODS_INNOS()
{
	AI_Output (other, self, "DIA_Vatras_GODS_INNOS_15_00");	//Tell me about Innos.
	AI_Output (self, other, "DIA_Vatras_GODS_INNOS_05_01");	//Very well. (preaches) Innos is the first and highest god. He created the sun and the world.
	AI_Output (self, other, "DIA_Vatras_GODS_INNOS_05_02");	//He commands light and fire, his gifts to humanity. He is law and justice.
	AI_Output (self, other, "DIA_Vatras_GODS_INNOS_05_03");	//His priests are the Magicians of Fire, the paladins are his warriors.
	Info_ClearChoices (DIA_Vatras_GODS);
	Info_AddChoice (DIA_Vatras_GODS, Dialog_Back, DIA_Vatras_GODS_BACK);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Innos.", DIA_Vatras_GODS_INNOS);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Adanos.", DIA_Vatras_GODS_ADANOS);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Beliar.", DIA_Vatras_GODS_BELIAR);
};

func void DIA_Vatras_GODS_ADANOS()
{
	AI_Output (other, self, "DIA_Vatras_GODS_ADANOS_15_00");	//Tell me about Adanos.
	AI_Output (self, other, "DIA_Vatras_GODS_ADANOS_05_01");	//Adanos is the god of the center. He is the scales of justice, the guardian of the balance between Innos and Beliar.
	AI_Output (self, other, "DIA_Vatras_GODS_ADANOS_05_02");	//He commands the power of change, his gift is the water in all the oceans, rivers, and lakes.
	AI_Output (self, other, "DIA_Vatras_GODS_ADANOS_05_03");	//His priests are the Water Mages, just as I am a servant and priest of Adanos.
	Info_ClearChoices (DIA_Vatras_GODS);
	Info_AddChoice (DIA_Vatras_GODS, Dialog_Back, DIA_Vatras_GODS_BACK);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Innos.", DIA_Vatras_GODS_INNOS);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Adanos.", DIA_Vatras_GODS_ADANOS);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Beliar.", DIA_Vatras_GODS_BELIAR);
};

func void DIA_Vatras_GODS_BELIAR()
{
	AI_Output (other, self, "DIA_Vatras_GODS_BELIAR_15_00");	//Tell me about Beliar.
	AI_Output (self, other, "DIA_Vatras_GODS_BELIAR_05_01");	//Beliar is the dark god of death, destruction and all things unnatural.
	AI_Output (self, other, "DIA_Vatras_GODS_BELIAR_05_02");	//He is in eternal battle with Innos, but Adanos guards the balance between the two.
	AI_Output (self, other, "DIA_Vatras_GODS_BELIAR_05_03");	//Only a few humans follow the call of Beliar - however, he grants great strength to those who do.
	Info_ClearChoices (DIA_Vatras_GODS);
	Info_AddChoice (DIA_Vatras_GODS, Dialog_Back, DIA_Vatras_GODS_BACK);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Innos.", DIA_Vatras_GODS_INNOS);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Adanos.", DIA_Vatras_GODS_ADANOS);
	Info_AddChoice (DIA_Vatras_GODS, "Tell me about Beliar.", DIA_Vatras_GODS_BELIAR);
};


instance DIA_Vatras_HEAL(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 99;
	condition = DIA_Vatras_HEAL_Condition;
	information = DIA_Vatras_HEAL_Info;
	permanent = TRUE;
	description = "Can you heal me?";
};


func int DIA_Vatras_HEAL_Condition()
{
	/*if(Vatras_MORE == TRUE)
	{
		return TRUE;
	};*/
	return TRUE;
};

func void DIA_Vatras_HEAL_Info()
{
	AI_Output (other, self, "DIA_Vatras_HEAL_15_00");	//Can you heal me?
	if (hero.attribute[ATR_HITPOINTS] < hero.attribute[ATR_HITPOINTS_MAX])
	{
		AI_Output (self, other, "DIA_Vatras_HEAL_05_01");	//(devout) Adanos bless this body. Free it of its wounds and strengthen it with new life.
		hero.attribute[ATR_HITPOINTS] = hero.attribute[ATR_HITPOINTS_MAX];
		PrintScreen(PRINT_FullyHealed,-1,-1,FONT_Screen,2);
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_HEAL_05_02");	//You do not require healing magic at this time.
	};
};


instance DIA_Vatras_MISSION(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 1;
	condition = DIA_Vatras_MISSION_Condition;
	information = DIA_Vatras_MISSION_Info;
	important = TRUE;
};


func int DIA_Vatras_MISSION_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Kapitel == 2) && !Npc_IsDead(Isgaroth) && Npc_KnowsInfo(other,DIA_Addon_Vatras_HowToJoin))
	{
		return TRUE;
	};
};

func void DIA_Vatras_MISSION_Info()
{
	AI_Output (self, other, "DIA_Vatras_Add_05_10");	//I have a message for Master Isgaroth. He guards the shrine in front of the monastery.
	AI_Output (self, other, "DIA_Vatras_MISSION_05_01");	//If you run this errand for me, you get to choose your own reward.
	Info_ClearChoices (DIA_Vatras_MISSION);
	Info_AddChoice (DIA_Vatras_MISSION, "Not now.", DIA_Vatras_MISSION_NO);
	Info_AddChoice (DIA_Vatras_MISSION, "Sure.", DIA_Vatras_MISSION_YES);
};

func void B_SayVatrasGo()
{
	AI_Output (self, other, "DIA_Vatras_Add_05_13");	//Good. So be on your way to Master Isgaroth now.
};

func void DIA_Vatras_MISSION_YES()
{
	AI_Output (other, self, "DIA_Vatras_MISSION_YES_15_00");	//I'll do it.
	AI_Output (self, other, "DIA_Vatras_Add_05_11");	//Good, then take the message and choose one of these spell scrolls.
	AI_Output (self, other, "DIA_Vatras_Add_05_12");	//When you have delivered the message, I shall reward you accordingly.
	B_GiveInvItems(self,other,ItWr_VatrasMessage,1);
	MIS_Vatras_Message = LOG_Running;
	Log_CreateTopic(TOPIC_Botschaft,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Botschaft,LOG_Running);
	B_LogEntry(TOPIC_Botschaft,"Vatras has given me a message for Master Isgaroth. He is at the shrine in front of the monastery.");
	Info_ClearChoices(DIA_Vatras_MISSION);
/*	Info_AddChoice(DIA_Vatras_MISSION,"Я возьму заклинание света.",DIA_Vatras_MISSION_LIGHT);
	Info_AddChoice(DIA_Vatras_MISSION,"Я выбираю лечебное заклинание.",DIA_Vatras_MISSION_HEAL);
	Info_AddChoice(DIA_Vatras_MISSION,"Дай мне 'Ледяную стрелу'.",DIA_Vatras_MISSION_ICE);*/
	Info_AddChoice(DIA_Vatras_MISSION,"I'll take the spell of light.",DIA_Vatras_MISSION_LIGHT);
	Info_AddChoice(DIA_Vatras_MISSION,"I choose the healing spell.",DIA_Vatras_MISSION_HEAL);
	Info_AddChoice(DIA_Vatras_MISSION,"Give me the Ice Arrow.",DIA_Vatras_MISSION_ICE);
};

func void DIA_Vatras_MISSION_NO()
{
	AI_Output (other, self, "DIA_ADDON_Vatras_MISSION_NO_15_00");	//Not now!
	AI_Output (self, other, "DIA_ADDON_Vatras_MISSION_NO_05_01");	//No problem. I shall send somebody else.
	MIS_Vatras_Message = LOG_OBSOLETE;
	Info_ClearChoices(DIA_Vatras_MISSION);
};

func void DIA_Vatras_MISSION_HEAL()
{
	AI_Output(other,self,"DIA_Vatras_MISSION_HEAL_15_00");	//I choose the healing spell.
	B_SayVatrasGo();
	B_GiveInvItems(self,other,ItSc_LightHeal,1);
	Info_ClearChoices(DIA_Vatras_MISSION);
};

func void DIA_Vatras_MISSION_ICE()
{
	AI_Output(other,self,"DIA_Vatras_MISSION_ICE_15_00");	//Give me the Ice Arrow.
	B_SayVatrasGo();
	B_GiveInvItems(self,other,ItSc_Icebolt,1);
	Info_ClearChoices(DIA_Vatras_MISSION);
};

func void DIA_Vatras_MISSION_LIGHT()
{
	AI_Output(other,self,"DIA_Vatras_MISSION_LIGHT_15_00");	//I'll take the spell of light.
	B_SayVatrasGo();
	B_GiveInvItems(self,other,ItSc_Light,1);
	Info_ClearChoices(DIA_Vatras_MISSION);
};


instance DIA_Vatras_MESSAGE_SUCCESS(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 1;
	condition = DIA_Vatras_MESSAGE_SUCCESS_Condition;
	information = DIA_Vatras_MESSAGE_SUCCESS_Info;
	description = "I have delivered your message.";
};


func int DIA_Vatras_MESSAGE_SUCCESS_Condition()
{
	if((MIS_Vatras_Message == LOG_Running) && (Vatras_Return == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_MESSAGE_SUCCESS_Info()
{
	AI_Output (other, self, "DIA_Vatras_MESSAGE_SUCCESS_15_00");	//I have delivered your message.
	AI_Output (self, other, "DIA_Vatras_Add_05_14");	//Accept my thanks. And now pick your reward.
	MIS_Vatras_Message = LOG_SUCCESS;
	B_GivePlayerXP (XP_Vatras_Message);
	Info_ClearChoices (DIA_Vatras_MESSAGE_SUCCESS);
	Info_AddChoice (DIA_Vatras_MESSAGE_SUCCESS, "1 King's Sorrel", DIA_Vatras_MESSAGE_SUCCESS_Plant);
	Info_AddChoice (DIA_Vatras_MESSAGE_SUCCESS, "Ring of Skill", DIA_Vatras_MESSAGE_SUCCESS_Ring);
	Info_AddChoice (DIA_Vatras_MESSAGE_SUCCESS, "1 Ore Nugget", DIA_Vatras_MESSAGE_SUCCESS_Ore);
};

func void DIA_Vatras_MESSAGE_SUCCESS_Plant()
{
	AI_Output(other,self,"DIA_Vatras_MESSAGE_SUCCESS_15_00_Plant_Add");	//Я возьму царский щавель.@@@
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(self,other,ItPl_Perm_Herb,1);
	Info_ClearChoices(DIA_Vatras_MESSAGE_SUCCESS);
};

func void DIA_Vatras_MESSAGE_SUCCESS_Ring()
{
	AI_Output(other,self,"DIA_Addon_Skip_Grog_ring_15_00");	//Give me the ring.
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(self,other,ItRi_Dex_01,1);
	Info_ClearChoices(DIA_Vatras_MESSAGE_SUCCESS);
};

func void DIA_Vatras_MESSAGE_SUCCESS_Ore()
{
	AI_Output(other,self,"DIA_Vatras_MESSAGE_SUCCESS_15_00_Ore_Add");	//Я возьму руду. @@@
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(self,other,ItMi_Nugget,1);
	Info_ClearChoices(DIA_Vatras_MESSAGE_SUCCESS);
};


const int kurz = 0;
const int lang = 1;
var int Vatras_einmalLangWeg;

func void B_Vatras_GeheWeg(var int dauer)
{
	if(Vatras_einmalLangWeg == TRUE)
	{
		return;
	};
	if((Npc_GetDistToWP(self,"NW_CITY_MERCHANT_TEMPLE_FRONT") <= 500) && Npc_WasInState(self,ZS_Preach_Vatras))
	{
		B_StopLookAt (self);
		AI_AlignToWP (self);
		AI_Output (self, other, "DIA_Vatras_Add_05_06");	//Listen people! I am needed elsewhere.
		if (dauer == kurz)
		{
			AI_Output (self, other, "DIA_Vatras_Add_05_07");	//It won't take long. When I return I shall tell you the rest of the story.
		}
		else
		{
			AI_Output (self, other, "DIA_Vatras_Add_05_08");	//I do not know whether I shall return. If you want to know the ending, read up on the story in the scriptures.
			Vatras_einmalLangWeg = TRUE;
		};
		AI_Output(self,other,"DIA_Vatras_Add_05_09");	//May Adanos be with you!
		Vatras_Listeners_ReadyToGo = TRUE;
		B_TurnToNpc(self,other);
	};
};


instance DIA_Addon_Vatras_AbloesePre(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_AbloesePre_Condition;
	information = DIA_Addon_Vatras_AbloesePre_Info;
	description = "I've got this problem with the Eye of Innos.";
};


func int DIA_Addon_Vatras_AbloesePre_Condition()
{
	if((Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)) && (Kapitel == 3) && (VatrasCanLeaveTown_Kap3 == FALSE))
	{
		if((RavenIsDead == FALSE) && (AddonDisabled == FALSE))
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Vatras_AbloesePre_Info()
{
	AI_Output (other, self, "DIA_Addon_Vatras_AbloesePre_15_00");	//I've got a problem with the Eye of Innos. I could use your help.
	AI_Output (self, other, "DIA_Addon_Vatras_AbloesePre_05_01");	//And will your problem require me to leave town?
	AI_Output (other, self, "DIA_Addon_Vatras_AbloesePre_15_02");	//I don't know. Possibly.
	AI_Output (self, other, "DIA_Addon_Vatras_AbloesePre_05_03");	//I have been waiting to be relieved for days. The other Water Mages should have been back in Khorinis some time ago.
	AI_Output (self, other, "DIA_Addon_Vatras_AbloesePre_05_04");	//If you see to it that at least one of them comes to take over my duties in town, I shall be free to help you solve your problem.
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
	Log_CreateTopic (TOPIC_Addon_VatrasAbloesung, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_VatrasAbloesung, LOG_Running);
	B_LogEntry (TOPIC_Addon_VatrasAbloesung, "Vatras cannot help me solve my problem with the 'Eye of Innos' as long as there isn't another Water Mage to take over his task in the city.");
};


instance DIA_Addon_Vatras_AddonSolved(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Addon_Vatras_AddonSolved_Condition;
	information = DIA_Addon_Vatras_AddonSolved_Info;
	description = "Someone's here to relieve you.";
};


func int DIA_Addon_Vatras_AddonSolved_Condition()
{
	if(RavenIsDead == TRUE)
	{
		if(Npc_KnowsInfo(other,DIA_Addon_Vatras_AbloesePre))
		{
			DIA_Addon_Vatras_AddonSolved.description = "Someone's here to relieve you.";
		}
		else
		{
			DIA_Addon_Vatras_AddonSolved.description = "I'm back.";
		};
		return TRUE;
	};
};

func void DIA_Addon_Vatras_AddonSolved_Info()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Vatras_AbloesePre))
	{
		AI_Output(other,self,"DIA_Addon_Vatras_AddonSolved_15_00");	//Someone's here to relieve you.
	}
	else
	{
		DIA_Common_ImBack();
	};
	AI_Output (other, self, "DIA_Addon_Vatras_AddonSolved_15_00");	//Someone's here to relieve you.
	AI_Output (self, other, "DIA_Addon_Vatras_AddonSolved_05_01");	//Have the matters beyond the north-eastern mountains been settled?
	AI_Output (other, self, "DIA_Addon_Vatras_AddonSolved_15_02");	//Yes, they have. Raven is dead, and the threat has been averted.
	AI_Output (self, other, "DIA_Addon_Vatras_AddonSolved_05_03");	//That is good news indeed. Now let us hope that such things will not happen again.
	if(Npc_KnowsInfo(other,DIA_Addon_Vatras_AbloesePre))
	{
		AI_Output (self, other, "DIA_Addon_Vatras_AddonSolved_05_04");	//NOW I can help you with your little problem.
		AI_Output (self, other, "DIA_Addon_Vatras_AddonSolved_05_05");	//I seem to remember it concerns the Eye of Innos, right?
	};
	VatrasCanLeaveTown_Kap3 = TRUE;
	B_GivePlayerXP(XP_AmbientKap3);
};


instance DIA_Vatras_INNOSEYEKAPUTT(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 2;
	condition = DIA_Vatras_INNOSEYEKAPUTT_Condition;
	information = DIA_Vatras_INNOSEYEKAPUTT_Info;
	description = "The Eye of Innos is broken.";
};


func int DIA_Vatras_INNOSEYEKAPUTT_Condition()
{
	if((Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)) && (Kapitel == 3))
	{
		if((VatrasCanLeaveTown_Kap3 == TRUE) || (AddonDisabled == TRUE))
		{
			return TRUE;
		};
	};
};

func void DIA_Vatras_INNOSEYEKAPUTT_Info()
{
	DIA_Common_InnosEyeBroken();
	if(MIS_Pyrokar_GoToVatrasInnoseye == LOG_Running)
	{
		AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_15_00");	//Pyrokar sent me.
	}
	else if(MIS_Xardas_GoToVatrasInnoseye == LOG_Running)
	{
		AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_15_01");	//Xardas sent me.
	};
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
	B_GivePlayerXP(XP_AmbientKap3);
	AI_Output(self,other,"DIA_Vatras_INNOSEYEKAPUTT_05_03");	//The Eye of Innos is broken.
	AI_Output(self,other,"DIA_Vatras_INNOSEYEKAPUTT_05_04");	//I know. I have already learned of it from some very upset novices.
	AI_Output(self,other,"DIA_Vatras_INNOSEYEKAPUTT_05_05");	//I would call that an inspired move by the enemy.
	Info_ClearChoices(DIA_Vatras_INNOSEYEKAPUTT);
	Info_AddChoice(DIA_Vatras_INNOSEYEKAPUTT,"News spreads fast in this city.",DIA_Vatras_INNOSEYEKAPUTT_schnelleNachrichten);
	if(MIS_Pyrokar_GoToVatrasInnoseye == LOG_Running)
	{
		Info_AddChoice (DIA_Vatras_INNOSEYEKAPUTT, "Why did Pyrokar send me to you of all people?", DIA_Vatras_INNOSEYEKAPUTT_warumdu);
	};
	Info_AddChoice (DIA_Vatras_INNOSEYEKAPUTT, "What will become of the Eye now?", DIA_Vatras_INNOSEYEKAPUTT_Auge);
};

func void DIA_Vatras_INNOSEYEKAPUTT_Auge()
{
	AI_Output(other,self,"DIA_Vatras_INNOSEYEKAPUTT_Auge_15_00");	//What will become of the Eye now?
	AI_Output(self,other,"DIA_Vatras_INNOSEYEKAPUTT_Auge_05_01");	//We must join it back together. But that is no easy task, I fear.
	if(Npc_HasItems(other,ItMi_InnosEye_Broken_Mis))
	{
		if(MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS)
		{
			AI_Output(self,other,"DIA_Vatras_INNOSEYEKAPUTT_Auge_05_02");	//The setting is broken into two pieces. A skilled smith should be able to repair this.
			AI_Output(self,other,"DIA_Vatras_INNOSEYEKAPUTT_Auge_05_03");	//But that is really not the problem. It's rather the inlaid gem that worries me.
		};
		AI_Output(self,other,"DIA_Vatras_INNOSEYEKAPUTT_Auge_05_04");	//It is dull and powerless. The enemy seems to have known exactly how to weaken it.
		if(!Npc_KnowsInfo(other,DIA_Bennet_GiveInnosEye))
		{
			Info_AddChoice(DIA_Vatras_INNOSEYEKAPUTT,"Where can I find a smith capable of repairing the setting?",DIA_Vatras_INNOSEYEKAPUTT_Auge_schmied);
		};
		Info_AddChoice(DIA_Vatras_INNOSEYEKAPUTT,"How can the gem get its power back?",DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein);
	}
	else
	{
		Info_AddChoice(DIA_Vatras_INNOSEYEKAPUTT,"So what shall we do next?",DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein);
	};
};

func void DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein()
{
	if(Npc_HasItems(other,ItMi_InnosEye_Broken_Mis))
	{
		AI_Output(other,self,"DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_15_00");	//How can the gem get its power back?
	}
	else
	{
		AI_Output(other,self,"DIA_Xardas_Weiter_15_00");	//So what shall we do next?
	};
	AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_15_00");	//How can the gem get its power back?
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_05_01");	//I see only one way. A union of the three reigning divinities should achieve the desired effect.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_05_02");	//A well prepared ritual of reversal in the place of its destruction will give the gem back its fire.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_05_03");	//However, the problem is that you must bring an earthly representative of each of the three gods to this place.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_05_04");	//Furthermore, a lot of swampweed is required for this ritual. I estimate it should be at least 3 plants.
	Info_AddChoice (DIA_Vatras_INNOSEYEKAPUTT, "Who could those three earthly representatives of the gods be?", DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer);
	Info_AddChoice (DIA_Vatras_INNOSEYEKAPUTT, "Where can I find this swampweed?", DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Kraut);
};

func void DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Kraut()
{
	AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Kraut_15_00");	//Where can I find this swampweed?
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Kraut_05_01");	//I have heard about an old quack in the woods named Sagitta. She supposedly sells such herbs.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Kraut_05_02");	//But you could also try your luck down at the harbor.
};

func void DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer()
{
	AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_15_00");	//Who could those three earthly representatives of the gods be?
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_05_01");	//I shall represent the god Adanos myself.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_05_02");	//Pyrokar, the highest fire magician, would be the right person to represent the god Innos.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_05_03");	//But for Beliar, I cannot think of an appropriate candidate. It must be someone who commands black magic.
	Info_AddChoice (DIA_Vatras_INNOSEYEKAPUTT, "Black magic? What about Xardas?", DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_Xardas);
};

func void DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_Xardas()
{
	AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_Xardas_15_00");	//Black magic? What about Xardas?
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_Xardas_05_01");	//That's it. That could work.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_Xardas_05_02");	//But I ask myself how you will bring all three of us together.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_Xardas_05_03");	//I can just see Pyrokar's face when he hears that he must cooperate with Xardas.
	Info_AddChoice (DIA_Vatras_INNOSEYEKAPUTT, "I've got to go.", DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_Xardas_weiter);
};

func void DIA_Vatras_INNOSEYEKAPUTT_Auge_schmied()
{
	AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_Auge_schmied_15_00");	//Where can I find a smith capable of repairing the setting of the Eye?
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_Auge_schmied_05_01");	//Ask around in the area for someone who knows how to repair jewelry.
};

func void DIA_Vatras_INNOSEYEKAPUTT_warumdu()
{
	AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_warumdu_15_00");	//Why did Pyrokar send me to you of all people?
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_warumdu_05_01");	//I suspected that sooner or later something like this would happen.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_warumdu_05_02");	//Pyrokar always thinks himself so invulnerable and superior that it almost borders on carelessness.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_warumdu_05_03");	//Thus his precautions for protecting the Eye were also careless.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_warumdu_05_04");	//I simply think that he unconsciously relies on the abilities which Adanos has granted me.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_warumdu_05_05");	//It doesn't bear thinking about what would happen if I were not available now.
};

func void DIA_Vatras_INNOSEYEKAPUTT_schnelleNachrichten()
{
	AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_schnelleNachrichten_15_00");	//News spreads fast in this city.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_schnelleNachrichten_05_01");	//That's a good thing, too. The enemy won't be sleeping, either.
};

func void DIA_Vatras_INNOSEYEKAPUTT_Auge_Stein_Wer_Xardas_weiter()
{
	AI_Output (other, self, "DIA_Vatras_INNOSEYEKAPUTT_weiter_15_00");	//I've got to go.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_weiter_05_01");	//I shall also set out and prepare the ceremony at the Circle of the Sun.
	AI_Output (self, other, "DIA_Vatras_INNOSEYEKAPUTT_weiter_05_02");	//Send Xardas and Pyrokar there. And don't forget to bring the swampweed. I am counting on you.
	B_LogEntry (TOPIC_INNOSEYE, "Vatras wants to perform a ritual at the Circle of the Sun to heal the Eye. I have to persuade Xardas and Pyrokar to take part in it. Also, I have to find a smith who can repair the amulet's broken setting.");
	MIS_RitualInnosEyeRepair = LOG_Running;
	Info_ClearChoices(DIA_Vatras_INNOSEYEKAPUTT);
	Npc_ExchangeRoutine(self,"RITUALINNOSEYEREPAIR");
	B_Vatras_GeheWeg(kurz);
	if(!Npc_IsDead(DMT_1202))
	{
		DMT_1202.aivar[AIV_EnemyOverride] = TRUE;
		B_StartOtherRoutine(DMT_1202,"AfterRitual");
	};
	if(!Npc_IsDead(DMT_1204))
	{
		DMT_1204.aivar[AIV_EnemyOverride] = TRUE;
		B_StartOtherRoutine(DMT_1204,"AfterRitual");
	};
	if(!Npc_IsDead(DMT_1206))
	{
		DMT_1206.aivar[AIV_EnemyOverride] = TRUE;
		B_StartOtherRoutine(DMT_1206,"AfterRitual");
	};
	if(!Npc_IsDead(DMT_1207))
	{
		DMT_1207.aivar[AIV_EnemyOverride] = TRUE;
		B_StartOtherRoutine(DMT_1207,"AfterRitual");
	};
	if(!Npc_IsDead(DMT_1209))
	{
		DMT_1209.aivar[AIV_EnemyOverride] = TRUE;
		B_StartOtherRoutine(DMT_1209,"AfterRitual");
	};
	if(!Npc_IsDead(DMT_1210))
	{
		DMT_1210.aivar[AIV_EnemyOverride] = TRUE;
		B_StartOtherRoutine(DMT_1210,"AfterRitual");
	};
	if(!Npc_IsDead(DMT_1211))
	{
		DMT_1211.aivar[AIV_EnemyOverride] = TRUE;
		B_StartOtherRoutine(DMT_1211,"AfterRitual");
	};
};


instance DIA_Vatras_RitualInnosEyeRepair(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 33;
	condition = DIA_Vatras_RitualInnosEyeRepair_Condition;
	information = DIA_Vatras_RitualInnosEyeRepair_Info;
	permanent = TRUE;
	description = "How are things with the Eye of Innos?";
};


func int DIA_Vatras_RitualInnosEyeRepair_Condition()
{
	if((MIS_RitualInnosEyeRepair == LOG_Running) && (Kapitel == 3))
	{
		return TRUE;
	};
};

func void DIA_Vatras_RitualInnosEyeRepair_Info()
{
	AI_Output(other,self,"DIA_Vatras_RitualInnosEyeRepair_15_00");	//How are things with the Eye of Innos?
	AI_Output(self,other,"DIA_Vatras_RitualInnosEyeRepair_05_01");	//Remember: only a ritual of reversal at the Circle of the Sun together with Xardas and Pyrokar will restore the Eye.
	if(RitualInnosEyeRuns != LOG_Running)
	{
		AI_Output(self,other,"DIA_Vatras_RitualInnosEyeRepair_05_02");	//And don't forget to bring the Eye, with its setting repaired.
	};
};


instance DIA_Vatras_BEGINN(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 31;
	condition = DIA_Vatras_BEGINN_Condition;
	information = DIA_Vatras_BEGINN_Info;
	description = "I did everything you told me to do.";
};


func int DIA_Vatras_BEGINN_Condition()
{
	if((Kapitel == 3) && (Npc_GetDistToWP(self,"NW_TROLLAREA_RITUAL_02") < 2000) && (Npc_GetDistToWP(Xardas,"NW_TROLLAREA_RITUAL_02") < 2000) && (Npc_GetDistToWP(Pyrokar,"NW_TROLLAREA_RITUAL_02") < 2000) && Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) && (MIS_Bennet_InnosEyeRepairedSetting == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Vatras_BEGINN_Info()
{
	AI_Output(other,self,"DIA_Vatras_BEGINN_15_00");	//I did everything you told me to do. Here's the repaired Eye.
	B_GiveInvItems(other,self,ItMi_InnosEye_Broken_Mis,1);
	Npc_RemoveInvItem(self,ItMi_InnosEye_Broken_Mis);
	AI_Output(self,other,"DIA_Vatras_BEGINN_05_01");	//Indeed, there is nothing missing now for the performance of the ritual.
	if(Npc_HasItems(other,ItPl_SwampHerb) >= 3)
	{
		AI_Output(other,self,"DIA_Vatras_BEGINN_15_02");	//What about the swampweed?
		B_GivePlayerXP(XP_RitualInnosEyeRuns + XP_AmbientKap3);
	}
	else
	{
		B_GivePlayerXP(XP_RitualInnosEyeRuns);
	};
	AI_Output(self,other,"DIA_Vatras_BEGINN_05_03");	//Ah, yes. Do you have 3 swampweed plants, then?
	if(B_GiveInvItems(other,self,ItPl_SwampHerb,3))
	{
		AI_Output(other,self,"DIA_Vatras_BEGINN_15_04");	//Ahem. Yes. Here are the 3 plants.
		AI_Output(self,other,"DIA_Vatras_BEGINN_05_05");	//Excellent.
	}
	else
	{
		AI_Output(other,self,"DIA_Vatras_BEGINN_15_06");	//No. Alas not.
		AI_Output(self,other,"DIA_Vatras_BEGINN_05_07");	//All right. Then we shall have to make do without.
	};
	AI_Output(self,other,"DIA_Vatras_BEGINN_05_08");	//You have done well, but now step aside so that we may begin the ceremony. May our spirits unite.
	Info_ClearChoices(DIA_Vatras_BEGINN);
	Info_AddChoice(DIA_Vatras_BEGINN,Dialog_Ende,DIA_Vatras_BEGINN_los);
};

func void DIA_Vatras_BEGINN_los()
{
	AI_StopProcessInfos(self);
//	Vatras_MORE = FALSE;
	Npc_ExchangeRoutine(self,"RITUALINNOSEYE");
	B_StartOtherRoutine(Xardas,"RITUALINNOSEYE");
	B_StartOtherRoutine(Pyrokar,"RITUALINNOSEYE");
	Npc_SetRefuseTalk(self,60);
	RitualInnosEyeRuns = LOG_Running;
};


instance DIA_Vatras_AUGEGEHEILT(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 33;
	condition = DIA_Vatras_AUGEGEHEILT_Condition;
	information = DIA_Vatras_AUGEGEHEILT_Info;
	important = TRUE;
};


func int DIA_Vatras_AUGEGEHEILT_Condition()
{
	if((Kapitel == 3) && (RitualInnosEyeRuns == LOG_Running) && !Npc_RefuseTalk(self))
	{
		return TRUE;
	};
};

func void DIA_Vatras_AUGEGEHEILT_Info()
{
	AI_Output (self, other, "DIA_Vatras_AUGEGEHEILT_05_00");	//It is finished. We have succeeded in thwarting the enemy's plan and restoring the Eye.
	AI_Output (self, other, "DIA_Vatras_AUGEGEHEILT_05_01");	//Let Pyrokar explain to you how to use its power.
	AI_Output (self, other, "DIA_Vatras_AUGEGEHEILT_05_02");	//I hope that I shall see you again, once you have accomplished your mission. Farewell.
	B_LogEntry (TOPIC_INNOSEYE, "The Eye has been healed. Pyrokar will hand it to me, and then it's off dragon hunting.");
	AI_StopProcessInfos(self);
//	Vatras_MORE = FALSE;
	Vatras_Listeners_ReadyToGo = TRUE;
	RitualInnosEyeRuns = LOG_SUCCESS;
	MIS_RitualInnosEyeRepair = LOG_SUCCESS;
	B_StartOtherRoutine(Pyrokar,"RitualInnosEyeRepair");
	B_StartOtherRoutine(Xardas,"RitualInnosEyeRepair");
	B_Vatras_ListenersControl();
};


instance DIA_Vatras_PERMKAP3(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 33;
	condition = DIA_Vatras_PERMKAP3_Condition;
	information = DIA_Vatras_PERMKAP3_Info;
	description = "Thank you for helping to heal the Eye of Innos.";
};


func int DIA_Vatras_PERMKAP3_Condition()
{
	if(MIS_RitualInnosEyeRepair == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Vatras_PERMKAP3_Info()
{
	AI_Output (other, self, "DIA_Vatras_PERMKAP3_15_00");	//Thank you for helping to heal the Eye of Innos.
	AI_Output (self, other, "DIA_Vatras_PERMKAP3_05_01");	//Do not be so lavish with your thanks. Your greatest task yet lies before you.
	if (MIS_ReadyforChapter4 == FALSE)
	{
		AI_Output (self, other, "DIA_Vatras_PERMKAP3_05_02");	//Speak to Pyrokar, he will explain everything else to you.
	};
	AI_Output (self, other, "DIA_Vatras_PERMKAP3_05_03");	//I hope to see you again in one piece, my son.
};


instance DIA_Vatras_HILDAKRANK(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 34;
	condition = DIA_Vatras_HILDAKRANK_Condition;
	information = DIA_Vatras_HILDAKRANK_Info;
	description = "Lobart's wife Hilda is sick.";
};


func int DIA_Vatras_HILDAKRANK_Condition()
{
	if((MIS_HealHilda == LOG_Running) && Npc_KnowsInfo(other,DIA_Vatras_GREET))
	{
		return TRUE;
	};
};

func void DIA_Vatras_HILDAKRANK_Info()
{
	AI_Output (other, self, "DIA_Vatras_HILDAKRANK_15_00");	//Lobart's wife Hilda is sick.
	AI_Output (self, other, "DIA_Vatras_HILDAKRANK_05_01");	//What? Again? The good woman should take better care of herself.
	AI_Output (self, other, "DIA_Vatras_HILDAKRANK_05_02");	//One hard winter, and she won't be with us anymore. All right, I will give her a medicine to reduce the fever.
	AI_Output (self, other, "DIA_Vatras_HILDAKRANK_05_03");	//Oh, you know, while you're at it, you might as well drop it off with her.
	CreateInvItems (self, ItPo_HealHilda_MIS, 1);
	B_GiveInvItems (self, other, ItPo_HealHilda_MIS, 1);
};


instance DIA_Vatras_OBSESSION(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 35;
	condition = DIA_Vatras_OBSESSION_Condition;
	information = DIA_Vatras_OBSESSION_Info;
	description = "I've got this feeling of trepidation.";
};


func int DIA_Vatras_OBSESSION_Condition()
{
	if((SC_IsObsessed == TRUE) && (SC_ObsessionTimes < 1))
	{
		return TRUE;
	};
};

func void DIA_Vatras_OBSESSION_Info()
{
	AI_Output (other, self, "DIA_Vatras_OBSESSION_15_00");	//I've got this feeling of trepidation.
	AI_Output (self, other, "DIA_Vatras_OBSESSION_05_01");	//You don't look well either. You were subjected to the black look of the Seekers for too long.
	AI_Output (self, other, "DIA_Vatras_OBSESSION_05_02");	//All I can heal is your body, but only the monastery can purify your soul. Speak to Pyrokar. He will help you.
};


instance DIA_Vatras_AllDragonsDead(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 59;
	condition = DIA_Vatras_AllDragonsDead_Condition;
	information = DIA_Vatras_AllDragonsDead_Info;
	description = "The dragons will wreak no more havoc.";
};


func int DIA_Vatras_AllDragonsDead_Condition()
{
	if(Kapitel == 5)
	{
		return TRUE;
	};
};

func void DIA_Vatras_AllDragonsDead_Info()
{
	AI_Output (other, self, "DIA_Vatras_AllDragonsDead_15_00");	//The dragons will wreak no more havoc.
	AI_Output (self, other, "DIA_Vatras_AllDragonsDead_05_01");	//I knew that you would return safe and sound. However, you have yet to take your greatest hurdle.
	AI_Output (other, self, "DIA_Vatras_AllDragonsDead_15_02");	//I know.
	AI_Output (self, other, "DIA_Vatras_AllDragonsDead_05_03");	//Then equip yourself well and come to me if you need help. Always carry the Eye of Innos with you, do you hear? Adanos bless you.
};


instance DIA_Vatras_KnowWhereEnemy(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 55;
	condition = DIA_Vatras_KnowWhereEnemy_Condition;
	information = DIA_Vatras_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "I know where our enemy is located.";
};


func int DIA_Vatras_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (Vatras_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_Vatras_KnowWhereEnemy_15_00");	//I know where our enemy is located.
	AI_Output (self, other, "DIA_Vatras_KnowWhereEnemy_05_01");	//Then let us waste no time and seek him out before he comes to us.
	AI_Output (other, self, "DIA_Vatras_KnowWhereEnemy_15_02");	//You want to accompany me?
	AI_Output (self, other, "DIA_Vatras_KnowWhereEnemy_05_03");	//I have thought long about this and have never been so sure of my business, my friend.
	if(SCToldVatrasHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"Surprisingly, Vatras has offered to accompany me on my journey. A man of his skill and experience could be very valuable to me.");
		SCToldVatrasHeKnowWhereEnemy = TRUE;
	};
	if(Crewmember_Count >= Max_Crew)
	{
		AI_Output (other, self, "DIA_Vatras_KnowWhereEnemy_15_04");	//I've got too many on my list already. I'm afraid there will be no more room for you.
		AI_Output (self, other, "DIA_Vatras_KnowWhereEnemy_05_05");	//Then make room. You will need me.
	}
	else
	{
		Info_ClearChoices (DIA_Vatras_KnowWhereEnemy);
		Info_AddChoice (DIA_Vatras_KnowWhereEnemy, "I'm going to think about it some more.", DIA_Vatras_KnowWhereEnemy_No);
		Info_AddChoice (DIA_Vatras_KnowWhereEnemy, "I consider it an honor to have you by my side.", DIA_Vatras_KnowWhereEnemy_Yes);
	};
};

func void DIA_Vatras_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_Vatras_KnowWhereEnemy_Yes_15_00");	//I consider it an honor to have you by my side. We'll meet you at the harbor.
	AI_Output (self, other, "DIA_Vatras_KnowWhereEnemy_Yes_05_01");	//Don't take too much time. The enemy does not sleep, my friend.
	B_Vatras_GeheWeg(lang);
	Info_ClearChoices(DIA_Vatras_KnowWhereEnemy);
	Info_AddChoice(DIA_Vatras_KnowWhereEnemy,Dialog_Ende,DIA_Vatras_JoinShip);
};

func void DIA_Vatras_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_Vatras_KnowWhereEnemy_No_15_00");	//I'm going to think about it some more.
	AI_Output (self, other, "DIA_Vatras_KnowWhereEnemy_No_05_01");	//Suit yourself. Come back to me if you change your mind.
	Vatras_IsOnBoard = LOG_OBSOLETE;
	Info_ClearChoices(DIA_Vatras_KnowWhereEnemy);
};

var int Vatras_JoinShip_Once;

func void DIA_Vatras_JoinShip()
{
	B_JoinShip(self);
	if(Vatras_JoinShip_Once == FALSE)
	{
		B_Vatras_ListenersControl();
		Vatras_JoinShip_Once = TRUE;
	};
};

instance DIA_Vatras_LeaveMyShip(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 55;
	condition = DIA_Vatras_LeaveMyShip_Condition;
	information = DIA_Vatras_LeaveMyShip_Info;
	permanent = TRUE;
	description = "You had better stay here. The city needs you.";
};


func int DIA_Vatras_LeaveMyShip_Condition()
{
	if((Vatras_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_Vatras_LeaveMyShip_15_00");	//You had better stay here. The city needs you.
	AI_Output (self, other, "DIA_Vatras_LeaveMyShip_05_01");	//Perhaps you are right. And yet, I shall accompany you if you wish. You know that.
	Vatras_IsOnBoard = LOG_OBSOLETE;
	Crewmember_Count -= 1;
	Npc_ExchangeRoutine(self,"PRAY");
};


instance DIA_Vatras_StillNeedYou(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 55;
	condition = DIA_Vatras_StillNeedYou_Condition;
	information = DIA_Vatras_StillNeedYou_Info;
	permanent = TRUE;
	description = "Come with me to the enemy's island.";
};


func int DIA_Vatras_StillNeedYou_Condition()
{
	if(((Vatras_IsOnBoard == LOG_OBSOLETE) || (Vatras_IsOnBoard == LOG_FAILED)) && (Crewmember_Count < Max_Crew))
	{
		return TRUE;
	};
};

func void DIA_Vatras_StillNeedYou_Info()
{
	AI_Output(other,self,"DIA_Vatras_StillNeedYou_15_00");	//ome with me to the enemy's island.
	if(Vatras_WasOnBoard == TRUE)
	{
		AI_Output(self,other,"DIA_Vatras_StillNeedYou_05_01");	//A wise decision. I hope you are going to stick with it now.
	}
	else
	{
		AI_Output(self,other,"DIA_Vatras_KnowWhereEnemy_Yes_05_01");	//Don't take too much time. The enemy does not sleep, my friend.
	};
	B_Vatras_GeheWeg(lang);
	if(Vatras_JoinShip_Once == FALSE)
	{
		Info_ClearChoices(DIA_Vatras_StillNeedYou);
		Info_AddChoice(DIA_Vatras_StillNeedYou,Dialog_Ende,DIA_Vatras_JoinShip);
	}
	else
	{
		B_JoinShip(self);
	};
};


instance DIA_Addon_Vatras_PISSOFFFOREVVER(C_Info)
{
	npc = VLK_439_Vatras;
	nr = 1;
	condition = DIA_Addon_Vatras_PISSOFFFOREVVER_Condition;
	information = DIA_Addon_Vatras_PISSOFFFOREVVER_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Addon_Vatras_PISSOFFFOREVVER_Condition()
{
	if((VatrasPissedOffForever == TRUE) && (Kapitel >= 5))
	{
		return TRUE;
	};
};

func void DIA_Addon_Vatras_PISSOFFFOREVVER_Info()
{
	B_VatrasPissedOff();
//	AI_StopProcessInfos(self);
//	Vatras_MORE = FALSE;
};

