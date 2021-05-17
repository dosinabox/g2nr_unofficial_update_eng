
instance DIA_Addon_Greg_EXIT(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 999;
	condition = DIA_Addon_Greg_EXIT_Condition;
	information = DIA_Addon_Greg_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Greg_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Greg_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Greg_PICKPOCKET(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 900;
	condition = DIA_Addon_Greg_PICKPOCKET_Condition;
	information = DIA_Addon_Greg_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_120;
};


func int DIA_Addon_Greg_PICKPOCKET_Condition()
{
	return C_Beklauen(111,666);
};

func void DIA_Addon_Greg_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Greg_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Greg_PICKPOCKET,Dialog_Back,DIA_Addon_Greg_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Greg_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Greg_PICKPOCKET_DoIt);
};

func void DIA_Addon_Greg_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Greg_PICKPOCKET);
};

func void DIA_Addon_Greg_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Greg_PICKPOCKET);
};


func int C_NorthBeachMonstersDead()
{
	if(!Npc_IsDead(BeachLurker1))
	{
		return FALSE;
	};
	if(!Npc_IsDead(BeachLurker2))
	{
		return FALSE;
	};
	if(!Npc_IsDead(BeachLurker3))
	{
		return FALSE;
	};
	if(!Npc_IsDead(BeachWaran1))
	{
		return FALSE;
	};
	if(!Npc_IsDead(BeachWaran2))
	{
		return FALSE;
	};
	if(!Npc_IsDead(BeachShadowbeast1))
	{
		return FALSE;
	};
	return TRUE;
};

instance DIA_Addon_Greg_ImNew(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 1;
	condition = DIA_Addon_Greg_ImNew_Condition;
	information = DIA_Addon_Greg_ImNew_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Greg_ImNew_Condition()
{
	return TRUE;
};

func void DIA_Addon_Greg_ImNew_Info()
{
	AI_Output (self, other, "DIA_Addon_Greg_Hello_01_00");	//(threatening) Hey, you. What are you doing in my hut?
	AI_Output (other, self, "DIA_Addon_Greg_Hello_15_01");	//I...
	AI_Output (self, other, "DIA_Addon_Greg_Hello_01_02");	//(furious) I've just been gone for a couple of days, and everyone thinks they can do what they damn well please.
	AI_Output (self, other, "DIA_Addon_Greg_ImNew_01_03");	//What the hell is going on here?
	AI_Output (self, other, "DIA_Addon_Greg_ImNew_01_04");	//The palisade still isn't finished? The canyon is overrun with beasts, and everybody is just hanging around, enjoying themselves.
	if(!Npc_IsDead(Francis) && (Npc_GetDistToWP(Francis,"ADW_PIRATECAMP_HUT4_01") <= 1000))
	{
		AI_TurnToNPC (self, Francis);
		AI_Output (self, other, "DIA_Addon_Greg_ImNew_01_05");	//(loudly) So this is all you've accomplished, Francis?
		if (C_BodyStateContains (Francis, BS_SIT))
		{
			AI_Output (self, other, "DIA_Addon_Greg_ImNew_01_06");	//(loudly) Get off of my bench at once!
		};
	};
	Npc_ExchangeRoutine(self,"HOME");
	AI_TurnToNPC(self,other);
	AI_Output(self,other,"DIA_Addon_Greg_ImNew_01_07");	//And YOU? What have YOU done?
	Info_ClearChoices(DIA_Addon_Greg_ImNew);
	Info_AddChoice(DIA_Addon_Greg_ImNew,"Not much so far.",DIA_Addon_Greg_ImNew_nich);
	if((C_NorthBeachMonstersDead() && (MIS_Addon_MorganLurker != FALSE)) || C_TowerBanditsDead())
	{
		Info_AddChoice (DIA_Addon_Greg_ImNew, "I've been working.", DIA_Addon_Greg_ImNew_turm);
	};
};

func void B_UseRakeBilanz()
{
	if((MIS_Addon_Greg_RakeCave == LOG_Running) || (MIS_Addon_Greg_RakeCave == LOG_FAILED) || (Greg_NoHelpInNW_Cave == TRUE))
	{
		AI_Output(self,other,"DIA_Addon_Greg_UseRakeBilanz_01_00");	//And don't think I've forgotten that you still owe me a thing or two.
		if((MIS_Addon_Greg_BringMeToTheCity == LOG_Running) || (MIS_Addon_Greg_BringMeToTheCity == LOG_FAILED))
		{
			AI_Output(self,other,"DIA_Addon_Greg_NW_was_NoHelp_01_02");	//This is the second time you've left me hanging.
			Greg_NoHelpInNW = TRUE;
		};
		if(Greg_SuchWeiter == TRUE)
		{
			AI_Output (self, other, "DIA_Addon_Greg_UseRakeBilanz_01_01");	//That is, things worth several hundred gold coins that I buried all over Khorinis.
			AI_Output (self, other, "DIA_Addon_Greg_UseRakeBilanz_01_02");	//You just pocketed them all, didn't you?
			AI_Output (self, other, "DIA_Addon_Greg_UseRakeBilanz_01_03");	//I'll have you work off every last bit of it.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Greg_UseRakeBilanz_01_04");	//I'll teach you the true meaning of work.
	};
	if(!Npc_IsDead(Francis))
	{
		Npc_ExchangeRoutine(Francis,"GREGISBACK");
		AI_StartState(Francis,ZS_Saw,1,"ADW_PIRATECAMP_BEACH_19");
		Francis_ausgeschissen = TRUE;
	};
	Info_ClearChoices(DIA_Addon_Greg_ImNew);
};

func void DIA_Addon_Greg_ImNew_nich()
{
	AI_Output (other, self, "DIA_Addon_Greg_ImNew_nich_15_00");	//Not much so far.
	AI_Output (self, other, "DIA_Addon_Greg_ImNew_nich_01_01");	//Never mind. I'll find you something suitable, my friend.
	B_UseRakeBilanz ();
};

func void DIA_Addon_Greg_ImNew_turm()
{
	AI_Output (other, self, "DIA_Addon_Greg_ImNew_turm_15_00");	//I've been working.
	AI_Output (self, other, "DIA_Addon_Greg_ImNew_turm_01_01");	//Have you? And what?
	if(C_TowerBanditsDead())
	{
		AI_Output (other, self, "DIA_Addon_Greg_ImNew_turm_15_02");	//I've done away with the bandits in the tower.
	};
	if(C_NorthBeachMonstersDead() && (MIS_Addon_MorganLurker != FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Greg_ImNew_turm_15_03");	//There are no more beasts on the beach to the north.
	};
	AI_Output (self, other, "DIA_Addon_Greg_ImNew_turm_01_04");	//Well. It's a beginning, I guess.
	B_UseRakeBilanz ();
};


func int C_PiratesAvailableToFollow()
{
	if(!Npc_IsDead(Brandon) || !Npc_IsDead(Matt) || !Npc_IsDead(AlligatorJack) || !Npc_IsDead(Skip) || !Npc_IsDead(RoastPirate) || !Npc_IsDead(BenchPirate))
	{
		return TRUE;
	};
	return FALSE;
};

var int GregHints_Followers;
var int GregHints_Razors;

func void B_GregHints_Followers()
{
	if(GregHints_Followers == FALSE)
	{
		B_LogEntry(TOPIC_Addon_ClearCanyon,"Greg says I can take a couple of the boys with me.");
		GregHints_Followers = TRUE;
	};
};

func void B_GregHints_Razors()
{
	if(GregHints_Razors == FALSE)
	{
		B_LogEntry(TOPIC_Addon_ClearCanyon,"It seems to be all about razors.");
		GregHints_Razors = TRUE;
	};
};

instance DIA_Addon_Greg_JoinPirates(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 5;
	condition = DIA_Addon_Greg_JoinPirates_Condition;
	information = DIA_Addon_Greg_JoinPirates_Info;
	permanent = FALSE;
	description = "What is there to do?";
};


func int DIA_Addon_Greg_JoinPirates_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Greg_ImNew))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_JoinPirates_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_JoinPirates_15_00");	//What is there to do?
	AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_01_01");	//First of all we'll make things hum around here.
	if(!Npc_IsDead(Morgan))
	{
		AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_01_02");	//Morgan, that lazy pig, gets to saw planks.
	};
	AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_01_03");	//YOU will take over Morgan's job and clear those beasts out of the damn canyon.
	MIS_Addon_Greg_ClearCanyon = LOG_Running;
	Log_CreateTopic(TOPIC_Addon_ClearCanyon,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_ClearCanyon,LOG_Running);
	if(Greg_NoHelpInNW == FALSE)
	{
		B_LogEntry(TOPIC_Addon_ClearCanyon,"Greg would like me to take over Morgan's job and clear the canyon of beasts.");
	}
	else
	{
		B_LogEntry(TOPIC_Addon_ClearCanyon,"Greg would like me to take over Morgan's job and clear the canyon of beasts. It looks like he still remembers me refusing to help him in Khorinis.");
	};
	Info_ClearChoices(DIA_Addon_Greg_JoinPirates);
	Info_AddChoice(DIA_Addon_Greg_JoinPirates,"I guess I'll get going then.",DIA_Addon_Greg_JoinPirates_Leave);
	Info_AddChoice(DIA_Addon_Greg_JoinPirates,"Am I supposed to do that all by myself?",DIA_Addon_Greg_JoinPirates_Compadres);
	Info_AddChoice(DIA_Addon_Greg_JoinPirates,"What beasts?",DIA_Addon_Greg_JoinPirates_ClearCanyon);
};

func void DIA_Addon_Greg_JoinPirates_Leave()
{
	AI_Output (other, self, "DIA_Addon_Greg_JoinPirates_Leave_15_00");	//I guess I'll get going then.
	AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_Leave_01_01");	//One more thing. You're one of us now.
	AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_Leave_01_02");	//So get yourself a decent hunting outfit first.
	AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_Leave_01_03");	//Here's some of our armor for you. I hope it fits.
	if(Greg_NoHelpInNW == FALSE)
	{
		B_GiveArmor(ITAR_PIR_M_Addon);
	}
	else
	{
		B_GiveArmor(ITAR_PIR_L_Addon);
	};
	AI_Output(self,other,"DIA_Addon_Greg_JoinPirates_Leave_01_04");	//And don't dawdle - get right to it!
	Info_ClearChoices(DIA_Addon_Greg_JoinPirates);
};

func void DIA_Addon_Greg_JoinPirates_Compadres()
{
	AI_Output(other,self,"DIA_Addon_Greg_JoinPirates_Compadres_15_00");	//Am I supposed to do that all by myself?
	if(C_PiratesAvailableToFollow())
	{
		AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_Compadres_01_01");	//Just go ahead and grab some of the boys.
		AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_Compadres_01_02");	//Let them earn their pay instead of just gabbing all day.
		B_GregHints_Followers();
	}
	else
	{
		DIA_Common_01_AreYouTryingToPissMeOff();
	};
};

func void DIA_Addon_Greg_JoinPirates_ClearCanyon()
{
	AI_Output(other,self,"DIA_Addon_Greg_JoinPirates_ClearCanyon_15_00");	//What beasts?
	AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_ClearCanyon_01_01");	//The razors in the canyon are coming closer and closer to our camp.
	AI_Output (self, other, "DIA_Addon_Greg_JoinPirates_ClearCanyon_01_02");	//I won't wait until they eat one of my men who's had a few too many.
	B_GregHints_Razors();
};


instance DIA_Addon_Greg_AboutCanyon(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 5;
	condition = DIA_Addon_Greg_AboutCanyon_Condition;
	information = DIA_Addon_Greg_AboutCanyon_Info;
	permanent = TRUE;
	description = "About that canyon...";
};


func int DIA_Addon_Greg_AboutCanyon_Condition()
{
	if(MIS_Addon_Greg_ClearCanyon == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_AboutCanyon_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_AboutCanyon_15_00");	//About that canyon...
	AI_Output (self, other, "DIA_Addon_Greg_AboutCanyon_01_01");	//Yeah, what about it?
	Info_ClearChoices(DIA_Addon_Greg_AboutCanyon);
	if(!C_AllCanyonRazorDead())
	{
		Info_AddChoice(DIA_Addon_Greg_AboutCanyon,"Nothing so far...",DIA_Addon_Greg_AboutCanyon_Back);
		Info_AddChoice(DIA_Addon_Greg_AboutCanyon,"Who can help me with that?",DIA_Addon_Greg_AboutCanyon_Compadres);
		Info_AddChoice(DIA_Addon_Greg_AboutCanyon,"What beasts am I supposed to kill?",DIA_Addon_Greg_AboutCanyon_Job);
	}
	else
	{
		Info_AddChoice (DIA_Addon_Greg_AboutCanyon, "I killed all the razors.", DIA_Addon_Greg_AboutCanyon_RazorsDead);
	};
};

func void DIA_Addon_Greg_AboutCanyon_Back()
{
	DIA_Common_NothingImportantYet();
	Info_ClearChoices(DIA_Addon_Greg_AboutCanyon);
};

func void DIA_Addon_Greg_AboutCanyon_Compadres()
{
	AI_Output(other,self,"DIA_Addon_Greg_AboutCanyon_Compadres_15_00");	//Who can help me with that?
	if(C_PiratesAvailableToFollow())
	{
		AI_Output(self,other,"DIA_Addon_Greg_AboutCanyon_Compadres_01_01");	//Take a few of the boys along.
		AI_Output(self,other,"DIA_Addon_Greg_AboutCanyon_Compadres_01_02");	//They do nothing but loiter about anyway.
		B_GregHints_Followers();
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Greg_NW_Bigcross_01_07_add");	//It can't be all that difficult.
	};
	Info_ClearChoices(DIA_Addon_Greg_AboutCanyon);
};

func void DIA_Addon_Greg_AboutCanyon_Job()
{
	AI_Output (other, self, "DIA_Addon_Greg_AboutCanyon_RazorsDead_15_00");	//I killed all the razors.
	AI_Output (self, other, "DIA_Addon_Greg_AboutCanyon_RazorsDead_01_01");	//Good. You seem to be a useful fellow.
	B_GregHints_Razors();
	Info_ClearChoices(DIA_Addon_Greg_AboutCanyon);
};

func void DIA_Addon_Greg_AboutCanyon_RazorsDead()
{
	AI_Output (other, self, "DIA_Addon_Greg_AboutCanyon_RazorsDead_15_00");	//I killed all the razors.
	AI_Output (self, other, "DIA_Addon_Greg_AboutCanyon_RazorsDead_01_01");	//Good. You seem to be a useful fellow.
	B_LogEntry (TOPIC_Addon_ClearCanyon, "Greg even seemed to be a bit impressed that I killed all the razors in the canyon.");
	MIS_Addon_Greg_ClearCanyon = LOG_SUCCESS;
	B_Addon_PiratesGoHome();
	B_GivePlayerXP(XP_Addon_ClearCanyon);
	Info_ClearChoices(DIA_Addon_Greg_AboutCanyon);
};


instance DIA_Addon_Greg_BanditArmor(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 5;
	condition = DIA_Addon_Greg_BanditArmor_Condition;
	information = DIA_Addon_Greg_BanditArmor_Info;
	permanent = TRUE;
	description = "I need that bandits' armor.";
};


func int DIA_Addon_Greg_BanditArmor_Condition()
{
	if((MIS_Greg_ScoutBandits == FALSE) && !C_SCHasBDTArmor())
	{
		return TRUE;
	};
};

var int Greg_BanditArmor_Once;

func void DIA_Addon_Greg_BanditArmor_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_BanditArmor_15_00");	//I need that bandits' armor.
	if (MIS_Addon_Greg_ClearCanyon != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Addon_Greg_BanditArmor_01_01");	//Prove yourself useful first. Then we can talk.
		if (MIS_Addon_Greg_ClearCanyon == LOG_Running)
		{
			AI_Output (self, other, "DIA_Addon_Greg_BanditArmor_01_02");	//First, kill all the razors in the canyon!
		};
		if(Greg_BanditArmor_Once == FALSE)
		{
			B_LogEntry(TOPIC_Addon_BDTRuestung,"Greg wants me to help him put some life back into the camp. Afterwards, I can talk to him about the armor.");
			Greg_BanditArmor_Once = TRUE;
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Greg_BanditArmor_01_03");	//Hey, you're quite something!
		AI_Output (self, other, "DIA_Addon_Greg_BanditArmor_01_04");	//Bones was supposed to wear that armor and spy on the bandits.
		AI_Output (self, other, "DIA_Addon_Greg_BanditArmor_01_05");	//But maybe YOU'RE the better man for the job.
		AI_Output (self, other, "DIA_Addon_Greg_BanditArmor_01_06");	//Perhaps you even stand a chance of coming out of there alive.
		AI_Output (self, other, "DIA_Addon_Greg_BanditArmor_01_07");	//Talk to Bones and let him give you the armor. Then put it on and go to the bandits' camp.
		AI_Output (self, other, "DIA_Addon_Greg_BanditArmor_01_08");	//I need to know why those scumbags came to our valley in the first place.
		AI_Output (other, self, "DIA_Addon_Greg_BanditArmor_15_09");	//Aye aye, Captain!
		B_LogEntries(TOPIC_Addon_BDTRuestung,"Now that I got rid of the Razors in the canyon, I can get the armor from Bones.");
		Log_CreateTopic(TOPIC_Addon_ScoutBandits,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_ScoutBandits,LOG_Running);
		B_LogNextEntry(TOPIC_Addon_ScoutBandits,"I'm supposed to find out for Greg why the bandits came to this valley in the first place.");
		MIS_Greg_ScoutBandits = LOG_Running;
	};
};


instance DIA_Addon_Greg_Auftraege2(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 5;
	condition = DIA_Addon_Greg_Auftraege2_Condition;
	information = DIA_Addon_Greg_Auftraege2_Info;
	description = "Have you got anything else for me to do?";
};


func int DIA_Addon_Greg_Auftraege2_Condition()
{
	if((MIS_Greg_ScoutBandits != FALSE) && (!C_TowerBanditsDead() || !C_NorthBeachMonstersDead()))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_Auftraege2_Info()
{
	AI_Output(other,self,"DIA_Addon_Greg_Auftraege2_15_00");	//Have you got anything else for me to do?
	if(!C_NorthBeachMonstersDead())
	{
		AI_Output (self, other, "DIA_Addon_Greg_Auftraege2_01_01");	//The beach to the north is still teeming with beasts.
		AI_Output (self, other, "DIA_Addon_Greg_Auftraege2_01_02");	//Looks like Morgan hasn't done a thing.
		Log_CreateTopic(TOPIC_Addon_MorganBeach,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_MorganBeach,LOG_Running);
		B_LogEntry(TOPIC_Addon_MorganBeach,"Greg wants me to take care of the beach. It is full of beasts and needs to be cleaned up.");
		MIS_Addon_MorganLurker = LOG_Running;
	};
	if(!C_TowerBanditsDead())
	{
		AI_Output (self, other, "DIA_Addon_Greg_Auftraege2_01_03");	//There are still bandits in the southern tower on the cliff.
		AI_Output (self, other, "DIA_Addon_Greg_Auftraege2_01_04");	//Francis should have dealt with them.
		Log_CreateTopic (TOPIC_Addon_BanditsTower, LOG_MISSION);
		Log_SetTopicStatus (TOPIC_Addon_BanditsTower, LOG_Running);
		B_LogEntry (TOPIC_Addon_BanditsTower, "Greg wants me to drive the bandits out of the tower south of the camp.");
		MIS_Henry_FreeBDTTower = LOG_Running;
	};
	AI_Output (self, other, "DIA_Addon_Greg_Auftraege2_01_05");	//You can handle that as well if you like.
};


instance DIA_Addon_Greg_Sauber2(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 5;
	condition = DIA_Addon_Greg_Sauber2_Condition;
	information = DIA_Addon_Greg_Sauber2_Info;
	description = "The northern beach is cleared.";
};


func int DIA_Addon_Greg_Sauber2_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Greg_Auftraege2) && C_NorthBeachMonstersDead())
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_Sauber2_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_Sauber2_15_00");	//The northern beach is cleared.
	AI_Output (self, other, "DIA_Addon_Greg_Sauber2_01_01");	//Great. Here's your reward.
	if(Greg_NoHelpInNW == FALSE)
	{
		CreateInvItems(self,ItMi_Gold,200);
		B_GiveInvItems(self,other,ItMi_Gold,200);
	}
	else
	{
		CreateInvItems(self,ItMi_Gold,50);
		B_GiveInvItems(self,other,ItMi_Gold,50);
	};
	B_LogEntry(TOPIC_Addon_MorganBeach,"I have reported to Greg that the beach in the north is clean.");
	MIS_Addon_MorganLurker = LOG_SUCCESS;
	B_GivePlayerXP(XP_Addon_Morgan_LurkerPlatt);
};


instance DIA_Addon_Greg_BanditPlatt2(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 5;
	condition = DIA_Addon_Greg_BanditPlatt2_Condition;
	information = DIA_Addon_Greg_BanditPlatt2_Info;
	description = "The bandits in the tower have been dealt with.";
};


func int DIA_Addon_Greg_BanditPlatt2_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Greg_Auftraege2) && C_TowerBanditsDead())
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_BanditPlatt2_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_BanditPlatt2_15_00");	//The bandits in the tower have been dealt with.
	AI_Output (self, other, "DIA_Addon_Greg_BanditPlatt2_01_01");	//Excellent. Good work. Here's your reward.
	if(Greg_NoHelpInNW == FALSE)
	{
		CreateInvItems(self,ItMi_Gold,200);
		B_GiveInvItems(self,other,ItMi_Gold,200);
		B_LogEntry(TOPIC_Addon_BanditsTower,"The bandits in the tower are dead. Greg was very pleased with me.");
	}
	else
	{
		CreateInvItems(self,ItMi_Gold,50);
		B_GiveInvItems(self,other,ItMi_Gold,50);
		B_LogEntry(TOPIC_Addon_BanditsTower,"The bandits in the tower are dead.");
	};
	MIS_Henry_FreeBDTTower = LOG_SUCCESS;
	B_GivePlayerXP(XP_Addon_Henry_FreeBDTTower);
};


instance DIA_Addon_Greg_BanditGoldmine(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 5;
	condition = DIA_Addon_Greg_BanditGoldmine_Condition;
	information = DIA_Addon_Greg_BanditGoldmine_Info;
	permanent = TRUE;
	description = "The bandits have found a gold mine.";
};


func int DIA_Addon_Greg_BanditGoldmine_Condition()
{
	if((SC_KnowsRavensGoldmine == TRUE) && (MIS_Greg_ScoutBandits == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_BanditGoldmine_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_BanditGoldmine_15_00");	//The bandits have found a gold mine.
	AI_Output (self, other, "DIA_Addon_Greg_BanditGoldmine_01_01");	//I knew it! THAT'S why they came here.
	AI_Output (self, other, "DIA_Addon_Greg_BanditGoldmine_01_02");	//Nobody would volunteer to live in this monster-ridden bog.
	AI_Output (self, other, "DIA_Addon_Greg_BanditGoldmine_01_03");	//Good work. Here, I've got something for you.
	B_GiveInvItems (self, other, ItRi_Addon_STR_01, 1);
	B_LogEntry (TOPIC_Addon_ScoutBandits, "I have informed Greg about the gold mine.");
	MIS_Greg_ScoutBandits = LOG_SUCCESS;
	B_GivePlayerXP(XP_Greg_ScoutBandits);
};


instance DIA_Addon_Greg_WhoAreYou(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 2;
	condition = DIA_Addon_Greg_WhoAreYou_Condition;
	information = DIA_Addon_Greg_WhoAreYou_Info;
	permanent = FALSE;
	description = "Who are you?";
};


func int DIA_Addon_Greg_WhoAreYou_Condition()
{
//	if((PlayerTalkedToGregNW == FALSE) && (SC_MeetsGregTime == FALSE))
	if(PlayerTalkedToGregNW == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_WhoAreYou_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_WhoAreYou_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Addon_Greg_WhoAreYou_01_01");	//I'm Greg, the leader of this lazy bunch.
	AI_Output (self, other, "DIA_Addon_Greg_WhoAreYou_01_02");	//Is that enough for you?
};


instance DIA_Addon_Greg_NiceToSeeYou(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 5;
	condition = DIA_Addon_Greg_NiceToSeeYou_Condition;
	information = DIA_Addon_Greg_NiceToSeeYou_Info;
	permanent = FALSE;
	description = "So how did you get here?";
};


func int DIA_Addon_Greg_NiceToSeeYou_Condition()
{
	if(PlayerTalkedToGregNW == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NiceToSeeYou_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NiceToSeeYou_15_00");	//So how did you get here?
	AI_Output (self, other, "DIA_Addon_Greg_NiceToSeeYou_01_01");	//You weren't expecting me, huh?
	AI_Output (self, other, "DIA_Addon_Greg_NiceToSeeYou_01_02");	//Just so we set this straight. I'm Greg, and this here is my camp.
	AI_Output (self, other, "DIA_Addon_Greg_NiceToSeeYou_01_03");	//That enough for you?
};


instance DIA_Addon_Greg_Story(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 99;
	condition = DIA_Addon_Greg_Story_Condition;
	information = DIA_Addon_Greg_Story_Info;
	permanent = TRUE;
	description = "There's one more thing I'd like to know.";
};


func int DIA_Addon_Greg_Story_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Addon_Greg_WhoAreYou) || Npc_KnowsInfo(other,DIA_Addon_Greg_NiceToSeeYou)) && (MIS_Greg_ScoutBandits != FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_Story_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_Story_15_00");	//There's one more thing I'd like to know.
	AI_Output (self, other, "DIA_Addon_Greg_Story_01_01");	//And that is?
	Info_ClearChoices (DIA_Addon_Greg_Story);
	Info_AddChoice (DIA_Addon_Greg_Story, Dialog_Back, DIA_Addon_Greg_Story_Back);
	Info_AddChoice (DIA_Addon_Greg_Story, "How did you get here?", DIA_Addon_Greg_Story_Way);
	Info_AddChoice (DIA_Addon_Greg_Story, "Where's your ship?", DIA_Addon_Greg_Story_Ship);
	if (RavenIsDead == FALSE)
	{
		Info_AddChoice (DIA_Addon_Greg_Story, "What do you know about Raven?", DIA_Addon_Greg_Story_Raven);
	};
};

func void DIA_Addon_Greg_Story_Back()
{
	Info_ClearChoices(DIA_Addon_Greg_Story);
};

func void DIA_Addon_Greg_Story_Way()
{
	AI_Output (other, self, "DIA_Addon_Greg_Story_Way_15_00");	//How did you get here?
	AI_Output (self, other, "DIA_Addon_Greg_Story_Way_01_01");	//I found a tunnel near the old pyramid, guarded by a few mages.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Way_01_02");	//I simply sneaked past those blindworms.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Way_01_03");	//First I took it for an ancient burial chamber and decided to check out what I could find there.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Way_01_04");	//Imagine my surprise when I suddenly found myself in my beloved valley.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Way_01_05");	//Just when I thought I would have to spend the rest of my life running away from the militia.
};

func void DIA_Addon_Greg_Story_Ship()
{
	AI_Output (other, self, "DIA_Addon_Greg_Story_Ship_15_00");	//Where's your ship?
	AI_Output (self, other, "DIA_Addon_Greg_Story_Ship_01_01");	//This is just my luck. For months, no ships have sailed between here and the mainland.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Ship_01_02");	//For months! And the first ship I run into happens to be a fully manned warship, belonging to the King.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Ship_01_03");	//Full of paladins, from her keel to the top of her mast.
	AI_Output (other, self, "DIA_Addon_Greg_Story_Ship_15_04");	//That's what I call bad luck.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Ship_01_05");	//You can say that again. They sank us right away. I'm the only one who made it to shore.
};

func void DIA_Addon_Greg_Story_Raven()
{
	AI_Output (other, self, "DIA_Addon_Greg_Story_Raven_15_00");	//What do you know about Raven?
	AI_Output (self, other, "DIA_Addon_Greg_Story_Raven_01_01");	//He used to be an ore baron as far as I know. Quite a big shot in the colony.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Raven_01_02");	//I haven't a clue why he's here now and why people are following him.
	AI_Output (self, other, "DIA_Addon_Greg_Story_Raven_01_03");	//But he's certainly up to something. He's not the kind who would hide out in a swamp.
};


instance DIA_Addon_Greg_RavenDead(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 2;
	condition = DIA_Addon_Greg_RavenDead_Condition;
	information = DIA_Addon_Greg_RavenDead_Info;
	description = "So much for Raven.";
};


func int DIA_Addon_Greg_RavenDead_Condition()
{
	if(RavenIsDead == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_RavenDead_Info()
{
	AI_Output(other,self,"DIA_Addon_Greg_RavenDead_15_00");	//So much for Raven.
	AI_Output(self,other,"DIA_Addon_Greg_RavenDead_01_01");	//Well, I'll be... That's unexpected. Caught him with his pants down, did you?
	if((Greg_NoHelpInNW == FALSE) && (Greg_NoHelpInNW_Cave == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_Greg_RavenDead_01_02");	//That's certainly worth 500 gold pieces to me.
		CreateInvItems(self,ItMi_Gold,500);
		B_GiveInvItems(self,other,ItMi_Gold,500);
	};
	AI_Output(self,other,"DIA_Addon_Greg_RavenDead_01_03");	//You're quite the daredevil. Carry on like that.
	B_GivePlayerXP(XP_Addon_GregRavenLohn);
	if(MIS_Henry_HolOwen == LOG_SUCCESS)
	{
		B_StartOtherRoutine(Owen,"PostStart");
	};
};

instance DIA_Addon_Greg_ItemsInADW(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 800;
	condition = DIA_Addon_Greg_ItemsInADW_Condition;
	information = DIA_Addon_Greg_ItemsInADW_Info;
	description = "Here's your stuff.";
};


func int DIA_Addon_Greg_ItemsInADW_Condition()
{
	if((RAKEPLACE[1] == TRUE) && (RAKEPLACE[2] == TRUE) && (RAKEPLACE[3] == TRUE) && (RAKEPLACE[4] == TRUE) && (RAKEPLACE[5] == TRUE) && (MIS_Addon_Greg_RakeCave == LOG_Running) && (Greg_SuchWeiter == TRUE))
	{
		if((Npc_HasItems(other,ItSe_GoldPocket100) || (Npc_HasItems(other,ItMi_Gold) >= 100)) && Npc_HasItems(other,ItMi_GoldChalice) && Npc_HasItems(other,ItMi_GregsSilverPlate) && Npc_HasItems(other,ItAm_Addon_Greg))
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Greg_ItemsInADW_Info()
{
	B_GiveGregItems();
	B_GivePlayerXP(XP_Addon_Greg_RakeCave / 3);
};

instance DIA_Addon_Greg_BeMyCap(C_Info)
{
	npc = PIR_1320_Addon_Greg;
	nr = 850;
	condition = DIA_Addon_Greg_BeMyCap_Condition;
	information = DIA_Addon_Greg_BeMyCap_Info;
	description = "Maybe I could offer you a job as a captain.";
};


func int DIA_Addon_Greg_BeMyCap_Condition()
{
	if((Kapitel == 5) && (MIS_SCKnowsWayToIrdorath == TRUE) && (SCGotCaptain == FALSE))
	{
		if((PlayerTalkedToGregNW == TRUE) || Npc_KnowsInfo(other,DIA_Addon_Greg_WhoAreYou))
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Greg_BeMyCap_Info()
{
	DIA_Common_MaybeICanOfferYouCaptainJob();
	AI_Output(self,other,"DIA_Addon_Greg_NW_RavensLetter_01_06");	//(angrily) What's this nonsense?
	AI_Output(other,self,"DIA_Pyrokar_SCKNOWSWAYTOIRDORATH_15_00");	//I know where to find the Halls of Irdorath.
	AI_Output(self,other,"DIA_Addon_Greg_NW_WasWillstDu_da_01_01");	//You had better not try to go there.
	DIA_Common_SoWhatYouSay();
	AI_Output(self,other,"DIA_Addon_Greg_NW_was_SLD_01_02");	//(laughs) Not too bad for a landlubber.
	B_LogEntry(Topic_Captain,"Greg is not interested in being my captain.");
	AI_StopProcessInfos(self);
};

