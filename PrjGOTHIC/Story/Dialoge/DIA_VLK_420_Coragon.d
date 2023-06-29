
instance DIA_Coragon_EXIT(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 999;
	condition = DIA_Coragon_EXIT_Condition;
	information = DIA_Coragon_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Coragon_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Coragon_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Coragon_PICKPOCKET(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 900;
	condition = DIA_Coragon_PICKPOCKET_Condition;
	information = DIA_Coragon_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Coragon_PICKPOCKET_Condition()
{
	return C_Beklauen(40,45);
};

func void DIA_Coragon_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Coragon_PICKPOCKET);
	Info_AddChoice(DIA_Coragon_PICKPOCKET,Dialog_Back,DIA_Coragon_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Coragon_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Coragon_PICKPOCKET_DoIt);
};

func void DIA_Coragon_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Coragon_PICKPOCKET);
};

func void DIA_Coragon_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Coragon_PICKPOCKET);
};


instance DIA_Coragon_HALLO(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 2;
	condition = DIA_Coragon_HALLO_Condition;
	information = DIA_Coragon_HALLO_Info;
	permanent = FALSE;
	description = "Can I get a drink here?";
};


func int DIA_Coragon_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Coragon_HALLO_Info()
{
	AI_Output (other, self, "DIA_Coragon_HALLO_15_00");	//Can I get a drink here?
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_00");	//If you have gold, you can even eat here if you like.
	Log_CreateTopic (TOPIC_CityTrader, LOG_NOTE);
	B_LogEntry (TOPIC_CityTrader, "I can buy food and drink from the inn keeper Coragon.");
};


instance DIA_Coragon_Trade(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 2;
	condition = DIA_Coragon_Trade_Condition;
	information = DIA_Coragon_Trade_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Coragon_Trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Coragon_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Coragon_Trade_Info()
{
	AI_Output(other,self,"DIA_Coragon_Trade_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Coragon_WhatsUp(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 3;
	condition = DIA_Coragon_WhatsUp_Condition;
	information = DIA_Coragon_WhatsUp_Info;
	permanent = FALSE;
	description = "And, how's business going?";
};


func int DIA_Coragon_WhatsUp_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Coragon_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Coragon_WhatsUp_Info()
{
	AI_Output (other, self, "DIA_Coragon_Gelaber_15_00");	//And, how's business going?
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_01");	//Ah, don't remind me. Lord Andre is serving free beer at the gallows square.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_02");	//Hardly anybody comes here now except for the rich people from the upper quarter.
	AI_Output (other, self, "DIA_Coragon_Add_15_03");	//What's wrong with them?
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_04");	//(laughs) Some of those swells can really get on your nerves.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_05");	//Take that Valentino, for instance - I can't stand the sight of him.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_06");	//But I can't pick my customers. I need every coin I can make.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_07");	//What little I had managed to save has been stolen, along with all my silver.
};


instance DIA_Addon_Coragon_MissingPeople(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 5;
	condition = DIA_Addon_Coragon_MissingPeople_Condition;
	information = DIA_Addon_Coragon_MissingPeople_Info;
	description = "Tell me about the missing townspeople.";
};


func int DIA_Addon_Coragon_MissingPeople_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Coragon_HALLO) && (SC_HearedAboutMissingPeople == TRUE) && (MissingPeopleReturnedHome == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Coragon_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Coragon_MissingPeople_15_00");	//Tell me about the missing townspeople.
	AI_Output (self, other, "DIA_Addon_Coragon_MissingPeople_09_01");	//I heard that a lot of them went missing down by the harbor. Small wonder with all that's going on down there.
	AI_Output (self, other, "DIA_Addon_Coragon_MissingPeople_09_02");	//Even Thorben, the carpenter in the lower part of town, has lost his apprentice.
	AI_Output (self, other, "DIA_Addon_Coragon_MissingPeople_09_03");	//Hakon, one of the merchants in the marketplace, had an especially strange tale to tell.
	AI_Output (self, other, "DIA_Addon_Coragon_MissingPeople_09_04");	//He said that there was this fellow he used to bump into every day, and then suddenly he vanished off the face of the earth. He even went to see the militia about it.
	AI_Output (self, other, "DIA_Addon_Coragon_MissingPeople_09_05");	//The townspeople all pretty much panicked after that. I don't know what to make of it. I think it's all nonsense.
	AI_Output (self, other, "DIA_Addon_Coragon_MissingPeople_09_06");	//Khorinis is a rough city, and many dangers lurk outside her gates.
	AI_Output (self, other, "DIA_Addon_Coragon_MissingPeople_09_07");	//Those who don't stay within the city walls will be attacked by bandits or eaten by wild animals. It's that simple.
	Log_CreateTopic (TOPIC_Addon_WhoStolePeople, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_WhoStolePeople, LOG_Running);
	B_LogEntry (TOPIC_Addon_WhoStolePeople, "Hakon, a trader in the marketplace, and Thorben the carpenter should both know something about the missing people.");
};


instance DIA_Coragon_Bestohlen(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 4;
	condition = DIA_Coragon_Bestohlen_Condition;
	information = DIA_Coragon_Bestohlen_Info;
	permanent = FALSE;
	description = "Somebody stole from you?";
};


func int DIA_Coragon_Bestohlen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Coragon_WhatsUp))
	{
		return TRUE;
	};
};

func void DIA_Coragon_Bestohlen_Info()
{
	AI_Output (other, self, "DIA_Coragon_Add_15_08");	//You've been robbed?
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_09");	//Yes, some time ago. It was still rather crowded that night, and I was doing the round serving beer.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_10");	//I wasn't gone long from behind the counter - but it was long enough for those bastards.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_11");	//I went to see the militia about it - but they couldn't find a thing, of course. They prefer to get plastered on free beer.
	MIS_Coragon_Silber = LOG_Running;
};


var int Coragon_Bier;

func void B_Coragon_Bier()
{
	Coragon_Bier += 1;
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_14");	//Here - take this as a reward.
	B_GiveInvItems(self,other,ItFo_CoragonsBeer,1);
	if(Coragon_Bier < 2)
	{
		AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_21");	//A very special beer. This is my last keg.
	}
	else
	{
		AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_22");	//It's the very last drop!
	};
};


instance DIA_Coragon_BringSilber(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 5;
	condition = DIA_Coragon_BringSilber_Condition;
	information = DIA_Coragon_BringSilber_Info;
	permanent = FALSE;
	description = "I've got your silver.";
};


func int DIA_Coragon_BringSilber_Condition()
{
	if((MIS_Coragon_Silber == LOG_Running) && (Npc_HasItems(other,ItMi_CoragonsSilber) >= 8))
	{
		return TRUE;
	};
};

func void DIA_Coragon_BringSilber_Info()
{
	AI_Output(other,self,"DIA_Coragon_Add_15_12");	//I've got your silver.
	B_GiveInvItems(other,self,ItMi_CoragonsSilber,8);
	Npc_RemoveInvItems(self,ItMi_CoragonsSilber,8);
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_13");	//Really!
	B_GivePlayerXP(XP_CoragonsSilber);
	B_Coragon_Bier();
	MIS_Coragon_Silber = LOG_SUCCESS;
};


instance DIA_Coragon_Schuldenbuch(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 6;
	condition = DIA_Coragon_Schuldenbuch_Condition;
	information = DIA_Coragon_Schuldenbuch_Info;
	permanent = FALSE;
	description = "Look what I have here...";
};


func int DIA_Coragon_Schuldenbuch_Condition()
{
	if(Npc_HasItems(other,ItWr_Schuldenbuch) && (SchuldBuchNamesKnown == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Coragon_Schuldenbuch_Info()
{
	DIA_Common_LookWhatIGot();
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_16");	//Mmm? (surprised) But this is Lehmar's ledger!
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_17");	//What are you planning to do with that?
};


instance DIA_Coragon_GiveBook(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 7;
	condition = DIA_Coragon_GiveBook_Condition;
	information = DIA_Coragon_GiveBook_Info;
	permanent = FALSE;
	description = "Here is the book.";
};


func int DIA_Coragon_GiveBook_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Coragon_Schuldenbuch) && Npc_HasItems(other,ItWr_Schuldenbuch))
	{
		return TRUE;
	};
};

func void DIA_Coragon_GiveBook_Info()
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
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_19");	//Thanks! You saved my butt. Lehmar can get rather ugly.
	B_GivePlayerXP(XP_Schuldenbuch);
	B_Coragon_Bier();
};


instance DIA_Coragon_ToOV(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 9;
	condition = DIA_Coragon_ToOV_Condition;
	information = DIA_Coragon_ToOV_Info;
	permanent = FALSE;
	description = "What do I have to do to get into the upper quarter?";
};


func int DIA_Coragon_ToOV_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Coragon_WhatsUp) && (other.guild == GIL_NONE) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Coragon_ToOV_Info()
{
	AI_Output (other, self, "DIA_Coragon_Add_15_23");	//What do I have to do to get into the upper quarter?
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_24");	//You need to be a citizen of the town. Go find some work.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_25");	//Preferably with the craftsmen in the lower part of town. That would make you a citizen.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_26");	//Well, and if that's still not enough, go talk to Lord Andre at the barracks.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_27");	//Maybe he'll let you join the city guard. They can go into the upper quarter, too.
};


instance DIA_Coragon_Valentino(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 8;
	condition = DIA_Coragon_Valentino_Condition;
	information = DIA_Coragon_Valentino_Info;
	permanent = FALSE;
	description = "What is it with this Valentino?";
};


func int DIA_Coragon_Valentino_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Coragon_WhatsUp))
	{
		return TRUE;
	};
};

func void DIA_Coragon_Valentino_Info()
{
	AI_Output (other, self, "DIA_Coragon_Add_15_28");	//What is it with this Valentino?
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_29");	//He's filthy rich and has no need to work. And he brags about it to everyone.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_30");	//Whether you want to hear it or not.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_31");	//He drinks a lot and always stays until the end - then, early in the morning, he totters back to the upper quarter.
	AI_Output (self, other, "DIA_ADDON_NEW_Coragon_Add_09_32");	//It's the same every day.
};


instance DIA_Coragon_News(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 1;
	condition = DIA_Coragon_News_Condition;
	information = DIA_Coragon_News_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Coragon_News_Condition()
{
//	if(!Npc_IsDead(Valentino) && (Valentino.aivar[AIV_DefeatedByPlayer] == TRUE) && Npc_KnowsInfo(other,DIA_Regis_Valentino) && (Valentino_Day < Wld_GetDay()))
	if(!Npc_IsDead(Valentino) && (Valentino.aivar[AIV_DefeatedByPlayer] == TRUE) && (Valentino_Day < Wld_GetDay()))
	{
		return TRUE;
	};
};

func void DIA_Coragon_News_Info()
{
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_33");	//Valentino was unable to pay his bar tab last night.
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_35");	//And right before that, he had been crowing about how much money he had.
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_36");	//Then he put his hand in his pocket and made a funny face. He said he had been robbed...
	AI_Output(other,self,"DIA_Coragon_Add_15_37");	//And? What did you do?
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_38");	//Well, I gave him a good thrashing, what else?
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_34");	//He was blathering something about having being robbed, and paying me later... Really!
	if(Npc_HasItems(Valentino,ItMi_Gold) > 0)
	{
		Npc_RemoveInvItems(Valentino,ItMi_Gold,Npc_HasItems(Valentino,ItMi_Gold));
	};
};


instance DIA_Coragon_Ring(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 10;
	condition = DIA_Coragon_Ring_Condition;
	information = DIA_Coragon_Ring_Info;
	permanent = FALSE;
	description = "Here - take this ring.";
};


func int DIA_Coragon_Ring_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Coragon_News) && Npc_HasItems(other,ItRi_Prot_Edge_01_Valentino))
	{
		return TRUE;
	};
};

func void DIA_Coragon_Ring_Info()
{
	AI_Output(other,self,"DIA_Coragon_Add_15_39");	//Here - take this ring.
	B_GiveInvItems(other,self,ItRi_Prot_Edge_01_Valentino,1);
	Npc_RemoveInvItems(self,ItRi_Prot_Edge_01_Valentino,1);
	AI_Output(self,other,"DIA_ADDON_NEW_Coragon_Add_09_40");	//What? I don't understand...
	AI_Output(other,self,"DIA_Coragon_Add_15_41");	//It used to belong to Valentino.
	AI_Output(other,self,"DIA_Coragon_Add_15_42");	//You're welcome to pass it on to the next person who tans his hide...
	B_GivePlayerXP(300);
};

instance DIA_Coragon_PICKPOCKET_Book(C_Info)
{
	npc = VLK_420_Coragon;
	nr = 700;
	condition = DIA_Coragon_PICKPOCKET_Book_Condition;
	information = DIA_Coragon_PICKPOCKET_Book_Info;
	permanent = TRUE;
	description = "(It would be simple to steal his book.)";
};


func int DIA_Coragon_PICKPOCKET_Book_Condition()
{
	if((ClassicLehmarBook == FALSE) && (SchuldBuch_Stolen_Coragon == FALSE) && Npc_KnowsInfo(other,DIA_Coragon_GiveBook) && Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) && (other.attribute[ATR_DEXTERITY] >= 30))
	{
		return TRUE;
	};
};

func void DIA_Coragon_PICKPOCKET_Book_Info()
{
	Info_ClearChoices(DIA_Coragon_PICKPOCKET_Book);
	Info_AddChoice(DIA_Coragon_PICKPOCKET_Book,Dialog_Back,DIA_Coragon_PICKPOCKET_Book_BACK);
	Info_AddChoice(DIA_Coragon_PICKPOCKET_Book,DIALOG_PICKPOCKET,DIA_Coragon_PICKPOCKET_Book_DoIt);
};

func void DIA_Coragon_PICKPOCKET_Book_DoIt()
{
	if(other.attribute[ATR_DEXTERITY] >= 40)
	{
		CreateInvItem(other,ItWr_Schuldenbuch);
		AI_PrintScreen("Received: Book of Debts",-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
		B_GiveThiefXP();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Coragon",PRINT_PickPocketSuccess));
		SchuldBuch_Stolen_Coragon = TRUE;
	}
	else
	{
		B_ResetThiefLevel();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Coragon",PRINT_PickPocketFailed));
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_Theft,1);
	};
	Info_ClearChoices(DIA_Coragon_PICKPOCKET_Book);
};

func void DIA_Coragon_PICKPOCKET_Book_BACK()
{
	Info_ClearChoices(DIA_Coragon_PICKPOCKET_Book);
};

