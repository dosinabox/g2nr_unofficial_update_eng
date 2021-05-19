
instance DIA_Addon_Merdarion_ADW_EXIT(C_Info)
{
	npc = KDW_14050_Addon_Merdarion_ADW;
	nr = 999;
	condition = DIA_Addon_Merdarion_ADW_EXIT_Condition;
	information = DIA_Addon_Merdarion_ADW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Merdarion_ADW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Merdarion_ADW_EXIT_Info()
{
	if(DIA_Addon_Saturas_StonePlateHint_Condition() && (MIS_Saturas_LookingForHousesOfRulers == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_Merdarion_ActivateTeleports_06_11");	//Oh, by the way. Before I forget, Saturas would like to talk to you.
		AI_Output(self,other,"DIA_Addon_Merdarion_ActivateTeleports_06_12");	//You should see him as soon as possible.
	};
	if((Npc_KnowsInfo(other,DIA_Addon_Merdarion_FokusGeben) || (Merdarion_GotFocusCount > 0)) && !SC_ADW_ActivatedAllTelePortStones && (TriggeredTeleporterADW <= Merdarion_GotFocusCount) && !Npc_HasItems(other,ItMi_Focus))
	{
		CreateInvItems(self,ItMi_Focus,1);
		B_GiveInvItems(self,other,ItMi_Focus,1);
	};
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Merdarion_ADWHello(C_Info)
{
	npc = KDW_14050_Addon_Merdarion_ADW;
	nr = 5;
	condition = DIA_Addon_Merdarion_ADWHello_Condition;
	information = DIA_Addon_Merdarion_ADWHello_Info;
	description = "How's it going?";
};


func int DIA_Addon_Merdarion_ADWHello_Condition()
{
	return TRUE;
};

func void DIA_Addon_Merdarion_ADWHello_Info()
{
	AI_Output(other,self,"DIA_Addon_Merdarion_ADWHello_15_00");	//How's it going?
	AI_Output(self,other,"DIA_Addon_Merdarion_ADWHello_06_01");	//(listening) Listen... Curious. Don't you think?
	AI_Output(other,self,"DIA_Addon_Merdarion_ADWHello_15_02");	//Mmh...
	AI_Output(self,other,"DIA_Addon_Merdarion_ADWHello_06_03");	//These teleporter stones don't appear to function and yet you can hear them hum.
	AI_Output(self,other,"DIA_Addon_Merdarion_ADWHello_06_04");	//Although they aren't active, a certain energy rests in them nevertheless.
	Info_ClearChoices(DIA_Addon_Merdarion_ADWHello);
	Info_AddChoice(DIA_Addon_Merdarion_ADWHello,"How do these teleporter stones get their power?",DIA_Addon_Merdarion_ADWHello_reaktor);
	Info_AddChoice(DIA_Addon_Merdarion_ADWHello,"What do you think needs to be done to activate them?",DIA_Addon_Merdarion_ADWHello_was);
};

func void DIA_Addon_Merdarion_ADWHello_was()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_ADWHello_was_15_00");	//What do you think needs to be done to activate them?
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_was_06_01");	//I have an idea about that. I just need proof for my suspicion.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_was_06_02");	//I had a feeling days ago that I had seen this sort of construction somewhere before.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_was_06_03");	//I suspect that we have to supply them with a damn large amount of magical energy to get them back in service.
	Info_AddChoice (DIA_Addon_Merdarion_ADWHello, "Where have you seen these teleporter stones before?", DIA_Addon_Merdarion_ADWHello_wo);
	Info_AddChoice (DIA_Addon_Merdarion_ADWHello, "What could provide enough magical energy...", DIA_Addon_Merdarion_ADWHello_focus);
};

func void DIA_Addon_Merdarion_ADWHello_focus()
{
	AI_Output(other,self,"DIA_Addon_Merdarion_ADWHello_focus_15_00");	//What could provide enough magical energy...
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_focus_06_01");	//I can only think of one thing. A magical focus.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_focus_06_02");	//I mean one of the five focus stones that were used to create the magical barrier in the Valley of Mines.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_focus_06_03");	//As far as I know, you had to get them back for us a while ago.
	AI_Output (other, self, "DIA_Addon_Merdarion_ADWHello_focus_15_04");	//Yes. I can remember.
	Info_AddChoice (DIA_Addon_Merdarion_ADWHello, "You said you need proof for your suspicion.", DIA_Addon_Merdarion_ADWHello_focusProof);
	Info_AddChoice (DIA_Addon_Merdarion_ADWHello, "Where are the focus stones now?", DIA_Addon_Merdarion_ADWHello_focusWo);
};

func void DIA_Addon_Merdarion_ADWHello_focusWo()
{
	AI_Output(other,self,"DIA_Addon_Merdarion_ADWHello_focusWo_15_00");	//Where are the focus stones now?
	AI_Output(self,other,"DIA_Addon_Merdarion_ADWHello_focusWo_06_01");	//They were entrusted to me. I am supposed to keep them safe until we find another use for them.
	AI_Output(self,other,"DIA_Addon_Merdarion_ADWHello_focusWo_06_02");	//The way it looks, the time is ripe now.
	Info_AddChoice(DIA_Addon_Merdarion_ADWHello,"I've heard enough.",DIA_Addon_Merdarion_ADWHello_Back);
};

func void DIA_Addon_Merdarion_ADWHello_focusProof()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_ADWHello_focusProof_15_00");	//You said you need proof for your suspicion.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_focusProof_06_01");	//A magical focus should be connected to these stones.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_focusProof_06_02");	//But I don't know where.
};

func void DIA_Addon_Merdarion_ADWHello_Back()
{
	AI_Output(other,self,"DIA_Addon_Merdarion_ADWHello_Back_15_00");	//I've heard enough.
	Info_ClearChoices(DIA_Addon_Merdarion_ADWHello);
};

func void DIA_Addon_Merdarion_ADWHello_wo()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_ADWHello_wo_15_00");	//Where have you seen these teleporter stones before?
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_wo_06_01");	//You were in the penal colony, too. Didn't you ever notice those stones?
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_wo_06_02");	//I am quite sure that they can still be found there today.
};

func void DIA_Addon_Merdarion_ADWHello_reaktor()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_ADWHello_reaktor_15_00");	//How do these teleporter stones get their power?
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_reaktor_06_01");	//The builders were a very highly developed people.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_reaktor_06_02");	//They used properties of magic that we have never seen.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_reaktor_06_03");	//A network of teleporter stones was built so that the builders could move quickly from one place in the city to another.
	AI_Output (self, other, "DIA_Addon_Merdarion_ADWHello_reaktor_06_04");	//The stone HERE obviously forms a kind of center.
};


instance DIA_Addon_Merdarion_FokusGeben(C_Info)
{
	npc = KDW_14050_Addon_Merdarion_ADW;
	nr = 5;
	condition = DIA_Addon_Merdarion_FokusGeben_Condition;
	information = DIA_Addon_Merdarion_FokusGeben_Info;
	description = "Give me a focus stone.";
};


func int DIA_Addon_Merdarion_FokusGeben_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_ADWHello))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_FokusGeben_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_FokusGeben_15_00");	//Give me a focus stone. I will try to get the teleporters to work.
	AI_Output (self, other, "DIA_Addon_Merdarion_FokusGeben_06_01");	//All right. But be careful with it, you hear?
	AI_Output (self, other, "DIA_Addon_Merdarion_FokusGeben_06_02");	//Saturas will have my head if we lose them.
	CreateInvItems (self, ItMi_Focus, 1);
	B_GiveInvItems (self, other, ItMi_Focus, 1);
	Log_CreateTopic (TOPIC_Addon_TeleportsADW, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_TeleportsADW, LOG_Running);
	B_LogEntry (TOPIC_Addon_TeleportsADW, "The Water Mage Merdarion gave me one of the old focus stones that was used to create the Barrier in the Valley of Mines. I am to try and activate one of the teleporter stones.");
};


var int Merdarion_GotFocusCount;

instance DIA_Addon_Merdarion_FirstFocus(C_Info)
{
	npc = KDW_14050_Addon_Merdarion_ADW;
	nr = 5;
	condition = DIA_Addon_Merdarion_FirstFocus_Condition;
	information = DIA_Addon_Merdarion_FirstFocus_Info;
	description = "I have activated one of the teleporter stones.";
};


func int DIA_Addon_Merdarion_FirstFocus_Condition()
{
	if(TriggeredTeleporterADW != 0)
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_FirstFocus_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_FirstFocus_15_00");	//I have activated one of the teleporter stones.
	AI_Output (self, other, "DIA_Addon_Merdarion_FirstFocus_06_01");	//I can see that. So I was right.
	AI_Output (self, other, "DIA_Addon_Merdarion_FirstFocus_06_02");	//I have talked to the others about it.
	AI_Output (self, other, "DIA_Addon_Merdarion_FirstFocus_06_03");	//We want you to try to activate all of the teleporter stones.
	AI_Output (self, other, "DIA_Addon_Merdarion_FirstFocus_06_04");	//It would be a great help in our investigations if we could move quickly from one part of the city to another.
	AI_Output (self, other, "DIA_Addon_Merdarion_FirstFocus_06_05");	//Here is another focus stone.
	CreateInvItems (self, ItMi_Focus, 1);
	B_GiveInvItems (self, other, ItMi_Focus, 1);
	Merdarion_GotFocusCount = 1;
	AI_Output (self, other, "DIA_Addon_Merdarion_FirstFocus_06_06");	//Activate them all if you can.
	AI_Output (other, self, "DIA_Addon_Merdarion_FirstFocus_15_07");	//I'll try.
	B_GivePlayerXP (XP_Addon_ActivatedTeleportStone);
	B_LogEntry (TOPIC_Addon_TeleportsADW, "Merdarion gave me another focus stone. I am supposed to try and get all the teleporter stone working. He will give me another focus stone as soon as the next teleporter stone is working.");
};


var int DIA_Addon_Merdarion_ActivateTeleports_OneTime;

instance DIA_Addon_Merdarion_ActivateTeleports(C_Info)
{
	npc = KDW_14050_Addon_Merdarion_ADW;
	nr = 5;
	condition = DIA_Addon_Merdarion_ActivateTeleports_Condition;
	information = DIA_Addon_Merdarion_ActivateTeleports_Info;
	permanent = TRUE;
	description = "I have activated another one of the teleporter stones.";
};


func int DIA_Addon_Merdarion_ActivateTeleports_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_FirstFocus) && (TriggeredTeleporterADW > Merdarion_GotFocusCount) && (Merdarion_GotFocusCount < 6))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_ActivateTeleports_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_ActivateTeleports_15_00");	//I have activated another one of the teleporter stones.
	if (SC_ADW_ActivatedAllTelePortStones == FALSE)
	{
		AI_Output (other, self, "DIA_Addon_Merdarion_ActivateTeleports_15_01");	//Give me the next focus.
		AI_Output (self, other, "DIA_Addon_Merdarion_ActivateTeleports_06_02");	//Of course. Here it is.
		CreateInvItems (self, ItMi_Focus, 1);
		B_GiveInvItems (self, other, ItMi_Focus, 1);
	};
	if(DIA_Addon_Merdarion_ActivateTeleports_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Merdarion_ActivateTeleports_06_03");	//Was it difficult.
		AI_Output (other, self, "DIA_Addon_Merdarion_ActivateTeleports_15_04");	//Depends on how you look at it. I could use a bit of support.
		AI_Output (self, other, "DIA_Addon_Merdarion_ActivateTeleports_06_05");	//I can give you some gold, would that help?
		AI_Output (other, self, "DIA_Addon_Merdarion_ActivateTeleports_15_06");	//It couldn't hurt.
		AI_Output (self, other, "DIA_Addon_Merdarion_ActivateTeleports_06_07");	//Let's see...
		DIA_Addon_Merdarion_ActivateTeleports_OneTime = TRUE;
	};
	if(SC_ADW_ActivatedAllTelePortStones == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Merdarion_ActivateTeleports_06_08");	//You have done really well. I can only congraulate you on your work.
		AI_Output (self, other, "DIA_Addon_Merdarion_ActivateTeleports_06_09");	//They are all working again now. An impressive sight, don't you think?
	};
	AI_Output(self,other,"DIA_Addon_Merdarion_ActivateTeleports_06_10");	//Here are a few gold coins.
	B_GivePlayerXP(XP_Addon_ActivatedTeleportStone);
	CreateInvItems(self,ItMi_Gold,150);
	B_GiveInvItems(self,other,ItMi_Gold,150);
	Merdarion_GotFocusCount += 1;
};


instance DIA_Addon_Merdarion_ADW_PreTeachMana(C_Info)
{
	npc = KDW_14050_Addon_Merdarion_ADW;
	nr = 5;
	condition = DIA_Addon_Merdarion_ADW_PreTeachMana_Condition;
	information = DIA_Addon_Merdarion_ADW_PreTeachMana_Info;
	description = "Can you teach me your magic skills?";
};


func int DIA_Addon_Merdarion_ADW_PreTeachMana_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Merdarion_ADWHello))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_ADW_PreTeachMana_Info()
{
	AI_Output (other, self, "DIA_Addon_Merdarion_ADW_PreTeachMana_15_00");	//Can you teach me your magic skills?
	AI_Output (self, other, "DIA_Addon_Merdarion_ADW_PreTeachMana_06_01");	//I can show you how to increase your magic power.
	Merdarion_Addon_TeachMana = TRUE;
	Log_CreateTopic (TOPIC_Addon_KDWTeacher, LOG_NOTE);
	B_LogEntry (TOPIC_Addon_KDWTeacher, "Merdarion can increase my mana.");
};


var int Merdarion_ADW_Empty;

func void B_BuildLearnDialog_Merdarion()
{
	if(other.aivar[REAL_MANA_MAX] >= T_HIGH)
	{
		AI_Output(self,other,"DIA_Addon_Merdarion_ADW_TEACH_MANA_06_00");	//Your request goes beyond my capabilities.
		AI_Output(self,other,"DIA_Addon_Merdarion_ADW_TEACH_MANA_06_01");	//I cannot teach you anything more.
		Merdarion_ADW_Empty = TRUE;
	}
	else
	{
		Info_ClearChoices(DIA_Addon_Merdarion_ADW_TEACH_MANA);
		Info_AddChoice(DIA_Addon_Merdarion_ADW_TEACH_MANA,Dialog_Back,DIA_Addon_Merdarion_ADW_TEACH_MANA_BACK);
		Info_AddChoice(DIA_Addon_Merdarion_ADW_TEACH_MANA,B_BuildLearnString(PRINT_LearnMANA1,B_GetLearnCostAttribute(other,ATR_MANA_MAX)),DIA_Addon_Merdarion_ADW_TEACH_MANA_1);
		Info_AddChoice(DIA_Addon_Merdarion_ADW_TEACH_MANA,B_BuildLearnString(PRINT_LearnMANA5,B_GetLearnCostAttribute(other,ATR_MANA_MAX) * 5),DIA_Addon_Merdarion_ADW_TEACH_MANA_5);
	};
};

instance DIA_Addon_Merdarion_ADW_TEACH_MANA(C_Info)
{
	npc = KDW_14050_Addon_Merdarion_ADW;
	nr = 99;
	condition = DIA_Addon_Merdarion_ADW_TEACH_MANA_Condition;
	information = DIA_Addon_Merdarion_ADW_TEACH_MANA_Info;
	permanent = TRUE;
	description = "I want to increase my magic power.";
};


func int DIA_Addon_Merdarion_ADW_TEACH_MANA_Condition()
{
	if((Merdarion_Addon_TeachMana == TRUE) && (Merdarion_ADW_Empty == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Merdarion_ADW_TEACH_MANA_Info()
{
	AI_Output(other,self,"DIA_Addon_Merdarion_ADW_TEACH_MANA_15_00");	//I want to increase my magic power.
	B_BuildLearnDialog_Merdarion();
};

func void DIA_Addon_Merdarion_ADW_TEACH_MANA_BACK()
{
	Info_ClearChoices(DIA_Addon_Merdarion_ADW_TEACH_MANA);
};

func void DIA_Addon_Merdarion_ADW_TEACH_MANA_1()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,1,T_HIGH))
	{
		B_BuildLearnDialog_Merdarion();
	};
};

func void DIA_Addon_Merdarion_ADW_TEACH_MANA_5()
{
	if(B_TeachAttributePoints(self,other,ATR_MANA_MAX,5,T_HIGH))
	{
		B_BuildLearnDialog_Merdarion();
	};
};

