
instance DIA_Neoras_Kap1_EXIT(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 999;
	condition = DIA_Neoras_Kap1_EXIT_Condition;
	information = DIA_Neoras_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Neoras_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Neoras_Kap1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Neoras_Hallo(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 2;
	condition = DIA_Neoras_Hallo_Condition;
	information = DIA_Neoras_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Neoras_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Neoras_Hallo_Info()
{
	if(Npc_GetDistToWP(self,"NW_MONASTERY_ALCHEMY_01") <= 500)
	{
		AI_Output(self,other,"DIA_Neoras_Hallo_01_00");	//What ... what's wrong? Why are you bothering me? Can't you see that I'm in the middle of an extremely complicated experiment?
	}
	else
	{
		AI_Output(self,other,"DIA_Neoras_Hallo_01_00_add");	//What ... what's wrong? Why are you bothering me?
	};
	AI_Output(other,self,"DIA_Neoras_Hallo_15_01");	//I didn't mean to disturb you.
	AI_Output(self,other,"DIA_Neoras_Hallo_01_02");	//You already have. -sigh- Well, what do you want?
};


instance DIA_Neoras_Arbeit(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 5;
	condition = DIA_Neoras_Arbeit_Condition;
	information = DIA_Neoras_Arbeit_Info;
	permanent = FALSE;
	description = "Have you got work for me?";
};


func int DIA_Neoras_Arbeit_Condition()
{
	if(MIS_KlosterArbeit == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Neoras_Arbeit_Info()
{
	AI_Output (other, self, "DIA_Neoras_Arbeit_15_00");	//Have you got work for me?
	AI_Output (self, other, "DIA_Neoras_Arbeit_01_01");	//Yes, I need plants for my experiments. We raise plants ourselves, but we're all out of fire nettles.
	AI_Output (self, other, "DIA_Neoras_Arbeit_01_02");	//Seven blossoms should do. Bring me those - oh, something else - I am missing a recipe for creating magic potions.
	AI_Output (self, other, "DIA_Neoras_Arbeit_01_03");	//If you find it, I would be very grateful.
	MIS_NeorasPflanzen = LOG_Running;
	MIS_NeorasRezept = LOG_Running;
	Log_CreateTopic(Topic_NeorasPflanzen,LOG_MISSION);
	Log_SetTopicStatus(Topic_NeorasPflanzen,LOG_Running);
	B_LogEntries(Topic_NeorasPflanzen,"I'm to take seven fire nettles to Master Neoras, the alchemist.");
	Log_CreateTopic(Topic_Neorasrezept,LOG_MISSION);
	Log_SetTopicStatus(Topic_Neorasrezept,LOG_Running);
	B_LogNextEntry(Topic_Neorasrezept,"Master Neoras is missing a recipe for brewing mana potions.");
	if(Npc_KnowsInfo(other,DIA_Opolos_beibringen))
	{
		Log_AddEntry(Topic_Neorasrezept,"That must be the recipe Opolos wants to take a look at.");
	};
};


instance DIA_Neoras_Rezept(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 6;
	condition = DIA_Neoras_Rezept_Condition;
	information = DIA_Neoras_Rezept_Info;
	permanent = TRUE;
	description = "About your recipe ...";
};


func int DIA_Neoras_Rezept_Condition()
{
	if(MIS_NeorasRezept == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Neoras_Rezept_Info()
{
	DIA_Common_AboutThatRecipe();
	if(B_GiveInvItems(other,self,ItWr_ManaRezept,1))
	{
		DIA_Common_IFoundHim();
		AI_Output (self, other, "DIA_Neoras_Rezept_01_02");	//Good. I was afraid it was lost for good.
		AI_Output (self, other, "DIA_Neoras_Rezept_01_03");	//Here, take this magic potion as a sign of my gratitude.
		MIS_NeorasRezept = LOG_SUCCESS;
		B_GivePlayerXP(XP_NeorasRezept);
		B_GiveInvItems(self,other,ItPo_Mana_02,1);
	}
	else
	{
		AI_Output (other, self, "DIA_Neoras_Rezept_15_04");	//I haven't found it yet.
		AI_Output (self, other, "DIA_Neoras_Rezept_01_05");	//Well, in that case I hope you'll still find it.
	};
};


instance DIA_Neoras_Flieder(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 7;
	condition = DIA_Neoras_Flieder_Condition;
	information = DIA_Neoras_Flieder_Info;
	permanent = TRUE;
	description = "I've got some fire nettles for you.";
};


func int DIA_Neoras_Flieder_Condition()
{
	if(MIS_NeorasPflanzen == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Neoras_Flieder_Info()
{
	AI_Output (other, self, "DIA_Neoras_Flieder_15_00");	//I've got some fire nettles for you.
	if (B_GiveInvItems (other, self, ItPl_Mana_Herb_01, 7))
	{
		AI_Output (self, other, "DIA_Neoras_Flieder_01_01");	//Excellent, I can work with that. Take this 'Fist of Wind' spell scroll for your help.
		MIS_NeorasPflanzen = LOG_SUCCESS;
		B_GivePlayerXP(XP_NeorasPflanzen);
		B_GiveInvItems(self,other,ItSc_Windfist,1);
	}
	else
	{
		AI_Output (self, other, "DIA_Neoras_Flieder_01_02");	//Oh, really? But you didn't bring enough. I need SEVEN plants.
	};
};


instance DIA_Neoras_TEACH(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 10;
	condition = DIA_Neoras_TEACH_Condition;
	information = DIA_Neoras_TEACH_Info;
	permanent = TRUE;
	description = "Can I learn from you?";
};


func int DIA_Neoras_TEACH_Condition()
{
	return TRUE;
};

func void DIA_Neoras_TEACH_Info()
{
	AI_Output (other, self, "DIA_Neoras_TEACH_15_00");	//Can I learn from you?
	if ((other.guild == GIL_KDF) || (other.guild == GIL_PAL))
	{
		AI_Output(self,other,"DIA_Neoras_TEACH_01_01");	//I shall instruct you in the secrets of alchemy.
		if(Neoras_TeachAlchemy == FALSE)
		{
			Log_CreateTopic(Topic_KlosterTeacher,LOG_NOTE);
			B_LogEntry(Topic_KlosterTeacher,"Neoras can teach me new potion recipies.");
			Neoras_TeachAlchemy = TRUE;
		};
		Info_ClearChoices(DIA_Neoras_TEACH);
		Info_AddChoice(DIA_Neoras_TEACH,Dialog_Back,DIA_Neoras_TEACH_BACK);
		if(PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE)
		{
			Info_AddChoice(DIA_Neoras_TEACH,B_BuildLearnString(NAME_HP_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_01)),DIA_Neoras_TEACH_HEALTH_01);
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Health_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_01] == TRUE))
		{
			Info_AddChoice(DIA_Neoras_TEACH,B_BuildLearnString(NAME_HP_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_02)),DIA_Neoras_TEACH_Health_02);
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Health_03] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_02] == TRUE))
		{
			Info_AddChoice(DIA_Neoras_TEACH,B_BuildLearnString(NAME_HP_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_03)),DIA_Neoras_TEACH_Health_03);
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Perm_Health] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_03] == TRUE))
		{
			Info_AddChoice(DIA_Neoras_TEACH,B_BuildLearnString(NAME_HPMax_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_Health)),DIA_Neoras_TEACH_Perm_Health);
		};
		if(PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE)
		{
			Info_AddChoice(DIA_Neoras_TEACH,B_BuildLearnString(NAME_Mana_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_01)),DIA_Neoras_TEACH_Mana_01);
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == TRUE))
		{
			Info_AddChoice(DIA_Neoras_TEACH,B_BuildLearnString(NAME_Mana_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_02)),DIA_Neoras_TEACH_Mana_02);
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == TRUE))
		{
			Info_AddChoice(DIA_Neoras_TEACH,B_BuildLearnString(NAME_Mana_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_03)),DIA_Neoras_TEACH_Mana_03);
		};
		if((PLAYER_TALENT_ALCHEMY[POTION_Perm_Mana] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == TRUE))
		{
			Info_AddChoice(DIA_Neoras_TEACH,B_BuildLearnString(NAME_ManaMax_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_Mana)),DIA_Neoras_TEACH_Perm_Mana);
		};
	}
	else if(hero.guild == GIL_NOV)
	{
		AI_Output (self, other, "DIA_Neoras_TEACH_01_02");	//I do not instruct novices. If, some day, you are accepted into the Circle of Fire -
		AI_Output (self, other, "DIA_Neoras_TEACH_01_03");	//then I can show you how to create powerful potions.
	}
	else
	{
		AI_Output (self, other, "DIA_Neoras_TEACH_01_04");	//I pass on my knowledge only to members of our church.
	};
};

func void DIA_Neoras_TEACH_BACK()
{
	Info_ClearChoices(DIA_Neoras_TEACH);
};

func void DIA_Neoras_TEACH_HEALTH_01()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_01);
};

func void DIA_Neoras_TEACH_Health_02()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_02);
};

func void DIA_Neoras_TEACH_Health_03()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_03);
};

func void DIA_Neoras_TEACH_Perm_Health()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_Health);
};

func void DIA_Neoras_TEACH_Mana_01()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_01);
};

func void DIA_Neoras_TEACH_Mana_02()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_02);
};

func void DIA_Neoras_TEACH_Mana_03()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_03);
};

func void DIA_Neoras_TEACH_Perm_Mana()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_Mana);
};

func void B_Neoras_Price()
{
	AI_Output(self,other,"DIA_Neoras_BrewPotion_01_07");	//For the brewing itself, I charge 10 gold pieces.
};

instance DIA_Neoras_BrewPotion(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 39;
	condition = DIA_Neoras_BrewPotion_Condition;
	information = DIA_Neoras_BrewPotion_Info;
	permanent = TRUE;
	description = "Could you brew me a potion?";
};


func int DIA_Neoras_BrewPotion_Condition()
{
	if(NeorasBrewsForYou == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Neoras_BrewPotion_Info()
{
	AI_Output (other, self, "DIA_Neoras_BrewPotion_15_00");	//Could you brew me a potion?
	if (hero.guild == GIL_NOV)
	{
	AI_Output (self, other, "DIA_Neoras_BrewPotion_01_01");	//For a novice, you are certainly impertinent. Go about your duties.
		AI_Output (self, other, "DIA_Neoras_BrewPotion_01_02");	//You can buy everything you need from Gorax.
		if(Gorax_Trade == FALSE)
		{
			Log_CreateTopic(Topic_KlosterTrader,LOG_NOTE);
			B_LogEntry(Topic_KlosterTrader,"Master Gorax from the monastery can supply me with anything I need.");
			Gorax_Trade = TRUE;
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Neoras_BrewPotion_01_03");	//Do you doubt my abilities? I can brew any potion.
		AI_Output (other, self, "DIA_Neoras_BrewPotion_15_04");	//Fine.
		AI_Output (self, other, "DIA_Neoras_BrewPotion_01_05");	//Not so fast, naturally you must bring me the ingredients and pay a small fee for expenses, as well as for the materials.
		AI_Output (other, self, "DIA_Neoras_BrewPotion_15_06");	//How much do you ask?
		B_Neoras_Price();
		NeorasBrewsForYou = TRUE;
	};
};


instance DIA_Neoras_BrewForMe(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 39;
	condition = DIA_Neoras_BrewForMe_Condition;
	information = DIA_Neoras_BrewForMe_Info;
	permanent = TRUE;
	description = "Brew me ...";
};


func int DIA_Neoras_BrewForMe_Condition()
{
	if(NeorasBrewsForYou == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Neoras_BrewForMe_Info()
{
	Info_ClearChoices (DIA_Neoras_BrewForMe);
	Info_AddChoice (DIA_Neoras_BrewForMe, Dialog_Back, DIA_Neoras_BrewForMe_Back);
	Info_AddChoice (DIA_Neoras_BrewForMe, "a potion of speed.", DIA_Neoras_BrewForMe_Speed);
	Info_AddChoice (DIA_Neoras_BrewForMe, "a mana extract.", DIA_Neoras_BrewForMe_Mana);
	Info_AddChoice (DIA_Neoras_BrewForMe, "an extract of healing.", DIA_Neoras_BrewForMe_Health);
};

func void DIA_Neoras_BrewForMe_Back()
{
	Info_ClearChoices(DIA_Neoras_BrewForMe);
};

var int Neoras_Ingrediences_Advice;

func void DIA_Neoras_BrewForMe_Speed()
{
	AI_Output(other,self,"DIA_Neoras_BrewForMe_Speed_15_00");	//Brew me a potion of speed.
	if(Npc_HasItems(other,ItPl_Speed_Herb_01) && Npc_HasItems(other,ItPl_Temp_Herb) && (Npc_HasItems(other,ItMi_Gold) >= 10))
	{
		AI_Output(self,other,"DIA_Neoras_BrewForMe_Speed_01_01");	//All right, do you have the ingredients and the gold?
		AI_Output(other,self,"DIA_Neoras_BrewForMe_Speed_15_02");	//Yes, here.
		Npc_RemoveInvItems(other,ItPl_Speed_Herb_01,1);
		Npc_RemoveInvItems(other,ItPl_Temp_Herb,1);
		AI_PrintScreen("Снеппер-трава отдано",-1,31,FONT_ScreenSmall,2);
		AI_PrintScreen("Луговой горец отдано",-1,28,FONT_ScreenSmall,2);
		B_GiveInvItems(other,self,ItMi_Gold,10);
		AI_Output(self,other,"DIA_Neoras_BrewForMe_Speed_01_03");	//Good, thanks. I shall give you a potion now, then you won't have to wait so long.
		B_GiveInvItems(self,other,ItPo_Speed,1);
	}
	else if(Npc_HasItems(other,ItMi_Gold) < 10)
	{
		B_Neoras_Price();
	}
	else
	{
		AI_Output(self,other,"DIA_Neoras_BrewForMe_Speed_01_04");	//You don't have the necessary ingredients. Come back when you've got them all together.
		if(Neoras_Ingrediences_Advice == FALSE)
		{
			AI_Output(other,self,"DIA_Neoras_INGREDIENCES_Speed_15_00");	//What ingredients do I need for a potion of great speed?
			AI_Output(self,other,"DIA_Hyglas_FIREBOLT_14_01");	//Read up on it - it's right there in the books.
			Neoras_Ingrediences_Advice = TRUE;
		};
	};
	Info_ClearChoices (DIA_Neoras_BrewForMe);
	Info_AddChoice (DIA_Neoras_BrewForMe, Dialog_Back, DIA_Neoras_BrewForMe_Back);
	Info_AddChoice (DIA_Neoras_BrewForMe, "Brew me a potion of great speed.", DIA_Neoras_BrewForMe_Speed);
	Info_AddChoice (DIA_Neoras_BrewForMe, "Brew me a mana extract.", DIA_Neoras_BrewForMe_Mana);
	Info_AddChoice (DIA_Neoras_BrewForMe, "Brew me an elixir of healing.", DIA_Neoras_BrewForMe_Health);
};

func void DIA_Neoras_BrewForMe_Mana()
{
	AI_Output(other,self,"DIA_Neoras_BrewForMe_Mana_15_00");	//Brew me a mana extract.
	if((Npc_HasItems(other,ItPl_Mana_Herb_02) >= 2) && Npc_HasItems(other,ItPl_Temp_Herb) && (Npc_HasItems(other,ItMi_Gold) >= 10))
	{
		AI_Output(self,other,"DIA_Neoras_BrewForMe_Mana_01_01");	//All right, do you have the ingredients and the gold?
		AI_Output(other,self,"DIA_Neoras_BrewForMe_Mana_15_02");	//Yes, here.
		Npc_RemoveInvItems(other,ItPl_Mana_Herb_02,2);
		Npc_RemoveInvItems(other,ItPl_Temp_Herb,1);
		AI_PrintScreen("2 предметов отдано (Огненная трава)",-1,31,FONT_ScreenSmall,2);
		AI_PrintScreen("Луговой горец отдано",-1,28,FONT_ScreenSmall,2);
		B_GiveInvItems(other,self,ItMi_Gold,10);
		AI_Output(self,other,"DIA_Neoras_BrewForMe_Mana_01_03");	//Good. I shall give you a potion now, then you won't have to wait so long.
		B_GiveInvItems(self,other,ItPo_Mana_02,1);
	}
	else if(Npc_HasItems(other,ItMi_Gold) < 10)
	{
		B_Neoras_Price();
	}
	else
	{
		AI_Output(self,other,"DIA_Neoras_BrewForMe_Mana_01_04");	//You don't have the necessary ingredients. Come back when you've got them all
		if(Neoras_Ingrediences_Advice == FALSE)
		{
			AI_Output(other,self,"DIA_Neoras_INGREDIENCES_Mana_15_00");	//What ingredients do I need for a mana extract?
			AI_Output(self,other,"DIA_Hyglas_FIREBOLT_14_01");	//Read up on it - it's right there in the books.
			Neoras_Ingrediences_Advice = TRUE;
		};
	};
	Info_ClearChoices (DIA_Neoras_BrewForMe);
	Info_AddChoice (DIA_Neoras_BrewForMe, Dialog_Back, DIA_Neoras_BrewForMe_Back);
	Info_AddChoice (DIA_Neoras_BrewForMe, "Brew me a potion of great speed.", DIA_Neoras_BrewForMe_Speed);
	Info_AddChoice (DIA_Neoras_BrewForMe, "Brew me a mana extract.", DIA_Neoras_BrewForMe_Mana);
	Info_AddChoice (DIA_Neoras_BrewForMe, "Brew me an elixir of healing.", DIA_Neoras_BrewForMe_Health);
};

func void DIA_Neoras_BrewForMe_Health()
{
	AI_Output(other,self,"DIA_Neoras_BrewForMe_Health_15_00");	//Brew me an elixir of healing.
	if((Npc_HasItems(other,ItPl_Health_Herb_02) >= 2) && Npc_HasItems(other,ItPl_Temp_Herb) && (Npc_HasItems(other,ItMi_Gold) >= 10))
	{
		AI_Output(self,other,"DIA_Neoras_BrewForMe_Health_01_01");	//All right, do you have the ingredients and the gold?
		AI_Output(other,self,"DIA_Neoras_BrewForMe_Health_15_02");	//Yes, here.
		Npc_RemoveInvItems(other,ItPl_Health_Herb_02,2);
		Npc_RemoveInvItems(other,ItPl_Temp_Herb,1);
		AI_PrintScreen("2 предметов отдано (Лечебное растение)",-1,31,FONT_ScreenSmall,2);
		AI_PrintScreen("Луговой горец отдано",-1,28,FONT_ScreenSmall,2);
		B_GiveInvItems(other,self,ItMi_Gold,10);
		AI_Output(self,other,"DIA_Neoras_BrewForMe_Health_01_03");	//Good. I shall give you a potion now, then you won't have to wait so long.
		B_GiveInvItems(self,other,ItPo_Health_02,1);
	}
	else if(Npc_HasItems(other,ItMi_Gold) < 10)
	{
		B_Neoras_Price();
	}
	else
	{
		AI_Output (self, other, "DIA_Neoras_BrewForMe_Health_01_04");	//You don't have the necessary ingredients. Come back when you've got them all together.
	};
	Info_ClearChoices(DIA_Neoras_BrewForMe);
	Info_AddChoice(DIA_Neoras_BrewForMe,Dialog_Back,DIA_Neoras_BrewForMe_Back);
	Info_AddChoice(DIA_Neoras_BrewForMe,"Brew me a potion of great speed.",DIA_Neoras_BrewForMe_Speed);
	Info_AddChoice(DIA_Neoras_BrewForMe,"Brew me a mana extract.",DIA_Neoras_BrewForMe_Mana);
	Info_AddChoice(DIA_Neoras_BrewForMe,"Brew me an elixir of healing.",DIA_Neoras_BrewForMe_Health);
};


instance DIA_Neoras_DRACHENEIER(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 40;
	condition = DIA_Neoras_DRACHENEIER_Condition;
	information = DIA_Neoras_DRACHENEIER_Info;
	permanent = TRUE;
	description = "You seem to have worked up a sweat.";
};


func int DIA_Neoras_DRACHENEIER_Condition()
{
	if((Kapitel >= 4) && ((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL) || (hero.guild == GIL_KDF)) && (MIS_Neoras_DragonEgg == FALSE) && (Npc_GetDistToWP(self,"NW_MONASTERY_ALCHEMY_01") <= 1000))
	{
		return TRUE;
	};
};

func void DIA_Neoras_DRACHENEIER_Info()
{
	AI_Output (other, self, "DIA_Neoras_DRACHENEIER_15_00");	//You seem to have worked up a sweat.
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_01_01");	//Yes, I'm completely exhausted. For days I have been trying to get this confounded concoction to work. I just can't do it.
	Info_ClearChoices (DIA_Neoras_DRACHENEIER);
	Info_AddChoice (DIA_Neoras_DRACHENEIER, "Not my problem.", DIA_Neoras_DRACHENEIER_no);
	Info_AddChoice (DIA_Neoras_DRACHENEIER, "What kind of a potion is that supposed to be?", DIA_Neoras_DRACHENEIER_trank);
	Info_AddChoice (DIA_Neoras_DRACHENEIER, "What's the problem?", DIA_Neoras_DRACHENEIER_ei);
};

func void DIA_Neoras_DRACHENEIER_ei()
{
	AI_Output (other, self, "DIA_Neoras_DRACHENEIER_ei_15_00");	//What's the problem?
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_ei_01_01");	//The recipe says something about a dragon egg. Of course I don't have one of those things.
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_ei_01_02");	//So I've been trying to simulate that ingredient. However, with little success thus far.
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_ei_01_03");	//If one of those things should ever roll across your path in some cave, then think of me.
	Info_AddChoice (DIA_Neoras_DRACHENEIER, "So what are you using instead of the dragon egg?", DIA_Neoras_DRACHENEIER_ei_statt);
	Info_AddChoice (DIA_Neoras_DRACHENEIER, "I'll see what I can do.", DIA_Neoras_DRACHENEIER_ei_jep);
};

func void DIA_Neoras_DRACHENEIER_ei_jep()
{
	AI_Output (other, self, "DIA_Neoras_DRACHENEIER_ei_jep_15_00");	//I'll see what I can do.
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_ei_jep_01_01");	//Hey. That was only a joke. I do not believe you will really find a dragon egg.
	AI_Output (other, self, "DIA_Neoras_DRACHENEIER_ei_jep_15_02");	//Just wait.
	Info_ClearChoices (DIA_Neoras_DRACHENEIER);
	Log_CreateTopic (TOPIC_DRACHENEIERNeoras, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_DRACHENEIERNeoras, LOG_Running);
	B_LogEntry (TOPIC_DRACHENEIERNeoras, "Neoras needs a dragon egg for his experiments. He thinks I might be able to find one in a cave somewhere.");
	MIS_Neoras_DragonEgg = LOG_Running;
};

func void DIA_Neoras_DRACHENEIER_ei_statt()
{
	AI_Output (other, self, "DIA_Neoras_DRACHENEIER_ei_statt_15_00");	//So what are you using instead of the dragon egg?
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_ei_statt_01_01");	//Believe me, you don't want to know.
};

func void DIA_Neoras_DRACHENEIER_trank()
{
	AI_Output (other, self, "DIA_Neoras_DRACHENEIER_trank_15_00");	//What kind of potion is that supposed to be?
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_trank_01_01");	//I bought the recipe from a traveling salesman. It mentions some curious, but rather interesting things.
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_trank_01_02");	//I am not sure if this potion really does anything, but my thirst for knowledge impels me to continue.
};

func void DIA_Neoras_DRACHENEIER_no()
{
	AI_Output (other, self, "DIA_Neoras_DRACHENEIER_no_15_00");	//Not my problem.
	AI_Output (self, other, "DIA_Neoras_DRACHENEIER_no_01_01");	//Then don't bother me any further.
	Info_ClearChoices (DIA_Neoras_DRACHENEIER);
};


instance DIA_Neoras_FOUNDDRAGONEGG(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 3;
	condition = DIA_Neoras_FOUNDDRAGONEGG_Condition;
	information = DIA_Neoras_FOUNDDRAGONEGG_Info;
	description = "Here, I've got a dragon egg for you.";
};


func int DIA_Neoras_FOUNDDRAGONEGG_Condition()
{
	if(Npc_HasItems(other,ItAt_DragonEgg_MIS) && (MIS_Neoras_DragonEgg == LOG_Running))
	{
		return TRUE;
	};
};


var int Neoras_DragonEggDrink_Day;

func void DIA_Neoras_FOUNDDRAGONEGG_Info()
{
	AI_Output (other, self, "DIA_Neoras_FOUNDDRAGONEGG_15_00");	//Here, I've got a dragon egg for you.
	AI_Output (self, other, "DIA_Neoras_FOUNDDRAGONEGG_01_01");	//You're trying to pull my leg.
//	B_GiveInvItems(other,self,ItAt_DragonEgg_MIS,1);
	AI_PrintScreen("Драконье яйцо отдано",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	Npc_RemoveInvItem(other,ItAt_DragonEgg_MIS);
	AI_Output (self, other, "DIA_Neoras_FOUNDDRAGONEGG_01_02");	//It's real! I hadn't thought it possible. Where did you find it?
	AI_Output (other, self, "DIA_Neoras_FOUNDDRAGONEGG_15_03");	//I'd rather keep that to myself.
	AI_Output (self, other, "DIA_Neoras_FOUNDDRAGONEGG_01_04");	//Excellent. What do you want for it?
	MIS_Neoras_DragonEgg = LOG_SUCCESS;
	B_GivePlayerXP (XP_Neoras_DragonEgg);
	Info_ClearChoices (DIA_Neoras_FOUNDDRAGONEGG);
	Info_AddChoice (DIA_Neoras_FOUNDDRAGONEGG, "Surprise me.", DIA_Neoras_FOUNDDRAGONEGG_irgendwas);
	Info_AddChoice (DIA_Neoras_FOUNDDRAGONEGG, "What about a few healing potions?", DIA_Neoras_FOUNDDRAGONEGG_heil);
	Info_AddChoice (DIA_Neoras_FOUNDDRAGONEGG, "Give me some of the potion when it's ready.", DIA_Neoras_FOUNDDRAGONEGG_trank);
};


func void B_Neoras_Later()
{
	AI_Output(self,other,"DIA_Neoras_FOUNDDRAGONEGG_trank_01_02");	//Come back later when I have finished it.
};

var int Neoras_SCWantsDragonEggDrink;

func void DIA_Neoras_FOUNDDRAGONEGG_trank()
{
	AI_Output (other, self, "DIA_Neoras_FOUNDDRAGONEGG_trank_15_00");	//Give me some of the potion when it's ready.
	AI_Output (self, other, "DIA_Neoras_FOUNDDRAGONEGG_trank_01_01");	//All right. But as I said, I have no idea what will come from it.
	B_Neoras_Later();
	Neoras_DragonEggDrink_Day = Wld_GetDay();
	Neoras_SCWantsDragonEggDrink = TRUE;
	Info_ClearChoices(DIA_Neoras_FOUNDDRAGONEGG);
};

func void DIA_Neoras_FOUNDDRAGONEGG_heil()
{
	AI_Output (other, self, "DIA_Neoras_FOUNDDRAGONEGG_heil_15_00");	//What about a few healing potions?
	AI_Output (self, other, "DIA_Neoras_FOUNDDRAGONEGG_heil_01_01");	//A good choice. Here, take them. May they be of use to you.
	CreateInvItems(self,ItPo_Health_Addon_04,5);
	B_GiveInvItems(self,other,ItPo_Health_Addon_04,5);
	Info_ClearChoices(DIA_Neoras_FOUNDDRAGONEGG);
};

func void DIA_Neoras_FOUNDDRAGONEGG_irgendwas()
{
	AI_Output (other, self, "DIA_Neoras_FOUNDDRAGONEGG_irgendwas_15_00");	//Surprise me.
	AI_Output (self, other, "DIA_Neoras_FOUNDDRAGONEGG_irgendwas_01_01");	//Mmh. Good. Then take this magic ring. It is sure to help you overcome your enemies.
	AI_Output (self, other, "DIA_Neoras_FOUNDDRAGONEGG_irgendwas_01_02");	//It will protect you from the attacks of magical beings.
	CreateInvItems (self, ItRi_Prot_Mage_02, 1);
	B_GiveInvItems (self, other, ItRi_Prot_Mage_02, 1);
	Info_ClearChoices (DIA_Neoras_FOUNDDRAGONEGG);
};


instance DIA_Neoras_DRAGONEGGDRINK(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 3;
	condition = DIA_Neoras_DRAGONEGGDRINK_Condition;
	information = DIA_Neoras_DRAGONEGGDRINK_Info;
	description = "I've come to get that ominous dragon egg potion.";
	permanent = TRUE;
};


func int DIA_Neoras_DRAGONEGGDRINK_Condition()
{
	if((Neoras_SCWantsDragonEggDrink == TRUE) && (Neoras_DragonEggDrinkGiven == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Neoras_DRAGONEGGDRINK_Info()
{
	AI_Output(other,self,"DIA_Neoras_DRAGONEGGDRINK_15_00");	//I've come to get that ominous dragon egg potion.
	if(Neoras_DragonEggDrink_Day <= (Wld_GetDay() - 2))
	{
		AI_Output (self, other, "DIA_Neoras_DRAGONEGGDRINK_01_01");	//Yes. I have just finished it. I haven't tested it and I accept no responsibility, do you hear?
		AI_Output (other, self, "DIA_Neoras_DRAGONEGGDRINK_15_02");	//Give here already.
		AI_Output (self, other, "DIA_Neoras_DRAGONEGGDRINK_01_03");	//All right. Hopefully, the stuff won't make your head explode.
		CreateInvItems(self,ItPo_DragonEggDrinkNeoras_MIS,1);
		B_GiveInvItems(self,other,ItPo_DragonEggDrinkNeoras_MIS,1);
		Neoras_DragonEggDrinkGiven = TRUE;
	}
	else
	{
		B_Neoras_Later();
		AI_StopProcessInfos(self);
	};
};


instance DIA_Neoras_USEDDRAGONEGGDRINK(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 3;
	condition = DIA_Neoras_USEDDRAGONEGGDRINK_Condition;
	information = DIA_Neoras_USEDDRAGONEGGDRINK_Info;
	description = "I tried out your dragon egg brew. Great stuff!";
};


func int DIA_Neoras_USEDDRAGONEGGDRINK_Condition()
{
	if(Neoras_SCUsedDragonEggDrink == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Neoras_USEDDRAGONEGGDRINK_Info()
{
	AI_Output (other, self, "DIA_Neoras_USEDDRAGONEGGDRINK_15_00");	//I tried out your dragon egg brew. Great stuff, that!
	AI_Output (self, other, "DIA_Neoras_USEDDRAGONEGGDRINK_01_01");	//Mmh. Very interesting. I absolutely must carry on my research.
	AI_Output (other, self, "DIA_Neoras_USEDDRAGONEGGDRINK_15_02");	//Could you make me more of it?
	AI_Output (self, other, "DIA_Neoras_USEDDRAGONEGGDRINK_01_03");	//Better if we try the whole thing again in a few weeks. Otherwise, you'll probably grow horns.
};


instance DIA_Neoras_PICKPOCKET(C_Info)
{
	npc = KDF_506_Neoras;
	nr = 900;
	condition = DIA_Neoras_PICKPOCKET_Condition;
	information = DIA_Neoras_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Neoras_PICKPOCKET_Condition()
{
	return C_Beklauen(72,140);
};

func void DIA_Neoras_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Neoras_PICKPOCKET);
	Info_AddChoice(DIA_Neoras_PICKPOCKET,Dialog_Back,DIA_Neoras_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Neoras_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Neoras_PICKPOCKET_DoIt);
};

func void DIA_Neoras_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Neoras_PICKPOCKET);
};

func void DIA_Neoras_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Neoras_PICKPOCKET);
};

