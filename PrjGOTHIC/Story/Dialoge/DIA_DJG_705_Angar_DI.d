
instance DIA_Angar_DI_EXIT(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 999;
	condition = DIA_Angar_DI_EXIT_Condition;
	information = DIA_Angar_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Angar_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Angar_DI_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Angar_DI_HALLO(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 10;
	condition = DIA_Angar_DI_HALLO_Condition;
	information = DIA_Angar_DI_HALLO_Info;
	permanent = TRUE;
	description = "How are you?";
};


func int DIA_Angar_DI_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Angar_DI_HALLO_Info()
{
	AI_Output(other,self,"DIA_Angar_DI_HALLO_15_00");	//How are you?
	if(!Npc_IsDead(UndeadDragon))
	{
		AI_Output (self, other, "DIA_Angar_DI_HALLO_04_01");	//The headaches have become unbearable since we've been here on the island.
		AI_Output (self, other, "DIA_Angar_DI_HALLO_04_02");	//Damnit. This finally has to end.
	}
	else
	{
		AI_Output (self, other, "DIA_Angar_DI_HALLO_04_03");	//Don't worry about me. Let's get out of here.
	};
};


instance DIA_Angar_DI_ORKS(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 5;
	condition = DIA_Angar_DI_ORKS_Condition;
	information = DIA_Angar_DI_ORKS_Info;
	important = TRUE;
};


func int DIA_Angar_DI_ORKS_Condition()
{
	if((OrkSturmDI == TRUE) && !Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Angar_DI_ORKS_Info()
{
	AI_Output (self, other, "DIA_Angar_DI_ORKS_04_00");	//You had damn well better hurry. The next attack by the orcs will cost us our lives.
	AI_Output (other, self, "DIA_Angar_DI_ORKS_15_01");	//I'm doing my best.
	AI_Output (self, other, "DIA_Angar_DI_ORKS_04_02");	//That's not enough.
	Info_ClearChoices (DIA_Angar_DI_ORKS);
	Info_AddChoice (DIA_Angar_DI_ORKS, "Relax.", DIA_Angar_DI_ORKS_no);
	Info_AddChoice (DIA_Angar_DI_ORKS, "So help me and stop complaining.", DIA_Angar_DI_ORKS_follow);
};

func void DIA_Angar_DI_ORKS_follow()
{
	AI_Output (other, self, "DIA_Angar_DI_ORKS_follow_15_00");	//So help me and stop complaining.
	AI_Output (self, other, "DIA_Angar_DI_ORKS_follow_04_01");	//I will. You go first. Move on.
	AI_StopProcessInfos(self);
	B_GivePlayerXP(XP_AmbientKap6);
	Npc_ExchangeRoutine(self,"FollowDI");
	Angar_DI_Party = LOG_Running;
};

func void DIA_Angar_DI_ORKS_no()
{
	AI_Output (other, self, "DIA_Angar_DI_ORKS_no_15_00");	//Relax.
	AI_Output (self, other, "DIA_Angar_DI_ORKS_no_04_01");	//That's easy for you to say. I'm about to lose my mind here.
	AI_StopProcessInfos(self);
};


func void B_AngarStays()
{
	AI_Output(other,self,"DIA_Angar_DI_FOLLOW_15_00");	//Stay back now.
	if(Npc_GetDistToWP(self,"SKELETTE") < 4000)
	{
		AI_Output(other,self,"DIA_Angar_DI_FOLLOW_15_01");	//I'll have to take care of the rest by myself.
		AI_Output(self,other,"DIA_Angar_DI_FOLLOW_04_02");	//Good luck.
		AI_StopProcessInfos(self);
		Npc_ExchangeRoutine(self,"FireDragonIsland");
		if(Angar_DI_Party != LOG_SUCCESS)
		{
			B_GivePlayerXP(XP_AmbientKap6);
			Angar_DI_Party = LOG_SUCCESS;
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Angar_DI_FOLLOW_04_03");	//Sure thing.
		AI_StopProcessInfos(self);
		if(Npc_GetDistToWP(self,"SHIP") < 10000)
		{
			Npc_ExchangeRoutine(self,"Start");
		}
		else if(Npc_IsDead(FireDragonIsland))
		{
			Npc_ExchangeRoutine(self,"FireDragonIsland");
		}
		else if(Npc_IsDead(AntiPaladin_DI))
		{
			Npc_ExchangeRoutine(self,"ORKOBERST_DI");
		}
		else if(Npc_IsDead(Troll_DI))
		{
			Npc_ExchangeRoutine(self,"Troll_DI");
		}
		else
		{
			Npc_ExchangeRoutine(self,"Start");
		};
		Angar_DI_Party = LOG_OBSOLETE;
	};
};


instance DIA_Angar_DI_FOLLOW(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 5;
	condition = DIA_Angar_DI_FOLLOW_Condition;
	information = DIA_Angar_DI_FOLLOW_Info;
	permanent = TRUE;
	description = "Stay back now.";
};


func int DIA_Angar_DI_FOLLOW_Condition()
{
	if(Angar_DI_Party == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Angar_DI_FOLLOW_Info()
{
	B_AngarStays();
};


instance DIA_Angar_DI_FOLLOWAGAIN(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 5;
	condition = DIA_Angar_DI_FOLLOWAGAIN_Condition;
	information = DIA_Angar_DI_FOLLOWAGAIN_Info;
	permanent = TRUE;
	description = "Follow me.";
};


func int DIA_Angar_DI_FOLLOWAGAIN_Condition()
{
	if(Angar_DI_Party == LOG_OBSOLETE)
	{
		return TRUE;
	};
};

func void DIA_Angar_DI_FOLLOWAGAIN_Info()
{
	AI_Output (other, self, "DIA_Angar_DI_FOLLOWAGAIN_15_00");	//Follow me.
	AI_Output (self, other, "DIA_Angar_DI_FOLLOWAGAIN_04_01");	//You go first.
	Angar_DI_Party = LOG_Running;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"FollowDI");
};


instance DIA_Angar_DI_FOLLOWSTOP(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 5;
	condition = DIA_Angar_DI_FOLLOWSTOP_Condition;
	information = DIA_Angar_DI_FOLLOWSTOP_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Angar_DI_FOLLOWSTOP_Condition()
{
	if((Angar_DI_Party == LOG_Running) && (((Npc_GetDistToWP(self,"DI_DRACONIANAREA_FIREDRAGON") < 3000) && !Npc_IsDead(FireDragonIsland)) || (Npc_GetDistToWP(self,"SKELETTE") < 3000)))
	{
		return TRUE;
	};
};

func void DIA_Angar_DI_FOLLOWSTOP_Info()
{
	AI_Output(self,other,"DIA_Angar_DI_FOLLOWSTOP_04_00");	//Aarh! These headaches are driving me insane!
	B_AngarStays();
};


instance DIA_Angar_DI_UNDEADDRGDEAD(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 2;
	condition = DIA_Angar_DI_UNDEADDRGDEAD_Condition;
	information = DIA_Angar_DI_UNDEADDRGDEAD_Info;
	description = "You pulled through.";
};


func int DIA_Angar_DI_UNDEADDRGDEAD_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Angar_DI_UNDEADDRGDEAD_Info()
{
	AI_Output (other, self, "DIA_Angar_DI_UNDEADDRGDEAD_15_00");	//You pulled through.
	AI_Output (self, other, "DIA_Angar_DI_UNDEADDRGDEAD_04_01");	//Can we finally get out of here?
	AI_Output (other, self, "DIA_Angar_DI_UNDEADDRGDEAD_15_02");	//Yep. The enemy has been defeated.
	AI_Output (self, other, "DIA_Angar_DI_UNDEADDRGDEAD_04_03");	//Then let's not waste any more time. Go to the captain and tell him to weigh anchor.
//	if(SC_KnowsMadPsi == TRUE)
	if(Angar_KnowsMadPsi == TRUE)
	{
		AI_Output (other, self, "DIA_Angar_DI_UNDEADDRGDEAD_15_04");	//I hope there aren't any more of you renegade sect members.
		AI_Output (self, other, "DIA_Angar_DI_UNDEADDRGDEAD_04_05");	//Anything is possible. The Seekers were very thorough, though. Even I almost became enslaved by them. Who knows?
	};
	AI_Output (other, self, "DIA_Angar_DI_UNDEADDRGDEAD_15_06");	//What will you do next?
	AI_Output (self, other, "DIA_Angar_DI_UNDEADDRGDEAD_04_07");	//Maybe I'll retire to the country and become a farmer. I'm tired of fighting.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Start");
};


instance DIA_Angar_DI_PICKPOCKET(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 900;
	condition = DIA_Angar_DI_PICKPOCKET_Condition;
	information = DIA_Angar_DI_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Angar_DI_PICKPOCKET_Condition()
{
	return C_Beklauen(47,45);
};

func void DIA_Angar_DI_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Angar_DI_PICKPOCKET);
	Info_AddChoice(DIA_Angar_DI_PICKPOCKET,Dialog_Back,DIA_Angar_DI_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Angar_DI_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Angar_DI_PICKPOCKET_DoIt);
};

func void DIA_Angar_DI_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Angar_DI_PICKPOCKET);
};

func void DIA_Angar_DI_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Angar_DI_PICKPOCKET);
};


instance DIA_Angar_DI_FOUNDAMULETT(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 7;
	condition = DIA_Angar_DI_FOUNDAMULETT_Condition;
	information = DIA_Angar_DI_FOUNDAMULETT_Info;
	description = "I found your amulet.";
};


func int DIA_Angar_DI_FOUNDAMULETT_Condition()
{
	if(Npc_HasItems(other,ItAm_Mana_Angar_MIS) && Npc_KnowsInfo(other,DIA_Angar_WIEKOMMSTDUHIERHER) && (DJG_AngarGotAmulett == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Angar_DI_FOUNDAMULETT_Info()
{
	B_AngarsAmulettAbgeben();
};


instance DIA_Angar_SCTellsAngarAboutMadPsi2_DI(C_Info)
{
	npc = DJG_705_Angar_DI;
	nr = 8;
	condition = DIA_Angar_SCTellsAngarAboutMadPsi2_DI_Condition;
	information = DIA_Angar_SCTellsAngarAboutMadPsi2_DI_Info;
	description = "The Brotherhood of the Sleeper has been enslaved by evil.";
};


func int DIA_Angar_SCTellsAngarAboutMadPsi2_DI_Condition()
{
	if((SC_KnowsMadPsi == TRUE) && (Angar_KnowsMadPsi == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Angar_SCTellsAngarAboutMadPsi2_DI_Info()
{
	B_SCTellsAngarAboutMadPsi();
	B_SCTellsAngarAboutMadPsi2();
};

