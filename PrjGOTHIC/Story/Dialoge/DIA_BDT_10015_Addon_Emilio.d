
instance DIA_Addon_Emilio_EXIT(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 999;
	condition = DIA_Addon_Emilio_EXIT_Condition;
	information = DIA_Addon_Emilio_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Emilio_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Emilio_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Emilio_PICKPOCKET(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 900;
	condition = DIA_Addon_Emilio_PICKPOCKET_Condition;
	information = DIA_Addon_Emilio_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Addon_Emilio_PICKPOCKET_Condition()
{
	return C_Beklauen(76,112);
};

func void DIA_Addon_Emilio_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Emilio_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Emilio_PICKPOCKET,Dialog_Back,DIA_Addon_Emilio_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Emilio_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Emilio_PICKPOCKET_DoIt);
};

func void DIA_Addon_Emilio_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Emilio_PICKPOCKET);
};

func void DIA_Addon_Emilio_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Emilio_PICKPOCKET);
};


instance DIA_Addon_BDT_10015_Emilio_Hi(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 1;
	condition = DIA_Addon_Emilio_Hi_Condition;
	information = DIA_Addon_Emilio_Hi_Info;
	permanent = FALSE;
	description = "You look like a digger.";
};


func int DIA_Addon_Emilio_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Emilio_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10015_Emilio_Hi_15_00");	//You look like a digger.
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Hi_10_01");	//I AM a digger. The last time I was in the mine, I worked my ass off.
	if (SC_KnowsRavensGoldmine == FALSE)
	{
		B_LogEntries(TOPIC_Addon_RavenKDW,LogText_Addon_RavensGoldmine);
		B_LogNextEntry(TOPIC_Addon_Sklaven,LogText_Addon_RavensGoldmine);
		B_LogNextEntry(TOPIC_Addon_ScoutBandits,Log_Text_Addon_ScoutBandits);
	};
	SC_KnowsRavensGoldmine = TRUE;
};


instance DIA_Addon_BDT_10015_Emilio_Gold(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 2;
	condition = DIA_Addon_Emilio_Gold_Condition;
	information = DIA_Addon_Emilio_Gold_Info;
	permanent = FALSE;
	description = "What happens to the gold from the mine?";
};


func int DIA_Addon_Emilio_Gold_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_BDT_10015_Emilio_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_Gold_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10015_Emilio_Gold_15_00");	//What happens to the gold from the mine?
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Gold_10_01");	//Thorus collects it and then distributes it. No one is allowed to keep what he mines.
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Gold_10_02");	//Everybody gets only a part of the gold - that way even the hunters and guards get their share.
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Gold_10_03");	//I think that's okay. Since we've had that rule, there have been fewer deaths, and the miners still get more than the guys who hang around outside.
};


instance DIA_Addon_BDT_10015_Emilio_Stein(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 3;
	condition = DIA_Addon_Emilio_Stein_Condition;
	information = DIA_Addon_Emilio_Stein_Info;
	permanent = FALSE;
	description = "What's the deal with these red stones?";
};


func int DIA_Addon_Emilio_Stein_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Emilio_Jetzt))
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_Stein_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10015_Emilio_Stein_15_00");	//What's the deal with these red stones?
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Stein_10_01");	//That's something Thorus and Esteban thought up.
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Stein_10_02");	//Thorus takes care of the gold distribution and Esteban organizes the workers for the mine.
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Stein_10_03");	//Of course, he doesn't want to run to Thorus every time he sends someone to the mine.
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Stein_10_04");	//That's why he gives us one of these red stone tablets and Thorus lets us in then. It's like a pass.
};


var int Emilio_Switch;

instance DIA_Addon_Emilio_Attentat(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 4;
	condition = DIA_Addon_Emilio_Attentat_Condition;
	information = DIA_Addon_Emilio_Attentat_Info;
	permanent = TRUE;
	description = "What do you know about the attack?";
};


func int DIA_Addon_Emilio_Attentat_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Emilio_VonEmilio) && Npc_IsDead(Senyan))
	{
		return FALSE;
	}
	else if(MIS_Judas == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_Attentat_Info()
{
	AI_Output (other, self, "DIA_Addon_Emilio_Attentat_15_00");	//What do you know about the attack?
	if (Emilio_Switch == 0)
	{
		AI_Output (self, other, "DIA_Addon_Emilio_Attentat_10_01");	//(scared) Hey, man, I didn't have anything to do with it!
		Emilio_Switch = 1;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Emilio_Attentat_10_02");	//(scared) NOTHING AT ALL!
		Emilio_Switch = 0;
	};
};


instance DIA_Addon_BDT_10015_Emilio_Senyan(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 1;
	condition = DIA_Addon_Emilio_Senyan_Condition;
	information = DIA_Addon_Emilio_Senyan_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Emilio_Senyan_Condition()
{
	if(Npc_IsDead(Senyan))
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_Senyan_Info()
{
	if(Senyan_Called == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Senyan_10_00");	//(searchingly) Tell me, WHY did Senyan yell, 'Look who we have here'?
		AI_Output (other, self, "DIA_Addon_BDT_10015_Emilio_Senyan_15_01");	//(drily) Unpaid debts.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Senyan_10_02");	//You killed Senyan!
	};
	AI_Output (other, self, "DIA_Addon_BDT_10015_Emilio_Senyan_15_03");	//Do you have a problem with that?
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Senyan_10_04");	//(hastily) No, man, I don't have a problem with it.
	AI_Output (self, other, "DIA_Addon_BDT_10015_Emilio_Senyan_10_05");	//Quite the opposite. (snidely) The bastard worked for Esteban.
	Senyan_CONTRA = LOG_SUCCESS;
	B_LogEntry (Topic_Addon_Esteban, "Emilio is not on Esteban's side.");
};


instance DIA_Addon_Emilio_Jetzt(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 5;
	condition = DIA_Addon_Emilio_Jetzt_Condition;
	information = DIA_Addon_Emilio_Jetzt_Info;
	permanent = FALSE;
	description = "Why aren't you in the mine now?";
};


func int DIA_Addon_Emilio_Jetzt_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_BDT_10015_Emilio_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_Jetzt_Info()
{
	AI_Output (other, self, "DIA_Addon_Emilio_Jetzt_15_00");	//Why aren't you in the mine now?
	AI_Output (self, other, "DIA_Addon_Emilio_Jetzt_10_01");	//(somewhat unsure) I was in the mine long enough and slaved away until I was about to fall over. Now I need a few days' rest.
	AI_Output (self, other, "DIA_Addon_Emilio_Jetzt_10_02");	//(sighs, somewhat unsure) Before I get my next red stone.
};


instance DIA_Addon_Emilio_VonEmilio(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 6;
	condition = DIA_Addon_Emilio_VonEmilio_Condition;
	information = DIA_Addon_Emilio_VonEmilio_Info;
	permanent = FALSE;
	description = "Lennar told me a bit about you...";
};


func int DIA_Addon_Emilio_VonEmilio_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Emilio_Jetzt) && Npc_KnowsInfo(other,DIA_Addon_Lennar_Attentat))
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_VonEmilio_Info()
{
	AI_Output (other, self, "DIA_Addon_Emilio_VonEmilio_15_00");	//Lennar told me a bit about you...
	AI_Output (self, other, "DIA_Addon_Emilio_VonEmilio_10_01");	//Lennar? That guy's an idiot. You must have noticed.
	AI_Output (other, self, "DIA_Addon_Emilio_VonEmilio_15_02");	//He said you haven't been in the mine since the attack happened.
	AI_Output (self, other, "DIA_Addon_Emilio_VonEmilio_10_03");	//(intimidated) I... don't know anything!
	if (!Npc_IsDead (Senyan))
	{
		AI_Output (self, other, "DIA_Addon_Emilio_VonEmilio_10_04");	//You are working together with that Senyan!
		AI_Output (self, other, "DIA_Addon_Emilio_VonEmilio_10_05");	//You're both in cahoots with Esteban! I heard exactly what you were blabbing about!
		AI_Output (self, other, "DIA_Addon_Emilio_VonEmilio_10_06");	//Up to now Esteban hasn't given a damn about us. Why should I trust his people.
		AI_Output (self, other, "DIA_Addon_Emilio_VonEmilio_10_07");	//Leave me alone!
		AI_StopProcessInfos (self);
	};
	B_LogEntry (Topic_Addon_Esteban, "Emilio thinks that Lennar is an idiot.");
};


instance DIA_Addon_Emilio_HilfMir(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 7;
	condition = DIA_Addon_Emilio_HilfMir_Condition;
	information = DIA_Addon_Emilio_HilfMir_Info;
	permanent = FALSE;
	description = "Help me find out who was behind the attack!";
};


func int DIA_Addon_Emilio_HilfMir_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Emilio_VonEmilio) && Npc_IsDead(Senyan))
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_HilfMir_Info()
{
	AI_Output (other, self, "DIA_Addon_Emilio_HilfMir_15_00");	//Help me find out who was behind the attack!
	AI_Output (self, other, "DIA_Addon_Emilio_HilfMir_10_01");	//No! I don't want anything to do with it!
	AI_Output (other, self, "DIA_Addon_Emilio_HilfMir_15_02");	//If an idiot like Lennar notices that you're behaving oddly, it won't take long before Esteban finds out, too.
	AI_Output (self, other, "DIA_Addon_Emilio_HilfMir_10_03");	//(squirming) I... shit! I'll tell you one name. Nothing more.
	AI_Output (other, self, "DIA_Addon_Emilio_HilfMir_15_04");	//I'm listening.
	AI_Output (self, other, "DIA_Addon_Emilio_HilfMir_10_05");	//Huno... go to Huno. He must know something about this business.
	Emilio_TellAll = TRUE;
	B_LogEntry (Topic_Addon_Esteban, "Emilio has finally coughed up a name: Huno.");
};


instance DIA_Addon_Emilio_GegenEsteban(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 8;
	condition = DIA_Addon_Emilio_GegenEsteban_Condition;
	information = DIA_Addon_Emilio_GegenEsteban_Info;
	permanent = FALSE;
	description = "What do you have against Esteban?";
};


func int DIA_Addon_Emilio_GegenEsteban_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_BDT_10015_Emilio_Senyan))
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_GegenEsteban_Info()
{
	AI_Output (other, self, "DIA_Addon_Emilio_GegenEsteban_15_00");	//What do you have against Esteban?
	AI_Output (self, other, "DIA_Addon_Emilio_GegenEsteban_10_01");	//All that swine thinks about is money.
	AI_Output (self, other, "DIA_Addon_Emilio_GegenEsteban_10_02");	//Every few days one of us gets eaten by a crawler.
	AI_Output (self, other, "DIA_Addon_Emilio_GegenEsteban_10_03");	//But Esteban just won't send any fighters into the mine.
	AI_Output (self, other, "DIA_Addon_Emilio_GegenEsteban_10_04");	//And why? Those guys belong to 'Raven's bodyguards' and Esteban is scared shitless to tell them.
	AI_Output (self, other, "DIA_Addon_Emilio_GegenEsteban_10_05");	//He'd rather let us get killed!
};


instance DIA_Addon_BDT_10015_Emilio_Mine(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 9;
	condition = DIA_Addon_Emilio_Mine_Condition;
	information = DIA_Addon_Emilio_Mine_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_MINE_DESCRIPTION;
};


func int DIA_Addon_Emilio_Mine_Condition()
{
	if((MIS_Send_Buddler == LOG_Running) && (Player_SentBuddler < 3) && Npc_HasItems(other,ItMi_Addon_Stone_01))
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_Mine_Info()
{
	B_Say(other,self,"$MINE_ADDON_DESCRIPTION");
	B_GiveInvItems(other,self,ItMi_Addon_Stone_01,1);
	AI_Output(self,other,"DIA_Addon_BDT_10015_Emilio_Mine_10_00");	//So now you're the boss here. Okay, then I'll get going.
	Player_SentBuddler += 1;
	B_GivePlayerXP(XP_Addon_MINE);
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"MINE");
};


instance DIA_Addon_Emilio_Hacker(C_Info)
{
	npc = BDT_10015_Addon_Emilio;
	nr = 9;
	condition = DIA_Addon_Emilio_Hacker_Condition;
	information = DIA_Addon_Emilio_Hacker_Info;
	permanent = TRUE;
	description = "What's up?";
};


func int DIA_Addon_Emilio_Hacker_Condition()
{
	if(Npc_GetDistToWP(self,"ADW_MINE_09_PICK") <= 500)
	{
		return TRUE;
	};
};

func void DIA_Addon_Emilio_Hacker_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10004_Emilio_Hacker_15_00");	//What's up?
	AI_Output (self, other, "DIA_Addon_BDT_10004_Emilio_Hacker_10_01");	//I'm really slaving away. Well, the main thing is, I won't get eaten by a crawler.
};

