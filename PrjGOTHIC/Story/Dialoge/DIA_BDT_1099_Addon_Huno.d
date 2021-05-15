
instance DIA_Addon_Huno_EXIT(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 999;
	condition = DIA_Addon_Huno_EXIT_Condition;
	information = DIA_Addon_Huno_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Huno_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Huno_EXIT_Info()
{
	B_EquipTrader(self);
	EnteredBanditsCamp = TRUE;
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Huno_PICKPOCKET(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 900;
	condition = DIA_Addon_Huno_PICKPOCKET_Condition;
	information = DIA_Addon_Huno_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Addon_Huno_PICKPOCKET_Condition()
{
	return C_Beklauen(85,102);
};

func void DIA_Addon_Huno_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Huno_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Huno_PICKPOCKET,Dialog_Back,DIA_Addon_Huno_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Huno_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Huno_PICKPOCKET_DoIt);
};

func void DIA_Addon_Huno_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Huno_PICKPOCKET);
};

func void DIA_Addon_Huno_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Huno_PICKPOCKET);
};


instance DIA_Addon_Huno_Abwimmeln(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 1;
	condition = DIA_Addon_Huno_Abwimmeln_Condition;
	information = DIA_Addon_Huno_Abwimmeln_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Huno_Abwimmeln_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		if(Huno_MEGA_Angepisst == TRUE)
		{
			return TRUE;
		};
		if((Huno_zuSnaf == TRUE) && !Npc_KnowsInfo(other,DIA_Addon_Fisk_Meeting))
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Huno_Abwimmeln_Info()
{
	if(Huno_MEGA_Angepisst == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Huno_Abwimmeln_06_00");	//What do you want now? Piss off!
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Huno_Abwimmeln_06_01");	//What are you waiting for? Go to the bar!
	};
	AI_StopProcessInfos(self);
};


var int Knows_Flucht;
var int Huno_Angepisst;

instance DIA_Addon_Huno_Hi(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 1;
	condition = DIA_Addon_Huno_Hi_Condition;
	information = DIA_Addon_Huno_Hi_Info;
	permanent = FALSE;
	description = "It looks like you're a master of your craft.";
};


func int DIA_Addon_Huno_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Huno_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_Huno_Hi_15_00");	//It looks like you're a master of your craft.
	AI_Output (self, other, "DIA_Addon_Huno_Hi_06_01");	//I've heard that before... Did you bring the steel?
	AI_Output (other, self, "DIA_Addon_Huno_Hi_15_02");	//Steel? No, I think you're confusing me with...
	AI_Output (self, other, "DIA_Addon_Huno_Hi_06_03");	//Hm... somehow you seem familiar. Do we know each other from somewhere?
	Info_ClearChoices (DIA_Addon_Huno_Hi);
	Info_AddChoice (DIA_Addon_Huno_Hi, "Sure, from the Old Camp.", DIA_Addon_Huno_Hi_JA);
	Info_AddChoice (DIA_Addon_Huno_Hi, "I wouldn't know where from.", DIA_Addon_Huno_Hi_NO);
	Log_CreateTopic (Topic_Addon_BDT_Trader, LOG_NOTE);
	B_LogEntry (Topic_Addon_BDT_Trader, "Huno deals in smithy equipment.");
};

func void DIA_Addon_Huno_Hi_JA()
{
	AI_Output (other, self, "DIA_Addon_Huno_Hi_JA_15_00");	//Sure, from the Old Camp.
	AI_Output (self, other, "DIA_Addon_Huno_Hi_JA_06_01");	//The Old Camp... right... you're that curious guy... I thought you were dead.
	AI_Output (other, self, "DIA_Addon_Huno_Hi_JA_15_02");	//Yes, everybody thinks that. Who else survived?
	AI_Output (self, other, "DIA_Addon_Huno_Hi_JA_06_03");	//A few. Some fled with Raven like I did. For a lot of others, the Old Camp became a grave.
	Info_ClearChoices (DIA_Addon_Huno_Hi);
	Knows_Flucht = TRUE;
};

func void DIA_Addon_Huno_Hi_NO()
{
	AI_Output (other, self, "DIA_Addon_Huno_Hi_NO_15_00");	//I wouldn't know where from.
	AI_Output (self, other, "DIA_Addon_Huno_Hi_NO_06_01");	//Hm... my brain is like a sieve... whatever...
	Info_ClearChoices (DIA_Addon_Huno_Hi);
};


instance DIA_Addon_Huno_Blitz(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 2;
	condition = DIA_Addon_Huno_Blitz_Condition;
	information = DIA_Addon_Huno_Blitz_Info;
	permanent = FALSE;
	description = "Tell me about your escape.";
};


func int DIA_Addon_Huno_Blitz_Condition()
{
	if((Knows_Flucht == TRUE) && (Huno_Angepisst == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Huno_Blitz_Info()
{
	AI_Output (other, self, "DIA_Addon_Huno_Blitz_15_00");	//Tell me about your escape.
	AI_Output (self, other, "DIA_Addon_Huno_Blitz_06_01");	//Chaos broke out the day the Barrier fell.
	AI_Output (self, other, "DIA_Addon_Huno_Blitz_06_02");	//Some hid - others fled, and there was plundering everywhere.
	AI_Output (other, self, "DIA_Addon_Huno_Blitz_15_03");	//What did you do?
	AI_Output (self, other, "DIA_Addon_Huno_Blitz_06_04");	//I was about to to leave the camp when it turned bright very suddenly and a scorching pain ate through my skin.
	AI_Output (self, other, "DIA_Addon_Huno_Blitz_06_05");	//I'd been struck by damn lightning! It feels like I can still hear it...
	AI_Output (self, other, "DIA_Addon_Huno_Blitz_06_06");	//Later someone told me that Thorus found me and took me with him.
};


var int Huno_ArmorPerm;

instance DIA_Addon_Huno_Armor(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 3;
	condition = DIA_Addon_Huno_Armor_Condition;
	information = DIA_Addon_Huno_Armor_Info;
	permanent = TRUE;
	description = "I need better armor.";
};


func int DIA_Addon_Huno_Armor_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Huno_Hi) && (Huno_ArmorPerm == FALSE) && (Huno_Angepisst == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Huno_Armor_Info()
{
	Info_ClearChoices (DIA_Addon_Huno_Armor);
	AI_Output (other, self, "DIA_Addon_Huno_Armor_15_00");	//I need better armor.
	if (Huno_ArmorCheap == FALSE)
	{
		if(!Npc_IsDead(Esteban))
		{
			AI_Output (self, other, "DIA_Addon_Huno_Armor_06_01");	//So - you can have this. It's Esteban's fault it's so expensive.
			AI_Output (self, other, "DIA_Addon_Huno_Armor_06_02");	//That damned dog pockets his share of every piece of armor I sell.
		};
		BDT_Armor_H_Value = 2100;
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Huno_Armor_15_03");	//Fisk said you'd give me a good price?
		AI_Output (self, other, "DIA_Addon_Huno_Armor_06_04");	//Fisk, you say? Hm, well, I still owe him a favor.
		BDT_Armor_H_Value = 1000;
	};
	Info_AddChoice(DIA_Addon_Huno_Armor,Dialog_Back,DIA_Addon_Huno_Armor_BACK);
	Info_AddChoice(DIA_Addon_Huno_Armor,B_BuildPriceString("Купить тяжелые доспехи бандита. Защита: 50/50/0/0.",BDT_Armor_H_Value),DIA_Addon_Huno_Armor_BUY);
};

func void DIA_Addon_Huno_Armor_BACK()
{
	Info_ClearChoices(DIA_Addon_Huno_Armor);
};

func void DIA_Addon_Huno_Armor_BUY()
{
	AI_Output (other, self, "DIA_Addon_Huno_Armor_Buy_15_00");	//Okay, I'll take the armor.
	if (B_GiveInvItems (other, self, ItMi_Gold, BDT_Armor_H_Value))
	{
		AI_Output(self,other,"DIA_Addon_Huno_Armor_Buy_06_01");	//Sure thing.
		B_GiveArmor(ITAR_BDT_H);
		Huno_ArmorPerm = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Huno_Armor_Buy_06_02");	//No gold, no armor.
	};
	/*if(BDT_Armor_H_Value < 2100)
	{
		Huno_ArmorPerm = TRUE;
	};*/
	Info_ClearChoices(DIA_Addon_Huno_Armor);
};


instance DIA_Addon_Huno_Attentat(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 4;
	condition = DIA_Addon_Huno_Attentat_Condition;
	information = DIA_Addon_Huno_Attentat_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_ATTENTAT_DESCRIPTION2;
};


func int DIA_Addon_Huno_Attentat_Condition()
{
	if(MIS_Judas == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Huno_Attentat_Info()
{
	B_Say(other,self,"$ATTENTAT_ADDON_DESCRIPTION2");
	AI_Output (self, other, "DIA_Addon_Huno_Attentat_06_00");	//(dangerously) What do you want from me?
	AI_Output (other, self, "DIA_Addon_Huno_Attentat_15_01");	//I'm looking for the person behind the attack...
	AI_Output (self, other, "DIA_Addon_Huno_Attentat_06_02");	//And why are you coming to me about that?
	AI_Output (other, self, "DIA_Addon_Huno_Attentat_15_03");	//I thought you might know something about the business.
	DIA_Common_06_IKnowNothingAboutIt();
};


var int Huno_nochmal;
var int Huno_SomeThings_PERM;
var int Huno_Counter;

func void B_Addon_Huno_Stress()
{
	AI_Output (self, other, "DIA_Addon_Huno_Stress_06_00");	//(sighs) Now, listen! You move your ass out of here, before I forget myself!
	Huno_Angepisst = TRUE;
};


instance DIA_Addon_Huno_SomeThings(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 4;
	condition = DIA_Addon_Huno_SomeThings_Condition;
	information = DIA_Addon_Huno_SomeThings_Info;
	permanent = TRUE;
	description = "I've heard a few things about you...";
};


func int DIA_Addon_Huno_SomeThings_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Huno_Attentat) && (Huno_SomeThings_PERM == FALSE) && ((Finn_TellAll == TRUE) || (Paul_TellAll == TRUE) || (Emilio_TellAll == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Huno_SomeThings_Info()
{
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_15_00");	//I've heard a few things about you...
	if (Huno_nochmal == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Huno_SomeThings_06_01");	//So?
		Huno_nochmal = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Huno_SomeThings_06_02");	//Again? (threatening) It had better be something important this time...
	};
	Huno_Counter = 0;
	if(Finn_TellAll == TRUE)
	{
		AI_Output (other, self, "DIA_Addon_Huno_SomeThings_15_03");	//I heard that you weren't in your place when the attack occurred!
		AI_Output (self, other, "DIA_Addon_Huno_SomeThings_06_04");	//(dangerously) What else?
		Huno_Counter += 1;
	};
	if(Paul_TellAll == TRUE)
	{
		AI_Output (other, self, "DIA_Addon_Huno_SomeThings_15_05");	//Paul said you hate Esteban.
		AI_Output (self, other, "DIA_Addon_Huno_SomeThings_06_06");	//(dangerously) So? Did he? What else?
		Huno_Counter += 1;
	};
	if(Emilio_TellAll == TRUE)
	{
		AI_Output (other, self, "DIA_Addon_Huno_SomeThings_15_07");	//Emilio spat out your name! You definitely know something about the attack!
		AI_Output (self, other, "DIA_Addon_Huno_SomeThings_06_08");	//(calmly) You've been having a chat with old Emilio, eh?
		if (Huno_Counter > 0)
		{
			AI_Output (other, self, "DIA_Addon_Huno_SomeThings_15_09");	//And he isn't the only one who suspects you!
			AI_PlayAni (self, "T_SEARCH");
			AI_Output (self, other, "DIA_Addon_Huno_SomeThings_06_10");	//What's that supposed to mean, hm?
			Huno_SomeThings_PERM = TRUE;
			Info_ClearChoices (DIA_Addon_Huno_SomeThings);
			Info_AddChoice (DIA_Addon_Huno_SomeThings, "I want to join forces with the assassin!", DIA_Addon_Huno_SomeThings_Contra);
			Info_AddChoice (DIA_Addon_Huno_SomeThings, "If you were behind the attack, you'll pay for it!", DIA_Addon_Huno_SomeThings_Pro);
			B_LogEntry (Topic_Addon_Esteban, "It looks like I have Huno by the balls.");
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Huno_SomeThings_06_11");	//(threatening) Maybe I should also have a word with him. I'm sure that AFTERWARDS he'll say the exact opposite!
			B_Addon_Huno_Stress ();
			AI_StopProcessInfos (self);
		};
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Huno_SomeThings_15_12");	//Nothing else...
		B_Addon_Huno_Stress ();
		AI_StopProcessInfos (self);
	};
};

func void DIA_Addon_Huno_SomeThings_Pro()
{
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_Pro_15_00");	//If you were behind the attack, you'll pay for it!
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Pro_06_01");	//(annoyed) You are such an idiot! Do you really think you can toady up to Esteban?
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Pro_06_02");	//Get out of here!
	Huno_MEGA_Angepisst = TRUE;
	Info_ClearChoices(DIA_Addon_Huno_SomeThings);
	AI_StopProcessInfos(self);
};

func void DIA_Addon_Huno_SomeThings_Contra()
{
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_Contra_15_00");	//I want to join forces with the assassin!
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Contra_06_01");	//Against Esteban? Really? Then prove it!
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Contra_06_02");	//I've been waiting for too long for a delivery of steel from the pirates.
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Contra_06_03");	//I suspect that Esteban captured it in order to sell it to me later at a higher price.
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Contra_06_04");	//Of course, he won't do that himself. A couple of bandits in the swamp are on his payroll.
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_Contra_15_05");	//How do you know that?
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Contra_06_06");	//Drunken bandits talk too much...
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_Contra_15_07");	//Does this talkative bandit have a name?
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Contra_06_08");	//His name is none of your business. But the guy you're LOOKING for is called Juan. Anyway, I haven't seen him in the camp for a long time.
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Contra_06_09");	//You'll have to look for him in the swamp.
	MIS_Huno_Stahl = LOG_Running;
	Huno_Angepisst = FALSE;
	Log_CreateTopic (Topic_Addon_Huno, LOG_MISSION);
	Log_SetTopicStatus (Topic_Addon_Huno, LOG_Running);
	B_LogEntry (Topic_Addon_Huno, "Huno is waiting for a delivery of steel from the pirates. He thinks that a guy named Juan stole it for Esteban. He is hiding somewhere in the swamp.");
	Info_ClearChoices (DIA_Addon_Huno_SomeThings);
	Info_AddChoice (DIA_Addon_Huno_SomeThings, "First tell me who is behind the attack!", DIA_Addon_Huno_SomeThings_TellMeNow);
	Info_AddChoice (DIA_Addon_Huno_SomeThings, "Okay, I'll do it for you!", DIA_Addon_Huno_SomeThings_Mission);
};

func void DIA_Addon_Huno_SomeThings_Mission()
{
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_Mission_15_00");	//Okay, I'll do it for you!
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_Mission_06_01");	//Good. We'll see if you can be trusted.
	Info_ClearChoices (DIA_Addon_Huno_SomeThings);
	AI_StopProcessInfos (self);
};

func void DIA_Addon_Huno_SomeThings_TellMeNow()
{
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_TellMeNow_15_00");	//First tell me who is behind the attack!
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_TellMeNow_06_01");	//No. I don't trust you.
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_TellMeNow_15_02");	//Look. The next conversation I have is either going to be with the person behind the attack or with Esteban.
	AI_Output (other, self, "DIA_Addon_Huno_SomeThings_TellMeNow_15_03");	//Who I talk to is your choice.
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_TellMeNow_06_04");	//(sighs) All right. I'll get you together with the perpetrator. But it happens the way I say, got it?
	AI_Output (self, other, "DIA_Addon_Huno_SomeThings_TellMeNow_06_05");	//Go to the bar and talk to the barkeeper. You'll learn everything else from him.
	Huno_zuSnaf = TRUE;
	Info_ClearChoices (DIA_Addon_Huno_SomeThings);
	AI_StopProcessInfos (self);
	B_LogEntry (Topic_Addon_Esteban, "Huno told me I should talk to Snaf.");
};


instance DIA_Addon_Huno_Paket(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 3;
	condition = DIA_Addon_Huno_Paket_Condition;
	information = DIA_Addon_Huno_Paket_Info;
	permanent = FALSE;
	description = "I have the steel.";
};


func int DIA_Addon_Huno_Paket_Condition()
{
	if((MIS_Huno_Stahl == LOG_Running) && Npc_HasItems(other,ItMi_Addon_Steel_Paket))
	{
		return TRUE;
	};
};

func void DIA_Addon_Huno_Paket_Info()
{
	AI_Output(other,self,"DIA_Addon_Huno_Paket_15_00");	//I have the steel.
	B_GiveInvItems(other,self,ItMi_Addon_Steel_Paket,1);
	Npc_RemoveInvItem(self,ItMi_Addon_Steel_Paket);
	AI_Output (self, other, "DIA_Addon_Huno_Paket_06_01");	//And? Was Juan there, too?
	AI_Output (other, self, "DIA_Addon_Huno_Paket_15_02");	//He was.
	AI_Output (self, other, "DIA_Addon_Huno_Paket_06_03");	//I knew it. That rat Esteban was behind it.
	if(Huno_zuSnaf == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Huno_Paket_06_04");	//You're all right. To be honest, I hadn't expected this from you.
		AI_Output (self, other, "DIA_Addon_Huno_Paket_06_05");	//Here, take this as a reward.
		B_GiveInvItems (self, other, ItMi_Gold, 200);
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Huno_Paket_15_06");	//Now, what about our agreement?
		AI_Output (self, other, "DIA_Addon_Huno_Paket_06_07");	//The man you want to talk to is waiting for you in the bar. Talk to the barkeeper.
		Huno_zuSnaf = TRUE;
	};
	B_LogEntry (Topic_Addon_Esteban, "Huno told me I should talk to Snaf.");
	MIS_Huno_Stahl = LOG_SUCCESS;
	B_GivePlayerXP(XP_Addon_HunoStahl);
};


instance DIA_Addon_Huno_Trade(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 888;
	condition = DIA_Addon_Huno_Trade_Condition;
	information = DIA_Addon_Huno_Trade_Info;
	permanent = TRUE;
	trade = TRUE;
	description = DIALOG_TRADE_v3;
};


func int DIA_Addon_Huno_Trade_Condition()
{
	if(Huno_Angepisst == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Huno_Trade_Info()
{
	if(Huno_flag == TRUE)
	{
		B_ClearSmithInv(self);
		if(Huno_swordraws > 0)
		{
			CreateInvItems(self,ItMiSwordraw,Huno_swordraws);
		};
		Huno_flag = FALSE;
	};
	B_Say(other,self,"$TRADE_3");
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};

instance DIA_Huno_RepairNecklace(C_Info)
{
	npc = BDT_1099_Addon_Huno;
	nr = 600;
	condition = DIA_Huno_RepairNecklace_Condition;
	information = DIA_Huno_RepairNecklace_Info;
	permanent = FALSE;
	description = "Can you repair jewelry?";
};


func int DIA_Huno_RepairNecklace_Condition()
{
	if((MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS) && (Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)))
	{
		if(!Npc_KnowsInfo(other,DIA_Bennet_ShowInnosEye))
		{
			return TRUE;
		};
	};
};

func void DIA_Huno_RepairNecklace_Info()
{
	DIA_Common_CanYouRepairJewelry();
	DIA_Common_06_IKnowNothingAboutIt();
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
	AI_StopProcessInfos(self);
};

