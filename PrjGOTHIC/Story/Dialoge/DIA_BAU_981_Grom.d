
instance DIA_Grom_EXIT(C_Info)
{
	npc = BAU_981_Grom;
	nr = 999;
	condition = DIA_Grom_EXIT_Condition;
	information = DIA_Grom_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Grom_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Grom_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Grom_HALLO(C_Info)
{
	npc = BAU_981_Grom;
	nr = 3;
	condition = DIA_Grom_HALLO_Condition;
	information = DIA_Grom_HALLO_Info;
	description = "Everything all right?";
};


func int DIA_Grom_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Grom_HALLO_Info()
{
	AI_Output(other,self,"DIA_Grom_HALLO_15_00");	//Everything all right?
	AI_Output(self,other,"DIA_Grom_HALLO_08_01");	//Ah, an unfamiliar wanderer. I am very busy, so what do you want?
//	Info_ClearChoices(DIA_Grom_HALLO);
//	Info_AddChoice(DIA_Grom_HALLO,"What interesting things are there to see here?",DIA_Grom_HALLO_waszusehen);
//	Info_AddChoice(DIA_Grom_HALLO,"What are you doing here?",DIA_Grom_HALLO_was);
};

/*func void DIA_Grom_HALLO_waszusehen()
{
	AI_Output (other, self, "DIA_Grom_HALLO_waszusehen_15_00");	//What interesting things are there to see here?
	AI_Output (self, other, "DIA_Grom_HALLO_waszusehen_08_01");	//Interesting is well put. If you go deeper into the woods here, you will run into some very evil fellows.
	AI_Output (self, other, "DIA_Grom_HALLO_waszusehen_08_02");	//They're about ten feet tall, hairy, and in a really bad mood. So don't go there if you're not strong enough for them.
};

func void DIA_Grom_HALLO_was()
{
	AI_Output (other, self, "DIA_Grom_HALLO_was_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Grom_HALLO_was_08_01");	//Well, the things a woodcutter and hunter usually does.
	Info_AddChoice (DIA_Grom_HALLO, Dialog_Back, DIA_Grom_HALLO_BACK);
};

func void DIA_Grom_HALLO_BACK()
{
	Info_ClearChoices(DIA_Grom_HALLO);
};
*/
instance DIA_Grom_HALLO2(C_Info)
{
	npc = BAU_981_Grom;
	nr = 4;
	condition = DIA_Grom_HALLO2_Condition;
	information = DIA_Grom_HALLO2_Info;
	description = "What are you doing here?";
};


func int DIA_Grom_HALLO2_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Grom_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Grom_HALLO2_Info()
{
	AI_Output(other,self,"DIA_Grom_HALLO_was_15_00");	//What are you doing here?
	AI_Output(self,other,"DIA_Grom_HALLO_was_08_01");	//Well, the things a woodcutter and hunter usually does.
};

instance DIA_Grom_HALLO3(C_Info)
{
	npc = BAU_981_Grom;
	nr = 11;
	condition = DIA_Grom_HALLO3_Condition;
	information = DIA_Grom_HALLO3_Info;
	description = "What interesting things are there to see here?";
};


func int DIA_Grom_HALLO3_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Grom_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Grom_HALLO3_Info()
{
	AI_Output(other,self,"DIA_Grom_HALLO_waszusehen_15_00");	//What interesting things are there to see here?
	AI_Output(self,other,"DIA_Grom_HALLO_waszusehen_08_01");	//Interesting is well put. If you go deeper into the woods here, you will run into some very evil fellows.
	AI_Output(self,other,"DIA_Grom_HALLO_waszusehen_08_02");	//They're about ten feet tall, hairy, and in a really bad mood. So don't go there if you're not strong enough for them.
};

instance DIA_Grom_AskTeacher(C_Info)
{
	npc = BAU_981_Grom;
	nr = 10;
	condition = DIA_Grom_AskTeacher_Condition;
	information = DIA_Grom_AskTeacher_Info;
	description = "Can you teach me something about hunting?";
};


func int DIA_Grom_AskTeacher_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Grom_HALLO))
	if(Npc_KnowsInfo(other,DIA_Grom_HALLO2))
	{
		return TRUE;
	};
};

func void DIA_Grom_AskTeacher_Info()
{
	AI_Output (other, self, "DIA_Grom_AskTeacher_15_00");	//Can you teach me something about hunting?
	AI_Output (self, other, "DIA_Grom_AskTeacher_08_01");	//Sure. But first get me something decent to eat. I'm dying of hunger out here.
	AI_Output (self, other, "DIA_Grom_AskTeacher_08_02");	//I want a bottle of milk, a loaf of bread and a fat ham, then I'll teach you what you want.
	Log_CreateTopic (TOPIC_GromAskTeacher, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_GromAskTeacher, LOG_Running);
	B_LogEntry (TOPIC_GromAskTeacher, "Grom the hunter will teach me what he knows if I get him a bottle of milk, a loaf of bread and ham.");
};


instance DIA_Grom_PayTeacher(C_Info)
{
	npc = BAU_981_Grom;
	nr = 11;
	condition = DIA_Grom_PayTeacher_Condition;
	information = DIA_Grom_PayTeacher_Info;
	description = "Here's the food you wanted.";
};


func int DIA_Grom_PayTeacher_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Grom_AskTeacher) && Npc_HasItems(other,ItFo_Milk) && Npc_HasItems(other,ItFo_Bread) && Npc_HasItems(other,ItFo_Bacon))
	{
		return TRUE;
	};
};

func void DIA_Grom_PayTeacher_Info()
{
	AI_Output(other,self,"DIA_Grom_PayTeacher_15_00");	//Here's the food you wanted.
	Npc_RemoveInvItem(other,ItFo_Milk);
	Npc_RemoveInvItem(other,ItFo_Bread);
	Npc_RemoveInvItem(other,ItFo_Bacon);
	CreateInvItem(self,ItFo_Milk);
	CreateInvItem(self,ItFo_Bread);
	CreateInvItem(self,ItFo_Bacon);
	AI_PrintScreen("Молоко отдано",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	AI_PrintScreen("Хлеб отдано",-1,40,FONT_ScreenSmall,2);
	AI_PrintScreen("Окорок отдано",-1,43,FONT_ScreenSmall,2);
	AI_Output(self,other,"DIA_Grom_PayTeacher_08_01");	//Fantastic. And now?
	Grom_TeachAnimalTrophy = TRUE;
	B_GivePlayerXP(XP_Ambient);
	Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_OutTeacher,"Grom the hunter can teach me how to take animal trophies.");
};


instance DIA_Grom_TEACHHUNTING(C_Info)
{
	npc = BAU_981_Grom;
	nr = 12;
	condition = DIA_Grom_TEACHHUNTING_Condition;
	information = DIA_Grom_TEACHHUNTING_Info;
	permanent = TRUE;
	description = "Teach me how to hunt.";
};


func int DIA_Grom_TEACHHUNTING_Condition()
{
	if(Grom_TeachAnimalTrophy == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Grom_TEACHHUNTING_Info()
{
	AI_Output (other, self, "DIA_Grom_TEACHHUNTING_15_00");	//Teach me how to hunt.
	if ((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Heart] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Mandibles] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ShadowHorn] == FALSE))
	{
		AI_Output (self, other, "DIA_Grom_TEACHHUNTING_08_01");	//What do you want to learn?
		Info_AddChoice (DIA_Grom_TEACHHUNTING, Dialog_Back, DIA_Grom_TEACHHUNTING_BACK);
		if (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE)
		{
			Info_AddChoice(DIA_Grom_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Fur,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_Fur)),DIA_Grom_TEACHHUNTING_Fur);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE)
		{
			Info_AddChoice(DIA_Grom_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Teeth,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Teeth)),DIA_Grom_TEACHHUNTING_Teeth);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Heart] == FALSE)
		{
			Info_AddChoice(DIA_Grom_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Heart,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Heart)),DIA_Grom_TEACHHUNTING_Heart);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Mandibles] == FALSE)
		{
			Info_AddChoice(DIA_Grom_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Mandibles,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Mandibles)),DIA_Grom_TEACHHUNTING_Mandibles);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ShadowHorn] == FALSE)
		{
			Info_AddChoice(DIA_Grom_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_ShadowHorn,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_ShadowHorn)),DIA_Grom_TEACHHUNTING_ShadowHorn);
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Grom_TEACHHUNTING_08_02");	//I can't teach you anything you don't already know.
	};
};

func void DIA_Grom_TEACHHUNTING_BACK()
{
	Info_ClearChoices(DIA_Grom_TEACHHUNTING);
};

func void DIA_Grom_TEACHHUNTING_Fur()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Fur))
	{
		AI_Output (self, other, "DIA_Grom_TEACHHUNTING_Fur_08_00");	//Cut a slit in the animal's legs so that you can strip the skin off. Do that from front to back, not the other way around.
	};
	Info_ClearChoices(DIA_Grom_TEACHHUNTING);
};

func void DIA_Grom_TEACHHUNTING_Teeth()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Teeth))
	{
		AI_Output (self, other, "DIA_Grom_TEACHHUNTING_Teeth_08_00");	//When removing the teeth you have to take special care that they don't break when they come away from the skull.
	};
	Info_ClearChoices(DIA_Grom_TEACHHUNTING);
};

func void DIA_Grom_TEACHHUNTING_Heart()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Heart))
	{
		AI_Output (self, other, "DIA_Grom_TEACHHUNTING_Heart_08_00");	//You remove the heart of the animal with a deft cut in the chest. But it's usually only worth it with special animals or magical beings.
	};
	Info_ClearChoices(DIA_Grom_TEACHHUNTING);
};

func void DIA_Grom_TEACHHUNTING_Mandibles()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Mandibles))
	{
		AI_Output (self, other, "DIA_Grom_TEACHHUNTING_Mandibles_08_00");	//The mandibles of a minecrawler or field raider have to be removed with a very strong metal lever. They are lodged very deeply in the animal's skull.
	};
	Info_ClearChoices(DIA_Grom_TEACHHUNTING);
};

func void DIA_Grom_TEACHHUNTING_ShadowHorn()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_ShadowHorn))
	{
		AI_Output (self, other, "DIA_Grom_TEACHHUNTING_ShadowHorn_08_00");	//To take off a shadowbeast horn, brace yourself against the skull with all your might, pulling on the horn and cutting the thing out with a hard blade.
	};
	Info_ClearChoices(DIA_Grom_TEACHHUNTING);
};


instance DIA_Grom_PICKPOCKET(C_Info)
{
	npc = BAU_981_Grom;
	nr = 900;
	condition = DIA_Grom_PICKPOCKET_Condition;
	information = DIA_Grom_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Grom_PICKPOCKET_Condition()
{
	return C_Beklauen(75,40);
};

func void DIA_Grom_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Grom_PICKPOCKET);
	Info_AddChoice(DIA_Grom_PICKPOCKET,Dialog_Back,DIA_Grom_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Grom_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Grom_PICKPOCKET_DoIt);
};

func void DIA_Grom_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Grom_PICKPOCKET);
};

func void DIA_Grom_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Grom_PICKPOCKET);
};

