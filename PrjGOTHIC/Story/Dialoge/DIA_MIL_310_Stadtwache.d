
instance DIA_Mil_310_Stadtwache_EXIT(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 999;
	condition = DIA_Mil_310_Stadtwache_EXIT_Condition;
	information = DIA_Mil_310_Stadtwache_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Mil_310_Stadtwache_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Mil_310_Stadtwache_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


func void B_CityMainGatesPass()
{
	self.aivar[AIV_PASSGATE] = TRUE;
	Stadtwache_333.aivar[AIV_PASSGATE] = TRUE;
	Mil_310_schonmalreingelassen = TRUE;
	B_CheckLog();
};

const string Mil_310_Checkpoint = "NW_CITY_ENTRANCE_MAIN";

var int MIL_310_Personal_AbsolutionLevel;

instance DIA_Mil_310_Stadtwache_FirstWarn(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 1;
	condition = DIA_Mil_310_Stadtwache_FirstWarn_Condition;
	information = DIA_Mil_310_Stadtwache_FirstWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Mil_310_Stadtwache_FirstWarn_Condition()
{
	if(Npc_GetDistToWP(other,Mil_310_Checkpoint) <= 700)
	{
		Npc_SetRefuseTalk(self,5);
		return FALSE;
	};
	if((B_GetGreatestPetzCrime(self) >= CRIME_ATTACK) && (B_GetCurrentAbsolutionLevel(self) == MIL_310_Personal_AbsolutionLevel))
	{
		self.aivar[AIV_PASSGATE] = FALSE;
	}
	else if(Mil_310_schonmalreingelassen == TRUE)
	{
		self.aivar[AIV_PASSGATE] = TRUE;
	};
	if((self.aivar[AIV_Guardpassage_Status] == GP_NONE) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && !Npc_RefuseTalk(self))
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_FirstWarn_Info()
{
	AI_Output(self,other,"DIA_Mil_310_Stadtwache_FirstWarn_07_00");	//HALT!
	if(B_GetGreatestPetzCrime(self) >= CRIME_ATTACK)
	{
		AI_Output (other, self, "DIA_Mil_310_Stadtwache_FirstWarn_15_01");	//(sighs) What is it?
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_02");	//You know exactly what!
		if (B_GetGreatestPetzCrime (self) == CRIME_MURDER)
		{
			AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_03");	//You are wanted in the city for murder!
		};
		if(B_GetGreatestPetzCrime(self) == CRIME_THEFT)
		{
			AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_04");	//We don't need any filthy thieves here!
		};
		if(B_GetGreatestPetzCrime(self) == CRIME_ATTACK)
		{
			AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_05");	//We don't need any troublemakers in our city!
		};
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_06");	//Why do you think we should let you in?
	}
	else
	{
		if(!Npc_HasEquippedArmor(other))
		{
			AI_Output (other, self, "DIA_Mil_310_Stadtwache_FirstWarn_15_07");	//What is it?
			AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_08");	//YOU aren't getting in here, my boy!
			AI_Output (other, self, "DIA_Mil_310_Stadtwache_FirstWarn_15_09");	//Why not?
			AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_10");	//Looking the way you do, you're sure to cause nothing but trouble here, boy!
			AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_11");	//We've got enough rabble in the city. We have no use for people without money.
			if((self.aivar[AIV_Guardpassage_Status] == GP_NONE) && (Mil_333_schonmalreingelassen == FALSE) && (PlayerEnteredCity == FALSE))
			{
				Log_CreateTopic(TOPIC_City,LOG_MISSION);
				Log_SetTopicStatus(TOPIC_City,LOG_Running);
				B_LogEntry(TOPIC_City,"For the gate guards to let me into the city, I have to look like I've got money. Either that, or I must find another way.");
			};
		}
		else if(VisibleGuild(other) == GIL_BAU)
		{
			if(self.aivar[AIV_TalkedToPlayer] == TRUE)
			{
				AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_12");	//What do you want this time?
				AI_Output (other, self, "DIA_Mil_310_Stadtwache_FirstWarn_15_13");	//The farmer sent me.
				AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_14");	//So? Have you at least got a good reason for coming here this time?
			}
			else
			{
				AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_15");	//Are you one of the hands on Lobart's farm? I've never seen you here!
				AI_Output (other, self, "DIA_Mil_310_Stadtwache_FirstWarn_15_16");	//I haven't been with Lobart for long.
				AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_17");	//What do you want in the city?
			};
		}
		else
		{
			AI_Output(other,self,"DIA_Mil_310_Stadtwache_FirstWarn_15_18");	//(calmly) What?
			if((VisibleGuild(other) == GIL_PAL) || (VisibleGuild(other) == GIL_KDF))
			{
				AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_19");	//Pardon me, but those are our instructions.
				AI_Output (other, self, "DIA_Mil_310_Stadtwache_FirstWarn_15_20");	//Are you trying to stop me?
				AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_21");	//Of course not. All members of the church of Innos are naturally welcome.
			}
			else
			{
				AI_Output (self, other, "DIA_Mil_310_Stadtwache_FirstWarn_07_22");	//I only wanted to take a look at you. Looks like you've got money. You can go in.
			};
			B_CityMainGatesPass();
			AI_StopProcessInfos(self);
		};
	};
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,Mil_310_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_FirstWarnGiven;
};


instance DIA_Mil_310_Stadtwache_SecondWarn(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 2;
	condition = DIA_Mil_310_Stadtwache_SecondWarn_Condition;
	information = DIA_Mil_310_Stadtwache_SecondWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Mil_310_Stadtwache_SecondWarn_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_FirstWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,Mil_310_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_SecondWarn_Info()
{
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_SecondWarn_07_00");	//No funny business. One more step and I'll hack you to bits!
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP (other, Mil_310_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_SecondWarnGiven;
	AI_StopProcessInfos(self);
};


instance DIA_Mil_310_Stadtwache_Attack(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 3;
	condition = DIA_Mil_310_Stadtwache_Attack_Condition;
	information = DIA_Mil_310_Stadtwache_Attack_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Mil_310_Stadtwache_Attack_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_SecondWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,Mil_310_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_Attack_Info()
{
	other.aivar[AIV_LastDistToWP] = 0;
	self.aivar[AIV_Guardpassage_Status] = GP_NONE;
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Attack_07_00");	//You asked for it...
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_GuardStopsIntruder, 0);
};


instance DIA_Mil_310_Stadtwache_Bribe(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 5;
	condition = DIA_Mil_310_Stadtwache_Bribe_Condition;
	information = DIA_Mil_310_Stadtwache_Bribe_Info;
	permanent = TRUE;
	description = "Here's 100 gold pieces. Let me pass!";
};


func int DIA_Mil_310_Stadtwache_Bribe_Condition()
{
	if(self.aivar[AIV_PASSGATE] == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_Bribe_Info()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Bribe_15_00");	//Here's 100 gold pieces. Let me pass!
	if (B_GiveInvItems (other, self, ItMi_Gold, 100))
	{
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_Bribe_07_01");	//(greedy) 100 gold pieces sounds good. In you go then.
		if (B_GetGreatestPetzCrime (self) >= CRIME_ATTACK)
		{
			AI_Output (self, other, "DIA_Mil_310_Stadtwache_Bribe_07_02");	//And go straight to Lord Andre! Otherwise you'll be out another 100 gold pieces the next time!
		};
		B_CityMainGatesPass();
		MIL_310_Personal_AbsolutionLevel = B_GetCurrentAbsolutionLevel(self) + 1;
	}
	else
	{
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_Bribe_07_03");	//What?! Where?! I don't see 100 gold pieces. Beat it!
	};
	AI_StopProcessInfos(self);
};


instance DIA_Mil_310_Stadtwache_Passierschein(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 4;
	condition = DIA_Mil_310_Stadtwache_Passierschein_Condition;
	information = DIA_Mil_310_Stadtwache_Passierschein_Info;
	permanent = FALSE;
	description = "I've got a pass!";
};


func int DIA_Mil_310_Stadtwache_Passierschein_Condition()
{
	if(Npc_HasItems(other,ItWr_Passierschein) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK) && (Mil_310_schonmalreingelassen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_Passierschein_Info()
{
	AI_Output(other,self,"DIA_Mil_310_Stadtwache_Passierschein_15_00");	//I've got a pass!
	if(!Npc_HasEquippedArmor(other))
	{
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_Passierschein_07_01");	//Really? And who did you kill for that, you cut-throat?
		AI_Output (other, self, "DIA_Mil_310_Stadtwache_Passierschein_15_02");	//Now will you let me pass, or not?
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_Passierschein_07_03");	//Well, go on in before I change my mind!
	}
	else
	{
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_Passierschein_07_04");	//Seems to be all right. Go on.
	};
	B_CityMainGatesPass();
	AI_StopProcessInfos(self);
};


instance DIA_Mil_310_Stadtwache_ZumSchmied(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 3;
	condition = DIA_Mil_310_Stadtwache_ZumSchmied_Condition;
	information = DIA_Mil_310_Stadtwache_ZumSchmied_Info;
	permanent = FALSE;
	description = "I want to see the blacksmith. To have some tools repaired.";
};


func int DIA_Mil_310_Stadtwache_ZumSchmied_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Maleth_ToTheCity) && (Mil_310_schonmalreingelassen == FALSE) && (VisibleGuild(other) == GIL_BAU))
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_ZumSchmied_Info()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_ZumSchmied_15_00");	//I want to see the blacksmith. To have some tools repaired.
	if (Mil_310_Scheisse_erzaehlt == TRUE)
	{
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_ZumSchmied_07_01");	//(angry) Oh? And why didn't you say so right away?
		AI_Output (other, self, "DIA_Mil_310_Stadtwache_ZumSchmied_15_02");	//I was just curious how you would react.
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_ZumSchmied_07_03");	//What?! Try something like that with me again and I'll show you how I react to that kind of thing, you stupid yokel!
	}
	else
	{
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_ZumSchmied_07_04");	//Okay, fine, in you go then.
	};
	AI_Output(self,other,"DIA_Mil_310_Stadtwache_ZumSchmied_07_05");	//And if you see Lobart, you can tell him he should feed his sheep well, we're coming back to him shortly! (dirty laugh)
	B_CityMainGatesPass();
	B_GivePlayerXP(XP_Ambient);
	AI_StopProcessInfos(self);
};


func int C_SCHasHerbs(var int count)
{
	if(Npc_HasItems(other,ItPl_Blueplant) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Forestberry) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Planeberry) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Mana_Herb_01) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Mana_Herb_02) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Mana_Herb_03) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Health_Herb_01) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Health_Herb_02) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Health_Herb_03) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Dex_Herb_01) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Strength_Herb_01) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Speed_Herb_01) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Temp_Herb) >= count)
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItPl_Perm_Herb) >= count)
	{
		return TRUE;
	};
	return FALSE;
};

instance DIA_Addon_Mil_310_Stadtwache_Constantino(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 2;
	condition = DIA_Addon_Mil_310_Stadtwache_Constantino_Condition;
	information = DIA_Addon_Mil_310_Stadtwache_Constantino_Info;
	permanent = TRUE;
	description = "I brought some herbs for Constantino the alchemist.";
};


func int DIA_Addon_Mil_310_Stadtwache_Constantino_Condition()
{
	if((MIS_Addon_Lester_PickForConstantino == LOG_Running) && (Mil_310_schonmalreingelassen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Mil_310_Stadtwache_Constantino_Info()
{
	AI_Output(other,self,"DIA_Addon_Mil_310_Stadtwache_Constantino_15_00");	//I'm bringing some herbs for Constantino the alchemist.
	if(C_SCHasHerbs(1) || Npc_HasItems(other,ItPl_Beet) || Npc_HasItems(other,ItPl_Weed) || Npc_HasItems(other,ItPl_SwampHerb) || Npc_HasItems(other,ItPl_Sagitta_Herb_MIS))
	{
		AI_Output(self,other,"DIA_Addon_Mil_310_Stadtwache_Constantino_07_01");	//(slyly) Really? Then you won't mind showing me what you've brought.
		if(C_SCHasHerbs(MinimumPassagePlants))
		{
			AI_Output(self,other,"DIA_Addon_Mil_310_Stadtwache_Constantino_07_02");	//(approving) Mmh. Looks good. All right. In you go. But don't cause any trouble, understood?
			B_CityMainGatesPass();
			MIS_Addon_Lester_PickForConstantino = LOG_SUCCESS;
			B_GivePlayerXP(XP_Addon_PickForConstantino);
			AI_StopProcessInfos(self);
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Mil_310_Stadtwache_Constantino_07_03");	//What? What is this supposed to be?
			if (Npc_HasItems (other, ItPl_Beet) >= MinimumPassagePlants)
			{
				AI_Output (self, other, "DIA_Addon_Mil_310_Stadtwache_Constantino_07_04");	//What's an alchemist to do with a bunch of clunky turnips? Are you trying to be cute? Get lost!
			}
			else
			{
				AI_Output (self, other, "DIA_Addon_Mil_310_Stadtwache_Constantino_07_05");	//I don't know much about alchemy, but who is going to use this trussed-up bundle of mixed veggies for anything? Nice try.
			};
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Mil_310_Stadtwache_Constantino_07_06");	//What herbs? You don't have any herbs. Beat it!
	};
	AI_StopProcessInfos(self);
};


instance DIA_Mil_310_Stadtwache_MilizWerden(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 2;
	condition = DIA_Mil_310_Stadtwache_MilizWerden_Condition;
	information = DIA_Mil_310_Stadtwache_MilizWerden_Info;
	permanent = FALSE;
	description = "I've come to join the militia!";
};


func int DIA_Mil_310_Stadtwache_MilizWerden_Condition()
{
	if(Mil_310_schonmalreingelassen == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_MilizWerden_Info()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_MilizWerden_15_00");	//I've come to join the militia!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_MilizWerden_07_01");	//That's a good one! Try that at the other gate - maybe THEY'LL buy that from you.
	Mil_310_Scheisse_erzaehlt = TRUE;
};


instance DIA_Mil_310_Stadtwache_Paladine(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 1;
	condition = DIA_Mil_310_Stadtwache_Paladine_Condition;
	information = DIA_Mil_310_Stadtwache_Paladine_Info;
	permanent = FALSE;
	description = "I need to see the leader of the paladins!";
};


func int DIA_Mil_310_Stadtwache_Paladine_Condition()
{
	if(Mil_310_schonmalreingelassen == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_Paladine_Info()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_15_00");	//I need to see the leader of the paladins! I've got an important message for him!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_07_01");	//Oh? And what important message might that be?
	Mil_310_Scheisse_erzaehlt = TRUE;
	Info_ClearChoices (DIA_Mil_310_Stadtwache_Paladine);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "The city will soon be under attack!", DIA_Mil_310_Stadtwache_Paladine_AttackSoon);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "The hosts of evil are camped in the valley of Khorinis!", DIA_Mil_310_Stadtwache_Paladine_EvilArmy);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "I have come to get the Eye of Innos!", DIA_Mil_310_Stadtwache_Paladine_EyeInnos);
};

func void DIA_Mil_310_Stadtwache_Paladine_EyeInnos()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_EyeInnos_15_00");	//I have come to get the Eye of Innos!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_EyeInnos_07_01");	//What? Never heard of it - what's that supposed to be?
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_EyeInnos_15_02");	//It's an important artifact.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_EyeInnos_07_03");	//You don't look much like an important messenger. Do you have some kind of identification?
	if (!Npc_HasItems (other, ItWr_Passierschein) > 0)
	{
		AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_EyeInnos_15_04");	//No, I don't!
		AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_EyeInnos_07_05");	//Then don't waste my time!
	};
	Info_ClearChoices(DIA_Mil_310_Stadtwache_Paladine);
};

func void DIA_Mil_310_Stadtwache_Paladine_EvilArmy()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_EvilArmy_15_00");	//The hosts of evil are camped in the valley of Khorinis!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_EvilArmy_07_01");	//In the Valley of Mines? You come from there? Have you seen the army?
	Info_ClearChoices (DIA_Mil_310_Stadtwache_Paladine);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "No - but I've been sent by someone who saw them.", DIA_Mil_310_Stadtwache_Paladine_NoSomeone);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "No. But I know that it's led by dragons!", DIA_Mil_310_Stadtwache_Paladine_NoDragons);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "Yes. I was in the valley of Khorinis. I saw some gigantic dragons!", DIA_Mil_310_Stadtwache_Paladine_YesDragons);
};

func void DIA_Mil_310_Stadtwache_Paladine_AttackSoon()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_AttackSoon_15_00");	//The city will soon be under attack!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_AttackSoon_07_01");	//What? By whom? The orcs? Have you seen our army?
	Info_ClearChoices (DIA_Mil_310_Stadtwache_Paladine);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "No - but I've been sent by someone who saw them.", DIA_Mil_310_Stadtwache_Paladine_NoSomeone);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "No. But I know that it's led by dragons!", DIA_Mil_310_Stadtwache_Paladine_NoDragons);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "Yes. I was in the valley of Khorinis. I saw some gigantic dragons!", DIA_Mil_310_Stadtwache_Paladine_YesDragons);
};

func void DIA_Mil_310_Stadtwache_Paladine_NoDragons()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_NoDragons_15_00");	//No. But I know that it's led by dragons!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_NoDragons_07_01");	//Sure! And my grandmother advises the orc generals.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_NoDragons_07_02");	//You don't think we'll let you carry an old wives' tale like that to Lord Hagen!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_NoDragons_07_03");	//Scram!
	Player_KnowsLordHagen = TRUE;
	AI_StopProcessInfos(self);
};

func void DIA_Mil_310_Stadtwache_Paladine_NoSomeone()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_NoSomeone_15_00");	//No - but I've been sent by someone who saw them.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_NoSomeone_07_01");	//(distrustful) WHO sent you?
	Info_ClearChoices (DIA_Mil_310_Stadtwache_Paladine);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "I don't have permission to tell you that.", DIA_Mil_310_Stadtwache_Paladine_CantTellYou);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "A paladin.", DIA_Mil_310_Stadtwache_Paladine_APaladin);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "A magician.", DIA_Mil_310_Stadtwache_Paladine_AMage);
};

func void DIA_Mil_310_Stadtwache_Paladine_YesDragons()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_YesDragons_15_00");	//Yes. I was in the valley of Khorinis. I saw some gigantic dragons!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_YesDragons_07_01");	//You liar! The pass to the valley is held on both sides. No one gets through!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_YesDragons_07_02");	//Get out of here!
	AI_StopProcessInfos (self);
};

func void DIA_Mil_310_Stadtwache_Paladine_AMage()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_AMage_15_00");	//A magician.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_AMage_07_01");	//You have news from the magicians? Then you certainly have a seal as proof!
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_AMage_15_02");	//No.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_AMage_07_03");	//What? The magicians ALWAYS give their messengers a seal.
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_AMage_15_04");	//Not this magician.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_AMage_07_05");	//I don't believe you. If you're really a messenger, then spit out your news or clear off!
	Info_ClearChoices (DIA_Mil_310_Stadtwache_Paladine);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "I can only give this message to the paladins!", DIA_Mil_310_Stadtwache_Paladine_OnlyPaladins);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "The army of evil is led by dragons!", DIA_Mil_310_Stadtwache_Paladine_DepecheDragons);
};

func void DIA_Mil_310_Stadtwache_Paladine_APaladin()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_APaladin_15_00");	//A paladin.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_APaladin_07_01");	//Hm, that could be - the paladins hold the pass to the Valley of Mines.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_APaladin_07_02");	//Give me your message and I'll report you.
	Info_ClearChoices (DIA_Mil_310_Stadtwache_Paladine);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "I can only give this message to the paladins!", DIA_Mil_310_Stadtwache_Paladine_OnlyPaladins);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "The army of evil is led by dragons!", DIA_Mil_310_Stadtwache_Paladine_DepecheDragons);
};

func void DIA_Mil_310_Stadtwache_Paladine_CantTellYou()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_CantTellYou_15_00");	//I don't have permission to tell you that.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_CantTellYou_07_01");	//Don't act like that with me, boy! I'm a member of the city guard.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_CantTellYou_07_02");	//You can tell me EVERYTHING. So - who sent you?
};

func void DIA_Mil_310_Stadtwache_Paladine_DepecheDragons()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_DepecheDragons_15_00");	//The army of evil is led by dragons!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_DepecheDragons_07_01");	//What? That can't be true. And I came that close to letting you in.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_DepecheDragons_07_02");	//If you served up THAT story to Lord Hagen, he'd have handed me my head.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_DepecheDragons_07_03");	//Scram!
	AI_PlayAni(self,"T_GETLOST");
	Player_KnowsLordHagen = TRUE;
	AI_StopProcessInfos(self);
};

func void DIA_Mil_310_Stadtwache_Paladine_OnlyPaladins()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_OnlyPaladins_15_00");	//I can only give this message to the paladins!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_OnlyPaladins_07_01");	//It doesn't work like that, boy!
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_OnlyPaladins_07_02");	//Like hell will I let you see Lord Hagen if I can't be sure that you won't waste his valuable time.
	Player_KnowsLordHagen = TRUE;
	Info_ClearChoices (DIA_Mil_310_Stadtwache_Paladine);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "No. The message is for the paladins ONLY.", DIA_Mil_310_Stadtwache_Paladine_Only2);
	Info_AddChoice (DIA_Mil_310_Stadtwache_Paladine, "The army of evil is led by dragons!", DIA_Mil_310_Stadtwache_Paladine_DepecheDragons);
};

func void DIA_Mil_310_Stadtwache_Paladine_Only2()
{
	AI_Output (other, self, "DIA_Mil_310_Stadtwache_Paladine_Only2_15_00");	//No. The message is for the paladins ONLY.
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_Paladine_Only2_07_01");	//Then your journey ends here, stranger.
	AI_StopProcessInfos (self);
};


instance DIA_Mil_310_Stadtwache_PERM(C_Info)
{
	npc = MIL_310_Stadtwache;
	nr = 5;
	condition = DIA_Mil_310_Stadtwache_PERM_Condition;
	information = DIA_Mil_310_Stadtwache_PERM_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Mil_310_Stadtwache_PERM_Condition()
{
	if((self.aivar[AIV_PASSGATE] == TRUE) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Mil_310_Stadtwache_PERM_Info()
{
	AI_Output (self, other, "DIA_Mil_310_Stadtwache_PERM_07_00");	//Move along!
	AI_StopProcessInfos (self);
};

