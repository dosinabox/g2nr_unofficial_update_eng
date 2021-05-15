
instance DIA_Dragomir_EXIT(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 999;
	condition = DIA_Dragomir_EXIT_Condition;
	information = DIA_Dragomir_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Dragomir_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Dragomir_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Dragomir_Hello(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 1;
	condition = DIA_Dragomir_Hello_Condition;
	information = DIA_Dragomir_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dragomir_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Dragomir_Hello_Info()
{
	AI_Output (self, other, "DIA_Dragomir_Hello_12_00");	//Traveling so far from home?
	AI_Output (self, other, "DIA_Dragomir_Hello_12_01");	//Out here you have to be careful, especially when you're all by yourself.
};


instance DIA_Dragomir_OutHere(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 2;
	condition = DIA_Dragomir_OutHere_Condition;
	information = DIA_Dragomir_OutHere_Info;
	permanent = FALSE;
	description = "What are you doing out here?";
};


func int DIA_Dragomir_OutHere_Condition()
{
	return TRUE;
};

func void DIA_Dragomir_OutHere_Info()
{
	AI_Output (other, self, "DIA_Dragomir_OutHere_15_00");	//What are you doing out here?
	AI_Output (self, other, "DIA_Dragomir_OutHere_12_01");	//Well, the tavern is too expensive for me, that's why I settled here.
	AI_Output (self, other, "DIA_Dragomir_OutHere_12_02");	//The previous inhabitants don't seem to need it any more.
};


instance DIA_Dragomir_Settlers(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 2;
	condition = DIA_Dragomir_Settlers_Condition;
	information = DIA_Dragomir_Settlers_Info;
	permanent = FALSE;
	description = "Who used to live in this camp?";
};


func int DIA_Dragomir_Settlers_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragomir_OutHere))
	{
		return TRUE;
	};
};

func void DIA_Dragomir_Settlers_Info()
{
	AI_Output (other, self, "DIA_Dragomir_Settlers_15_00");	//Who used to live in this camp?
	AI_Output (self, other, "DIA_Dragomir_Settlers_12_01");	//No idea, probably some hunters. I suppose it got too dangerous for them out here.
};


instance DIA_Dragomir_Dangerous(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 2;
	condition = DIA_Dragomir_Dangerous_Condition;
	information = DIA_Dragomir_Dangerous_Info;
	permanent = FALSE;
	description = "Isn't it too dangerous out here?";
};


func int DIA_Dragomir_Dangerous_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragomir_OutHere))
	{
		return TRUE;
	};
};

func void DIA_Dragomir_Dangerous_Info()
{
	AI_Output (other, self, "DIA_Dragomir_Dangerous_15_00");	//Isn't it too dangerous out here?
	AI_Output (self, other, "DIA_Dragomir_Dangerous_12_01");	//Well, not if you can defend yourself. My crossbow has already proven to be of service many times.
	AI_Output (other, self, "DIA_Dragomir_Dangerous_15_02");	//It's not all that big.
	AI_Output (self, other, "DIA_Dragomir_Dangerous_12_03");	//But deadly, if you know how to handle it. I used to have a bigger one. Unfortunately, I lost it.
	AI_Output (self, other, "DIA_Dragomir_Dangerous_12_04");	//I ventured too far north into the mountains. There's a big stone circle there with a sacrificial altar.
	AI_Output (self, other, "DIA_Dragomir_Dangerous_12_05");	//While I was hunting scavengers up there, these vile undead beings came out of the woods and attacked me.
	AI_Output (self, other, "DIA_Dragomir_Dangerous_12_06");	//All I could do was run for my life.
	AI_Output (self, other, "DIA_Dragomir_Dangerous_12_07");	//While I was running, the crossbow slipped from my hand. I bet it's still lying up there by that strange stone circle in the north.
	Log_CreateTopic (TOPIC_DragomirsArmbrust, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_DragomirsArmbrust, LOG_Running);
	B_LogEntry (TOPIC_DragomirsArmbrust, "Dragomir lost his crossbow at a strange stone circle in the high northern mountains.");
	MIS_DragomirsArmbrust = LOG_Running;
};


instance DIA_Dragomir_Armbrust(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 2;
	condition = DIA_Dragomir_Armbrust_Condition;
	information = DIA_Dragomir_Armbrust_Info;
	permanent = FALSE;
	description = "Here. I found your crossbow.";
};


func int DIA_Dragomir_Armbrust_Condition()
{
	if((MIS_DragomirsArmbrust == LOG_Running) && Npc_HasItems(other,ItRw_DragomirsArmbrust_MIS))
	{
		return TRUE;
	};
};

func void DIA_Dragomir_Armbrust_Info()
{
	AI_Output (other, self, "DIA_Dragomir_Armbrust_15_00");	//Here. I found your crossbow.
	B_GiveInvItems (other, self, ItRw_DragomirsArmbrust_MIS, 1);
	AI_Output (self, other, "DIA_Dragomir_Armbrust_12_01");	//Indeed, this is mine. Don't tell me you were up by the stone circle?!
	AI_Output (other, self, "DIA_Dragomir_Armbrust_15_02");	//Most certainly!
	AI_Output (self, other, "DIA_Dragomir_Armbrust_12_03");	//That was pretty reckless of you. But thanks anyway.
	AI_Output (self, other, "DIA_Dragomir_Armbrust_12_04");	//Naturally, I'll repay this deed. I hope this is enough.
	CreateInvItems (self, ItMi_Gold, 150);
	B_GiveInvItems (self, other, ItMi_Gold, 150);
	MIS_DragomirsArmbrust = LOG_SUCCESS;
	B_GivePlayerXP(XP_DragomirsArmbrust);
	AI_EquipBestRangedWeapon(self);
};


var int Dragomir_TeachPlayer;
const int Dragomir_TeachingCost = 150;

instance DIA_Dragomir_Learn(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 2;
	condition = DIA_Dragomir_Learn_Condition;
	information = DIA_Dragomir_Learn_Info;
	permanent = TRUE;
	description = "Can you teach me something?";
};


func int DIA_Dragomir_Learn_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dragomir_Dangerous) && (Dragomir_TeachPlayer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Dragomir_Learn_Info()
{
	AI_Output (other, self, "DIA_Dragomir_Learn_15_00");	//Can you teach me something?
	if (other.attribute[ATR_DEXTERITY] < 30)
	{
		AI_Output (self, other, "DIA_Dragomir_Learn_12_01");	//Before I teach you anything, you'll have to improve your dexterity.
	}
	else
	{
		AI_Output (self, other, "DIA_Dragomir_Learn_12_02");	//If you can pay. Like I said, at the moment I'm a bit strapped for cash.
		AI_Output (other, self, "DIA_Dragomir_Learn_15_03");	//How much do you ask?
		B_Say_Gold (self, other, Dragomir_TeachingCost);
		Info_ClearChoices (DIA_Dragomir_Learn);
		Info_AddChoice (DIA_Dragomir_Learn, "Maybe later.", DIA_Dragomir_Learn_Later);
		if (Npc_HasItems (other, ItMi_Gold) >= Dragomir_TeachingCost)
		{
			Info_AddChoice (DIA_Dragomir_Learn, "Here's your gold.", DIA_Dragomir_Learn_Here);
		};
	};
};

func void DIA_Dragomir_Learn_Later()
{
	AI_Output (other, self, "DIA_Dragomir_Learn_Later_15_00");	//Maybe later.
	Info_ClearChoices (DIA_Dragomir_Learn);
};

func void DIA_Dragomir_Learn_Here()
{
	AI_Output (other, self, "DIA_Dragomir_Learn_Here_15_00");	//Here's your gold.
	B_GiveInvItems (other, self, ItMi_Gold, Dragomir_TeachingCost);
	AI_Output (self, other, "DIA_Dragomir_Learn_Here_12_01");	//Good, as far as I'm concerned we can begin immediately.
	Dragomir_TeachPlayer = TRUE;
	Info_ClearChoices(DIA_Dragomir_Learn);
	Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_OutTeacher,"Dragomir can show me how to shoot with crossbows.");
};


var int DIA_Dragomir_Teach_permanent;

func void B_BuildLearnDialog_Dragomir()
{
	if(VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Dragomir)
	{
		Info_ClearChoices(DIA_Dragomir_Teach);
		Info_AddChoice(DIA_Dragomir_Teach,Dialog_Back,DIA_Dragomir_Teach_Back);
		Info_AddChoice(DIA_Dragomir_Teach,B_BuildLearnString(PRINT_LearnCrossBow1,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,1)),DIA_Dragomir_Teach_CROSSBOW_1);
		Info_AddChoice(DIA_Dragomir_Teach,B_BuildLearnString(PRINT_LearnCrossBow5,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,5)),DIA_Dragomir_Teach_CROSSBOW_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_CROSSBOW) >= TeachLimit_Crossbow_Dragomir)
		{
			DIA_Dragomir_Teach_permanent = TRUE;
		};
		PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_Crossbow_Dragomir)),-1,53,FONT_Screen,2);
		AI_Output(self,other,"DIA_Dragomir_Teach_12_00");	//I can't teach you anything more. It's time you looked for another teacher.
		AI_StopProcessInfos(self);
	};
};

instance DIA_Dragomir_Teach(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 2;
	condition = DIA_Dragomir_Teach_Condition;
	information = DIA_Dragomir_Teach_Info;
	permanent = TRUE;
	description = "Teach me something.";
};


func int DIA_Dragomir_Teach_Condition()
{
	if((Dragomir_TeachPlayer == TRUE) && (DIA_Dragomir_Teach_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Dragomir_Teach_Info()
{
	AI_Output(other,self,"DIA_Dragomir_Teach_15_00");	//Teach me something.
	B_BuildLearnDialog_Dragomir();
};

func void DIA_Dragomir_Teach_Back()
{
	Info_ClearChoices(DIA_Dragomir_Teach);
};

func void DIA_Dragomir_Teach_CROSSBOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,1,TeachLimit_Crossbow_Dragomir))
	{
		B_BuildLearnDialog_Dragomir();
	};
};

func void DIA_Dragomir_Teach_CROSSBOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,5,TeachLimit_Crossbow_Dragomir))
	{
		B_BuildLearnDialog_Dragomir();
	};
};

instance DIA_Dragomir_PICKPOCKET(C_Info)
{
	npc = BAU_983_Dragomir;
	nr = 900;
	condition = DIA_Dragomir_PICKPOCKET_Condition;
	information = DIA_Dragomir_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Dragomir_PICKPOCKET_Condition()
{
	return C_Beklauen(47,70);
};

func void DIA_Dragomir_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Dragomir_PICKPOCKET);
	Info_AddChoice(DIA_Dragomir_PICKPOCKET,Dialog_Back,DIA_Dragomir_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Dragomir_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Dragomir_PICKPOCKET_DoIt);
};

func void DIA_Dragomir_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Dragomir_PICKPOCKET);
};

func void DIA_Dragomir_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Dragomir_PICKPOCKET);
};

