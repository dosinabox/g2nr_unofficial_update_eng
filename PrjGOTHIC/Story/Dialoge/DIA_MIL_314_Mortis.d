
instance DIA_Mortis_EXIT(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 999;
	condition = DIA_Mortis_EXIT_Condition;
	information = DIA_Mortis_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Mortis_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Mortis_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Mortis_Hallo(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 2;
	condition = DIA_Mortis_Hallo_Condition;
	information = DIA_Mortis_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Mortis_Hallo_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Peck_FOUND_PECK) && (Kapitel < 3))
	{
		if(Npc_IsInState(self,ZS_Talk))
		{
			return TRUE;
		};
	}
	else if(other.guild == GIL_MIL)
	{
		return TRUE;
	};
};

func void DIA_Mortis_Hallo_Info()
{
	if(!Npc_KnowsInfo(other,DIA_Peck_FOUND_PECK) && (Kapitel < 3))
	{
		AI_Output(self,other,"DIA_Mortis_Hallo_13_00");	//What do you want? Peck isn't here. So you can't get anything. Come back later.
	}
	else if(other.guild == GIL_MIL)
	{
		AI_Output(self,other,"DIA_Mortis_Waffe_13_01");	//You just started with us, huh? Well then, welcome to the team.
	};
};


instance DIA_Mortis_Waffe(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 3;
	condition = DIA_Mortis_Waffe_Condition;
	information = DIA_Mortis_Waffe_Info;
	permanent = FALSE;
	description = "Where is Peck?";
};


func int DIA_Mortis_Waffe_Condition()
{
	if((MIS_Andre_Peck == LOG_Running) && !Npc_KnowsInfo(other,DIA_Peck_FOUND_PECK) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Mortis_Waffe_Info()
{
	AI_Output (other, self, "DIA_Mortis_Waffe_15_00");	//Where's Peck?
	AI_Output (self, other, "DIA_Mortis_Waffe_13_01");	//You just started with us, huh? Well then, welcome to the team.
	AI_Output (self, other, "DIA_Mortis_Waffe_13_02");	//Peck's been in the city a really long time. I bet he's hanging around that sweet Vanja in the Red Lantern.
};


instance DIA_Mortis_Paket(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 4;
	condition = DIA_Mortis_Paket_Condition;
	information = DIA_Mortis_Paket_Info;
	permanent = FALSE;
	description = "What do you know about that package of weed?";
};


func int DIA_Mortis_Paket_Condition()
{
	if(MIS_Andre_WAREHOUSE == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Mortis_Paket_Info()
{
	AI_Output (other, self, "DIA_Mortis_Paket_15_00");	//What do you know about that package of weed?
	AI_Output (self, other, "DIA_Mortis_Paket_13_01");	//Hm ... the last time I was in the harbor tavern, I heard how Kardif and some other guy were talking about it.
	AI_Output (other, self, "DIA_Mortis_Paket_15_02");	//Who was the other guy?
	AI_Output (self, other, "DIA_Mortis_Paket_13_03");	//No idea. But he said he'd found the best storage place for his herbs - then the two of them laughed like drunken orcs.
	B_LogEntry (TOPIC_Warehouse, "Mortis heard the landlord Kardif and some other man talking about the package in the dockside pub. They were discussing where to store it.");
};


instance DIA_Mortis_Redlight(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 5;
	condition = DIA_Mortis_Redlight_Condition;
	information = DIA_Mortis_Redlight_Info;
	permanent = FALSE;
	description = "What do you know about the harbor district?";
};


func int DIA_Mortis_Redlight_Condition()
{
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Mortis_Redlight_Info()
{
	AI_Output(other,self,"DIA_Mortis_Redlight_15_00");	//What do you know about the harbor district? I want to find the one who's selling the swampweed.
	if(other.guild == GIL_MIL)
	{
		AI_Output(self,other,"DIA_Mortis_Redlight_13_01");	//Weeell, the guys down there really don't talk much, and they're guaranteed not to say anything to one of the city guard.
	};
	AI_Output(self,other,"DIA_Mortis_Redlight_13_02");	//If you want to learn anything down there, you should, no you HAVE to take off your armor.
	AI_Output(other,self,"DIA_Mortis_Redlight_15_03");	//All right, and then?
	AI_Output(self,other,"DIA_Mortis_Redlight_13_04");	//The tavern and the brothel are probably the best places for you to go. If you're going to learn anything, then you'll learn it there.
	B_LogEntry(TOPIC_Redlight,"Mortis reckons if I want to buy swampweed in the harbor district, I'd better not wear any armor. The tavern and the brothel are the best places to try.");
};


instance DIA_Mortis_CanTeach(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 6;
	condition = DIA_Mortis_CanTeach_Condition;
	information = DIA_Mortis_CanTeach_Info;
	permanent = TRUE;
	description = "I want to get stronger.";
};


func int DIA_Mortis_CanTeach_Condition()
{
	if(Mortis_TeachSTR == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Mortis_CanTeach_Info()
{
	AI_Output (other, self, "DIA_Mortis_CanTeach_15_00");	//I want to get stronger.
	if ((other.guild == GIL_MIL) || (other.guild == GIL_PAL))
	{
		AI_Output(self,other,"DIA_Mortis_CanTeach_13_01");	//Got it. If you've got enough experience, I can help you with your training.
		if(!Npc_KnowsInfo(other,DIA_Wulfgar_AlsMil))
		{
			Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
			B_LogEntry(TOPIC_CityTeacher,"Mortis, the city guardsman, can help me train my strength.");
		};
		Mortis_TeachSTR = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Mortis_CanTeach_13_02");	//Of course you do. But so long as you aren't one of us or a paladin, I won't help you.
	};
};


func void B_BuildLearnDialog_Mortis()
{
	if(other.aivar[REAL_STRENGTH] >= 150)
	{
		AI_Output(self,other,"DIA_Mortis_Teach_13_00");	//You're strong enough. If you want to train more, go somewhere else.
	}
	else
	{
		Info_ClearChoices(DIA_Mortis_Teach);
		Info_AddChoice(DIA_Mortis_Teach,Dialog_Back,DIA_Mortis_Teach_BACK);
		Info_AddChoice(DIA_Mortis_Teach,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_Mortis_Teach_1);
		Info_AddChoice(DIA_Mortis_Teach,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_Mortis_Teach_5);
	};
};

instance DIA_Mortis_Teach(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 100;
	condition = DIA_Mortis_Teach_Condition;
	information = DIA_Mortis_Teach_Info;
	permanent = TRUE;
	description = "I want to get stronger.";
};


func int DIA_Mortis_Teach_Condition()
{
	if(Mortis_TeachSTR == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Mortis_Teach_Info()
{
	AI_Output(other,self,"DIA_Keroloth_Teach_15_00");	//I want to get stronger.
	B_BuildLearnDialog_Mortis();
};

func void DIA_Mortis_Teach_BACK()
{
	Info_ClearChoices(DIA_Mortis_Teach);
};

func void DIA_Mortis_Teach_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,150))
	{
		B_BuildLearnDialog_Mortis();
	};
};

func void DIA_Mortis_Teach_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,150))
	{
		B_BuildLearnDialog_Mortis();
	};
};

instance DIA_Mortis_PICKPOCKET(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 900;
	condition = DIA_Mortis_PICKPOCKET_Condition;
	information = DIA_Mortis_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Mortis_PICKPOCKET_Condition()
{
	return C_Beklauen(38,60);
};

func void DIA_Mortis_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Mortis_PICKPOCKET);
	Info_AddChoice(DIA_Mortis_PICKPOCKET,Dialog_Back,DIA_Mortis_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Mortis_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Mortis_PICKPOCKET_DoIt);
};

func void DIA_Mortis_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Mortis_PICKPOCKET);
};

func void DIA_Mortis_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Mortis_PICKPOCKET);
};

instance DIA_Mortis_RepairNecklace(C_Info)
{
	npc = MIL_314_Mortis;
	nr = 8;
	condition = DIA_Mortis_RepairNecklace_Condition;
	information = DIA_Mortis_RepairNecklace_Info;
	permanent = FALSE;
	description = "Can you repair jewelry?";
};


func int DIA_Mortis_RepairNecklace_Condition()
{
	if((MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS) && (Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)))
	{
		if(!Npc_KnowsInfo(other,DIA_Bennet_ShowInnosEye))
		{
			return TRUE;
		};
	};
};

func void DIA_Mortis_RepairNecklace_Info()
{
	DIA_Common_CanYouRepairJewelry();
	AI_Output(self,other,"DIA_Parcival_PERMKAP4_13_01");	//Aah, leave me alone!
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
	AI_StopProcessInfos(self);
};

