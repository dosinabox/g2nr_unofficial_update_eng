
instance DIA_Halvor_EXIT(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 999;
	condition = DIA_Halvor_EXIT_Condition;
	information = DIA_Halvor_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Halvor_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Halvor_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Halvor_PICKPOCKET(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 900;
	condition = DIA_Halvor_PICKPOCKET_Condition;
	information = DIA_Halvor_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Halvor_PICKPOCKET_Condition()
{
	return C_Beklauen(78,150);
};

func void DIA_Halvor_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Halvor_PICKPOCKET);
	Info_AddChoice(DIA_Halvor_PICKPOCKET,Dialog_Back,DIA_Halvor_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Halvor_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Halvor_PICKPOCKET_DoIt);
};

func void DIA_Halvor_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Halvor_PICKPOCKET);
};

func void DIA_Halvor_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Halvor_PICKPOCKET);
};

////////////////////////////////////////

instance DIA_Halvor_InPrison(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 2;
	condition = DIA_Halvor_InPrison_Condition;
	information = DIA_Halvor_InPrison_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Halvor_InPrison_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Halvor_Ausgeliefert == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Halvor_InPrison_Info()
{
	AI_Output(self,other,"DIA_Halvor_MESSAGE_PRISON_06_03");	//You'll regret this.
	AI_StopProcessInfos(self);
};

////////////////////////////////////////

instance DIA_Halvor_Hallo(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 2;
	condition = DIA_Halvor_Hallo_Condition;
	information = DIA_Halvor_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Halvor_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && Wld_IsTime(5,0,20,0) && (Halvor_Ausgeliefert == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Halvor_Hallo_Info()
{
	AI_Output(self,other,"DIA_Halvor_Hallo_06_00");	//Hey, do you need fish? Get your fish here, fresh from the depths of the sea!
	Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
	B_LogEntry(TOPIC_CityTrader,"Halvor sells fish at the harbor.");
};


instance DIA_Halvor_TRADE(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 2;
	condition = DIA_Halvor_TRADE_Condition;
	information = DIA_Halvor_TRADE_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "Покажи мне свою рыбу.";
};


func int DIA_Halvor_TRADE_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Halvor_Hallo) && Wld_IsTime(5,0,20,0) && (Halvor_Ausgeliefert == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Halvor_TRADE_Info()
{
	AI_Output(other,self,"DIA_Halvor_TRADE_15_00");	//Show me your fish.
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Halvor_Night(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 2;
	condition = DIA_Halvor_Night_Condition;
	information = DIA_Halvor_Night_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Halvor_Night_Condition()
{
	if(Wld_IsTime(20,0,5,0) && Npc_IsInState(self,ZS_Talk) && (Halvor_Ausgeliefert == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Halvor_Night_Info()
{
	if(Wld_IsTime(20,0,0,0))
	{
		AI_Output(self,other,"DIA_Halvor_Night_06_00");	//Hey, if you want to buy fish, come to my booth tomorrow, OK?
	}
	else
	{
		B_Say(self,other,"$NOTNOW");
	};
};

instance DIA_Addon_Halvor_MissingPeople(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 5;
	condition = DIA_Addon_Halvor_MissingPeople_Condition;
	information = DIA_Addon_Halvor_MissingPeople_Info;
	description = "Can you tell me something about those missing people?";
};


func int DIA_Addon_Halvor_MissingPeople_Condition()
{
	if((SC_HearedAboutMissingPeople == TRUE) && (MissingPeopleReturnedHome == FALSE) && (Halvor_Ausgeliefert == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Halvor_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Halvor_MissingPeople_15_00");	//Can you tell me something about those missing people?
	AI_Output (self, other, "DIA_Addon_Halvor_MissingPeople_06_01");	//Missing people? This is a harbor, pal. Things like that are bound to happen.
	AI_Output (self, other, "DIA_Addon_Halvor_MissingPeople_06_02");	//The sea is treacherous, and bound to claim a life now and then.
	AI_Output (self, other, "DIA_Addon_Halvor_MissingPeople_06_03");	//Captains of large vessels will always sign on new sailors in large seaports such as Khorinis to complete their crews.
	AI_Output (self, other, "DIA_Addon_Halvor_MissingPeople_06_04");	//And if they don't find any volunteers, some people may get dragged off against their will. And then they're gone.
	Info_ClearChoices (DIA_Addon_Halvor_MissingPeople);
	Info_AddChoice (DIA_Addon_Halvor_MissingPeople, Dialog_Back, DIA_Addon_Halvor_MissingPeople_Back);
	Info_AddChoice (DIA_Addon_Halvor_MissingPeople, "What ship would that have been?", DIA_Addon_Halvor_MissingPeople_schiff);
	Info_AddChoice (DIA_Addon_Halvor_MissingPeople, "Do you know of anyone who's missing?", DIA_Addon_Halvor_MissingPeople_wer);
	Info_AddChoice (DIA_Addon_Halvor_MissingPeople, "Are YOU missing someone?", DIA_Addon_Halvor_MissingPeople_you);
};

func void DIA_Addon_Halvor_MissingPeople_Back()
{
	Info_ClearChoices(DIA_Addon_Halvor_MissingPeople);
};

func void DIA_Addon_Halvor_MissingPeople_wer()
{
	AI_Output (other, self, "DIA_Addon_Halvor_MissingPeople_wer_15_00");	//Do you know of anyone who's missing?
	AI_Output (self, other, "DIA_Addon_Halvor_MissingPeople_wer_06_01");	//No idea. Ask the ship builders.
	Log_CreateTopic (TOPIC_Addon_WhoStolePeople, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_WhoStolePeople, LOG_Running);
	B_LogEntry (TOPIC_Addon_WhoStolePeople, "The best advice Halvor the fishmonger could give me was to go ask the ship builders.");
};

func void DIA_Addon_Halvor_MissingPeople_schiff()
{
	AI_Output (other, self, "DIA_Addon_Halvor_MissingPeople_schiff_15_00");	//What ship would that have been?
	AI_Output (self, other, "DIA_Addon_Halvor_MissingPeople_schiff_06_01");	//Good question. Not many ships have come into Khorinis lately, that's true.
};

func void DIA_Addon_Halvor_MissingPeople_you()
{
	AI_Output (other, self, "DIA_Addon_Halvor_MissingPeople_you_15_00");	//Are YOU missing someone?
	AI_Output (self, other, "DIA_Addon_Halvor_MissingPeople_you_06_01");	//Me? No.
};


instance DIA_Halvor_MESSAGE(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 2;
	condition = DIA_Halvor_MESSAGE_Condition;
	information = DIA_Halvor_MESSAGE_Info;
	permanent = FALSE;
	description = "I think this piece of paper belongs to you ...";
	trade = FALSE;
};


func int DIA_Halvor_MESSAGE_Condition()
{
	if(Npc_HasItems(other,ItWr_HalvorMessage) && (Knows_Halvor == TRUE) && (Halvor_Ausgeliefert == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Halvor_MESSAGE_Info()
{
	AI_Output (other, self, "DIA_Halvor_MESSAGE_15_00");	//I think this piece of paper belongs to you ...
	AI_Output (self, other, "DIA_Halvor_MESSAGE_06_01");	//What...? Let me see.
	DIA_Common_NotSoFastMyFriend();
//	B_UseFakeScroll();
	AI_Output (self, other, "DIA_Halvor_MESSAGE_06_02");	//(sweating) Er... OK, let's stay calm about this - er ... listen. I have resold the goods I got from the bandits.
	AI_Output (self, other, "DIA_Halvor_MESSAGE_06_03");	//(hastily) But there's no reason to take this straight to the militia, right? I'm sure we can come to an understanding, can't we?
	Info_ClearChoices (DIA_Halvor_MESSAGE);
	Info_AddChoice (DIA_Halvor_MESSAGE, "Make me an offer, then.", DIA_Halvor_MESSAGE_OFFER);
	Info_AddChoice (DIA_Halvor_MESSAGE, "Looks like it's the slammer for you.", DIA_Halvor_MESSAGE_PRISON);
};

func void DIA_Halvor_MESSAGE_OFFER()
{
	AI_Output (other, self, "DIA_Halvor_MESSAGE_OFFER_15_00");	//Make me an offer, then.
	AI_Output (self, other, "DIA_Halvor_MESSAGE_OFFER_06_01");	//All right. I'll tell you something. I can sell you more than just fish.
	AI_Output (self, other, "DIA_Halvor_MESSAGE_OFFER_06_03");	//If you hand me this ridiculous piece of paper and, er ... forget about the matter, you and I can become the best of trading partners.
	Info_ClearChoices (DIA_Halvor_MESSAGE);
	Info_AddChoice (DIA_Halvor_MESSAGE, "All right, agreed.", DIA_Halvor_MESSAGE_Okay);
	Info_AddChoice (DIA_Halvor_MESSAGE, "Looks like it's the slammer for you.", DIA_Halvor_MESSAGE_PRISON);
	Info_AddChoice (DIA_Halvor_MESSAGE, "Oh really? What kind of goods would those be?", DIA_Halvor_MESSAGE_DEAL);
};

func void DIA_Halvor_MESSAGE_PRISON()
{
	AI_Output (other, self, "DIA_Halvor_MESSAGE_PRISON_15_00");	//Looks like it's the slammer for you.
	AI_Output (self, other, "DIA_Halvor_MESSAGE_PRISON_06_01");	//No, wait, you can't do that! After all, I'm nothing but ... you know ... small fry.
	AI_Output (other, self, "DIA_Halvor_MESSAGE_PRISON_15_02");	//You should have thought of that sooner. Now I'm going to report you to Lord Andre.
	AI_Output (self, other, "DIA_Halvor_MESSAGE_PRISON_06_03");	//You'll regret this.
	Betrayal_Halvor = TRUE;
	AI_StopProcessInfos(self);
};

func void DIA_Halvor_MESSAGE_DEAL()
{
	AI_Output (other, self, "DIA_Halvor_MESSAGE_DEAL_15_00");	//Oh really? What kind of goods would those be?
	AI_Output (self, other, "DIA_Halvor_MESSAGE_DEAL_06_01");	//Well, I could offer you ... quite special fish, you see. Not just plain ones for eating.
	AI_Output (other, self, "DIA_Halvor_MESSAGE_DEAL_15_02");	//You mean like the one that contained your hidden message?
	AI_Output (self, other, "DIA_Halvor_MESSAGE_DEAL_06_03");	//You've got it. I have several of those ... fish.
};

func void DIA_Halvor_MESSAGE_Okay()
{
	AI_Output (other, self, "DIA_Halvor_MESSAGE_Okay_15_00");	//All right, it's a deal. I think we can keep this little matter between ourselves.
	AI_Output (self, other, "DIA_Halvor_MESSAGE_Okay_06_01");	//Thank you. Just drop in the next time you happen to be in the vicinity. I'm bound to have some interesting things for you.
	B_GiveInvItems(other,self,ItWr_HalvorMessage,1);
	Npc_RemoveInvItems(self,ItWr_HalvorMessage,1);
//	Halvor_Deal = TRUE;
	Diebesgilde_Okay += 1;
	CreateInvItems(self,ItSe_ErzFisch,1);
	CreateInvItems(self,ItSe_GoldFisch,1);
	CreateInvItems(self,ItSe_RingFisch,1);
	CreateInvItems(self,ItSe_LockpickFisch,1);
	Info_ClearChoices(DIA_Halvor_MESSAGE);
};


instance DIA_Halvor_Zeichen(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 800;
	condition = DIA_Halvor_Zeichen_Condition;
	information = DIA_Halvor_Zeichen_Info;
	permanent = FALSE;
	description = DIALOG_SecretSign;
};


func int DIA_Halvor_Zeichen_Condition()
{
	if((Knows_SecretSign == TRUE) && (Betrayal_Halvor == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Halvor_Zeichen_Info()
{
	AI_PlayAni(other,"T_YES");
	AI_Output (self, other, "DIA_Halvor_Zeichen_06_00");	//I see. You haven't come just to buy fish.
	AI_Output (self, other, "DIA_Halvor_Zeichen_06_01");	//(quietly) I'll make you an offer. If you have any silver plates or chalices - I'll take them for a good price.
	CreateInvItems(self,ItKe_Lockpick,20);
	B_LogEntry(Topic_Diebesgilde,"Halvor will buy silver plates and chalices for a better price than any other merchant.");
};


instance DIA_Halvor_Hehlerei(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 2;
	condition = DIA_Halvor_Hehlerei_Condition;
	information = DIA_Halvor_Hehlerei_Info;
	permanent = TRUE;
	description = "(Sell all plates and chalices)";
};


func int DIA_Halvor_Hehlerei_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Halvor_Zeichen) && (Betrayal_Halvor == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Halvor_Hehlerei_Info()
{
	DIA_Common_LookWhatIGot();
	Halvor_Score = 0;
	if(Halvor_Day != Wld_GetDay())
	{
		if(Npc_HasItems(other,ItMi_SilverPlate) || Npc_HasItems(other,ItMi_SilverCup))
		{
			Halvor_Score = (Npc_HasItems(other,ItMi_SilverPlate) * (Value_SilverPlate / 2)) + (Npc_HasItems(other,ItMi_SilverCup) * (Value_SilverCup / 2));
			if(Halvor_Score <= 1000)
			{
				AI_Output (self, other, "DIA_Halvor_Zeichen_06_05");	//For all your stuff, I'll give you ...
				B_Say_Gold (self, other, Halvor_Score);
				Info_ClearChoices (DIA_Halvor_Hehlerei);
				Info_AddChoice (DIA_Halvor_Hehlerei, "All right, sold.", DIA_Halvor_Hehlerei_Annehmen);
				Info_AddChoice (DIA_Halvor_Hehlerei, "I'll think about it.", DIA_Halvor_Hehlerei_Ablehnen);
			}
			else
			{
				AI_Output (self, other, "DIA_Halvor_Zeichen_06_06");	//You brought too much stuff. I can't give you that much gold all at once.
				Info_ClearChoices (DIA_Halvor_Hehlerei);
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Halvor_Zeichen_06_02");	//Come back when you have some silver plates or chalices.
			Info_ClearChoices (DIA_Halvor_Hehlerei);
		};
	}
	else if(Wld_GetDay() == 0)
	{
		AI_Output (self, other, "DIA_Halvor_Zeichen_06_03");	//You can get rid of your silver here tomorrow. Today's too early.
	}
	else
	{
		AI_Output (self, other, "DIA_Halvor_Zeichen_06_04");	//Sorry, no more business for today. Come back tomorrow, OK?
	};
};

func void DIA_Halvor_Hehlerei_Annehmen()
{
	var int amount;
	var string concatText;
	amount = Npc_HasItems(other,ItMi_SilverPlate) + Npc_HasItems(other,ItMi_SilverCup);
	concatText = ConcatStrings(IntToString(amount),PRINT_ItemsGiven);
	AI_PrintScreen(concatText,-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	Npc_RemoveInvItems(other,ItMi_SilverCup,Npc_HasItems(other,ItMi_SilverCup));
	Npc_RemoveInvItems(other,ItMi_SilverPlate,Npc_HasItems(other,ItMi_SilverPlate));
	B_GiveInvItems(self,other,ItMi_Gold,Halvor_Score);
	AI_Output (other, self, "DIA_Halvor_Zeichen_Annehmen_15_00");	//All right, sold.
	AI_Output (self, other, "DIA_Halvor_Zeichen_Annehmen_06_01");	//We've made some good deals today. Better not come back until tomorrow, or somebody might get suspicious, you see?
	Halvor_Day = Wld_GetDay();
	Info_ClearChoices(DIA_Halvor_Hehlerei);
};

func void DIA_Halvor_Hehlerei_Ablehnen()
{
	DIA_Common_IWillThinkAboutIt();
	Info_ClearChoices(DIA_Halvor_Hehlerei);
};


instance DIA_Halvor_Crew(C_Info)
{
	npc = VLK_469_Halvor;
	nr = 51;
	condition = DIA_Halvor_Crew_Condition;
	information = DIA_Halvor_Crew_Info;
	permanent = FALSE;
	description = "I'm looking for a crew.";
};


func int DIA_Halvor_Crew_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (Halvor_Ausgeliefert == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Halvor_Crew_Info()
{
	AI_Output(other,self,"DIA_Halvor_Crew_15_00");	//I'm looking for a crew.
	if(Betrayal_Halvor == FALSE)
	{
		AI_Output(self,other,"DIA_Halvor_Crew_06_01");	//But how are you planning to leave here?
		Info_ClearChoices(DIA_Halvor_Crew);
		Info_AddChoice(DIA_Halvor_Crew,"That's my own business.",DIA_Halvor_Crew_MyThing);
		Info_AddChoice(DIA_Halvor_Crew,"I'm going to appropriate a ship.",DIA_Halvor_Crew_StealShip);
	}
	else
	{
		B_Say(self,other,"$NOTNOW");
		AI_StopProcessInfos(self);
	};
};

func void DIA_Halvor_Crew_MyThing()
{
	AI_Output (other, self, "DIA_Halvor_Crew_MyThing_15_00");	//That's my own business.
	AI_Output (self, other, "DIA_Halvor_Crew_MyThing_06_01");	//Suit yourself. It's none of my business, really.
	Info_ClearChoices (DIA_Halvor_Crew);
	Info_AddChoice (DIA_Halvor_Crew, Dialog_Back, DIA_Halvor_Crew_BACK);
	Info_AddChoice (DIA_Halvor_Crew, "Wanna come along?", DIA_Halvor_Crew_JoinMe);
	Info_AddChoice (DIA_Halvor_Crew, "Can you help me?", DIA_Halvor_Crew_HelpMe);
};

func void DIA_Halvor_Crew_StealShip()
{
	AI_Output (other, self, "DIA_Halvor_Crew_StealShip_15_00");	//I'm going to appropriate a ship.
	AI_Output (self, other, "DIA_Halvor_Crew_StealShip_06_01");	//Yeah right. Are you for real? The paladins will make short work of you, when they get hold of you.
	AI_Output (self, other, "DIA_Halvor_Crew_StealShip_06_02");	//Suit yourself - it's not my life you're risking.
	Info_ClearChoices(DIA_Halvor_Crew);
	Info_AddChoice(DIA_Halvor_Crew,Dialog_Back,DIA_Halvor_Crew_BACK);
	Info_AddChoice(DIA_Halvor_Crew,"Wanna come along?",DIA_Halvor_Crew_JoinMe);
	Info_AddChoice(DIA_Halvor_Crew,"Can you help me?",DIA_Halvor_Crew_HelpMe);
};

func void DIA_Halvor_Crew_JoinMe()
{
	AI_Output (other, self, "DIA_Halvor_Crew_JoinMe_15_00");	//Wanna come along?
	AI_Output (self, other, "DIA_Halvor_Crew_JoinMe_06_01");	//Naah, I think not. I've plenty to do here and, honestly, I have no desire to encounter a slave galley full of orcs.
	AI_Output (self, other, "DIA_Halvor_Crew_JoinMe_06_02");	//But I wish you lots of luck.
};

func void DIA_Halvor_Crew_HelpMe()
{
	AI_Output(other,self,"DIA_Halvor_Crew_HelpMe_15_00");	//Can you help me?
	if(!Npc_IsDead(Jack))
	{
		AI_Output(self,other,"DIA_Halvor_Crew_HelpMe_06_01");	//I'm not the right person for that. But go talk to Jack, he should be hanging out here somewhere in the harbor. He'll know best what you need to make that journey.
	}
	else
	{
		DIA_Common_06_IKnowNothingAboutIt();
	};
};

func void DIA_Halvor_Crew_BACK()
{
	Info_ClearChoices(DIA_Halvor_Crew);
};

