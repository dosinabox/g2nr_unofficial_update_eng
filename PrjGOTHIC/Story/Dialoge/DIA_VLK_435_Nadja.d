
instance DIA_Nadja_EXIT(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 999;
	condition = DIA_Nadja_EXIT_Condition;
	information = DIA_Nadja_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Nadja_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Nadja_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Nadja_PICKPOCKET(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 900;
	condition = DIA_Nadja_PICKPOCKET_Condition;
	information = DIA_Nadja_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40_Female;
};


func int DIA_Nadja_PICKPOCKET_Condition()
{
	return C_Beklauen(40,40);
};

func void DIA_Nadja_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Nadja_PICKPOCKET);
	Info_AddChoice(DIA_Nadja_PICKPOCKET,Dialog_Back,DIA_Nadja_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Nadja_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Nadja_PICKPOCKET_DoIt);
};

func void DIA_Nadja_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Nadja_PICKPOCKET);
};

func void DIA_Nadja_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Nadja_PICKPOCKET);
};

func void B_Nadja_NotHere()
{
	AI_Output(self,other,"DIA_ADDON_Nadja_STANDARD_16_02");	//I could tell you a thing or two, but not here, honey.
	if(Bromor_Pay == 0)
	{
		AI_Output (other, self, "DIA_ADDON_Nadja_STANDARD_15_03");	//Then let's go upstairs.
		AI_Output (self, other, "DIA_ADDON_Nadja_STANDARD_16_04");	//Fine. But you get it settled with Bromor first. I don't want any trouble.
	};
};

instance DIA_Nadja_STANDARD(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 3;
	condition = DIA_Nadja_STANDARD_Condition;
	information = DIA_Nadja_STANDARD_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Nadja_STANDARD_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Bromor_Pay == 0))
	{
		return TRUE;
	};
};


var int Nadja_LuciaInfo;

func void DIA_Nadja_STANDARD_Info()
{
	if(Npc_GetDistToWP(self,"NW_PUFF_DANCE") > 400)
	{
		AI_Output(self,other,"DIA_Nadja_Danach_16_00");	//Come back to me the next time.
	}
	else if(Nadja_Nacht > 0)
	{
		AI_Output(self,other,"DIA_Nadja_STANDARD_16_00");	//Hey, I can't take care of you now, baby. Talk to Bromor if you want to have some fun.
	}
	else
	{
		AI_Output(self,other,"DIA_ADDON_Nadja_STANDARD_16_00");	//I can only talk to you if you speak to Bromor first.
	};
	if((SC_HearedAboutMissingPeople == TRUE) && (SCKnowsMissingPeopleAreInAddonWorld == FALSE) && (Nadja_LuciaInfo == FALSE))
	{
		AI_Output(other,self,"DIA_ADDON_Nadja_STANDARD_15_01");	//I just want to ask you a few questions about those missing people.
		B_Nadja_NotHere();
		Nadja_LuciaInfo = TRUE;
	};
	AI_StopProcessInfos(self);
};


/*instance DIA_Nadja_Danach(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 2;
	condition = DIA_Nadja_Danach_Condition;
	information = DIA_Nadja_Danach_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Nadja_Danach_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Bromor_Pay == 0) && (Nadja_Nacht == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Nadja_Danach_Info()
{
	AI_Output (self, other, "DIA_Nadja_Danach_16_00");	//Come back to me the next time.
	Nadja_Nacht = FALSE;
	AI_StopProcessInfos(self);
};*/


instance DIA_Nadja_hochgehen(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 3;
	condition = DIA_Nadja_hochgehen_Condition;
	information = DIA_Nadja_hochgehen_Info;
	important = FALSE;
	permanent = TRUE;
	description = "Let's go upstairs.";
};


func int DIA_Nadja_hochgehen_Condition()
{
	if(Bromor_Pay == 1)
	{
		return TRUE;
	};
};

func void DIA_Nadja_hochgehen_Info()
{
	AI_Output (other, self, "DIA_Nadja_hochgehen_15_00");	//Let's go upstairs.
	AI_Output (self, other, "DIA_Nadja_hochgehen_16_01");	//Today's your lucky day, baby. Let's go.
	Bromor_Pay = 2;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"DANCE");
};


instance DIA_Addon_Nadja_LuciaInfo(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 5;
	condition = DIA_Addon_Nadja_LuciaInfo_Condition;
	information = DIA_Addon_Nadja_LuciaInfo_Info;
	description = "Can we talk now?";
};


func int DIA_Addon_Nadja_LuciaInfo_Condition()
{
	if((Bromor_Pay == 2) && (Npc_GetDistToWP(self,"NW_CITY_HABOUR_PUFF_NADJA") < 300))
	{
		if(Nadja_LuciaInfo == TRUE)
		{
			DIA_Addon_Nadja_LuciaInfo.description = "So can we talk NOW?";
			return TRUE;
		}
		else if((SC_HearedAboutMissingPeople == TRUE) && (SCKnowsMissingPeopleAreInAddonWorld == FALSE))
		{
			DIA_Addon_Nadja_LuciaInfo.description = "I just want to ask you a few questions about those missing people.";
			return TRUE;
		};
	};
};


func void DIA_Addon_Nadja_LuciaInfo_Info()
{
	if(Nadja_LuciaInfo == TRUE)
	{
		AI_Output(other,self,"DIA_Addon_Nadja_LuciaInfo_15_00");	//So can we talk NOW?
	}
	else
	{
		AI_Output(other,self,"DIA_ADDON_Nadja_STANDARD_15_01");	//I just want to ask you a few questions about those missing people.
	};
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_16_01");	//We've got enough privacy up here.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_16_02");	//Bromor doesn't like to see us talk to guests during work if there's nothing in it for him.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_16_03");	//So you want to know more about the people who disappeared down here at the harbor, do you?
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_16_04");	//I don't know whether I can help you much, but at least I can tell you what became of Lucia.
	LuciaMentionedInKhorinis = TRUE;
	Info_ClearChoices(DIA_Addon_Nadja_LuciaInfo);
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Where did she disappear to?",DIA_Addon_Nadja_LuciaInfo_wo);
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Tell me about Lucia.",DIA_Addon_Nadja_LuciaInfo_lucia);
};

func void DIA_Addon_Nadja_LuciaInfo_lucia()
{
	AI_Output (other, self, "DIA_Addon_Nadja_LuciaInfo_lucia_15_00");	//Tell me about Lucia.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_lucia_16_01");	//Nobody here is too sorry that she's gone.
	AI_Output (other, self, "DIA_Addon_Nadja_LuciaInfo_lucia_15_02");	//Why?
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_lucia_16_03");	//I don't think there was anyone here whom she didn't try to use.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_lucia_16_04");	//She was a real bitch!
};

func void DIA_Addon_Nadja_LuciaInfo_wo()
{
	AI_Output (other, self, "DIA_Addon_Nadja_LuciaInfo_wo_15_00");	//Where did she disappear to?
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_wo_16_01");	//She used to see a lot of Elvrich, the apprentice of Thorben the carpenter from the lower part of town.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_wo_16_02");	//I bet she's up and left with that young man.
	if((SC_KnowsLuciaCaughtByBandits == FALSE) && (MIS_LuciasLetter != LOG_SUCCESS))
	{
		if(MIS_LookingForLucia == LOG_Running)
		{
			B_LogEntry(TOPIC_Addon_Lucia,"Lucia the whore likely ran off with Elvrich, Thorben the carpenter's apprentice.");
		}
		else if(MIS_LookingForLucia == FALSE)
		{
			Log_CreateTopic(TOPIC_Addon_Lucia,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_Lucia,LOG_Running);
			B_LogEntry(TOPIC_Addon_Lucia,"Lucia the whore disappeared from Bromor's brothel overnight. They assume that she ran off with Elvrich, Thorben the carpenter's apprentice.");
			MIS_LookingForLucia = LOG_Running;
		};
		Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Where could the two of them have gone?",DIA_Addon_Nadja_LuciaInfo_Elvrich);
	}
	else
	{
		Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"What else do you know?",DIA_Addon_Nadja_LuciaInfo_sonst);
	};
};

func void DIA_Addon_Nadja_LuciaInfo_Elvrich()
{
	AI_Output (other, self, "DIA_Addon_Nadja_LuciaInfo_Elvrich_15_00");	//Where could the two of them have gone?
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_Elvrich_16_01");	//If the wolves didn't eat them, I suppose they went to stay with the farmers.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_Elvrich_16_02");	//Where else would they go?
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"What else do you know?",DIA_Addon_Nadja_LuciaInfo_sonst);
};

func void B_Nadja_WhatsNextHoney()
{
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_sonst_16_05");	//Now, what about the two of us, sweetie? You paid for it, after all.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_sonst_16_06");	//Wouldn't you like to have a little fun before you leave?
};

func void B_Nadja_Poppen_Start()
{
	AI_Output (self, other, "DIA_Nadja_Poppen_16_00");	//The next couple of hours belong to us.
	AI_Output (self, other, "DIA_Nadja_Poppen_16_01");	//It's time for you to relax. Lie back and enjoy..
};

func void DIA_Addon_Nadja_LuciaInfo_sonst()
{
	AI_Output (other, self, "DIA_Addon_Nadja_LuciaInfo_sonst_15_00");	//What else do you know?
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_sonst_16_01");	//I've heard many stories about people who disappeared down here at the harbor.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_sonst_16_02");	//But I'm not so sure whether I should believe them.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_sonst_16_03");	//You should have a chat with the merchants down here.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_sonst_16_04");	//That's all I can tell you, alas.
	B_Nadja_WhatsNextHoney();
	Info_ClearChoices(DIA_Addon_Nadja_LuciaInfo);
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == FALSE))
	{
		if(Nadja_Money == FALSE)
		{
			Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Where can I buy weed around here?",DIA_Addon_Nadja_WAIT);
		}
		else if(Npc_HasItems(other,ItMi_Gold) >= 50)
		{
			Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Now tell me where I can buy weed.",DIA_Addon_Nadja_WAIT_GiveGold2);
		};
	};
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Thanks, but I've got to go now.",DIA_Addon_Nadja_LuciaInfo_weiter);
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"(Have fun)",DIA_Nadja_Poppen_Start1);
};

func void DIA_Nadja_Poppen_Start1()
{
	DIA_Common_WhyNot();
	B_Nadja_Poppen_Start();
	Info_ClearChoices(DIA_Addon_Nadja_LuciaInfo);
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Here...",DIA_Nadja_Poppen_Start);
};

func void DIA_Addon_Nadja_LuciaInfo_weiter()
{
	AI_Output (other, self, "DIA_Addon_Nadja_LuciaInfo_weiter_15_00");	//Thanks, but I've got to go now.
	AI_Output (self, other, "DIA_Addon_Nadja_LuciaInfo_weiter_16_01");	//Too bad. Well, maybe next time.
	Bromor_Pay = 0;
	Nadja_Nacht += 1;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"START");
};

func void B_Nadja_BUYHERB()
{
	AI_Output(other,self,"DIA_Nadja_BUYHERB_15_00");	//Where can I buy weed around here?
	if(Undercover_Failed_Nadja == TRUE)
	{
		AI_Output(self,other,"DIA_Nadja_BUYHERB_16_01");	//How would I know? Even if I knew, I'd certainly not tell the city guard.
		Nadja_BuyHerb_Failed = TRUE;
	}
	else if(Npc_GetDistToWP(self,"NW_CITY_HABOUR_PUFF_NADJA") < 300)
	{
			AI_Output (self, other, "DIA_Nadja_BUYHERB_16_02");	//If you want me to tell you something, you'd better part with a few gold pieces.
			AI_Output (other, self, "DIA_Nadja_BUYHERB_15_03");	//How much do you want?
			AI_Output (self, other, "DIA_Nadja_BUYHERB_16_04");	//50 gold pieces should do the trick.
		Nadja_Money = TRUE;
	}
	else
	{
		B_Nadja_NotHere();
	};
};

func void B_Nadja_WANT_HERB()
{
	AI_Output(other,self,"DIA_Nadja_WANT_HERB_15_00");	//Now tell me where I can buy weed.
	if(Undercover_Failed_Nadja == TRUE)
	{
		AI_Output(self,other,"DIA_Nadja_WANT_HERB_16_01");	//Sorry, I simply can't remember.
	}
	else if(Npc_GetDistToWP(self,"NW_CITY_HABOUR_PUFF_NADJA") < 300)
	{
		if(B_GiveInvItems(other,self,ItMi_Gold,50))
		{
			AI_Output(self,other,"DIA_Nadja_WANT_HERB_16_02");	//Talk to Borka, baby. He'll have some weed for you.
			Knows_Borka_Dealer = TRUE;
		}
		else
		{
			AI_Output(self,other,"DIA_Cassia_DIA_Cassia_BevorLernen_DEX_16_02");	//Come back when you've got the gold.
			AI_StopProcessInfos(self);
		};
	}
	else
	{
		B_Nadja_NotHere();
	};
};

func void B_Nadja_GiveGoldLater()
{
	DIA_Common_MaybeLater();
	B_Nadja_WhatsNextHoney();
};

func void B_Nadja_GiveGoldNow()
{
	B_Nadja_WANT_HERB();
	B_Nadja_WhatsNextHoney();
	Info_ClearChoices(DIA_Addon_Nadja_LuciaInfo);
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Thanks, but I've got to go now.",DIA_Addon_Nadja_LuciaInfo_weiter);
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Too bad. Well, maybe next time.",DIA_Nadja_Poppen_Start1);
};

func void DIA_Addon_Nadja_WAIT()
{
	B_Nadja_BUYHERB();
	if(Npc_HasItems(other,ItMi_Gold) >= 50)
	{
		Info_ClearChoices(DIA_Addon_Nadja_LuciaInfo);
		Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Here...",DIA_Addon_Nadja_WAIT_GiveGold);
		Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Maybe later...",DIA_Addon_Nadja_WAIT_GiveGoldLater);
	}
	else
	{
		B_Nadja_GiveGoldLater();
	};
};

func void DIA_Addon_Nadja_WAIT_GiveGoldLater()
{
	B_Nadja_GiveGoldLater();
	Info_ClearChoices(DIA_Addon_Nadja_LuciaInfo);
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Thanks, but I've got to go now.",DIA_Addon_Nadja_LuciaInfo_weiter);
	Info_AddChoice(DIA_Addon_Nadja_LuciaInfo,"Too bad. Well, maybe next time.",DIA_Nadja_Poppen_Start1);
};

func void DIA_Addon_Nadja_WAIT_GiveGold()
{
	DIA_Common_TakeIt();
	B_Nadja_GiveGoldNow();
};

func void DIA_Addon_Nadja_WAIT_GiveGold2()
{
	B_Nadja_GiveGoldNow();
};

instance DIA_Nadja_Poppen(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 800;
	condition = DIA_Nadja_Poppen_Condition;
	information = DIA_Nadja_Poppen_Info;
	permanent = TRUE;
	description = "(Have fun)";
};


func int DIA_Nadja_Poppen_Condition()
{
	if((Bromor_Pay == 2) && (Npc_GetDistToWP(self,"NW_CITY_HABOUR_PUFF_NADJA") < 300))
	{
		return TRUE;
	};
};

func void DIA_Nadja_Poppen_Info()
{
	B_Nadja_Poppen_Start();
	Info_ClearChoices(DIA_Nadja_Poppen);
	Info_AddChoice(DIA_Nadja_Poppen,"Okay...",DIA_Nadja_Poppen_Start);
};

func void DIA_Nadja_Poppen_Start()
{
	Bromor_Pay = 0;
	Nadja_Nacht += 1;
	self.attribute[ATR_HITPOINTS] = self.attribute[ATR_HITPOINTS_MAX];
	PlayVideo("LOVESCENE.BIK");
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"START");
};

func void DIA_Addon_Nadja_LuciaInfo_Pop()
{
	DIA_Nadja_Poppen_Start();
};


instance DIA_Nadja_BUYHERB(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 2;
	condition = DIA_Nadja_BUYHERB_Condition;
	information = DIA_Nadja_BUYHERB_Info;
	permanent = TRUE;
	description = "Where can I buy weed here?";
};


func int DIA_Nadja_BUYHERB_Condition()
{
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Nadja_Money == FALSE) && (Nadja_BuyHerb_Failed == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Nadja_BUYHERB_Info()
{
	B_Nadja_BUYHERB();
};


instance DIA_Nadja_WANT_HERB(C_Info)
{
	npc = VLK_435_Nadja;
	nr = 2;
	condition = DIA_Nadja_WANT_HERB_Condition;
	information = DIA_Nadja_WANT_HERB_Info;
	permanent = TRUE;
	description = "Now tell me where I can buy weed (pay 50 gold).";
};


func int DIA_Nadja_WANT_HERB_Condition()
{
	if((Nadja_Money == TRUE) && (MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Nadja_WANT_HERB_Info()
{
	B_Nadja_WANT_HERB();
};

