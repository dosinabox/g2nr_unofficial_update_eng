
instance DIA_Torlof_EXIT(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 999;
	condition = DIA_Torlof_EXIT_Condition;
	information = DIA_Torlof_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Torlof_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Torlof_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Torlof_Hallo(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 1;
	condition = DIA_Torlof_HALLO_Condition;
	information = DIA_Torlof_HALLO_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Torlof_HALLO_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_HALLO_Info()
{
	AI_Output (self, other, "DIA_Torlof_Hallo_01_00");	//(grumpy) What do you want from me?
};


instance DIA_Torlof_WannaJoin(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 2;
	condition = DIA_Torlof_WannaJoin_Condition;
	information = DIA_Torlof_WannaJoin_Info;
	permanent = FALSE;
	description = "I want to join the mercenaries!";
};


func int DIA_Torlof_WannaJoin_Condition()
{
	if(other.guild == GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_Torlof_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Torlof_WannaJoin_15_00");	//I want to join the mercenaries!
	AI_Output (self, other, "DIA_Torlof_WannaJoin_01_01");	//Oh? And why do you think I should be in favor of you being accepted here?
};


var int Torlof_Go;

instance DIA_Torlof_Probe(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 3;
	condition = DIA_Torlof_Probe_Condition;
	information = DIA_Torlof_Probe_Info;
	permanent = TRUE;
	description = "Put me to the test!";
};


func int DIA_Torlof_Probe_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Torlof_WannaJoin) && (hero.guild == GIL_NONE) && (Torlof_Go == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_Probe_Info()
{
	AI_Output (other, self, "DIA_Torlof_Probe_15_00");	//Put me to the test!
	AI_Output (self, other, "DIA_Torlof_Probe_01_01");	//Did Lee send you to me?
	if (Npc_KnowsInfo (other, DIA_Lee_OtherSld))
	{
		AI_Output (other, self, "DIA_Torlof_Probe_15_02");	//He said you would help me.
		AI_Output (self, other, "DIA_Torlof_Probe_01_03");	//(sigh) Fine. So here we go: There are two things you have to do before you can join us.
		AI_Output (self, other, "DIA_Torlof_Probe_01_04");	//First: You have to prove that you're capable of mastering the tasks that you will have to fulfill as a mercenary. I'll put you to the test.
		AI_Output (self, other, "DIA_Torlof_Probe_01_05");	//And second: You have to earn the respect of the other mercenaries.
		SCKnowsSLDVotes = TRUE;
		Torlof_Go = TRUE;
		Npc_ExchangeRoutine (self, "Start");
		Log_CreateTopic (TOPIC_BecomeSLD, LOG_MISSION);
		Log_SetTopicStatus (TOPIC_BecomeSLD, LOG_Running);
		B_LogEntry (TOPIC_BecomeSLD, "To be accepted as a mercenary, I have to let Torlof put me to the test and earn the respect of the other mercenaries.");
	}
	else
	{
		AI_Output (other, self, "DIA_Torlof_Probe_15_06");	//No.
		AI_Output (self, other, "DIA_Torlof_Probe_01_07");	//Then what are you blathering at me for?
		AI_StopProcessInfos (self);
	};
};


instance DIA_Torlof_Respekt(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 4;
	condition = DIA_Torlof_Respekt_Condition;
	information = DIA_Torlof_Respekt_Info;
	permanent = FALSE;
	description = "How can I earn the respect of the other mercenaries? ";
};


func int DIA_Torlof_Respekt_Condition()
{
	if((Torlof_Go == TRUE) && (hero.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_Respekt_Info()
{
	AI_Output (other, self, "DIA_Torlof_Respekt_15_00");	//How can I earn the respect of the other mercenaries?
	AI_Output (self, other, "DIA_Torlof_Respekt_01_01");	//For most of them, it will be enough if you fulfill your task and pass my test.
	AI_Output (self, other, "DIA_Torlof_Respekt_01_02");	//But you'll have to find some other way of convincing some of them.
	AI_Output (self, other, "DIA_Torlof_Respekt_01_03");	//Some will try and exploit your situation, and others may not like your mug.
	AI_Output (self, other, "DIA_Torlof_Respekt_01_04");	//You should try to get along with as many of the boys as possible - but if nothing else helps, you can always take part in a duel.
	AI_Output (self, other, "DIA_Torlof_Respekt_01_05");	//If you win, you'll earn the respect of most of them. But watch out that you don't kill one of them by accident. Because then you'll have a big problem.
	if(Torlof_GenugStimmen == FALSE)
	{
		Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
	};
	B_LogEntry(TOPIC_SLDRespekt,"If I want the other mercenaries to respect me, I have to pass the test Torlof sets me. They'll also be convinced if I can beat them in a duel.");
};


instance DIA_Torlof_Duellregeln(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 5;
	condition = DIA_Torlof_Duellregeln_Condition;
	information = DIA_Torlof_Duellregeln_Info;
	permanent = FALSE;
	description = "What are the rules for a duel?";
};


func int DIA_Torlof_Duellregeln_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Torlof_Respekt) || Npc_KnowsInfo(other,DIA_Jarvis_MissionKO))
	{
		return TRUE;
	};
};

func void DIA_Torlof_Duellregeln_Info()
{
	AI_Output (other, self, "DIA_Torlof_Duellregeln_15_00");	//What are the rules for a duel?
	AI_Output (self, other, "DIA_Torlof_Duellregeln_01_01");	//Quite simple. Both opponents have to have the opportunity to draw their weapons before the first blow.
	AI_Output (self, other, "DIA_Torlof_Duellregeln_01_02");	//You can't just go and belt one of the men without warning.
	AI_Output (self, other, "DIA_Torlof_Duellregeln_01_03");	//There has to be some sort of spoken challenge. An insult, or another reason to fight.
	AI_Output (self, other, "DIA_Torlof_Duellregeln_01_04");	//None of the other men will interfere in a fight like that. Unless one of the two gets killed in the duel.
	if(other.guild == GIL_NONE)
	{
		if(Torlof_GenugStimmen == FALSE)
		{
			Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
		};
		B_LogEntry(TOPIC_SLDRespekt,"The rules for a duel: A duel must be started with a challenge, that way no one else will get involved. There must be no killing in a duel.");
	};
};


instance DIA_Torlof_DeineStimme(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 6;
	condition = DIA_Torlof_DeineStimme_Condition;
	information = DIA_Torlof_DeineStimme_Info;
	permanent = FALSE;
	description = "What about you? Will you vote me in?";
};


func int DIA_Torlof_DeineStimme_Condition()
{
	if((Torlof_Go == TRUE) && (other.guild == GIL_NONE) && (MIS_Torlof_HolPachtVonSekob != LOG_SUCCESS) && (MIS_Torlof_BengarMilizKlatschen != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Torlof_DeineStimme_Info()
{
	AI_Output (other, self, "DIA_Torlof_DeineStimme_15_00");	//What about you? Will you vote me in?
	AI_Output (self, other, "DIA_Torlof_DeineStimme_01_01");	//If you can prove that you can fulfill the duties of a mercenary, yes.
};


var int Points_Sld;

instance DIA_Torlof_RUF(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 7;
	condition = DIA_Torlof_RUF_Condition;
	information = DIA_Torlof_RUF_Info;
	permanent = TRUE;
	description = "How's my reputation among the mercenaries?";
};


func int DIA_Torlof_RUF_Condition()
{
	if((Torlof_Go == TRUE) && (Torlof_GenugStimmen == FALSE) && (hero.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_RUF_Info()
{
	AI_Output (other, self, "DIA_Torlof_RUF_15_00");	//How's my reputation among the mercenaries?
	AI_Output (self, other, "DIA_Torlof_RUF_01_01");	//Let's see...
	Points_Sld = 0;
	if(Npc_IsDead(SLD_Wolf))
	{
		Points_Sld += 1;
	}
	else if(SLD_Wolf.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_02");	//Wolf says he has nothing against you joining.
		Points_Sld += 1;
	};
	if(Npc_IsDead(Jarvis))
	{
		Points_Sld += 1;
	}
	else if(MIS_Jarvis_SldKO == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_03");	//Jarvis thinks you're on the right side.
		Points_Sld += 1;
	}
	else if(Jarvis.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_04");	//Jarvis still isn't sure if you're on the right side.
		AI_Output (self, other, "DIA_Torlof_RUF_01_05");	//He doesn't want more people dancing to Sylvio's tune. For that matter, neither do I.
	};
	if(Npc_IsDead(Cord))
	{
		Points_Sld += 1;
	}
	else if(Cord_Voted == TRUE)
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_06");	//Cord thinks you would be good enough to join.
		Points_Sld += 1;
	}
	else if(Cord.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_07");	//It's Cord's opinion that you first need to learn how to handle weapons better.
	};
	if(Npc_IsDead(Cipher))
	{
		Points_Sld += 1;
	}
	else if(GotCipherVote == TRUE)
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_08");	//Cipher says that for him it was crystal clear that you'd get to join. Something seems to have made him really happy.
		Points_Sld += 1;
	}
	else if(Cipher.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_09");	//Cipher says you owe him a little favor, and that you know what that's all about.
	};
	if(Npc_IsDead(Rod))
	{
		Points_Sld += 1;
	}
	else if(!Npc_HasItems(Rod,ItMw_2h_Rod))
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_10");	//Rod just wants to have his sword back.
	}
	else if((Rod.aivar[AIV_DefeatedByPlayer] == TRUE) || (Rod_WetteGewonnen == TRUE))
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_11");	//You seem to have convinced Rod that you're strong enough.
		if (Rod.aivar[AIV_DefeatedByPlayer] == FALSE)
		{
			Points_Sld += 1;
		};
	}
	else if(Rod.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_12");	//Rod thinks you're a weakling.
	};
	if(Npc_IsDead(Sentenza))
	{
		Points_Sld += 1;
	}
	else if(Npc_HasItems(Sentenza,ItMi_Gold) >= 50)
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_13");	//Sentenza will vote for you. He says you were a very reasonable man.
		Points_Sld += 1;
		Torlof_SentenzaCounted = TRUE;
	}
	else if(Sentenza.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_14");	//Sentenza won't vote for you. He says you still owe him 50 gold pieces.
	};
	if(Npc_IsDead(Raoul))
	{
		Points_Sld += 1;
	}
	else if(Raoul.aivar[AIV_DefeatedByPlayer] == FALSE)
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_15");	//Raoul is against you. I think he can't stand you.
	}
	else
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_15_add");	//Raoul says he has nothing against you joining.@@@
		Points_Sld += 1;
	};
	if(Npc_IsDead(Bullco))
	{
		Points_Sld += 1;
	}
	else if(Bullco.aivar[AIV_DefeatedByPlayer] == FALSE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_16");	//I don't need to say anything about Sylvio and Bullco. Those two morons are against everyone.
	};
	if(Npc_IsDead(Buster))
	{
		Points_Sld += 1;
	}
	else if(Buster_Duell == TRUE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_17");	//Buster says you're okay.
		if (Buster.aivar[AIV_DefeatedByPlayer] == FALSE)
		{
			AI_Output (self, other, "DIA_Torlof_RUF_01_18");	//Although you lost to him.
		};
		Points_Sld += 1;
	}
	else if(Buster.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_19");	//Buster said you chickened out when he challenged you.
		AI_Output (self, other, "DIA_Torlof_RUF_01_20");	//That's not a good idea. Maybe you should go back to the outpost and challenge him.
	};
	if(Npc_IsDead(Dar))
	{
		Points_Sld += 1;
	}
	else if(Dar_LostAgainstCipher == TRUE)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_21");	//And Dar says you're a blabbermouth. But his vote doesn't count for very much here.
	};
	if(Points_Sld > 0)
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_22");	//The rest of the mercenaries haven't said anything.
	};
	if((MIS_Torlof_HolPachtVonSekob != LOG_SUCCESS) && (MIS_Torlof_BengarMilizKlatschen != LOG_SUCCESS))
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_23");	//Most of them are just waiting to see if you pass the test.
	}
	else
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_24");	//You convinced most of them by passing the test.
		if (Cord_RangerHelp_TorlofsProbe == TRUE)
		{
			AI_Output(self,other,"DIA_Addon_Torlof_RUF_01_00");	//(grins) Even if Cord had a little hand in it...
			Points_Sld += 4;
		}
		else if(MIS_Torlof_HolPachtVonSekob == LOG_SUCCESS)
		{
			AI_Output(self,other,"DIA_Torlof_RUF_01_25");	//Although a lot of them say that getting a farmer to pay his rent was too easy for a test.
			Points_Sld += 3;
		}
		else
		{
			Points_Sld += 5;
		};
		AI_Output(self,other,"DIA_Torlof_RUF_01_26");	//You have my vote, in any case.
		if(GotTorlofVote == FALSE)
		{
			if(Torlof_GenugStimmen == FALSE)
			{
				Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
				Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
			};
			B_LogEntry(TOPIC_SLDRespekt,"Torlof thinks I'm capable of handling the responsibilities of a mercenary.");
			GotTorlofVote = TRUE;
		};
		Points_Sld += 1;
	};
	if(Sld_Duelle_gewonnen >= 3)
	{
		Points_Sld += 1;
		if(Points_Sld >= 9)
		{
			AI_Output (self, other, "DIA_Torlof_RUF_01_27");	//And you won some fair duels.
			AI_Output (self, other, "DIA_Torlof_RUF_01_28");	//A lot of mercenaries respect that.
		}
		else
		{
			AI_Output (self, other, "DIA_Torlof_RUF_01_29");	//At any rate, you won some fair duels already.
		};
	};
	if((Points_Sld >= 9) && ((MIS_Torlof_HolPachtVonSekob == LOG_SUCCESS) || (MIS_Torlof_BengarMilizKlatschen == LOG_SUCCESS)))
	{
		AI_Output (self, other, "DIA_Torlof_RUF_01_30");	//Most of the mercenaries are for you - as far as we're concerned, you can start with us any time.
		AI_Output (self, other, "DIA_Torlof_RUF_01_31");	//Go to Lee. He'll explain everything else to you.
		B_LogEntry(TOPIC_BecomeSLD,"I've earned enough respect from the mercenaries. Now I should have a word with Lee.");
		Torlof_GenugStimmen = TRUE;
		B_CheckLog();
	}
	else if(Points_Sld >= 7)
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_32");	//That's quite a lot, but it still isn't enough.
		if(Sld_Duelle_gewonnen < 3)
		{
			AI_Output(self,other,"DIA_Torlof_RUF_01_33");	//You'll have to keep fighting with the boys for a while.
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Torlof_RUF_01_34");	//You're far from done, kid. If you want us to accept you, you'll have to do something for it.
	};
};


instance DIA_Torlof_Aufgaben(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 8;
	condition = DIA_Torlof_Aufgaben_Condition;
	information = DIA_Torlof_Aufgaben_Info;
	permanent = FALSE;
	description = "What are my duties as a mercenary?";
};


func int DIA_Torlof_Aufgaben_Condition()
{
	if((Torlof_Go == TRUE) && (hero.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_Aufgaben_Info()
{
	AI_Output (other, self, "DIA_Torlof_Aufgaben_15_00");	//What are my duties as a mercenary?
	AI_Output (self, other, "DIA_Torlof_Aufgaben_01_01");	//Onar hired us for two reasons: He wants us to keep the militia off his back, and he wants us to keep things in order on his farms.
	AI_Output (self, other, "DIA_Torlof_Aufgaben_01_02");	//That includes collecting the rent when the small farmers won't pay.
	AI_Output (self, other, "DIA_Torlof_Aufgaben_01_03");	//So, what'll it be?
	Info_ClearChoices (DIA_Torlof_Aufgaben);
	Info_AddChoice (DIA_Torlof_Aufgaben, "Let me collect the rent!", DIA_Torlof_Aufgaben_Pacht);
	Info_AddChoice (DIA_Torlof_Aufgaben, "I'll deal with the militia, don't worry!", DIA_Torlof_Aufgaben_Miliz);
};

func void B_Torlof_HolPachtVonSekob()
{
	AI_Output (self, other, "B_Torlof_HolPachtvonSekob_01_00");	//Good. Listen. The farmer Sekob hasn't paid his rent to Onar for weeks.
	AI_Output (self, other, "B_Torlof_HolPachtvonSekob_01_01");	//Onar wants him to cough up 50 gold pieces. Any questions?
	if(Sekob.aivar[AIV_TalkedToPlayer] == FALSE)
	{
			AI_Output (other, self, "B_Torlof_HolPachtvonSekob_15_02");	//Where is Sekob's farm?
			AI_Output (self, other, "B_Torlof_HolPachtvonSekob_01_03");	//In the north of the valley. Looking from here, that's to the right at the big crossroad.
			AI_Output (self, other, "B_Torlof_HolPachtvonSekob_01_04");	//If you have problems, the farmers in the fields will help you find your way around the area.
	}
	else
	{
		DIA_Common_No();
	};
	MIS_Torlof_HolPachtVonSekob = LOG_Running;
	Sekob.flags = 0;
//	CreateInvItems(Sekob,ItMi_Gold,50);
	Log_CreateTopic(TOPIC_TorlofPacht,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_TorlofPacht,LOG_Running);
	B_LogEntry(TOPIC_TorlofPacht,"Torlof has tasked me to collect the rent from the farmer Sekob. He's got to pay 50 pieces of gold.");
};

func void B_Torlof_BengarMilizKlatschen()
{
	AI_Output (self, other, "B_Torlof_BengarMilizKlatschen_01_00");	//The farmer Bengar has complained that lately the militia from the city has been getting on his nerves.
	AI_Output (self, other, "B_Torlof_BengarMilizKlatschen_01_01");	//They're pressuring the farmer - probably trying to make him break with Onar.
	AI_Output (self, other, "B_Torlof_BengarMilizKlatschen_01_02");	//I want you to go to his farm and make it clear to the militia that they have no business there! Questions?
	if(Bengar.aivar[AIV_TalkedToPlayer] == FALSE)
	{
	AI_Output (other, self, "B_Torlof_BengarMilizKlatschen_15_03");	//How can I find Bengar's farm?
	AI_Output (self, other, "B_Torlof_BengarMilizKlatschen_01_04");	//In the southwest of the valley is a big stairway that leads to a high plain. That's where Bengar's farm is.
	AI_Output (self, other, "B_Torlof_BengarMilizKlatschen_01_05");	//If you get lost, ask the farmers in the fields how to find your way around the area.
	}
	else
	{
		DIA_Common_No();
	};
	MIS_Torlof_BengarMilizKlatschen = LOG_Running;
	Bengar.flags = 0;
	Wld_InsertNpc(MIL_335_Rumbold,"FARM3");
	Wld_InsertNpc(MIL_336_Rick,"FARM3");
	B_InitNpcGlobals();
	Log_CreateTopic(TOPIC_TorlofMiliz,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_TorlofMiliz,LOG_Running);
	B_LogEntry(TOPIC_TorlofMiliz,"Torlof has tasked me to drive away the militia from farmer Bengar's farm. It's on the high plain.");
};

func void DIA_Torlof_Aufgaben_Pacht()
{
	AI_Output (other, self, "DIA_Torlof_Aufgaben_Pacht_15_00");	//Let me collect the rent!
	B_Torlof_HolPachtVonSekob ();
	Torlof_Probe = Probe_Sekob;
	Info_ClearChoices(DIA_Torlof_Aufgaben);
};

func void DIA_Torlof_Aufgaben_Miliz()
{
	AI_Output (other, self, "DIA_Torlof_Aufgaben_Miliz_15_00");	//I'll deal with the militia, don't worry!
	B_Torlof_BengarMilizKlatschen ();
	Torlof_Probe = Probe_Bengar;
	Info_ClearChoices(DIA_Torlof_Aufgaben);
};


var int Torlof_TheOtherMission_Day;

func void B_Torlof_TheOtherMissionDay()
{
	if(Torlof_TheOtherMission_Day < (Wld_GetDay() - 1))
	{
		AI_Output (self, other, "B_Torlof_TheOtherMissionDay_01_00");	//You took an awfully long time there. Onar won't be very happy.
		Torlof_TheOtherMission_TooLate = TRUE;
		if(Enter_OldWorld_FirstTime_Trigger_OneTime == TRUE)
		{
			AI_Output (self, other, "DIA_Torlof_Add_01_00");	//And it's all the same to him if the paladins get eaten in the Valley of Mines or not ...
		};
	}
	else
	{
		AI_Output (self, other, "B_Torlof_TheOtherMissionDay_01_01");	//Well done! When I have something new, I'll let you know.
	};
};


instance DIA_Torlof_SekobSuccess(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 9;
	condition = DIA_Torlof_SekobSuccess_Condition;
	information = DIA_Torlof_SekobSuccess_Info;
	permanent = TRUE;
	description = "I collected the rent from Sekob.";
};


func int DIA_Torlof_SekobSuccess_Condition()
{
	if(MIS_Torlof_HolPachtVonSekob == LOG_Running)
	{
		if((Sekob.aivar[AIV_DefeatedByPlayer] == TRUE) || Npc_IsDead(Sekob))
		{
			return TRUE;
		};
	};
};

func void DIA_Torlof_SekobSuccess_Info()
{
	AI_Output (other, self, "DIA_Torlof_SekobSuccess_15_00");	//I collected the rent from Sekob.
	if (B_GiveInvItems (other, self, ItMi_Gold, 50))
	{
		AI_Output (self, other, "DIA_Torlof_SekobSuccess_01_01");	//And? Did he pay willingly?
		if (Npc_IsDead (Sekob))
		{
			AI_Output (other, self, "DIA_Torlof_SekobTot_15_00");	//Well, he had a deadly accident...
		}
		else
		{
			AI_Output (other, self, "DIA_Torlof_SekobSuccess_15_02");	//I had to convince him first.
		};
		if(Torlof_Probe == Probe_Sekob)
		{
			AI_Output (self, other, "DIA_Torlof_SekobSuccess_01_03");	//Well done! You passed your test. That will convince a lot of the mercenaries that you have what it takes.
		}
		else
		{
			B_Torlof_TheOtherMissionDay();
		};
		MIS_Torlof_HolPachtVonSekob = LOG_SUCCESS;
		B_GivePlayerXP(XP_Torlof_SekobsKohlebekommen);
		if(hero.guild == GIL_NONE)
		{
			B_LogEntry(TOPIC_BecomeSLD,"I have completed the task Torlof gave me.");
		};
		Torlof_ProbeBestanden = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Torlof_SekobSuccess_01_04");	//And? Did you blow it on booze? Bring me the money! And be quick about it!
	};
};


instance DIA_Torlof_BengarSuccess(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 10;
	condition = DIA_Torlof_BengarSuccess_Condition;
	information = DIA_Torlof_BengarSuccess_Info;
	permanent = FALSE;
	description = "I took care of Bengar's militia problem.";
};


func int DIA_Torlof_BengarSuccess_Condition()
{
//	if((MIS_Torlof_BengarMilizKlatschen == LOG_Running) && Npc_IsDead(Rumbold) && Npc_IsDead(Rick))
	if((MIS_Torlof_BengarMilizKlatschen == LOG_Running) && ((Npc_IsDead(Rumbold) && Npc_IsDead(Rick)) || (Miliz_Flucht == TRUE) || (Bengar_MilSuccess == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Torlof_BengarSuccess_Info()
{
	AI_Output (other, self, "DIA_Torlof_BengarSuccess_15_00");	//I took care of Bengar's militia problem.
	AI_Output (self, other, "DIA_Torlof_BengarSuccess_01_01");	//Did you make sure that they won't be standing on his doorstep again tomorrow?
	AI_Output (other, self, "DIA_Torlof_BengarSuccess_15_02");	//They'd have a really hard time doing that...
	if(Torlof_Probe == Probe_Bengar)
	{
		AI_Output(self,other,"DIA_Torlof_BengarSuccess_01_03");	//Well done!
		AI_Output(self,other,"DIA_Torlof_BengarSuccess_01_04");	///You passed your test. If you can handle the militia, most here will respect you.
	}
	else
	{
		B_Torlof_TheOtherMissionDay();
	};
	MIS_Torlof_BengarMilizKlatschen = LOG_SUCCESS;
	B_GivePlayerXP(XP_Bengar_MILIZKLATSCHEN);
	if(hero.guild == GIL_NONE)
	{
		B_LogEntry(TOPIC_BecomeSLD,"I have completed the task Torlof gave me.");
	};
	Torlof_ProbeBestanden = TRUE;
};


instance DIA_Torlof_Welcome(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 11;
	condition = DIA_Torlof_Welcome_Condition;
	information = DIA_Torlof_Welcome_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Torlof_Welcome_Condition()
{
	if((other.guild == GIL_SLD) && (Kapitel == 1))
	{
		return TRUE;
	};
};

func void DIA_Torlof_Welcome_Info()
{
	AI_Output (self, other, "DIA_Torlof_Welcome_01_00");	//Welcome to the mercenaries, kid!
	AI_Output (other, self, "DIA_Torlof_Welcome_15_01");	//Thanks!
	AI_Output (self, other, "DIA_Torlof_Welcome_01_02");	//As soon as I have something for you to do, I'll let you know.
};


var int Torlof_KnowsDragons;

func void B_Torlof_Dragons()
{
	AI_Output (self, other, "DIA_Torlof_Add_01_01");	//Where have you been?
	AI_Output (other, self, "DIA_Torlof_Add_15_02");	//I was in the Valley of Mines! There are dragons there! They gave the paladins a pretty hard time!
	AI_Output (self, other, "DIA_Torlof_Add_01_03");	//So? Then there really is something to the stories!
	AI_Output (self, other, "DIA_Torlof_Add_01_04");	//Lee will be interested ...
	Torlof_KnowsDragons = TRUE;
};


instance DIA_Torlof_TheOtherMission(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 11;
	condition = DIA_Torlof_TheOtherMission_Condition;
	information = DIA_Torlof_TheOtherMission_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Torlof_TheOtherMission_Condition()
{
	if((other.guild == GIL_SLD) && (Kapitel >= 2))
	{
		return TRUE;
	};
};

func void DIA_Torlof_TheOtherMission_Info()
{
	if((Torlof_KnowsDragons == FALSE) && (Enter_OldWorld_FirstTime_Trigger_OneTime == TRUE))
	{
		B_Torlof_Dragons();
	};
	AI_Output (self, other, "DIA_Torlof_TheOtherMission_01_00");	//Good thing you're here. I've got something for you to do ...
	AI_Output (other, self, "DIA_Torlof_TheOtherMission_15_01");	//What is it?
	if (Torlof_Probe == Probe_Bengar)
	{
		B_Torlof_HolPachtVonSekob();
	}
	else
	{
		B_Torlof_BengarMilizKlatschen();
	};
	AI_Output (self, other, "DIA_Torlof_TheOtherMission_01_02");	//And see to it that you finish by tomorrow!
	Torlof_TheOtherMission_Day = Wld_GetDay ();
};


instance DIA_Torlof_Dragons(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 12;
	condition = DIA_Torlof_Dragons_Condition;
	information = DIA_Torlof_Dragons_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Torlof_Dragons_Condition()
{
	if((Enter_OldWorld_FirstTime_Trigger_OneTime == TRUE) && (Kapitel <= 3) && (other.guild == GIL_SLD) && (Torlof_KnowsDragons == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_Dragons_Info()
{
	B_Torlof_Dragons();
};


instance DIA_Torlof_WhatCanYouTeach(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 140;
	condition = DIA_Torlof_WhatCanYouTeach_Condition;
	information = DIA_Torlof_WhatCanYouTeach_Info;
	permanent = FALSE;
	description = "Can you help me improve my abilities?";
};


func int DIA_Torlof_WhatCanYouTeach_Condition()
{
	return TRUE;
};

func void DIA_Torlof_WhatCanYouTeach_Info()
{
	AI_Output (other, self, "DIA_Torlof_WhatCanYouTeach_15_00");	//Can you help me improve my abilities?
	AI_Output (self, other, "DIA_Torlof_WhatCanYouTeach_01_01");	//I could show you how you can use your strength better in close combat.
	AI_Output (self, other, "DIA_Torlof_WhatCanYouTeach_01_02");	//A lot of fighters are very weak because they don't have the technique to use their strength properly.
	AI_Output (self, other, "DIA_Torlof_WhatCanYouTeach_01_03");	//The same is true for dexterity and ranged weapons.
};


var int Torlof_Merke_STR;
var int Torlof_Merke_DEX;
var int Log_TorlofTeach;

func void B_BuildLearnDialog_Torlof_NW()
{
	Info_ClearChoices(DIA_Torlof_Teach);
	Info_AddChoice(DIA_Torlof_Teach,Dialog_Back,DIA_Torlof_Teach_Back);
	Info_AddChoice(DIA_Torlof_Teach,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_Torlof_Teach_DEX_1);
	Info_AddChoice(DIA_Torlof_Teach,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_Torlof_Teach_DEX_5);
	Info_AddChoice(DIA_Torlof_Teach,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_Torlof_Teach_STR_1);
	Info_AddChoice(DIA_Torlof_Teach,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_Torlof_Teach_STR_5);
};

instance DIA_Torlof_Teach(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 150;
	condition = DIA_Torlof_Teach_Condition;
	information = DIA_Torlof_Teach_Info;
	permanent = TRUE;
	description = "I want to improve my abilities!";
};


func int DIA_Torlof_Teach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Torlof_WhatCanYouTeach))
	{
		return TRUE;
	};
};

func void DIA_Torlof_Teach_Info()
{
	AI_Output(other,self,"DIA_Torlof_Teach_15_00");	//I want to improve my abilities!
	if((other.guild == GIL_SLD) || (other.guild == GIL_DJG) || (TorlofIsCaptain == TRUE) || ((other.guild == GIL_NONE) && (Torlof_Go == TRUE)))
	{
		if(Log_TorlofTeach == FALSE)
		{
			Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
			B_LogEntry(TOPIC_SoldierTeacher,"Torlof can help me improve my dexterity and strength.");
			Log_TorlofTeach = TRUE;
		};
		Torlof_Merke_STR = other.aivar[REAL_STRENGTH];
		Torlof_Merke_DEX = other.aivar[REAL_DEXTERITY];
		B_BuildLearnDialog_Torlof_NW();
	}
	else
	{
		AI_Output(self,other,"DIA_Torlof_Teach_01_01");	//I said I COULD help you, not that I WOULD.
		if(other.guild == GIL_NONE)
		{
			AI_Output(self,other,"DIA_Torlof_Teach_01_02");	//As long as you aren't one of us, you can find someone else to instruct you!
			if(Log_TorlofTeach == FALSE)
			{
				Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
				B_LogEntry(TOPIC_SoldierTeacher,"Torlof can increase my strength and dexterity, but only when I decide to join the mercenaries.");
				Log_TorlofTeach = TRUE;
			};
		};
	};
};

func void DIA_Torlof_Teach_Back()
{
	if((Torlof_Merke_STR < other.aivar[REAL_STRENGTH]) || (Torlof_Merke_DEX < other.aivar[REAL_DEXTERITY]))
	{
		AI_Output (self, other, "DIA_Torlof_Teach_Back_01_00");	//Good! Now you can use your abilities better!
	};
	Info_ClearChoices(DIA_Torlof_Teach);
};

func void DIA_Torlof_Teach_STR_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_MAX))
	{
		B_BuildLearnDialog_Torlof_NW();
	};
};

func void DIA_Torlof_Teach_STR_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_MAX))
	{
		B_BuildLearnDialog_Torlof_NW();
	};
};

func void DIA_Torlof_Teach_DEX_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MED))
	{
		B_BuildLearnDialog_Torlof_NW();
	};
};

func void DIA_Torlof_Teach_DEX_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MED))
	{
		B_BuildLearnDialog_Torlof_NW();
	};
};

instance DIA_Torlof_DEMENTOREN(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 30;
	condition = DIA_Torlof_DEMENTOREN_Condition;
	information = DIA_Torlof_DEMENTOREN_Info;
	description = "Have you got something for me to do?";
};


func int DIA_Torlof_DEMENTOREN_Condition()
{
	if(Kapitel >= 3)
	{
		return TRUE;
	};
};

func void DIA_Torlof_DEMENTOREN_Info()
{
	AI_Output (other, self, "DIA_Torlof_DEMENTOREN_15_00");	//Have you got something for me to do?
	AI_Output (self, other, "DIA_Torlof_DEMENTOREN_01_01");	//Have you seen those black-hooded guys creeping by here? Those people give me the willies, I'll tell you.
	AI_Output (self, other, "DIA_Torlof_DEMENTOREN_01_02");	//When I was at sea, I saw some pretty curious things, but those fellows really scare me.
	TorlofIsSailor = TRUE;	
	AI_Output (self, other, "DIA_Torlof_DEMENTOREN_01_03");	//They went in the direction of the bandit camp in the mountains at the southern end of the valley.
	AI_Output (self, other, "DIA_Torlof_DEMENTOREN_01_04");	//Maybe you should go there to check on those guys, and do away with them!
	Wld_InsertNpc (CastlemineDMT, "FP_STAND_DEMENTOR_KDF_12");
	Log_CreateTopic (TOPIC_Torlof_Dmt, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Torlof_Dmt, LOG_Running);
	B_LogEntry (TOPIC_Torlof_Dmt, "There are supposed to be some of those black-hooded guys at the bandits' camp in the mountains in the south of the valley. They give Torlof heartburn. I'm to solve that problem for him.");
	MIS_Torlof_Dmt = LOG_Running;
};


instance DIA_Torlof_DmtSuccess(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 30;
	condition = DIA_Torlof_DmtSuccess_Condition;
	information = DIA_Torlof_DmtSuccess_Info;
	description = "The black-hooded men in the mountains are no longer with us.";
};


func int DIA_Torlof_DmtSuccess_Condition()
{
	if((MIS_Torlof_Dmt == LOG_Running) && Npc_IsDead(CastlemineDMT))
	{
		return TRUE;
	};
};

func void DIA_Torlof_DmtSuccess_Info()
{
	AI_Output (other, self, "DIA_Torlof_DmtSuccess_15_00");	//The black-hooded men in the mountains are no longer with us.
	AI_Output (self, other, "DIA_Torlof_DmtSuccess_01_01");	//You were able to deal with them? Good man!
	AI_Output (self, other, "DIA_Torlof_DmtSuccess_01_02");	//I didn't trust those guys one bit. They were bound to cause a lot of trouble ...
	MIS_Torlof_Dmt = LOG_SUCCESS;
	B_GivePlayerXP(XP_Torlof_DMT);
};


instance DIA_Torlof_WOISTSYLVIO(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 40;
	condition = DIA_Torlof_WOISTSYLVIO_Condition;
	information = DIA_Torlof_WOISTSYLVIO_Info;
	description = "Some of the mercenaries have left?";
};


func int DIA_Torlof_WOISTSYLVIO_Condition()
{
	if(MIS_ReadyforChapter4 == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Torlof_WOISTSYLVIO_Info()
{
	AI_Output (other, self, "DIA_Torlof_WOISTSYLVIO_15_00");	//Some of the mercenaries have left?
	AI_Output (self, other, "DIA_Torlof_WOISTSYLVIO_01_01");	//Sylvio took a few of the boys and disappeared over the pass.
	AI_Output (self, other, "DIA_Torlof_WOISTSYLVIO_01_02");	//It's rumored that some dragons have shown up there. When he heard that, there was no stopping him.
	AI_Output (self, other, "DIA_Torlof_WOISTSYLVIO_01_03");	//Who knows? A dragon trophy is sure to bring a ton of money on the open market.
	AI_Output (self, other, "DIA_Torlof_WOISTSYLVIO_01_04");	//That's nothing for me. I'm a sailor. I belong on the sea and not in a stuffy dragon's den.
	TorlofIsSailor = TRUE;
};


instance DIA_Torlof_BEMYCAPTAIN(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 51;
	condition = DIA_Torlof_BEMYCAPTAIN_Condition;
	information = DIA_Torlof_BEMYCAPTAIN_Info;
	description = "You're a sailor?";
};


func int DIA_Torlof_BEMYCAPTAIN_Condition()
{
	if((Kapitel == 5) && (MIS_SCKnowsWayToIrdorath == TRUE) && (TorlofIsSailor == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_BEMYCAPTAIN_Info()
{
	AI_Output (other, self, "DIA_Torlof_BEMYCAPTAIN_15_00");	//You're a sailor?
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN_01_01");	//Did you finally catch on to that? Aye, damnit, I'm a sailor. Why do you ask?
	AI_Output (other, self, "DIA_Torlof_BEMYCAPTAIN_15_02");	//I could use your abilities. I need to go to an island.
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN_01_03");	//(laughs) To an island? You don't even have a ship, let alone a crew to man her.
	if((MIS_ShipIsFree == TRUE) && (Crewmember_Count >= Min_Crew))
	{
		AI_Output(other,self,"DIA_Hanna_AnyNews_Yes_15_00");	//Yeah, sure I do.
	};
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN_01_04");	//No, my boy. If you want to engage my services as a captain and strength teacher, then first you'll have to prove to me that you know what you're talking about.
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN_01_05");	//Besides which, I already have other worries. The paladins haven't pulled out of the city as expected.
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN_01_06");	//Something serious will have to happen to get them to clear the field.
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN_01_07");	//Go to the castle in the Valley of Mines. Steal the key for the main gate from the gate guard and open it. The orcs will take care of the rest!
	B_LogEntry(Topic_Captain,"Before Torlof will accept the post of captain, I must get the paladins to leave the city. He said to arrange an incident in the castle in the Valley of Mines. He wants me to steal the key to the main gate from the gate guard and let the orcs into the castle. He hopes that will make the paladins leave the city to help their comrades.");
};


instance DIA_Torlof_BEMYCAPTAIN2(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 52;
	condition = DIA_Torlof_BEMYCAPTAIN2_Condition;
	information = DIA_Torlof_BEMYCAPTAIN2_Info;
	description = "The gate to the castle in the Valley of Mines is open ...";
};


func int DIA_Torlof_BEMYCAPTAIN2_Condition()
{
	if((MIS_OCGateOpen == TRUE) && Npc_KnowsInfo(other,DIA_Torlof_BEMYCAPTAIN))
	{
		return TRUE;
	};
};

func void DIA_Torlof_BEMYCAPTAIN2_Info()
{
	AI_Output (other, self, "DIA_Torlof_BEMYCAPTAIN2_15_00");	//The gate to the castle in the Valley of Mines is open and jammed. There's nothing to keep the orcs from storming the castle now.
	AI_Output (other, self, "DIA_Torlof_BEMYCAPTAIN2_15_01");	//The paladins in the castle have suffered some heavy losses against the orcs.
	AI_Output (other, self, "DIA_Torlof_BEMYCAPTAIN2_15_02");	//It won't be long now, I guess, before the paladins from the city advance to the Valley of Mines to get their boys out of the castle.
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN2_01_03");	//That's pleasant news. So now there's nothing to prevent me from escaping from this accursed region.
	B_GivePlayerXP (XP_Ambient);
};


instance DIA_Torlof_BEMYCAPTAIN3(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 53;
	condition = DIA_Torlof_BEMYCAPTAIN3_Condition;
	information = DIA_Torlof_BEMYCAPTAIN3_Info;
	permanent = TRUE;
	description = "Now will you help me get to the island?";
};


var int Torlof_PaidToBeCaptain;
var int Torlof_PaidToBeCaptain_Log_OneTime;

func int DIA_Torlof_BEMYCAPTAIN3_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Torlof_BEMYCAPTAIN2) && (Torlof_PaidToBeCaptain == FALSE) && (SCGotCaptain == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_BEMYCAPTAIN3_Info()
{
	AI_Output(other,self,"DIA_Torlof_BEMYCAPTAIN3_15_00");	//Now will you help me get to the island?
	if(Torlof_PaidToBeCaptain_Log_OneTime == FALSE)
	{
		AI_Output(self,other,"DIA_Torlof_BEMYCAPTAIN3_01_01");	//Oh, yeah. You wanted to go to an island. Mmh. I'll make you a suggestion.
		B_LogEntry(Topic_Captain,"Torlof is now willing to command the ship. Unfortunately, he wants a reward of 2500 pieces of gold.");
		Torlof_PaidToBeCaptain_Log_OneTime = TRUE;
	};
	AI_Output(self,other,"DIA_Torlof_BEMYCAPTAIN3_01_02");	//You pay me 2500 gold coins and I'll captain your ship.
	AI_Output(self,other,"DIA_Torlof_BEMYCAPTAIN3_01_03");	//For that, I'll also teach you strength and dexterity wherever you want to go.
	Info_ClearChoices(DIA_Torlof_BEMYCAPTAIN3);
	Info_AddChoice(DIA_Torlof_BEMYCAPTAIN3,"That's an awful lot of gold.",DIA_Torlof_BEMYCAPTAIN3_zuViel);
	Info_AddChoice(DIA_Torlof_BEMYCAPTAIN3,"All right. Here's your gold.",DIA_Torlof_BEMYCAPTAIN3_ok);
};

func void DIA_Torlof_BEMYCAPTAIN3_zuViel()
{
	AI_Output (other, self, "DIA_Torlof_BEMYCAPTAIN3_zuViel_15_00");	//That's an awful lot of gold.
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN3_zuViel_01_01");	//Well. Good help is expensive. You don't have any other choice. You won't find anyone else in this area to captain your ship.
	AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN3_zuViel_01_02");	//So pay the money and don't make any trouble.
	Info_ClearChoices(DIA_Torlof_BEMYCAPTAIN3);
};

func void DIA_Torlof_BEMYCAPTAIN3_ok()
{
	AI_Output (other, self, "DIA_Torlof_BEMYCAPTAIN3_ok_15_00");	//All right. Here's your gold.
	if (B_GiveInvItems (other, self, ItMi_Gold, 2500))
	{
		AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN3_ok_01_01");	//Wonderful. Now you just have to tell me exactly what I'm supposed to do.
		Torlof_PaidToBeCaptain = TRUE;
		B_LogEntry (Topic_Captain, "Now that I've given him 2500 pieces of gold, Torlof is prepared to come with me at last.");
	}
	else
	{
		AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN3_ok_01_02");	//Are you trying to fob me off with a few coins? First get the money. Then we'll see.
	};
	Info_ClearChoices(DIA_Torlof_BEMYCAPTAIN3);
};


instance DIA_Torlof_BEMYCAPTAIN4(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 54;
	condition = DIA_Torlof_BEMYCAPTAIN4_Condition;
	information = DIA_Torlof_BEMYCAPTAIN4_Info;
	permanent = TRUE;
	description = "Be my captain.";
};


func int DIA_Torlof_BEMYCAPTAIN4_Condition()
{
	if((SCGotCaptain == FALSE) && (Torlof_PaidToBeCaptain == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_BEMYCAPTAIN4_Info()
{
	AI_Output(other,self,"DIA_Torlof_BEMYCAPTAIN4_15_00");	//Be my captain.
	if(Npc_HasItems(self,ItMi_Gold) >= 2380)
	{
		AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN4_01_01");	//All right. Get me a ship and a sufficiently strong crew, and I'll take you to your damned island.
		AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN4_01_02");	//Do you have a nautical chart? We won't get far without one of those things.
		AI_Output (other, self, "DIA_Torlof_BEMYCAPTAIN4_15_03");	//I'll take care of all that. I'll see you at the harbor.
		AI_Output (self, other, "DIA_Torlof_BEMYCAPTAIN4_01_04");	//I can't wait to see how you do that.
		if(self.attribute[ATR_HITPOINTS] == 1)
		{
			self.attribute[ATR_HITPOINTS] += 1;
		};
		AI_StopProcessInfos(self);
		SCGotCaptain = TRUE;
		TorlofIsCaptain = TRUE;
		self.flags = NPC_FLAG_IMMORTAL;
		Npc_ExchangeRoutine(self,"WaitForShipCaptain");
		B_GivePlayerXP(XP_Captain_Success);
	}
	else
	{
		AI_Output(self,other,"DIA_Torlof_BEMYCAPTAIN3_ok_01_02");	//Are you trying to fob me off with a few coins? First get the money. Then we'll see.
		Torlof_PaidToBeCaptain = FALSE;
		AI_StopProcessInfos(self);
	};
};


instance DIA_Torlof_LOSFAHREN(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 59;
	condition = DIA_Torlof_LOSFAHREN_Condition;
	information = DIA_Torlof_LOSFAHREN_Info;
	permanent = TRUE;
	description = "Let's set out for the island.";
};


func int DIA_Torlof_LOSFAHREN_Condition()
{
	if((TorlofIsCaptain == TRUE) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_LOSFAHREN_Info()
{
	AI_Output(other,self,"DIA_Torlof_LOSFAHREN_15_00");	//Let's set out for the island.
	if(B_CaptainConditions(self))
	{
		AI_Output(self,other,"DIA_Torlof_LOSFAHREN_01_01");	//All right. Give me the chart and we're off.
		B_GiveInvItems(other,self,ItWr_Seamap_Irdorath,1);
		AI_Output (self, other, "DIA_Torlof_LOSFAHREN_01_02");	//(calls) All hands on board.
		AI_Output (self, other, "DIA_Torlof_LOSFAHREN_01_03");	//Make sure you really have everything you might need with you. There's no way back.
		AI_Output (self, other, "DIA_Torlof_LOSFAHREN_01_04");	//If you're sure, then go bunk down in the captain's cabin. The journey will take a while.
		if(C_BodyStateContains(self,BS_SIT))
		{
			AI_Standup(self);
			B_TurnToNpc(self,other);
		};
		AI_StopProcessInfos(self);
		B_CaptainCallsAllOnBoard(self);
	}
	else
	{
		AI_Output (self, other, "DIA_Torlof_LOSFAHREN_01_05");	//No ship, no crew, no sea chart, no trip, my friend.
		AI_Output (self, other, "DIA_Torlof_LOSFAHREN_01_06");	//I want to see at least 5 men, willing and able to sail a ship.
		AI_StopProcessInfos (self);
	};
};


instance DIA_Torlof_PERM5_NOTCAPTAIN(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 59;
	condition = DIA_Torlof_PERM5_NOTCAPTAIN_Condition;
	information = DIA_Torlof_PERM5_NOTCAPTAIN_Info;
	permanent = TRUE;
	description = "I've decided on a different captain.";
};


func int DIA_Torlof_PERM5_NOTCAPTAIN_Condition()
{
	if((SCGotCaptain == TRUE) && (TorlofIsCaptain == FALSE) && (Torlof_PaidToBeCaptain == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Torlof_PERM5_NOTCAPTAIN_Info()
{
	AI_Output (other, self, "DIA_Torlof_PERM5_NOTCAPTAIN_15_00");	//I've decided on a different captain. You can return my money now.
	AI_Output (self, other, "DIA_Torlof_PERM5_NOTCAPTAIN_01_01");	//Wouldn't you like that. Nothing doing. If you pay me first and then don't want my services after all, that's your problem.
	AI_StopProcessInfos(self);
};


instance DIA_Torlof_PICKPOCKET(C_Info)
{
	npc = SLD_801_Torlof;
	nr = 900;
	condition = DIA_Torlof_PICKPOCKET_Condition;
	information = DIA_Torlof_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Torlof_PICKPOCKET_Condition()
{
	return C_Beklauen(76,120);
};

func void DIA_Torlof_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Torlof_PICKPOCKET);
	Info_AddChoice(DIA_Torlof_PICKPOCKET,Dialog_Back,DIA_Torlof_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Torlof_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Torlof_PICKPOCKET_DoIt);
};

func void DIA_Torlof_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Torlof_PICKPOCKET);
};

func void DIA_Torlof_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Torlof_PICKPOCKET);
};

