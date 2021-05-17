
instance DIA_Addon_Eremit_EXIT(C_Info)
{
	npc = NONE_ADDON_115_Eremit;
	nr = 999;
	condition = DIA_Addon_Eremit_EXIT_Condition;
	information = DIA_Addon_Eremit_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Eremit_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Eremit_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Eremit_Hello(C_Info)
{
	npc = NONE_ADDON_115_Eremit;
	nr = 1;
	condition = DIA_Addon_Eremit_Hello_Condition;
	information = DIA_Addon_Eremit_Hello_Info;
	important = TRUE;
};


func int DIA_Addon_Eremit_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Eremit_Hello_Info()
{
	AI_Output (other, self, "DIA_Addon_Eremit_Add_15_00");	//(amazed) What are you doing here?
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_00");	//What am I doing here?! What the hell are YOU doing here?
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_01");	//I came to the remotest spot on the island because I finally wanted some peace!
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_02");	//Civil war, bandit raids, hordes of orcs outside my door ...
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_03");	//That just wasn't my thing. I've retired from that madness.
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_04");	//There may be orcs here, but not very many.
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_05");	//And other PEOPLE - thank Innos - never show up here. (grumpily) Until today.
};


instance DIA_Addon_Eremit_SeekTafeln(C_Info)
{
	npc = NONE_ADDON_115_Eremit;
	nr = 2;
	condition = DIA_Addon_Eremit_SeekTafeln_Condition;
	information = DIA_Addon_Eremit_SeekTafeln_Info;
	description = "I am looking for some stone tablets...";
};


func int DIA_Addon_Eremit_SeekTafeln_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Eremit_Hello))
	{
		return TRUE;
	};
};

func void DIA_Addon_Eremit_SeekTafeln_Info()
{
	AI_Output(other,self,"DIA_Addon_Eremit_Add_15_02");	//I am searching for stone tablets. You wouldn't happen to have found any?
	if(MIS_Eremit_Klamotten != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_06");	//(carefully) Yes ... But I'm keeping them!
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_07");	//They're the only thing there is to read around here.
	};
	AI_Output(self,other,"DIA_Addon_Eremit_Add_04_08");	//I may not understand all of it yet, but I've been able to decipher some of the texts.
};


var int Eremit_Teach_Once;

instance DIA_Addon_Eremit_Teach(C_Info)
{
	npc = NONE_ADDON_115_Eremit;
	nr = 3;
	condition = DIA_Addon_Eremit_Teach_Condition;
	information = DIA_Addon_Eremit_Teach_Info;
	permanent = TRUE;
	description = "About the stone tablets ...";
};


func int DIA_Addon_Eremit_Teach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Eremit_SeekTafeln) && (Eremit_Teach_Once == FALSE) && (PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_3] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Eremit_Teach_Info()
{
	AI_Output (other, self, "DIA_Addon_Eremit_Add_15_03");	//About the stone tablets ...
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_25");	//Shall I teach you to read them?
	if (MIS_Eremit_Klamotten != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_26");	//(hastily) But you won't get mine! You'll have to find your own!
	};
	Info_ClearChoices(DIA_Addon_Eremit_Teach);
	Info_AddChoice(DIA_Addon_Eremit_Teach,Dialog_Back,DIA_Addon_Eremit_Teach_No);
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == FALSE)
	{
		Info_AddChoice(DIA_Addon_Eremit_Teach,B_BuildLearnString(NAME_ADDON_LEARNLANGUAGE_1,B_GetLearnCostTalent(other,NPC_TALENT_FOREIGNLANGUAGE,LANGUAGE_1)),DIA_Addon_Eremit_Teach_Yes);
	}
	else if((PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_2] == FALSE) && (PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE))
	{
		Info_AddChoice(DIA_Addon_Eremit_Teach,B_BuildLearnString(NAME_ADDON_LEARNLANGUAGE_2,B_GetLearnCostTalent(other,NPC_TALENT_FOREIGNLANGUAGE,LANGUAGE_2)),DIA_Addon_Eremit_Teach_Yes);
	}
	else if((PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_3] == FALSE) && (PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE) && (PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_2] == TRUE))
	{
		Info_AddChoice(DIA_Addon_Eremit_Teach,B_BuildLearnString(NAME_ADDON_LEARNLANGUAGE_3,B_GetLearnCostTalent(other,NPC_TALENT_FOREIGNLANGUAGE,LANGUAGE_3)),DIA_Addon_Eremit_Teach_Yes);
	};
};

func void B_Addon_Eremit_TeachLanguage()
{
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_27");	//Well, it's quite simple. A G is an O, a T is an H and an I is a C.
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_28");	//If you understand that, the rest is quite logical ...
	Eremit_Teach_Once = TRUE;
};

func void DIA_Addon_Eremit_Teach_No()
{
	Info_ClearChoices(DIA_Addon_Eremit_Teach);
};

func void DIA_Addon_Eremit_Teach_Yes()
{
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_3] == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_29");	//I don't think there is any more I can teach you about that.
		Eremit_Teach_Once = TRUE;
	}
	else if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_2] == TRUE)
	{
		if(B_TeachPlayerTalentForeignLanguage(self,other,LANGUAGE_3))
		{
			B_Addon_Eremit_TeachLanguage();
		};
	}
	else if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE)
	{
		if(B_TeachPlayerTalentForeignLanguage(self,other,LANGUAGE_2))
		{
			B_Addon_Eremit_TeachLanguage();
		};
	}
	else if(B_TeachPlayerTalentForeignLanguage(self,other,LANGUAGE_1))
	{
		B_Addon_Eremit_TeachLanguage();
	};
};


instance DIA_Addon_Eremit_Klamotten(C_Info)
{
	npc = NONE_ADDON_115_Eremit;
	nr = 4;
	condition = DIA_Addon_Eremit_Klamotten_Condition;
	information = DIA_Addon_Eremit_Klamotten_Info;
	permanent = TRUE;
	description = "I have some clothes for you ...";
};


func int DIA_Addon_Eremit_Klamotten_Condition()
{
	if(MIS_Eremit_Klamotten == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Eremit_Klamotten_Info()
{
	AI_Output (other, self, "DIA_Addon_Eremit_Add_15_01");	//I have some clothes for you ...
	AI_Output (self, other, "DIA_Addon_Eremit_Add_04_19");	//Really? Show me, let's see if they fit!
	Info_ClearChoices(DIA_Addon_Eremit_Klamotten);
	Info_AddChoice(DIA_Addon_Eremit_Klamotten,Dialog_Back,DIA_Addon_Eremit_Klamotten_BACK);
	if(Npc_HasItems(other,ITAR_PIR_L_Addon))
	{
		Info_AddChoice (DIA_Addon_Eremit_Klamotten, "(Give Light Pirate Armor)", DIA_Addon_Eremit_Klamotten_PIR_L);
	};
	if(Npc_HasItems(other,ITAR_PIR_M_Addon))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Pirate Armor)",DIA_Addon_Eremit_Klamotten_PIR_M);
	};
	if(Npc_HasItems(other,ITAR_RANGER_Addon))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give 'Ring of Water' Armor)",DIA_Addon_Eremit_Klamotten_Ranger);
	};
	if(Npc_HasItems(other,ITAR_Vlk_L))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Simple Citizen's Clothes)",DIA_Addon_Eremit_Klamotten_VLK_L);
	};
	if(Npc_HasItems(other,ITAR_Vlk_M))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Decent Citizen's Clothes)",DIA_Addon_Eremit_Klamotten_VLK_M);
	};
	if(Npc_HasItems(other,ITAR_Vlk_H))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Fine Citizen's Clothes)",DIA_Addon_Eremit_Klamotten_VLK_H);
	};
	if(Npc_HasItems(other,ITAR_Bau_L))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Farmer's Clothes)",DIA_Addon_Eremit_Klamotten_BAU_L);
	};
	if(Npc_HasItems(other,ITAR_DJG_Crawler))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Minecrawler Plate Armor)",DIA_Addon_Eremit_Klamotten_DJG_Crawler);
	};
	if(Npc_HasItems(other,ITAR_Leather_L))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Leather Armor)",DIA_Addon_Eremit_Klamotten_Leather);
	};
	if(Npc_HasItems(other,ITAR_BDT_M) && (Npc_HasItems(other,ITAR_BDT_H) || Npc_HasItems(other,ITAR_Thorus_Addon)))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Medium Bandit Armor)",DIA_Addon_Eremit_Klamotten_BDT_M);
	};
	if(Npc_HasItems(other,ITAR_BDT_H) && (Npc_HasItems(other,ITAR_BDT_M) || Npc_HasItems(other,ITAR_Thorus_Addon)))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Heavy Bandit Armor)",DIA_Addon_Eremit_Klamotten_BDT_H);
	};
	if(Npc_HasItems(other,ITAR_Thorus_Addon) && (Npc_HasItems(other,ITAR_BDT_M) || Npc_HasItems(other,ITAR_BDT_H)))
	{
		Info_AddChoice(DIA_Addon_Eremit_Klamotten,"(Give Raven's Guard Armor)",DIA_Addon_Eremit_Klamotten_Thorus_Addon);
	};
};

func void B_Eremit_Tatsache()
{
	AI_EquipBestArmor(self);
	AI_Output(self,other,"DIA_Addon_Eremit_Add_04_20");	//They do!
	AI_Output(self,other,"DIA_Addon_Eremit_Add_04_21");	//Well, what do I do now? I gave all my gold to the pirates for the crossing.
	AI_Output(self,other,"DIA_Addon_Eremit_Add_04_22");	//All I can give you is a couple of old stone tablets.
	AI_Output(self,other,"DIA_Addon_Eremit_Add_04_23");	//Here, take them, by all means. I'll look for some new ones.
	AI_WaitTillEnd(other,self);
	CreateInvItem(other,ItWr_DexStonePlate3_Addon);
	CreateInvItem(other,ItWr_StonePlateCommon_Addon);
	AI_PrintScreen("Received: 2 Stone Tablets",-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
	MIS_Eremit_Klamotten = LOG_SUCCESS;
	B_GivePlayerXP(200);
	Info_ClearChoices(DIA_Addon_Eremit_Klamotten);
};

func void DIA_Addon_Eremit_Klamotten_BACK()
{
	DIA_Common_IWillGiveYouSomethingLater();
	AI_Output(self,other,"DIA_Addon_Eremit_Add_04_24");	//Oh, great. First you get me all stirred up and then ... (sighs)
	Info_ClearChoices(DIA_Addon_Eremit_Klamotten);
};

 func void DIA_Addon_Eremit_Klamotten_PIR_L()
{
	B_GiveInvItems(other,self,ITAR_PIR_L_Addon,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_PIR_M()
{
	B_GiveInvItems(other,self,ITAR_PIR_M_Addon,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_Ranger()
{
	B_GiveInvItems(other,self,ITAR_RANGER_Addon,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_VLK_L()
{
	B_GiveInvItems(other,self,ITAR_Vlk_L,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_VLK_M()
{
	B_GiveInvItems(other,self,ITAR_Vlk_M,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_VLK_H()
{
	B_GiveInvItems(other,self,ITAR_Vlk_H,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_BAU_L()
{
	B_GiveInvItems(other,self,ITAR_Bau_L,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_DJG_Crawler()
{
	B_GiveInvItems(other,self,ITAR_DJG_Crawler,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_Leather()
{
	B_GiveInvItems(other,self,ITAR_Leather_L,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_BDT_M()
{
	B_GiveInvItems(other,self,ITAR_BDT_M,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_BDT_H()
{
	B_GiveInvItems(other,self,ITAR_BDT_H,1);
	B_Eremit_Tatsache();
};

func void DIA_Addon_Eremit_Klamotten_Thorus_Addon()
{
	B_GiveInvItems(other,self,ITAR_Thorus_Addon,1);
	B_Eremit_Tatsache();
};

instance DIA_Addon_Eremit_PERM(C_Info)
{
	npc = NONE_ADDON_115_Eremit;
	nr = 99;
	condition = DIA_Addon_Eremit_PERM_Condition;
	information = DIA_Addon_Eremit_PERM_Info;
	permanent = TRUE;
	description = "And? How's life as a drop-out?";
};


func int DIA_Addon_Eremit_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Eremit_Hello))
	{
		return TRUE;
	};
};

func void DIA_Addon_Eremit_PERM_Info()
{
	AI_Output (other, self, "DIA_Addon_Eremit_Add_15_04");	//And? How's life as a drop-out?
	if (MIS_Eremit_Klamotten == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_09");	//(proudly) I built everything myself. My weapons, my tools, my hut, everything.
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_10");	//Came here with nothing but a good mood ...
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_11");	//Sometimes, though ...
		AI_Output (other, self, "DIA_Addon_Eremit_Doppelt_15_01");	//Yes?
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_12");	//Sometimes, I wish I had at least taken a few clothes with me.
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_13");	//I don't know how to weave or tan hides ...
		AI_Output (self, other, "DIA_Addon_Eremit_Add_04_14");	//And the nights aren't exactly warm in this part of the island.
		MIS_Eremit_Klamotten = LOG_Running;
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Eremit_Add_04_15");	//I manage.
		AI_Output(self,other,"DIA_Addon_Eremit_Add_04_16");	//Better than Khorinis, anyway!
		if(MIS_Eremit_Klamotten != LOG_SUCCESS)
		{
			AI_Output(self,other,"DIA_Addon_Eremit_Add_04_17");	//Even without clothes.
			AI_Output(self,other,"DIA_Addon_Eremit_Add_04_18");	//Но зиму пережить без одежды мне будет довольно сложно...@@@
		};
	};
};

