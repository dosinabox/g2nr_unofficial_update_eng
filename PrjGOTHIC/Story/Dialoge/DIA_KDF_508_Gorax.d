
instance DIA_Gorax_Kap1_EXIT(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 999;
	condition = DIA_Gorax_Kap1_EXIT_Condition;
	information = DIA_Gorax_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Gorax_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Gorax_Kap1_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Gorax_PICKPOCKET(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 888;
	condition = DIA_Gorax_PICKPOCKET_Condition;
	information = DIA_Gorax_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80_Key;
};


func int DIA_Gorax_PICKPOCKET_Condition()
{
//	return C_StealItems(80,Hlp_GetInstanceID(ItKe_KlosterSchatz),0);
	return C_StealItem(80);
};

func void DIA_Gorax_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Gorax_PICKPOCKET);
	Info_AddChoice(DIA_Gorax_PICKPOCKET,Dialog_Back,DIA_Gorax_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Gorax_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Gorax_PICKPOCKET_DoIt);
};

func void DIA_Gorax_PICKPOCKET_DoIt()
{
	if(!Npc_HasItems(self,ItKe_KlosterSchatz))
	{
		CreateInvItem(self,ItKe_KlosterSchatz);
	};
//	B_StealItems(80,Hlp_GetInstanceID(ItKe_KlosterSchatz),1);
	B_StealItem(80,Hlp_GetInstanceID(ItKe_KlosterSchatz));
	Info_ClearChoices(DIA_Gorax_PICKPOCKET);
};

func void DIA_Gorax_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Gorax_PICKPOCKET);
};


instance DIA_Gorax_HELP(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 2;
	condition = DIA_Gorax_HELP_Condition;
	information = DIA_Gorax_HELP_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Gorax_HELP_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Pedro_Traitor == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Gorax_HELP_Info()
{
	AI_Output (self, other, "DIA_Gorax_HELP_14_00");	//Can I be of assistance to you?
};


instance DIA_Gorax_GOLD(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 2;
	condition = DIA_Gorax_GOLD_Condition;
	information = DIA_Gorax_GOLD_Info;
	permanent = TRUE;
	description = "I've brought a heap of gold.";
};


var int DIA_Gorax_GOLD_perm;

func int DIA_Gorax_GOLD_Condition()
{
	if((other.guild == GIL_NOV) && (DIA_Gorax_GOLD_perm == FALSE) && (Pedro_NOV_Aufnahme_LostInnosStatue_Daron == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Gorax_GOLD_Info()
{
	AI_Output (other, self, "DIA_Gorax_GOLD_15_00");	//I've brought a heap of gold.
	if (Npc_HasItems (other, ItMi_Gold) >= Summe_Kloster)
	{
		AI_Output (self, other, "DIA_Gorax_GOLD_14_01");	//(with anticipation) Ah - you're bringing your offering for Innos. That's good of you, my son.
		AI_Output (self, other, "DIA_Gorax_GOLD_14_02");	//I shall use your offering for the best of the monastery as it pleases Innos.
		DIA_Gorax_GOLD_perm = TRUE;
		B_GiveInvItems(other,self,ItMi_Gold,Summe_Kloster);
	}
	else
	{
		AI_Output (self, other, "DIA_Gorax_Orlan_14_02");	//What have you done with that gold? Did you spend it? Go get it and then come back!
	};
};


instance DIA_Addon_Gorax_DaronsStatue(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 2;
	condition = DIA_Addon_Gorax_DaronsStatue_Condition;
	information = DIA_Addon_Gorax_DaronsStatue_Info;
	permanent = TRUE;
	description = "Here, I've got the statuette that Daron was supposed to take to the monastery.";
};


func int DIA_Addon_Gorax_DaronsStatue_Condition()
{
	if((other.guild == GIL_NOV) && (DIA_Gorax_GOLD_perm == FALSE) && (Pedro_NOV_Aufnahme_LostInnosStatue_Daron == TRUE))
	{
		return TRUE;
	}
	else if((MIS_OLDWORLD == LOG_SUCCESS) && (MIS_Addon_Daron_GetStatue == LOG_Running) && (LostInnosStatueInMonastery == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Gorax_DaronsStatue_Info()
{
	AI_Output(other,self,"DIA_Addon_Gorax_DaronsStatue_15_00");	//Here, I've got the statuette that Daron was supposed to bring to the monastery.
	if(B_GiveInvItems(other,self,ItMi_LostInnosStatue_Daron,1))
	{
		if(other.guild == GIL_NOV)
		{
			AI_Output(self,other,"DIA_Addon_Gorax_DaronsStatue_14_01");	//(sighs) It is truly embarrassing that such a valuable piece is brought to us by an aspiring novice.
			AI_Output(self,other,"DIA_Addon_Gorax_DaronsStatue_14_02");	//Nevertheless, this confirms your commitment to serve Innos.
			AI_Output(self,other,"DIA_Addon_Gorax_DaronsStatue_14_03");	//I am very obliged to you, young novice.
			DIA_Gorax_GOLD_perm = TRUE;
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Gorax_DaronsStatue_14_02");	//Nevertheless, this confirms your commitment to serve Innos.
		};
		Npc_RemoveInvItem(self,ItMi_LostInnosStatue_Daron);
		MIS_Addon_Daron_GetStatue = LOG_SUCCESS;
		B_GivePlayerXP(XP_Addon_ReturnedLostInnosStatue_Daron);
		LostInnosStatueInMonastery = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Gorax_DaronsStatue_14_04");	//Statuette? I see no statuette. Bring it to me, and I might believe your little story.
	};
};


instance DIA_Gorax_SLEEP(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 4;
	condition = DIA_Gorax_SLEEP_Condition;
	information = DIA_Gorax_SLEEP_Info;
	description = "I'm looking for a place to sleep.";
};


func int DIA_Gorax_SLEEP_Condition()
{
	if((DIA_Gorax_GOLD_perm == TRUE) && (other.guild == GIL_NOV) && Npc_KnowsInfo(other,DIA_Gorax_JOB))
	{
		return TRUE;
	};
};

func void DIA_Gorax_SLEEP_Info()
{
	AI_Output (other, self, "DIA_Gorax_SLEEP_15_00");	//I'm looking for a place to sleep.
	AI_Output (self, other, "DIA_Gorax_SLEEP_14_01");	//There's an empty bed right next door. The first on the right, next to the entrance. You can sleep there.
	AI_Output (self, other, "DIA_Gorax_SLEEP_14_02");	//You can store your belongings in one of the unused chests.
	AI_Output (self, other, "DIA_Gorax_SLEEP_14_03");	//And remember - you have no business entering the sleeping chambers of the magicians. You are also not allowed to enter the library unless you have been given permission.
};


instance DIA_Gorax_Aufgabe(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 3;
	condition = DIA_Gorax_Aufgabe_Condition;
	information = DIA_Gorax_Aufgabe_Info;
	permanent = FALSE;
	description = "Do you have an assignment for me?";
};


func int DIA_Gorax_Aufgabe_Condition()
{
	if(MIS_KlosterArbeit == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Gorax_Aufgabe_Info()
{
	DIA_Common_AnyMissionForMe();
	AI_Output (self, other, "DIA_Gorax_Aufgabe_14_01");	//You novices have worked hard lately. And those who work a lot shall eat a lot, too.
	AI_Output (self, other, "DIA_Gorax_Aufgabe_14_02");	//I'm giving you the key to the larder. You'll find some mutton sausages there. Distribute them among the novices - but fairly!
	AI_Output (self, other, "DIA_Gorax_Aufgabe_14_03");	//Once you have done that, you can come see me again.
	CreateInvItems(self,ItKe_KlosterStore,1);
	B_GiveInvItems(self,other,ItKe_KlosterStore,1);
	MIS_GoraxEssen = LOG_Running;
	Log_CreateTopic (Topic_GoraxEssen, LOG_MISSION);
	Log_SetTopicStatus (Topic_GoraxEssen, LOG_Running);
	B_LogEntry (Topic_GoraxEssen, "Master Gorax wants me to share the mutton sausages from the larder out equally among the novices. Apart from me, there are thirteen more novices in the monastery.");
};


instance DIA_Gorax_Wurst(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 2;
	condition = DIA_Gorax_Wurst_Condition;
	information = DIA_Gorax_Wurst_Info;
	permanent = TRUE;
	description = "I have distributed the sausages (complete task).";
};


func int DIA_Gorax_Wurst_Condition()
{
	if((MIS_GoraxEssen == LOG_Running) && !Mob_HasItems("WURSTTRUHE",ItFo_Schafswurst))
	{
		return TRUE;
	};
};

func void DIA_Gorax_Wurst_Info()
{
	AI_Output (other, self, "DIA_Gorax_Wurst_15_00");	//I have distributed the sausages.
	if (Wurst_Gegeben >= 13)
	{
		AI_Output (self, other, "DIA_Gorax_Wurst_14_01");	//And you have done so fairly. Take these spell scrolls of healing - and go back to your work.
		MIS_GoraxEssen = LOG_SUCCESS;
		B_GivePlayerXP(XP_GoraxEssen);
		B_GiveInvItems(self,other,ItSc_LightHeal,2);
	}
	else
	{
		AI_Output (self, other, "DIA_Gorax_Wurst_14_02");	//Really? Then you cannot have put much effort into fulfilling your task.
		AI_Output (self, other, "DIA_Gorax_Wurst_14_03");	//So, either you ate those sausages yourself, or you gave someone more than his share.
		AI_Output (self, other, "DIA_Gorax_Wurst_14_04");	//Listen, since you're new - and for that reason only - I shall let you get away with it. Keep that in mind, novice!
		MIS_GoraxEssen = LOG_FAILED;
		B_CheckLog();
	};
};


instance DIA_Gorax_Aufgabe2(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 3;
	condition = DIA_Gorax_Aufgabe2_Condition;
	information = DIA_Gorax_Aufgabe2_Info;
	permanent = FALSE;
	description = "Do you have another assignment for me?";
};


func int DIA_Gorax_Aufgabe2_Condition()
{
	if(((MIS_GoraxEssen == LOG_SUCCESS) || (MIS_GoraxEssen == LOG_FAILED)) && !Npc_IsDead(Orlan))
	{
		return TRUE;
	};
};

func void DIA_Gorax_Aufgabe2_Info()
{
	AI_Output (other, self, "DIA_Gorax_Aufgabe2_15_00");	//Do you have another assignment for me?
	AI_Output (self, other, "DIA_Gorax_Aufgabe2_14_01");	//Yes. As you know, we make an excellent wine here and we sell it, too.
	AI_Output (self, other, "DIA_Gorax_Aufgabe2_14_02");	//Orlan, the landlord of the inn 'The Dead Harpy' has ordered a shipment. We've agreed on 240 gold pieces for the bottles.
	AI_Output (self, other, "DIA_Gorax_Aufgabe2_14_03");	//Bring him these bottles - but don't let him shortchange you.
	CreateInvItems(self,ItFo_Wine,12);
	B_GiveInvItems(self,other,ItFo_Wine,12);
	MIS_GoraxWein = LOG_Running;
	Log_CreateTopic (Topic_GoraxWein, LOG_MISSION);
	Log_SetTopicStatus (Topic_GoraxWein, LOG_Running);
	B_LogEntry (Topic_GoraxWein, "Master Gorax wants me to take Orlan, the landlord of the inn, twelve bottles of wine. The price is 240 pieces of gold.");
};


var int DIA_Gorax_Orlan_permanent;

instance DIA_Gorax_Orlan(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 3;
	condition = DIA_Gorax_Orlan_Condition;
	information = DIA_Gorax_Orlan_Info;
	permanent = TRUE;
	description = "I went to see Orlan.";
};

func int DIA_Gorax_Orlan_Condition()
{
	if((MIS_GoraxWein == LOG_Running) && Npc_KnowsInfo(other,DIA_Orlan_Wein) && (DIA_Gorax_Orlan_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Gorax_Orlan_Info()
{
	AI_Output(other,self,"DIA_Gorax_Orlan_15_00");	//I went to see Orlan.
	if(Npc_HasItems(other,ItMi_Gold) >= 100)
	{
		AI_Output(self,other,"DIA_Gorax_Orlan_14_01");	//And, did you get the 240 gold coins?
		DIA_Gorax_Orlan_permanent = TRUE;
		Info_ClearChoices (DIA_Gorax_Orlan);
		Info_AddChoice (DIA_Gorax_Orlan, "He put one over on me! (Give 100 gold)", DIA_Gorax_Orlan_100);
		Info_AddChoice (DIA_Gorax_Orlan, "I've got the gold. (Give 240 gold)", DIA_Gorax_Orlan_240);
	}
	else
	{
		AI_Output (self, other, "DIA_Gorax_Orlan_14_02");	//What have you done with that gold? Did you spend it? Go get it and then come back!
	};
};

func void B_Gorax_YouAreUseless()
{
	AI_Output(self,other,"DIA_Gorax_Orlan_100_14_02");	//You really are utterly and completely useless. Now get out of my sight.
};

func void DIA_Gorax_Orlan_100()
{
	AI_Output(other,self,"DIA_Gorax_Orlan_100_15_00");	//He put one over on me!
	B_GiveInvItems(other,self,ItMi_Gold,100);
	AI_Output(self,other,"DIA_Gorax_Orlan_100_14_01");	//You sold it to him cheaper? Oh no, why did I have to send YOU of all people?
	B_Gorax_YouAreUseless();
	MIS_GoraxWein = LOG_FAILED;
	Goraxday = Wld_GetDay() + 1;
	Info_ClearChoices(DIA_Gorax_Orlan);
	AI_StopProcessInfos(self);
};

func void DIA_Gorax_Orlan_240()
{
	AI_Output (other, self, "DIA_Gorax_Orlan_240_15_00");	//I've got the gold.
	if (B_GiveInvItems (other, self, ItMi_Gold, 240))
	{
		AI_Output (self, other, "DIA_Gorax_Orlan_240_14_01");	//Excellent. You're really useful. Take this spell scroll of healing as a reward. And now go and find yourself something else to do.
		MIS_GoraxWein = LOG_SUCCESS;
		B_GivePlayerXP(XP_GoraxWein);
		B_GiveInvItems(self,other,ItSc_MediumHeal,1);
	}
	else
	{
		B_GiveInvItems(other,self,ItMi_Gold,Npc_HasItems(other,ItMi_Gold));
		AI_Output(self,other,"DIA_Gorax_Orlan_240_14_02");	//But you've already spent part of the money, haven't you? You're good for nothing - begone!
		MIS_GoraxWein = LOG_FAILED;
		Goraxday = Wld_GetDay() + 1;
	};
	Info_ClearChoices(DIA_Gorax_Orlan);
};


/*instance DIA_Gorax_Orlan_TooLate(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 3;
	condition = DIA_Gorax_Orlan_TooLate_Condition;
	information = DIA_Gorax_Orlan_TooLate_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Gorax_Orlan_TooLate_Condition()
{
	if((other.guild == GIL_NOV) && (MIS_GoraxWein == LOG_OBSOLETE))
	{
		return TRUE;
	};

};

func void DIA_Gorax_Orlan_TooLate_Info()
{
	B_Gorax_YouAreUseless();
	Goraxday = Wld_GetDay() + 1;
	AI_StopProcessInfos(self);
};*/


instance DIA_Gorax_JOB(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 35;
	condition = DIA_Gorax_JOB_Condition;
	information = DIA_Gorax_JOB_Info;
	permanent = FALSE;
	description = "What's your task here?";
};


func int DIA_Gorax_JOB_Condition()
{
	return TRUE;
};

func void DIA_Gorax_JOB_Info()
{
	AI_Output(other,self,"DIA_Gorax_JOB_15_00");	//What's your task here?
	AI_Output (self, other, "DIA_Gorax_JOB_14_01");	//My tasks are many and varied. Not only am I the steward, but I am also the treasurer.
	AI_Output (self, other, "DIA_Gorax_JOB_14_02");	//Moreover, I supervise the wine cellar, and I'm in control of the monastery's food supplies.
	AI_Output (self, other, "DIA_Gorax_JOB_14_03");	//So, if there's anything you need, you can always come to me and get it - for a modest contribution, that is.
	if(Gorax_Trade == FALSE)
	{
		Log_CreateTopic(Topic_KlosterTrader,LOG_NOTE);
		B_LogEntry(Topic_KlosterTrader,"Master Gorax can supply me with everything I need at the monastery.");
		Gorax_Trade = TRUE;
	};
};


func void B_Gorax_INeedSomething()
{
	AI_Output(other,self,"DIA_Gorax_TRADE_15_00");	//I need a few things...
};

instance DIA_Gorax_TRADE(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 99;
	condition = DIA_Gorax_TRADE_Condition;
	information = DIA_Gorax_TRADE_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "I need a few things...";
};


func int DIA_Gorax_TRADE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gorax_JOB) && (Goraxday <= Wld_GetDay()))
	{
		return TRUE;
	};
};

func void DIA_Gorax_TRADE_Info()
{
	B_Gorax_INeedSomething();
	B_GiveTradeInv(self);
	if(!Npc_HasItems(self,ItMi_Pliers) && !Npc_HasItems(other,ItMi_Pliers))
	{
		CreateInvItems(self,ItMi_Pliers,1);
	};
	if(Npc_HasItems(self,ItKe_KlosterSchatz))
	{
		Npc_RemoveInvItem(self,ItKe_KlosterSchatz);
	};
	Trade_IsActive = TRUE;
};

/////////////////////////////////////////////////////
instance DIA_Gorax_NOTRADE(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 99;
	condition = DIA_Gorax_NOTRADE_Condition;
	information = DIA_Gorax_NOTRADE_Info;
	permanent = TRUE;
	description = "I need a few things...";
};


func int DIA_Gorax_NOTRADE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gorax_JOB) && (Goraxday > Wld_GetDay()) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Gorax_NOTRADE_Info()
{
	B_Gorax_INeedSomething();
	B_Gorax_YouAreUseless();
	AI_StopProcessInfos(self);
};

/////////////////////////////////////////////////////
instance DIA_Gorax_KDF(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 5;
	condition = DIA_Gorax_KDF_Condition;
	information = DIA_Gorax_KDF_Info;
	permanent = FALSE;
	description = "I need a new place to sleep.";
};


func int DIA_Gorax_KDF_Condition()
{
	if((other.guild == GIL_KDF) && Npc_KnowsInfo(other,DIA_Gorax_JOB))
	{
		return TRUE;
	};
};

func void DIA_Gorax_KDF_Info()
{
	AI_Output(other,self,"DIA_Gorax_KDF_15_00");	//I need a new place to sleep.
	AI_Output(self,other,"DIA_Gorax_KDF_14_01");	//There's a free chamber on the right here. Take the key. You'll find everything you need there.
	B_GiveInvItems(self,other,ItKe_KDFPlayer,1);
	Wld_InsertItem(ItPo_Perm_Mana,"FP_ITEM_KDFPLAYER");
};


instance DIA_Gorax_KILLPEDRO(C_Info)
{
	npc = KDF_508_Gorax;
	nr = 3;
	condition = DIA_Gorax_KILLPEDRO_Condition;
	information = DIA_Gorax_KILLPEDRO_Info;
	important = TRUE;
};


func int DIA_Gorax_KILLPEDRO_Condition()
{
	if((Pedro_Traitor == TRUE) && ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)))
	{
		return TRUE;
	};
};

func void DIA_Gorax_KILLPEDRO_Info()
{
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_14_00");	//Wait, mercenary. I need to talk to you.
	AI_Output (other, self, "DIA_Gorax_KILLPEDRO_15_01");	//What do you want?
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_14_02");	//The monastery is facing a very delicate situation.
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_14_03");	//At the moment, everyone seems to mistrust everybody else. And then, this thing with Pedro, that's extremely ... (gulps)
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_14_04");	//I have an assignment for you from the highest authorities. You are not a member of the Brotherhood of the Fire, and therefore the only one here who can settle this matter for us.
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_14_05");	//But I must warn you. If I give you this assignment, you'll be bound to fulfill it, too. Once you know what it's about, you'll have no choice. Do you understand?
	Npc_ExchangeRoutine(self,"Start");
	Info_ClearChoices(DIA_Gorax_KILLPEDRO);
	Info_AddChoice (DIA_Gorax_KILLPEDRO, "Forget it. That's too risky for me.", DIA_Gorax_KILLPEDRO_nein);
	Info_AddChoice (DIA_Gorax_KILLPEDRO, "Tell me what you want.", DIA_Gorax_KILLPEDRO_ja);
};

func void DIA_Gorax_KILLPEDRO_nein()
{
	AI_Output (other, self, "DIA_Gorax_KILLPEDRO_nein_15_00");	//Forget it. That's too risky for me.
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_nein_14_01");	//All right. In that case, forget I said anything.
	AI_StopProcessInfos (self);
};

func void DIA_Gorax_KILLPEDRO_ja()
{
	AI_Output (other, self, "DIA_Gorax_KILLPEDRO_ja_15_00");	//Tell me what you want.
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_ja_14_01");	//All right. Then listen well, for I'm only going to say this once.
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_ja_14_02");	//Serpentes wants you to kill Pedro for his treason as soon as you lay your hands on him.
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_ja_14_03");	//You will be paid as soon as this task is fulfilled.
	AI_Output (self, other, "DIA_Gorax_KILLPEDRO_ja_14_04");	//I never said that. And you haven't heard anything either, understand?
	B_LogEntry (TOPIC_TraitorPedro, "Gorax told me that Serpentes wants me to kill the traitor Pedro if I come across him.");
	B_GivePlayerXP (XP_Gorax_KILLPEDRO_GotMission);
	MIS_Gorax_KillPedro = LOG_Running;
	AI_StopProcessInfos(self);
};


