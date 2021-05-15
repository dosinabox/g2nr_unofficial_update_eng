
instance DIA_Akil_EXIT(C_Info)
{
	npc = BAU_940_Akil;
	nr = 999;
	condition = DIA_Akil_EXIT_Condition;
	information = DIA_Akil_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende_v1;
};


func int DIA_Akil_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Akil_EXIT_Info()
{
	AI_Output(other,self,"DIA_Akil_EXIT_15_00");	//I've got to go.
	if(!Npc_KnowsInfo(other,DIA_Akil_NachKampf))
	{
		AI_Output (self, other, "DIA_Akil_EXIT_13_01");	//Don't let me stop you.
	}
	else
	{
		AI_Output (self, other, "DIA_Akil_EXIT_13_02");	//So long. I really wish I could have done more for you.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Akil_Hallo(C_Info)
{
	npc = BAU_940_Akil;
	nr = 4;
	condition = DIA_Akil_Hallo_Condition;
	information = DIA_Akil_Hallo_Info;
	permanent = FALSE;
	description = "Is there a problem?";
};


func int DIA_Akil_Hallo_Condition()
{
//	if(!Npc_IsDead(Alvares) && !Npc_IsDead(Engardo) && Npc_IsInState(self,ZS_Talk))
	if(Kapitel < 4)
	{
		if(!C_AkilFarmIsFree())
		{
			return TRUE;
		};
	};
};

func void DIA_Akil_Hallo_Info()
{
	AI_Output (other, self, "DIA_Akil_Hallo_15_00");	//Is there a problem?
	AI_Output (self, other, "DIA_Akil_Hallo_13_01");	//(sweating) ... Eh ... no, no ... everything's fine. (nervous) It ... would be better if you left now.
	AI_Output (other, self, "DIA_Akil_Hallo_15_02");	//Are you sure?
	AI_Output (self, other, "DIA_Akil_Hallo_13_03");	//eh ... yeah, yeah ... everything's fine. You ... eh ... I ... I can't talk to you now.
	if(Akils_SLDStillthere == FALSE)
	{
		Log_CreateTopic(TOPIC_AkilsSLDStillthere,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_AkilsSLDStillthere,LOG_Running);
		B_LogEntry(TOPIC_AkilsSLDStillthere,"Akil's farm is threatened by mercenaries.");
		Akils_SLDStillthere = TRUE;
	};
	AI_StopProcessInfos(self);
};


instance DIA_Akil_Nichtjetzt(C_Info)
{
	npc = BAU_940_Akil;
	nr = 7;
	condition = DIA_Akil_Nichtjetzt_Condition;
	information = DIA_Akil_Nichtjetzt_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Akil_Nichtjetzt_Condition()
{
//	if(Npc_IsInState(self,ZS_Talk) && !Npc_IsDead(Alvares) && !Npc_IsDead(Engardo) && Npc_KnowsInfo(other,DIA_Akil_Hallo))
	if(Npc_IsInState(self,ZS_Talk) && !C_AkilFarmIsFree() && Npc_KnowsInfo(other,DIA_Akil_Hallo) && (Kapitel < 4))
	{
		return TRUE;
	};
};

func void DIA_Akil_Nichtjetzt_Info()
{
	AI_Output (self, other, "DIA_Akil_Nichtjetzt_13_00");	//Eh... not now, I can't talk to you now.
	AI_StopProcessInfos (self);
};


instance DIA_Akil_NachKampf(C_Info)
{
	npc = BAU_940_Akil;
	nr = 5;
	condition = DIA_Akil_NachKampf_Condition;
	information = DIA_Akil_NachKampf_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Akil_NachKampf_Condition()
{
	if(C_AkilFarmIsFree() && (Kapitel < 4))
	{
		return TRUE;
	};
};

func void DIA_Akil_NachKampf_Info()
{
	AI_Output (self, other, "DIA_Akil_NachKampf_13_00");	//Thank Innos. I thought my time had run out.
	AI_Output (self, other, "DIA_Akil_NachKampf_13_01");	//My name is Akil. I farm this humble piece of land.
	AI_Output (other, self, "DIA_Akil_NachKampf_15_02");	//Who were those people?
	if ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Akil_NachKampf_13_03");	//You ought to recognize them. Those were mercenaries from Onar's farm. Like you.
	}
	else
	{
		AI_Output (self, other, "DIA_Akil_NachKampf_13_04");	//Those were mercenaries from Onar's farm. Those bastards don't know anything but plunder and murder.
	};
	AI_Output (self, other, "DIA_Akil_NachKampf_13_05");	//I'd been fearing the worst ...
	AI_Output (self, other, "DIA_Akil_NachKampf_13_06");	//(deep breath)... well, thank Innos it didn't come to that. Tell me what I can do for you.
	Info_ClearChoices (DIA_Akil_NachKampf);
	Info_AddChoice (DIA_Akil_NachKampf, "Nothing. Just as long as you got through this all right.", DIA_Akil_NachKampf_Ehre);
	Info_AddChoice (DIA_Akil_NachKampf, "What about a few gold pieces?", DIA_Akil_NachKampf_Gold);
	Npc_ExchangeRoutine (self, "Start");
	self.flags = 0;
	if (Hlp_IsValidNpc (Kati) && !Npc_IsDead (Kati))
	{
//		Kati.flags = 0;
		B_StartOtherRoutine(Kati,"Start");
	};
	if(Hlp_IsValidNpc(Randolph) && !Npc_IsDead(Randolph))
	{
		B_StartOtherRoutine(Randolph,"Start");
		Randolph.flags = 0;
	};
	TOPIC_END_AkilsSLDStillthere = TRUE;
	B_GivePlayerXP(XP_Ambient);
};

func void DIA_Akil_NachKampf_Ehre()
{
	AI_Output (other, self, "DIA_Akil_NachKampf_Ehre_15_00");	//Nothing. Just as long as you got through this all right.
	AI_Output (self, other, "DIA_Akil_NachKampf_Ehre_13_01");	//You're an exceptional fellow. May Innos guard you on your way.
	B_GivePlayerXP (XP_Akil_SLDWegVomHofEhre);
	Info_ClearChoices (DIA_Akil_NachKampf);
};

func void DIA_Akil_NachKampf_Gold()
{
	AI_Output (other, self, "DIA_Akil_NachKampf_Gold_15_00");	//What about a few gold pieces?
	AI_Output (self, other, "DIA_Akil_NachKampf_Gold_13_01");	//I'm afraid I have to disappoint you - we're poor farmers. It's just enough to live on.
	if(!Npc_IsDead(Kati))
	{
		AI_Output(self,other,"DIA_Akil_NachKampf_Gold_13_02");	//All I can offer you is a meal. Go to Kati and let her take care of you.
		Kati_Mahlzeit = TRUE;
	};
	B_GivePlayerXP(XP_Akil_SLDWegVomHof);
	Info_ClearChoices(DIA_Akil_NachKampf);
};


instance DIA_Akil_Soeldner(C_Info)
{
	npc = BAU_940_Akil;
	nr = 7;
	condition = DIA_Akil_Soeldner_Condition;
	information = DIA_Akil_Soeldner_Info;
	permanent = FALSE;
	description = "What did the mercenaries want from you?";
};


func int DIA_Akil_Soeldner_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_NachKampf))
	{
		return TRUE;
	};
};

func void DIA_Akil_Soeldner_Info()
{
	AI_Output (other, self, "DIA_Akil_Soeldner_15_00");	//What did the mercenaries want from you?
	if ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Akil_Soeldner_13_01");	//You're pulling my leg. The mercenaries wanted to collect the rent.
	}
	else
	{
		AI_Output (self, other, "DIA_Akil_Soeldner_13_02");	//You don't know that? Onar, the landowner, hired them. They guard his farm and collect the rent for him.
		AI_Output (self, other, "DIA_Akil_Soeldner_13_03");	//That means they go from farm to farm and take whatever they want. And whoever can't pay gets a taste of their steel.
	};
};


instance DIA_Addon_Akil_MissingPeople(C_Info)
{
	npc = BAU_940_Akil;
	nr = 5;
	condition = DIA_Addon_Akil_MissingPeople_Condition;
	information = DIA_Addon_Akil_MissingPeople_Info;
	description = "Have you heard anything about missing citizens?";
};


func int DIA_Addon_Akil_MissingPeople_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_NachKampf) && (SC_HearedAboutMissingPeople == TRUE) && (MissingPeopleReturnedHome == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Akil_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Akil_MissingPeople_15_00");	//Have you heard anything about missing citizens?
	AI_Output (self, other, "DIA_Addon_Akil_MissingPeople_13_01");	//Don't make me laugh. Heard of them? Some of my own people are missing.
	AI_Output (self, other, "DIA_Addon_Akil_MissingPeople_13_02");	//Tonak and Telbor used to work on my fields, until 3 days ago.
	AI_Output (self, other, "DIA_Addon_Akil_MissingPeople_13_03");	//And I know exactly that they wouldn't up and leave the farm just like that.
	AI_Output (self, other, "DIA_Addon_Akil_MissingPeople_13_04");	//And yet, they've simply vanished and no-one can tell me where they went.
	AI_Output (self, other, "DIA_Addon_Akil_MissingPeople_13_05");	//If you happen to find out what's become of them, be sure to let me know, will you?
	B_GivePlayerXP (XP_Ambient);
	Log_CreateTopic (TOPIC_Addon_MissingPeople, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_MissingPeople, LOG_Running);
	B_LogEntry (TOPIC_Addon_MissingPeople, "The farmer Akil is missing his two field hands Tonak and Telbor");
	MIS_Akil_BringMissPeopleBack = LOG_Running;
};


instance DIA_Addon_Akil_ReturnPeople(C_Info)
{
	npc = BAU_940_Akil;
	nr = 5;
	condition = DIA_Addon_Akil_ReturnPeople_Condition;
	information = DIA_Addon_Akil_ReturnPeople_Info;
	permanent = FALSE;
	description = "About your farmhands ...";
};


func int DIA_Addon_Akil_ReturnPeople_Condition()
{
	if((MIS_Akil_BringMissPeopleBack == LOG_Running) && (MissingPeopleReturnedHome == TRUE) && (!Npc_IsDead(Tonak_NW) || !Npc_IsDead(Telbor_NW)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Akil_ReturnPeople_Info()
{
	AI_Output(other,self,"DIA_Addon_Akil_ReturnPeople_15_00");	//About your farmhands...
	if(!Npc_IsDead(Tonak_NW) && !Npc_IsDead(Telbor_NW))
	{
		AI_Output (self, other, "DIA_Addon_Akil_ReturnPeople_13_01");	//You brought them back - you're one brave man.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Akil_ReturnPeople_13_02");	//At least one of them has survived.
	};
	AI_Output (self, other, "DIA_Addon_Akil_ReturnPeople_13_03");	//Take this gold as a token of my gratitude.
	B_GiveInvItems (self, other, ItMi_Gold, 100);
	B_GivePlayerXP (XP_Ambient);
	MIS_Akil_BringMissPeopleBack = LOG_SUCCESS;
};


func void B_GetBaltramPaket()
{
	CreateInvItems(self,ItMi_BaltramPaket,1);
	B_GiveInvItems(self,other,ItMi_BaltramPaket,1);
	B_LogEntries(TOPIC_Baltram,"I've got the shipment. I could take it to Baltram now...");
	B_LogNextEntry(TOPIC_Nagur,"I've got the shipment. I could take it to Nagur now...");
	Lieferung_Geholt = TRUE;
};

instance DIA_Akil_Lieferung(C_Info)
{
	npc = BAU_940_Akil;
	nr = 20;
	condition = DIA_Akil_Lieferung_Condition;
	information = DIA_Akil_Lieferung_Info;
	permanent = FALSE;
	description = "Baltram sent me ...";
};


func int DIA_Akil_Lieferung_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_NachKampf) && (MIS_Baltram_ScoutAkil == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Akil_Lieferung_Info()
{
	AI_Output (other, self, "DIA_Akil_Lieferung_15_00");	//Baltram sent me. I'm supposed to pick up a shipment for him here.
	AI_Output (self, other, "DIA_Akil_Lieferung_13_01");	//So you're his new messenger. Okay, I've already made up the package.
	B_GetBaltramPaket();
};


instance DIA_Akil_Gegend(C_Info)
{
	npc = BAU_940_Akil;
	nr = 90;
	condition = DIA_Akil_Gegend_Condition;
	information = DIA_Akil_Gegend_Info;
	permanent = FALSE;
	description = "You know your way around this area ...";
};


func int DIA_Akil_Gegend_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_Soeldner))
	{
		return TRUE;
	};
};


func void DIA_Akil_Gegend_Info()
{
	AI_Output (other, self, "DIA_Akil_Gegend_15_00");	//You know your way around this area ...
	AI_Output (self, other, "DIA_Akil_Gegend_13_01");	//Sure, what do you want to know?
};


instance DIA_Akil_Hof(C_Info)
{
	npc = BAU_940_Akil;
	nr = 20;
	condition = DIA_Akil_Hof_Condition;
	information = DIA_Akil_Hof_Info;
	permanent = FALSE;
	description = "Where can I find Onar's farm?";
};


func int DIA_Akil_Hof_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_Gegend) && (hero.guild != GIL_SLD) && (hero.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Akil_Hof_Info()
{
	AI_Output (other, self, "DIA_Akil_Gegend_Onar_15_00");	//Where can I find Onar's farm?
	AI_Output (self, other, "DIA_Akil_Gegend_Onar_13_01");	//Just go back down the stone steps and follow the road to the east.
	AI_Output (self, other, "DIA_Akil_Gegend_Onar_13_02");	//At some point you come to a tavern. From there you go farther east until you come to the big fields. That's where the mercenaries hang out.
	Knows_Taverne = TRUE;
};


instance DIA_Akil_Taverne(C_Info)
{
	npc = BAU_940_Akil;
	nr = 20;
	condition = DIA_Akil_Taverne_Condition;
	information = DIA_Akil_Taverne_Info;
	permanent = FALSE;
	description = "What is that tavern to the east of here?";
};


func int DIA_Akil_Taverne_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_Gegend) && (Knows_Taverne == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Akil_Taverne_Info()
{
	AI_Output (other, self, "DIA_Akil_Gegend_Taverne_15_00");	//What is that tavern to the east of here?
	AI_Output (self, other, "DIA_Akil_Gegend_Taverne_13_01");	//Ask Randolph. He knows more about it than I do. He's been there a few times.
};


instance DIA_Akil_Wald(C_Info)
{
	npc = BAU_940_Akil;
	nr = 20;
	condition = DIA_Akil_Wald_Condition;
	information = DIA_Akil_Wald_Info;
	permanent = FALSE;
	description = "What is there in the woods behind your farm?";
};


func int DIA_Akil_Wald_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_Gegend))
	{
		return TRUE;
	};
};

func void DIA_Akil_Wald_Info()
{
	AI_Output (other, self, "DIA_Akil_Gegend_Wald_15_00");	//What is there in the woods behind your farm?
	AI_Output (self, other, "DIA_Akil_Gegend_Wald_13_01");	//There's just a whole bunch of monsters back there - and the wolves are the least dangerous.
	if(Kapitel < 3)
	{
		AI_Output(self,other,"DIA_Akil_Gegend_Wald_13_02");	//A few bandits are also said to have their caves there. Well - they've left my farm alone so far.
	};
};


instance DIA_Akil_Perm(C_Info)
{
	npc = BAU_940_Akil;
	nr = 32;
	condition = DIA_Akil_Perm_Condition;
	information = DIA_Akil_Perm_Info;
	permanent = TRUE;
	description = "Did anything else happen?";
};


func int DIA_Akil_Perm_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_Soeldner) && (Kapitel >= 3))
	{
		return TRUE;
	};
	if(Kapitel >= 4)
	{
		return TRUE;
	};
};

func void DIA_Akil_Perm_Info()
{
	AI_Output (other, self, "DIA_Akil_Perm_15_00");	//Did anything else happen?
	if (Kapitel == 3)
	{
		if(MIS_Akil_SchafDiebe == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_Akil_Perm_13_01");	//No. I hope the sheep stay where they are right now.
		}
		else
		{
			AI_Output (self, other, "DIA_Akil_Perm_13_02");	//My sheep keep disappearing. Soon I won't be able to feed us anymore.
		};
	}
	else
	{
		if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL))
		{
			AI_Output (self, other, "DIA_Akil_Perm_13_03");	//The orcs have shown up everywhere. Someone even mentioned their headquarters. Ask the farmer Lobart about that.
		};
		if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
		{
			AI_Output (self, other, "DIA_Akil_Perm_13_04");	//They've also spotted plenty of lizard people in this area. I wouldn't go into the caves if I were you.
		};
		if(hero.guild == GIL_KDF)
		{
			AI_Output(self,other,"DIA_Akil_Perm_13_05");	//The black hoods are looking for you.
		};
		AI_Output (other, self, "DIA_Akil_Perm_15_06");	//Now there's a novel concept.
		AI_Output (self, other, "DIA_Akil_Perm_13_07");	//All right. I just thought I'd mention it.
	};
};


instance DIA_Akil_SCHAFDIEB(C_Info)
{
	npc = BAU_940_Akil;
	nr = 2;
	condition = DIA_Akil_SCHAFDIEB_Condition;
	information = DIA_Akil_SCHAFDIEB_Info;
	description = "Is there any other news?";
};


func int DIA_Akil_SCHAFDIEB_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Akil_Soeldner) && (Kapitel >= 3))
	{
		return TRUE;
	};
	if(Kapitel >= 4)
	{
		return TRUE;
	};
};

func void DIA_Akil_SCHAFDIEB_Info()
{
	AI_Output (other, self, "DIA_Akil_SCHAFDIEB_15_00");	//Is there any other news?
	AI_Output (self, other, "DIA_Akil_SCHAFDIEB_13_01");	//Someone keeps stealing my sheep lately. I haven't been able to sleep properly for nights.
	Info_ClearChoices (DIA_Akil_SCHAFDIEB);
	Info_AddChoice (DIA_Akil_SCHAFDIEB, "Not my problem.", DIA_Akil_SCHAFDIEB_nein);
	Info_AddChoice (DIA_Akil_SCHAFDIEB, "How many sheep are you missing?", DIA_Akil_SCHAFDIEB_wieviel);
	Info_AddChoice (DIA_Akil_SCHAFDIEB, "Who could have done that?", DIA_Akil_SCHAFDIEB_wer);
};

func void DIA_Akil_SCHAFDIEB_wer()
{
	AI_Output (other, self, "DIA_Akil_SCHAFDIEB_wer_15_00");	//Who could have done that?
	AI_Output (self, other, "DIA_Akil_SCHAFDIEB_wer_13_01");	//I've got a hunch about that.
	AI_Output (self, other, "DIA_Akil_SCHAFDIEB_wer_13_02");	//Some really nasty fellows have settled into the caves over in the forest.
	AI_Output (self, other, "DIA_Akil_SCHAFDIEB_wer_13_03");	//I find it hard to believe that they're living on berries. I'm almost certain that's where my sheep are disappearing to.
	MIS_Akil_SchafDiebe = LOG_Running;
	Log_CreateTopic(TOPIC_AkilSchafDiebe,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_AkilSchafDiebe,LOG_Running);
	B_LogEntry(TOPIC_AkilSchafDiebe,"Akil's sheep keep getting stolen. He suspects that the bandits in the woodland cave nearby are behind it.");
	Info_ClearChoices(DIA_Akil_SCHAFDIEB);
};

func void DIA_Akil_SCHAFDIEB_wieviel()
{
	AI_Output (other, self, "DIA_Akil_SCHAFDIEB_wieviel_15_00");	//How many sheep are you missing?
	AI_Output (self, other, "DIA_Akil_SCHAFDIEB_wieviel_13_01");	//It must be at least three that have disappeared now.
};

func void DIA_Akil_SCHAFDIEB_nein()
{
	AI_Output (other, self, "DIA_Akil_SCHAFDIEB_nein_15_00");	//Not my problem.
	AI_Output (self, other, "DIA_Akil_SCHAFDIEB_nein_13_01");	//I understand. You have other things to worry about.
	Info_ClearChoices (DIA_Akil_SCHAFDIEB);
};


instance DIA_Akil_SCHAFDIEBEPLATT(C_Info)
{
	npc = BAU_940_Akil;
	nr = 2;
	condition = DIA_Akil_SCHAFDIEBEPLATT_Condition;
	information = DIA_Akil_SCHAFDIEBEPLATT_Info;
	description = "I found the sheep rustlers.";
};


func int DIA_Akil_SCHAFDIEBEPLATT_Condition()
{
	if((Kapitel >= 3) && (MIS_Akil_SchafDiebe == LOG_Running) && Npc_IsDead(BDT_1025_Bandit_H) && Npc_IsDead(BDT_1026_Bandit_H) && Npc_IsDead(BDT_1027_Bandit_H))
	{
		return TRUE;
	};
};

func void DIA_Akil_SCHAFDIEBEPLATT_Info()
{
	AI_Output (other, self, "DIA_Akil_SCHAFDIEBEPLATT_15_00");	//I found the sheep rustlers.
	AI_Output (other, self, "DIA_Akil_SCHAFDIEBEPLATT_15_01");	//You were right. Those fellows in the forest cave did it. They'll never steal sheep from you again.
	if ((hero.guild == GIL_PAL) || (hero.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Akil_SCHAFDIEBEPLATT_13_02");	//Thank you, noble servant of Innos.
	}
	else if(hero.guild == GIL_MIL)
	{
		AI_Output (self, other, "DIA_Akil_SCHAFDIEBEPLATT_13_03");	//Thanks. So the militia really does care about us small farmers.
	}
	else
	{
		AI_Output (self, other, "DIA_Akil_SCHAFDIEBEPLATT_13_04");	//Thanks. You sure are a strange mercenary. Not at all like the others I know.
	};
	AI_Output (self, other, "DIA_Akil_SCHAFDIEBEPLATT_13_05");	//Take this as a small token of thanks for the selfless favor you did for me.
	CreateInvItems (self, ItMi_Gold, 150);
	B_GiveInvItems (self, other, ItMi_Gold, 150);
	MIS_Akil_SchafDiebe = LOG_SUCCESS;
	B_GivePlayerXP(XP_Akil_SchafDiebe);
};


instance DIA_Akil_AkilsSchaf(C_Info)
{
	npc = BAU_940_Akil;
	nr = 2;
	condition = DIA_Akil_AkilsSchaf_Condition;
	information = DIA_Akil_AkilsSchaf_Info;
	important = TRUE;
//	description = "(return Akils sheep)";
};


func int DIA_Akil_AkilsSchaf_Condition()
{
	if((Kapitel >= 3) && !Npc_IsDead(Follow_Sheep_AKIL) && (MIS_Akil_SchafDiebe != FALSE))
	{
		if(Npc_GetDistToNpc(self,Follow_Sheep_AKIL) < 1000)
		{
			return TRUE;
		};
	};
};

func void DIA_Akil_AkilsSchaf_Info()
{
	AI_Output(self,other,"DIA_Akil_AkilsSchaf_13_01");	//Very good. Here's a few gold coins. I hope it's enough.
	CreateInvItems(self,ItMi_Gold,150);
	B_GiveInvItems(self,other,ItMi_Gold,150);
	Follow_Sheep_AKIL.aivar[AIV_PARTYMEMBER] = FALSE;
	Follow_Sheep_AKIL.aivar[AIV_TAPOSITION] = NOTINPOS;
	Follow_Sheep_AKIL.wp = "NW_FARM2_OUT_02";
	Follow_Sheep_AKIL.start_aistate = ZS_MM_AllScheduler;
	B_StartOtherRoutine(Follow_Sheep_AKIL,"Farm");
	B_GivePlayerXP(XP_AkilsSchaf);
};


instance DIA_Akil_PICKPOCKET(C_Info)
{
	npc = BAU_940_Akil;
	nr = 900;
	condition = DIA_Akil_PICKPOCKET_Condition;
	information = DIA_Akil_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Akil_PICKPOCKET_Condition()
{
	return C_Beklauen(37,30);
};

func void DIA_Akil_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Akil_PICKPOCKET);
	Info_AddChoice(DIA_Akil_PICKPOCKET,Dialog_Back,DIA_Akil_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Akil_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Akil_PICKPOCKET_DoIt);
};

func void DIA_Akil_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Akil_PICKPOCKET);
};

func void DIA_Akil_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Akil_PICKPOCKET);
};

