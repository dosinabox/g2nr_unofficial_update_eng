
instance DIA_Thorben_EXIT(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 999;
	condition = DIA_Thorben_EXIT_Condition;
	information = DIA_Thorben_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Thorben_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Thorben_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Thorben_PICKPOCKET(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 900;
	condition = DIA_Thorben_PICKPOCKET_Condition;
	information = DIA_Thorben_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Thorben_PICKPOCKET_Condition()
{
	return C_Beklauen(30,28);
};

func void DIA_Thorben_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Thorben_PICKPOCKET);
	Info_AddChoice(DIA_Thorben_PICKPOCKET,Dialog_Back,DIA_Thorben_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Thorben_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Thorben_PICKPOCKET_DoIt);
};

func void DIA_Thorben_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Thorben_PICKPOCKET);
};

func void DIA_Thorben_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Thorben_PICKPOCKET);
};


instance DIA_Thorben_angepisst(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 1;
	condition = DIA_Thorben_angepisst_Condition;
	information = DIA_Thorben_angepisst_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Thorben_angepisst_Condition()
{
	if(Npc_IsDead(Gritta) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Thorben_angepisst_Info()
{
	AI_Output (self, other, "DIA_Thorben_angepisst_06_00");	//You have murdered my Gritta. I shall never forgive you. Out of my sight, you murderer!
	AI_StopProcessInfos (self);
};


instance DIA_Thorben_Hallo(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 2;
	condition = DIA_Thorben_Hallo_Condition;
	information = DIA_Thorben_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Thorben_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE) && (other.guild == GIL_NONE) && !Npc_IsDead(Gritta))
	{
		return TRUE;
	};
};

func void DIA_Thorben_Hallo_Info()
{
	AI_Output (self, other, "DIA_Thorben_Hallo_06_00");	//Ah! A fresh face. You're not from Khorinis, are you?
	AI_Output (self, other, "DIA_Thorben_Hallo_06_01");	//This is not a good time for travelers. Bandits everywhere, no work, and now the farmers have risen up, too.
	AI_Output (self, other, "DIA_Thorben_Hallo_06_02");	//What winds have blown you here?
};


instance DIA_Thorben_Arbeit(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 2;
	condition = DIA_Thorben_Arbeit_Condition;
	information = DIA_Thorben_Arbeit_Info;
	permanent = FALSE;
	description = "I'm looking for work.";
};


func int DIA_Thorben_Arbeit_Condition()
{
	return TRUE;
};

func void DIA_Thorben_Arbeit_Info()
{
	AI_Output (other, self, "DIA_Thorben_Arbeit_15_00");	//I'm looking for work.
	AI_Output (self, other, "DIA_Thorben_Arbeit_06_01");	//Do you know anything about carpentry?
	AI_Output (other, self, "DIA_Thorben_Arbeit_15_02");	//The only thing I can make out of wood is a fire.
	AI_Output (self, other, "DIA_Thorben_Arbeit_06_03");	//And what about locks?
	AI_Output (other, self, "DIA_Thorben_Arbeit_15_04");	//Weeell ...
	AI_Output (self, other, "DIA_Thorben_Arbeit_06_05");	//I'm sorry, but I can't use you if you know nothing about my trade.
	AI_Output (self, other, "DIA_Thorben_Arbeit_06_06");	//And I have no money to pay for an apprentice.
	if(Player_IsApprentice == APP_NONE)
	{
		Log_CreateTopic(TOPIC_Lehrling,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Lehrling,LOG_Running);
		B_LogEntry(TOPIC_Lehrling,"Thorben won't have me as his apprentice.");
	};
};


instance DIA_Thorben_OtherMasters(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 2;
	condition = DIA_Thorben_OtherMasters_Condition;
	information = DIA_Thorben_OtherMasters_Info;
	permanent = FALSE;
	description = "What if I want to start an apprenticeship with one of the other masters here?";
};


func int DIA_Thorben_OtherMasters_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Thorben_Arbeit) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Thorben_OtherMasters_Info()
{
	AI_Output (other, self, "DIA_Thorben_OtherMasters_15_00");	//What if I want to start an apprenticeship with one of the other masters here?
	AI_Output (self, other, "DIA_Thorben_OtherMasters_06_01");	//All right, I shall give you my approval.
	AI_Output (self, other, "DIA_Thorben_OtherMasters_06_02");	//But you had better get yourself the blessing of the gods first.
	AI_Output (self, other, "DIA_Thorben_OtherMasters_06_03");	//Say, are you a man of faith?
	Info_ClearChoices (DIA_Thorben_OtherMasters);
	if ((other.guild != GIL_KDF) && (other.guild != GIL_NOV) && (other.guild != GIL_PAL))
	{
		Info_AddChoice (DIA_Thorben_OtherMasters, "Well, if you mean, do I say my prayers regularly ...", DIA_Thorben_OtherMasters_Naja);
	};
	Info_AddChoice (DIA_Thorben_OtherMasters, "Yes. A most humble servant, Master Thorben.", DIA_Thorben_OtherMasters_Devoutly);
};

func void B_Thorben_GetBlessings()
{
	AI_Output (self, other, "B_Thorben_GetBlessings_06_00");	//Then go to Vatras, the priest of Adanos, and have him give you his blessing.
	if ((other.guild != GIL_KDF) && (other.guild != GIL_NOV) && (other.guild != GIL_PAL))
	{
		AI_Output (self, other, "B_Thorben_GetBlessings_06_01");	//He will tell you where you can find a priest of Innos. You should get his blessing, too.
	};
	AI_Output (self, other, "B_Thorben_GetBlessings_06_02");	//Once you have received the blessing of the gods, I shall vote for you.
	MIS_Thorben_GetBlessings = LOG_Running;
	Log_CreateTopic (TOPIC_Thorben, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Thorben, LOG_Running);
	B_LogEntry (TOPIC_Thorben, "Thorben will give his approval, if a priest of Adanos and a priest of Innos give me their blessing.");
};

func void DIA_Thorben_OtherMasters_Devoutly()
{
	AI_Output (other, self, "DIA_Thorben_OtherMasters_Devoutly_15_00");	//Yes. A most humble servant, Master Thorben.
	B_Thorben_GetBlessings ();
	Info_ClearChoices (DIA_Thorben_OtherMasters);
};

func void DIA_Thorben_OtherMasters_Naja()
{
	AI_Output (other, self, "DIA_Thorben_OtherMasters_Naja_15_00");	//Well, if you mean, do I say my prayers regularly ...
	AI_Output (self, other, "DIA_Thorben_OtherMasters_Naja_06_01");	//I see!
	AI_Output (self, other, "DIA_Thorben_OtherMasters_Naja_06_02");	//A man who does not ply his trade with the blessing of the gods will never receive my approval.
	AI_Output (self, other, "DIA_Thorben_OtherMasters_Naja_06_03");	//Ask the gods for forgiveness for your transgressions.
	B_Thorben_GetBlessings ();
	Info_ClearChoices (DIA_Thorben_OtherMasters);
};


instance DIA_Thorben_ZUSTIMMUNG(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 1;
	condition = DIA_Thorben_ZUSTIMMUNG_Condition;
	information = DIA_Thorben_ZUSTIMMUNG_Info;
	permanent = TRUE;
	description = "How about your approval, Master?";
};


func int DIA_Thorben_ZUSTIMMUNG_Condition()
{
	if((Player_IsApprentice == APP_NONE) && (MIS_Thorben_GetBlessings == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Thorben_ZUSTIMMUNG_Info()
{
	AI_Output (other, self, "DIA_Thorben_ZUSTIMMUNG_15_00");	//How about your approval, Master?
	AI_Output (self, other, "DIA_Thorben_ZUSTIMMUNG_06_01");	//Has Vatras given you his blessing?
	if(Vatras_Blessing == TRUE)
	{
		AI_Output (other, self, "DIA_Thorben_ZUSTIMMUNG_15_02");	//Yes.
		AI_Output (self, other, "DIA_Thorben_ZUSTIMMUNG_06_03");	//And did you also get the blessing of a priest of Innos?
		if((GotInnosBlessingForThorben == TRUE) || (other.guild == GIL_KDF))
		{
			AI_Output (other, self, "DIA_Thorben_ZUSTIMMUNG_15_04");	//Yes, I did.
			AI_Output (self, other, "DIA_Thorben_ZUSTIMMUNG_06_05");	//Then you shall have my blessing as well. No matter what path you decide to take - take pride in doing a good job, my boy!
			MIS_Thorben_GetBlessings = LOG_SUCCESS;
			B_GivePlayerXP (XP_Zustimmung);
			Log_CreateTopic (TOPIC_Lehrling, LOG_MISSION);
			Log_SetTopicStatus (TOPIC_Lehrling, LOG_Running);
			B_LogEntry (TOPIC_Lehrling, "Thorben will give his approval if I want to start work as an apprentice.");
		}
		else
		{
			DIA_Common_NoNotYet();
			AI_Output(self,other,"DIA_Thorben_ZUSTIMMUNG_06_07");	//You know my terms. You should only ply your trade with the blessing of the gods.
		};
	}
	else
	{
		AI_Output (other, self, "DIA_Thorben_ZUSTIMMUNG_15_08");	//Not yet ...
		AI_Output (self, other, "DIA_Thorben_ZUSTIMMUNG_06_09");	//Then I don't know why you're asking me again. You know my terms.
	};
};


instance DIA_Thorben_Locksmith(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 2;
	condition = DIA_Thorben_Locksmith_Condition;
	information = DIA_Thorben_Locksmith_Info;
	permanent = FALSE;
	description = "So you know a lot about locks?";
};


func int DIA_Thorben_Locksmith_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Thorben_Arbeit))
	{
		return TRUE;
	};
};

func void DIA_Thorben_Locksmith_Info()
{
	AI_Output (other, self, "DIA_Thorben_Locksmith_15_00");	//So you know a lot about locks?
	AI_Output (self, other, "DIA_Thorben_Locksmith_06_01");	//What good is a fine chest without a fine lock?
	AI_Output (self, other, "DIA_Thorben_Locksmith_06_02");	//I make my own locks. That way, I can at least be sure that I haven't built my chests that sturdy for nothing.
	AI_Output (self, other, "DIA_Thorben_Locksmith_06_03");	//A poorly made lock is easy to break. And there are plenty of thieves about in Khorinis. Especially lately!
};


instance DIA_Thorben_Schuldenbuch(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 2;
	condition = DIA_Thorben_Schuldenbuch_Condition;
	information = DIA_Thorben_Schuldenbuch_Info;
	permanent = FALSE;
	description = "I've got Lehmar's ledger right here ...";
};


func int DIA_Thorben_Schuldenbuch_Condition()
{
	if(Npc_HasItems(other,ItWr_Schuldenbuch) && ((SchuldBuchNamesKnown == TRUE) || Npc_KnowsInfo(other,DIA_Thorben_Gritta)))
	{
		return TRUE;
	};
};

func void DIA_Thorben_Schuldenbuch_Info()
{
	AI_Output (other, self, "DIA_Thorben_Schuldenbuch_15_00");	//I've got Lehmar's ledger right here ...
	AI_Output (self, other, "DIA_Thorben_Schuldenbuch_06_01");	//(suspiciously) Where did you get that?
	AI_Output (other, self, "DIA_Thorben_Schuldenbuch_15_02");	//That shouldn't interest you so much as the fact that your name is in it.
	AI_Output (self, other, "DIA_Thorben_Schuldenbuch_06_03");	//Give it to me!
//	B_GiveInvItems(other,self,ItWr_Schuldenbuch,1);
	AI_Output(other,self,"DIA_Thorben_Schuldenbuch_15_04");	//What will you give me, then?
	AI_Output(self,other,"DIA_Thorben_Schuldenbuch_06_05");	//I have no money to spare and can give you nothing but my heartfelt gratitude.
//	B_GivePlayerXP(XP_Schuldenbuch);
};


instance DIA_Thorben_GiveBook(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 2;
	condition = DIA_Thorben_GiveBook_Condition;
	information = DIA_Thorben_GiveBook_Info;
	permanent = FALSE;
	description = "Can you teach me how to pick locks?";
};


func int DIA_Thorben_GiveBook_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Thorben_Schuldenbuch) && Npc_HasItems(other,ItWr_Schuldenbuch))
	{
		return TRUE;
	};
};

func void DIA_Thorben_GiveBook_Info()
{
	DIA_Common_HereIsYourBook();
	if(ClassicLehmarBook == FALSE)
	{
		AI_PrintScreen("Given: Book of Debts",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
		Npc_RemoveInvItem(other,ItWr_Schuldenbuch);
	}
	else
	{
		B_GiveInvItems(other,self,ItWr_Schuldenbuch,1);
	};
	if(Thorben_TeachPlayer == TRUE)
	{
		AI_Output(self,other,"DIA_Thorben_PleaseTeach_06_01");	//If it weren't for you, I'd be paying Lehmar for the rest of my life.
	}
	else
	{
		B_Say(self,other,"$ABS_GOOD");
	};
	B_GivePlayerXP(XP_Schuldenbuch);
};

instance DIA_Thorben_PleaseTeach(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 2;
	condition = DIA_Thorben_PleaseTeach_Condition;
	information = DIA_Thorben_PleaseTeach_Info;
	permanent = TRUE;
	description = "Can you teach me how to pick locks?";
};


func int DIA_Thorben_PleaseTeach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Thorben_Locksmith) && (Thorben_TeachPlayer == FALSE) && !Npc_GetTalentSkill(other,NPC_TALENT_PICKLOCK))
	{
		return TRUE;
	};
};

func void DIA_Thorben_PleaseTeach_Info()
{
	AI_Output(other,self,"DIA_Thorben_PleaseTeach_15_00");	//Can you teach me how to pick locks?
	if(Npc_KnowsInfo(other,DIA_Thorben_GiveBook) || Npc_KnowsInfo(other,DIA_Addon_Thorben_ElvrichIsBack))
	{
		if(Npc_KnowsInfo(other,DIA_Thorben_GiveBook))
		{
			AI_Output(self,other,"DIA_Thorben_PleaseTeach_06_01");	//If it weren't for you, I'd be paying Lehmar for the rest of my life.
		};
		AI_Output(self,other,"DIA_Thorben_PleaseTeach_06_02");	//I shall teach you what you want to know.
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Thorben can teach me how to use lockpicks.");
		Thorben_TeachPlayer = TRUE;
	}
	else if(Thorben_GotGold == TRUE)
	{
		AI_Output (self, other, "DIA_Thorben_PleaseTeach_06_03");	//You have brought me the 100 gold pieces. That was very decent of you.
		AI_Output (self, other, "DIA_Thorben_PleaseTeach_06_04");	//I am almost embarrassed, but I must ask even more of you.
		AI_Output (self, other, "DIA_Thorben_PleaseTeach_06_05");	//If I cannot pay back my debt to Lehmar soon, he's going to send his thugs after me.
		AI_Output (self, other, "DIA_Thorben_PleaseTeach_06_06");	//Give me another 100 gold pieces, and I shall instruct you.
		Info_ClearChoices (DIA_Thorben_PleaseTeach);
		Info_AddChoice (DIA_Thorben_PleaseTeach, "Maybe later...", DIA_Thorben_PleaseTeach_Later);
		Info_AddChoice (DIA_Thorben_PleaseTeach, "Fine. Here are 100 gold pieces.", DIA_Thorben_PleaseTeach_Pay100);
	}
	else if((MIS_Matteo_Gold == LOG_SUCCESS) && ((Gritta_GoldGiven == TRUE) || ((Gritta_WantPay == TRUE) && (Npc_HasItems(Gritta,ItMi_Gold) >= 80))) && (Gritta.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE))
	{
		AI_Output (self, other, "DIA_Thorben_PleaseTeach_06_07");	//You have paid Gritta's debt with Matteo. You seem to be a decent fellow. I shall teach you what you want to know.
		AI_Output (self, other, "DIA_Thorben_PleaseTeach_06_08");	//However, I cannot do it for free. I still have a mountain of debts, and I need the money.
		AI_Output (other, self, "DIA_Thorben_PleaseTeach_15_09");	//How much do you charge?
		AI_Output (self, other, "DIA_Thorben_PleaseTeach_06_10");	//200 gold pieces.
		Info_ClearChoices (DIA_Thorben_PleaseTeach);
		Info_AddChoice (DIA_Thorben_PleaseTeach, "Maybe later...", DIA_Thorben_PleaseTeach_Later);
		Info_AddChoice (DIA_Thorben_PleaseTeach, "Fine. Here are 200 gold pieces.", DIA_Thorben_PleaseTeach_Pay200);
	}
	else
	{
		AI_Output(self,other,"DIA_Thorben_PleaseTeach_06_11");	//Hmm ... I don't know whether you can be trusted or not.
		if((other.guild != GIL_KDF) && (other.guild != GIL_MIL) && (other.guild != GIL_PAL))
		{
			AI_Output(self,other,"DIA_Thorben_PleaseTeach_06_12");	//For all I know, you might be one of those layabouts who only come to town to empty the chests of honest people.
		};
		AI_Output(self,other,"DIA_Thorben_PleaseTeach_06_13");	//I'm not going to teach you anything before I'm convinced that you are an honest fellow.
	};
};

func void DIA_Thorben_PleaseTeach_Pay200()
{
	AI_Output (other, self, "DIA_Thorben_PleaseTeach_Pay200_15_00");	//Fine. Here are 200 gold pieces.
	if (B_GiveInvItems (other, self, ItMi_Gold, 200))
	{
		AI_Output(self,other,"DIA_Thorben_PleaseTeach_Pay200_06_01");	//This money will really help me. We can start as soon as you're ready.
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Thorben can teach me how to use lockpicks.");
		Thorben_TeachPlayer = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Thorben_PleaseTeach_Pay200_06_02");	//You're still a few coins short of 200. I need that money.
	};
	Info_ClearChoices(DIA_Thorben_PleaseTeach);
};

func void DIA_Thorben_PleaseTeach_Pay100()
{
	AI_Output (other, self, "DIA_Thorben_PleaseTeach_Pay100_15_00");	//Fine. Here are 100 gold pieces.
	if (B_GiveInvItems (other, self, ItMi_Gold, 100))
	{
		AI_Output(self,other,"DIA_Thorben_PleaseTeach_Pay100_06_01");	//In that case, we can start whenever you're ready.
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Thorben can teach me how to use lockpicks.");
		Thorben_TeachPlayer = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Thorben_PleaseTeach_Pay100_06_02");	//Hey, you're still a few coins short of 100.
	};
	Info_ClearChoices(DIA_Thorben_PleaseTeach);
};

func void DIA_Thorben_PleaseTeach_Later()
{
	DIA_Common_MaybeLater();
	Info_ClearChoices(DIA_Thorben_PleaseTeach);
};


instance DIA_Thorben_Teach(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 2;
	condition = DIA_Thorben_Teach_Condition;
	information = DIA_Thorben_Teach_Info;
	permanent = TRUE;
	description = B_BuildLearnString(NAME_Skill_PickLock,B_GetLearnCostTalent(other,NPC_TALENT_PICKLOCK,1));
};


func int DIA_Thorben_Teach_Condition()
{
	if((Thorben_TeachPlayer == TRUE) && !Npc_GetTalentSkill(other,NPC_TALENT_PICKLOCK))
	{
		return TRUE;
	};
};

func void DIA_Thorben_Teach_Info()
{
	AI_Output (other, self, "DIA_Thorben_Teach_15_00");	//Teach me how to pick a lock!
	if (B_TeachThiefTalent (self, other, NPC_TALENT_PICKLOCK))
	{
		AI_Output (self, other, "DIA_Thorben_Teach_06_01");	//All you need is a lock pick. If you move it carefully left and right in the lock, you can unbolt the mechanism.
		AI_Output (self, other, "DIA_Thorben_Teach_06_02");	//But if you move it too much or too fast in the wrong direction, it will snap right off.
		AI_Output (self, other, "DIA_Thorben_Teach_06_03");	//The more adept you become, the fewer lock picks you are going to need. That's all there is to it, really.
	};
};


var int Thorben_TradeLog;

instance DIA_Thorben_TRADE(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 3;
	condition = DIA_Thorben_TRADE_Condition;
	information = DIA_Thorben_TRADE_Info;
	permanent = TRUE;
	description = "Can you sell me some lock picks?";
	trade = TRUE;
};


func int DIA_Thorben_TRADE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Thorben_Locksmith))
	{
		return TRUE;
	};
};

func void DIA_Thorben_TRADE_Info()
{
	AI_Output(other,self,"DIA_Thorben_TRADE_15_00");	//Can you sell me some lock picks?
	B_GiveTradeInv(self);
	if(Npc_GetTalentSkill(other,NPC_TALENT_PICKLOCK))
	{
		AI_Output (self, other, "DIA_Thorben_TRADE_06_01");	//If I have any left...
	}
	else
	{
		AI_Output (self, other, "DIA_Thorben_TRADE_06_02");	//Well, all right. But they won't be of any use to you as long as you don't know how they work.
	};
	if(!Npc_HasItems(self,ItKe_Lockpick) && (Kapitel > Dietrichgeben))
	{
		CreateInvItems(self,ItKe_Lockpick,5);
		Dietrichgeben += 1;
	};
	if(Thorben_TradeLog == FALSE)
	{
		Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
		B_LogEntry(TOPIC_CityTrader,"The carpenter Thorben sells lockpicks.");
		Thorben_TradeLog = TRUE;
	};
	Trade_IsActive = TRUE;
};


instance DIA_Addon_Thorben_MissingPeople(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 4;
	condition = DIA_Addon_Thorben_MissingPeople_Condition;
	information = DIA_Addon_Thorben_MissingPeople_Info;
	description = "Have you had an apprentice before?";
};


func int DIA_Addon_Thorben_MissingPeople_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Thorben_Arbeit) && (SC_HearedAboutMissingPeople == TRUE) && (Elvrich_GoesBack2Thorben == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorben_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Thorben_MissingPeople_15_00");	//Have you had an apprentice before?
	AI_Output (self, other, "DIA_Addon_Thorben_MissingPeople_06_01");	//Yes, and not too long ago.
	AI_Output (other, self, "DIA_Addon_Thorben_MissingPeople_15_02");	//And? What happened?
	AI_Output (self, other, "DIA_Addon_Thorben_MissingPeople_06_03");	//His name is Elvrich. He's my nephew.
	AI_Output (self, other, "DIA_Addon_Thorben_MissingPeople_06_04");	//I was quite pleased with him, actually, but one day he simply didn't show up for work.
	MIS_Thorben_BringElvrichBack = LOG_Running;
	if(MissingPeopleReturnedHome == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
	};
	B_LogEntry(TOPIC_Addon_MissingPeople,"Elvrich, the apprentice to Thorben the carpenter, has vanished.");
	Info_ClearChoices(DIA_Addon_Thorben_MissingPeople);
	Info_AddChoice(DIA_Addon_Thorben_MissingPeople,Dialog_Back,DIA_Addon_Thorben_MissingPeople_Back);
	Info_AddChoice(DIA_Addon_Thorben_MissingPeople,"Have you reported that to the militia?",DIA_Addon_Thorben_MissingPeople_Mil);
	Info_AddChoice(DIA_Addon_Thorben_MissingPeople,"How long has it been since you saw him?",DIA_Addon_Thorben_MissingPeople_wann);
	Info_AddChoice(DIA_Addon_Thorben_MissingPeople,"Where is Elvrich now?",DIA_Addon_Thorben_MissingPeople_where);
};

func void DIA_Addon_Thorben_MissingPeople_Back()
{
	Info_ClearChoices(DIA_Addon_Thorben_MissingPeople);
};

func void DIA_Addon_Thorben_MissingPeople_wann()
{
	AI_Output (other, self, "DIA_Addon_Thorben_MissingPeople_wann_15_00");	//How long has it been since you saw him?
	AI_Output (self, other, "DIA_Addon_Thorben_MissingPeople_wann_06_01");	//I guess it must be about 2 weeks.
};

func void DIA_Addon_Thorben_MissingPeople_where()
{
	AI_Output (other, self, "DIA_Addon_Thorben_MissingPeople_where_15_00");	//Where is Elvrich now?
	AI_Output (self, other, "DIA_Addon_Thorben_MissingPeople_where_06_01");	//How would I know? He kept hanging around that filthy brothel by the harbor.
	AI_Output (self, other, "DIA_Addon_Thorben_MissingPeople_where_06_02");	//I wouldn't be surprised if he's still warming the bed of some whore down there.
};

func void DIA_Addon_Thorben_MissingPeople_Mil()
{
	AI_Output (other, self, "DIA_Addon_Thorben_MissingPeople_Mil_15_00");	//Have you reported that to the militia?
	AI_Output (self, other, "DIA_Addon_Thorben_MissingPeople_Mil_06_01");	//Of course I have. They were supposed to catch him and see to it that the lazy-bones does his work. But I already regret that.
	AI_Output (self, other, "DIA_Addon_Thorben_MissingPeople_Mil_06_02");	//He can do whatever he wants. Sooner or later he'll realize that he'll get nowhere in Khorinis without a decent job.
	AI_Output (other, self, "DIA_Addon_Thorben_MissingPeople_Mil_15_03");	//(cynically) Is that so?
};


instance DIA_Addon_Thorben_ElvrichIsBack(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 5;
	condition = DIA_Addon_Thorben_ElvrichIsBack_Condition;
	information = DIA_Addon_Thorben_ElvrichIsBack_Info;
	description = "Elvrich will work for you again from now on.";
};


func int DIA_Addon_Thorben_ElvrichIsBack_Condition()
{
	if((Elvrich_GoesBack2Thorben == TRUE) && !Npc_IsDead(Elvrich))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorben_ElvrichIsBack_Info()
{
	AI_Output (other, self, "DIA_Addon_Thorben_ElvrichIsBack_15_00");	//Elvrich will work for you again from now on.
	AI_Output (self, other, "DIA_Addon_Thorben_ElvrichIsBack_06_01");	//I can only hope that he won't disappear again when the next little tart waves her skirts at him.
	AI_Output (self, other, "DIA_Addon_Thorben_ElvrichIsBack_06_02");	//Take this gold as a reward for bringing back my apprentice.
	CreateInvItems (self, ItMi_Gold, 200);
	B_GiveInvItems (self, other, ItMi_Gold, 200);
	MIS_Thorben_BringElvrichBack = LOG_SUCCESS;
	Elvrich.flags = 0;
	Elvrich.aivar[AIV_ToughGuy] = FALSE;
};


instance DIA_Thorben_Paladine(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 4;
	condition = DIA_Thorben_Paladine_Condition;
	information = DIA_Thorben_Paladine_Info;
	permanent = FALSE;
	description = "What do you know about the paladins?";
};


func int DIA_Thorben_Paladine_Condition()
{
	if(other.guild != GIL_PAL)
	{
		return TRUE;
	};
};

func void DIA_Thorben_Paladine_Info()
{
	AI_Output (other, self, "DIA_Thorben_Paladine_15_00");	//What do you know about the paladins?
	AI_Output (self, other, "DIA_Thorben_Paladine_06_01");	//Not much. They arrived by ship two weeks ago from the mainland.
	AI_Output (self, other, "DIA_Thorben_Paladine_06_02");	//Since then, they have withdrawn to the upper end of town.
	AI_Output (self, other, "DIA_Thorben_Paladine_06_03");	//Nobody here really knows exactly why they have come.
	AI_Output (self, other, "DIA_Thorben_Paladine_06_04");	//Many are afraid of an attack by the orcs.
	AI_Output (self, other, "DIA_Thorben_Paladine_06_05");	//I suppose, however, that they are here to quell the farmers' rebellion.
};


instance DIA_Thorben_Bauernaufstand(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 4;
	condition = DIA_Thorben_Bauernaufstand_Condition;
	information = DIA_Thorben_Bauernaufstand_Info;
	permanent = FALSE;
	description = "Do you know anything about the peasants' rebellion?";
};


func int DIA_Thorben_Bauernaufstand_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Thorben_Paladine) && (other.guild != GIL_SLD) && (other.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Thorben_Bauernaufstand_Info()
{
	AI_Output (other, self, "DIA_Thorben_Bauernaufstand_15_00");	//Do you know anything about the peasants' rebellion?
	AI_Output (self, other, "DIA_Thorben_Bauernaufstand_06_01");	//Rumor has it that Onar the landowner has hired mercenaries to keep the King's troops from breathing down his neck.
	AI_Output (self, other, "DIA_Thorben_Bauernaufstand_06_02");	//He was probably tired of having to throw his harvest along with his livestock at paladins and militia.
	AI_Output (self, other, "DIA_Thorben_Bauernaufstand_06_03");	//All we notice of this in town is that the food prices keep rising.
	AI_Output (self, other, "DIA_Thorben_Bauernaufstand_06_04");	//Onar's farm lies far to the east of here. We wouldn't know if there's any fighting going on there.
	AI_Output (self, other, "DIA_Thorben_Bauernaufstand_06_05");	//If you want to know more, ask the merchants in the marketplace. They get around the island more than I do.
};


instance DIA_Thorben_Gritta(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 5;
	condition = DIA_Thorben_Gritta_Condition;
	information = DIA_Thorben_Gritta_Info;
	permanent = FALSE;
	description = "I've come about Gritta ...";
};


func int DIA_Thorben_Gritta_Condition()
{
	if((MIS_Matteo_Gold == LOG_Running) && !Npc_IsDead(Gritta))
	{
		return TRUE;
	};
};

func void DIA_Thorben_Gritta_Info()
{
	AI_Output (other, self, "DIA_Thorben_Gritta_15_00");	//I've come about Gritta...
	AI_Output (self, other, "DIA_Thorben_Gritta_06_01");	//My niece? What's your business with her? This isn't about money, is it?
	AI_Output (other, self, "DIA_Thorben_Gritta_15_02");	//She owes 100 gold pieces to the merchant Matteo.
	AI_Output (self, other, "DIA_Thorben_Gritta_06_03");	//Tell me this isn't true. Ever since that little piece of work moved in with me, I've had nothing but trouble!
	AI_Output (self, other, "DIA_Thorben_Gritta_06_04");	//She's in debt with practically every single merchant in town.
	if(!Npc_KnowsInfo(other,DIA_Thorben_GiveBook))
	{
		AI_Output(self,other,"DIA_Thorben_Gritta_06_05");	//I had to borrow 200 gold pieces from Lehmar the moneylender just to settle her debts! And now this!
	};
	if(Npc_GetDistToWP(self,"NW_CITY_MERCHANT_SHOP01_FRONT_01") < 500)
	{
		AI_Output(self,other,"DIA_Thorben_Gritta_06_06");	//Gritta should be in the house.
	};
	AI_Output(self,other,"DIA_Thorben_Gritta_06_07");	//Go ahead, ask her. But I can tell you this: she doesn't have a SINGLE gold piece.
	if(Npc_HasItems(Gritta,ItMi_Gold) >= 100)
	{
		AI_Output(other,self,"DIA_Thorben_Gritta_15_08");	//We shall see...
	};
};


instance DIA_Thorben_GrittaHatteGold(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 5;
	condition = DIA_Thorben_GrittaHatteGold_Condition;
	information = DIA_Thorben_GrittaHatteGold_Info;
	permanent = FALSE;
	description = "Your niece had 100 gold pieces.";
};


func int DIA_Thorben_GrittaHatteGold_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Thorben_Gritta) && (Npc_HasItems(Gritta,ItMi_Gold) < 80) && !Npc_IsDead(Gritta))
	{
		return TRUE;
	};
};

func void DIA_Thorben_GrittaHatteGold_Info()
{
	AI_Output (other, self, "DIA_Thorben_GrittaHatteGold_15_00");	//Your niece had 100 gold pieces.
	AI_Output (self, other, "DIA_Thorben_GrittaHatteGold_06_01");	//WHAT? The brazen little serpent - that was MY gold! She took it from my chest.
	if(!Npc_KnowsInfo(other,DIA_Thorben_GiveBook))
	{
		AI_Output (self, other, "DIA_Thorben_GrittaHatteGold_06_02");	//Give it back to me! I have to pay off Lehmar first. Matteo can get his money later!
	};
	Info_ClearChoices(DIA_Thorben_GrittaHatteGold);
	if(MIS_Matteo_Gold == LOG_SUCCESS)
	{
		Info_AddChoice (DIA_Thorben_GrittaHatteGold, "I've already given Matteo his gold!", DIA_Thorben_GrittaHatteGold_MatteoHatEs);
	}
	else
	{
		Info_AddChoice (DIA_Thorben_GrittaHatteGold, "No. Matteo will get his money back from me.", DIA_Thorben_GrittaHatteGold_MatteoSollHaben);
	};
	if(Npc_HasItems(other,ItMi_Gold) >= 100)
	{
		Info_AddChoice (DIA_Thorben_GrittaHatteGold, "Here's your gold.", DIA_Thorben_GrittaHatteGold_HereItIs);
	};
};

func void B_Thorben_DeletePetzCrimeGritta()
{
	if(Gritta_GoldGiven == FALSE)
	{
		AI_Output (self, other, "B_Thorben_DeletePetzCrimeGritta_06_00");	//From what I know of this little viper, I'm sure she'll run straight to the city guard and accuse you, too!
		AI_Output (self, other, "B_Thorben_DeletePetzCrimeGritta_06_01");	//I shall see to it that the matter is settled.
		B_DeletePetzCrime (Gritta);
	};
};

func void DIA_Thorben_GrittaHatteGold_MatteoHatEs()
{
	AI_Output (other, self, "DIA_Thorben_GrittaHatteGold_MatteoHatEs_15_00");	//I've already given Matteo his gold!
	AI_Output (self, other, "DIA_Thorben_GrittaHatteGold_MatteoHatEs_06_01");	//Damn! Oh well - a debt is a debt. At least you didn't keep the money. I guess I should thank you for that.
	B_Thorben_DeletePetzCrimeGritta ();
	Info_ClearChoices (DIA_Thorben_GrittaHatteGold);
};

func void DIA_Thorben_GrittaHatteGold_MatteoSollHaben()
{
	AI_Output (other, self, "DIA_Thorben_GrittaHatteGold_MatteoSollHaben_15_00");	//No. Matteo will get his money back from me.
	if(!Npc_KnowsInfo(other,DIA_Thorben_GiveBook))
	{
		AI_Output (self, other, "DIA_Thorben_GrittaHatteGold_MatteoSollHaben_06_01");	//You're getting me into a right old mess that way. Lehmar is not terribly generous when it comes to debts.
	};
	AI_Output (self, other, "DIA_Thorben_GrittaHatteGold_MatteoSollHaben_06_02");	//But at least you are planning to pay my niece's debts. I guess I ought to thank you for that.
	B_Thorben_DeletePetzCrimeGritta();
	Info_ClearChoices(DIA_Thorben_GrittaHatteGold);
};

func void DIA_Thorben_GrittaHatteGold_HereItIs()
{
	AI_Output(other,self,"DIA_Thorben_GrittaHatteGold_HereItIs_15_00");	//Here's your gold.
	B_GiveInvItems(other,self,ItMi_Gold,100);
	if(!Npc_KnowsInfo(other,DIA_Thorben_GiveBook))
	{
		AI_Output(self,other,"DIA_Thorben_GrittaHatteGold_HereItIs_06_01");	//Thanks! Now I have at least part of the money I owe Lehmar.
	}
	else
	{
		B_Say(self,other,"$ABS_GOOD");
	};
	AI_Output(self,other,"DIA_Thorben_GrittaHatteGold_HereItIs_06_02");	//I can't believe she had the audacity to take my gold!
	B_Thorben_DeletePetzCrimeGritta();
	Thorben_GotGold = TRUE;
	Info_ClearChoices(DIA_Thorben_GrittaHatteGold);
};


instance DIA_Thorben_PICKPOCKET_Book(C_Info)
{
	npc = VLK_462_Thorben;
	nr = 700;
	condition = DIA_Thorben_PICKPOCKET_Book_Condition;
	information = DIA_Thorben_PICKPOCKET_Book_Info;
	permanent = TRUE;
	description = "(It would be simple to steal his book.)";
};


func int DIA_Thorben_PICKPOCKET_Book_Condition()
{
	if((ClassicLehmarBook == FALSE) && (SchuldBuch_Stolen_Thorben == FALSE) && Npc_KnowsInfo(other,DIA_Thorben_GiveBook) && Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) && (other.attribute[ATR_DEXTERITY] >= 20))
	{
		return TRUE;
	};
};

func void DIA_Thorben_PICKPOCKET_Book_Info()
{
	Info_ClearChoices(DIA_Thorben_PICKPOCKET_Book);
	Info_AddChoice(DIA_Thorben_PICKPOCKET_Book,Dialog_Back,DIA_Thorben_PICKPOCKET_Book_BACK);
	Info_AddChoice(DIA_Thorben_PICKPOCKET_Book,DIALOG_PICKPOCKET,DIA_Thorben_PICKPOCKET_Book_DoIt);
};

func void DIA_Thorben_PICKPOCKET_Book_DoIt()
{
	if(other.attribute[ATR_DEXTERITY] >= 30)
	{
		CreateInvItem(other,ItWr_Schuldenbuch);
		AI_PrintScreen("Stolen: Book of Debts",-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
		B_GiveThiefXP();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Thorben",PRINT_PickPocketSuccess));
		SchuldBuch_Stolen_Thorben = TRUE;
	}
	else
	{
		B_ResetThiefLevel();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Thorben",PRINT_PickPocketFailed));
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_Theft,1);
	};
	Info_ClearChoices(DIA_Thorben_PICKPOCKET_Book);
};

func void DIA_Thorben_PICKPOCKET_Book_BACK()
{
	Info_ClearChoices(DIA_Thorben_PICKPOCKET_Book);
};

