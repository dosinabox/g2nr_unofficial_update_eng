
instance DIA_Mika_EXIT(C_Info)
{
	npc = MIL_337_Mika;
	nr = 999;
	condition = DIA_Mika_EXIT_Condition;
	information = DIA_Mika_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Mika_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Mika_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


var int Mika_FreeHelp;

func int C_Mika_FreeHelp()
{
	if(Mika_FreeHelp == TRUE)
	{
		return TRUE;
	}
	else if((VisibleGuild(other) == GIL_KDF) || (VisibleGuild(other) == GIL_PAL) || (VisibleGuild(other) == GIL_MIL))
	{
		Mika_FreeHelp = TRUE;
		return TRUE;
	};
	return FALSE;
};

instance DIA_Mika_Refuse(C_Info)
{
	npc = MIL_337_Mika;
	nr = 1;
	condition = DIA_Mika_Refuse_Condition;
	information = DIA_Mika_Refuse_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Mika_Refuse_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Npc_GetDistToWP(self,"NW_FARM2_PATH_03") >= 10000))
	{
		if((Lares.aivar[AIV_PARTYMEMBER] == TRUE) && (Npc_GetDistToNpc(self,Lares) < 2000))
		{
			return TRUE;
		}
		else if(Npc_GetDistToWP(self,"NW_CITY_KASERN_BARRACK02_03") < 3000)
		{
			return TRUE;
		};
	};
};

func void DIA_Mika_Refuse_Info()
{
	if(C_Mika_FreeHelp())
	{
		AI_Output(self,other,"DIA_Mika_REFUSE_12_00_add");	//We'll talk again.
	}
	else
	{
		B_Say(self,other,"$NOTNOW");
	};
	AI_StopProcessInfos(self);
};


instance DIA_Mika_WOHIN(C_Info)
{
	npc = MIL_337_Mika;
	nr = 4;
	condition = DIA_Mika_WOHIN_Condition;
	information = DIA_Mika_WOHIN_Info;
	important = TRUE;
};


func int DIA_Mika_WOHIN_Condition()
{
	if((Lares.aivar[AIV_PARTYMEMBER] == FALSE) && (Npc_GetDistToWP(self,"NW_CITY_TO_FOREST_01") < 700))
	{
		if(ArmorEquipped(other,ITAR_MIL_L))
		{
			return TRUE;
		};
		if(!C_Mika_FreeHelp())
		{
			return TRUE;
		};
	};
};

func void DIA_Mika_WOHIN_Info()
{
	if(VisibleGuild(other) == GIL_MIL)
	{
		AI_Output(self,other,"DIA_Mika_WOHIN_Bauern_12_01_add");	//Strolling about alone out here is dangerous... If you need my help, you know where to find me.
	}
	else
	{
		AI_Output(self,other,"DIA_Mika_WOHIN_12_00");	//Hey, hey. Not so fast. Strolling about alone out here is dangerous. Where do you come from?
		Info_ClearChoices(DIA_Mika_WOHIN);
		Info_AddChoice(DIA_Mika_WOHIN,"That's none of your business.",DIA_Mika_WOHIN_weg);
		if(other.guild == GIL_NONE)
		{
			Info_AddChoice(DIA_Mika_WOHIN,"From one of the farms.",DIA_Mika_WOHIN_Bauern);
		}
		else if(other.guild == GIL_NOV)
		{
			Info_AddChoice(DIA_Mika_WOHIN,"From the monastery.",DIA_Mika_WOHIN_Kloster);
		};
		Info_AddChoice(DIA_Mika_WOHIN,"From the city.",DIA_Mika_WOHIN_stadt);
	};
};

func void DIA_Mika_WOHIN_stadt()
{
	AI_Output (other, self, "DIA_Mika_WOHIN_stadt_15_00");	//From the city!
	AI_Output (self, other, "DIA_Mika_WOHIN_stadt_12_01");	//Well, well. Then what are you doing wandering around out here, so far from the protective walls of the city?
	Info_ClearChoices (DIA_Mika_WOHIN);
};

func void DIA_Mika_WOHIN_Bauern()
{
	AI_Output (other, self, "DIA_Mika_WOHIN_Bauern_15_00");	//From one of the farms.
	AI_Output (self, other, "DIA_Mika_WOHIN_Bauern_12_01");	//A farmer, eh? Hmm. Then you shouldn't be walking along these dangerous paths all by yourself. Who knows who might be lying in wait for you.
	Info_ClearChoices (DIA_Mika_WOHIN);
};

func void DIA_Mika_WOHIN_Kloster()
{
	AI_Output(other,self,"DIA_Mika_WOHIN_Kloster_15_00_add");	//From the monastery.
	AI_Output(self,other,"DIA_Mika_WOHIN_Kloster_12_01_add");	//Then you shouldn't be walking along these dangerous paths all by yourself. Who knows who might be lying in wait for you.
	Info_ClearChoices(DIA_Mika_WOHIN);
};

func void DIA_Mika_WOHIN_weg()
{
	AI_Output(other,self,"DIA_Mika_WOHIN_weg_15_00");	//That's none of your business.
	AI_Output(self,other,"DIA_Mika_WOHIN_weg_12_01");	//If you say so. But don't go whining about it afterwards if somebody skins you. Have a nice day.
	AI_StopProcessInfos(self);
};


instance DIA_Mika_WASGEFAEHRLICH(C_Info)
{
	npc = MIL_337_Mika;
	nr = 5;
	condition = DIA_Mika_WASGEFAEHRLICH_Condition;
	information = DIA_Mika_WASGEFAEHRLICH_Info;
	description = "What's so dangerous out here?";
};


func int DIA_Mika_WASGEFAEHRLICH_Condition()
{
	if(!C_Mika_FreeHelp())
	{
		return TRUE;
	};
};

func void DIA_Mika_WASGEFAEHRLICH_Info()
{
	AI_Output(other,self,"DIA_Mika_WASGEFAEHRLICH_15_00");	//What's so dangerous out here?
	AI_Output(self,other,"DIA_Mika_WASGEFAEHRLICH_12_01");	//Many things.
	AI_Output(self,other,"DIA_Mika_WASGEFAEHRLICH_12_02");	//For one thing, there's the bandits. They'd polish off a little wimp like you for breakfast.
	if((VisibleGuild(other) != GIL_SLD) && (VisibleGuild(other) != GIL_DJG))
	{
		AI_Output(self,other,"DIA_Mika_WASGEFAEHRLICH_12_03");	//If the bandits don't catch you, then the wild animals in the forest or the mercenaries roaming around will take care of you.
	};
	if(!Npc_HasEquippedArmor(other) || (VisibleGuild(other) == GIL_BAU) || (VisibleGuild(other) == GIL_VLK))
	{
		AI_Output(self,other,"DIA_Mika_WASGEFAEHRLICH_12_04");	//So, first get yourself some decent armor before you go out.
	};
	if(VisibleGuild(other) != GIL_MIL)
	{
		AI_Output(self,other,"DIA_Mika_WASGEFAEHRLICH_12_05");	//I bet you'll be yelling for my help after the next bend in the road.
	};
};


instance DIA_Mika_WASKOSTETHILFE(C_Info)
{
	npc = MIL_337_Mika;
	nr = 6;
	condition = DIA_Mika_WASKOSTETHILFE_Condition;
	information = DIA_Mika_WASKOSTETHILFE_Info;
	description = "Just assuming I would fall back on your help.";
};


func int DIA_Mika_WASKOSTETHILFE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Mika_WASGEFAEHRLICH) && (Mika_Helps == FALSE) && !C_Mika_FreeHelp())
	{
		return TRUE;
	};
};

func void DIA_Mika_WASKOSTETHILFE_Info()
{
	AI_Output (other, self, "DIA_Mika_WASKOSTETHILFE_15_00");	//Just assuming I would fall back on your help. How much would that cost me?
	AI_Output (self, other, "DIA_Mika_WASKOSTETHILFE_12_01");	//I am merely a humble servant of the king and would not enjoy fleecing a helpless little citizen of the realm.
	AI_Output (self, other, "DIA_Mika_WASKOSTETHILFE_12_02");	//But you know, if you put it like that, I wouldn't object to a little financial backing to promote our future business relationship.
	AI_Output (self, other, "DIA_Mika_WASKOSTETHILFE_12_03");	//10 gold coins should do for starters. What do you think?
	Info_ClearChoices (DIA_Mika_WASKOSTETHILFE);
	Info_AddChoice (DIA_Mika_WASKOSTETHILFE, "I'll think about it.", DIA_Mika_WASKOSTETHILFE_nochnicht);
	Info_AddChoice (DIA_Mika_WASKOSTETHILFE, "Why not? Here's your 10 coins.", DIA_Mika_WASKOSTETHILFE_ja);
};

func void DIA_Mika_WASKOSTETHILFE_ja()
{
	AI_Output (other, self, "DIA_Mika_WASKOSTETHILFE_ja_15_00");	//Why not? Here's your 10 coins.
	if (B_GiveInvItems (other, self, ItMi_Gold, 10))
	{
		AI_Output (self, other, "DIA_Mika_WASKOSTETHILFE_ja_12_01");	//Terrific. If you need my help, you know where to find me.
		AI_Output (self, other, "DIA_Mika_WASKOSTETHILFE_ja_12_02");	//But please do me a favor, don't come to me with any trifles. I can't stand that, you hear??
		Mika_Helps = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Mika_WASKOSTETHILFE_ja_12_03");	//You haven't got the money. Maybe you should think again whether you really want my help.
	};
	AI_StopProcessInfos(self);
};

func void DIA_Mika_WASKOSTETHILFE_nochnicht()
{
	AI_Output (other, self, "DIA_Mika_WASKOSTETHILFE_nochnicht_15_00");	//I'll think about it.
	AI_Output (self, other, "DIA_Mika_WASKOSTETHILFE_nochnicht_12_01");	//Suit yourself. Have a nice death.
	AI_StopProcessInfos (self);
};


instance DIA_Mika_UEBERLEGT(C_Info)
{
	npc = MIL_337_Mika;
	nr = 7;
	condition = DIA_Mika_UEBERLEGT_Condition;
	information = DIA_Mika_UEBERLEGT_Info;
	permanent = TRUE;
	description = "I changed my mind. I'll pay you the 10 gold coins.";
};


func int DIA_Mika_UEBERLEGT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Mika_WASKOSTETHILFE) && (Mika_Helps == FALSE) && !C_Mika_FreeHelp())
	{
		return TRUE;
	};
};

func void DIA_Mika_UEBERLEGT_Info()
{
	AI_Output (other, self, "DIA_Mika_UEBERLEGT_15_00");	//I changed my mind. I'll pay you the 10 gold coins.
	if (B_GiveInvItems (other, self, ItMi_Gold, 10))
	{
		AI_Output (self, other, "DIA_Mika_UEBERLEGT_12_01");	//Wonderful. Better late than never. And now?
		Mika_Helps = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Mika_UEBERLEGT_12_02");	//(angry) Come back when you have the money.
		AI_StopProcessInfos (self);
	};
};


instance DIA_Mika_HILFE(C_Info)
{
	npc = MIL_337_Mika;
	nr = 8;
	condition = DIA_Mika_HILFE_Condition;
	information = DIA_Mika_HILFE_Info;
	permanent = TRUE;
	description = "I need your help.";
};


func int DIA_Mika_HILFE_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == FALSE) && (C_Mika_FreeHelp() || (Mika_Helps == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Mika_HILFE_Info()
{
	AI_Output(other,self,"DIA_Mika_HILFE_15_00");	//I need your help.
	if(C_Mika_FreeHelp())
	{
		AI_Output(self,other,"DIA_Mika_HILFE_12_01_add");	//What's wrong?
	}
	else
	{
		AI_Output(self,other,"DIA_Mika_HILFE_12_01");	//If it's absolutely necessary ... What's wrong?
	};
	Mika_Helps = TRUE;
	Info_ClearChoices(DIA_Mika_HILFE);
	Info_AddChoice(DIA_Mika_HILFE,Dialog_Back,DIA_Mika_HILFE_BACK);
	Info_AddChoice(DIA_Mika_HILFE,"I'm being chased by bandits.",DIA_Mika_HILFE_schongut);
	Info_AddChoice(DIA_Mika_HILFE,"I'm being attacked by monsters.",DIA_Mika_HILFE_monster);
	if(!C_AkilFarmIsFree() && (Akils_SLDStillthere == TRUE) && (Kapitel < 4))
	{
		Info_AddChoice(DIA_Mika_HILFE,"The farmer Akil is under attack by mercenaries.",DIA_Mika_HILFE_Akil);
	};
};

func void DIA_Mika_HILFE_BACK()
{
	Info_ClearChoices(DIA_Mika_HILFE);
};

func void DIA_Mika_HILFE_Akil()
{
	AI_Output(other,self,"DIA_Mika_HILFE_Akil_15_00");	//The farmer Akil is under attack by mercenaries.
	AI_Output(self,other,"DIA_Mika_HILFE_Akil_12_01");	//(agitated) What? Those riff-raff are hanging around on Akil's farm? Then let's not waste any time. Follow me.
	AI_StopProcessInfos(self);
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	B_GivePlayerXP (XP_Ambient);
	B_LogEntry (TOPIC_AkilsSLDStillthere, "Mika wants to help me solve the mercenary problem on Akil's farm.");
	Npc_ExchangeRoutine (self, "Akil");
};

func void DIA_Mika_HILFE_monster()
{
	AI_Output (other, self, "DIA_Mika_HILFE_monster_15_00");	//I'm being attacked by monsters.
	AI_Output (self, other, "DIA_Mika_HILFE_monster_12_01");	//But I don't see any monsters right now. I'm sure you're just making that up.
	AI_StopProcessInfos (self);
};

func void DIA_Mika_HILFE_schongut()
{
	AI_Output (other, self, "DIA_Mika_HILFE_schongut_15_00");	//I'm being chased by bandits.
	AI_Output (self, other, "DIA_Mika_HILFE_schongut_12_01");	//Really? Where are they then? If you were being chased, I should be able to see at least one of them, right?
	AI_StopProcessInfos (self);
};


instance DIA_Mika_Zack(C_Info)
{
	npc = MIL_337_Mika;
	nr = 8;
	condition = DIA_Mika_Zack_Condition;
	information = DIA_Mika_Zack_Info;
	important = TRUE;
};


func int DIA_Mika_Zack_Condition()
{
	if((Npc_GetDistToWP(self,"NW_FARM2_PATH_03") < 500) && (Kapitel < 4))
	{
		if(!C_AkilFarmIsFree())
		{
			return TRUE;
		};
	};
};

func void DIA_Mika_Zack_Info()
{
	AI_Output(self,other,"DIA_Mika_Zack_12_00");	//Now watch how this works.
	Info_ClearChoices(DIA_Mika_Zack);
	Info_AddChoice(DIA_Mika_Zack,Dialog_Ende,DIA_Mika_Zack_los);
};

func void DIA_Mika_Zack_los()
{
	AI_StopProcessInfos(self);
	if(!Npc_IsDead(Alvares))
	{
		Alvares.aivar[AIV_EnemyOverride] = FALSE;
	};
	if(!Npc_IsDead(Engardo))
	{
		Engardo.aivar[AIV_EnemyOverride] = FALSE;
	};
};


instance DIA_Mika_WIEDERNACHHAUSE(C_Info)
{
	npc = MIL_337_Mika;
	nr = 9;
	condition = DIA_Mika_WIEDERNACHHAUSE_Condition;
	information = DIA_Mika_WIEDERNACHHAUSE_Info;
	important = TRUE;
};


func int DIA_Mika_WIEDERNACHHAUSE_Condition()
{
	if(Npc_GetDistToWP(self,"NW_FARM2_PATH_03") < 1000)
	{
		if(C_AkilFarmIsFree())
		{
			return TRUE;
		};
		if(Kapitel >= 4)
		{
			return TRUE;
		};
	};
};

func void DIA_Mika_WIEDERNACHHAUSE_Info()
{
	AI_Output(self,other,"DIA_Mika_WIEDERNACHHAUSE_12_00");	//All right. That's that. I'll be off then.
	AI_StopProcessInfos(self);
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"Start");
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Mika_Kap3u4u5_PERM(C_Info)
{
	npc = MIL_337_Mika;
	nr = 39;
	condition = DIA_Mika_Kap3u4u5_PERM_Condition;
	information = DIA_Mika_Kap3u4u5_PERM_Info;
	permanent = TRUE;
	description = "All quiet?";
};


func int DIA_Mika_Kap3u4u5_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Mika_WIEDERNACHHAUSE) || C_Mika_FreeHelp())
	{
		return TRUE;
	};
};

func void DIA_Mika_Kap3u4u5_PERM_Info()
{
	AI_Output(other,self,"DIA_Mika_Kap3u4u5_PERM_15_00");	//All quiet?
	if(C_Mika_FreeHelp())
	{
		AI_Output(self,other,"DIA_Mika_WOHIN_weg_12_01_add");	//Have a nice day.
	}
	else
	{
		AI_Output(self,other,"DIA_Mika_Kap3u4u5_PERM_12_01");	//You're still alive. I'm impressed.
	};
};


instance DIA_Mika_PICKPOCKET(C_Info)
{
	npc = MIL_337_Mika;
	nr = 900;
	condition = DIA_Mika_PICKPOCKET_Condition;
	information = DIA_Mika_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Mika_PICKPOCKET_Condition()
{
	return C_Beklauen(65,75);
};

func void DIA_Mika_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Mika_PICKPOCKET);
	Info_AddChoice(DIA_Mika_PICKPOCKET,Dialog_Back,DIA_Mika_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Mika_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Mika_PICKPOCKET_DoIt);
};

func void DIA_Mika_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Mika_PICKPOCKET);
};

func void DIA_Mika_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Mika_PICKPOCKET);
};

