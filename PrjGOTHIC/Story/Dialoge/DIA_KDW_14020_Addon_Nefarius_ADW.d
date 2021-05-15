
instance DIA_Addon_Nefarius_ADW_EXIT(C_Info)
{
	npc = KDW_14020_Addon_Nefarius_ADW;
	nr = 999;
	condition = DIA_Addon_Nefarius_ADW_EXIT_Condition;
	information = DIA_Addon_Nefarius_ADW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Nefarius_ADW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Nefarius_ADW_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Nefarius_ADWHello(C_Info)
{
	npc = KDW_14020_Addon_Nefarius_ADW;
	nr = 5;
	condition = DIA_Addon_Nefarius_ADWHello_Condition;
	information = DIA_Addon_Nefarius_ADWHello_Info;
	important = TRUE;
};


func int DIA_Addon_Nefarius_ADWHello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Addon_Nefarius_ADWHello_Info()
{
	AI_Output (self, other, "DIA_Addon_Nefarius_ADWHello_05_00");	//I'm tremendously relieved to see that you have arrived here unscathed.
	AI_Output (other, self, "DIA_Addon_Nefarius_ADWHello_15_01");	//How is it that you arrived here before me?
	AI_Output (self, other, "DIA_Addon_Nefarius_ADWHello_05_02");	//We traveled through a curious dimension. Who knows what detours you took.
	AI_Output (other, self, "DIA_Addon_Nefarius_ADWHello_15_03");	//And now? Can I use the portal again?
	AI_Output (self, other, "DIA_Addon_Nefarius_ADWHello_05_04");	//We came here directly. It obviously works quite well.
	AI_Output (self, other, "DIA_Addon_Nefarius_ADWHello_05_05");	//Of course, I'll let you know if I have the suspicion that it could be otherwise.
};


instance DIA_Addon_Nefarius_Neues(C_Info)
{
	npc = KDW_14020_Addon_Nefarius_ADW;
	nr = 5;
	condition = DIA_Addon_Nefarius_Neues_Condition;
	information = DIA_Addon_Nefarius_Neues_Info;
	description = "What have you done here up to now?";
};


func int DIA_Addon_Nefarius_Neues_Condition()
{
	return TRUE;
};

func void DIA_Addon_Nefarius_Neues_Info()
{
	DIA_Common_WhatAreYouGuysDoingHere();
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_05_01");	//I am studying the history of the builders and am trying to understand why they closed the portal.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_05_02");	//It looks very much as though they wanted to hide the sunken city from the rest of the world.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_05_03");	//Terrible things happened here many years ago. They were seized by something awful.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_05_04");	//There was a dreadful civil war shortly before the downfall of the city, if their records can be believed.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_05_05");	//The streets were in flames, and a flood which devoured everything ultimately sealed the fate of the builders.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_05_06");	//The few who survived the inferno closed this part of the island in the hope of locking up the chaos.
	Info_ClearChoices (DIA_Addon_Nefarius_Neues);
	Info_AddChoice (DIA_Addon_Nefarius_Neues, "What do you think we will find here?", DIA_Addon_Nefarius_Neues_find);
	Info_AddChoice (DIA_Addon_Nefarius_Neues, "And we fools have reopened the portal.", DIA_Addon_Nefarius_Neues_auf);
	Info_AddChoice (DIA_Addon_Nefarius_Neues, "What made the builders so agitated?", DIA_Addon_Nefarius_Neues_was);
	Info_AddChoice (DIA_Addon_Nefarius_Neues, "Did you say that there was a flood?", DIA_Addon_Nefarius_Neues_flut);
};

func void DIA_Addon_Nefarius_Neues_find()
{
	AI_Output (other, self, "DIA_Addon_Nefarius_Neues_find_15_00");	//What do you think we will find here?
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_find_05_01");	//I can only speculate about that. You should talk to Saturas.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_find_05_02");	//He has a certain idea.
	Log_CreateTopic (TOPIC_Addon_Flut, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Flut, LOG_Running);
	B_LogEntry (TOPIC_Addon_Flut, "Nefarius says I should talk to Saturas about the drowned city.");
	NefariusADW_Talk2Saturas = TRUE;
};

func void DIA_Addon_Nefarius_Neues_flut()
{
	AI_Output (other, self, "DIA_Addon_Nefarius_Neues_flut_15_00");	//Did you say that there was a flood?
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_flut_05_01");	//Adanos himself appeared to them to end the madness.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_flut_05_02");	//He razed the city to the ground.
};

func void DIA_Addon_Nefarius_Neues_was()
{
	AI_Output (other, self, "DIA_Addon_Nefarius_Neues_was_15_00");	//What made the builders so agitated?
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_was_05_01");	//One of their own devoted himself to Evil. He was a great commander named Quahodron.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_was_05_02");	//Returning from a successful battle outside the protecting walls of the city, he brought the Evil with him.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_was_05_03");	//All of his followers fell to the madness a short time later and began to battle with the common folk.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_was_05_04");	//The civil war that followed reduced everything to rubble.
};

func void DIA_Addon_Nefarius_Neues_auf()
{
	AI_Output (other, self, "DIA_Addon_Nefarius_Neues_auf_15_00");	//And we fools have reopened the portal.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_auf_05_01");	//I'm not happy about that either, believe you me.
	AI_Output (self, other, "DIA_Addon_Nefarius_Neues_auf_05_02");	//But what choice did we have?
	if(RavenIsDead == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Nefarius_Neues_auf_05_03");	//If we cannot stop what is happening here, then Khorinis will suffer exactly the same fate that once befell the builders of this ancient city.
	};
};


instance DIA_Addon_Nefarius_PermADW(C_Info)
{
	npc = KDW_14020_Addon_Nefarius_ADW;
	nr = 10;
	condition = DIA_Addon_Nefarius_PermADW_Condition;
	information = DIA_Addon_Nefarius_PermADW_Info;
	permanent = TRUE;
	description = "The trip through the portal is safe?";
};


func int DIA_Addon_Nefarius_PermADW_Condition()
{
	return TRUE;
};

func void DIA_Addon_Nefarius_PermADW_Info()
{
	AI_Output (other, self, "DIA_Addon_Nefarius_PermADW_15_00");	//The trip through the portal is safe?
	AI_Output (self, other, "DIA_Addon_Nefarius_PermADW_05_01");	//I haven't had any reservations so far.
};


instance DIA_Addon_Nefarius_PreTeach(C_Info)
{
	npc = KDW_14020_Addon_Nefarius_ADW;
	nr = 99;
	condition = DIA_Addon_Nefarius_PreTeach_Condition;
	information = DIA_Addon_Nefarius_PreTeach_Info;
	permanent = TRUE;
	description = "Could you impart your knowledge of magic to me?";
};


func int DIA_Addon_Nefarius_PreTeach_Condition()
{
	if((hero.guild == GIL_KDF) && (Nefarius_Addon_TeachRunes == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Nefarius_PreTeach_Info()
{
	AI_Output(other,self,"DIA_Addon_Nefarius_PreTeach_15_00");	//Could you impart your knowledge of magic to me?
	if(Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) >= 1)
	{
		AI_Output (self, other, "DIA_Addon_Nefarius_PreTeach_05_01");	//I can instruct you in the creation of runes, and Cronos can sell you the formulas for them.
		AI_Output (self, other, "DIA_Addon_Nefarius_PreTeach_05_02");	//He always has his rune books with him.
		Nefarius_Addon_TeachRunes = TRUE;
		Log_CreateTopic(TOPIC_Addon_KDWTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_Addon_KDWTeacher,LogText_Addon_NefariusTeach);
	}
	else
	{
		B_Say(self,other,"$NOLEARNNOPOINTS");
		PrintScreen(PRINT_MAGCIRCLES_NEEDFIRST,-1,-1,FONT_ScreenSmall,2);
	};
};


instance DIA_Addon_Nefarius_ADW_Runen(C_Info)
{
	npc = KDW_14020_Addon_Nefarius_ADW;
	nr = 99;
	condition = DIA_Addon_Nefarius_ADW_Runen_Condition;
	information = DIA_Addon_Nefarius_ADW_Runen_Info;
	permanent = TRUE;
	description = "Instruct me (create runes)";
};


func int DIA_Addon_Nefarius_ADW_Runen_Condition()
{
	if(Nefarius_Addon_TeachRunes == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Nefarius_ADW_Runen_Info()
{
	DIA_Common_WantToLearnNewRunes();
	Info_ClearChoices(DIA_Addon_Nefarius_ADW_Runen);
	Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,Dialog_Back,DIA_Addon_Nefarius_ADW_Runen_BACK);
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 6)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,NAME_Circle_6,DIA_Addon_Nefarius_ADW_Runen_6);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 5)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,NAME_Circle_5,DIA_Addon_Nefarius_ADW_Runen_5);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 4)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,NAME_Circle_4,DIA_Addon_Nefarius_ADW_Runen_4);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 3)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,NAME_Circle_3,DIA_Addon_Nefarius_ADW_Runen_3);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 2)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,NAME_Circle_2,DIA_Addon_Nefarius_ADW_Runen_2);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) >= 1)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,NAME_Circle_1,DIA_Addon_Nefarius_ADW_Runen_1);
	};
};

func void DIA_Addon_Nefarius_ADW_Runen_BACK()
{
	Info_ClearChoices(DIA_Addon_Nefarius_ADW_Runen);
};

func void DIA_Addon_Nefarius_ADW_Runen_1()
{
	Info_ClearChoices(DIA_Addon_Nefarius_ADW_Runen);
	Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,Dialog_Back,DIA_Addon_Nefarius_ADW_Runen_BACK);
	if(PLAYER_TALENT_RUNES[SPL_SummonGoblinSkeleton] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_SummonGoblinSkeleton,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_SummonGoblinSkeleton)),DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_SummonGoblinSkeleton);
	};
	if(PLAYER_TALENT_RUNES[SPL_LightHeal] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_LightHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_LightHeal)),DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_LightHeal);
	};
	if(PLAYER_TALENT_RUNES[SPL_Zap] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Zap,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Zap)),DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_Zap);
	};
	if(PLAYER_TALENT_RUNES[SPL_Firebolt] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Firebolt,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Firebolt)),DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_Firebolt);
	};
	if(PLAYER_TALENT_RUNES[SPL_Light] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_LIGHT,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Light)),DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_LIGHT);
	};
};

func void DIA_Addon_Nefarius_ADW_Runen_2()
{
	Info_ClearChoices(DIA_Addon_Nefarius_ADW_Runen);
	Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,Dialog_Back,DIA_Addon_Nefarius_ADW_Runen_BACK);
	if(PLAYER_TALENT_RUNES[SPL_InstantFireball] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_InstantFireball,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_InstantFireball)),DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_InstantFireball);
	};
	if(PLAYER_TALENT_RUNES[SPL_Icebolt] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Icebolt,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Icebolt)),DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_Icebolt);
	};
	if(PLAYER_TALENT_RUNES[SPL_SummonWolf] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_SummonWolf,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_SummonWolf)),DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_SummonWolf);
	};
	if(PLAYER_TALENT_RUNES[SPL_WindFist] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_WINDFIST,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_WindFist)),DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_WINDFIST);
	};
	if(PLAYER_TALENT_RUNES[SPL_Sleep] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Sleep,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Sleep)),DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_Sleep);
	};
	if(PLAYER_TALENT_RUNES[SPL_Whirlwind] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Whirlwind,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Whirlwind)),DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_Whirlwind);
	};
	if(PLAYER_TALENT_RUNES[SPL_IceLance] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_IceLance,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_IceLance)),DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_ICELANCE);
	};
};

func void DIA_Addon_Nefarius_ADW_Runen_3()
{
	Info_ClearChoices(DIA_Addon_Nefarius_ADW_Runen);
	Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,Dialog_Back,DIA_Addon_Nefarius_ADW_Runen_BACK);
	if(PLAYER_TALENT_RUNES[SPL_MediumHeal] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_MediumHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_MediumHeal)),DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_MediumHeal);
	};
	if(PLAYER_TALENT_RUNES[SPL_ChargeZap] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_ChargeZap,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_ChargeZap)),DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_ThunderBall);
	};
	if(PLAYER_TALENT_RUNES[SPL_Firestorm] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Firestorm,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Firestorm)),DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_Firestorm);
	};
	if(PLAYER_TALENT_RUNES[SPL_SummonSkeleton] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_SummonSkeleton,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_SummonSkeleton)),DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_SummonSkeleton);
	};
	if(PLAYER_TALENT_RUNES[SPL_Fear] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Fear,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Fear)),DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_Fear);
	};
	if(PLAYER_TALENT_RUNES[SPL_IceCube] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_IceCube,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_IceCube)),DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_IceCube);
	};
	if(PLAYER_TALENT_RUNES[SPL_Thunderstorm] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Thunderstorm,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Thunderstorm)),DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_Thunderstorm);
	};
	if(PLAYER_TALENT_RUNES[SPL_Geyser] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Geyser,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Geyser)),DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_Geyser);
	};
};

func void DIA_Addon_Nefarius_ADW_Runen_4()
{
	Info_ClearChoices(DIA_Addon_Nefarius_ADW_Runen);
	Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,Dialog_Back,DIA_Addon_Nefarius_ADW_Runen_BACK);
	if(PLAYER_TALENT_RUNES[SPL_SummonGolem] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_SummonGolem,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_SummonGolem)),DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_SummonGolem);
	};
	if(PLAYER_TALENT_RUNES[SPL_DestroyUndead] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_DestroyUndead,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_DestroyUndead)),DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_DestroyUndead);
	};
	if(PLAYER_TALENT_RUNES[SPL_LightningFlash] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_LightningFlash,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_LightningFlash)),DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_LightningFlash);
	};
	if(PLAYER_TALENT_RUNES[SPL_ChargeFireball] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_ChargeFireball,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_ChargeFireball)),DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_ChargeFireball);
	};
	if(PLAYER_TALENT_RUNES[SPL_WaterFist] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_WaterFist,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_WaterFist)),DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_Waterfist);
	};
};

func void DIA_Addon_Nefarius_ADW_Runen_5()
{
	Info_ClearChoices(DIA_Addon_Nefarius_ADW_Runen);
	Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,Dialog_Back,DIA_Addon_Nefarius_ADW_Runen_BACK);
	if(PLAYER_TALENT_RUNES[SPL_IceWave] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_IceWave,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_IceWave)),DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_IceWave);
	};
	if(PLAYER_TALENT_RUNES[SPL_SummonDemon] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_SummonDemon,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_SummonDemon)),DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_SummonDemon);
	};
	if(PLAYER_TALENT_RUNES[SPL_FullHeal] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_FullHeal,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_FullHeal)),DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_FullHeal);
	};
	if(PLAYER_TALENT_RUNES[SPL_Pyrokinesis] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Pyrokinesis,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Pyrokinesis)),DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_Pyrokinesis);
	};
	if(PLAYER_TALENT_RUNES[SPL_Shrink] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Shrink,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Shrink)),DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_Shrink);
	};
};

func void DIA_Addon_Nefarius_ADW_Runen_6()
{
	Info_ClearChoices(DIA_Addon_Nefarius_ADW_Runen);
	Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,Dialog_Back,DIA_Addon_Nefarius_ADW_Runen_BACK);
	if(PLAYER_TALENT_RUNES[SPL_Firerain] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Firerain,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Firerain)),DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_Firerain);
	};
	if(PLAYER_TALENT_RUNES[SPL_BreathOfDeath] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_BreathOfDeath,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_BreathOfDeath)),DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_BreathOfDeath);
	};
	if(PLAYER_TALENT_RUNES[SPL_MassDeath] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_MassDeath,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_MassDeath)),DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_MassDeath);
	};
	if(PLAYER_TALENT_RUNES[SPL_ArmyOfDarkness] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_ArmyOfDarkness,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_ArmyOfDarkness)),DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_ArmyOfDarkness);
	};
	/*if(PLAYER_TALENT_RUNES[SPL_Shrink] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Nefarius_ADW_Runen,B_BuildLearnString(NAME_SPL_Shrink,B_GetLearnCostTalent(other,NPC_TALENT_RUNES,SPL_Shrink)),DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_Shrink);
	};*/
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_LIGHT()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Light);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_Firebolt()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Firebolt);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_Zap()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Zap);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_LightHeal()
{
	B_TeachPlayerTalentRunes(self,other,SPL_LightHeal);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_1_SPL_SummonGoblinSkeleton()
{
	B_TeachPlayerTalentRunes(self,other,SPL_SummonGoblinSkeleton);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_Whirlwind()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Whirlwind);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_ICELANCE()
{
	B_TeachPlayerTalentRunes(self,other,SPL_IceLance);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_InstantFireball()
{
	B_TeachPlayerTalentRunes(self,other,SPL_InstantFireball);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_Icebolt()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Icebolt);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_SummonWolf()
{
	B_TeachPlayerTalentRunes(self,other,SPL_SummonWolf);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_WINDFIST()
{
	B_TeachPlayerTalentRunes(self,other,SPL_WindFist);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_2_SPL_Sleep()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Sleep);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_Thunderstorm()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Thunderstorm);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_Geyser()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Geyser);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_MediumHeal()
{
	B_TeachPlayerTalentRunes(self,other,SPL_MediumHeal);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_SummonSkeleton()
{
	B_TeachPlayerTalentRunes(self,other,SPL_SummonSkeleton);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_Fear()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Fear);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_IceCube()
{
	B_TeachPlayerTalentRunes(self,other,SPL_IceCube);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_ThunderBall()
{
	B_TeachPlayerTalentRunes(self,other,SPL_ChargeZap);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_3_SPL_Firestorm()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Firestorm);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_LightningFlash()
{
	B_TeachPlayerTalentRunes(self,other,SPL_LightningFlash);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_ChargeFireball()
{
	B_TeachPlayerTalentRunes(self,other,SPL_ChargeFireball);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_Waterfist()
{
	B_TeachPlayerTalentRunes(self,other,SPL_WaterFist);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_SummonGolem()
{
	B_TeachPlayerTalentRunes(self,other,SPL_SummonGolem);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_4_SPL_DestroyUndead()
{
	B_TeachPlayerTalentRunes(self,other,SPL_DestroyUndead);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_Pyrokinesis()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Pyrokinesis);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_IceWave()
{
	B_TeachPlayerTalentRunes(self,other,SPL_IceWave);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_SummonDemon()
{
	B_TeachPlayerTalentRunes(self,other,SPL_SummonDemon);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_FullHeal()
{
	B_TeachPlayerTalentRunes(self,other,SPL_FullHeal);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_Firerain()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Firerain);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_BreathOfDeath()
{
	B_TeachPlayerTalentRunes(self,other,SPL_BreathOfDeath);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_MassDeath()
{
	B_TeachPlayerTalentRunes(self,other,SPL_MassDeath);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_6_SPL_ArmyOfDarkness()
{
	B_TeachPlayerTalentRunes(self,other,SPL_ArmyOfDarkness);
};

func void DIA_Addon_Nefarius_ADW_Runen_Circle_5_SPL_Shrink()
{
	B_TeachPlayerTalentRunes(self,other,SPL_Shrink);
};

