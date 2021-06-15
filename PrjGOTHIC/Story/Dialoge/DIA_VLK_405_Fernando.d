
instance DIA_Fernando_EXIT(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 999;
	condition = DIA_Fernando_EXIT_Condition;
	information = DIA_Fernando_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Fernando_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Fernando_EXIT_Info()
{
	B_NpcClearObsessionByDMT(self);
};


instance DIA_Fernando_PICKPOCKET(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 900;
	condition = DIA_Fernando_PICKPOCKET_Condition;
	information = DIA_Fernando_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Fernando_PICKPOCKET_Condition()
{
//	if(C_StealItems(50,Hlp_GetInstanceID(ItSe_GoldPocket100),1) && (NpcObsessedByDMT_Fernando == FALSE))
	if(Npc_HasItems(self,ItSe_GoldPocket100) && (NpcObsessedByDMT_Fernando == FALSE))
	{
		return C_StealItem(50);
	};
	return FALSE;
};

func void DIA_Fernando_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Fernando_PICKPOCKET);
	Info_AddChoice(DIA_Fernando_PICKPOCKET,Dialog_Back,DIA_Fernando_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Fernando_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Fernando_PICKPOCKET_DoIt);
};

func void DIA_Fernando_PICKPOCKET_DoIt()
{
//	B_StealItems(50,Hlp_GetInstanceID(ItSe_GoldPocket100),1);
	B_StealItem(50,Hlp_GetInstanceID(ItSe_GoldPocket100));
	Info_ClearChoices(DIA_Fernando_PICKPOCKET);
};

func void DIA_Fernando_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Fernando_PICKPOCKET);
};


instance DIA_Fernando_Hello(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 5;
	condition = DIA_Fernando_Hello_Condition;
	information = DIA_Fernando_Hello_Info;
	permanent = FALSE;
	description = "How's business?";
};


func int DIA_Fernando_Hello_Condition()
{
	if((NpcObsessedByDMT_Fernando == FALSE) && (Fernando_ImKnast == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Fernando_Hello_Info()
{
	AI_Output (other, self, "DIA_Fernando_Hello_15_00");	//How's business?
	AI_Output (self, other, "DIA_Fernando_Hello_14_01");	//Not so great. Back when the Barrier was still in place, times were better.
	AI_Output (self, other, "DIA_Fernando_Hello_14_02");	//The prisoners would scrape boxes and boxes of ore from the mines, and my ships then brought it to the mainland.
	AI_Output (self, other, "DIA_Fernando_Hello_14_03");	//And on their way back, they brought food and other wares.
	AI_Output (self, other, "DIA_Fernando_Hello_14_04");	//But now we're cut off from the mainland and have to rely on the farmers for supplies.
};


instance DIA_Fernando_Perm(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 850;
	condition = DIA_Fernando_Perm_Condition;
	information = DIA_Fernando_Perm_Info;
	permanent = TRUE;
	description = "How do you make a living now?";
};


func int DIA_Fernando_Perm_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Fernando_Hello) && (NpcObsessedByDMT_Fernando == FALSE) && (Fernando_ImKnast == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Fernando_Perm_Info()
{
	AI_Output(other,self,"DIA_Fernando_Perm_15_00");	//How do you make a living now?
	if(Fernando_HatsZugegeben == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Fernando_Perm_14_00");	//I don't know. But at any rate, no more shady dealings for me. That much is clear.
	}
	else if(!Npc_KnowsInfo(other,DIA_Fernando_Success))
	{
		AI_Output (self, other, "DIA_Fernando_Perm_14_01");	//Right now, I'm living off of my savings. But if I can't get back into business, times are going to get rough for me.
	}
	else
	{
		AI_Output (self, other, "DIA_Fernando_Perm_14_02");	//I am ruined. I should have listened to my father and kept out of this mining business.
	};
};


instance DIA_Fernando_Minental(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 2;
	condition = DIA_Fernando_Minental_Condition;
	information = DIA_Fernando_Minental_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Fernando_Minental_Condition()
{
	if((NpcObsessedByDMT_Fernando == FALSE) && (MIS_OLDWORLD == LOG_Running) && (EnterOW_Kapitel2 == FALSE) && (Fernando_Betrayal == FALSE) && (Fernando_ImKnast == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Fernando_Minental_Info()
{
	AI_Output (self, other, "DIA_Fernando_Minental_14_00");	//Hey you - wait a minute. You are headed for the Valley of Mines, aren't you?
	AI_Output (other, self, "DIA_Fernando_Minental_15_01");	//And?
	AI_Output (self, other, "DIA_Fernando_Minental_14_02");	//Here's a bargain. You give me a report of what's going on with the ore, and for that I get you ...
	if (other.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_Fernando_Minental_14_03");	//... a runestone.
	}
	else
	{
		AI_Output (self, other, "DIA_Fernando_Minental_14_04");	//... a ring that increases your life energy.
	};
	AI_Output (other, self, "DIA_Fernando_Minental_15_05");	//I'll see what I can do.
	B_NpcClearObsessionByDMT (self);
	Npc_ExchangeRoutine (self, "START");
	Log_CreateTopic (TOPIC_Fernando, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Fernando, LOG_Running);
	B_LogEntry (TOPIC_Fernando, "The merchant Fernando wants to know what's with the ore in the Valley of Mines.");
};


instance DIA_Addon_Fernando_BanditTrader(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 5;
	condition = DIA_Addon_Fernando_BanditTrader_Condition;
	information = DIA_Addon_Fernando_BanditTrader_Info;
	permanent = TRUE;
	description = "You've been selling weapons to the bandits.";
};


func int DIA_Addon_Fernando_BanditTrader_Condition()
{
	if((FernandoBlame_noPerm == FALSE) && (MIS_Vatras_FindTheBanditTrader == LOG_Running) && Npc_KnowsInfo(other,DIA_Fernando_Hello) && (NpcObsessedByDMT_Fernando == FALSE) && C_SCHasAnyFernandoEvidence() && (Fernando_ImKnast == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Fernando_BanditTrader_Info()
{
	AI_Output (other, self, "DIA_Addon_Fernando_BanditTrader_15_00");	//You've been selling weapons to the bandits.
	AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_14_01");	//(baffled) But - what makes you think THAT?
	FernandoMajorEvidenceCount = 0;
	if(Npc_HasItems(other,ItWr_Addon_BanditTrader) && (BanditTrader_Lieferung_Gelesen == TRUE))
	{
		AI_Output(other,self,"DIA_Addon_Fernando_BanditTrader_15_02");	//This list of merchandise that I took from a bandit bears YOUR signature.
		FernandoMajorEvidenceCount += 3;
	};
	if(Npc_HasItems(other,ItRi_Addon_BanditTrader))
	{
		AI_Output(other,self,"DIA_Addon_Fernando_BanditTrader_15_03");	//I found this ring of the overseas traders' guild Araxos with the bandits. You're an overseas trader.
		FernandoMajorEvidenceCount += 1;
		if(Npc_HasItems(other,ItMw_Addon_BanditTrader))
		{
			AI_Output(other,self,"DIA_Addon_Fernando_BanditTrader_15_04");	//And the swords which the bandits were carrying bore your initials.
			FernandoMajorEvidenceCount += 1;
		};
	}
	else if(Npc_HasItems(other,ItMw_Addon_BanditTrader))
	{
		AI_Output(other,self,"DIA_Addon_Fernando_BanditTrader_15_05");	//The swords which the bandits were carrying bore your initials.
		FernandoMajorEvidenceCount += 1;
	};
	if(FernandoMajorEvidenceCount < 2)
	{
		DIA_Cord_And();
		AI_Output(other,self,"DIA_Addon_Cavalorn_Banditen_15_02");	//Eh...
		if((other.guild == GIL_MIL) || (other.guild == GIL_PAL) || (other.guild == GIL_KDF))
		{
			B_Say(self,other,"$SPAREME");
		}
		else
		{
			B_Say(self,other,"$NOTNOW");
		};
		B_NpcClearObsessionByDMT(self);
	}
	else
	{
		AI_Output(other,self,"DIA_Addon_Fernando_BanditTrader_15_06");	//You can admit it now. I've blown your cover.
		B_LogEntry(TOPIC_Addon_Bandittrader,"Fernando the overseas trader admitted himself that he supplied weapons to the bandits.");
		B_GivePlayerXP(XP_Addon_Fernando_HatsZugegeben);
		FernandoBlame_noPerm = TRUE;
		Fernando_HatsZugegeben = TRUE;
		AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_14_10");	//(pleading) I didn't mean to do that, believe me.
		AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_14_11");	//(pleading) First, all they wanted from me was food supplies. Business was really slow, so I got involved with them.
		AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_14_12");	//(pleading) Then they became more aggressive and threatened to kill me if I didn't sell them the swords they wanted.
		AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_14_13");	//(pleading) You can't blame me for this. I am a victim of circumstances.
		Info_ClearChoices(DIA_Addon_Fernando_BanditTrader);
			Info_AddChoice (DIA_Addon_Fernando_BanditTrader, "What will you pay me if I let you go?", DIA_Addon_Fernando_BanditTrader_preis);
			Info_AddChoice (DIA_Addon_Fernando_BanditTrader, "The militia is going to deal with you.", DIA_Addon_Fernando_BanditTrader_mil);
			Info_AddChoice (DIA_Addon_Fernando_BanditTrader, "I'm shaking, I'm shaking.", DIA_Addon_Fernando_BanditTrader_Uptown);
	};
};

func void DIA_Addon_Fernando_BanditTrader_Uptown()
{
	AI_Output (other, self, "DIA_Addon_Fernando_BanditTrader_Uptown_15_00");	//Don't make me weep. You're pretty repulsive for someone who lives in the upper quarter.
	AI_Output (other, self, "DIA_Addon_Fernando_BanditTrader_Uptown_15_01");	//You'd sell your soul for a fistful of gold pieces.
	AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_Uptown_14_02");	//I've got my expenses to cover. If I'm not liquid, they're going to feed me to the mob from the harbor district.
};

func void DIA_Addon_Fernando_BanditTrader_mil()
{
	AI_Output (other, self, "DIA_Addon_Fernando_BanditTrader_mil_15_00");	//The militia is going to deal with you.
	AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_mil_14_01");	//You can't do this.
	AI_Output (other, self, "DIA_Addon_Fernando_BanditTrader_mil_15_02");	//I should say I can. You'll be amazed.
	AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_mil_14_03");	//By Innos. I'm ruined.
	Fernando_Betrayal = TRUE;
	B_NpcClearObsessionByDMT(self);
};

func void DIA_Addon_Fernando_BanditTrader_preis()
{
	AI_Output (other, self, "DIA_Addon_Fernando_BanditTrader_preis_15_00");	//What will you pay me if I let you go?
	AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_preis_14_01");	//You know I'm not doing too well. I can't give you much.
	AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_preis_14_02");	//I'll give you 200 gold coins and a valuable ring.
	AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_preis_14_03");	//That will have to do. Will you give me the incriminating material now?
	Info_ClearChoices (DIA_Addon_Fernando_BanditTrader);
	Info_AddChoice (DIA_Addon_Fernando_BanditTrader, "Forget it. I'm not going to give that away.", DIA_Addon_Fernando_BanditTrader_nein);
	Info_AddChoice (DIA_Addon_Fernando_BanditTrader, "Well, all right. Agreed.", DIA_Addon_Fernando_BanditTrader_ja);
};

func void DIA_Addon_Fernando_BanditTrader_ja()
{
	AI_Output(other,self,"DIA_Addon_Fernando_BanditTrader_ja_15_00");	//Well, all right. Agreed.
	B_GivePlayerXP(XP_Ambient);
	FernandoMajorEvidenceCount = 0;
	if(Npc_HasItems(other,ItMw_Addon_BanditTrader))
	{
		Npc_RemoveInvItems(other,ItMw_Addon_BanditTrader,Npc_HasItems(other,ItMw_Addon_BanditTrader));
	};
	if(Npc_HasItems(other,ItRi_Addon_BanditTrader))
	{
		Npc_RemoveInvItem(other,ItRi_Addon_BanditTrader);
		FernandoMajorEvidenceCount += 1;
	};
	if(Npc_HasItems(other,ItWr_Addon_BanditTrader))
	{
		Npc_RemoveInvItem(other,ItWr_Addon_BanditTrader);
		FernandoMajorEvidenceCount += 1;
	};
	AI_PrintScreen(PRINT_Addon_EvidenceGiven,-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	AI_Output(self,other,"DIA_Addon_Fernando_BanditTrader_ja_14_01");	//Fine, here's your gold.
	CreateInvItems(self,ItMi_Gold,200);
	B_GiveInvItems(self,other,ItMi_Gold,200);
	AI_Output(self,other,"DIA_Addon_Fernando_BanditTrader_ja_14_02");	//And the ring. We're even now.
	if(FernandoMajorEvidenceCount < 2)
	{
		CreateInvItems(self,ItRi_Prot_Point_01,1);
		B_GiveInvItems(self,other,ItRi_Prot_Point_01,1);
	}
	else
	{
		CreateInvItems(self,ItRi_Prot_Total_00,1);
		B_GiveInvItems(self,other,ItRi_Prot_Total_00,1);
		MIS_Martin_FindTheBanditTrader = LOG_FAILED;
		MIS_Vatras_FindTheBanditTrader = LOG_FAILED;
		B_LogEntry(TOPIC_Addon_Bandittrader,"I decided not to give up Fernando to the militia, I gave up the evidence against him.");
		B_CheckLog();
	};
	Info_ClearChoices(DIA_Addon_Fernando_BanditTrader);
};

func void DIA_Addon_Fernando_BanditTrader_nein()
{
	AI_Output (other, self, "DIA_Addon_Fernando_BanditTrader_nein_15_00");	//No. I think I'd rather keep it.
	AI_Output (self, other, "DIA_Addon_Fernando_BanditTrader_nein_14_01");	//Fine. Keep it then, but woe betide you if you rat on me.
	Fernando_Betrayal = TRUE;
	Info_ClearChoices(DIA_Addon_Fernando_BanditTrader);
};


instance DIA_Fernando_Success(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 5;
	condition = DIA_Fernando_Success_Condition;
	information = DIA_Fernando_Success_Info;
	permanent = FALSE;
	description = "I've been to the Valley of Mines.";
};


func int DIA_Fernando_Success_Condition()
{
	if((Kapitel >= 3) && Npc_KnowsInfo(other,DIA_Fernando_Minental))
	{
		return TRUE;
	};
};

func void DIA_Fernando_Success_Info()
{
	AI_Output(other,self,"DIA_Fernando_Success_15_00");	//I've been to the Valley of Mines.
	if((Fernando_ImKnast == FALSE) && (NpcObsessedByDMT_Fernando == FALSE))
	{
		Fernando_Erz = TRUE;
		B_GivePlayerXP(XP_Ambient);
		AI_Output (self, other, "DIA_Fernando_Success_14_01");	//And? How is the situation there?
		AI_Output (other, self, "DIA_Fernando_Success_15_02");	//The mines are all depleted, there's barely more than a few chests full of ore. It's hardly worth digging for that.
		AI_Output (self, other, "DIA_Fernando_Success_14_03");	//That can't be true! That means I'm ruined...
		AI_Output(other,self,"DIA_Fernando_Success_15_04");	//What about our deal?
		if(Fernando_Betrayal == FALSE)
		{
			AI_Output(self,other,"DIA_Fernando_Success_14_05");	//Now, about your reward...
			if(other.guild == GIL_KDF)
			{
				AI_Output (self, other, "DIA_Fernando_Minental_14_06");	//Here, take this runestone.
				B_GiveInvItems (self, other, ItMi_RuneBlank, 1);
			}
			else
			{
				AI_Output (self, other, "DIA_Fernando_Minental_14_07");	//Here's your ring.
				B_GiveInvItems (self, other, ItRi_Hp_02, 1);
			};
		}
		else
		{
			B_Say(self,other,"$NOTNOW");
			AI_StopProcessInfos(self);
		};
	}
	else
	{
		B_Say(self,other,"$NOTNOW");
		Log_SetTopicStatus(TOPIC_Fernando,LOG_FAILED);
		B_LogEntry(TOPIC_Fernando,"Fernando no longer wants the information. And I'm not going to get paid, either.");
	};
};


var int Fernando_ThreatFromPrison;

instance DIA_Fernando_Prison(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 3;
	condition = DIA_Fernando_Prison_Condition;
	information = DIA_Fernando_Prison_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Fernando_Prison_Condition()
{
	if((Fernando_ImKnast == TRUE) && Npc_IsInState(self,ZS_Talk) && (NpcObsessedByDMT_Fernando == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Fernando_Prison_Info()
{
	if(Fernando_ThreatFromPrison == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Fernando_BanditTrader_14_07");	//So YOU did this. YOU'RE the one who gave me away. I'm going to make you pay for this.
		AI_Output(other,self,"DIA_Addon_Fernando_BanditTrader_15_08");	//You'd first have to get out of here, and I hardly think they're going to let you go any time soon.
		Fernando_ThreatFromPrison = TRUE;
	};
	AI_Output(self,other,"DIA_Addon_Fernando_BanditTrader_14_09");	//(angrily, to himself) My time will come.
	B_NpcClearObsessionByDMT(self);
};


instance DIA_Fernando_Obsession(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 30;
	condition = DIA_Fernando_Obsession_Condition;
	information = DIA_Fernando_Obsession_Info;
	description = "Are you all right?";
};


func int DIA_Fernando_Obsession_Condition()
{
	if((Kapitel >= 3) && (NpcObsessedByDMT_Fernando == FALSE) && (hero.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Fernando_Obsession_Info()
{
	DIA_Common_IsEverythingOk();
	B_NpcObsessedByDMT(self);
};


instance DIA_Fernando_Heilung(C_Info)
{
	npc = VLK_405_Fernando;
	nr = 55;
	condition = DIA_Fernando_Heilung_Condition;
	information = DIA_Fernando_Heilung_Info;
	permanent = TRUE;
	description = "You're possessed!";
};


func int DIA_Fernando_Heilung_Condition()
{
	if((NpcObsessedByDMT_Fernando == TRUE) && (NpcObsessedByDMT == FALSE) && (hero.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Fernando_Heilung_Info()
{
	AI_Output (other, self, "DIA_Fernando_Heilung_15_00");	//You're possessed!
	AI_Output (self, other, "DIA_Fernando_Heilung_14_01");	//Go away. Go already.
	B_NpcClearObsessionByDMT (self);
};

