
instance DIA_Bromor_EXIT(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 999;
	condition = DIA_Bromor_EXIT_Condition;
	information = DIA_Bromor_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Bromor_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Bromor_EXIT_Info()
{
	B_NpcClearObsessionByDMT(self);
};


instance DIA_Bromor_GIRLS(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 2;
	condition = DIA_Bromor_GIRLS_Condition;
	information = DIA_Bromor_GIRLS_Info;
	permanent = FALSE;
	description = "Are you the one who runs this place?";
};


func int DIA_Bromor_GIRLS_Condition()
{
	if(NpcObsessedByDMT_Bromor == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Bromor_GIRLS_Info()
{
	AI_Output (other, self, "DIA_Addon_Bromor_GIRLS_15_00");	//Are you the one who runs this place?
	AI_Output (self, other, "DIA_Bromor_GIRLS_07_02");	//I am Bromor. This is my house, and these are my girls. I like my girls.
	AI_Output (self, other, "DIA_Bromor_GIRLS_07_03");	//And if you like my girls, too, then you'll pay for it - 50 gold pieces.
	AI_Output (self, other, "DIA_Bromor_GIRLS_07_04");	//And don't get the idea of making trouble here.
};


instance DIA_Addon_Bromor_MissingPeople(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 2;
	condition = DIA_Addon_Bromor_MissingPeople_Condition;
	information = DIA_Addon_Bromor_MissingPeople_Info;
	description = "Are all your girls accounted for?";
};


func int DIA_Addon_Bromor_MissingPeople_Condition()
{
	if((NpcObsessedByDMT_Bromor == FALSE) && (SC_HearedAboutMissingPeople == TRUE) && Npc_KnowsInfo(other,DIA_Bromor_GIRLS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Bromor_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Bromor_MissingPeople_15_00");	//Are all your girls accounted for?
	AI_Output (self, other, "DIA_Addon_Bromor_MissingPeople_07_01");	//Of course they are. Or did you think I want to go to jail over something like that?
	AI_Output (other, self, "DIA_Addon_Bromor_MissingPeople_15_02");	//(irritated) Er ... I wasn't asking about your payroll. I mean, are they all PRESENT? Or have any gone missing?
	AI_Output (self, other, "DIA_Addon_Bromor_MissingPeople_07_03");	//Oh. Yes, actually. One of my girls has up and left. Her name's Lucia.
	AI_Output (self, other, "DIA_Addon_Bromor_MissingPeople_07_04");	//I reported it to the militia, too. But they claim they haven't found a trace of her yet.
	LuciaMentionedInKhorinis = TRUE;
	if(MissingPeopleReturnedHome == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
	};
	B_LogEntries(TOPIC_Addon_MissingPeople,"A whore named Lucia has disappeared from the brothel down by the harbor.");
	if(MIS_LookingForLucia == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_Lucia,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_Lucia,LOG_Running);
		B_LogNextEntry(TOPIC_Addon_Lucia,"A whore named Lucia has disappeared from the brothel down by the harbor.");
		MIS_LookingForLucia = LOG_Running;
	};
};


instance DIA_Addon_Bromor_Lucia(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 5;
	condition = DIA_Addon_Bromor_Lucia_Condition;
	information = DIA_Addon_Bromor_Lucia_Info;
	description = "How long has Lucia been missing?";
};


func int DIA_Addon_Bromor_Lucia_Condition()
{
	if((NpcObsessedByDMT_Bromor == FALSE) && (SC_HearedAboutMissingPeople == TRUE) && Npc_KnowsInfo(other,DIA_Addon_Bromor_MissingPeople))
	{
		return TRUE;
	};
};

func void DIA_Addon_Bromor_Lucia_Info()
{
	AI_Output (other, self, "DIA_Addon_Bromor_Lucia_15_00");	//How long has Lucia been missing?
	AI_Output (self, other, "DIA_Addon_Bromor_Lucia_07_01");	//Several days. I don't know exactly how long.
	AI_Output (self, other, "DIA_Addon_Bromor_Lucia_07_02");	//I assume she's run off with one of her suitors.
	AI_Output (self, other, "DIA_Addon_Bromor_Lucia_07_03");	//That bitch made off with part of my savings. A really valuable golden dish.
	AI_Output (self, other, "DIA_Addon_Bromor_Lucia_07_04");	//If I get hold of her, I'll give her what for.
	AI_Output (self, other, "DIA_Addon_Bromor_Lucia_07_05");	//So how's that any business of YOURS? Are you trying to make fun of me, or what?
	Log_CreateTopic (TOPIC_Addon_BromorsGold, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_BromorsGold, LOG_Running);
	B_LogEntry (TOPIC_Addon_BromorsGold, "Lucia the whore stole a golden dish from her boss, Bromor. Bromor wants it back.");
	MIS_Bromor_LuciaStoleGold = LOG_Running;
};


instance DIA_Addon_Bromor_LuciaGold(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 5;
	condition = DIA_Addon_Bromor_LuciaGold_Condition;
	information = DIA_Addon_Bromor_LuciaGold_Info;
	permanent = TRUE;
	description = "I found the dish that Lucia stole from you.";
};


func int DIA_Addon_Bromor_LuciaGold_Condition()
{
//	if((NpcObsessedByDMT_Bromor == FALSE) && (MIS_Bromor_LuciaStoleGold == LOG_Running) && Npc_HasItems(other,ItMi_BromorsGeld_Addon))
	if((MIS_Bromor_LuciaStoleGold == LOG_Running) && Npc_HasItems(other,ItMi_BromorsGeld_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Bromor_LuciaGold_Info()
{
	AI_Output (other, self, "DIA_Addon_Bromor_LuciaGold_15_00");	//I found the dish that Lucia stole from you.
	AI_Output (self, other, "DIA_Addon_Bromor_LuciaGold_07_01");	//Great! High time I got it back.
	Info_ClearChoices (DIA_Addon_Bromor_LuciaGold);
	if (Bromor_Hausverbot == FALSE)
	{
		Info_AddChoice (DIA_Addon_Bromor_LuciaGold, "What about a reward?", DIA_Addon_Bromor_LuciaGold_lohn);
	};
	Info_AddChoice (DIA_Addon_Bromor_LuciaGold, "Here's your dish.", DIA_Addon_Bromor_LuciaGold_einfachgeben);
	if (DIA_Addon_Bromor_LuciaGold_lucia_OneTime == FALSE)
	{
		Info_AddChoice (DIA_Addon_Bromor_LuciaGold, "Don't you want to know what became of Lucia?", DIA_Addon_Bromor_LuciaGold_lucia);
	};
};

func void DIA_Addon_Bromor_LuciaGold_einfachgeben()
{
	AI_Output (other, self, "DIA_Addon_Bromor_LuciaGold_einfachgeben_15_00");	//Here's your dish.
	B_GiveInvItems (other, self, ItMi_BromorsGeld_Addon, 1);
	AI_Output (self, other, "DIA_Addon_Bromor_LuciaGold_einfachgeben_07_01");	//Thanks. That's very generous of you. Anything else?
	MIS_Bromor_LuciaStoleGold = LOG_SUCCESS;
	Bromor_Hausverbot = FALSE;
	B_GivePlayerXP(XP_Addon_Bromor_LuciaGold);
	Info_ClearChoices(DIA_Addon_Bromor_LuciaGold);
};


var int DIA_Addon_Bromor_LuciaGold_lucia_OneTime;

func void DIA_Addon_Bromor_LuciaGold_lucia()
{
	AI_Output (other, self, "DIA_Addon_Bromor_LuciaGold_lucia_15_00");	//Don't you want to know what became of Lucia?
	AI_Output (self, other, "DIA_Addon_Bromor_LuciaGold_lucia_07_01");	//No. Why? I've got the dish back, haven't I?
	AI_Output (self, other, "DIA_Addon_Bromor_LuciaGold_lucia_07_02");	//I've managed without Lucia so far, and I will in the future. Why would I try to make her come back?
	DIA_Addon_Bromor_LuciaGold_lucia_OneTime = TRUE;
};

func void DIA_Addon_Bromor_LuciaGold_lohn()
{
	AI_Output(other,self,"DIA_Addon_Bromor_LuciaGold_lohn_15_00");	//What about a reward?
	if(!Npc_IsDead(Nadja))
	{
		AI_Output(self,other,"DIA_Addon_Bromor_LuciaGold_lohn_07_01");	//You get to have a good time with one of my girls - for free. What do you say?
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Bromor_LuciaGold_lohn_07_01_add");	//50 золотых монет. Что скажешь?@@@
	};
	Info_ClearChoices(DIA_Addon_Bromor_LuciaGold);
	if(DIA_Addon_Bromor_LuciaGold_lucia_OneTime == FALSE)
	{
		Info_AddChoice(DIA_Addon_Bromor_LuciaGold,"Don't you want to know what became of Lucia?",DIA_Addon_Bromor_LuciaGold_lucia);
	};
	Info_AddChoice(DIA_Addon_Bromor_LuciaGold,"That's not enough.",DIA_Addon_Bromor_LuciaGold_mehr);
	Info_AddChoice(DIA_Addon_Bromor_LuciaGold,"Agreed. Here's your dish.",DIA_Addon_Bromor_LuciaGold_geben);
};

func void DIA_Addon_Bromor_LuciaGold_mehr()
{
	AI_Output (other, self, "DIA_Addon_Bromor_LuciaGold_mehr_15_00");	//That's not enough.
	AI_Output (self, other, "DIA_Addon_Bromor_LuciaGold_mehr_07_01");	//Take it, or you needn't show your face around here again.
	Info_AddChoice (DIA_Addon_Bromor_LuciaGold, "Forget it.", DIA_Addon_Bromor_LuciaGold_nein);
};

func void DIA_Addon_Bromor_LuciaGold_nein()
{
	AI_Output (other, self, "DIA_Addon_Bromor_LuciaGold_nein_15_00");	//Forget it.
	AI_Output (self, other, "DIA_Addon_Bromor_LuciaGold_nein_07_01");	//Then leave my establishment right now, you bastard.
	AI_Output (self, other, "DIA_Addon_Bromor_LuciaGold_nein_07_02");	//And don't even think that you'll get served here ever again.
	Info_ClearChoices (DIA_Addon_Bromor_LuciaGold);
	Bromor_Hausverbot = TRUE;
	Bromor_Pay = 0;
};

func void DIA_Addon_Bromor_LuciaGold_geben()
{
	AI_Output(other,self,"DIA_Addon_Bromor_LuciaGold_geben_15_00");	//Agreed. Here's your dish.
	B_GiveInvItems(other,self,ItMi_BromorsGeld_Addon,1);
	if(!Npc_IsDead(Nadja))
	{
		AI_Output(self,other,"DIA_Addon_Bromor_LuciaGold_geben_07_01");	//Thanks. Go to Nadja. She'll accompany you upstairs.
		Bromor_Pay = 1;
	}
	else
	{
		CreateInvItems(self,ItMi_Gold,50);
		B_GiveInvItems(self,other,ItMi_Gold,50);
	};
	MIS_Bromor_LuciaStoleGold = LOG_SUCCESS;
	Bromor_Hausverbot = FALSE;
	B_GivePlayerXP(XP_Addon_Bromor_LuciaGold);
	Info_ClearChoices(DIA_Addon_Bromor_LuciaGold);
};

func void B_Bromor_NoServiceForYou()
{
	AI_Output(self,other,"DIA_Addon_Bromor_LuciaGold_mehr_07_01_add");	//Можешь здесь больше не показываться!
};

var int DIA_Bromor_Pay_OneTime;

instance DIA_Bromor_Pay(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 2;
	condition = DIA_Bromor_Pay_Condition;
	information = DIA_Bromor_Pay_Info;
	permanent = TRUE;
	description = "I want to have some fun (pay 50 pieces of gold).";
};


func int DIA_Bromor_Pay_Condition()
{
	if((Bromor_Pay == 0) && Npc_KnowsInfo(other,DIA_Bromor_GIRLS) && (NpcObsessedByDMT_Bromor == FALSE) && !Npc_IsDead(Nadja))
	{
		return TRUE;
	};
};

func void DIA_Bromor_Pay_Info()
{
	AI_Output(other,self,"DIA_Bromor_Pay_15_00");	//I want to have some fun.
	if(Bromor_Hausverbot == FALSE)
	{
		if(DIA_Bromor_Pay_OneTime == FALSE)
		{
			AI_Output(self,other,"DIA_Bromor_GIRLS_07_01");	//Ну да, все сюда за этим приходят.
			DIA_Bromor_Pay_OneTime = TRUE;
		};
		if(B_GiveInvItems(other,self,ItMi_Gold,50))
		{
		AI_Output (self, other, "DIA_Bromor_Pay_07_01");	//Fine. (grins) You're not likely to forget the next few hours of your life any time soon.
		AI_Output (self, other, "DIA_Bromor_Pay_07_02");	//Go upstairs with Nadja, then. Have fun.
			Bromor_Pay = 1;
		}
		else
		{
			AI_Output(self,other,"DIA_Bromor_Pay_07_03");	//I can't stand it when people try to pull my leg. Get out of here if you can't pay.
		};
	}
	else
	{
		B_Bromor_NoServiceForYou();
	};
	B_NpcClearObsessionByDMT(self);
};


instance DIA_Bromor_DOPE(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 3;
	condition = DIA_Bromor_DOPE_Condition;
	information = DIA_Bromor_DOPE_Info;
	permanent = FALSE;
	description = "Can I get 'special' goods here, too?";
};


func int DIA_Bromor_DOPE_Condition()
{
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == FALSE) && (NpcObsessedByDMT_Bromor == FALSE) && Npc_KnowsInfo(other,DIA_Bromor_GIRLS))
	{
		return TRUE;
	};
};

func void DIA_Bromor_DOPE_Info()
{
	AI_Output(other,self,"DIA_Bromor_DOPE_15_00");	//an I get 'special' goods here, too?
	if(Bromor_Hausverbot == FALSE)
	{
		if(!C_LawArmorEquipped(other) && !Npc_IsDead(Nadja))
		{
			AI_Output (self, other, "DIA_Bromor_DOPE_07_01");	//Sure, all my girls are very special. (grins)
			AI_Output (self, other, "DIA_Bromor_DOPE_07_02");	//If you have enough gold, you can go upstairs with Nadja.
		}
		else
		{
			AI_Output(self,other,"DIA_Bromor_DOPE_07_01_add");	//(уклончиво) Все мои девочки особенные...@@@
		};
	}
	else
	{
		B_Bromor_NoServiceForYou();
	};
};


instance DIA_Bromor_Obsession(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 30;
	condition = DIA_Bromor_Obsession_Condition;
	information = DIA_Bromor_Obsession_Info;
	description = "Are you all right?";
};


func int DIA_Bromor_Obsession_Condition()
{
	if((Kapitel >= 3) && (NpcObsessedByDMT_Bromor == FALSE) && (hero.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Bromor_Obsession_Info()
{
	DIA_Common_IsEverythingOk();
	B_NpcObsessedByDMT(self);
};


instance DIA_Bromor_Heilung(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 55;
	condition = DIA_Bromor_Heilung_Condition;
	information = DIA_Bromor_Heilung_Info;
	permanent = TRUE;
	description = "You're possessed!";
};


func int DIA_Bromor_Heilung_Condition()
{
	if((NpcObsessedByDMT_Bromor == TRUE) && (NpcObsessedByDMT == FALSE) && (hero.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Bromor_Heilung_Info()
{
	AI_Output (other, self, "DIA_Bromor_Heilung_15_00");	//You are possessed.
	AI_Output (self, other, "DIA_Bromor_Heilung_07_01");	//What? What are you talking about? Get out of here.
	B_NpcClearObsessionByDMT (self);
};


instance DIA_Bromor_PICKPOCKET(C_Info)
{
	npc = VLK_433_Bromor;
	nr = 900;
	condition = DIA_Bromor_PICKPOCKET_Condition;
	information = DIA_Bromor_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60_Key;
};


func int DIA_Bromor_PICKPOCKET_Condition()
{
//	return C_StealItems(50,Hlp_GetInstanceID(ItKe_Bromor),1);
	if(Npc_HasItems(self,ItKe_Bromor) && (NpcObsessedByDMT_Bromor == FALSE))
	{
		return C_StealItem(50);
	};
	return FALSE;
};

func void DIA_Bromor_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Bromor_PICKPOCKET);
	Info_AddChoice(DIA_Bromor_PICKPOCKET,Dialog_Back,DIA_Bromor_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Bromor_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Bromor_PICKPOCKET_DoIt);
};

func void DIA_Bromor_PICKPOCKET_DoIt()
{
//	B_StealItems(50,Hlp_GetInstanceID(ItKe_Bromor),1);
	B_StealItem(50,Hlp_GetInstanceID(ItKe_Bromor));
	Info_ClearChoices(DIA_Bromor_PICKPOCKET);
};

func void DIA_Bromor_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Bromor_PICKPOCKET);
};

