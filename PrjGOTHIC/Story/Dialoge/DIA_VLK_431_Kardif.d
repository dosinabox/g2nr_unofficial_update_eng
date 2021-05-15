
instance DIA_Kardif_EXIT(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 999;
	condition = DIA_Kardif_EXIT_Condition;
	information = DIA_Kardif_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Kardif_EXIT_Condition()
{
	if(Kardif_OneQuestion == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Kardif_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Kardif_PICKPOCKET(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 900;
	condition = DIA_Kardif_PICKPOCKET_Condition;
	information = DIA_Kardif_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Kardif_PICKPOCKET_Condition()
{
	if(Kardif_OneQuestion == FALSE)
	{
		return C_Beklauen(55,85);
	};
	return FALSE;
};

func void DIA_Kardif_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Kardif_PICKPOCKET);
	Info_AddChoice(DIA_Kardif_PICKPOCKET,Dialog_Back,DIA_Kardif_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Kardif_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Kardif_PICKPOCKET_DoIt);
};

func void DIA_Kardif_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Kardif_PICKPOCKET);
};

func void DIA_Kardif_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Kardif_PICKPOCKET);
};


instance DIA_Kardif_Hi(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 2;
	condition = DIA_Kardif_Hi_Condition;
	information = DIA_Kardif_Hi_Info;
	permanent = FALSE;
	description = "What's up?";
};


func int DIA_Kardif_Hi_Condition()
{
	if(Kardif_OneQuestion == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Kardif_Hi_Info()
{
	AI_Output(other,self,"DIA_Kardif_Hi_15_00");	//How are things?
	if(self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_LOST)
	{
		AI_Output(self,other,"DIA_Kardif_Hi_14_01");	//If you want something to drink, you'll have to order it.
	}
	else
	{
		AI_Output(self,other,"DIA_Kardif_Hallo_14_01");	//So, what's that to you?
	};
	Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
	B_LogEntry(TOPIC_CityTrader,"Kardif sells drinks in the dockside pub.");
};


instance DIA_Kardif_Hallo(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 2;
	condition = DIA_Kardif_Hallo_Condition;
	information = DIA_Kardif_Hallo_Info;
	permanent = FALSE;
	description = "I bet you overhear a lot of things...";
};


func int DIA_Kardif_Hallo_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kardif_Hi) && (Kardif_Deal == 0))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Hallo_Info()
{
	AI_Output (other, self, "DIA_Kardif_Hallo_15_00");	//I bet you overhear a lot of things ...
	AI_Output (self, other, "DIA_Kardif_Hallo_14_01");	//So, what's that to you?
	AI_Output (other, self, "DIA_Kardif_Hallo_15_02");	//I've always got an open ear for news.
	AI_Output (self, other, "DIA_Kardif_Hallo_14_03");	//Have you got your purse open, then?
	AI_Output (self, other, "DIA_Kardif_Hallo_14_04");	//Every piece of information I give you will cost 10 gold pieces.
	if(!Npc_KnowsInfo(other,DIA_Meldor_Interessantes))
	{
		Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
		B_LogEntry(TOPIC_CityTrader,"Kardif, the landlord of the harbor pub, trades information.");
	};
	Info_ClearChoices(DIA_Kardif_Hallo);
	Info_AddChoice (DIA_Kardif_Hallo, "I'll give you no more than 5 for your info.", DIA_Kardif_Hallo_Angebot);
	Info_AddChoice (DIA_Kardif_Hallo, "Forget it - I'll get my info elsewhere.", DIA_Kardif_Hallo_Hart);
	Info_AddChoice (DIA_Kardif_Hallo, "All right, agreed.", DIA_Kardif_Hallo_Zehn);
};

func void DIA_Kardif_Hallo_Zehn()
{
	AI_Output (other, self, "DIA_Kardif_Hallo_Zehn_15_00");	//All right, agreed.
	AI_Output (self, other, "DIA_Kardif_Hallo_Zehn_14_01");	//You struck a good bargain (grins). I'm always at your service.
	Kardif_Deal = 10;
	Info_ClearChoices(DIA_Kardif_Hallo);
};

func void DIA_Kardif_Hallo_Angebot()
{
	AI_Output (other, self, "DIA_Kardif_Hallo_Angebot_15_00");	//I'll give you no more than 5 for your information.
	AI_Output (self, other, "DIA_Kardif_Hallo_Angebot_14_01");	//What, 5 gold pieces? Are you trying to ruin me? (thinks briefly) - Let's make it 7.
	Info_ClearChoices (DIA_Kardif_Hallo);
	Info_AddChoice (DIA_Kardif_Hallo, "No, it doesn't work that way. Let's say 6!", DIA_Kardif_Hallo_KeinDeal);
	Info_AddChoice (DIA_Kardif_Hallo, "OK, 7 gold pieces sounds fair.", DIA_Kardif_Hallo_Sieben);
};

func void DIA_Kardif_Hallo_Hart()
{
	AI_Output (other, self, "DIA_Kardif_Hallo_Hart_15_00");	//Forget it - I'll get my information elsewhere.
	AI_Output (self, other, "DIA_Kardif_Hallo_Hart_14_01");	//All right, all right ... I'll go down to 7.
	Info_ClearChoices (DIA_Kardif_Hallo);
	Info_AddChoice (DIA_Kardif_Hallo, "OK, 7 gold pieces sounds fair.", DIA_Kardif_Hallo_Sieben);
	Info_AddChoice (DIA_Kardif_Hallo, "No, I don't need your information that bad.", DIA_Kardif_Hallo_Ablehnen);
};

func void DIA_Kardif_Hallo_Sieben()
{
	AI_Output (other, self, "DIA_Kardif_Hallo_Sieben_15_00");	//OK, 7 gold pieces sounds fair.
	AI_Output (self, other, "DIA_Kardif_Hallo_Sieben_14_01");	//(grins) A wise decision. Well, so if there's anything you want to know, ask me.
	Kardif_Deal = 7;
	Info_ClearChoices(DIA_Kardif_Hallo);
};

func void DIA_Kardif_Hallo_Ablehnen()
{
	AI_Output (other, self, "DIA_Kardif_Hallo_Ablehnen_15_00");	//No, I don't need your information that bad.
	AI_Output (self, other, "DIA_Kardif_Hallo_Ablehnen_14_01");	//Hey, wait ... (sigh) - all right, 5 gold pieces. But that's my final offer!
	Info_ClearChoices (DIA_Kardif_Hallo);
	Info_AddChoice (DIA_Kardif_Hallo, "Why couldn't you say that right away?", DIA_Kardif_Hallo_Fuenf);
};

func void DIA_Kardif_Hallo_Fuenf()
{
	AI_Output (other, self, "DIA_Kardif_Hallo_Fuenf_15_00");	//Why couldn't you say that right away?
	AI_Output (self, other, "DIA_Kardif_Hallo_Fuenf_14_01");	//Oh, I'm simply out of shape. But whatever - it's a deal.
	Kardif_Deal = 5;
	Info_ClearChoices(DIA_Kardif_Hallo);
};

func void DIA_Kardif_Hallo_KeinDeal()
{
	AI_Output (other, self, "DIA_Kardif_Hallo_KeinDeal_15_00");	//No, it doesn't work that way. Let's say 6!
	AI_Output (self, other, "DIA_Kardif_Hallo_KeinDeal_14_01");	//You're a scoundrel, you know that? Well, if you insist, let's say 6 gold pieces for each piece of information.
	Kardif_Deal = 6;
	Info_ClearChoices(DIA_Kardif_Hallo);
};


instance DIA_Kardif_TRADE(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 2;
	condition = DIA_Kardif_TRADE_Condition;
	information = DIA_Kardif_TRADE_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "Give me something to drink.";
};


func int DIA_Kardif_TRADE_Condition()
{
	if((Kardif_OneQuestion == FALSE) && Npc_KnowsInfo(other,DIA_Kardif_Hi))
	{
		return TRUE;
	};
};

func void DIA_Kardif_TRADE_Info()
{
	AI_Output(other,self,"DIA_Kardif_TRADE_15_00");	//Дай мне что-нибудь выпить.
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Kardif_TradeInfo(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 2;
	condition = DIA_Kardif_TradeInfo_Condition;
	information = DIA_Kardif_TradeInfo_Info;
	permanent = TRUE;
	description = "I need some information.";
};


func int DIA_Kardif_TradeInfo_Condition()
{
	if((Kardif_OneQuestion == FALSE) && (Kardif_Deal > 0))
	{
		return TRUE;
	};
};

func void DIA_Kardif_TradeInfo_Info()
{
	AI_Output (other, self, "DIA_Kardif_TradeInfo_15_00");	//I need information.
	Kardif_OneQuestion = TRUE;
};

func void B_SayKardifZuwenigGold()
{
	AI_Output (self, other, "B_SayKardifZuwenigGold_14_00");	//Come back when you have enough gold.
};


instance DIA_Kardif_Buerger(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 5;
	condition = DIA_Kardif_Buerger_Condition;
	information = DIA_Kardif_Buerger_Info;
	permanent = TRUE;
	description = "Who counts among the influential citizens in this town?";
};


var int DIA_Kardif_Buerger_permanent;

func int DIA_Kardif_Buerger_Condition()
{
	if((DIA_Kardif_Buerger_permanent == FALSE) && (Kardif_OneQuestion == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Buerger_Info()
{
	AI_Output(other,self,"DIA_Kardif_Buerger_15_00");	//Who counts among the influential citizens in this town?
	if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output (self, other, "DIA_Kardif_Buerger_14_01");	//You won't find anyone down here at the harbor. The only powerful man here is Lehmar.
		AI_Output (self, other, "DIA_Kardif_Buerger_14_02");	//The moneylender is not very popular, but he has gold, and other influential citizens owe him money.
		AI_Output (self, other, "DIA_Kardif_Buerger_14_03");	//The merchants and craftsmen also have a lot of influence - too much if you ask me.
		DIA_Kardif_Buerger_permanent = TRUE;
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Kardif_Lehmar(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 5;
	condition = DIA_Kardif_Lehmar_Condition;
	information = DIA_Kardif_Lehmar_Info;
	permanent = TRUE;
	description = "Who's in debt to Lehmar?";
};


var int DIA_Kardif_Lehmar_permanent;

func int DIA_Kardif_Lehmar_Condition()
{
	if((DIA_Kardif_Lehmar_permanent == FALSE) && (Kardif_OneQuestion == TRUE) && (DIA_Kardif_Buerger_permanent == TRUE) && (SchuldBuchNamesKnown == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Lehmar_Info()
{
	AI_Output(other,self,"DIA_Kardif_Add_15_00");	//Who's in debt to Lehmar?
	if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output (self, other, "DIA_Kardif_Add_14_01");	//(laughs) If you want to know that, you should take a look in his ledger.
		AI_Output (self, other, "DIA_Kardif_Add_14_02");	//Only it might be pretty difficult to do that without him noticing.
		AI_Output (self, other, "DIA_Kardif_Add_14_03");	//As far as I know, he always carries it with him...
		DIA_Kardif_Lehmar_permanent = TRUE;
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Kardif_Arbeit(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 5;
	condition = DIA_Kardif_Arbeit_Condition;
	information = DIA_Kardif_Arbeit_Info;
	permanent = TRUE;
	description = "Where can I find work?";
};


var int DIA_Kardif_Arbeit_permanent;

func int DIA_Kardif_Arbeit_Condition()
{
	if((DIA_Kardif_Arbeit_permanent == FALSE) && (Kardif_OneQuestion == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Arbeit_Info()
{
	AI_Output(other,self,"DIA_Kardif_Arbeit_15_00");	//Where can I find work?
	if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output (self, other, "DIA_Kardif_Arbeit_14_01");	//You're not likely to find work down here at the harbor. You need to go to the craftsmen in the lower part of town for that.
		AI_Output (self, other, "DIA_Kardif_Arbeit_14_02");	//But if you wield a decent blade, you could go challenge Alrik. He fights for gold, behind the warehouse.
		DIA_Kardif_Arbeit_permanent = TRUE;
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Addon_Kardif_MissingPeople(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 5;
	condition = DIA_Addon_Kardif_MissingPeople_Condition;
	information = DIA_Addon_Kardif_MissingPeople_Info;
	permanent = TRUE;
	description = "Что ты знаешь о пропавших горожанах?";
};


var int DIA_Addon_Kardif_MissingPeople_permanent;

func int DIA_Addon_Kardif_MissingPeople_Condition()
{
	if((DIA_Addon_Kardif_MissingPeople_permanent == FALSE) && (Kardif_OneQuestion == TRUE) && (SC_HearedAboutMissingPeople == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Kardif_MissingPeople_Info()
{
	AI_Output(other,self,"DIA_Addon_Kardif_MissingPeople_15_00");	//What do you know about the missing citizens?
	if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output (self, other, "DIA_Addon_Kardif_MissingPeople_14_01");	//All I know is that some people have vanished during the last few days.
		AI_Output (self, other, "DIA_Addon_Kardif_MissingPeople_14_02");	//It's especially bad down here at the harbor, they say. Maybe you should ask around here a bit.
		AI_Output (self, other, "DIA_Addon_Kardif_MissingPeople_14_03");	//There were some cases in the lower part of the city, too.
		AI_Output (self, other, "DIA_Addon_Kardif_MissingPeople_14_04");	//If you want to know more, you should talk to Coragon.
		AI_Output (self, other, "DIA_Addon_Kardif_MissingPeople_14_05");	//He has his pub in the lower part of town, and he's likely to hear a thing or two.
		if((Halvor_Ausgeliefert == FALSE) && !Npc_IsDead(Halvor))
		{
			AI_Output(self,other,"DIA_Addon_Kardif_MissingPeople_14_06");	//Halvor, the fish merchant down by the quay, might know something, too. Many people frequent him.
			B_LogEntry(TOPIC_Addon_WhoStolePeople,"Kardif says I should ask Coragon, the tavern landlord from the lower part of town, and Halvor the fishmonger at the harbor about the missing citizens.");
		}
		else
		{
			B_LogEntry(TOPIC_Addon_WhoStolePeople,"Kardif says I should ask Coragon, the tavern landlord from the lower part of town.");
		};
		Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
		DIA_Addon_Kardif_MissingPeople_permanent = TRUE;
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Kardif_Lernen(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 5;
	condition = DIA_Kardif_Lernen_Condition;
	information = DIA_Kardif_Lernen_Info;
	permanent = TRUE;
	description = "Who can teach me something here?";
};


var int DIA_Kardif_Lernen_permanent;

func int DIA_Kardif_Lernen_Condition()
{
	if((DIA_Kardif_Lernen_permanent == FALSE) && (Kardif_OneQuestion == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Lernen_Info()
{
	AI_Output(other,self,"DIA_Kardif_Lernen_15_00");	//Who can teach me something here?
	if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output (self, other, "DIA_Kardif_Lernen_14_01");	//There are a few competent people here in the harbor district.
		AI_Output (self, other, "DIA_Kardif_Lernen_14_02");	//Carl the blacksmith is a sturdy fellow. I bet he can show you how to get stronger.
		AI_Output (self, other, "DIA_Kardif_Lernen_14_03");	//Alrik knows a lot about fighting. And Lares is a cunning rogue. He's down here at the harbor sometimes as well.
		AI_Output (self, other, "DIA_Kardif_Lernen_14_04");	//And if you're crazy enough to go see old Ignaz - he knows all about aleche ... almich ... potions.
		AI_Output (other, self, "DIA_Kardif_Lernen_15_05");	//Where can I find all these people?
		AI_Output (self, other, "DIA_Kardif_Lernen_14_06");	//(groans) Boy, the King will have won his war against the orcs before I'm done explaining that to you.
		AI_Output (self, other, "DIA_Kardif_Lernen_14_07");	//Just look around the harbor district, and you're bound to find them. And if you don't know your way about, go to Brahim and buy yourself a map.
		AI_Output (self, other, "DIA_Kardif_Lernen_14_08");	//HE is easy to find. His hut is right next to my pub. (murmurs) I should have charged double for that one.
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		if(!Npc_KnowsInfo(other,DIA_Carl_Lernen))
		{
			B_LogEntry(TOPIC_CityTeacher,"Carl, the smith in the harbor district, can help me become stronger.");
		};
		if(Lares_TeachDEX == FALSE)
		{
			B_LogEntry(TOPIC_CityTeacher,"Lares can help me improve my dexterity.");
		};
		if(Alrik_Teach1H == FALSE)
		{
			B_LogEntry(TOPIC_CityTeacher,"Alrik can train me to fight with one-handed weapons. He hangs round behind the storehouse in the harbor district.");
		};
		if(Ignaz_TeachAlchemy == FALSE)
		{
			B_LogEntry(TOPIC_CityTeacher,"Ignaz can show me some recipes for brewing potions. He lives in the harbor district.");
		};
		if(!Npc_KnowsInfo(other,DIA_Brahim_GREET))
		{
			Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
			B_LogEntry(TOPIC_CityTrader,"Brahim draws and sells maps near the harbor.");
		};
		DIA_Kardif_Lernen_permanent = TRUE;
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Kardif_Diebeswerk(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 5;
	condition = DIA_Kardif_Diebeswerk_Condition;
	information = DIA_Kardif_Diebeswerk_Info;
	permanent = TRUE;
	description = "Is there any 'special' work to be had ...?";
};


var int DIA_Kardif_Diebeswerk_permanent;

func int DIA_Kardif_Diebeswerk_Condition()
{
	if((DIA_Kardif_Diebeswerk_permanent == FALSE) && (DIA_Kardif_Arbeit_permanent == TRUE) && (Kardif_OneQuestion == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Diebeswerk_Info()
{
	AI_Output(other,self,"DIA_Kardif_Diebeswerk_15_00");	//Is there any 'special' work to be had around here where I could make some quick money?
	if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output(self,other,"DIA_Kardif_Diebeswerk_14_01");	//Something special, you say? Hmmm...
		AI_PlayAni(self,"T_SEARCH");
		AI_Output(self,other,"DIA_Kardif_Diebeswerk_14_02");	//...go talk to Nagur then. Maybe he can help you.
		DIA_Kardif_Diebeswerk_permanent = TRUE;
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


var int DIA_Kardif_Diebeswerk2_permanent;

func void B_Kardif_AboutDaronChest()
{
		AI_Output (self, other, "DIA_Kardif_Diebeswerk2_14_03");	//Well, Zuris, the potion vendor in the marketplace, currently has a guest - Daron the Fire Magician.
		AI_Output (other, self, "DIA_Kardif_Diebeswerk2_15_04");	//And?
		AI_Output (self, other, "DIA_Kardif_Diebeswerk2_14_05");	//He had a new chest made specially for him by Thorben the carpenter.
		AI_Output (self, other, "DIA_Kardif_Diebeswerk2_14_06");	//They say that this Daron has brought a bunch of valuable stuff with him. But you didn't hear that from me, understand?
	DIA_Kardif_Diebeswerk2_permanent = TRUE;
};

instance DIA_Kardif_Diebeswerk2(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 5;
	condition = DIA_Kardif_Diebeswerk2_Condition;
	information = DIA_Kardif_Diebeswerk2_Info;
	permanent = TRUE;
	description = "Got anything 'special' for me to do?";
};


func int DIA_Kardif_Diebeswerk2_Condition()
{
//	if((DIA_Kardif_Diebeswerk2_permanent == FALSE) && (DIA_Kardif_Diebeswerk_permanent == TRUE) && (DIA_Kardif_Arbeit_permanent == TRUE) && (Kardif_OneQuestion == TRUE) && (other.guild != GIL_KDF) && (other.guild != GIL_NOV) && (other.guild != GIL_MIL) && (other.guild != GIL_PAL))
	if((DIA_Kardif_Diebeswerk2_permanent == FALSE) && (DIA_Kardif_Diebeswerk_permanent == TRUE) && (DIA_Kardif_Arbeit_permanent == TRUE) && (Kardif_OneQuestion == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Diebeswerk2_Info()
{
	AI_Output(other,self,"DIA_Kardif_Diebeswerk2_15_00");	//Got anything 'special' for me to do?
	if(Kardif_Busted == TRUE)
	{
		AI_Output(self,other,"DIA_Kardif_Crew_14_04");	//You're asking the wrong guy. I just run this pub.
	}
	else if((Npc_GetDistToWP(Martin,"NW_CITY_HABOUR_TAVERN01_04") < 700) && !Npc_IsDead(Martin))
	{
		AI_WaitTillEnd(self,other);
		AI_PlayAni(self,"T_SEARCH");
		AI_Output(self,other,"DIA_Kardif_Crew_14_04");	//You're asking the wrong guy. I just run this pub.
	}
	else if(Npc_KnowsInfo(other,DIA_Kardif_Zeichen) || B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		if(!Npc_KnowsInfo(other,DIA_Kardif_Zeichen))
		{
			AI_Output(self,other,"DIA_Kardif_Diebeswerk2_14_01");	//I've got something for you - but that should only interest you if you're a man of versatile talents.
			AI_Output(other,self,"DIA_Kardif_Diebeswerk2_15_02");	//What have you got?
		};
		B_Kardif_AboutDaronChest();
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Kardif_Zurueck(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 10;
	condition = DIA_Kardif_Zurueck_Condition;
	information = DIA_Kardif_Zurueck_Info;
	permanent = TRUE;
	description = Dialog_Back;
};


func int DIA_Kardif_Zurueck_Condition()
{
	if(Kardif_OneQuestion == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Kardif_Zurueck_Info()
{
	Kardif_OneQuestion = FALSE;
	Info_ClearChoices(DIA_Kardif_Zurueck);
};


instance DIA_Kardif_DOPE(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 5;
	condition = DIA_Kardif_DOPE_Condition;
	information = DIA_Kardif_DOPE_Info;
	permanent = TRUE;
	description = "Where can I buy weed here?";
};


var int DIA_Kardif_DOPE_perm;

func int DIA_Kardif_DOPE_Condition()
{
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == FALSE) && (Kardif_OneQuestion == TRUE) && (DIA_Kardif_DOPE_perm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_DOPE_Info()
{
	AI_Output(other,self,"DIA_Kardif_DOPE_15_01");	//Where can I buy weed here?
	if(Kardif_Busted == TRUE)
	{
		AI_Output(self,other,"DIA_Kardif_DOPE_14_00");	//Certainly not here - I've nothing to do with stuff like that.
		Undercover_Failed_Kardif = TRUE;
		B_CheckRedLightUndercover();
	}
	else if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output (self, other, "DIA_Kardif_DOPE_14_02");	//Certainly not here.
		AI_Output (other, self, "DIA_Kardif_DOPE_15_03");	//All right, where then?
		AI_Output (self, other, "DIA_Kardif_DOPE_14_04");	//I'd talk to Meldor if I were you - after all, he smokes all day.
		DIA_Kardif_DOPE_perm = TRUE;
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Kardif_Paket(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 3;
	condition = DIA_Kardif_Paket_Condition;
	information = DIA_Kardif_Paket_Info;
	permanent = TRUE;
	description = "What do you know about a package of swampweed?";
};


var int DIA_Kardif_Paket_perm;

func int DIA_Kardif_Paket_Condition()
{
	if((MIS_Andre_WAREHOUSE == LOG_Running) && (Kardif_OneQuestion == TRUE) && (DIA_Kardif_Paket_perm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Paket_Info()
{
	AI_Output(other,self,"DIA_Kardif_Paket_15_00");	//What do you know about a package of swampweed?
	if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output (self, other, "DIA_Kardif_Paket_14_01");	//Whoever owns such a package is a rich man. And probably a very relaxed man as well!
		AI_Output (other, self, "DIA_Kardif_Paket_15_02");	//Don't try to fool me. You know something. So spit it out!
		AI_Output (self, other, "DIA_Kardif_Paket_14_03");	//All right, all right - this fellow came to my pub the other day. One of the mercenaries.
		AI_Output (self, other, "DIA_Kardif_Paket_14_04");	//He said that he'd sold a package of swampweed at the harbor, but of course he was completely stoned. That's all I know.
		DIA_Kardif_Paket_perm = TRUE;
		B_LogEntry(TOPIC_Warehouse,"Kardif's been talking to a mercenary. The guy had a package of swampweed he was looking to sell.");
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Kardif_SENDATTILA(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 2;
	condition = DIA_Kardif_SENDATTILA_Condition;
	information = DIA_Kardif_SENDATTILA_Info;
	important = TRUE;
};


func int DIA_Kardif_SENDATTILA_Condition()
{
	if((MIS_ThiefGuild_sucked == TRUE) || (Diebesgilde_Okay >= 3) || (MIS_Nagur_Bote == LOG_FAILED) || ((Diebesgilde_Okay == 2) && (NagurHack == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Kardif_SENDATTILA_Info()
{
	AI_Output(self,other,"DIA_Kardif_SENDATTILA_14_00");	//Hey you, come over here. I've got something for you.
	AI_Output(self,other,"DIA_Kardif_SENDATTILA_14_01");	//There was a fellow here who insisted on talking to you.
	AI_Output(self,other,"DIA_Kardif_SENDATTILA_14_02");	//Since you weren't here, he told me to give you a message.
	AI_Output(self,other,"DIA_Kardif_SENDATTILA_14_03");	//He wants to meet you. Behind Halvor's fish shop.
	if(Kardif_Deal > 0)
	{
		AI_Output(self,other,"DIA_Kardif_SENDATTILA_14_04");	//This piece of information is free - but that's an exception, kid! Anything beyond that will cost you.
	};
	AI_Output(other,self,"DIA_Kardif_SENDATTILA_15_05");	//What did the guy look like?
	AI_Output(self,other,"DIA_Kardif_SENDATTILA_14_06");	//I could tell you that - but you need to pay for it, my friend. (grins)
	if(Kardif_Deal == 0)
	{
		AI_Output(self,other,"DIA_Kardif_Hallo_14_04");	//Every piece of information I give you will cost 10 gold pieces.
		Kardif_Deal = 10;
	};
	Wld_InsertNpc(VLK_494_Attila,"NW_CITY_HABOUR_POOR_AREA_BACK_ALLEY_02");
	B_InitNpcGlobals();
	if((NagurHack == TRUE) || (MIS_Nagur_Bote == LOG_FAILED))
	{
		MIS_ThiefGuild_sucked = TRUE;
	};
};


instance DIA_Kardif_Kerl(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 2;
	condition = DIA_Kardif_Kerl_Condition;
	information = DIA_Kardif_Kerl_Info;
	permanent = TRUE;
	description = "What did the guy look like?";
};


var int DIA_Kardif_Kerl_permanent;

func int DIA_Kardif_Kerl_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kardif_SENDATTILA) && (Attila.aivar[AIV_TalkedToPlayer] == FALSE) && !Npc_IsDead(Attila) && (Kardif_OneQuestion == TRUE) && (DIA_Kardif_Kerl_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Kerl_Info()
{
	AI_Output(other,self,"DIA_Kardif_Kerl_15_00");	//What did the guy look like?
	if(B_GiveInvItems(other,self,ItMi_Gold,Kardif_Deal))
	{
		AI_Output (self, other, "DIA_Kardif_Kerl_14_01");	//Well, rather tall, dark-skinned and strong - but no uniform. Somehow... menacing.
		AI_Output (other, self, "DIA_Kardif_Kerl_15_02");	//And his face?
		AI_Output (self, other, "DIA_Kardif_Kerl_14_03");	//His face? When he looked at me I was glad that it wasn't me he had come for.
		AI_Output (self, other, "DIA_Kardif_Kerl_14_04");	//There was something scary in his eyes - anyway, I think you should go see him. This is bound to be interesting.
		AI_Output (other, self, "DIA_Kardif_Kerl_15_05");	//Yeah... the question is, for whom...
		DIA_Kardif_Kerl_permanent = TRUE;
	}
	else
	{
		B_SayKardifZuwenigGold();
	};
};


instance DIA_Kardif_DEFEATEDATTILA(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 2;
	condition = DIA_Kardif_DEFEATEDATTILA_Condition;
	information = DIA_Kardif_DEFEATEDATTILA_Info;
	permanent = FALSE;
	description = "That bastard tried to kill me!";
};


func int DIA_Kardif_DEFEATEDATTILA_Condition()
{
	if((Kardif_OneQuestion == FALSE) && Npc_KnowsInfo(other,DIA_Attila_Hallo) && (!Npc_HasItems(Attila,ItKe_ThiefGuildKey_MIS) || (Npc_GetDistToWP(Attila,"NW_CITY_KARDIF") > 2000) || Npc_IsDead(Attila)))
	{
		return TRUE;
	};
};

func void DIA_Kardif_DEFEATEDATTILA_Info()
{
	AI_Output (other, self, "DIA_Kardif_DEFEATEDATTILA_15_00");	//That bastard tried to kill me!
	AI_Output (self, other, "DIA_Kardif_DEFEATEDATTILA_14_01");	//Hey, how would that be my fault? All I did was pass on some information.
	AI_Output (self, other, "DIA_Kardif_DEFEATEDATTILA_14_02");	//If anyone is determined to step on your toes, I guess he'll have his reasons.
	B_GivePlayerXP(XP_Kardif_Blame4Attila);
//	B_KillNpc(VLK_494_Attila);
//	Npc_RemoveInvItem(Attila,ItMi_OldCoin);
};


instance DIA_Kardif_Zeichen(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 800;
	condition = DIA_Kardif_Zeichen_Condition;
	information = DIA_Kardif_Zeichen_Info;
	permanent = FALSE;
	description = DIALOG_SecretSign;
};


func int DIA_Kardif_Zeichen_Condition()
{
	if((Kardif_OneQuestion == FALSE) && (Knows_SecretSign == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Zeichen_Info()
{
	AI_PlayAni(other,"T_YES");
	AI_Output(self,other,"DIA_Kardif_Zeichen_14_00");	//Ah, you're involved with the gang. All right. In that case, I've got something for you.
	AI_Output(self,other,"DIA_Kardif_Zeichen_14_01");	//(quietly) If you ever need some lock picks, come to me. I still have a few around. Just ask me for something to drink.
	if(DIA_Kardif_Diebeswerk2_permanent == FALSE)
	{
		if((Npc_GetDistToWP(Martin,"NW_CITY_HABOUR_TAVERN01_04") >= 700) && !Npc_IsDead(Martin))
		{
			AI_Output(other,self,"DIA_Kardif_Diebeswerk2_15_00");	//Got anything 'special' for me to do?
			B_Kardif_AboutDaronChest();
		};
	};
	CreateInvItems(self,ItKe_Lockpick,20);
	Kardif_Busted = FALSE;
};


instance DIA_Kardif_Crew(C_Info)
{
	npc = VLK_431_Kardif;
	nr = 51;
	condition = DIA_Kardif_Crew_Condition;
	information = DIA_Kardif_Crew_Info;
	permanent = FALSE;
	description = "I still need a few sailors.";
};


func int DIA_Kardif_Crew_Condition()
{
	if((Kardif_OneQuestion == FALSE) && (MIS_SCKnowsWayToIrdorath == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Kardif_Crew_Info()
{
	AI_Output (other, self, "DIA_Kardif_Crew_15_00");	//I still need a few sailors.
	AI_Output (self, other, "DIA_Kardif_Crew_14_01");	//Bad times, my friend. You won't find enough sailors in all of Khorinis. Most of them have left the city.
	AI_Output (self, other, "DIA_Kardif_Crew_14_02");	//But with a good captain, it shouldn't be too hard to find yourself a few bright lads and make them into a decent crew before too long.
	if(SCGotCaptain == FALSE)
	{
	AI_Output (other, self, "DIA_Kardif_Crew_15_03");	//Where can I find a captain?
	AI_Output (self, other, "DIA_Kardif_Crew_14_04");	//You're asking the wrong guy. I just run this pub.
		if(!Npc_IsDead(Jack))
		{
			AI_Output(self,other,"DIA_Kardif_Crew_14_05");	//Go talk to Old Jack. He's been hanging around this harbor for as long as I can think. When it comes to seafaring, he's your man.
			if(MIS_Jack_NewLighthouseOfficer == FALSE)
			{
				B_LogEntry(Topic_Captain,"Kardif sent me to old Jack. Apparently, he should be able to help me.");
			};
		};
	};
};


