
instance DIA_Cipher_EXIT(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 999;
	condition = DIA_Cipher_EXIT_Condition;
	information = DIA_Cipher_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Cipher_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Cipher_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Cipher_Hello(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 1;
	condition = DIA_Cipher_Hello_Condition;
	information = DIA_Cipher_Hello_Info;
	permanent = FALSE;
	description = "What's up?";
};


func int DIA_Cipher_Hello_Condition()
{
	return TRUE;
};

func void DIA_Cipher_Hello_Info()
{
	AI_Output (other, self, "DIA_Cipher_Hello_15_00");	//How are things?
	AI_Output (self, other, "DIA_Cipher_Hello_07_01");	//Hey, don't I know you from somewhere?
	AI_Output (other, self, "DIA_Cipher_Hello_15_02");	//It's possible ...
	AI_Output (self, other, "DIA_Cipher_Hello_07_03");	//I used to deal in swampweed back in the colony, remember?
};


instance DIA_Cipher_TradeWhat(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_TradeWhat_Condition;
	information = DIA_Cipher_TradeWhat_Info;
	permanent = FALSE;
	description = "And what are you dealing in now?";
};


func int DIA_Cipher_TradeWhat_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Cipher_Hello))
	{
		return TRUE;
	};
};

func void DIA_Cipher_TradeWhat_Info()
{
	AI_Output (other, self, "DIA_Cipher_TradeWhat_15_00");	//And what are you dealing in now?
	AI_Output (self, other, "DIA_Cipher_TradeWhat_07_01");	//Ah, don't ask.
	AI_Output (self, other, "DIA_Cipher_TradeWhat_07_02");	//I brought a whole package of swampweed with me from the mining colony.
	AI_Output (self, other, "DIA_Cipher_TradeWhat_07_03");	//Many of the mercenaries like a little smoke now and then. I've earned a small fortune on the side.
	AI_Output (self, other, "DIA_Cipher_TradeWhat_07_04");	//But some bastard stole all the weed from my chest!
	Log_CreateTopic(TOPIC_SoldierTrader,LOG_NOTE);
	B_LogEntries(TOPIC_SoldierTrader,"Cipher is a merchant on Onar's farm.");
	Log_CreateTopic(Topic_CipherPaket,LOG_MISSION);
	Log_SetTopicStatus(Topic_CipherPaket,LOG_Running);
	B_LogNextEntry(Topic_CipherPaket,"The mercenary Cipher has lost a package of swampweed.");
	if(!Npc_IsDead(Bodo))
	{
		AI_Output(self,other,"DIA_Cipher_TradeWhat_07_05");	//I'm pretty sure it was that Bodo. He bunks in the same room as me, and he always grins at me like such an idiot...
		Log_AddEntry(Topic_CipherPaket,"He suspects Bodo of stealing it");
	};
	MIS_Cipher_Paket = LOG_Running;
};


instance DIA_Cipher_DoWithThief(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_DoWithThief_Condition;
	information = DIA_Cipher_DoWithThief_Info;
	permanent = FALSE;
	description = "What are you going to do about the thief, then?";
};


func int DIA_Cipher_DoWithThief_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Cipher_TradeWhat))
	{
		return TRUE;
	};
};

func void DIA_Cipher_DoWithThief_Info()
{
	AI_Output (other, self, "DIA_Cipher_DoWithThief_15_00");	//What are you going to do about the thief, then?
	AI_Output (self, other, "DIA_Cipher_DoWithThief_07_01");	//One of these days, I'll catch him puffing away on my weed.
	AI_Output (self, other, "DIA_Cipher_DoWithThief_07_02");	//And then I'll find a quiet spot and teach him a lesson he won't forget.
	AI_Output (self, other, "DIA_Cipher_DoWithThief_07_03");	//If I knock him down here in the middle of the yard, the other farmers will notice, and I'll pay an arm and a leg.
	AI_Output (other, self, "DIA_Cipher_DoWithThief_15_04");	//How come?
	AI_Output (self, other, "DIA_Cipher_DoWithThief_07_05");	//Quite simple. We can't rough up the farmers, otherwise Lee makes us pay a heavy fine. That's the way Onar wants it.
	AI_Output (self, other, "DIA_Cipher_DoWithThief_07_06");	//And the more witnesses there are, the more of a fuss there is. That makes things more expensive.
	AI_Output (self, other, "DIA_Cipher_DoWithThief_07_07");	//So I'll pull the thing off nice and inconspicuously ...
};


instance DIA_Cipher_WannaJoin(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_WannaJoin_Condition;
	information = DIA_Cipher_WannaJoin_Info;
	permanent = FALSE;
	description = "I want to join Lee's people!";
};


func int DIA_Cipher_WannaJoin_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Cipher_Hello) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Cipher_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Cipher_WannaJoin_15_00");	//I want to join Lee's people!
	AI_Output (self, other, "DIA_Cipher_WannaJoin_07_01");	//LEE'S people?! If Lee keeps on this way, they soon won't be his any more!
	AI_Output (other, self, "DIA_Cipher_WannaJoin_15_02");	//Why?
	AI_Output (self, other, "DIA_Cipher_WannaJoin_07_03");	//Lee has always been a quiet one. It was that way in the colony, too.
	AI_Output (self, other, "DIA_Cipher_WannaJoin_07_04");	//But lately, he's overdoing it. He just wants to sit here and wait until the paladins drop dead from starvation.
	AI_Output (self, other, "DIA_Cipher_WannaJoin_07_05");	//Sylvio thinks we should clean up a bit on the small farms and outside the city.
	AI_Output (self, other, "DIA_Cipher_WannaJoin_07_06");	//I think that would make for an excellent change.
	AI_Output (self, other, "DIA_Cipher_WannaJoin_07_07");	//At the moment, most of us are just twiddling our thumbs here - do you want to join up anyway?
};


func void B_CipherHappyForWeedPaket()
{
	AI_Output(self,other,"DIA_Cipher_Joints_07_01");	//You brought back my packet! Now everything will be all right.
	if((other.guild == GIL_NONE) && (GotCipherVote == FALSE))
	{
		AI_Output(self,other,"DIA_Cipher_Joints_07_02");	//I'm certainly going to vote for you...
		if(Torlof_GenugStimmen == FALSE)
		{
			Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
		};
		B_LogEntry(TOPIC_SLDRespekt,"Cipher will vote for me when I join the mercenaries.");
		SCKnowsSLDVotes = TRUE;
		GotCipherVote = TRUE;
	};
	B_GivePlayerXP(XP_CipherWeed);
};

instance DIA_Cipher_YesJoin(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_YesJoin_Condition;
	information = DIA_Cipher_YesJoin_Info;
	permanent = FALSE;
	description = "I want to become one of you no matter what!";
};


func int DIA_Cipher_YesJoin_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Cipher_WannaJoin) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Cipher_YesJoin_Info()
{
	AI_Output(other,self,"DIA_Cipher_YesJoin_15_00");	//I want to become one of you no matter what!
	if(MIS_Cipher_Paket == LOG_SUCCESS)
	{
		B_CipherHappyForWeedPaket();
		B_GivePlayerXP(XP_CipherWeed);
	}
	else
	{
	AI_Output (self, other, "DIA_Cipher_YesJoin_07_01");	//You already know that we take a vote on every new recruit?
	AI_Output (other, self, "DIA_Cipher_YesJoin_15_02");	//What are you hinting at?
	AI_Output (self, other, "DIA_Cipher_YesJoin_07_03");	//Well, I haven't had anything to smoke in a long time. Bring me a few swampweed reefers and you've got my vote.
	AI_Output (self, other, "DIA_Cipher_YesJoin_07_04");	//You can surely scare some up someplace.
		SCKnowsSLDVotes = TRUE;
		MIS_Cipher_BringWeed = LOG_Running;
		Log_CreateTopic(Topic_CipherHerb,LOG_MISSION);
		Log_SetTopicStatus(Topic_CipherHerb,LOG_Running);
		B_LogEntry(Topic_CipherHerb,"Cipher will give me his vote if I bring him some stalks of swampweed.");
	};
};


instance DIA_Cipher_Joints(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_Joints_Condition;
	information = DIA_Cipher_Joints_Info;
	permanent = TRUE;
	description = "About the swampweed...";
};


func int DIA_Cipher_Joints_Condition()
{
	if(MIS_Cipher_BringWeed == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Cipher_Joints_Info()
{
	AI_Output (other, self, "DIA_Cipher_Joints_15_00");	//About the swampweed...
	if (MIS_Cipher_Paket == LOG_SUCCESS)
	{
		B_CipherHappyForWeedPaket();
		MIS_Cipher_BringWeed = LOG_SUCCESS;
	}
	else
	{
		Info_ClearChoices(DIA_Cipher_Joints);
		Info_AddChoice(DIA_Cipher_Joints,"I'll see what I can do...",DIA_Cipher_Joints_Running);
		if(Npc_HasItems(other,ItMi_Joint))
		{
			Info_AddChoice (DIA_Cipher_Joints, "Here's a few stalks for you...", DIA_Cipher_Joints_Success);
		};
	};
};

func void DIA_Cipher_Joints_Running()
{
	AI_Output (other, self, "DIA_Cipher_Joints_Running_15_00");	//I'll see what I can do...
	Info_ClearChoices (DIA_Cipher_Joints);
};

func void DIA_Cipher_Joints_Success()
{
	AI_Output (other, self, "DIA_Cipher_Joints_Success_15_00");	//Here's a few stalks for you...
	if (B_GiveInvItems (other, self, ItMi_Joint, 10))
	{
		AI_Output(self,other,"DIA_Cipher_Joints_Success_07_01");	//Ah! You are my man!
		if((other.guild == GIL_NONE) && (GotCipherVote == FALSE))
		{
			AI_Output(self,other,"DIA_Cipher_Joints_Success_07_05");	//You've got my vote.
			if(Torlof_GenugStimmen == FALSE)
			{
				Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
				Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
			};
			B_LogEntry(TOPIC_SLDRespekt,"Cipher will vote for me when I join the mercenaries.");
			SCKnowsSLDVotes = TRUE;
			GotCipherVote = TRUE;
		};
		MIS_Cipher_BringWeed = LOG_SUCCESS;
		B_GivePlayerXP(XP_CipherWeed);
	}
	else
	{
		AI_Output (self, other, "DIA_Cipher_Joints_Success_07_03");	//That's all? I can smoke that much in one sitting!
		AI_Output (self, other, "DIA_Cipher_Joints_Success_07_04");	//It's got to be at least 10 reefers.
	};
	Info_ClearChoices(DIA_Cipher_Joints);
};


instance DIA_Cipher_TRADE(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_TRADE_Condition;
	information = DIA_Cipher_TRADE_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Cipher_TRADE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Cipher_TradeWhat))
	{
		return TRUE;
	};
};

func void DIA_Cipher_TRADE_Info()
{
	AI_Output(other,self,"DIA_Cipher_TRADE_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
	if(Npc_HasItems(self,ItMi_Joint))
	{
		AI_Output(self,other,"DIA_Cipher_TRADE_07_01");	//Sure. Help yourself.
	}
	else if(!Npc_HasItems(self,ItPl_SwampHerb))
	{
		AI_Output(self,other,"DIA_Cipher_TRADE_07_02");	//I don't have any swampweed at the moment. Do you want something else?
	};
	Trade_IsActive = TRUE;
};


instance DIA_Cipher_DarDieb(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_DarDieb_Condition;
	information = DIA_Cipher_DarDieb_Info;
	permanent = FALSE;
	description = "I know who took your weed.";
};


func int DIA_Cipher_DarDieb_Condition()
{
	if((Dar_Dieb == TRUE) || (Dar_Verdacht == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Cipher_DarDieb_Info()
{
	AI_Output (other, self, "DIA_Cipher_DarDieb_15_00");	//I know who took your weed.
	AI_Output (self, other, "DIA_Cipher_DarDieb_07_01");	//Who? Was it that Bodo?
	AI_Output (other, self, "DIA_Cipher_DarDieb_15_02");	//No - one of the mercenaries did it - Dar.
	AI_Output (self, other, "DIA_Cipher_DarDieb_07_03");	//That bastard - where is he?
	if((Dar_Dieb == TRUE) || (DIA_Kardif_Paket_perm == TRUE))
	{
		AI_Output(other,self,"DIA_Cipher_DarDieb_15_04");	//Finding him won't help you, he doesn't have the package any more. He sold it in Khorinis.
		AI_Output(self,other,"DIA_Cipher_DarDieb_07_05");	//WHERE IS HE!?!
	};
	if(!Npc_IsDead(Dar))
	{
			AI_Output (other, self, "DIA_Cipher_DarDieb_15_06");	//Behind the kitchen building, on the corner...
			AI_Output (self, other, "DIA_Cipher_DarDieb_07_07");	//I'LL FLATTEN HIM!
		AI_StopProcessInfos(self);
		other.aivar[AIV_INVINCIBLE] = FALSE;
		B_Attack(self,Dar,AR_NONE,0);
	}
	else
	{
		DIA_Common_HeIsDead();
		AI_Output(self,other,"DIA_Cipher_DarLOST_07_03");	//The little beggar has no business going through my chest!
		AI_StopProcessInfos(self);
	};
};


instance DIA_Cipher_DarLOST(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_DarLOST_Condition;
	information = DIA_Cipher_DarLOST_Info;
	permanent = FALSE;
	description = "You really gave Dar what for... are you feeling better now?";
};


func int DIA_Cipher_DarLOST_Condition()
{
	if(Dar_LostAgainstCipher == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Cipher_DarLOST_Info()
{
	AI_Output (other, self, "DIA_Cipher_DarLOST_15_00");	//You really gave Dar what for... are you feeling better now?
	AI_Output (self, other, "DIA_Cipher_DarLOST_07_01");	//(sighs) Yeah, that felt good.
	AI_Output (other, self, "DIA_Cipher_DarLOST_15_02");	//Not to HIM, I suppose...
	AI_Output (self, other, "DIA_Cipher_DarLOST_07_03");	//The little beggar has no business going through my chest!
	B_GivePlayerXP (XP_Ambient * 2);
};


instance DIA_Cipher_KrautPaket(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 2;
	condition = DIA_Cipher_KrautPaket_Condition;
	information = DIA_Cipher_KrautPaket_Info;
	permanent = FALSE;
	description = "Would this package of swampweed happen to be yours?";
};


func int DIA_Cipher_KrautPaket_Condition()
{
	if(Npc_HasItems(other,ItMi_HerbPaket) && (MIS_Cipher_Paket == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Cipher_KrautPaket_Info()
{
	AI_Output (other, self, "DIA_Cipher_KrautPaket_15_00");	//Would this package of swampweed happen to be yours?
	B_GiveInvItems (other, self, ItMi_HerbPaket, 1);
	AI_Output (self, other, "DIA_Cipher_KrautPaket_07_01");	//Well, I'll be! Where did you get that?
	AI_Output (other, self, "DIA_Cipher_KrautPaket_15_02");	//It's a long story...
	AI_Output (self, other, "DIA_Cipher_KrautPaket_07_03");	//Doesn't matter, really, you're a decent guy.
	if((other.guild == GIL_NONE) && Npc_KnowsInfo(other,DIA_Cipher_WannaJoin) && (GotCipherVote == FALSE))
	{
		AI_Output(self,other,"DIA_Cipher_Joints_Success_07_02");	//You've got my vote.
		if(Torlof_GenugStimmen == FALSE)
		{
			Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
		};
		B_LogEntry(TOPIC_SLDRespekt,"Cipher will vote for me when I join the mercenaries.");
		SCKnowsSLDVotes = TRUE;
		GotCipherVote = TRUE;
	};
	AI_Output(self,other,"DIA_Cipher_KrautPaket_07_04");	//Here, take this as a reward. Have fun with it!
	Npc_RemoveInvItems(self,ItMi_Joint,10);
	CreateInvItems(other,ItMi_Joint,10);
	CreateInvItems(other,ItMi_Gold,200);
	AI_PrintScreen("Received: 10 stalks of swampweed",-1,43,FONT_ScreenSmall,3);
	AI_PrintScreen("Received: 200 gold",-1,40,FONT_ScreenSmall,3);
	AI_Output(self,other,"DIA_Cipher_KrautPaket_07_05");	//First let me roll a few...
	Npc_RemoveInvItems(self,ItMi_HerbPaket,1);
	CreateInvItems(self,ItMi_Joint,40);
	MIS_Cipher_Paket = LOG_SUCCESS;
	B_GivePlayerXP(XP_CipherPaket);
};


instance DIA_CipherSLD_PICKPOCKET(C_Info)
{
	npc = SLD_803_Cipher;
	nr = 900;
	condition = DIA_CipherSLD_PICKPOCKET_Condition;
	information = DIA_CipherSLD_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_CipherSLD_PICKPOCKET_Condition()
{
	return C_Beklauen(65,65);
};

func void DIA_CipherSLD_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_CipherSLD_PICKPOCKET);
	Info_AddChoice(DIA_CipherSLD_PICKPOCKET,Dialog_Back,DIA_CipherSLD_PICKPOCKET_BACK);
	Info_AddChoice(DIA_CipherSLD_PICKPOCKET,DIALOG_PICKPOCKET,DIA_CipherSLD_PICKPOCKET_DoIt);
};

func void DIA_CipherSLD_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_CipherSLD_PICKPOCKET);
};

func void DIA_CipherSLD_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_CipherSLD_PICKPOCKET);
};

