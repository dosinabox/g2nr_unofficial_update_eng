
instance DIA_Addon_Garett_EXIT(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 999;
	condition = DIA_Addon_Garett_EXIT_Condition;
	information = DIA_Addon_Garett_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Garett_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Garett_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Garett_PICKPOCKET(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 900;
	condition = DIA_Addon_Garett_PICKPOCKET_Condition;
	information = DIA_Addon_Garett_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Addon_Garett_PICKPOCKET_Condition()
{
	return C_Beklauen(36,55);
};

func void DIA_Addon_Garett_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Garett_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Garett_PICKPOCKET,Dialog_Back,DIA_Addon_Garett_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Garett_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Garett_PICKPOCKET_DoIt);
};

func void DIA_Addon_Garett_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Garett_PICKPOCKET);
};

func void DIA_Addon_Garett_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Garett_PICKPOCKET);
};


func void B_GarettTradeIntro()
{
	AI_Output (self, other, "DIA_Addon_Garett_Hello_09_01");	//I'm Garett. If there's anything you need, ask me first.
	AI_Output (self, other, "DIA_Addon_Garett_Hello_09_02");	//I can get you almost anything. Wine, weapons, and other stuff you might need.
	AI_Output (self, other, "DIA_Addon_Garett_Hello_09_03");	//Except for booze - if it's a decent drink you want, go see Samuel.
	if(!Npc_KnowsInfo(other,DIA_Addon_Skip_News))
	{
		Log_CreateTopic(Topic_Addon_PIR_Trader,LOG_NOTE);
		B_LogEntry(Topic_Addon_PIR_Trader,Log_Text_Addon_GarettTrade);
	};
};

instance DIA_Addon_Garett_Anheuern(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 1;
	condition = DIA_Addon_Garett_Anheuern_Condition;
	information = DIA_Addon_Garett_Anheuern_Info;
	important = TRUE;
};


func int DIA_Addon_Garett_Anheuern_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (MIS_Addon_Greg_ClearCanyon == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_Anheuern_Info()
{
		AI_Output (self, other, "DIA_Addon_Garett_Anheuern_09_00");	//Don't even think about asking me to join your raiding troop.
		AI_Output (self, other, "DIA_Addon_Garett_Anheuern_09_01");	//What do you think the other boys will do once I'm gone, huh?
		AI_Output (self, other, "DIA_Addon_Garett_Anheuern_09_02");	//When I come back, there won't be ONE full crate left in my hut!
		AI_Output (self, other, "DIA_Addon_Garett_Anheuern_09_03");	//I'll just stay here and guard our supplies.
	if(!Npc_KnowsInfo(other,DIA_Addon_Garett_Hello))
	{
		B_GarettTradeIntro();
	};
};


instance DIA_Addon_Garett_Hello(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 1;
	condition = DIA_Addon_Garett_Hello_Condition;
	information = DIA_Addon_Garett_Hello_Info;
	important = TRUE;
};


func int DIA_Addon_Garett_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE) && (MIS_Addon_Greg_ClearCanyon != LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_Hello_Info()
{
	AI_Output(self,other,"DIA_Addon_Garett_Hello_09_00");	//What have we here? A fresh face. And not one of those filthy bandits, I hope.
	B_GarettTradeIntro();
};


instance DIA_Addon_Garett_Samuel(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 2;
	condition = DIA_Addon_Garett_Samuel_Condition;
	information = DIA_Addon_Garett_Samuel_Info;
	permanent = FALSE;
	description = "Who's Samuel?";
};


func int DIA_Addon_Garett_Samuel_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Addon_Garett_Hello) || Npc_KnowsInfo(other,DIA_Addon_Garett_Anheuern)) && (Samuel.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_Samuel_Info()
{
	AI_Output (other, self, "DIA_Addon_Garett_Samuel_15_00");	//Who's Samuel?
	AI_Output (self, other, "DIA_Addon_Garett_Samuel_09_01");	//He's our moonshiner. He's got his cave on the beach, a little distance from the camp.
	AI_Output (self, other, "DIA_Addon_Garett_Samuel_09_02");	//You can't miss it, just walk north.
	AI_Output (self, other, "DIA_Addon_Garett_Samuel_09_03");	//You'll be well advised to keep yourself supplied with grog.
	AI_Output (self, other, "DIA_Addon_Garett_Samuel_09_04");	//Some of the boys here aren't very fond of greenhorns at all, if you get my drift.
	AI_Output (self, other, "DIA_Addon_Garett_Samuel_09_05");	//A decent swig of grog can work wonders for you!
	Log_CreateTopic(Topic_Addon_PIR_Trader,LOG_NOTE);	
	B_LogEntry (Topic_Addon_PIR_Trader, Log_Text_Addon_SamuelTrade);
};


instance DIA_Addon_Garett_Warez(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 3;
	condition = DIA_Addon_Garett_Warez_Condition;
	information = DIA_Addon_Garett_Warez_Info;
	description = "Where do you get your supplies?";
};


func int DIA_Addon_Garett_Warez_Condition()
{
	return TRUE;
};

func void DIA_Addon_Garett_Warez_Info()
{
	AI_Output (other, self, "DIA_Addon_Garett_Warez_15_00");	//Where do you get your supplies?
	AI_Output (self, other, "DIA_Addon_Garett_Warez_09_01");	//Skip always brings loads of stuff from Khorinis when he visits there.
	AI_Output (self, other, "DIA_Addon_Garett_Warez_09_02");	//Until recently, he used to sell some of it directly to the bandits.
	AI_Output (self, other, "DIA_Addon_Garett_Warez_09_03");	//But since we've been at war with the bandits, I'm the one who ends up with all the stuff now.
};


instance DIA_Addon_Garett_Bandits(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 3;
	condition = DIA_Addon_Garett_Bandits_Condition;
	information = DIA_Addon_Garett_Bandits_Info;
	description = "What do you know about the bandits?";
};


func int DIA_Addon_Garett_Bandits_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Garett_Warez))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_Bandits_Info()
{
	DIA_Common_WhatDoYouKnowAboutBandits();
	AI_Output (self, other, "DIA_Addon_Garett_Bandits_09_01");	//You'd better ask Skip about that.
	AI_Output (self, other, "DIA_Addon_Garett_Bandits_09_02");	//He's been through quite a lot with that bunch, let me tell you.
	AI_Output (self, other, "DIA_Addon_Garett_Bandits_09_03");	//Greg has given orders to do away with any bandit who shows up near the camp.
};


instance DIA_Addon_Garett_Greg(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 4;
	condition = DIA_Addon_Garett_Greg_Condition;
	information = DIA_Addon_Garett_Greg_Info;
	permanent = FALSE;
	description = "Your Captain Greg. What's he like?";
};


func int DIA_Addon_Garett_Greg_Condition()
{
	return TRUE;
};

func void DIA_Addon_Garett_Greg_Info()
{
	AI_Output (other, self, "DIA_Addon_Garett_Greg_15_00");	//Your Captain Greg. What's he like?
	AI_Output (self, other, "DIA_Addon_Garett_Greg_09_01");	//He's a tough old bastard, and no doubt about it.
	AI_Output (self, other, "DIA_Addon_Garett_Greg_09_02");	//And greedy to the bone.
	AI_Output (self, other, "DIA_Addon_Garett_Greg_09_03");	//He makes Francis, our treasurer, pay out not a penny more than what it takes to prevent a mutiny.
	AI_Output (self, other, "DIA_Addon_Garett_Greg_09_04");	//And if one of us ever gets his hands on something REALLY valuable, he'll inevitably take it for himself.
	AI_Output (self, other, "DIA_Addon_Garett_Greg_09_05");	//I once took a compass from a royal frigate.
	AI_Output (self, other, "DIA_Addon_Garett_Greg_09_06");	//That bastard Greg made me hand it over, of course.
	AI_Output (self, other, "DIA_Addon_Garett_Greg_09_07");	//Bah. He probably buried it somewhere, just like the rest of his treasures.
};


instance DIA_Addon_Garett_Tips(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 5;
	condition = DIA_Addon_Garett_Tips_Condition;
	information = DIA_Addon_Garett_Tips_Info;
	description = "Where might Greg have buried that compass?";
};


func int DIA_Addon_Garett_Tips_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Garett_Greg))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_Tips_Info()
{
	AI_Output (other, self, "DIA_Addon_Garett_Tips_15_00");	//Where might Greg have buried that compass?
	AI_Output (self, other, "DIA_Addon_Garett_Tips_09_01");	//Greg once told me that Death himself watches over my compass. Then he laughed.
	AI_Output (other, self, "DIA_Addon_Garett_Tips_15_02");	//Anything else?
	AI_Output (self, other, "DIA_Addon_Garett_Tips_09_03");	//There's a beach at the southern coast. It can only be reached by sea.
	AI_Output (self, other, "DIA_Addon_Garett_Tips_09_04");	//Greg is said to have been there often. Maybe you'll find something there.
	AI_Output (self, other, "DIA_Addon_Garett_Tips_09_05");	//I once went there to see what I might find myself, but the area is teeming with monsters.
	AI_Output (self, other, "DIA_Addon_Garett_Tips_09_06");	//If you really want to give it a try, don't forget to bring a pick.
	MIS_ADDON_GARett_BringKompass = LOG_Running;
	Log_CreateTopic (TOPIC_Addon_Kompass, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Kompass, LOG_Running);
	B_LogEntry (TOPIC_Addon_Kompass, "Greg has taken a valuable compass from Garret. Garret suspects that he buried it somewhere on the southern beach.");
};


func void B_GarettGiveBelt()
{
	AI_Output(self,other,"DIA_Addon_Garett_GiveKompass_09_04");	//Here, take this belt in return. It's my most valuable piece.
	B_GiveInvItems(self,other,ItBe_Addon_Prot_EdgPoi,1);
};

instance DIA_Addon_Garett_GiveKompass(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 6;
	condition = DIA_Addon_Garett_GiveKompass_Condition;
	information = DIA_Addon_Garett_GiveKompass_Info;
	permanent = FALSE;
	description = "Here's your compass.";
};


func int DIA_Addon_Garett_GiveKompass_Condition()
{
	if((Npc_HasItems(other,ItMI_Addon_Kompass_Mis) >= 1) && (MIS_ADDON_GARett_BringKompass == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_GiveKompass_Info()
{
	AI_Output(other,self,"DIA_Addon_Garett_GiveKompass_15_00");	//Here's your compass.
	B_GiveInvItems(other,self,ItMI_Addon_Kompass_Mis,1);
	Npc_RemoveInvItem(self,ItMI_Addon_Kompass_Mis);
	AI_Output(self,other,"DIA_Addon_Garett_GiveKompass_09_01");	//(happily) Yes, that's it. I never thought I'd see it again.
	AI_Output(self,other,"DIA_Addon_Garett_GiveKompass_09_02");	//Thanks, man!
	AI_Output(self,other,"DIA_Addon_Garett_GiveKompass_09_03");	//This time Greg WON'T get hold of it again...
	if(Npc_HasItems(self,ItBe_Addon_Prot_EdgPoi))
	{
		B_GarettGiveBelt();
	}
	else if(self.aivar[AIV_DefeatedByPlayer] == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Garett_GiveKompass_09_05");	//You bought this belt from me, remember?
		AI_Output(self,other,"DIA_Addon_Garett_GiveKompass_09_06");	//And you paid a lot for it - (hastily) not that it wasn't worth it. Here - take back your gold.
		B_GiveInvItems(self,other,ItMi_Gold,Value_ItBE_Addon_Prot_EdgPoi);
	}
	else
	{
		CreateInvItems(self,ItBe_Addon_Prot_EdgPoi,1);
		B_GarettGiveBelt();
	};
	B_LogEntry (TOPIC_Addon_Kompass, "Garret was very pleased that I brought his compass back.");
	MIS_ADDON_GARett_BringKompass = LOG_SUCCESS;
	B_GivePlayerXP(XP_ADDON_Garett_Bring_Kompass);
};


instance DIA_Addon_Garett_Francis(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 7;
	condition = DIA_Addon_Garett_Francis_Condition;
	information = DIA_Addon_Garett_Francis_Info;
	permanent = FALSE;
	description = "What can you tell me about Francis?";
};


func int DIA_Addon_Garett_Francis_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Garett_Greg))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_Francis_Info()
{
	AI_Output (other, self, "DIA_Addon_Garett_Francis_15_00");	//What can you tell me about Francis?
	AI_Output (self, other, "DIA_Addon_Garett_Francis_09_01");	//Greg put him in command while he's gone.
	AI_Output (self, other, "DIA_Addon_Garett_Francis_09_02");	//But Francis is a total failure as a leader!
	AI_Output (self, other, "DIA_Addon_Garett_Francis_09_03");	//He can't even get Morgan to stir his lazy ass out of bed.
	AI_Output (self, other, "DIA_Addon_Garett_Francis_09_04");	//Henry and his boys are the only ones doing anything around here.
	AI_Output (self, other, "DIA_Addon_Garett_Francis_09_05");	//The others are just enjoying themselves instead of working.
	if (GregIsBack == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Garett_Francis_09_06");	//I can only hope that Greg will come back soon.
		AI_Output (self, other, "DIA_Addon_Garett_Francis_09_07");	//He'll give them all a good swift kick in the ass.
	};
};


instance DIA_Addon_Garett_PERM(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 99;
	condition = DIA_Addon_Garett_PERM_Condition;
	information = DIA_Addon_Garett_PERM_Info;
	permanent = TRUE;
	description = "Anything new?";
};


func int DIA_Addon_Garett_PERM_Condition()
{
	return TRUE;
};

func void DIA_Addon_Garett_PERM_Info()
{
	AI_Output(other,self,"DIA_Addon_Garett_PERM_15_00");	//Anything new?
	if(GregIsBack == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Garett_PERM_09_02");	//Nothing ever happens any more since Greg left.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Garett_PERM_09_01");	//Now that Greg has come back, things are starting to look up around here.
	};
};


instance DIA_Addon_Garett_Trade(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 888;
	condition = DIA_Addon_Garett_Trade_Condition;
	information = DIA_Addon_Garett_Trade_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Addon_Garett_Trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Garett_Hello) || Npc_KnowsInfo(other,DIA_Addon_Garett_Anheuern))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_Trade_Info()
{
	DIA_Common_ShowMeYourGoods();
	B_GiveTradeInv(self);
	if(TradersHaveLimitedAmmo == TRUE)
	{
		if(Garett_Ammo_Day <= Wld_GetDay())
		{
			B_RefreshAmmo(self,25);
			Garett_Ammo_Day = Wld_GetDay() + 1;
		};
	}
	else
	{
		B_RefreshAmmo(self,25);
	};
	Trade_IsActive = TRUE;
};

instance DIA_Addon_Garett_ArmorM(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 8;
	condition = DIA_Addon_Garett_ArmorM_Condition;
	information = DIA_Addon_Garett_ArmorM_Info;
	permanent = TRUE;
	description = "What about some better armor?";
};


func int DIA_Addon_Garett_ArmorM_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Addon_Garett_Hello) || Npc_KnowsInfo(other,DIA_Addon_Garett_Anheuern)) && Npc_KnowsInfo(other,DIA_Addon_Greg_JoinPirates) && (Greg_NoHelpInNW == TRUE) && (Garett_Armor_Given == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Garett_ArmorM_Info()
{
	DIA_Common_WhatAboutBetterArmor();
	AI_Output(self,other,"DIA_Matteo_LEATHER_09_01");	//You'll love it. (grins)
	Info_ClearChoices(DIA_Addon_Garett_ArmorM);
	Info_AddChoice(DIA_Addon_Garett_ArmorM,Dialog_Back,DIA_Addon_Garett_ArmorM_Back);
	Info_AddChoice(DIA_Addon_Garett_ArmorM,"Buy Pirate's Armor. Protection: 55/55/0/0. (1300 gold)",DIA_Addon_Garett_ArmorM_Buy);
};

func void DIA_Addon_Garett_ArmorM_Buy()
{
	DIA_Common_GiveMeThatArmor();
	if(B_GiveInvItems(other,self,ItMi_Gold,VALUE_ITAR_PIR_M_Addon))
	{
		B_Say(self,other,"$ABS_GOOD");
		B_GiveArmor(ITAR_PIR_M_Addon);
		Garett_Armor_Given = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Matteo_LEATHER_09_02");	//The armor has its price - and it's worth it. So, come back when you have enough gold.
	};
	Info_ClearChoices(DIA_Addon_Garett_ArmorM);
};

func void DIA_Addon_Garett_ArmorM_Back()
{
	Info_ClearChoices(DIA_Addon_Garett_ArmorM);
};

/*instance DIA_Addon_Garett_StonePlate(C_Info)
{
	npc = PIR_1357_Addon_Garett;
	nr = 9;
	condition = DIA_Addon_Garett_StonePlate_Condition;
	information = DIA_Addon_Garett_StonePlate_Info;
	permanent = FALSE;
	description = "У меня с собой есть каменная табличка. Сколько ты готов дать за это?";
};


func int DIA_Addon_Garett_StonePlate_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Addon_Garett_Hello) || Npc_KnowsInfo(other,DIA_Addon_Garett_Anheuern)) && (MIS_Addon_Morgan_SeekTraitor == LOG_SUCCESS) && Npc_HasItems(other,ItWr_StonePlateCommon_Addon))
	{
		return TRUE;
	};
	return FALSE;
};

func void DIA_Addon_Garett_StonePlate_Info()
{
	AI_Output(other,self,"DIA_Addon_Garett_StonePlate_15_00_add");	//У меня с собой есть каменная табличка. Сколько ты готов дать за это?
	AI_Output(self,other,"DIA_Addon_Garett_StonePlate_09_01_add");	//
};*/

