
instance DIA_Isgaroth_EXIT(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 999;
	condition = DIA_Isgaroth_EXIT_Condition;
	information = DIA_Isgaroth_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Isgaroth_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Isgaroth_EXIT_Info()
{
	AI_Output (self, other, "DIA_Isgaroth_EXIT_01_00");	//May Innos watch over you always.
	AI_StopProcessInfos (self);
};


instance DIA_Isgaroth_Hello(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 2;
	condition = DIA_Isgaroth_Hello_Condition;
	information = DIA_Isgaroth_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Isgaroth_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Isgaroth_Hello_Info()
{
	AI_Output (self, other, "DIA_Isgaroth_Hello_01_00");	//Innos be with you. What can I do for you, wanderer?
};


instance DIA_Isgaroth_Segen(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 10;
	condition = DIA_Isgaroth_Segen_Condition;
	information = DIA_Isgaroth_Segen_Info;
	permanent = TRUE;
	description = "Bless me!";
};


func int DIA_Isgaroth_Segen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Isgaroth_Job))
	{
		return TRUE;
	};
};

func void DIA_Isgaroth_Segen_Info()
{
	AI_Output (other, self, "DIA_Isgaroth_Segen_15_00");	//Bless me!
	AI_Output (self, other, "DIA_Isgaroth_Segen_01_01");	//I bless you in the name of Innos. May the Lord's fire burn in your heart and give you the strength to act according to his justice.
	if((MIS_Thorben_GetBlessings == LOG_Running) && (GotInnosBlessingForThorben == FALSE))
	{
		B_LogEntry(TOPIC_Thorben,"Isgaroth the Fire Magician has given me his blessing.");
	};
	GotInnosBlessingForThorben = TRUE;
};


instance DIA_Isgaroth_Wolf(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 2;
	condition = DIA_Isgaroth_Wolf_Condition;
	information = DIA_Isgaroth_Wolf_Info;
	permanent = FALSE;
	description = "Sergio sent me ...";
};


func int DIA_Isgaroth_Wolf_Condition()
{
//	if((MIS_KlosterArbeit == LOG_Running) && (Sergio_Sends == TRUE) && (Kapitel == 1))
	if((MIS_IsgarothWolf == LOG_Running) && (Sergio_Sends == TRUE) && (Kapitel == 1))
	{
		return TRUE;
	};
};

func void DIA_Isgaroth_Wolf_Info()
{
	AI_Output (other, self, "DIA_Isgaroth_Wolf_15_00");	//Sergio sent me. I have taken over his task. So, what is it?
	AI_Output (self, other, "DIA_Isgaroth_Wolf_01_01");	//A dark wolf has been roaming the area recently. Track it down and kill it.
	MIS_IsgarothWolf = LOG_Running;
	B_LogEntry (Topic_IsgarothWolf, "There's a dark wolf roaming around the shrine. I should find him and kill him.");
};


instance DIA_Isgaroth_tot(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 2;
	condition = DIA_Isgaroth_tot_Condition;
	information = DIA_Isgaroth_tot_Info;
//	permanent = TRUE;
	permanent = FALSE;
	description = "I have killed the wolf.";
};


func int DIA_Isgaroth_tot_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Isgaroth_Wolf) && Npc_IsDead(Wolfi))
	{
		return TRUE;
	};
};

func void DIA_Isgaroth_tot_Info()
{
	AI_Output(other,self,"DIA_Isgaroth_tot_15_00");	//I have killed the wolf.
	if(other.guild == GIL_KDF)
	{
		AI_Output(self,other,"DIA_Isgaroth_EXIT_01_00");	//May Innos watch over you always.
	}
	else
	{
		AI_Output(self,other,"DIA_Isgaroth_tot_01_01");	//Good work, novice. You are a brave man. But now return to the monastery and go about your duties.
	};
	MIS_IsgarothWolf = LOG_SUCCESS;
	B_GivePlayerXP(XP_IsgarothWolf);
	AI_StopProcessInfos(self);
};


instance DIA_Isgaroth_Job(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 4;
	condition = DIA_Isgaroth_Job_Condition;
	information = DIA_Isgaroth_Job_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Isgaroth_Job_Condition()
{
	return TRUE;
};

func void DIA_Isgaroth_Job_Info()
{
	AI_Output(other,self,"DIA_Isgaroth_Job_15_00");	//What are you doing here?
	if((hero.guild != GIL_KDF) && (hero.guild != GIL_NOV))
	{
		AI_Output(self,other,"DIA_Isgaroth_Job_01_01");	//I am a Magician of Fire. A priest of our god Innos.
		AI_Output(self,other,"DIA_Isgaroth_Job_01_02");	//This shrine is consecrated to HIM, the highest god, the creator of the fire and lord of justice.
	};
	AI_Output(self,other,"DIA_Isgaroth_Job_01_03");	//People come to me in order to pray to Innos and be blessed.
	AI_Output(self,other,"DIA_Isgaroth_Job_01_04");	//And for a small donation, you can get many useful things from me.
	Log_CreateTopic(Topic_KlosterTrader,LOG_NOTE);
	B_LogEntry(Topic_KlosterTrader,"Master Isgaroth trades useful magic objects at the shrine in front of the monastery.");
};


instance DIA_Isgaroth_Trade(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 99;
	condition = DIA_Isgaroth_Trade_Condition;
	information = DIA_Isgaroth_Trade_Info;
	permanent = TRUE;
	trade = TRUE;
	description = DIALOG_TRADE_v4;
};


func int DIA_Isgaroth_Trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Isgaroth_Job))
	{
		return TRUE;
	};
};

func void DIA_Isgaroth_Trade_Info()
{
	AI_Output(other,self,"DIA_Isgaroth_Trade_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
};


instance DIA_Isgaroth_Kloster(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 3;
	condition = DIA_Isgaroth_Kloster_Condition;
	information = DIA_Isgaroth_Kloster_Info;
	permanent = FALSE;
	description = "Where will this path take me?";
};


func int DIA_Isgaroth_Kloster_Condition()
{
	if((other.guild != GIL_NOV) && (other.guild != GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Isgaroth_Kloster_Info()
{
	AI_Output (other, self, "DIA_Isgaroth_Kloster_15_00");	//Where will this path take me?
	AI_Output (self, other, "DIA_Isgaroth_Kloster_01_01");	//The path leads to the monastery of the Magicians of Fire. However, access is permitted only to the servants of Innos.
	if (other.guild == GIL_NONE)
	{
		AI_Output(self,other,"DIA_Isgaroth_Kloster_01_02");	//And if you want to be accepted as a novice in the monastery, you must bring a sheep and...
		B_Say_Gold(self,other,Summe_Kloster);
		if(SC_KnowsKlosterTribut == FALSE)
		{
			SC_KnowsKlosterTribut = TRUE;
			Log_CreateTopic(Topic_Kloster,LOG_MISSION);
			Log_SetTopicStatus(Topic_Kloster,LOG_Running);
			B_LogEntry(Topic_Kloster,"To become a novice at the monastery of Innos, I need a sheep and 1000 pieces of gold.");
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Isgaroth_Kloster_01_03");	//Since you have already chosen to join another group, entrance will be denied you.
	};
};


instance DIA_Isgaroth_Vatras(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 3;
	condition = DIA_Isgaroth_Vatras_Condition;
	information = DIA_Isgaroth_Vatras_Info;
	permanent = TRUE;
	description = "I carry a message from Vatras.";
};


func int DIA_Isgaroth_Vatras_Condition()
{
	if((MIS_Vatras_Message == LOG_Running) && (Npc_HasItems(other,ItWr_VatrasMessage) || Npc_HasItems(other,ItWr_VatrasMessage_Open)))
	{
		return TRUE;
	};
};

func void DIA_Isgaroth_Vatras_Info()
{
	AI_Output (other, self, "DIA_ISgaroth_Vatras_15_00");	//I carry a message from Vatras.
	AI_Output (self, other, "DIA_Isgaroth_Vatras_01_01");	//What is this message?
	AI_Output (other, self, "DIA_Isgaroth_Vatras_15_02");	//It's a letter. Here.
	if(Npc_HasItems(other,ItWr_VatrasMessage))
	{
		B_GiveInvItems(other,self,ItWr_VatrasMessage,1);
		Npc_RemoveInvItem(self,ItWr_VatrasMessage);
		B_UseFakeScroll();
		AI_Output (self, other, "DIA_Isgaroth_Vatras_01_03");	//Good, you can tell Vatras that I have received the message.
		AI_Output (self, other, "DIA_Isgaroth_Vatras_01_04");	//Take these potions as a reward for your service, they will surely be of use to you.
		CreateInvItems(self,ItPo_Health_02,2);
		B_GiveInvItems(self,other,ItPo_Health_02,2);
		B_GivePlayerXP(XP_Ambient * 2);
	}
	else if(Npc_HasItems(other,ItWr_VatrasMessage_Open))
	{
		B_GiveInvItems(other,self,ItWr_VatrasMessage_Open,1);
		Npc_RemoveInvItem(self,ItWr_VatrasMessage_Open);
		B_UseFakeScroll();
		AI_Output (self, other, "DIA_Isgaroth_Vatras_01_05");	//The seal is broken. What were you thinking, you fool!
		AI_Output (self, other, "DIA_Isgaroth_Vatras_01_06");	//Go and tell Vatras that I have received his message.
		AI_StopProcessInfos(self);
	};
	Vatras_Return = TRUE;
};


instance DIA_Isgaroth_PICKPOCKET(C_Info)
{
	npc = KDF_509_Isgaroth;
	nr = 900;
	condition = DIA_Isgaroth_PICKPOCKET_Condition;
	information = DIA_Isgaroth_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Isgaroth_PICKPOCKET_Condition()
{
	return C_Beklauen(48,50);
};

func void DIA_Isgaroth_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Isgaroth_PICKPOCKET);
	Info_AddChoice(DIA_Isgaroth_PICKPOCKET,Dialog_Back,DIA_Isgaroth_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Isgaroth_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Isgaroth_PICKPOCKET_DoIt);
};

func void DIA_Isgaroth_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Isgaroth_PICKPOCKET);
};

func void DIA_Isgaroth_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Isgaroth_PICKPOCKET);
};

