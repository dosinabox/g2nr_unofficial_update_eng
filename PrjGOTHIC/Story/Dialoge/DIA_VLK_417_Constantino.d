
instance DIA_Constantino_EXIT(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 999;
	condition = DIA_Constantino_EXIT_Condition;
	information = DIA_Constantino_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Constantino_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Constantino_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Constantino_PICKPOCKET(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 900;
	condition = DIA_Constantino_PICKPOCKET_Condition;
	information = DIA_Constantino_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Constantino_PICKPOCKET_Condition()
{
	return C_Beklauen(59,90);
};

func void DIA_Constantino_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Constantino_PICKPOCKET);
	Info_AddChoice(DIA_Constantino_PICKPOCKET,Dialog_Back,DIA_Constantino_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Constantino_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Constantino_PICKPOCKET_DoIt);
};

func void DIA_Constantino_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Constantino_PICKPOCKET);
};

func void DIA_Constantino_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Constantino_PICKPOCKET);
};


instance DIA_Constantino_Hallo(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 2;
	condition = DIA_Constantino_Hallo_Condition;
	information = DIA_Constantino_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Constantino_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE) && (VisibleGuild(other) != GIL_PAL) && (VisibleGuild(other) != GIL_MIL) && (VisibleGuild(other) != GIL_KDF) && (VisibleGuild(other) != GIL_KDW))
	{
		return TRUE;
	};
};

func void DIA_Constantino_Hallo_Info()
{
	AI_Output (self, other, "DIA_Addon_Constantino_Hallo_10_00");	//What do you want? I'm not giving anything away.
};


instance DIA_Constantino_AboutLehrling(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 1;
	condition = DIA_Constantino_AboutLehrling_Condition;
	information = DIA_Constantino_AboutLehrling_Info;
	permanent = FALSE;
	description = "I'm looking to become an apprentice.";
};


func int DIA_Constantino_AboutLehrling_Condition()
{
	if(Player_IsApprentice == APP_NONE)
	{
		return TRUE;
	};
};

func void DIA_Constantino_AboutLehrling_Info()
{
	AI_Output (other, self, "DIA_Constantino_AboutLehrling_15_00");	//I'm looking to become an apprentice.
	AI_Output (self, other, "DIA_Constantino_AboutLehrling_10_01");	//Really? And with whom are you going to sign up?
};


instance DIA_Constantino_Heilung(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 5;
	condition = DIA_Constantino_Heilung_Condition;
	information = DIA_Constantino_Heilung_Info;
	permanent = FALSE;
	description = "I'm in need of healing.";
};


func int DIA_Constantino_Heilung_Condition()
{
	return TRUE;
};

func void DIA_Constantino_Heilung_Info()
{
	AI_Output (other, self, "DIA_Constantino_Heilung_15_00");	//I'm in need of healing.
	AI_Output (self, other, "DIA_Constantino_Heilung_10_01");	//(curtly) Why, are you injured?
	Info_ClearChoices (DIA_Constantino_Heilung);
	Info_AddChoice (DIA_Constantino_Heilung, "Not really.", DIA_Constantino_Heilung_Nein);
	Info_AddChoice (DIA_Constantino_Heilung, "Yes.", DIA_Constantino_Heilung_Ja);
};

func void DIA_Constantino_Heilung_Ja()
{
	AI_Output (other, self, "DIA_Constantino_Heilung_Ja_15_00");	//Yes.
	if (other.attribute[ATR_HITPOINTS] < other.attribute[ATR_HITPOINTS_MAX])
	{
		AI_Output (self, other, "DIA_Constantino_Heilung_Ja_10_01");	//Go to Vatras then, he'll patch you up all right. And stop bleeding all over my floor!
	}
	else
	{
		AI_Output (self, other, "DIA_Constantino_Heilung_Ja_10_02");	//There's barely a scratch on you and I have more important things to do than talk to you.
	};
	AI_StopProcessInfos(self);
};

func void DIA_Constantino_Heilung_Nein()
{
	AI_Output (other, self, "DIA_Constantino_Heilung_Nein_15_00");	//Not really.
	AI_Output (self, other, "DIA_Constantino_Heilung_Nein_10_01");	//Get lost, then, or you may well suffer an injury.
	AI_StopProcessInfos (self);
};


instance DIA_Addon_Constantino_LestersKraeuter(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 5;
	condition = DIA_Addon_Constantino_LestersKraeuter_Condition;
	information = DIA_Addon_Constantino_LestersKraeuter_Info;
	description = "Can I sell you some herbs?";
};


func int DIA_Addon_Constantino_LestersKraeuter_Condition()
{
	if((MIS_Constantino_BringHerbs == FALSE) && (MIS_Addon_Lester_PickForConstantino != FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Constantino_LestersKraeuter_Info()
{
	AI_Output (other, self, "DIA_Addon_Constantino_LestersKraeuter_15_00");	//Can I sell you some herbs?
	AI_Output (self, other, "DIA_Addon_Constantino_LestersKraeuter_10_01");	//If you have any to offer ...
	B_GivePlayerXP (XP_Ambient);
};


instance DIA_Constantino_Trade(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 700;
	condition = DIA_Constantino_Trade_Condition;
	information = DIA_Constantino_Trade_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Constantino_Trade_Condition()
{
	if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
	{
		return TRUE;
	};
};

func void DIA_Constantino_Trade_Info()
{
	DIA_Common_ShowMeYourGoods();
	if(Constantino_flag == TRUE)
	{
		B_ClearAlchemyInv(self);
		if(Constantino_flasks > 0)
		{
			CreateInvItems(self,ItMi_Flask,Constantino_flasks);
		};
		Constantino_flag = FALSE;
	};
	if(Constantino_Logpatch1 == FALSE)
	{
		Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
		B_LogEntry(TOPIC_CityTrader,"Constantino sells alchemist supplies.");
		Constantino_Logpatch1 = TRUE;
	};
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


func void B_Constantino_NoYouAreWanted()
{
	AI_Output(self,other,"DIA_Constantino_LEHRLING_10_25");	//(irritated) No way! I have heard rumors that you stand accused as a criminal here in Khorinis!
};

instance DIA_Constantino_NoTrade(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 700;
	condition = DIA_Constantino_NoTrade_Condition;
	information = DIA_Constantino_NoTrade_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
};


func int DIA_Constantino_NoTrade_Condition()
{
	if(B_GetGreatestPetzCrime(self) != CRIME_NONE)
	{
		return TRUE;
	};
};

func void DIA_Constantino_NoTrade_Info()
{
	DIA_Common_ShowMeYourGoods();
	B_Constantino_NoYouAreWanted();
	AI_StopProcessInfos(self);
};


instance DIA_Constantino_BeiDir(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 1;
	condition = DIA_Constantino_BeiDir_Condition;
	information = DIA_Constantino_BeiDir_Info;
	permanent = FALSE;
	description = "I want to sign up with you as an apprentice.";
};


func int DIA_Constantino_BeiDir_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Constantino_AboutLehrling) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Constantino_BeiDir_Info()
{
	AI_Output (other, self, "DIA_Constantino_BeiDir_15_00");	//I want to sign up with you as an apprentice.
	AI_Output (self, other, "DIA_Constantino_BeiDir_10_01");	//With ME? No! I have already had the dubious pleasure once of grappling with an apprentice. That's quite enough for me.
	AI_Output (self, other, "DIA_Constantino_BeiDir_10_02");	//I invested several years in his education, and in the end the poor fool up and poisoned himself.
	AI_Output (self, other, "DIA_Constantino_BeiDir_10_03");	//Go sign up with one of the other masters!
};


instance DIA_Constantino_ZUSTIMMUNG(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 2;
	condition = DIA_Constantino_ZUSTIMMUNG_Condition;
	information = DIA_Constantino_ZUSTIMMUNG_Info;
	permanent = TRUE;
	description = "I want to sign up with one of the other masters.";
};


func int DIA_Constantino_ZUSTIMMUNG_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Constantino_AboutLehrling) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Constantino_ZUSTIMMUNG_Info()
{
	AI_Output (other, self, "DIA_Constantino_ZUSTIMMUNG_15_00");	//I want to sign up with one of the other masters.
	AI_Output (self, other, "DIA_Constantino_ZUSTIMMUNG_10_01");	//You have come to ask my approval?
	if (B_GetGreatestPetzCrime (self) == CRIME_NONE)
	{
		AI_Output (self, other, "DIA_Constantino_ZUSTIMMUNG_10_02");	//Hm - as far as I am concerned, you can sign up with whomever you like.
	}
	else
	{
		AI_Output (self, other, "DIA_Constantino_ZUSTIMMUNG_10_03");	//Well, you're not going to get it! The things I've heard about you do not speak for you.
		AI_Output (self, other, "DIA_Constantino_ZUSTIMMUNG_10_04");	//I shall not vote for a criminal such as yourself to attain an honorable position in our town.
		AI_Output (self, other, "DIA_Constantino_ZUSTIMMUNG_10_05");	//Until you have settled this matter with the commander of the city guard, my answer shall be no!
	};
	if(Constantino_Logpatch2 == FALSE)
	{
		Log_CreateTopic (TOPIC_Lehrling, LOG_MISSION);
		Log_SetTopicStatus (TOPIC_Lehrling, LOG_Running);
		B_LogEntry (TOPIC_Lehrling, "Constantino will give his approval to my becoming an apprentice as long as I'm not accused of any crime in town.");
		Constantino_Logpatch2 = TRUE;
	};
};


instance DIA_Constantino_BringHerbs(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 1;
	condition = DIA_Constantino_BringHerbs_Condition;
	information = DIA_Constantino_BringHerbs_Info;
	permanent = FALSE;
	description = "What will I have to do to become YOUR apprentice?";
};


func int DIA_Constantino_BringHerbs_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Constantino_BeiDir) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Constantino_BringHerbs_Info()
{
	AI_Output (other, self, "DIA_Constantino_BringHerbs_15_00");	//What will I have to do to become YOUR apprentice?
	AI_Output (self, other, "DIA_Constantino_BringHerbs_10_01");	//(sighs) I couldn't bear yet ANOTHER dilettante on my conscience.
	AI_Output (self, other, "DIA_Constantino_BringHerbs_10_02");	//There is a multitude of herbs out there. Used in different variations, they develop the most diverse effects.
	AI_Output (self, other, "DIA_Constantino_BringHerbs_10_03");	//You probably don't even know half of them.
	AI_Output (self, other, "DIA_Constantino_BringHerbs_10_04");	//(sighs) Here - this is a list of the most important plants.
	B_GiveInvItems (self, other, ItWr_Kraeuterliste, 1);
	AI_Output (self, other, "DIA_Constantino_BringHerbs_10_05");	//Bring me a plant of each kind, and I might reconsider taking you in as an apprentice.
	MIS_Constantino_BringHerbs = LOG_Running;
	Log_CreateTopic (TOPIC_ConstantinoPlants, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_ConstantinoPlants, LOG_Running);
	B_LogEntry (TOPIC_ConstantinoPlants, "Constantino wants one plant of each type, otherwise he won't accept me as his apprentice.");
};


instance DIA_Constantino_HerbsRunning(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 1;
	condition = DIA_Constantino_HerbsRunning_Condition;
	information = DIA_Constantino_HerbsRunning_Info;
	permanent = TRUE;
	description = "About the plants ...";
};


func int DIA_Constantino_HerbsRunning_Condition()
{
	if(MIS_Constantino_BringHerbs == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Constantino_HerbsRunning_Info()
{
	AI_Output (other, self, "DIA_Constantino_HerbsRunning_15_00");	//About the plants ...
	AI_Output (self, other, "DIA_Constantino_HerbsRunning_10_01");	//If you cannot handle that by yourself, you won't be any good as an alchemist either!
	Info_ClearChoices(DIA_Constantino_HerbsRunning);
	Info_AddChoice(DIA_Constantino_HerbsRunning,"I see.",DIA_Constantino_HerbsRunning_Running);
	if(Npc_HasItems(other,ItPl_Mana_Herb_01) && Npc_HasItems(other,ItPl_Mana_Herb_02) && Npc_HasItems(other,ItPl_Mana_Herb_03) && Npc_HasItems(other,ItPl_Health_Herb_01) && Npc_HasItems(other,ItPl_Health_Herb_02) && Npc_HasItems(other,ItPl_Health_Herb_03) && Npc_HasItems(other,ItPl_Dex_Herb_01) && Npc_HasItems(other,ItPl_Strength_Herb_01) && Npc_HasItems(other,ItPl_Speed_Herb_01) && Npc_HasItems(other,ItPl_Temp_Herb) && Npc_HasItems(other,ItPl_Perm_Herb))
	{
		Info_AddChoice (DIA_Constantino_HerbsRunning, "I've got all the plants I was supposed to bring you!", DIA_Constantino_HerbsRunning_Success);
	};
};

func void DIA_Constantino_HerbsRunning_Success()
{
	AI_Output (other, self, "DIA_Constantino_HerbsRunning_Success_15_00");	//I've got all the plants I was supposed to bring you!
	AI_Output (self, other, "DIA_Constantino_HerbsRunning_Success_10_01");	//What? You're pulling my leg, right?
	AI_PrintScreen("11 plants given",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	Npc_RemoveInvItems(other,ItPl_Mana_Herb_01,1);
	Npc_RemoveInvItems(other,ItPl_Mana_Herb_02,1);
	Npc_RemoveInvItems(other,ItPl_Mana_Herb_03,1);
	Npc_RemoveInvItems(other,ItPl_Health_Herb_01,1);
	Npc_RemoveInvItems(other,ItPl_Health_Herb_02,1);
	Npc_RemoveInvItems(other,ItPl_Health_Herb_03,1);
	Npc_RemoveInvItems(other,ItPl_Dex_Herb_01,1);
	Npc_RemoveInvItems(other,ItPl_Strength_Herb_01,1);
	Npc_RemoveInvItems(other,ItPl_Speed_Herb_01,1);
	Npc_RemoveInvItems(other,ItPl_Temp_Herb,1);
	Npc_RemoveInvItems(other,ItPl_Perm_Herb,1);
	CreateInvItems(self,ItPl_Mana_Herb_01,1);
	CreateInvItems(self,ItPl_Mana_Herb_02,1);
	CreateInvItems(self,ItPl_Mana_Herb_03,1);
	CreateInvItems(self,ItPl_Health_Herb_01,1);
	CreateInvItems(self,ItPl_Health_Herb_02,1);
	CreateInvItems(self,ItPl_Health_Herb_03,1);
	CreateInvItems(self,ItPl_Dex_Herb_01,1);
	CreateInvItems(self,ItPl_Strength_Herb_01,1);
	CreateInvItems(self,ItPl_Speed_Herb_01,1);
	CreateInvItems(self,ItPl_Temp_Herb,1);
	CreateInvItems(self,ItPl_Perm_Herb,1);
	AI_Output (self, other, "DIA_Constantino_HerbsRunning_Success_10_02");	//By Adanos! It's all there all right.
	AI_Output (self, other, "DIA_Constantino_HerbsRunning_Success_10_03");	//Who knows, maybe some day you could make a decent alchemist after all.
	MIS_Constantino_BringHerbs = LOG_SUCCESS;
	B_GivePlayerXP(XP_Constantino_Herbs);
	if(Player_IsApprentice == APP_NONE)
	{
		Log_CreateTopic(TOPIC_Lehrling,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Lehrling,LOG_Running);
		B_LogEntry(TOPIC_Lehrling,"Constantino will accept me as his apprentice, as long as the other masters approve.");
	};
	Info_ClearChoices(DIA_Constantino_HerbsRunning);
};

func void DIA_Constantino_HerbsRunning_Running()
{
	AI_Output (other, self, "DIA_Constantino_HerbsRunning_Running_15_00");	//I see.
	Info_ClearChoices (DIA_Constantino_HerbsRunning);
};


var int Constantino_StartGuild;

instance DIA_Constantino_LEHRLING(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 1;
	condition = DIA_Constantino_LEHRLING_Condition;
	information = DIA_Constantino_LEHRLING_Info;
	permanent = TRUE;
	description = "Can I become your apprentice now?";
};


func int DIA_Constantino_LEHRLING_Condition()
{
	if((MIS_Constantino_BringHerbs == LOG_SUCCESS) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Constantino_LEHRLING_Info()
{
	var int stimmen;
	stimmen = 0;
	AI_Output (other, self, "DIA_Constantino_LEHRLING_15_00");	//Can I become your apprentice now?
	if (B_GetGreatestPetzCrime (self) == CRIME_NONE)
	{
		AI_Output(self,other,"DIA_Constantino_LEHRLING_10_01");	//As far as I am concerned, yes..
		stimmen += 1;
		if(Harad.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_02");	//All that matters to Harad is that you will be able to defend the city if it is attacked by orcs.
			if ((MIS_Harad_Orc == LOG_SUCCESS) || (MIS_HakonBandits == LOG_SUCCESS))
			{
				AI_Output(self,other,"DIA_Constantino_LEHRLING_10_03");	//And it looks like you've got him convinced of that.
				stimmen += 1;
			}
			else
			{
				AI_Output (self, other, "DIA_Constantino_LEHRLING_10_04");	//But he thinks you are a coward.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_05");	//But Harad claims he has never seen you before.
		};
		if(Bosper.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_06");	//Bosper has been quite reluctant to comment on your qualities.
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_07");	//I suppose he would like to take you on as an apprentice himself.
			if ((MIS_Bosper_Bogen == LOG_SUCCESS) || (MIS_Bosper_WolfFurs == LOG_SUCCESS))
			{
				AI_Output(self,other,"DIA_Constantino_LEHRLING_10_08");	//But he still agreed in the end.
				stimmen += 1;
			}
			else
			{
				AI_Output (self, other, "DIA_Constantino_LEHRLING_10_09");	//To withhold one's approval for this reason is certainly not an honorable thing to do!
				AI_Output (self, other, "DIA_Constantino_LEHRLING_10_10");	//But if all other masters approve, you won't need his vote.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_11");	//And Bosper doesn't know you yet.
		};
		if(Thorben.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_12");	//Thorben is a very religious man.
			if (MIS_Thorben_GetBlessings == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Constantino_LEHRLING_10_13");	//He has given you his blessing. That is a good sign.
				stimmen += 1;
			}
			else
			{
				AI_Output (self, other, "DIA_Constantino_LEHRLING_10_14");	//He will only give you his approval with the blessing of the gods.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_15");	//Thorben does not know who you are.
		};
		if(Matteo.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			if(MIS_Matteo_Gold == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Constantino_LEHRLING_10_16");	//As for Matteo - he's singing your praises high and low.
				stimmen += 1;
			}
			else if(MIS_Matteo_Gold == LOG_Running)
			{
				AI_Output(self,other,"DIA_Constantino_LEHRLING_10_17");	//Matteo says there's still something you owe him. If you want his vote you had better take care of that little matter.
			}
			else if(MIS_Matteo_Gold == LOG_FAILED)
			{
				AI_Output(self,other,"DIA_Constantino_LEHRLING_10_19");	//Matteo says he has never seen you in his shop before.
			}
			else
			{
				AI_Output(self,other,"DIA_Constantino_LEHRLING_10_18");	//Matteo says he has not yet talked to you about this.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_19");	//Matteo says he has never seen you in his shop before.
		};
		if(stimmen >= 4)
		{
			if(stimmen == 5)
			{
				AI_Output (self, other, "DIA_Constantino_LEHRLING_10_20");	//This means you have the approval of all masters!
			}
			else
			{
				AI_Output (self, other, "DIA_Constantino_LEHRLING_10_21");	//You now have the approval of four masters. That will suffice for you to be accepted as an apprentice.
			};
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_22");	//Are you ready to begin your apprenticeship with me?
			Info_ClearChoices (DIA_Constantino_LEHRLING);
			Info_AddChoice (DIA_Constantino_LEHRLING, "I need to sleep on it first.", DIA_Constantino_LEHRLING_Later);
			Info_AddChoice (DIA_Constantino_LEHRLING, "Yes, Master.", DIA_Constantino_LEHRLING_Yes);
		}
		else
		{
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_23");	//You need the approval of at least four masters in order to be able to start an apprenticeship in the lower part of town.
			AI_Output (self, other, "DIA_Constantino_LEHRLING_10_24");	//This means that you should talk to all those who do not quite approve of you yet.
		};
	}
	else
	{
		B_Constantino_NoYouAreWanted();
		AI_Output(self,other,"DIA_Constantino_LEHRLING_10_26");	//I shall not take you on as an apprentice until you have settled this matter with the commander of the city guard.
	};
};

func void DIA_Constantino_LEHRLING_Yes()
{
	AI_Output (other, self, "DIA_Constantino_LEHRLING_Yes_15_00");	//Yes, Master.
	AI_Output (self, other, "DIA_Constantino_LEHRLING_Yes_10_01");	//(sighs) All right then! I hope I'm not going to regret this decision.
	AI_Output (self, other, "DIA_Constantino_LEHRLING_Yes_10_02");	//From this moment, you may consider yourself my apprentice.
	Player_IsApprentice = APP_Constantino;
	ApprenticeGoldCounter = 0;
	if(Hlp_IsValidNpc(Lothar) && !Npc_IsDead(Lothar))
	{
		Npc_ExchangeRoutine(Lothar,"START");
	};
	Constantino_StartGuild = other.guild;
	Constantino_Lehrling_Day = Wld_GetDay();
	Wld_AssignRoomToGuild("alchemist",GIL_NONE);
	MIS_Apprentice = LOG_SUCCESS;
	B_GivePlayerXP(XP_Lehrling);
	Log_CreateTopic(Topic_Bonus,LOG_NOTE);
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
		B_LogEntry(Topic_Bonus,"Constantino has accepted me as his apprentice. I now have access to the upper quarter.");
	}
	else
	{
		B_LogEntry(Topic_Bonus,"Constantino has accepted me as his apprentice.");
	};
	Info_ClearChoices(DIA_Constantino_LEHRLING);
};

func void DIA_Constantino_LEHRLING_Later()
{
	AI_Output (other, self, "DIA_Constantino_LEHRLING_Later_15_00");	//I need to sleep on it first.
	AI_Output (self, other, "DIA_Constantino_LEHRLING_Later_10_01");	//All right! If you cannot really put your heart into this, you should choose a different calling.
	Info_ClearChoices (DIA_Constantino_LEHRLING);
};


var int Constantino_MILKommentar;
var int Constantino_INNOSKommentar;

func void B_Constantino_NoLearnYouAreWanted()
{
	AI_Output(self,other,"DIA_Constantino_AlsLehrling_10_00");	//(irritated) I refuse to instruct you any further as long as you are accused of a crime in town.
};

instance DIA_Constantino_AlsLehrling(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 1;
	condition = DIA_Constantino_AlsLehrling_Condition;
	information = DIA_Constantino_AlsLehrling_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Constantino_AlsLehrling_Condition()
{
	if((Player_IsApprentice == APP_Constantino) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Constantino_AlsLehrling_Info()
{
	if(B_GetGreatestPetzCrime(self) > CRIME_NONE)
	{
		B_Constantino_NoLearnYouAreWanted();
		AI_Output(self,other,"DIA_Constantino_AlsLehrling_10_01");	//Go to Lord Andre and set matters right again.
		Constantino_Lehrling_Day = Wld_GetDay();
		AI_StopProcessInfos(self);
	}
	else if((other.guild == GIL_MIL) && (Constantino_StartGuild != GIL_MIL) && (Constantino_MILKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_02");	//So you have joined the militia? I've already heard about that.
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_03");	//Get yourself apprenticed in a hurry, and then up and join the militia? I'm not going to make it that easy for you.
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_04");	//I expect you to stick to our agreement and bring me plants and mushrooms on a regular basis.
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_05");	//If it's too much for you to work two jobs at once, you'll just have to sleep less!
		Constantino_MILKommentar = TRUE;
		Constantino_Lehrling_Day = Wld_GetDay();
	}
	else if(((VisibleGuild(other) == GIL_NOV) || (VisibleGuild(other) == GIL_KDF) || (VisibleGuild(other) == GIL_PAL)) && (Constantino_StartGuild != GIL_NOV) && (Constantino_StartGuild != GIL_KDF) && (Constantino_StartGuild != GIL_PAL) && (Constantino_INNOSKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_06");	//I see you have entered the service of Innos. I guess that means that, from now on, you cannot spare a lot of time just to fetch herbs for an old man.
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_07");	//Still, I consider it a great honor to have supported you on your way.
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_08");	//If, in spite of your new duties, you should find the time to occupy yourself with alchemy, you can always be sure of a warm welcome here.
		Constantino_INNOSKommentar = TRUE;
	}
	else if((Constantino_Lehrling_Day <= (Wld_GetDay() - 4)) && (Constantino_INNOSKommentar == FALSE))
	{
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_09");	//What have you been up to?
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_10");	//I expect more of my apprentice than just dropping in at my place once in a blue moon!
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_11");	//Did you at least bring me some mushrooms?
		Constantino_Lehrling_Day = Wld_GetDay ();
	}
	else
	{
		AI_Output (self, other, "DIA_Constantino_AlsLehrling_10_12");	//There you are again...
		Constantino_Lehrling_Day = Wld_GetDay ();
	};
};


instance DIA_Constantino_Aufgaben(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 2;
	condition = DIA_Constantino_Aufgaben_Condition;
	information = DIA_Constantino_Aufgaben_Info;
	permanent = FALSE;
	description = "What are my tasks?";
};


func int DIA_Constantino_Aufgaben_Condition()
{
	if(Player_IsApprentice == APP_Constantino)
	{
		return TRUE;
	};
};

func void DIA_Constantino_Aufgaben_Info()
{
	AI_Output (other, self, "DIA_Constantino_Aufgaben_15_00");	//What are my tasks?
	AI_Output (self, other, "DIA_Constantino_Aufgaben_10_01");	//I realize that I cannot expect a young man to spend all day indoors with me.
	AI_Output (self, other, "DIA_Constantino_Aufgaben_10_02");	//From time to time, you shall bring me the plants I need. In return, I shall instruct you in the art of alchemy.
	AI_Output (self, other, "DIA_Constantino_Aufgaben_10_03");	//You can buy the bottles from me. Most of the ingredients, however, you will have to get for yourself.
	AI_Output (self, other, "DIA_Constantino_Aufgaben_10_04");	//And I expect you to behave properly as a citizen of this town.
};


instance DIA_Constantino_Mushrooms(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 2;
	condition = DIA_Constantino_Mushrooms_Condition;
	information = DIA_Constantino_Mushrooms_Info;
	permanent = FALSE;
	description = "What plants am I supposed to bring?";
};


func int DIA_Constantino_Mushrooms_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Constantino_Aufgaben))
	{
		return TRUE;
	};
};

func void DIA_Constantino_Mushrooms_Info()
{
	AI_Output (other, self, "DIA_Constantino_Mushrooms_15_00");	//What plants am I supposed to bring?
	AI_Output (self, other, "DIA_Constantino_Mushrooms_10_01");	//I shall buy everything you bring me - and I'll pay the usual price.
	AI_Output (self, other, "DIA_Constantino_Mushrooms_10_02");	//For mushrooms, however, I shall pay you a special price.
	MIS_Constantino_Mushrooms = LOG_Running;
	Log_CreateTopic (Topic_Bonus, LOG_NOTE);
	B_LogEntry (Topic_Bonus, "I can sell mushrooms to Constantino for an especially good price.");
};


instance DIA_Constantino_MushroomsRunning(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 2;
	condition = DIA_Constantino_MushroomsRunning_Condition;
	information = DIA_Constantino_MushroomsRunning_Info;
	permanent = TRUE;
	description = "You wanted mushrooms...";
};


func int DIA_Constantino_MushroomsRunning_Condition()
{
	if(MIS_Constantino_Mushrooms == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Constantino_MushroomsRunning_Info()
{
	AI_Output (other, self, "DIA_Constantino_MushroomsRunning_15_00");	//You wanted mushrooms ...
	Info_ClearChoices (DIA_Constantino_MushroomsRunning);
	Info_AddChoice (DIA_Constantino_MushroomsRunning, "I'm going to bring you some ...", DIA_Constantino_MushroomsRunning_Later);
	if (Player_KnowsDunkelpilzBonus == FALSE)
	{
		Info_AddChoice(DIA_Constantino_MushroomsRunning,"Why are those things so important?",DIA_Constantino_MushroomsRunning_Why);
	};
	if(Npc_HasItems(other,ItPl_Mushroom_01))
	{
		Info_AddChoice(DIA_Constantino_MushroomsRunning,"I've got a few...",DIA_Constantino_MushroomsRunning_Sell);
	}
	else if(Npc_HasItems(other,ItPl_Mushroom_02))
	{
		Info_AddChoice(DIA_Constantino_MushroomsRunning,"I've got a few mushrooms here...",DIA_Constantino_MushroomsRunning_Sell);
	};
};

func void DIA_Constantino_MushroomsRunning_Sell()
{
	var int Mushroom1_Count;
	var int Mushroom2_Count;
	var int Dunkelpilz_dabei;
	Dunkelpilz_dabei = FALSE;
	if(Npc_HasItems(other,ItPl_Mushroom_01))
	{
		Mushroom1_Count = Npc_HasItems(other,ItPl_Mushroom_01);
		AI_Output(other,self,"DIA_Constantino_MushroomsRunning_Sell_15_00");	//I've got a few murky mushrooms here...
		AI_Output(self,other,"DIA_Constantino_MushroomsRunning_Sell_10_01");	//Ah! Those are the best! Well done! Here's your gold!
		Dunkelpilz_dabei = TRUE;
		Constantino_DunkelpilzCounter += Mushroom1_Count;
		ApprenticeGoldCounter += Mushroom1_Count * Value_Mushroom_01;
		B_GiveInvItems(self,other,ItMi_Gold,Mushroom1_Count * Value_Mushroom_01);
		B_GiveInvItems(other,self,ItPl_Mushroom_01,Mushroom1_Count);
	};
	if(Npc_HasItems(other,ItPl_Mushroom_02))
	{
		Mushroom2_Count = Npc_HasItems(other,ItPl_Mushroom_02);
		if(Dunkelpilz_dabei == TRUE)
		{
			AI_Output(other,self,"DIA_Constantino_MushroomsRunning_Sell_15_02");	//And here are some of the others...
		}
		else
		{
			AI_Output(other,self,"DIA_Constantino_MushroomsRunning_Sell_15_03");	//I've got a few mushrooms here!
		};
		AI_Output(self,other,"DIA_Constantino_MushroomsRunning_Sell_10_04");	//These are not quite as good as murky mushrooms, but I'll take them anyway.
		Constantino_BigMushroomsCounter += Mushroom2_Count;
		ApprenticeGoldCounter += Mushroom2_Count * Value_Mushroom_02;
		B_GiveInvItems(self,other,ItMi_Gold,Mushroom2_Count * Value_Mushroom_02);
		B_GiveInvItems(other,self,ItPl_Mushroom_02,Mushroom2_Count);
	};
	Info_ClearChoices(DIA_Constantino_MushroomsRunning);
};

func void DIA_Constantino_MushroomsRunning_Why()
{
	AI_Output (other, self, "DIA_Constantino_MushroomsRunning_Why_15_00");	//Why are those things so important?
	if (Constantino_DunkelpilzCounter == 0)
	{
		AI_Output (self, other, "DIA_Constantino_MushroomsRunning_Why_10_01");	//Even though you are my apprentice, I won't tell you everything.
	}
	else if(Constantino_DunkelpilzCounter >= 50)
	{
		AI_Output (self, other, "DIA_Constantino_MushroomsRunning_Why_10_02");	//All right - I shall tell you, then. But you must keep it to yourself.
		AI_Output (self, other, "DIA_Constantino_MushroomsRunning_Why_10_03");	//Murky mushrooms are full of magic energy. And every time you eat one, a little bit of this energy will accumulate in your body.
		AI_Output (self, other, "DIA_Constantino_MushroomsRunning_Why_10_04");	//Once you have eaten a sufficient amount of these mushrooms, your magic energy will increase ...
		AI_Output (self, other, "DIA_Constantino_MushroomsRunning_Why_10_05");	//If I had told you that earlier, you would have gobbled up all the mushrooms yourself, wouldn't you?
		AI_Output (other, self, "DIA_Constantino_MushroomsRunning_Why_15_06");	//(sighs) Oh, man!
		CreateInvItems(self,ItWr_MushroomMana,1);
		Player_KnowsDunkelpilzBonus = TRUE;
		Info_ClearChoices(DIA_Constantino_MushroomsRunning);
	}
	else
	{
		AI_Output (self, other, "DIA_Constantino_MushroomsRunning_Why_10_07");	//You have already asked me that. (mischievously) Who knows, maybe some day I'll actually tell you...
	};
};

func void DIA_Constantino_MushroomsRunning_Later()
{
	AI_Output (other, self, "DIA_Constantino_MushroomsRunning_Later_15_00");	//I'm going to bring you some ...
	AI_Output (self, other, "DIA_Constantino_MushroomsRunning_Later_10_01");	//Great! Bring me as many as you can find ...
	Info_ClearChoices (DIA_Constantino_MushroomsRunning);
};


func void B_Constantino_TeachAlchemy()
{
	Constantino_TeachAlchemy = TRUE;
	Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_CityTeacher,"Constantino can teach me the art of alchemy.");
};

func void B_Constantino_TeachAlchemyBasics()
{
	AI_Output (self, other, "DIA_Constantino_Alchemy_10_04");	//To prepare a potion at the alchemist's bench, you need a laboratory flask.
	AI_Output (self, other, "DIA_Constantino_Alchemy_10_05");	//You need to know the correct formulation and have the appropriate ingredients.
	AI_Output (self, other, "DIA_Constantino_Alchemy_10_06");	//There are quite a few formulations I could teach you.
	Alchemy_Explain = TRUE;
};

instance DIA_Constantino_Alchemy(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 2;
	condition = DIA_Constantino_Alchemy_Condition;
	information = DIA_Constantino_Alchemy_Info;
	permanent = TRUE;
	description = "Instruct me in the art of alchemy!";
};


func int DIA_Constantino_Alchemy_Condition()
{
	if((Player_IsApprentice == APP_Constantino) && (Constantino_TeachAlchemy == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Constantino_Alchemy_Info()
{
	AI_Output(other,self,"DIA_Constantino_Alchemy_15_00");	//Instruct me in the art of alchemy!
	if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
	{
		AI_Output (self, other, "DIA_Constantino_Alchemy_10_01");	//All right. Basics first.
		AI_Output (self, other, "DIA_Constantino_Alchemy_10_02");	//Each potion is made of plants - they possess all kinds of powers.
		AI_Output (self, other, "DIA_Constantino_Alchemy_10_03");	//They do nothing but put all their power into growth - and modifying this power is what the art of alchemy is about.
		B_Constantino_TeachAlchemyBasics();
		AI_Output (self, other, "DIA_Constantino_Alchemy_10_07");	//Potions which restore your lost strength, and even potions which affect your strength permanently.
		AI_Output (self, other, "DIA_Constantino_Alchemy_10_08");	//You cannot learn everything at once.
		B_Constantino_TeachAlchemy();
	}
	else
	{
		B_Constantino_NoLearnYouAreWanted();
		AI_StopProcessInfos(self);
	};
};


instance DIA_Constantino_NewRecipes(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 2;
	condition = DIA_Constantino_NewRecipes_Condition;
	information = DIA_Constantino_NewRecipes_Info;
	permanent = TRUE;
	description = "I'm looking for new recipes for potions.";
};


func int DIA_Constantino_NewRecipes_Condition()
{
	if((Player_IsApprentice != APP_Constantino) && (Constantino_TeachAlchemy == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Constantino_NewRecipes_Info()
{
	AI_Output(other,self,"DIA_Constantino_NewRecipes_15_00");	//I'm looking for new recipes for potions.
	if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
	{
		if(Player_IsApprentice > APP_NONE)
		{
			AI_Output(self,other,"DIA_Constantino_NewRecipes_10_01");	//Do you have any previous experience with alchemy?
			if(Npc_GetTalentSkill(other,NPC_TALENT_ALCHEMY))
			{
				AI_Output(other,self,"DIA_Constantino_NewRecipes_15_02");	//Yes, I do.
				AI_Output(self,other,"DIA_Constantino_NewRecipes_10_03");	//Yet you are still alive... those aren't bad qualifications.
				AI_Output(self,other,"DIA_Constantino_NewRecipes_10_04");	//I think I can tell you a few formulations. It depends, of course, on what you want to know.
				B_Constantino_TeachAlchemy();
			}
			else
			{
				DIA_Common_NoNotYet();
				AI_Output(self,other,"DIA_Constantino_BringHerbs_10_01");	//(sighs) I couldn't bear yet ANOTHER dilettante on my conscience.
				AI_StopProcessInfos(self);
			};
		}
		else
		{
			AI_Output(self,other,"DIA_Constantino_NewRecipes_10_04_add");	//Ты должен стать учеником в нижней части этого города.@@@
			AI_StopProcessInfos(self);
		};
	}
	else
	{
		B_Constantino_NoLearnYouAreWanted();
		AI_StopProcessInfos(self);
	};
};


instance DIA_Constantino_TEACH(C_Info)
{
	npc = VLK_417_Constantino;
	nr = 2;
	condition = DIA_Constantino_TEACH_Condition;
	information = DIA_Constantino_TEACH_Info;
	permanent = TRUE;
	description = "What recipes can you teach me?";
};


var int DIA_Constantino_Teach_permanent;

func int DIA_Constantino_TEACH_Condition()
{
	if((DIA_Constantino_Teach_permanent == FALSE) && (Constantino_TeachAlchemy == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Constantino_TEACH_Info()
{
	var int talente;
	talente = 0;
	AI_Output(other,self,"DIA_Constantino_TEACH_15_00");	//What recipes can you teach me?
	if(B_GetGreatestPetzCrime(self) == CRIME_NONE)
	{
		if((PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Health_02] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Health_03] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Perm_Health] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Perm_STR] == FALSE))
		{
			Info_ClearChoices(DIA_Constantino_TEACH);
			Info_AddChoice(DIA_Constantino_TEACH,Dialog_Back,DIA_Constantino_Teach_BACK);
		};
		if(PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE)
		{
			Info_AddChoice(DIA_Constantino_TEACH,B_BuildLearnString(NAME_HP_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_01)),DIA_Constantino_TEACH_Health01);
			talente += 1;
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Health_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_01] == TRUE))
		{
			Info_AddChoice(DIA_Constantino_TEACH,B_BuildLearnString(NAME_HP_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_02)),DIA_Constantino_TEACH_Health02);
			talente += 1;
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Health_03] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_02] == TRUE))
		{
			Info_AddChoice(DIA_Constantino_TEACH,B_BuildLearnString(NAME_HP_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_03)),DIA_Constantino_TEACH_Health03);
			talente += 1;
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Perm_Health] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_03] == TRUE))
		{
			Info_AddChoice(DIA_Constantino_TEACH,B_BuildLearnString(NAME_HPMax_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_Health)),DIA_Constantino_TEACH_PermHealth);
			talente += 1;
		};
		if(PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE)
		{
			Info_AddChoice(DIA_Constantino_TEACH,B_BuildLearnString(NAME_Mana_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_01)),DIA_Constantino_TEACH_Mana01);
			talente += 1;
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == TRUE))
		{
			Info_AddChoice(DIA_Constantino_TEACH,B_BuildLearnString(NAME_Mana_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_02)),DIA_Constantino_TEACH_Mana02);
			talente += 1;
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Perm_STR] == FALSE) && C_ShowAlchemySTRDEXDialog())
		{
			Info_AddChoice(DIA_Constantino_TEACH,B_BuildLearnString(NAME_STR_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_STR)),DIA_Constantino_TEACH_PermSTR);
			talente += 1;
		};
		if(talente > 0)
		{
			if(Alchemy_Explain == FALSE)
			{
				B_Constantino_TeachAlchemyBasics();
			};
			AI_Output(self,other,"DIA_Constantino_TEACH_10_02");	//I know a few - make your own choice.
		}
		else
		{
			AI_Output(self,other,"DIA_Constantino_TEACH_10_01");	//I'm sorry. There is nothing else I could teach you.
			DIA_Constantino_Teach_permanent = TRUE;
		};
	}
	else
	{
		B_Constantino_NoYouAreWanted();
		AI_StopProcessInfos(self);
	};	
};

func void DIA_Constantino_Teach_BACK()
{
	Info_ClearChoices(DIA_Constantino_TEACH);
};

func void DIA_Constantino_TEACH_Health01()
{
	if(B_TeachPlayerTalentAlchemy(self,other,POTION_Health_01))
	{
		AI_Output (self, other, "DIA_Constantino_TEACH_Health01_10_00");	//The ingredients for an essence of healing are healing plants and meadow knotweed.
	};
};

func void DIA_Constantino_TEACH_Health02()
{
	if(B_TeachPlayerTalentAlchemy(self,other,POTION_Health_02))
	{
		AI_Output (self, other, "DIA_Constantino_TEACH_Health02_10_00");	//To prepare a healing extract, you need healing herbs and meadow knotweed.
		AI_Output (self, other, "DIA_Constantino_TEACH_Health02_10_01");	//Be sure to heat that extract very carefully.
	};
};

func void DIA_Constantino_TEACH_Health03()
{
	if(B_TeachPlayerTalentAlchemy(self,other,POTION_Health_03))
	{
		AI_Output(self,other,"DIA_Constantino_TEACH_Health03_10_00");	//Creating an elixir of healing takes quite a bit of experience.
		AI_Output(self,other,"DIA_Constantino_TEACH_Health03_10_01");	//You need healing roots and meadow knotweed. Take special care when heating it this time.
	};
};

func void DIA_Constantino_TEACH_PermHealth()
{
	if(B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_Health))
	{
		AI_Output (self, other, "DIA_Constantino_TEACH_PermHealth_10_00");	//The elixir of life! A rare brew. Not so much because of the effort - the potion actually isn't all that hard to make.
		AI_Output (self, other, "DIA_Constantino_TEACH_PermHealth_10_01");	//But the ingredients are very rare. You need healing roots and king's sorrel.
	};
};

func void DIA_Constantino_TEACH_Mana01()
{
	if(B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_01))
	{
		AI_Output (self, other, "DIA_Constantino_TEACH_Mana01_10_00");	//The essence of magic is the simplest of magic potions.
		AI_Output (self, other, "DIA_Constantino_TEACH_Mana01_10_01");	//Take fire nettles and meadow knotweed and heat them slowly.
	};
};

func void DIA_Constantino_TEACH_Mana02()
{
	if(B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_02))
	{
		AI_Output (self, other, "DIA_Constantino_TEACH_Mana02_10_00");	//Since you can already prepare an essence of magic, with a little effort you should be able to produce an extract as well.
		AI_Output (self, other, "DIA_Constantino_TEACH_Mana02_10_01");	//You need to put the right kind of feeling into decocting that brew. Use fireweed and meadow knotweed for this potion.
	};
};

func void DIA_Constantino_TEACH_PermSTR()
{
	if(B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_STR))
	{
		AI_Output (self, other, "DIA_Constantino_TEACH_PermSTR_10_00");	//The elixir of strength! An excellent potion. You need the rare dragonroot and king's sorrel.
		AI_Output (self, other, "DIA_Constantino_TEACH_PermSTR_10_01");	//When boiling the brew, don't let the bubbles get too big or you'll be in for a nasty surprise!
	};
};

