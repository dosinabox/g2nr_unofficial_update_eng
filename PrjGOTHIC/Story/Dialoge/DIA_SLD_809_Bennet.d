
func void B_UpdateBennetItemsCount()
{
	if((Bennet_ItemsGiven_Chapter_1 == TRUE) && (Kapitel == 1))
	{
		Bennet_NW_ItMi_Swordraw_Count = Npc_HasItems(self,ItMiSwordraw);
	};
	if((Bennet_ItemsGiven_Chapter_2 == TRUE) && (Kapitel == 2))
	{
		Bennet_NW_ItMi_Swordraw_Count = Npc_HasItems(self,ItMiSwordraw);
	};
	if((Bennet_ItemsGiven_Chapter_3 == TRUE) && (Kapitel == 3))
	{
		Bennet_NW_ItMi_Swordraw_Count = Npc_HasItems(self,ItMiSwordraw);
		Bennet_NW_ItMi_Nugget_Count = Npc_HasItems(self,ItMi_Nugget);
	};
	if((Bennet_ItemsGiven_Chapter_4 == TRUE) && (Kapitel == 4))
	{
		Bennet_NW_ItMi_Swordraw_Count = Npc_HasItems(self,ItMiSwordraw);
		Bennet_NW_ItMi_Nugget_Count = Npc_HasItems(self,ItMi_Nugget);
	};
	if((Bennet_ItemsGiven_Chapter_5 == TRUE) && (Kapitel == 5))
	{
		Bennet_NW_ItMi_Swordraw_Count = Npc_HasItems(self,ItMiSwordraw);
		Bennet_NW_ItMi_Nugget_Count = Npc_HasItems(self,ItMi_Nugget);
	};
};

var int Bennet_Kap1Smith_Alt;
var int Bennet_Kap2Smith_Alt;
var int Bennet_Kap3Smith_Alt;
var int Bennet_Kap4Smith_Alt;
var int Bennet_Kap5Smith_Alt;

var int Bennet_Kap2Smith;
var int Bennet_Kap3Smith;
var int Bennet_Kap4Smith;
var int Bennet_Kap5Smith;

func int C_Bennet_HaveNewWeapons()
{
	if(Bennet_TeachSmith == TRUE)
	{
		if(AlternativeSmithing == FALSE)
		{
			if((Kapitel == 2) && (Bennet_Kap2Smith == FALSE))
			{
				return TRUE;
			}
			else if((Kapitel == 3) && (MIS_ReadyforChapter4 == FALSE) && (Bennet_Kap3Smith == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
			{
				return TRUE;
			}
			else if((Kapitel < 5) && (MIS_ReadyforChapter4 == TRUE) && (Bennet_Kap4Smith == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
			{
				return TRUE;
			}
			else if((Kapitel >= 5) && (Bennet_Kap5Smith == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
			{
				return TRUE;
			};
		}
		else
		{
			if((Kapitel == 1) && (Bennet_Kap1Smith_Alt == FALSE))
			{
				return TRUE;
			}
			else if((Kapitel == 2) && (Bennet_Kap2Smith_Alt == FALSE))
			{
				return TRUE;
			}
			else if((Kapitel < 5) && (Bennet_Kap3Smith_Alt == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
			{
				return TRUE;
			}
			else if((Kapitel >= 5) && (Bennet_Kap5Smith_Alt == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
			{
				return TRUE;
			};
		};
	};
	return FALSE;
};

func void DIA_Bennet_SmithComment1()
{
	AI_Output(self,other,"DIA_Bennet_TeachSmith_06_01");	//I can teach you how to forge magic ore swords, or even two-handed blades.
};

func void DIA_Bennet_SmithComment2()
{
	AI_Output(self,other,"DIA_Bennet_TeachSmith_06_02");	//I have improved my technique. Now I can teach you how to make bastard swords or heavy two-handed swords with ore.
};

func void DIA_Bennet_SmithComment3()
{
	AI_Output(self,other,"DIA_Bennet_TeachSmith_06_03");	//I think I've outdone myself this time. I've designed two battle blades. That's the best thing I've seen so far.
};

func void DIA_Bennet_SmithComment4()
{
		AI_Output (self, other, "DIA_Bennet_TeachSmith_06_04");	//Listen. I think I just had an ingenious inspiration. Magic ore weapons, coated with dragon blood. And I know exactly how I'll go about it!
		AI_Output (self, other, "DIA_Bennet_TeachSmith_06_05");	//(grins) Do you want to know?
};

instance DIA_Bennet_AnnounceNewWeapons(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 10;
	condition = DIA_Bennet_AnnounceNewWeapons_Condition;
	information = DIA_Bennet_AnnounceNewWeapons_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Bennet_AnnounceNewWeapons_Condition()
{
	if(C_Bennet_HaveNewWeapons())
	{
		return TRUE;
	};
};

func void DIA_Bennet_AnnounceNewWeapons_Info()
{
	if(AlternativeSmithing == FALSE)
	{
		if((Kapitel == 2) && (Bennet_Kap2Smith == FALSE))
		{
			DIA_Bennet_SmithComment1();
			Bennet_Kap2Smith = TRUE;
		}
		else if((Kapitel == 3) && (MIS_ReadyforChapter4 == FALSE) && (Bennet_Kap3Smith == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
		{
			DIA_Bennet_SmithComment2();
			Bennet_Kap3Smith = TRUE;
		}
		else if((Kapitel < 5) && (MIS_ReadyforChapter4 == TRUE) && (Bennet_Kap4Smith == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
		{
			DIA_Bennet_SmithComment3();
			Bennet_Kap4Smith = TRUE;
		}
		else if((Kapitel >= 5) && (Bennet_Kap5Smith == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
		{
			DIA_Bennet_SmithComment4();
			Bennet_Kap5Smith = TRUE;
		};
	}
	else
	{
		if((Kapitel == 1) && (Bennet_Kap1Smith_Alt == FALSE))
		{
			DIA_Bennet_SmithComment1();
			Bennet_Kap1Smith_Alt = TRUE;
		}
		else if((Kapitel == 2) && (Bennet_Kap2Smith_Alt == FALSE))
		{
			DIA_Bennet_SmithComment2();
			Bennet_Kap2Smith_Alt = TRUE;
		}
		else if((Kapitel < 5) && (Bennet_Kap3Smith_Alt == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
		{
			DIA_Bennet_SmithComment3();
			Bennet_Kap3Smith_Alt = TRUE;
		}
		else if((Kapitel >= 5) && (Bennet_Kap5Smith_Alt == FALSE) && Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
		{
			DIA_Bennet_SmithComment4();
			Bennet_Kap5Smith_Alt = TRUE;
		};
	};
};


instance DIA_Bennet_EXIT(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 999;
	condition = DIA_Bennet_EXIT_Condition;
	information = DIA_Bennet_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Bennet_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Bennet_EXIT_Info()
{
	B_EquipTrader(self);
	B_UpdateBennetItemsCount();
	if(C_Bennet_HaveNewWeapons())
	{
		DIA_Bennet_AnnounceNewWeapons_Info();
	};
	AI_StopProcessInfos(self);
};


instance DIA_Bennet_HALLO(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 1;
	condition = DIA_Bennet_HALLO_Condition;
	information = DIA_Bennet_HALLO_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Bennet_HALLO_Condition()
{
	if((Kapitel < 3) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Bennet_HALLO_Info()
{
	AI_Output(self,other,"DIA_Bennet_HALLO_06_00");	//I do not sell any weapons. Khaled does. He is in the house with Onar.
	if(Khaled_weiter == FALSE)
	{
		Log_CreateTopic(TOPIC_SoldierTrader,LOG_NOTE);
		B_LogEntry(TOPIC_SoldierTrader,"Khaled is a weapons dealer.");
	};
};


instance DIA_Bennet_TRADE(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 700;
	condition = DIA_Bennet_TRADE_Condition;
	information = DIA_Bennet_TRADE_Info;
	permanent = TRUE;
	description = "What about forging equipment?";
	trade = TRUE;
};


func int DIA_Bennet_TRADE_Condition()
{
	if((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Bennet_TRADE_Info()
{
	if(Bennet_flag == TRUE)
	{
		B_ClearSmithInv(self);
		if(Bennet_swordraws > 0)
		{
			CreateInvItems(self,ItMiSwordraw,Bennet_swordraws);
		};
		Bennet_flag = FALSE;
	};
	AI_Output(other,self,"DIA_Bennet_TRADE_15_00");	//What about forging equipment?
	B_GiveTradeInv(self);
	if(TradersHaveLimitedAmmo == TRUE)
	{
		if(Bennet_Ammo_Day <= Wld_GetDay())
		{
			B_RefreshAmmo(self,50);
	 		Bennet_Ammo_Day = Wld_GetDay() + 1;
		};
	}
	else
	{
		B_RefreshAmmo(self,50);
	};
	AI_Output(self,other,"DIA_Bennet_TRADE_06_01");	//What do you need?
	if(BennetLOG == FALSE)
	{
		Log_CreateTopic(TOPIC_SoldierTrader,LOG_NOTE);
		B_LogEntry(TOPIC_SoldierTrader,"Bennet sells smithery equipment.");
		BennetLOG = TRUE;
	};
	if(!Npc_HasItems(self,ItMw_1H_Mace_L_04) && !Npc_HasItems(other,ItMw_1H_Mace_L_04) && (PLAYER_TALENT_SMITH[WEAPON_Common] == TRUE))
	{
		CreateInvItems(self,ItMw_1H_Mace_L_04,1);
	};
	Trade_IsActive = TRUE;
};


instance DIA_Bennet_WhichWeapons(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 2;
	condition = DIA_Bennet_WhichWeapons_Condition;
	information = DIA_Bennet_WhichWeapons_Info;
	permanent = FALSE;
	description = "What kinds of weapons do you make?";
};


func int DIA_Bennet_WhichWeapons_Condition()
{
	if(((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)) && (MIS_Bennet_BringOre == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Bennet_WhichWeapons_Info()
{
	AI_Output (other, self, "DIA_Bennet_WhichWeapons_15_00");	//What kinds of weapons do you make?
	AI_Output (self, other, "DIA_Bennet_WhichWeapons_06_01");	//Plain swords at the moment, not much else.
	AI_Output (self, other, "DIA_Bennet_WhichWeapons_06_02");	//But if I had some magic ore I could forge weapons that are better than all comparable weapons made from regular old steel.
	AI_Output (self, other, "DIA_Bennet_WhichWeapons_06_03");	//You wouldn't happen to know where to find some around here? (laughs) Besides in the Valley of Mines, I mean.
	AI_Output (other, self, "DIA_Bennet_WhichWeapons_15_04");	//No.
	AI_Output (self, other, "DIA_Bennet_WhichWeapons_06_05");	//Of course not.
};


instance DIA_Bennet_BauOrSld(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 3;
	condition = DIA_Bennet_BauOrSld_Condition;
	information = DIA_Bennet_BauOrSld_Info;
	permanent = FALSE;
	description = "Are you with the farmers or the mercenaries?";
};


func int DIA_Bennet_BauOrSld_Condition()
{
	if((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Bennet_BauOrSld_Info()
{
	AI_Output (other, self, "DIA_Bennet_BauOrSld_15_00");	//Are you with the farmers or the mercenaries?
	AI_Output (self, other, "DIA_Bennet_BauOrSld_06_01");	//You're pulling my leg, aren't you?
	AI_Output (other, self, "DIA_Bennet_BauOrSld_15_02");	//I was just curious.
	AI_Output (self, other, "DIA_Bennet_BauOrSld_06_03");	//Have you ever seen a farmer who also forges weapons?
	AI_Output (other, self, "DIA_Bennet_BauOrSld_15_04");	//No.
	AI_Output (self, other, "DIA_Bennet_BauOrSld_06_05");	//Then why do you ask such stupid questions?
};


instance DIA_Bennet_WannaJoin(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 4;
	condition = DIA_Bennet_WannaJoin_Condition;
	information = DIA_Bennet_WannaJoin_Info;
	permanent = TRUE;
	description = "I want to join the mercenaries!";
};


func int DIA_Bennet_WannaJoin_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bennet_BauOrSld) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Bennet_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Bennet_WannaJoin_15_00");	//I want to join the mercenaries!
	AI_Output (self, other, "DIA_Bennet_WannaJoin_06_01");	//Stop blabbering then, go to Torlof and let him put you to the test.
	if ((MIS_Torlof_HolPachtVonSekob == LOG_SUCCESS) || (MIS_Torlof_BengarMilizKlatschen == LOG_SUCCESS))
	{
		AI_Output (other, self, "DIA_Bennet_WannaJoin_15_02");	//I have passed the test.
		AI_Output (self, other, "DIA_Bennet_WannaJoin_06_03");	//Good, I'll vote for you, then.
		SCKnowsSLDVotes = TRUE;
	};
};


instance DIA_Bennet_WannaSmith(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 5;
	condition = DIA_Bennet_WannaSmith_Condition;
	information = DIA_Bennet_WannaSmith_Info;
	permanent = TRUE;
	description = "Can you teach me how to forge a sword?";
};


func int DIA_Bennet_WannaSmith_Condition()
{
	if((PLAYER_TALENT_SMITH[WEAPON_Common] == FALSE) && (Bennet_TeachCommon == FALSE) && ((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Bennet_WannaSmith_Info()
{
	AI_Output (other, self, "DIA_Bennet_WannaSmith_15_00");	//Can you teach me how to forge a sword?
	AI_Output (self, other, "DIA_Bennet_WannaSmith_06_01");	//Sure.
	AI_Output (self, other, "DIA_Bennet_WannaSmith_06_02");	//That will cost you a bit, though. Let's say 30 gold pieces.
	Info_ClearChoices (DIA_Bennet_WannaSmith);
	Info_AddChoice (DIA_Bennet_WannaSmith, "Maybe later.", DIA_Bennet_WannaSmith_Later);
	Info_AddChoice (DIA_Bennet_WannaSmith, "Fine. Here's 30 for you.", DIA_Bennet_WannaSmith_Pay);
};

func void DIA_Bennet_WannaSmith_Pay()
{
	AI_Output (other, self, "DIA_Bennet_WannaSmith_Pay_15_00");	//Fine. Here's 30 for you.
	if (B_GiveInvItems (other, self, ItMi_Gold, 30))
	{
		AI_Output (self, other, "DIA_Bennet_WannaSmith_Pay_06_01");	//And that was a damn good price, too! We can start as soon as you're ready.
		Bennet_TeachCommon = TRUE;
		Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_SoldierTeacher,"Bennet can teach me a blacksmith's craft.");
	}
	else
	{
		AI_Output (self, other, "DIA_Bennet_WannaSmith_Pay_06_02");	//Stop playing me for a sucker. 30 and not a coin less.
	};
	Info_ClearChoices(DIA_Bennet_WannaSmith);
};

func void DIA_Bennet_WannaSmith_Later()
{
	AI_Output (other, self, "DIA_Bennet_WannaSmith_Later_15_00");	//Maybe later.
	Info_ClearChoices (DIA_Bennet_WannaSmith);
};


instance DIA_Bennet_TeachCOMMON(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 6;
	condition = DIA_Bennet_TeachCOMMON_Condition;
	information = DIA_Bennet_TeachCOMMON_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Learn to forge",B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_Common));
	description = B_BuildLearnString(NAME_Skill_Smith,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_Common));
};


func int DIA_Bennet_TeachCOMMON_Condition()
{
	if((PLAYER_TALENT_SMITH[WEAPON_Common] == FALSE) && (Bennet_TeachCommon == TRUE) && ((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Bennet_TeachCOMMON_Info()
{
	AI_Output (other, self, "DIA_Bennet_TeachCOMMON_15_00");	//Teach me how to forge a sword!
	if (B_TeachPlayerTalentSmith (self, other, WEAPON_Common))
	{
		AI_Output (self, other, "DIA_Bennet_TeachCOMMON_06_01");	//It's quite simple: get yourself a piece of raw steel and hold it into the fire until it glows.
		AI_Output (self, other, "DIA_Bennet_TeachCOMMON_06_02");	//Then put it on the anvil and hammer the blade into shape.
		AI_Output (self, other, "DIA_Bennet_TeachCOMMON_06_03");	//Most important, watch out that the blade doesn't get too cold. You only have a few minutes at a time to work on your weapon ...
		AI_Output (self, other, "DIA_Bennet_TeachCOMMON_06_04");	//The rest you can find out for yourself - it's merely a matter of practice.
	};
};


instance DIA_Bennet_WannaSmithORE(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 7;
	condition = DIA_Bennet_WannaSmithORE_Condition;
	information = DIA_Bennet_WannaSmithORE_Info;
	permanent = TRUE;
	description = "Teach me how to forge magic ore weapons!";
};


func int DIA_Bennet_WannaSmithORE_Condition()
{
	if((Bennet_TeachSmith == FALSE) && ((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Bennet_WannaSmithORE_Info()
{
	AI_Output(other,self,"DIA_Bennet_WannaSmithORE_15_00");	//Teach me how to forge magic ore weapons!
	if((other.guild != GIL_SLD) && (other.guild != GIL_DJG))
	{
		if(other.guild == GIL_NONE)
		{
			AI_Output(self,other,"DIA_Bennet_WannaSmithORE_06_03");	//As long as you aren't one of us, I'll be damned if I tell you the secret of the magic ore weapons.
		}
		else
		{
			AI_Output(self,other,"DIA_Bennet_WannaSmithORE_06_03_add");	//You aren't one of us - I'll be damned if I tell you the secret of the magic ore weapons.@@@
		};
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_04");	//Only very few blacksmiths know it at all, and I believe that not even the smiths in town know anything about it.
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_05");	//And that's a good thing, too. Otherwise, those boozers of the city guard would all be wielding magic swords next.
		if(other.guild == GIL_MIL)
		{
			AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_06");	//Nothing against you. (grins) You seem to be okay.
		};
	}
	else if(PLAYER_TALENT_SMITH[WEAPON_Common] == FALSE)
	{
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_01");	//But you don't even know the basics.
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_02");	//First you need to learn how to forge a decent sword. Then we'll see.
	}
	else if(MIS_Bennet_BringOre != LOG_SUCCESS)
	{
		if(MIS_Bennet_BringOre == FALSE)
		{
			AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_07");	//If I had magic ore, I might even do just that.
			AI_Output (other, self, "DIA_Bennet_WannaSmithORE_15_08");	//Aw, come on - I'm with the mercenaries, and I can forge - what else do you want?
			AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_09");	//Can you tell me, then, how I am supposed to forge a magic ore weapon without any magic ore?
			AI_Output (other, self, "DIA_Bennet_WannaSmithORE_15_10");	//Weeell...
			MIS_Bennet_BringOre = LOG_Running;
			Log_CreateTopic(TOPIC_BennetOre,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_BennetOre,LOG_Running);
			B_LogEntry(TOPIC_BennetOre,"Bennet the blacksmith of the mercenaries needs 5 lumps of ore.");
		};
		AI_Output(self,other,"DIA_Bennet_WannaSmithORE_06_11");	//That's what I thought. I need at least 5 lumps of that ore - or you can forget it.
	}
	else
	{
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_12");	//Great, you brought me the ore, and you also know how to forge a decent sword.
		AI_Output (other, self, "DIA_Bennet_WannaSmithORE_15_13");	//Well, fire away, then ...
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_14");	//The most important thing is: It doesn't matter at all whether your weapon is made of magic ore throughout, or if you have only coated a simple steel blade with a layer of ore. The surface is all that matters.
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_15");	//And since the blasted stuff is so expensive, you just grab a steel billet and a few lumps of ore.
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_16");	//Naturally, it won't do to just coat a finished sword with magic ore. You'll have to forge the weapon yourself from scratch.
		AI_Output (self, other, "DIA_Bennet_WannaSmithORE_06_17");	//Everything else depends on the weapon you would like to produce.
		Bennet_TeachSmith = TRUE;
	};
};


instance DIA_Bennet_WhereOre(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_WhereOre_Condition;
	information = DIA_Bennet_WhereOre_Info;
	permanent = FALSE;
	description = "Where can I find magic ore?";
};


func int DIA_Bennet_WhereOre_Condition()
{
	if((MIS_Bennet_BringOre == LOG_Running) && ((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Bennet_WhereOre_Info()
{
	AI_Output (other, self, "DIA_Bennet_WhereOre_15_00");	//Where can I find magic ore?
	AI_Output (self, other, "DIA_Bennet_WhereOre_06_01");	//Well, if only I knew that. There must surely be some in the mining colony.
	AI_Output (self, other, "DIA_Bennet_WhereOre_06_02");	//But maybe you'll luck out and find a few leftover morsels somewhere around here you can scrape together.
	AI_Output (self, other, "DIA_Bennet_WhereOre_06_03");	//I think there are some mining tunnels in the mountains south of here. Maybe you'll get lucky there.
	AI_Output (self, other, "DIA_Bennet_WhereOre_06_04");	//But watch out, I have heard it's teeming with bandits up there.
};


instance DIA_Bennet_BringOre(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 9;
	condition = DIA_Bennet_BringOre_Condition;
	information = DIA_Bennet_BringOre_Info;
	permanent = FALSE;
	description = "Here you are - 5 ore nuggets.";
};


func int DIA_Bennet_BringOre_Condition()
{
	if((MIS_Bennet_BringOre == LOG_Running) && (Npc_HasItems(other,ItMi_Nugget) >= 5) && ((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Bennet_BringOre_Info()
{
	AI_Output (other, self, "DIA_Bennet_BringOre_15_00");	//Here you are - 5 ore nuggets.
	AI_Output (self, other, "DIA_Bennet_BringOre_06_01");	//(laughs) Show me!
	B_GiveInvItems(other,self,ItMi_Nugget,5);
	AI_Output (self, other, "DIA_Bennet_BringOre_06_02");	//Really! Knock me down with a feather!
	AI_Output (self, other, "DIA_Bennet_BringOre_06_03");	//You can keep two of these things. You'll need them in order to forge your own weapon.
	B_GiveInvItems(self,other,ItMi_Nugget,2);
	Bennet_NW_ItMi_Nugget_Count += 3;
	B_LogEntry(TOPIC_BennetOre,"Bennet received his ore and shared some of it with me.");
	MIS_Bennet_BringOre = LOG_SUCCESS;
	B_GivePlayerXP(100);
};


instance DIA_Bennet_TeachSmith(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 30;
	condition = DIA_Bennet_TeachSmith_Condition;
	information = DIA_Bennet_TeachSmith_Info;
	permanent = TRUE;
	description = "I want to know more about forging magic ore weapons.";
};


func int DIA_Bennet_TeachSmith_Condition()
{
	if((Bennet_TeachSmith == TRUE) && ((Kapitel != 3) || (MIS_RescueBennet == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Bennet_TeachSmith_Info()
{
	AI_Output(other,self,"DIA_Bennet_TeachSmith_15_00");	//I want to know more about forging magic ore weapons.
	if(AlternativeSmithing == FALSE)
	{
		if(Kapitel == 1)
		{
			AI_Output(self,other,"DIA_Bennet_TeachSmith_06_06_add");	//Пока мне нечему учить тебя.@@@
		}
		else if(!C_Bennet_HaveNewWeapons())
		{
			AI_Output(self,other,"DIA_Bennet_TeachSmith_06_06");	//What kind of weapon would you like to make?
		}
		else
		{
			DIA_Bennet_AnnounceNewWeapons_Info();
		};
		if(Kapitel > 1)
		{
			Info_ClearChoices(DIA_Bennet_TeachSmith);
			Info_AddChoice(DIA_Bennet_TeachSmith,Dialog_Back,DIA_Bennet_TeachSmith_BACK);
			if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_01] == FALSE) && (Kapitel >= 2))
			{
				Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_1H_Special_01,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_01)),DIA_Bennet_TeachSmith_1hSpecial1);
			};
			if((PLAYER_TALENT_SMITH[WEAPON_2H_Special_01] == FALSE) && (Kapitel >= 2))
			{
				Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_2H_Special_01,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_01)),DIA_Bennet_TeachSmith_2hSpecial1);
			};
			if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_02] == FALSE) && (Kapitel >= 3))
			{
				Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_1H_Special_02,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_02)),DIA_Bennet_TeachSmith_1hSpecial2);
			};
			if((PLAYER_TALENT_SMITH[WEAPON_2H_Special_02] == FALSE) && (Kapitel >= 3))
			{
				Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_2H_Special_02,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_02)),DIA_Bennet_TeachSmith_2hSpecial2);
			};
			if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_03] == FALSE) && (MIS_ReadyforChapter4 == TRUE))
			{
				Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_1H_Special_03,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_03)),DIA_Bennet_TeachSmith_1hSpecial3);
			};
			if((PLAYER_TALENT_SMITH[WEAPON_2H_Special_03] == FALSE) && (MIS_ReadyforChapter4 == TRUE))
			{
				Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_2H_Special_03,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_03)),DIA_Bennet_TeachSmith_2hSpecial3);
			};
			if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_04] == FALSE) && (Kapitel >= 5))
			{
				Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_1H_Special_04,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_04)),DIA_Bennet_TeachSmith_1hSpecial4);
			};
			if((PLAYER_TALENT_SMITH[WEAPON_2H_Special_04] == FALSE) && (Kapitel >= 5))
			{
				Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_2H_Special_04,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_04)),DIA_Bennet_TeachSmith_2hSpecial4);
			};
		};
	}
	else
	{
		if(!C_Bennet_HaveNewWeapons())
		{
			AI_Output(self,other,"DIA_Bennet_TeachSmith_06_06");	//What kind of weapon would you like to make?
		}
		else
		{
			DIA_Bennet_AnnounceNewWeapons_Info();
		};
		Info_ClearChoices(DIA_Bennet_TeachSmith);
		Info_AddChoice(DIA_Bennet_TeachSmith,Dialog_Back,DIA_Bennet_TeachSmith_BACK);
		if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_01] == FALSE) && (Kapitel >= 1))
		{
			Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_1H_Special_01,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_01)),DIA_Bennet_TeachSmith_1hSpecial1);
		};
		if((PLAYER_TALENT_SMITH[WEAPON_2H_Special_01] == FALSE) && (Kapitel >= 1))
		{
			Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_2H_Special_01,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_01)),DIA_Bennet_TeachSmith_2hSpecial1);
		};
		if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_02] == FALSE) && (Kapitel >= 2))
		{
			Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_1H_Special_02,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_02)),DIA_Bennet_TeachSmith_1hSpecial2);
		};
		if((PLAYER_TALENT_SMITH[WEAPON_2H_Special_02] == FALSE) && (Kapitel >= 2))
		{
			Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_2H_Special_02,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_02)),DIA_Bennet_TeachSmith_2hSpecial2);
		};
		if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_03] == FALSE) && (Kapitel >= 3))
		{
			Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_1H_Special_03,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_03)),DIA_Bennet_TeachSmith_1hSpecial3);
		};
		if((PLAYER_TALENT_SMITH[WEAPON_2H_Special_03] == FALSE) && (Kapitel >= 3))
		{
			Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_2H_Special_03,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_03)),DIA_Bennet_TeachSmith_2hSpecial3);
		};
		if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_04] == FALSE) && (Kapitel >= 5))
		{
			Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_1H_Special_04,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_04)),DIA_Bennet_TeachSmith_1hSpecial4);
		};
		if((PLAYER_TALENT_SMITH[WEAPON_2H_Special_04] == FALSE) && (Kapitel >= 5))
		{
			Info_AddChoice(DIA_Bennet_TeachSmith,B_BuildLearnString(NAME_ItMw_2H_Special_04,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_04)),DIA_Bennet_TeachSmith_2hSpecial4);
		};
	};
};

func void DIA_Bennet_TeachSmith_BACK()
{
	Info_ClearChoices(DIA_Bennet_TeachSmith);
};

func void DIA_Bennet_TeachSmith_1hSpecial1()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Special_01);
};

func void DIA_Bennet_TeachSmith_2hSpecial1()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_2H_Special_01);
};

func void DIA_Bennet_TeachSmith_1hSpecial2()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Special_02);
};

func void DIA_Bennet_TeachSmith_2hSpecial2()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_2H_Special_02);
};

func void DIA_Bennet_TeachSmith_1hSpecial3()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Special_03);
};

func void DIA_Bennet_TeachSmith_2hSpecial3()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_2H_Special_03);
};

func void DIA_Bennet_TeachSmith_1hSpecial4()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Special_04);
};

func void DIA_Bennet_TeachSmith_2hSpecial4()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_2H_Special_04);
};

instance DIA_Bennet_WhyPrison(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_WhyPrison_Condition;
	information = DIA_Bennet_WhyPrison_Info;
	permanent = FALSE;
	description = "How come you're in the slammer?";
};


func int DIA_Bennet_WhyPrison_Condition()
{
	if((Kapitel == 3) && (MIS_RescueBennet != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Bennet_WhyPrison_Info()
{
	AI_Output (other, self, "DIA_Bennet_WhyPrison_15_00");	//How come you're in the slammer?
	AI_Output (self, other, "DIA_Bennet_WhyPrison_06_01");	//Those swine have thrown me in the hole. I'm supposed to have murdered a paladin.
	AI_Output (self, other, "DIA_Bennet_WhyPrison_06_02");	//But I didn't do it, they're only trying to frame me.
	AI_Output (other, self, "DIA_Bennet_WhyPrison_15_03");	//Why would they do that?
	AI_Output (self, other, "DIA_Bennet_WhyPrison_06_04");	//How would I know? You've got to get me out of here.
	AI_Output (self, other, "DIA_Bennet_WhyPrison_06_05");	//Talk to Lord Hagen, tear down the wall, who cares - just do something!
	if(MIS_RescueBennet != LOG_Running)
	{
		MIS_RescueBennet = LOG_Running;
		Log_CreateTopic(TOPIC_RescueBennet,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_RescueBennet,LOG_Running);
		B_LogEntry(TOPIC_RescueBennet,"Bennet's in a real fix. He'd do anything to get out of the slammer.");
	};
};


instance DIA_Bennet_WhatHappened(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_WhatHappened_Condition;
	information = DIA_Bennet_WhatHappened_Info;
	permanent = FALSE;
	description = "What happened?";
};


func int DIA_Bennet_WhatHappened_Condition()
{
	if((MIS_RescueBennet == LOG_Running) && Npc_KnowsInfo(other,DIA_Bennet_WhyPrison))
	{
		return TRUE;
	};
};

func void DIA_Bennet_WhatHappened_Info()
{
	AI_Output (other, self, "DIA_Bennet_WhatHappened_15_00");	//What happened?
	AI_Output (self, other, "DIA_Bennet_WhatHappened_06_01");	//I went downtown with Hodges to buy some supplies for our boys.
	AI_Output (self, other, "DIA_Bennet_WhatHappened_06_02");	//Suddenly we heard a loud scream and the sound of running feet.
	AI_Output (other, self, "DIA_Bennet_WhatHappened_15_03");	//Get to the point.
	AI_Output (self, other, "DIA_Bennet_WhatHappened_06_04");	//We knew at once that something had happened and that they would grab us at once if they saw us there.
	AI_Output (self, other, "DIA_Bennet_WhatHappened_06_05");	//We ran like hell. Then, just before we got to the city gate, I tripped and sprained my ankle.
	AI_Output (self, other, "DIA_Bennet_WhatHappened_06_06");	//The rest is soon told. The militia was on me at once, and they threw me straight into this hole.
};


instance DIA_Bennet_Victim(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_Victim_Condition;
	information = DIA_Bennet_Victim_Info;
	permanent = FALSE;
	description = "Who was murdered?";
};


func int DIA_Bennet_Victim_Condition()
{
	if((MIS_RescueBennet == LOG_Running) && Npc_KnowsInfo(other,DIA_Bennet_WhyPrison))
	{
		return TRUE;
	};
};

func void DIA_Bennet_Victim_Info()
{
	AI_Output (other, self, "DIA_Bennet_Victim_15_00");	//Who was murdered?
	AI_Output (self, other, "DIA_Bennet_Victim_06_01");	//I have no idea - one of the paladins, I don't know them.
	AI_Output (other, self, "DIA_Bennet_Victim_15_02");	//Have you got a name?
	AI_Output (self, other, "DIA_Bennet_Victim_06_03");	//Some Lothar, I think. Well, I don't know, I'm not really sure.
	AI_Output (self, other, "DIA_Bennet_Victim_06_04");	//You had better ask Lord Hagen, he knows all the details.
	B_LogEntry (TOPIC_RescueBennet, "Lothar, one of the paladins, was murdered. Lord Hagen should be able to tell me more, he's in charge of the investigations.");
};


instance DIA_Bennet_Evidence(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_Evidence_Condition;
	information = DIA_Bennet_Evidence_Info;
	permanent = FALSE;
	description = "Do they have any evidence against you?";
};


func int DIA_Bennet_Evidence_Condition()
{
	if((MIS_RescueBennet == LOG_Running) && Npc_KnowsInfo(other,DIA_Bennet_WhyPrison))
	{
		return TRUE;
	};
};

func void DIA_Bennet_Evidence_Info()
{
	AI_Output (other, self, "DIA_Bennet_Evidence_15_00");	//Do they have any evidence against you?
	AI_Output (self, other, "DIA_Bennet_Evidence_06_01");	//They say they have a witness who recognized me.
	AI_Output (other, self, "DIA_Bennet_Evidence_15_02");	//Do you know who the witness is?
	AI_Output (self, other, "DIA_Bennet_Evidence_06_03");	//No. All I know is that he's lying.
	B_LogEntry (TOPIC_RescueBennet, "There's a witness who claims to have seen Bennet. I'll have to find him if I want to discover the truth.");
//	RescueBennet_KnowsWitness = TRUE;
};


instance DIA_Bennet_Investigation(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_Investigation_Condition;
	information = DIA_Bennet_Investigation_Info;
	permanent = FALSE;
	description = "Who is leading the investigation?";
};


func int DIA_Bennet_Investigation_Condition()
{
	if((MIS_RescueBennet == LOG_Running) && Npc_KnowsInfo(other,DIA_Bennet_Evidence))
	{
		return TRUE;
	};
};

func void DIA_Bennet_Investigation_Info()
{
	AI_Output (other, self, "DIA_Bennet_Investigation_15_00");	//Who leads the investigation?
	AI_Output (self, other, "DIA_Bennet_Investigation_06_01");	//Lord Hagen himself. Since the victim was one of the paladins, this falls under martial law.
	AI_Output (other, self, "DIA_Bennet_Investigation_15_02");	//What does that mean?
	AI_Output (self, other, "DIA_Bennet_Investigation_06_03");	//That's easy to guess. If I don't get out of here, they're going to let me swing without further ado.
	AI_Output (self, other, "DIA_Bennet_Investigation_06_04");	//You've got to help me, or there'll be a war. Lee's not going to take this lying down.
	AI_Output (self, other, "DIA_Bennet_Investigation_06_05");	//You can figure out for yourself what that means.
};


instance DIA_Bennet_ThankYou(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_ThankYou_Condition;
	information = DIA_Bennet_ThankYou_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Bennet_ThankYou_Condition()
{
	if(MIS_RescueBennet == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Bennet_ThankYou_Info()
{
	AI_Output (self, other, "DIA_Bennet_ThankYou_06_00");	//Man, and here I was thinking they'd really hang me!
	AI_Output (other, self, "DIA_Bennet_ThankYou_15_01");	//Well, it worked out all right in the end.
	AI_Output (self, other, "DIA_Bennet_ThankYou_06_02");	//You can say that again. You should have seen the face of the soldier when he had to let me out!
	AI_Output (self, other, "DIA_Bennet_ThankYou_06_03");	//(laughs) He was so scared he almost did it in his pants.
	AI_Output (self, other, "DIA_Bennet_ThankYou_06_04");	//Which reminds me, I've got something for you.
	AI_Output (other, self, "DIA_Bennet_ThankYou_15_05");	//What do you mean?
	AI_Output (self, other, "DIA_Bennet_ThankYou_06_06");	//(grins) A present.
	self.npcType = NPCTYPE_FRIEND;
};


instance DIA_Bennet_Present(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_Present_Condition;
	information = DIA_Bennet_Present_Info;
	permanent = FALSE;
	description = "What present?";
};


func int DIA_Bennet_Present_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bennet_ThankYou))
	{
		return TRUE;
	};
};

func void DIA_Bennet_Present_Info()
{
	AI_Output (other, self, "DIA_Bennet_Present_15_00");	//What present?
	AI_Output (self, other, "DIA_Bennet_Present_06_01");	//We have heard of the dragons that are said to be in the valley.
	AI_Output (other, self, "DIA_Bennet_Present_15_02");	//They're really there!
	AI_Output (self, other, "DIA_Bennet_Present_06_03");	//All right, I believe you.
	if(hero.guild == GIL_SLD)
	{
		B_SetGuild(hero,GIL_DJG);
		AI_Output (self, other, "DIA_Bennet_Present_06_04");	//At any rate, some of the boys have decided to go into the valley as well.
		AI_Output (self, other, "DIA_Bennet_Present_06_05");	//(grins) They are planning to tidy up in there.
		AI_Output (other, self, "DIA_Bennet_Present_15_06");	//What's that got to do with me?
		AI_Output (self, other, "DIA_Bennet_Present_06_07");	//(proudly) I have developed a new type of armor. Dragon hunter's armor!
		AI_Output (self, other, "DIA_Bennet_Present_06_08");	//It is sturdier and lighter than traditional armor.
		AI_Output (self, other, "DIA_Bennet_Present_06_09");	//Since you're the one who saved me, I want you to have the first piece. It's a gift!
		B_GiveArmor(ITAR_DJG_L);
		AI_Output (self, other, "DIA_Bennet_Present_06_10");	//I thought you might want to be in on the fun. You're going to need the right equipment when you go down to that valley.
		AI_Output (self, other, "DIA_Bennet_Present_06_11");	//Also, I am interested in dragon scales. Genuine dragon scales. I shall pay you a good price for them.
		AI_Output (other, self, "DIA_Bennet_Present_15_12");	//How much do I get per scale?
		B_Say_Gold(self,other,Value_DragonScale);
	}
	else
	{
		AI_Output (self, other, "DIA_Bennet_Present_06_13");	//Anyway, I thought you would surely want to participate in the upcoming dragon hunt.
		AI_Output (other, self, "DIA_Bennet_Present_15_14");	//And?
		AI_Output (self, other, "DIA_Bennet_Present_06_15");	//Here, take this amulet. I think you'll need it more than I do.
		CreateInvItems (self, ItAm_Hp_01, 1);
		B_GiveInvItems (self, other, ItAm_Hp_01, 1);
	};
};


var int Bennet_DragonScale_Counter;
var int Show_DJG_Armor_M;

instance DIA_Bennet_DragonScale(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_DragonScale_Condition;
	information = DIA_Bennet_DragonScale_Info;
	permanent = TRUE;
	description = "I've got a few dragon scales for you.";
};


func int DIA_Bennet_DragonScale_Condition()
{
	if(Npc_HasItems(other,ItAt_DragonScale) && (hero.guild == GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Bennet_DragonScale_Info()
{
	var int dragonscalecount;
	var string concatText;
	AI_Output (other, self, "DIA_Bennet_DragonScale_15_00");	//I've got a few dragon scales for you.
	AI_Output (self, other, "DIA_Bennet_DragonScale_06_01");	//Genuine dragon scales!
	AI_Output (self, other, "DIA_Bennet_DragonScale_06_02");	//Here's your gold!
	dragonscalecount = Npc_HasItems(other,ItAt_DragonScale);
	Bennet_DragonScale_Counter += dragonscalecount;
	B_GiveInvItems(self,other,ItMi_Gold,dragonscalecount * Value_DragonScale);
	Npc_RemoveInvItems(other,ItAt_DragonScale,dragonscalecount);
	concatText = ConcatStrings(IntToString(dragonscalecount),PRINT_ItemsGiven);
	AI_PrintScreen(concatText,-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	if((Bennet_DragonScale_Counter >= 20) && (Show_DJG_Armor_M == FALSE))
	{
		AI_Output (self, other, "DIA_Bennet_DragonScale_06_03");	//All right, that should be enough. I could sell you new, improved armor if you want.
		Show_DJG_Armor_M = TRUE;
	};
};


var int Bennet_DIA_Bennet_DJG_ARMOR_M_permanent;

instance DIA_Bennet_DJG_ARMOR_M(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_DJG_ARMOR_M_Condition;
	information = DIA_Bennet_DJG_ARMOR_M_Info;
	permanent = TRUE;
	description = "Medium Dragon Hunter Armor. Prot. 120/120/75/35 (12000 gold)";
};


func int DIA_Bennet_DJG_ARMOR_M_Condition()
{
	if((Bennet_DIA_Bennet_DJG_ARMOR_M_permanent == FALSE) && (hero.guild == GIL_DJG) && (Show_DJG_Armor_M == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Bennet_DJG_ARMOR_M_Info()
{
	AI_Output(other,self,"DIA_Bennet_DJG_ARMOR_M_15_00");	//I want to buy the armor.
	if(Npc_HasItems(other,ItMi_Gold) >= VALUE_ITAR_DJG_M)
	{
		AI_Output (self, other, "DIA_Bennet_DJG_ARMOR_M_06_01");	//Very good. You'll be delighted with it.
		AI_Output (other, self, "DIA_Bennet_DJG_ARMOR_M_15_02");	//I should certainly expect that at this price.
		AI_Output (self, other, "DIA_Bennet_DJG_ARMOR_M_06_03");	//You'll find that it is worth every single gold piece.
		B_GiveInvItems(other,self,ItMi_Gold,VALUE_ITAR_DJG_M);
		if(Helmets_Enabled == TRUE)
		{
			B_GiveArmor(ITAR_DJGN_M);
			CreateInvItem(hero,ITHE_DJG_M);
		}
		else
		{
			B_GiveArmor(ITAR_DJG_M);
		};
		Bennet_DIA_Bennet_DJG_ARMOR_M_permanent = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Bennet_DJG_ARMOR_M_06_04");	//You don't have enough gold.
	};
};


instance DIA_Bennet_BetterArmor(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_BetterArmor_Condition;
	information = DIA_Bennet_BetterArmor_Info;
	permanent = FALSE;
	description = "I know how the armor can be improved even further.";
};


func int DIA_Bennet_BetterArmor_Condition()
{
	if((PlayergetsFinalDJGArmor == TRUE) && (hero.guild == GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Bennet_BetterArmor_Info()
{
	AI_Output (other, self, "DIA_Bennet_BetterArmor_15_00");	//I know how the armor can be improved even further.
	AI_Output (self, other, "DIA_Bennet_BetterArmor_06_01");	//(smiling to himself) Tell me, then.
	AI_Output (other, self, "DIA_Bennet_BetterArmor_15_02");	//You could coat the dragon scales with magic ore.
	AI_Output (self, other, "DIA_Bennet_BetterArmor_06_03");	//(laughs) That thought has already occurred to me, too. And you're right.
	AI_Output (self, other, "DIA_Bennet_BetterArmor_06_04");	//My newest armor beats everything you've ever seen. It is lightweight yet sturdy.
	AI_Output (self, other, "DIA_Bennet_BetterArmor_06_05");	//It is PERFECT.
	AI_Output (self, other, "DIA_Bennet_BetterArmor_06_06");	//You can buy it if you want. I don't make this offer to just anybody, and the price only just covers the manufacturing costs.
};


//var int Bennet_DIA_Bennet_DJG_ARMOR_H_permanent;

instance DIA_Bennet_DJG_ARMOR_H(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_DJG_ARMOR_H_Condition;
	information = DIA_Bennet_DJG_ARMOR_H_Info;
	permanent = TRUE;
	description = "Heavy Dragon Hunter Armor. Prot. 150/150/100/50 (20000 gold)";
};


func int DIA_Bennet_DJG_ARMOR_H_Condition()
{
	if((Bennet_DIA_Bennet_DJG_ARMOR_H_permanent == FALSE) && (hero.guild == GIL_DJG) && (Npc_KnowsInfo(other,DIA_Bennet_BetterArmor) || Npc_KnowsInfo(other,DIA_Bennet_DI_BetterArmor)))
	{
		return TRUE;
	};
};

func void DIA_Bennet_DJG_ARMOR_H_Info()
{
	AI_Output(other,self,"DIA_Bennet_DJG_ARMOR_H_15_00");	//Give me the armor.
	if(Npc_HasItems(other,ItMi_Gold) >= VALUE_ITAR_DJG_H)
	{
		AI_Output (self, other, "DIA_Bennet_DJG_ARMOR_H_06_01");	//This is the best armor I have ever made.
		AI_Output (self, other, "DIA_Bennet_DJG_ARMOR_H_06_02");	//A true masterpiece.
		B_GiveInvItems(other,self,ItMi_Gold,VALUE_ITAR_DJG_H);
		if(Helmets_Enabled == TRUE)
		{
			B_GiveArmor(ITAR_DJGN_H);
			CreateInvItem(hero,ITHE_DJG_H);
		}
		else
		{
			B_GiveArmor(ITAR_DJG_H);
		};
		Bennet_DIA_Bennet_DJG_ARMOR_H_permanent = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Bennet_DJG_ARMOR_H_06_03");	//You don't have enough gold.
	};
};


instance DIA_Bennet_RepairNecklace(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_RepairNecklace_Condition;
	information = DIA_Bennet_RepairNecklace_Info;
	permanent = FALSE;
	description = "Can you repair jewelry?";
};


func int DIA_Bennet_RepairNecklace_Condition()
{
	if((MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS) && (Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Bennet_RepairNecklace_Info()
{
	AI_Output (other, self, "DIA_Bennet_RepairNecklace_15_00");	//Can you repair jewelry?
	AI_Output (self, other, "DIA_Bennet_RepairNecklace_06_01");	//That depends. You would have to show me the piece first.
	if (MIS_RescueBennet != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Bennet_RepairNecklace_06_02");	//Also, I need to get out of here first.
		AI_Output (self, other, "DIA_Bennet_RepairNecklace_06_03");	//Before that, I can't do a thing, obviously.
	};
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
};


instance DIA_Bennet_ShowInnosEye(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_ShowInnosEye_Condition;
	information = DIA_Bennet_ShowInnosEye_Info;
	permanent = FALSE;
	description = "Can you have a look at this amulet?";
};


func int DIA_Bennet_ShowInnosEye_Condition()
{
	if(Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) && (MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_Bennet_RepairNecklace))
	{
		return TRUE;
	};
};

func void DIA_Bennet_ShowInnosEye_Info()
{
	AI_Output (other, self, "DIA_Bennet_ShowInnosEye_15_00");	//Can you have a look at this amulet?
	AI_Output (self, other, "DIA_Bennet_ShowInnosEye_06_01");	//Sure, let me see.
	AI_PrintScreen(Print_InnoseyeGiven,-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	AI_Output (self, other, "DIA_Bennet_ShowInnosEye_06_02");	//Hmm, that is a beautiful piece of work. The setting is shot. I think I can fix it, though.
	AI_Output (other, self, "DIA_Bennet_ShowInnosEye_15_03");	//How long will it take you?
	if(MIS_RescueBennet != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Bennet_ShowInnosEye_06_04");	//Well, I'm stuck here for now. Or do you see a forge in this place?
		AI_Output (self, other, "DIA_Bennet_ShowInnosEye_06_05");	//If I were in my smithy I could do it all in one day. But, of course, first I'll need to get out of here.
	}
	else
	{
		AI_Output (self, other, "DIA_Bennet_ShowInnosEye_06_06");	//If you leave it here with me, it will be done by the time you come back tomorrow.
		AI_Output (self, other, "DIA_Bennet_ShowInnosEye_06_07");	//And I won't even charge you for it. You got me out of the slammer, after all.
	};
	AI_PrintScreen(Print_InnosEyeGet,-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
	B_LogEntry(TOPIC_INNOSEYE,"Bennet is the smith I need to repair the amulet.");
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
};


instance DIA_Bennet_GiveInnosEye(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_GiveInnosEye_Condition;
	information = DIA_Bennet_GiveInnosEye_Info;
	permanent = FALSE;
	description = "Here's the amulet, please repair it for me.";
};


func int DIA_Bennet_GiveInnosEye_Condition()
{
	if(Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) && (MIS_SCKnowsInnosEyeIsBroken == TRUE) && (MIS_RescueBennet == LOG_SUCCESS) && (MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_Bennet_ShowInnosEye))
	{
		return TRUE;
	};
};

func void DIA_Bennet_GiveInnosEye_Info()
{
	AI_Output(other,self,"DIA_Bennet_GiveInnosEye_15_00");	//Here's the amulet, please repair it for me.
	Npc_RemoveInvItems(other,ItMi_InnosEye_Broken_Mis,1);
	AI_PrintScreen(Print_InnoseyeGiven,-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	AI_Output (self, other, "DIA_Bennet_GiveInnosEye_06_01");	//All right. I'll have finished the new setting by tomorrow.
	AI_Output (self, other, "DIA_Bennet_GiveInnosEye_06_02");	//You can come to me and get it then.
	Bennet_RepairDay = Wld_GetDay();
	B_UpdateBennetItemsCount();
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"WORK");
};


instance DIA_Bennet_GetInnosEye(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 8;
	condition = DIA_Bennet_GetInnosEye_Condition;
	information = DIA_Bennet_GetInnosEye_Info;
	permanent = TRUE;
	description = "Is the amulet ready?";
};


func int DIA_Bennet_GetInnosEye_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bennet_GiveInnosEye) && (MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Bennet_GetInnosEye_Info()
{
	AI_Output(other,self,"DIA_Bennet_GetInnosEye_15_00");	//Is the amulet ready?
	B_UpdateBennetItemsCount();
	if(((Bennet_RepairDay < Wld_GetDay()) && Wld_IsTime(5,0,23,59)) || (Bennet_RepairDay + 1 < Wld_GetDay()))
	{
		AI_Output (self, other, "DIA_Bennet_GetInnosEye_06_01");	//Yes, here.
		TEXT_Innoseye_Setting = TEXT_Innoseye_Setting_Repaired;
		CreateInvItems(other,ItMi_InnosEye_Broken_Mis,1);
		AI_PrintScreen(Print_InnosEyeGet,-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
		AI_Output (self, other, "DIA_Bennet_GetInnosEye_06_02");	//I had to make a new setting for the stone.
		AI_Output (self, other, "DIA_Bennet_GetInnosEye_06_03");	//I worked on it all night, and now it's as good as new.
		B_LogEntry (TOPIC_INNOSEYE, "The amulet's setting is whole again. Bennet's done a good job.");
		MIS_Bennet_InnosEyeRepairedSetting = LOG_SUCCESS;
		B_GivePlayerXP(XP_InnosEyeIsRepaired);
		AI_StopProcessInfos(self);
		Npc_ExchangeRoutine(self,"START");
	}
	else
	{
		AI_Output(self,other,"DIA_Bennet_GetInnosEye_06_04");	//No, not yet. Come back later.
		AI_Output(self,other,"DIA_Bennet_GetInnosEye_06_05");	//If you keep interrupting my work, it will take even longer.
		AI_StopProcessInfos(self);
	};
};


instance DIA_Bennet_DRACHENEIER(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 5;
	condition = DIA_Bennet_DRACHENEIER_Condition;
	information = DIA_Bennet_DRACHENEIER_Info;
	permanent = TRUE;
	description = "Is there anything you can do with dragon eggs?";
};


func int DIA_Bennet_DRACHENEIER_Condition()
{
	if((Kapitel >= 4) && (BennetsDragonEggOffer == 0) && Npc_HasItems(other,ItAt_DragonEgg_MIS) && (hero.guild == GIL_DJG))
	{
		return TRUE;
	};
};


var int BennetsDragonEggOffer;
var int DRACHENEIER_angebotenXP_OneTime;

func void DIA_Bennet_DRACHENEIER_Info()
{
	AI_Output (other, self, "DIA_Bennet_DRACHENEIER_15_00");	//Is there anything you can do with dragon eggs?
	if (DRACHENEIER_angebotenXP_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Bennet_DRACHENEIER_06_01");	//Dragon eggs? How the heck did you come by these?
		AI_Output (other, self, "DIA_Bennet_DRACHENEIER_15_02");	//I took them from some lizard people.
		AI_Output (self, other, "DIA_Bennet_DRACHENEIER_06_03");	//Let me see.
	};
	Npc_RemoveInvItems(other,ItAt_DragonEgg_MIS,1);
	AI_PrintScreen("Given: Dragon Egg",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	if(DRACHENEIER_angebotenXP_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Bennet_DRACHENEIER_06_04");	//Mmh. Very sturdy material. Ideal for finishing armor. If one can manage to get them open, that is.
		AI_Output (other, self, "DIA_Bennet_DRACHENEIER_15_05");	//What about it, then? Do you want it?
		AI_Output (self, other, "DIA_Bennet_DRACHENEIER_06_06");	//Sure! Give it here.
	}
	else
	{
		AI_Output (self, other, "DIA_Bennet_DRACHENEIER_06_07");	//How many more times are you going to shove that blasted thing at me? Do you want me to buy it or not?
	};
	AI_Output (self, other, "DIA_Bennet_DRACHENEIER_06_08");	//I'll pay you, mmh, let's say 300 gold coins for each egg you can bring me.
	Info_ClearChoices (DIA_Bennet_DRACHENEIER);
	Info_AddChoice (DIA_Bennet_DRACHENEIER, "Save your gold, then. I think I'll keep it.", DIA_Bennet_DRACHENEIER_nein);
	Info_AddChoice (DIA_Bennet_DRACHENEIER, "These are dragon eggs, not paltry chicken eggs.", DIA_Bennet_DRACHENEIER_mehr);
	Info_AddChoice (DIA_Bennet_DRACHENEIER, "It's a deal.", DIA_Bennet_DRACHENEIER_ok);
	if (DRACHENEIER_angebotenXP_OneTime == FALSE)
	{
		B_LogEntry (TOPIC_DRACHENEIER, "Bennet is willing to buy all the dragon eggs I can find for a good price.");
		B_GivePlayerXP (XP_DJG_BringDragonEgg);
		DRACHENEIER_angebotenXP_OneTime = TRUE;
	};
};

func void DIA_Bennet_DRACHENEIER_ok()
{
	AI_Output (other, self, "DIA_Bennet_DRACHENEIER_ok_15_00");	//It's a deal.
	AI_Output (self, other, "DIA_Bennet_DRACHENEIER_ok_06_01");	//Right-o.
	AI_Output (self, other, "DIA_Bennet_DRACHENEIER_ok_06_02");	//Then keep those things coming if you can get them.
	if (BennetsDragonEggOffer != 350)
	{
		BennetsDragonEggOffer = 300;
	};
	CreateInvItems(self,ItMi_Gold,BennetsDragonEggOffer);
	B_GiveInvItems(self,other,ItMi_Gold,BennetsDragonEggOffer);
	AI_Output (self, other, "DIA_Bennet_DRACHENEIER_ok_06_03");	//Ehmm. You say you took it from lizard people?
	AI_Output (other, self, "DIA_Bennet_DRACHENEIER_ok_15_04");	//Right.
	AI_Output (self, other, "DIA_Bennet_DRACHENEIER_ok_06_05");	//Most lizard people dwell in caves, as far as I know.
	AI_Output (self, other, "DIA_Bennet_DRACHENEIER_ok_06_06");	//It wouldn't surprise me if you found more of these things in the caves around here.
	B_LogEntry (TOPIC_DRACHENEIER, "Bennet thinks I should look for the eggs in the caves of Khorinis. There are supposed to be lizard people in many caves.");
	if(!Npc_HasItems(other,ItWr_Map_Caves_MIS))
	{
		if(!Npc_IsDead(Brahim))
		{
			AI_Output(self,other,"DIA_Bennet_DRACHENEIER_ok_06_08");	//But first you need to get a map of the caves from a cartographer in town. It would be a pity if you couldn't find them all.
			Log_AddEntry(TOPIC_DRACHENEIER,"I should get a map of the caves from a cartographer in the city, just to make sure I don't miss any eggs.");
		}
		else
		{
			AI_Output(self,other,"DIA_Bennet_DRACHENEIER_ok_06_07");	//Here. Take this map. It'll help you find the caves.
			CreateInvItems(self,ItWr_Map_Caves_MIS,1);
			B_GiveInvItems(self,other,ItWr_Map_Caves_MIS,1);
			Log_AddEntry(TOPIC_DRACHENEIER,"I received a map of caves, perhaps this will help me.");
		};
	};
	Info_ClearChoices(DIA_Bennet_DRACHENEIER);
};

func void DIA_Bennet_DRACHENEIER_mehr()
{
	AI_Output (other, self, "DIA_Bennet_DRACHENEIER_mehr_15_00");	//These are dragon eggs, not paltry chicken eggs.
	AI_Output (self, other, "DIA_Bennet_DRACHENEIER_mehr_06_01");	//(exasperated) All right. 350 it is. But I can't give you more than that - or it just won't pay for me.
	BennetsDragonEggOffer = 350;
};

func void DIA_Bennet_DRACHENEIER_nein()
{
	AI_Output (other, self, "DIA_Bennet_DRACHENEIER_nein_15_00");	//Save your gold, then. I think I'll keep it.
	AI_Output (self, other, "DIA_Bennet_DRACHENEIER_nein_06_01");	//Let me know when you change your mind.
	CreateInvItems(other,ItAt_DragonEgg_MIS,1);
	AI_PrintScreen("Received: Dragon Egg",-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
	BennetsDragonEggOffer = 0;
	Info_ClearChoices(DIA_Bennet_DRACHENEIER);
};


instance DIA_Bennet_EierBringen(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 5;
	condition = DIA_Bennet_EierBringen_Condition;
	information = DIA_Bennet_EierBringen_Info;
	permanent = TRUE;
	description = "Interested in some more dragon eggs?";
};


func int DIA_Bennet_EierBringen_Condition()
{
	if((BennetsDragonEggOffer > 0) && (Kapitel >= 4) && Npc_HasItems(other,ItAt_DragonEgg_MIS) && (hero.guild == GIL_DJG))
	{
		return TRUE;
	};
};


var int DragonEggCounter;

func void DIA_Bennet_EierBringen_Info()
{
	var int DragonEggCount;
	var int XP_DJG_BringDragonEggs;
	var int DragonEggGeld;
	var string concatText;
	AI_Output (other, self, "DIA_Bennet_EierBringen_15_00");	//Interested in some more dragon eggs?
	AI_Output (self, other, "DIA_Bennet_EierBringen_06_01");	//Sure!
	DragonEggCount = Npc_HasItems (other, ItAt_DragonEgg_MIS);
	if (DragonEggCount == 1)
	{
		AI_Output(other,self,"DIA_Bennet_EierBringen_15_02");	//Here. I've got another.
		Npc_RemoveInvItems(other,ItAt_DragonEgg_MIS,1);
		AI_PrintScreen("Received: Dragon Egg",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
		DragonEggCounter += 1;
		B_GivePlayerXP(XP_DJG_BringDragonEgg);
	}
	else
	{
		AI_Output(other,self,"DIA_Bennet_EierBringen_15_03");	//I've got some more here.
		Npc_RemoveInvItems(other,ItAt_DragonEgg_MIS,DragonEggCount);
		concatText = ConcatStrings(IntToString(DragonEggCount),PRINT_ItemsGiven);
		AI_PrintScreen(concatText,-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
		XP_DJG_BringDragonEggs = DragonEggCount * XP_DJG_BringDragonEgg;
		DragonEggCounter += DragonEggCount;
		B_GivePlayerXP(XP_DJG_BringDragonEggs);
	};
	if(DragonEggCounter <= 7)
	{
		AI_Output (self, other, "DIA_Bennet_EierBringen_06_04");	//Great. Give here. Have you looked everywhere, then? Surely there must be more.
	}
	else if(DragonEggCounter <= 11)
	{
		AI_Output (self, other, "DIA_Bennet_EierBringen_06_05");	//Just where do you dig up those things? There can't be many more now.
	}
	else
	{
		AI_Output (self, other, "DIA_Bennet_EierBringen_06_06");	//I don't think you'll find many more now. And I've got so many already, I hardly know what to do with them.
		TOPIC_END_DRACHENEIER = TRUE;
		B_CheckLog();
	};
	AI_Output (self, other, "DIA_Bennet_EierBringen_06_07");	//Oh, right. Here's your money.
	DragonEggGeld = DragonEggCount * BennetsDragonEggOffer;
	CreateInvItems(self,ItMi_Gold,DragonEggGeld);
	B_GiveInvItems(self,other,ItMi_Gold,DragonEggGeld);
};


func void B_Bennet_BeMySmith()
{
	AI_Output (other, self, "DIA_Bennet_KnowWhereEnemy_Yes_15_00");	//Be my smith, then. See you at the harbor.
	AI_Output (self, other, "DIA_Bennet_KnowWhereEnemy_Yes_06_01");	//All right. See you later.
};

instance DIA_Bennet_KnowWhereEnemy(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 55;
	condition = DIA_Bennet_KnowWhereEnemy_Condition;
	information = DIA_Bennet_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "I need to go to an island. I could use a smith.";
};


func int DIA_Bennet_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && (Bennet_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Bennet_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_Bennet_KnowWhereEnemy_15_00");	//I need to go to an island. I could use a smith.
	AI_Output (self, other, "DIA_Bennet_KnowWhereEnemy_06_01");	//And so you thought of me?
	AI_Output (other, self, "DIA_Bennet_KnowWhereEnemy_15_02");	//Yes. What do you say? At any rate, that would get you out of here.
	AI_Output (self, other, "DIA_Bennet_KnowWhereEnemy_06_03");	//Better than Onar's farm. Boy, even hell can't be THAT bad. Count me in.
	if(SCToldBennetHeKnowWhereEnemy == FALSE)
	{
		B_LogEntry(Topic_Crew,"Bennet could leave at once. His skill as a smith is unrivalled. I'm sure I could learn a few things from him.");
		SCToldBennetHeKnowWhereEnemy = TRUE;
	};
	if(Crewmember_Count >= Max_Crew)
	{
		AI_Output (other, self, "DIA_Bennet_KnowWhereEnemy_15_04");	//My crew is already complete at the moment.
		AI_Output (self, other, "DIA_Bennet_KnowWhereEnemy_06_05");	//Then make sure to send one of them away again.
	}
	else
	{
		Info_ClearChoices (DIA_Bennet_KnowWhereEnemy);
		Info_AddChoice (DIA_Bennet_KnowWhereEnemy, "I'm going to let you know when I need you.", DIA_Bennet_KnowWhereEnemy_No);
		Info_AddChoice (DIA_Bennet_KnowWhereEnemy, "Be my smith, then. See you at the harbor. ", DIA_Bennet_KnowWhereEnemy_Yes);
	};
};

func void DIA_Bennet_KnowWhereEnemy_Yes()
{
	B_Bennet_BeMySmith();
	B_UpdateBennetItemsCount();
	B_JoinShip(self);
};

func void DIA_Bennet_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_Bennet_KnowWhereEnemy_No_15_00");	//I'm going to let you know when I need you.
	AI_Output (self, other, "DIA_Bennet_KnowWhereEnemy_No_06_01");	//Fine. I'm here.
	Bennet_IsOnBoard = LOG_OBSOLETE;
	Info_ClearChoices(DIA_Bennet_KnowWhereEnemy);
};


instance DIA_Bennet_LeaveMyShip(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 55;
	condition = DIA_Bennet_LeaveMyShip_Condition;
	information = DIA_Bennet_LeaveMyShip_Info;
	permanent = TRUE;
	description = "I'm going to find myself a different smith.";
};


func int DIA_Bennet_LeaveMyShip_Condition()
{
	if((Bennet_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Bennet_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_Bennet_LeaveMyShip_15_00");	//I'm going to find myself a different smith.
	AI_Output (self, other, "DIA_Bennet_LeaveMyShip_06_01");	//It's this one minute, and that the next. Make up your mind, will you? Once you've figured out what you want, let me know.
	Bennet_IsOnBoard = LOG_OBSOLETE;
	Crewmember_Count -= 1;
	Npc_ExchangeRoutine(self,"Start");
};


instance DIA_Bennet_StillNeedYou(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 55;
	condition = DIA_Bennet_StillNeedYou_Condition;
	information = DIA_Bennet_StillNeedYou_Info;
	permanent = TRUE;
	description = "Come back. I can't find another smith.";
};


func int DIA_Bennet_StillNeedYou_Condition()
{
	if(((Bennet_IsOnBoard == LOG_OBSOLETE) || (Bennet_IsOnBoard == LOG_FAILED)) && (Crewmember_Count < Max_Crew))
	{
		if(Bennet_WasOnBoard == TRUE)
		{
			DIA_Bennet_StillNeedYou.description = "Come back. I can't find another smith.";
		}
		else
		{
			DIA_Bennet_StillNeedYou.description = "Be my smith, then. See you at the harbor.";
		};
		return TRUE;
	};
};

func void DIA_Bennet_StillNeedYou_Info()
{
	if(Bennet_WasOnBoard == TRUE)
	{
	AI_Output (other, self, "DIA_Bennet_StillNeedYou_15_00");	//Come back. I can't find another smith.
	AI_Output (self, other, "DIA_Bennet_StillNeedYou_06_01");	//(irritated) Right! It's only me, so who cares. See you later at the dock.
	}
	else
	{
		B_Bennet_BeMySmith();
	};
	B_UpdateBennetItemsCount();
	B_JoinShip(self);
};


instance DIA_Bennet_PICKPOCKET(C_Info)
{
	npc = SLD_809_Bennet;
	nr = 900;
	condition = DIA_Bennet_PICKPOCKET_Condition;
	information = DIA_Bennet_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Bennet_PICKPOCKET_Condition()
{
	return C_Beklauen(35,45);
};

func void DIA_Bennet_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Bennet_PICKPOCKET);
	Info_AddChoice(DIA_Bennet_PICKPOCKET,Dialog_Back,DIA_Bennet_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Bennet_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Bennet_PICKPOCKET_DoIt);
};

func void DIA_Bennet_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Bennet_PICKPOCKET);
};

func void DIA_Bennet_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Bennet_PICKPOCKET);
};

