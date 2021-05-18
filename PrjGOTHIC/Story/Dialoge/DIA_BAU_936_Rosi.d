
var int RosiTradeInfo;
var int RosiLocation;
var int RosiToldAboutBarrier;
var int RosiToldAboutMilitia;
var int RosiToldAboutOnar;

func void B_RosiTradeInfo()
{
	if(RosiTradeInfo == FALSE)
	{
		AI_Output(self,other,"DIA_Rosi_WASMACHSTDU_17_06");	//Would you like to buy something to eat, or perhaps something for hunting in the forest?
		if(RosiLocation == LOC_CITY)
		{
			Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
			B_LogEntry(TOPIC_CityTrader,"Rosi trades various goods.");
		}
		else if(RosiLocation == LOC_MONASTERY)
		{
			Log_CreateTopic(Topic_KlosterTrader,LOG_NOTE);
			B_LogEntry(Topic_KlosterTrader,"Rosi trades various goods.");
		}
		else if(RosiLocation == LOC_FARM)
		{
			Log_CreateTopic(TOPIC_SoldierTrader,LOG_NOTE);
			B_LogEntry(TOPIC_SoldierTrader,"Rosi trades various goods.");
		}
		else
		{
			Log_CreateTopic(TOPIC_OutTrader,LOG_NOTE);
			if(Rosi_FleeFromSekob_Kap5 == FALSE)
			{
				B_LogEntry(TOPIC_OutTrader,"Rosi trades various goods on Sekob's farm.");
			}
			else
			{
				B_LogEntry(TOPIC_OutTrader,"Rosi trades various goods.");
			};
		};
		RosiTradeInfo = TRUE;
	};
};

func void B_RosiAboutSekob()
{
	AI_Output(self,other,"DIA_Rosi_WASMACHSTDU_17_02");	//He's in debt everywhere. And so he steals goods from Onar's stocks and sells them in town.
	AI_Output(self,other,"DIA_Rosi_WASMACHSTDU_17_03");	//By now, he's accumulated a fortune with his underhanded dealings.
	AI_Output(self,other,"DIA_Rosi_WASMACHSTDU_17_04");	//And he works our field hands until their backs break. His own people call him nothing but slave-driver these days.
	RosiToldAboutSekob = TRUE;
};

instance DIA_Rosi_EXIT(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 999;
	condition = DIA_Rosi_EXIT_Condition;
	information = DIA_Rosi_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Rosi_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Rosi_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Rosi_HALLO(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 3;
	condition = DIA_Rosi_HALLO_Condition;
	information = DIA_Rosi_HALLO_Info;
	description = "Everything all right with you?";
};


func int DIA_Rosi_HALLO_Condition()
{
	if(Rosi_FleeFromSekob_Kap5 == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Rosi_HALLO_Info()
{
	AI_Output (other, self, "DIA_Rosi_HALLO_15_00");	//Everything all right with you?
	AI_Output (self, other, "DIA_Rosi_HALLO_17_01");	//Well, it's so-so. My back hurts from all this hard labor. What are you doing here? I don't get visitors here all that often.
	if (hero.guild != GIL_MIL)
	{
		AI_Output(self,other,"DIA_Rosi_HALLO_17_02");	//Usually, it's either some cutthroats from the mountains, or those horrible militia soldiers from the city.
		RosiToldAboutMilitia = TRUE;
		if(other.guild != GIL_NONE)
		{
			AI_Output(self,other,"DIA_Rosi_HALLO_17_03");	//They've been raiding our farm rather frequently lately. But you don't look like you're one of them, or are you?
		};
	};
};


instance DIA_Rosi_WASMACHSTDU(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 4;
	condition = DIA_Rosi_WASMACHSTDU_Condition;
	information = DIA_Rosi_WASMACHSTDU_Info;
	description = "What are you doing here?";
};


func int DIA_Rosi_WASMACHSTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rosi_HALLO) && (Rosi_FleeFromSekob_Kap5 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Rosi_WASMACHSTDU_Info()
{
	AI_Output(other,self,"DIA_Rosi_WASMACHSTDU_15_00");	//What are you doing here?
	if(!Npc_IsDead(Sekob))
	{
		AI_Output(self,other,"DIA_Rosi_WASMACHSTDU_17_01");	//I've been asking myself that for several years. Sekob, my husband, has fallen out with everyone in the area by now.
		B_RosiAboutSekob();
		AI_Output(self,other,"DIA_Rosi_WASMACHSTDU_17_05");	//I'm not particularly proud to call myself the wife of Sekob, believe me. Sometimes I wish the Barrier were still in place.
		RosiToldAboutBarrier = TRUE;
	};
	B_RosiTradeInfo();
};


instance DIA_Rosi_WAREZ(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 2;
	condition = DIA_Rosi_WAREZ_Condition;
	information = DIA_Rosi_WAREZ_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "What can you offer me?";
};


func int DIA_Rosi_WAREZ_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Rosi_WASMACHSTDU) || Npc_KnowsInfo(other,DIA_Rosi_FLEEFROMSEKOB)) && (MIS_bringRosiBackToSekob != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Rosi_WAREZ_Info()
{
	AI_Output(other,self,"DIA_Rosi_WAREZ_15_00");	//What can you offer me?
	B_RosiTradeInfo();
	AI_Output(self,other,"DIA_Rosi_WAREZ_17_01");	//What do you want?
	B_GiveTradeInv(self);
	if(MIS_Serpentes_MinenAnteil_KDF == LOG_Running)
	{
		RosiMinenAnteil = TRUE;
	};
	Trade_IsActive = TRUE;
};


instance DIA_Rosi_BARRIERE(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 6;
	condition = DIA_Rosi_BARRIERE_Condition;
	information = DIA_Rosi_BARRIERE_Info;
	description = "Barrier?";
};


func int DIA_Rosi_BARRIERE_Condition()
{
	if((RosiToldAboutBarrier == TRUE) && (MIS_bringRosiBackToSekob != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Rosi_BARRIERE_Info()
{
	AI_Output (other, self, "DIA_Rosi_BARRIERE_15_00");	//Barrier?
	AI_Output (self, other, "DIA_Rosi_BARRIERE_17_01");	//Well, the dome that used to enclose the old Valley of Mines.
	AI_Output (self, other, "DIA_Rosi_BARRIERE_17_02");	//Many of the farmers and workers who committed a crime back then were simply tossed in there, and they never came back.
};


instance DIA_Rosi_DuInBarriere(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 10;
	condition = DIA_Rosi_DuInBarriere_Condition;
	information = DIA_Rosi_DuInBarriere_Info;
	description = "Have you ever been at the Barrier?";
};


func int DIA_Rosi_DuInBarriere_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rosi_BARRIERE) && (MIS_bringRosiBackToSekob != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Rosi_DuInBarriere_Info()
{
	AI_Output (other, self, "DIA_Rosi_DuInBarriere_15_00");	//Have you ever been at the Barrier?
	AI_Output (self, other, "DIA_Rosi_DuInBarriere_17_01");	//No. We only heard about it. Bengar, the farmer on the high pastures, can surely tell you more about that.
};


instance DIA_Rosi_BENGAR(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 11;
	condition = DIA_Rosi_BENGAR_Condition;
	information = DIA_Rosi_BENGAR_Info;
	description = "How can I get to Bengar's farm?";
};


func int DIA_Rosi_BENGAR_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rosi_DuInBarriere) && (MIS_bringRosiBackToSekob != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Rosi_BENGAR_Info()
{
	AI_Output(other,self,"DIA_Rosi_BENGAR_15_00");	//How can I get to Bengar's farm?
	AI_Output(self,other,"DIA_Rosi_DuInBarriere_17_02");	//His farm is quite close to the pass which leads to the Valley of Mines.
	if((BalthasarMovedToBengar == FALSE) && !Npc_IsDead(Balthasar))
	{
		AI_Output(self,other,"DIA_Rosi_BENGAR_17_01");	//Go ask Balthasar. He's our shepherd. He sometimes leads his animals to graze on Bengar's pastures up there.
		AI_Output(self,other,"DIA_Rosi_BENGAR_17_02");	//He'll be able to tell you how to get there.
	};
};


instance DIA_Rosi_Miliz(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 7;
	condition = DIA_Rosi_Miliz_Condition;
	information = DIA_Rosi_Miliz_Info;
	description = "Why do the militia attack you on your farms here?";
};


func int DIA_Rosi_Miliz_Condition()
{
	if((RosiToldAboutMilitia == TRUE) && (MIS_bringRosiBackToSekob != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Rosi_Miliz_Info()
{
	AI_Output(other,self,"DIA_Rosi_Miliz_15_00");	//Why do the militia attack you on your farms here?
	if(hero.guild != GIL_MIL)
	{
		AI_Output(self,other,"DIA_Rosi_Miliz_17_01");	//Because there's nobody there to prevent them from simply plundering our farms instead of buying our goods.
		AI_Output(self,other,"DIA_Rosi_Miliz_17_02");	//The king is far away, and we just have to put up with working for Onar and hoping that Onar will send help when we really need it.
		RosiToldAboutOnar = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Rosi_Miliz_17_02_add");	//The king is far away...@@@
	};
};


instance DIA_Rosi_ONAR(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 8;
	condition = DIA_Rosi_ONAR_Condition;
	information = DIA_Rosi_ONAR_Info;
	description = "What does Onar's help look like?";
};


func int DIA_Rosi_ONAR_Condition()
{
	if((RosiToldAboutOnar == TRUE) && (MIS_bringRosiBackToSekob != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Rosi_ONAR_Info()
{
	AI_Output(other,self,"DIA_Rosi_ONAR_15_00");	//What does Onar's help look like?
	AI_Output(self,other,"DIA_Rosi_ONAR_17_01");	//Sometimes we receive warning in advance when some militiamen are planning to pay us a visit on their own account to rob us.
	if(hero.guild != GIL_MIL)
	{
		AI_Output(self,other,"DIA_Rosi_ONAR_17_02");	//Then we send somebody to the old landowner to ask him for help.
		AI_Output(self,other,"DIA_Rosi_ONAR_17_03");	//And then, usually, it doesn't take long for the mercenaries he pays to come here and chase off the militia.
	};
	if((hero.guild != GIL_SLD) && (hero.guild != GIL_DJG))
	{
		AI_Output(self,other,"DIA_Rosi_ONAR_17_04");	//But, when all is said and done, the mercenaries aren't much better.
	};
};


instance DIA_Rosi_PERMKAP1(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 80;
	condition = DIA_Rosi_PERMKAP1_Condition;
	information = DIA_Rosi_PERMKAP1_Info;
	permanent = TRUE;
	description = "Keep your chin up.";
};


func int DIA_Rosi_PERMKAP1_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rosi_WASMACHSTDU) || Npc_KnowsInfo(other,DIA_Rosi_FLEEFROMSEKOB))
	{
		return TRUE;
	};
};

func void DIA_Rosi_PERMKAP1_Info()
{
	AI_Output (other, self, "DIA_Rosi_PERMKAP1_15_00");	//Keep your chin up.
	if (MIS_bringRosiBackToSekob == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Rosi_PERMKAP1_17_01");	//Go jump in the lake.
	}
	else
	{
		AI_Output (self, other, "DIA_Rosi_PERMKAP1_17_02");	//Take care of yourself and don't let them get to you.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Rosi_FLEEFROMSEKOB(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 50;
	condition = DIA_Rosi_FLEEFROMSEKOB_Condition;
	information = DIA_Rosi_FLEEFROMSEKOB_Info;
	description = "What are you doing here in the wilderness?";
};


func int DIA_Rosi_FLEEFROMSEKOB_Condition()
{
	if(Rosi_FleeFromSekob_Kap5 == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Rosi_FLEEFROMSEKOB_Info()
{
	AI_Output (other, self, "DIA_Rosi_FLEEFROMSEKOB_15_00");	//What are you doing here in the wilderness?
	AI_Output (self, other, "DIA_Rosi_FLEEFROMSEKOB_17_01");	//I couldn't take it any more on Sekob's farm. Sekob threw one hissy fit after another.
	if(RosiToldAboutSekob == FALSE)
	{
		B_RosiAboutSekob();
	};
	AI_Output (self, other, "DIA_Rosi_FLEEFROMSEKOB_17_02");	//In the end, one couldn't talk to him at all. All he would do was yell.
	AI_Output (self, other, "DIA_Rosi_FLEEFROMSEKOB_17_03");	//I must get away from here, but I don't know where to turn.
	AI_Output (self, other, "DIA_Rosi_FLEEFROMSEKOB_17_04");	//Interested in a little deal?
	B_GivePlayerXP(XP_AmbientKap5);
	RosiFoundKap5 = TRUE;
};


instance DIA_Rosi_HILFE(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 51;
	condition = DIA_Rosi_HILFE_Condition;
	information = DIA_Rosi_HILFE_Info;
	description = "I'll get you out of here.";
};


func int DIA_Rosi_HILFE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rosi_FLEEFROMSEKOB))
	{
		return TRUE;
	};
};

func void DIA_Rosi_HILFE_Info()
{
	AI_Output (other, self, "DIA_Rosi_HILFE_15_00");	//I'll get you out of here.
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL) || (hero.guild == GIL_NONE))
	{
		AI_Output(other,self,"DIA_Rosi_HILFE_15_01");	//I could take you to the city.
	}
	else if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output(other,self,"DIA_Rosi_HILFE_15_02");	//I'll bring you to the landowner's farm.
	}
	else if((hero.guild == GIL_NOV) || (hero.guild == GIL_KDF))
	{
		AI_Output(other,self,"DIA_Rosi_HILFE_15_03");	//Come away to the monastery. You'll be welcome there.
	};
	AI_Output(self,other,"DIA_Rosi_HILFE_17_04");	//I'll never forget what you did for me. I'll pay you, of course.
	if(Npc_IsDead(Till))
	{
		AI_Output(self,other,"DIA_Rosi_HILFE_17_05");	//You go first. I'll follow.
	}
	else
	{
		Till.aivar[AIV_PARTYMEMBER] = TRUE;
		AI_Output(self,other,"DIA_Rosi_HILFE_17_06");	//You go first. We'll follow.
	};
	AI_StopProcessInfos(self);
	if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL) || (hero.guild == GIL_NONE))
	{
		Npc_ExchangeRoutine(self,"FollowCity");
		B_StartOtherRoutine(Till,"FollowCity");
	}
	else if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		Npc_ExchangeRoutine(self,"FollowBigfarm");
		B_StartOtherRoutine(Till,"FollowBigfarm");
	}
	else if((hero.guild == GIL_NOV) || (hero.guild == GIL_KDF))
	{
		Npc_ExchangeRoutine(self,"FollowKloster");
		B_StartOtherRoutine(Till,"FollowKloster");
	};
	if(!Npc_KnowsInfo(other,DIA_Babera_Rosi))
	{
		Log_CreateTopic(TOPIC_RosisFlucht,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_RosisFlucht,LOG_Running);
		B_LogEntry(TOPIC_RosisFlucht,"Rosi couldn't stand it on Sekob's farm any longer and now she doesn't know where to go. I'll lead her out of the wilderness.");
	};
	MIS_RosisFlucht = LOG_Running;
};


instance DIA_Rosi_ANGEKOMMEN(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 55;
	condition = DIA_Rosi_ANGEKOMMEN_Condition;
	information = DIA_Rosi_ANGEKOMMEN_Info;
	important = TRUE;
};


func int DIA_Rosi_ANGEKOMMEN_Condition()
{
	if((MIS_bringRosiBackToSekob != LOG_SUCCESS) && (Rosi_FleeFromSekob_Kap5 == TRUE))
	{
		if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL) || (hero.guild == GIL_NONE))
		{
			if((Npc_GetDistToWP(self,"CITY1") < 6000) || (Npc_GetDistToWP(self,"CITY2") < 6000))
			{
				return TRUE;
			};
		}
		else if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
		{
			if(Npc_GetDistToWP(self,"NW_BIGFARM_KITCHEN_02") < 6000)
			{
				return TRUE;
			};
		}
		else if((hero.guild == GIL_NOV) || (hero.guild == GIL_KDF))
		{
			if(Npc_GetDistToWP(self,"KLOSTER") < 6000)
			{
				return TRUE;
			};
		};
	};
};

func void DIA_Rosi_ANGEKOMMEN_Info()
{
	AI_Output (self, other, "DIA_Rosi_ANGEKOMMEN_17_00");	//I'll find my own way from here.
	AI_Output (self, other, "DIA_Rosi_ANGEKOMMEN_17_01");	//Thank you. I don't know what I would have done without you.
	self.aivar[AIV_PARTYMEMBER] = FALSE;
//	MIS_bringRosiBackToSekob = LOG_OBSOLETE;
	MIS_RosisFlucht = LOG_SUCCESS;
	AI_Output(self,other,"DIA_Rosi_ANGEKOMMEN_17_02");	//Please accept this modest gift as a reward.
	AI_WaitTillEnd(other,self);
	CreateInvItems(self,ItMi_Gold,650);
	B_GiveInvItems(self,other,ItMi_Gold,650);
	if(Npc_IsDead(Till))
	{
		B_GivePlayerXP(XP_SavedRosi);
	}
	else
	{
		Till.aivar[AIV_PARTYMEMBER] = FALSE;
		B_GivePlayerXP(XP_SavedRosi + XP_AmbientKap5);
	};
	AI_StopProcessInfos(self);
	if((Npc_GetDistToWP(self,"CITY1") < 8000) || (Npc_GetDistToWP(self,"CITY2") < 8000))
	{
		Npc_ExchangeRoutine(self,"CITY");
		B_StartOtherRoutine(Till,"CITY");
		RosiLocation = LOC_CITY;
	}
	else if(Npc_GetDistToWP(self,"NW_BIGFARM_KITCHEN_02") < 8000)
	{
		Npc_ExchangeRoutine(self,"BIGFARM");
		B_StartOtherRoutine(Till,"BIGFARM");
		RosiLocation = LOC_FARM;
	}
	else if(Npc_GetDistToWP(self,"KLOSTER") < 8000)
	{
		Npc_ExchangeRoutine(self,"KLOSTER");
		B_StartOtherRoutine(Till,"KLOSTER");
		RosiLocation = LOC_MONASTERY;
	};
};


instance DIA_Rosi_TRAIT(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 55;
	condition = DIA_Rosi_TRAIT_Condition;
	information = DIA_Rosi_TRAIT_Info;
	description = "See, now you're home again.";
};


func int DIA_Rosi_TRAIT_Condition()
{
	if(MIS_bringRosiBackToSekob == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Rosi_TRAIT_Info()
{
	AI_Output (other, self, "DIA_Rosi_TRAIT_15_00");	//See, now you're home again.
	AI_Output (self, other, "DIA_Rosi_TRAIT_17_01");	//You are the worst piece of dung I've met in my life, you filthy swine.
	AI_StopProcessInfos(self);
	MIS_RosisFlucht = LOG_FAILED;
	B_GivePlayerXP(XP_AmbientKap5);
};


instance DIA_Rosi_MinenAnteil(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 3;
	condition = DIA_Rosi_MinenAnteil_Condition;
	information = DIA_Rosi_MinenAnteil_Info;
	description = "Selling illegal mine shares - have you no shame?";
};


func int DIA_Rosi_MinenAnteil_Condition()
{
	if((hero.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running) && (RosiMinenAnteil == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Rosi_MinenAnteil_Info()
{
	AI_Output(other,self,"DIA_Rosi_Minenanteil_15_00");	//Selling illegal mine shares - have you no shame?
	if(MIS_bringRosiBackToSekob != LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Rosi_Minenanteil_17_01");	//No. I need to live, too, and I'm not the one who brought them into circulation.
	}
	else
	{
		B_Say(self,other,"$GETOUTOFHERE");
		AI_StopProcessInfos(self);
	};
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Rosi_PICKPOCKET(C_Info)
{
	npc = BAU_936_Rosi;
	nr = 900;
	condition = DIA_Rosi_PICKPOCKET_Condition;
	information = DIA_Rosi_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40_Female;
};


func int DIA_Rosi_PICKPOCKET_Condition()
{
	return C_Beklauen(30,75);
};

func void DIA_Rosi_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Rosi_PICKPOCKET);
	Info_AddChoice(DIA_Rosi_PICKPOCKET,Dialog_Back,DIA_Rosi_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Rosi_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Rosi_PICKPOCKET_DoIt);
};

func void DIA_Rosi_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Rosi_PICKPOCKET);
};

func void DIA_Rosi_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Rosi_PICKPOCKET);
};

