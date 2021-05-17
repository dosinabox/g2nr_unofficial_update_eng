
instance DIA_Rangar_EXIT(C_Info)
{
	npc = MIL_321_Rangar;
	nr = 999;
	condition = DIA_Rangar_EXIT_Condition;
	information = DIA_Rangar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Rangar_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Rangar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Rangar_PICKPOCKET(C_Info)
{
	npc = MIL_321_Rangar;
	nr = 900;
	condition = DIA_Rangar_PICKPOCKET_Condition;
	information = DIA_Rangar_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40_Key;
};


func int DIA_Rangar_PICKPOCKET_Condition()
{
//	return C_StealItems(30,Hlp_GetInstanceID(ItKe_City_Tower_02),1);
	if(Npc_HasItems(self,ItKe_City_Tower_02))
	{
		return C_StealItem(30);
	};
	return FALSE;
};

func void DIA_Rangar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Rangar_PICKPOCKET);
	Info_AddChoice(DIA_Rangar_PICKPOCKET,Dialog_Back,DIA_Rangar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Rangar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Rangar_PICKPOCKET_DoIt);
};

func void DIA_Rangar_PICKPOCKET_DoIt()
{
//	B_StealItems(30,Hlp_GetInstanceID(ItKe_City_Tower_02),1);
	B_StealItem(30,Hlp_GetInstanceID(ItKe_City_Tower_02));
	Info_ClearChoices(DIA_Rangar_PICKPOCKET);
};

func void DIA_Rangar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Rangar_PICKPOCKET);
};


instance DIA_Rangar_Hallo(C_Info)
{
	npc = MIL_321_Rangar;
	nr = 2;
	condition = DIA_Rangar_Hallo_Condition;
	information = DIA_Rangar_Hallo_Info;
	permanent = FALSE;
	description = "Hey, what's up?";
};


func int DIA_Rangar_Hallo_Condition()
{
	if((Npc_GetDistToWP(self,"NW_CITY_PALCAMP_15") >= 500) && (Npc_GetDistToWP(self,"NW_CITY_WAY_TO_SHIP_03") >= 500))
	{
		return TRUE;
	};
};

func void DIA_Rangar_Hallo_Info()
{
	AI_Output (other, self, "DIA_Rangar_Hallo_15_00");	//Hey, what's up?
	AI_Output (self, other, "DIA_Rangar_Hallo_07_01");	//As long as the paladins don't have any new assignments for me, I can have myself a couple of beers here. What more could you ask? (grins)
	AI_Output (other, self, "DIA_Rangar_Hallo_15_02");	//You're working for the paladins?
	AI_Output (self, other, "DIA_Rangar_Hallo_07_03");	//Yeah, I report to them on the situation in the city. At the moment, everything is quiet.
};


func void B_AskRangarAboutCityOrk()
{
	if((Knows_Ork == TRUE) && !Npc_IsDead(CityOrc) && (RangarToldAboutOrc == FALSE))
	{
		AI_Output (other, self, "DIA_Rangar_Bier_15_07");	//They've even spotted an orc outside of town.
		AI_Output (self, other, "DIA_Rangar_Bier_07_08");	//Yeah, right, the dangerous orc outside the city. A real monster of an orc. He's bound to attack the city soon.
		AI_Output (self, other, "DIA_Rangar_Bier_07_09");	//Listen, we'll kick that fat orc in his fat ass if he comes too close to the city. Got it?
		AI_Output (other, self, "DIA_Rangar_Bier_15_10");	//I see.
		RangarToldAboutOrc = TRUE;
	};
};

instance DIA_Rangar_Ork(C_Info)
{
	npc = MIL_321_Rangar;
	nr = 3;
	condition = DIA_Rangar_Ork_Condition;
	information = DIA_Rangar_Ork_Info;
	permanent = FALSE;
	description = "How are things with the orcs?";
};


func int DIA_Rangar_Ork_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rangar_Hallo) && (Npc_GetDistToWP(self,"NW_CITY_PALCAMP_15") >= 500) && (Npc_GetDistToWP(self,"NW_CITY_WAY_TO_SHIP_03") >= 500))
	{
		return TRUE;
	};
};

func void DIA_Rangar_Ork_Info()
{
	AI_Output(other,self,"DIA_Rangar_Ork_15_00");	//How are things with the orcs?
	AI_Output(self,other,"DIA_Rangar_Ork_07_01");	//No reason to worry - we in the city guard and the paladins have everything under control.
	if((other.guild != GIL_MIL) && (other.guild != GIL_PAL))
	{
		AI_Output(self,other,"DIA_Rangar_Ork_07_02");	//Go home and let us do our work. We're watching over the town and its citizens. -HIC-
	};
	if(MIS_Garvell_Infos == FALSE)
	{
		B_AskRangarAboutCityOrk();
	};
};


instance DIA_Rangar_Bier(C_Info)
{
	npc = MIL_321_Rangar;
	nr = 4;
	condition = DIA_Rangar_Bier_Condition;
	information = DIA_Rangar_Bier_Info;
	permanent = TRUE;
	description = "Would you like another beer?";
};


func int DIA_Rangar_Bier_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rangar_Ork) && (Npc_GetDistToWP(self,"NW_CITY_PALCAMP_15") >= 500) && (Npc_GetDistToWP(self,"NW_CITY_WAY_TO_SHIP_03") >= 500))
	{
		if(MIS_Garvell_Infos == LOG_Running)
		{
			return TRUE;
		}
		else if((MIS_Garvell_Infos == FALSE) && (Knows_Ork == TRUE) && !Npc_IsDead(CityOrc) && (RangarToldAboutOrc == FALSE))
		{
			return TRUE;
		};
	};
};

func void DIA_Rangar_Bier_Info()
{
	AI_Output (other, self, "DIA_Rangar_Bier_15_00");	//Would you like another beer?
	if (B_GiveInvItems (other, self, ItFo_Beer, 1))
	{
		if((RangarToldAboutPaladins == FALSE) && (MIS_Garvell_Infos == LOG_Running))
		{
			AI_Output(self,other,"DIA_Rangar_Bier_07_01");	//Ah - there's nothing better than a cool ale.
			B_UseItem(self,ItFo_Beer);
			AI_Output(self,other,"DIA_Rangar_Bier_07_12");	//You know, you don't often meet someone who'll treat you to a beer. You're all right.
			AI_Output(other,self,"DIA_Rangar_Bier_15_02");	//You were about to say something about the orcs...
			AI_Output (self, other, "DIA_Rangar_Bier_07_03");	//Oh, yeah, right. The orcs are absolutely no threat to the city.
			AI_Output (self, other, "DIA_Rangar_Bier_07_04");	//They're stuck in the Valley of Mines. And the pass is held by the paladins.
			AI_Output (self, other, "DIA_Rangar_Bier_07_05");	//Not even a meatbug could get through there.
			RangarToldAboutPaladins = TRUE;
		}
		else if((RangarToldAboutPaladins == TRUE) || (MIS_Garvell_Infos == FALSE))
		{
			AI_Output(self,other,"DIA_Rangar_Bier_07_06");	//I won't say no to a decent pint.
			B_UseItem(self,ItFo_Beer);
			AI_Output(self,other,"DIA_Rangar_Bier_07_11");	//A tasty bitter ale is absolutely the best.
			B_AskRangarAboutCityOrk();
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Rangar_Bier_07_13");	//Sure I want another beer. Get me one.
		AI_StopProcessInfos (self);
	};
};


instance DIA_Addon_Rangar_Erwischt(C_Info)
{
	npc = MIL_321_Rangar;
	nr = 5;
	condition = DIA_Addon_Rangar_Erwischt_Condition;
	information = DIA_Addon_Rangar_Erwischt_Info;
	description = "What are you doing there?";
};


func int DIA_Addon_Rangar_Erwischt_Condition()
{
	if((Npc_GetDistToWP(self,"NW_CITY_PALCAMP_15") < 500) && (MIS_Addon_Martin_GetRangar == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Rangar_Erwischt_Info()
{
	AI_Output (other, self, "DIA_Addon_Rangar_Erwischt_15_00");	//What are you doing there?
	AI_Output (self, other, "DIA_Addon_Rangar_Erwischt_07_01");	//(feeling caught) Uuhm. I... Er... It's none of your business. Get lost.
	AI_Output (other, self, "DIA_Addon_Rangar_Erwischt_15_02");	//Martin will be so happy when I tell him who's rummaging through his belongings while he's gone.
	AI_Output (self, other, "DIA_Addon_Rangar_Erwischt_07_03");	//(scornfully) You do whatever you want. I'll be on my way then, little man.
	B_GivePlayerXP (XP_Addon_Martin_GotRangar);
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Start");
	SC_GotRangar = TRUE;
};


instance DIA_Addon_Rangar_nachhaken(C_Info)
{
	npc = MIL_321_Rangar;
	nr = 2;
	condition = DIA_Addon_Rangar_nachhaken_Condition;
	information = DIA_Addon_Rangar_nachhaken_Info;
	permanent = TRUE;
	description = "Do you really think you're going to get away with this?";
};


func int DIA_Addon_Rangar_nachhaken_Condition()
{
	if((SC_GotRangar == TRUE) && (MIS_Addon_Martin_GetRangar == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Rangar_nachhaken_Info()
{
	AI_Output (other, self, "DIA_Addon_Rangar_nachhaken_15_00");	//Do you really think you're going to get away with this?
	AI_Output (self, other, "DIA_Addon_Rangar_nachhaken_07_01");	//(indifferently) Don't make such a fuss about a little bit of grub.
};

