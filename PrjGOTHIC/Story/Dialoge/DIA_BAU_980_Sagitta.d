
instance DIA_Sagitta_EXIT(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 999;
	condition = DIA_Sagitta_EXIT_Condition;
	information = DIA_Sagitta_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Sagitta_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Sagitta_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Sagitta_HALLO(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 1;
	condition = DIA_Sagitta_HALLO_Condition;
	information = DIA_Sagitta_HALLO_Info;
	description = "All by yourself out here?";
};


func int DIA_Sagitta_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Sagitta_HALLO_Info()
{
	AI_Output(other,self,"DIA_Sagitta_HALLO_15_00");	//All by yourself out here?
	AI_Output(self,other,"DIA_Sagitta_HALLO_17_01");	//Tell me what you want of me, and then go away. I'm busy.
//	Info_ClearChoices(DIA_Sagitta_HALLO);
//	Info_AddChoice(DIA_Sagitta_HALLO,Dialog_Back,DIA_Sagitta_HALLO_ende);
//	Info_AddChoice(DIA_Sagitta_HALLO,"Can you heal me?",DIA_Sagitta_HALLO_Heil);
//	Info_AddChoice(DIA_Sagitta_HALLO,"What are you doing out here?",DIA_Sagitta_HALLO_was);
//	Info_AddChoice(DIA_Sagitta_HALLO,"Who are you?",DIA_Sagitta_HALLO_wer);
};

/*func void DIA_Sagitta_HALLO_wer()
{
	AI_Output (other, self, "DIA_Sagitta_HALLO_wer_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Sagitta_HALLO_wer_17_01");	//You haven't heard of me, then?
	AI_Output (self, other, "DIA_Sagitta_HALLO_wer_17_02");	//Herb witch, they say. Quack, they call me.
	AI_Output (self, other, "DIA_Sagitta_HALLO_wer_17_03");	//But when they're in a bad way, they all suddenly remember good old Sagitta and her healing herbs.
};

func void DIA_Sagitta_HALLO_was()
{
	AI_Output (other, self, "DIA_Sagitta_HALLO_was_15_00");	//What are you doing out here?
	AI_Output (self, other, "DIA_Sagitta_HALLO_was_17_01");	//I've been living here for as long as I can think, attending to my herbs.
	AI_Output (self, other, "DIA_Sagitta_HALLO_was_17_02");	//The forest is my friend. It offers me all that I need.
};

func void DIA_Sagitta_HALLO_Heil()
{
	AI_Output(other,self,"DIA_Sagitta_HALLO_Heil_15_00");	//Can you heal me?
	AI_Output(self,other,"DIA_Sagitta_HALLO_Heil_17_01");	//That's what you came for, isn't it? Just let me know when there's something wrong with you.
};

func void DIA_Sagitta_HALLO_ende()
{
	Info_ClearChoices(DIA_Sagitta_HALLO);
};
*/
instance DIA_Sagitta_Pre_Who(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 1;
	condition = DIA_Sagitta_Pre_Who_Condition;
	information = DIA_Sagitta_Pre_Who_Info;
	description = "Who are you?";
};


func int DIA_Sagitta_Pre_Who_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Sagitta_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_Pre_Who_Info()
{
	AI_Output (other, self, "DIA_Sagitta_HALLO_wer_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Sagitta_HALLO_wer_17_01");	//You haven't heard of me, then?
	AI_Output (self, other, "DIA_Sagitta_HALLO_wer_17_02");	//Herb witch, they say. Quack, they call me.
	AI_Output (self, other, "DIA_Sagitta_HALLO_wer_17_03");	//But when they're in a bad way, they all suddenly remember good old Sagitta and her healing herbs.
};


instance DIA_Sagitta_Pre_Trade(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 1;
	condition = DIA_Sagitta_Pre_Trade_Condition;
	information = DIA_Sagitta_Pre_Trade_Info;
	description = "What are you doing out here?";
};


func int DIA_Sagitta_Pre_Trade_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Sagitta_HALLO))
	if(Npc_KnowsInfo(other,DIA_Sagitta_Pre_Who))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_Pre_Trade_Info()
{
	AI_Output (other, self, "DIA_Sagitta_HALLO_was_15_00");	//What are you doing out here?
	AI_Output (self, other, "DIA_Sagitta_HALLO_was_17_01");	//I've been living here for as long as I can think, attending to my herbs.
	AI_Output (self, other, "DIA_Sagitta_HALLO_was_17_02");	//The forest is my friend. It offers me all that I need.
	Log_CreateTopic(TOPIC_OutTrader,LOG_NOTE);
	B_LogEntry(TOPIC_OutTrader,"Sagitta sells goods behind Sekob's farm.");
};


instance DIA_Sagitta_Pre_Heal(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 99;
	condition = DIA_Sagitta_Pre_Heal_Condition;
	information = DIA_Sagitta_Pre_Heal_Info;
	description = "Can you heal me?";
};


func int DIA_Sagitta_Pre_Heal_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Sagitta_HALLO))
	if(Npc_KnowsInfo(other,DIA_Sagitta_Pre_Trade))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_Pre_Heal_Info()
{
	AI_Output (other, self, "DIA_Sagitta_HALLO_Heil_15_00");	//Can you heal me?
	AI_Output (self, other, "DIA_Sagitta_HALLO_Heil_17_01");	//That's what you came for, isn't it? Just let me know when there's something wrong with you.
};


instance DIA_Sagitta_TeachAlchemyRequest(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 6;
	condition = DIA_Sagitta_TeachAlchemyRequest_Condition;
	information = DIA_Sagitta_TeachAlchemyRequest_Info;
	permanent = TRUE;
	description = "Can you teach me your herbal lore?";
};


func int DIA_Sagitta_TeachAlchemyRequest_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Sagitta_HALLO) && (MIS_Sagitta_Herb == FALSE))
	if(Npc_KnowsInfo(other,DIA_Sagitta_Pre_Trade))
	{
		if(MIS_Sagitta_Herb == FALSE)
		{
			return TRUE;
		}
		else if((MIS_Sagitta_Herb == LOG_Running) && Npc_HasItems(self,ItPl_Sagitta_Herb_MIS) && (Sagitta_TeachAlchemy == FALSE))
		{
			return TRUE;
		};
	};
};


var int DIA_Sagitta_TeachAlchemyRequest_OneTime;
var int DIA_Sagitta_TeachAlchemyRequest_ToldAboutPlant;

func void DIA_Sagitta_TeachAlchemyRequest_Info()
{
	AI_Output(other,self,"DIA_Sagitta_TeachAlchemyRequest_15_00");	//Can you teach me your herbal lore?
	if(Npc_HasItems(self,ItPl_Sagitta_Herb_MIS))
	{
		Npc_RemoveInvItem(self,ItPl_Sagitta_Herb_MIS);
		AI_Output(self,other,"DIA_Sagitta_Sagitta_Herb_17_01_add");	//Ask me whatever you want to know about brewing potions.@@@
		Sagitta_TeachAlchemy = TRUE;
		MIS_Sagitta_Herb = LOG_SUCCESS;
		B_CheckLog();
		Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_OutTeacher,"Sagitta the healer behind Sekob's farm can instruct me in the arts of alchemy.");
	}
	else if(DIA_Sagitta_TeachAlchemyRequest_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_17_01");	//How interesting. I don't get asked that very often.
		AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_17_02");	//So you want to be my student? Then you'll first have to prove that you're request is serious.
		AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_17_03");	//At the moment, I'm working on a very rare potion made from exquisite herbs and juices.
		AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_17_04");	//If you can get me one ingredient - a very rare herb which I don't have here - I shall train you.
		DIA_Sagitta_TeachAlchemyRequest_OneTime = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_17_05");	//I already told you: yes, after you get me that rare ingredient.
	};
	if(Sagitta_TeachAlchemy == FALSE)
	{
		Info_ClearChoices(DIA_Sagitta_TeachAlchemyRequest);
		Info_AddChoice(DIA_Sagitta_TeachAlchemyRequest,"Sorry, not interested.",DIA_Sagitta_TeachAlchemyRequest_nein);
		Info_AddChoice(DIA_Sagitta_TeachAlchemyRequest,"Where can I find this ingredient?",DIA_Sagitta_TeachAlchemyRequest_was);
		if(DIA_Sagitta_TeachAlchemyRequest_ToldAboutPlant == TRUE)
		{
			Info_AddChoice(DIA_Sagitta_TeachAlchemyRequest,"What ingredient is that?",DIA_Sagitta_TeachAlchemyRequest_wo);
			Info_AddChoice(DIA_Sagitta_TeachAlchemyRequest,"Let's see if I can get hold of it somewhere.",DIA_Sagitta_TeachAlchemyRequest_wo_ja);
		};
	};
};

func void DIA_Sagitta_TeachAlchemyRequest_was()
{
		AI_Output (other, self, "DIA_Sagitta_TeachAlchemyRequest_was_15_00");	//What ingredient is that?
		AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_was_17_01");	//It's an extremely rare plant - an herb called sun aloe. You can recognize it by its intensive almond scent.
	if(DIA_Sagitta_TeachAlchemyRequest_ToldAboutPlant == FALSE)
	{
		Info_AddChoice(DIA_Sagitta_TeachAlchemyRequest,"Where can I find this ingredient?",DIA_Sagitta_TeachAlchemyRequest_wo);
	};
};

func void DIA_Sagitta_TeachAlchemyRequest_wo()
{
	AI_Output (other, self, "DIA_Sagitta_TeachAlchemyRequest_wo_15_00");	//Where can I find this ingredient?
	AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_wo_17_01");	//The herb I require only grows in places where it can get all the nutrients it needs.
	AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_wo_17_02");	//These are found in the excrements of a black troll.
	AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_wo_17_03");	//That's why it's so difficult for me to get the herb, you see?
	if(DIA_Sagitta_TeachAlchemyRequest_ToldAboutPlant == FALSE)
	{
		Info_AddChoice(DIA_Sagitta_TeachAlchemyRequest,"Let's see if I can get hold of it somewhere.",DIA_Sagitta_TeachAlchemyRequest_wo_ja);
		DIA_Sagitta_TeachAlchemyRequest_ToldAboutPlant = TRUE;
	};
};

func void DIA_Sagitta_TeachAlchemyRequest_wo_ja()
{
	AI_Output (other, self, "DIA_Sagitta_TeachAlchemyRequest_wo_ja_15_00");	//Let's see if I can get hold of it somewhere.
	AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_wo_ja_17_01");	//Well, then, good luck with your search.
	Info_ClearChoices (DIA_Sagitta_TeachAlchemyRequest);
	MIS_Sagitta_Herb = LOG_Running;
	Log_CreateTopic (TOPIC_SagittaHerb, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_SagittaHerb, LOG_Running);
	B_LogEntry (TOPIC_SagittaHerb, "Sagitta needs a weird kind of herb. It's sun aloe, and it only grows on the excrements of a black troll.");
};

func void DIA_Sagitta_TeachAlchemyRequest_nein()
{
	AI_Output (other, self, "DIA_Sagitta_TeachAlchemyRequest_nein_15_00");	//Sorry, not interested.
	AI_Output (self, other, "DIA_Sagitta_TeachAlchemyRequest_nein_17_01");	//Then stop wasting my time with your nonsense.
	Info_ClearChoices (DIA_Sagitta_TeachAlchemyRequest);
};


instance DIA_Sagitta_Sagitta_Herb(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 6;
	condition = DIA_Sagitta_Sagitta_Herb_Condition;
	information = DIA_Sagitta_Sagitta_Herb_Info;
	description = "I found the sun aloe.";
};


func int DIA_Sagitta_Sagitta_Herb_Condition()
{
	if(Npc_HasItems(other,ItPl_Sagitta_Herb_MIS) && (MIS_Sagitta_Herb == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_Sagitta_Herb_Info()
{
	AI_Output(other,self,"DIA_Sagitta_Sagitta_Herb_15_00");	//I found the sun aloe.
	B_GiveInvItems(other,self,ItPl_Sagitta_Herb_MIS,1);
	Npc_RemoveInvItem(self,ItPl_Sagitta_Herb_MIS);
	AI_Output(self,other,"DIA_Sagitta_Sagitta_Herb_17_01");	//Thank you. And now ask me whatever you want to know about brewing potions.
	Sagitta_TeachAlchemy = TRUE;
	MIS_Sagitta_Herb = LOG_SUCCESS;
	B_GivePlayerXP(XP_Sagitta_Sonnenaloe);
	Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_OutTeacher,"Sagitta the healer behind Sekob's farm can instruct me in the arts of alchemy.");
};


instance DIA_Sagitta_Teach(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 6;
	condition = DIA_Sagitta_Teach_Condition;
	information = DIA_Sagitta_Teach_Info;
	permanent = TRUE;
	description = "What potions can you teach me to brew?";
};


var int DIA_Sagitta_Teach_permanent;

func int DIA_Sagitta_Teach_Condition()
{
//	if((DIA_Sagitta_Teach_permanent == FALSE) && (Sagitta_TeachAlchemy == TRUE) && Npc_KnowsInfo(other,DIA_Sagitta_HALLO))
	if((DIA_Sagitta_Teach_permanent == FALSE) && (Sagitta_TeachAlchemy == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_Teach_Info()
{
	var int talente;
	talente = 0;
	AI_Output (other, self, "DIA_Sagitta_Teach_15_00");	//What potions can you teach me to brew?
	if ((PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Health_02] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Health_03] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Perm_Mana] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Perm_Health] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Perm_DEX] == FALSE))
	{
		Info_ClearChoices(DIA_Sagitta_Teach);
		Info_AddChoice(DIA_Sagitta_Teach,Dialog_Back,DIA_Sagitta_Teach_BACK);
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE)
	{
		Info_AddChoice(DIA_Sagitta_Teach,B_BuildLearnString(NAME_HP_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_01)),DIA_Sagitta_Teach_Health_01);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Health_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_01] == TRUE))
	{
		Info_AddChoice(DIA_Sagitta_Teach,B_BuildLearnString(NAME_HP_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_02)),DIA_Sagitta_Teach_Health_02);
		talente += 1;
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE)
	{
		Info_AddChoice(DIA_Sagitta_Teach,B_BuildLearnString(NAME_Mana_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_01)),DIA_Sagitta_Teach_Mana_01);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == TRUE))
	{
		Info_AddChoice(DIA_Sagitta_Teach,B_BuildLearnString(NAME_Mana_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_02)),DIA_Sagitta_Teach_Mana_02);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == TRUE))
	{
		Info_AddChoice(DIA_Sagitta_Teach,B_BuildLearnString(NAME_Mana_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_03)),DIA_Sagitta_Teach_Mana_03);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Perm_Mana] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == TRUE))
	{
		Info_AddChoice(DIA_Sagitta_Teach,B_BuildLearnString(NAME_ManaMax_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_Mana)),DIA_Sagitta_Teach_Perm_Mana);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Perm_DEX] == FALSE) && C_ShowAlchemySTRDEXDialog())
	{
		Info_AddChoice(DIA_Sagitta_Teach,B_BuildLearnString(NAME_DEX_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_DEX)),DIA_Sagitta_Teach_Perm_DEX);
		talente += 1;
	};
	if(talente > 0)
	{
		if(Alchemy_Explain == FALSE)
		{
			AI_Output (self, other, "DIA_Sagitta_Teach_17_01");	//Before I teach you my art of alchemy, I'm first going to tell you what all you need to brew potions.
			AI_Output (self, other, "DIA_Sagitta_Teach_17_02");	//The alchemist's bench serves as the kitchen for brewing potions. You will need an empty laboratory flask in which to store the brewed potion.
			AI_Output (self, other, "DIA_Sagitta_Teach_17_03");	//Then you add the required ingredients, and there's your potion.
			AI_Output (self, other, "DIA_Sagitta_Teach_17_04");	//You can learn this knowledge from me, of course.
			Alchemy_Explain = TRUE;
		};
		AI_Output(self,other,"DIA_Sagitta_Teach_17_05");	//So which potion shall it be?
	}
	else
	{
		AI_Output(self,other,"DIA_Sagitta_Teach_17_06");	//You already know everything I could teach you.
		DIA_Sagitta_Teach_permanent = TRUE;
	};
};

func void DIA_Sagitta_Teach_BACK()
{
	Info_ClearChoices(DIA_Sagitta_Teach);
};

func void DIA_Sagitta_Teach_Health_01()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_01);
};

func void DIA_Sagitta_Teach_Health_02()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_02);
};

func void DIA_Sagitta_Teach_Mana_01()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_01);
};

func void DIA_Sagitta_Teach_Mana_02()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_02);
};

func void DIA_Sagitta_Teach_Mana_03()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_03);
};

func void DIA_Sagitta_Teach_Perm_Mana()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_Mana);
};

func void DIA_Sagitta_Teach_Perm_DEX()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_DEX);
};


instance DIA_Sagitta_HEAL(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 99;
	condition = DIA_Sagitta_HEAL_Condition;
	information = DIA_Sagitta_HEAL_Info;
	permanent = TRUE;
	description = "Heal me.";
};


func int DIA_Sagitta_HEAL_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Sagitta_HALLO))
	if(Npc_KnowsInfo(other,DIA_Sagitta_Pre_Heal))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_HEAL_Info()
{
	AI_Output (other, self, "DIA_Sagitta_HEAL_15_00");	//Heal me.
	if (hero.attribute[ATR_HITPOINTS] < hero.attribute[ATR_HITPOINTS_MAX])
	{
		AI_Output (self, other, "DIA_Sagitta_HEAL_17_01");	//Let me see. Mmh. My ointment will take care of the worst of your wounds.
		hero.attribute[ATR_HITPOINTS] = hero.attribute[ATR_HITPOINTS_MAX];
		PrintScreen(PRINT_FullyHealed,-1,-1,FONT_Screen,2);
	}
	else
	{
		AI_Output (self, other, "DIA_Sagitta_HEAL_17_02");	//You don't need healing at the moment.
	};
};


instance DIA_Sagitta_TRADE(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 1;
	condition = DIA_Sagitta_TRADE_Condition;
	information = DIA_Sagitta_TRADE_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "What wares do you have to offer?";
};


func int DIA_Sagitta_TRADE_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Sagitta_HALLO))
	if(Npc_KnowsInfo(other,DIA_Sagitta_Pre_Trade))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_TRADE_Info()
{
	if(Sagitta_flag == TRUE)
	{
		B_ClearAlchemyInv(self);
		if(Sagitta_flasks > 0)
		{
			CreateInvItems(self,ItMi_Flask,Sagitta_flasks);
		};
		Sagitta_flag = FALSE;
	};
	AI_Output(other,self,"DIA_Sagitta_TRADE_15_00");	//What wares do you have to offer?
	B_GiveTradeInv(self);
	AI_Output(self,other,"DIA_Sagitta_TRADE_17_01");	//Tell me what you want.
	Trade_IsActive = TRUE;
};


instance DIA_Sagitta_OBSESSION(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 40;
	condition = DIA_Sagitta_OBSESSION_Condition;
	information = DIA_Sagitta_OBSESSION_Info;
	description = "I've got this feeling of trepidation. I need help.";
};


func int DIA_Sagitta_OBSESSION_Condition()
{
	if((SC_IsObsessed == TRUE) && (SC_ObsessionTimes < 1) && Npc_KnowsInfo(other,DIA_Sagitta_Pre_Heal))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_OBSESSION_Info()
{
	AI_Output (other, self, "DIA_Sagitta_OBSESSION_15_00");	//I've got this feeling of trepidation. I need help.
	AI_Output (self, other, "DIA_Sagitta_OBSESSION_17_01");	//I can see that sleep will not be enough for you to recuperate. You have been exposed to the black look of the Seekers.
	AI_Output (self, other, "DIA_Sagitta_OBSESSION_17_02");	//Go to Pyrokar, the highest magician of the monastery. My humble remedies are not enough
};


instance DIA_Sagitta_Thekla(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 30;
	condition = DIA_Sagitta_Thekla_Condition;
	information = DIA_Sagitta_Thekla_Info;
	description = "Thekla sent me to pick up a package for her.";
};


func int DIA_Sagitta_Thekla_Condition()
{
	if((MIS_Thekla_Paket == LOG_Running) && Npc_KnowsInfo(other,DIA_Sagitta_Pre_Who))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_Thekla_Info()
{
	AI_Output (other, self, "DIA_Sagitta_Thekla_15_00");	//Thekla sent me to pick up a package for her.
	AI_Output (self, other, "DIA_Sagitta_Thekla_17_01");	//Ah, yes. I had actually expected her days ago.
	AI_Output (self, other, "DIA_Sagitta_Thekla_17_02");	//Here's the package. Take good care of it!
	CreateInvItems(self,ItMi_TheklasPaket,1);
	B_GiveInvItems(self,other,ItMi_TheklasPaket,1);
	B_GivePlayerXP(150);
};


instance DIA_Sagitta_HEALRANDOLPH(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 20;
	condition = DIA_Sagitta_HEALRANDOLPH_Condition;
	information = DIA_Sagitta_HEALRANDOLPH_Info;
	permanent = TRUE;
	description = "Randolph has withdrawal symptoms.";
};


var int DIA_Sagitta_HEALRANDOLPH_GotOne;
var int DIA_Sagitta_HEALRANDOLPH_KnowsPrice;

func int DIA_Sagitta_HEALRANDOLPH_Condition()
{
	if((MIS_HealRandolph == LOG_Running) && !Npc_HasItems(other,ItPo_HealRandolph_MIS) && Npc_KnowsInfo(other,DIA_Sagitta_Pre_Who))
	{
		return TRUE;
	};
};

func void DIA_Sagitta_HEALRANDOLPH_Info()
{
	AI_Output (other, self, "DIA_Sagitta_HEALRANDOLPH_15_00");	//Randolph has withdrawal symptoms.
	if (DIA_Sagitta_HEALRANDOLPH_KnowsPrice == FALSE)
	{
		AI_Output(self,other,"DIA_Sagitta_HEALRANDOLPH_17_01");	//When is that fellow ever going to learn?
	};
	if(DIA_Sagitta_HEALRANDOLPH_GotOne == TRUE)
	{
		AI_Output (self, other, "DIA_Sagitta_HEALRANDOLPH_17_02");	//I already gave you a dose for him. Just don't mess around with it.
	}
	else
	{
		AI_Output (self, other, "DIA_Sagitta_HEALRANDOLPH_17_03");	//I'm going to give him a remedy. That will see him through the next couple of days.
	};
	AI_Output (self, other, "DIA_Sagitta_HEALRANDOLPH_17_04");	//That comes to 300 gold coins, then.
	if (DIA_Sagitta_HEALRANDOLPH_KnowsPrice == FALSE)
	{
			AI_Output (other, self, "DIA_Sagitta_HEALRANDOLPH_15_05");	//What?
			AI_Output (self, other, "DIA_Sagitta_HEALRANDOLPH_17_06");	//The only thing you get for free is death, kid.
		DIA_Sagitta_HEALRANDOLPH_KnowsPrice = TRUE;
	};
	Info_ClearChoices (DIA_Sagitta_HEALRANDOLPH);
	Info_AddChoice (DIA_Sagitta_HEALRANDOLPH, "Nah. Not for nonsense like that.", DIA_Sagitta_HEALRANDOLPH_no);
	Info_AddChoice (DIA_Sagitta_HEALRANDOLPH, "Here's your money.", DIA_Sagitta_HEALRANDOLPH_geld);
};

func void DIA_Sagitta_HEALRANDOLPH_geld()
{
	AI_Output (other, self, "DIA_Sagitta_HEALRANDOLPH_geld_15_00");	//Here's your money.
	if (B_GiveInvItems (other, self, ItMi_Gold, 300))
	{
		AI_Output (self, other, "DIA_Sagitta_HEALRANDOLPH_geld_17_01");	//Very good. You can always get the money back from him.
		CreateInvItems (self, ItPo_HealRandolph_MIS, 1);
		B_GiveInvItems (self, other, ItPo_HealRandolph_MIS, 1);
		DIA_Sagitta_HEALRANDOLPH_GotOne = TRUE;
		B_LogEntry (TOPIC_HealRandolph, "Sagitta's given me the stuff for Randolph.");
	}
	else
	{
		AI_Output (self, other, "DIA_Sagitta_HEALRANDOLPH_geld_17_02");	//We can't do business unless you've got the money.
	};
	Info_ClearChoices(DIA_Sagitta_HEALRANDOLPH);
};

func void DIA_Sagitta_HEALRANDOLPH_no()
{
	AI_Output (other, self, "DIA_Sagitta_HEALRANDOLPH_no_15_00");	//Nah. Not for nonsense like that.
	AI_Output (self, other, "DIA_Sagitta_HEALRANDOLPH_no_17_01");	//(laughs) He didn't give you any money? That's so like him!
	Info_ClearChoices(DIA_Sagitta_HEALRANDOLPH);
};


instance DIA_Sagitta_PICKPOCKET(C_Info)
{
	npc = BAU_980_Sagitta;
	nr = 900;
	condition = DIA_Sagitta_PICKPOCKET_Condition;
	information = DIA_Sagitta_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_120_Female;
};


func int DIA_Sagitta_PICKPOCKET_Condition()
{
	return C_Beklauen(103,360);
};

func void DIA_Sagitta_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Sagitta_PICKPOCKET);
	Info_AddChoice(DIA_Sagitta_PICKPOCKET,Dialog_Back,DIA_Sagitta_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Sagitta_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Sagitta_PICKPOCKET_DoIt);
};

func void DIA_Sagitta_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Sagitta_PICKPOCKET);
};

func void DIA_Sagitta_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Sagitta_PICKPOCKET);
};

