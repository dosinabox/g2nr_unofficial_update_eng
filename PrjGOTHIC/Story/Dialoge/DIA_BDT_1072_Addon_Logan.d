
instance DIA_Addon_Logan_EXIT(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 999;
	condition = DIA_Addon_Logan_EXIT_Condition;
	information = DIA_Addon_Logan_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende_v4;
};


func int DIA_Addon_Logan_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Logan_EXIT_Info()
{
	DIA_Common_IllBeBackLater();
	if((MIS_HlpLogan == LOG_Running) && (Logan_Inside == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_Logan_EXIT_10_01");	//(growls) Yeeaah, you just run away. I'll stay here and stop everything that gets too close.
	}
	else
	{
		AI_WaitTillEnd(self,other);
	};
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Logan_PICKPOCKET(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 900;
	condition = DIA_Addon_Logan_PICKPOCKET_Condition;
	information = DIA_Addon_Logan_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Addon_Logan_PICKPOCKET_Condition()
{
	return C_Beklauen(59,50);
};

func void DIA_Addon_Logan_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Logan_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Logan_PICKPOCKET,Dialog_Back,DIA_Addon_Logan_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Logan_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Logan_PICKPOCKET_DoIt);
};

func void DIA_Addon_Logan_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Logan_PICKPOCKET);
};

func void DIA_Addon_Logan_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Logan_PICKPOCKET);
};


instance DIA_Addon_BDT_1072_Logan_Mine(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 2;
	condition = DIA_Addon_Logan_Mine_Condition;
	information = DIA_Addon_Logan_Mine_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_MINE_DESCRIPTION;
};


func int DIA_Addon_Logan_Mine_Condition()
{
	if((MIS_Send_Buddler == LOG_Running) && (Player_SentBuddler < 3) && Npc_HasItems(other,ItMi_Addon_Stone_01) && (Npc_GetDistToWP(self,"BL_INN_CORNER_02") <= 1000))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_Mine_Info()
{
	B_Say(other,self,"$MINE_ADDON_DESCRIPTION");
	B_GiveInvItems(other,self,ItMi_Addon_Stone_01,1);
	AI_Output(self,other,"DIA_Addon_BDT_1072_Logan_Mine_10_00");	//So you did it, hm? Okay, good thing you didn't leave me hanging.
	Player_SentBuddler += 1;
	B_GivePlayerXP(XP_Addon_MINE);
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"MINE");
};


instance DIA_Addon_Logan_How2(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 2;
	condition = DIA_Addon_Logan_How2_Condition;
	information = DIA_Addon_Logan_How2_Info;
	permanent = FALSE;
	description = "How's it going with you?";
};


func int DIA_Addon_Logan_How2_Condition()
{
	if((Logan_Inside == TRUE) && (Npc_GetDistToWP(self,"BL_INN_CORNER_02") <= 1000))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_How2_Info()
{
	AI_Output (other, self, "DIA_Addon_Logan_How2_15_00");	//How's it going with you?
	AI_Output (self, other, "DIA_Addon_Logan_How2_10_01");	//Well, at least I'm in now. Lucia brews some wicked liquor.
	if(!Npc_IsDead(Esteban))
	{
	AI_Output (self, other, "DIA_Addon_Logan_How2_10_02");	//But Esteban won't let me into the mine. At any rate, not yet. He's given me another job.
	AI_Output (other, self, "DIA_Addon_Logan_How2_15_03");	//And? What does he want from you?
	AI_Output (self, other, "DIA_Addon_Logan_How2_10_04");	//There was an attempt on Esteban's life. He wants to know who's behind it.
	AI_Output (self, other, "DIA_Addon_Logan_How2_10_05");	//(quietly) Esteban thinks that Snaf is involved. I'm supposed to keep an eye on him...
		LoganToldAboutEsteban = TRUE;
	};
};


instance DIA_Addon_Logan_Attentat(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 9;
	condition = DIA_Addon_Logan_Attentat_Condition;
	information = DIA_Addon_Logan_Attentat_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_ATTENTAT_DESCRIPTION;
};


func int DIA_Addon_Logan_Attentat_Condition()
{
	if((MIS_Judas == LOG_Running) && (Logan_Inside == TRUE) && (LoganToldAboutEsteban == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_Attentat_Info()
{
	B_Say (other, self, "$ATTENTAT_ADDON_DESCRIPTION");
	AI_Output (self, other, "DIA_Addon_Logan_Attentat_10_00");	//You're looking for the guy who's behind it, huh?
	AI_Output (self, other, "DIA_Addon_Logan_Attentat_10_01");	//But I don't know anything about it. How could I? I was still in the swamp then...
};


instance DIA_Addon_Logan_HI(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 2;
	condition = DIA_Addon_Logan_HI_Condition;
	information = DIA_Addon_Logan_HI_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Logan_HI_Condition()
{
	if((Logan_Inside == FALSE) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_HI_Info()
{
	AI_Output (self, other, "DIA_Addon_Logan_HI_10_00");	//Look, a new face.
	AI_Output (self, other, "DIA_Addon_Logan_HI_10_01");	//Are you just going to stand around here, or have you come to help me?
	if (Npc_KnowsInfo (other, DIA_Addon_Franco_HI))
	{
		AI_Output (other, self, "DIA_Addon_Logan_HI_15_02");	//Franco sent me. He says you could use some help. So, what's up?
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Logan_HI_15_03");	//It depends - what do you need help with?
	};
	AI_Output (self, other, "DIA_Addon_Logan_HI_10_04");	//The swampsharks are coming a little too close for me - high time to finish off a few of them.
	Log_CreateTopic (Topic_Addon_Logan, LOG_MISSION);
	Log_SetTopicStatus (Topic_Addon_Logan, LOG_Running);
	B_LogEntry (Topic_Addon_Logan, "Logan wants me to hunt swamp sharks with him.");
};


instance DIA_Addon_Logan_Why(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 2;
	condition = DIA_Addon_Logan_Why_Condition;
	information = DIA_Addon_Logan_Why_Info;
	permanent = FALSE;
	description = "What do I get for my help?";
};


func int DIA_Addon_Logan_Why_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Logan_HI) && (Logan_Inside == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_Why_Info()
{
	AI_Output (other, self, "DIA_Addon_Logan_Why_15_00");	//What do I get for my help?
	AI_Output (self, other, "DIA_Addon_Logan_Why_10_01");	//(growls) Franco will let you rot here if you don't do it.
	AI_Output (self, other, "DIA_Addon_Logan_Why_10_02");	//If you want to get into the camp, you'll have to lend a hand. You won't get any farther here with just words.
	AI_Output (self, other, "DIA_Addon_Logan_Why_10_03");	//Besides, I can show you how to gut the beasts.
	AI_Output (self, other, "DIA_Addon_Logan_Why_10_04");	//But don't think Franco will send you straight into the camp just because we've had a little fun with the swampsharks here.
	AI_Output (self, other, "DIA_Addon_Logan_Why_10_05");	//There are people out here who have been waiting a long time to get in.
	AI_Output (self, other, "DIA_Addon_Logan_Why_10_06");	//And the next one who gets in is me... (growls)... it had better be...
	Log_CreateTopic (Topic_Addon_BDT_Teacher, LOG_NOTE);
	B_LogEntry (Topic_Addon_BDT_Teacher, "Logan can teach me to get pelts, claws and teeth.");
};


instance DIA_Addon_Logan_Lager(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 3;
	condition = DIA_Addon_Logan_Lager_Condition;
	information = DIA_Addon_Logan_Lager_Info;
	permanent = FALSE;
	description = "What's in the camp, then?";
};


func int DIA_Addon_Logan_Lager_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Logan_Why) && (Logan_Inside == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_Lager_Info()
{
	AI_Output (other, self, "DIA_Addon_Logan_Lager_15_00");	//What's in the camp, then?
	AI_Output (self, other, "DIA_Addon_Logan_Lager_10_01");	//(growls) The question is what ISN'T in the camp. There are no swampsharks, no swamp holes... no SWAMP at all.
	AI_Output (self, other, "DIA_Addon_Logan_Lager_10_02");	//Instead, they have booze and gold. As far as I know, they even have a woman. Got it?
};


instance DIA_Addon_Logan_MIS(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 99;
	condition = DIA_Addon_Logan_MIS_Condition;
	information = DIA_Addon_Logan_MIS_Info;
	permanent = FALSE;
	description = "Let's attack the swampsharks.";
};


func int DIA_Addon_Logan_MIS_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Logan_HI))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_MIS_Info()
{
	AI_Output (other, self, "DIA_Addon_Logan_MIS_15_00");	//Let's attack the swampsharks.
	AI_Output (self, other, "DIA_Addon_Logan_MIS_10_01");	//(growls) You've figured out how to get ahead here. I'm pleased. Psst... do you hear that? Yeeaah, I hear them.
	AI_Output (other, self, "DIA_Addon_Logan_MIS_15_02");	//I see - and what do we do now?
	AI_Output (self, other, "DIA_Addon_Logan_MIS_10_03");	//They're coming. They've got an appetite for a bite of human flesh. Well, we'll see WHO gets eaten here... Let's go.
	Snd_Play ("SWA_Warn");
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "JAGD");
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	MIS_HlpLogan = LOG_Running;
	Wld_InsertNpc(MIS_Addon_Swampshark_01,"ADW_SWAMPSHARK_01");
	Wld_InsertNpc(MIS_Addon_Swampshark_02,"ADW_SWAMPSHARK_02");
	Wld_InsertNpc(MIS_Addon_Swampshark_03,"ADW_BANDIT_VP3_06");
};


var int Logan_Teach_NoPerm;

instance DIA_Addon_Logan_tot(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 2;
	condition = DIA_Addon_Logan_tot_Condition;
	information = DIA_Addon_Logan_tot_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Logan_tot_Condition()
{
	if(Npc_IsDead(MIS_Addon_Swampshark_01) && Npc_IsDead(MIS_Addon_Swampshark_02) && Npc_IsDead(MIS_Addon_Swampshark_03) && Npc_KnowsInfo(other,DIA_Addon_Logan_MIS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_tot_Info()
{
	AI_Output (self, other, "DIA_Addon_Logan_tot_10_00");	//The only good swampshark is a dead swampshark. That will be a warning to their brothers!
	AI_Output (other, self, "DIA_Addon_Logan_tot_15_01");	//All right, is there anything else to do? Otherwise, I'll take off...
	if(Logan_Teach_NoPerm == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Logan_tot_10_02");	//Do that. If you want to learn anything else - you know where to find me.
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Logan_tot_10_02_add");	//Do that.
	};
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	MIS_HlpLogan = LOG_SUCCESS;
	B_CheckLog ();
	B_LogEntry (Topic_Addon_Franco, "I have helped Logan. We'll see what Franco says about that.");
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "START");
};


instance DIA_Addon_Logan_Lern(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 100;
	condition = DIA_Addon_Logan_Lern_Condition;
	information = DIA_Addon_Logan_Lern_Info;
	permanent = FALSE;
	description = "Show me how to gut animals...";
};


func int DIA_Addon_Logan_Lern_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Logan_Why))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_Lern_Info()
{
	AI_Output (other, self, "DIA_Addon_Logan_Lern_15_00");	//Show me how to gut animals...
	AI_Output (self, other, "DIA_Addon_Logan_Lern_10_01");	//If you want to learn something about bloodflies, go to Edgor. He knows all about them.
	AI_Output (self, other, "DIA_Addon_Logan_Lern_10_02");	//And if you want to gut swampsharks or lizards, you have to know how to remove skins and teeth. I can show you that.
	if(!Npc_KnowsInfo(other,DIA_Addon_Edgor_Teach))
	{
		Log_CreateTopic(Topic_Addon_BDT_Teacher,LOG_NOTE);
		B_LogEntry(Topic_Addon_BDT_Teacher,Log_Text_Addon_EdgorTeach);
	};
};


instance DIA_Addon_Logan_Allg(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 3;
	condition = DIA_Addon_Logan_Allg_Condition;
	information = DIA_Addon_Logan_Allg_Info;
	permanent = TRUE;
	description = "I want to learn...";
};


func int DIA_Addon_Logan_Allg_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Logan_Lern) && (Logan_Teach_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_Allg_Info()
{
	AI_Output(other,self,"DIA_Karras_TEACH_15_00");	//Teach me.
	if((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ReptileSkin] == FALSE))
	{
		Info_ClearChoices(DIA_Addon_Logan_Allg);
		Info_AddChoice(DIA_Addon_Logan_Allg,Dialog_Back,DIA_Addon_Logan_Allg_BACK);
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE)
		{
			Info_AddChoice(DIA_Addon_Logan_Allg,B_BuildLearnString(NAME_TROPHY_Teeth,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Teeth)),DIA_Addon_Logan_Allg_Teeth);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE)
		{
			Info_AddChoice(DIA_Addon_Logan_Allg,B_BuildLearnString(NAME_TROPHY_Claws,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Claws)),DIA_Addon_Logan_Allg_Claws);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ReptileSkin] == FALSE)
		{
			Info_AddChoice(DIA_Addon_Logan_Allg,B_BuildLearnString(NAME_TROPHY_ReptileSkin,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_ReptileSkin)),DIA_Addon_Logan_Allg_Fur);
		};
	}
	else
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		Logan_Teach_NoPerm = TRUE;
	};
};

func void DIA_Addon_Logan_Allg_BACK()
{
	if((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == TRUE) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == TRUE) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ReptileSkin] == TRUE))
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		Logan_Teach_NoPerm = TRUE;
	};
	Info_ClearChoices(DIA_Addon_Logan_Allg);
};

func void DIA_Addon_Logan_Allg_Teeth()
{
	B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Teeth);
};

func void DIA_Addon_Logan_Allg_Claws()
{
	B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Claws);
};

func void DIA_Addon_Logan_Allg_Fur()
{
	B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_ReptileSkin);
};


var int Logan_Lohn;

instance DIA_Addon_Logan_Hacker(C_Info)
{
	npc = BDT_1072_Addon_Logan;
	nr = 9;
	condition = DIA_Addon_Logan_Hacker_Condition;
	information = DIA_Addon_Logan_Hacker_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_Addon_Logan_Hacker_Condition()
{
	if(Npc_GetDistToWP(self,"ADW_MINE_PICK_08") <= 500)
	{
		return TRUE;
	};
};

func void DIA_Addon_Logan_Hacker_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10004_Logan_Hacker_15_00");	//How's it going?
	AI_Output (self, other, "DIA_Addon_BDT_10004_Logan_Hacker_10_01");	//Hey, thanks to you, I did it. I'm in the mine!
	AI_Output (self, other, "DIA_Addon_BDT_10004_Logan_Hacker_10_02");	//I may not know much about digging for gold, but that will come.
	if (Logan_Lohn == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_BDT_10004_Logan_Hacker_10_03");	//I've learned the most important thing. Legs firmly on the ground and always strike solidly!
		B_Upgrade_Hero_HackChance (10);
		Logan_Lohn = TRUE;
	};
};


