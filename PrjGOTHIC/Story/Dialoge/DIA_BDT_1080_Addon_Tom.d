
instance DIA_Addon_Tom_EXIT(C_Info)
{
	npc = BDT_1080_Addon_Tom;
	nr = 999;
	condition = DIA_Addon_Tom_EXIT_Condition;
	information = DIA_Addon_Tom_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Tom_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Tom_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Tom_PICKPOCKET(C_Info)
{
	npc = BDT_1080_Addon_Tom;
	nr = 900;
	condition = DIA_Addon_Tom_PICKPOCKET_Condition;
	information = DIA_Addon_Tom_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Addon_Tom_PICKPOCKET_Condition()
{
	return C_Beklauen(40,52);
};

func void DIA_Addon_Tom_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Tom_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Tom_PICKPOCKET,Dialog_Back,DIA_Addon_Tom_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Tom_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Tom_PICKPOCKET_DoIt);
};

func void DIA_Addon_Tom_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Tom_PICKPOCKET);
};

func void DIA_Addon_Tom_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Tom_PICKPOCKET);
};


instance DIA_Addon_Tom_HI(C_Info)
{
	npc = BDT_1080_Addon_Tom;
	nr = 1;
	condition = DIA_Addon_Tom_HI_Condition;
	information = DIA_Addon_Tom_HI_Info;
	permanent = FALSE;
	description = "Why are you sitting around here?";
};


func int DIA_Addon_Tom_HI_Condition()
{
	return TRUE;
};

func void DIA_Addon_Tom_HI_Info()
{
	AI_Output (other, self, "DIA_Addon_Tom_HI_15_00");	//Why are you sitting around here?
	AI_Output (self, other, "DIA_Addon_Tom_HI_11_01");	//I've got problems. At the moment, it's better for my health if I'm not seen in the camp.
	AI_Output (other, self, "DIA_Addon_Tom_HI_15_02");	//What's wrong?
	AI_Output (self, other, "DIA_Addon_Tom_HI_11_03");	//I had really good relations with some of the pirates, you see?
	AI_Output (self, other, "DIA_Addon_Tom_HI_11_04");	//I was always meeting the boys outside their camp and trading.
	AI_Output (self, other, "DIA_Addon_Tom_HI_11_05");	//Man! I bought stuff for half the camp. 'Tom bring me this - Tom bring me that.'
	AI_Output (self, other, "DIA_Addon_Tom_HI_11_06");	//And then that bastard Esteban got in between.
};


instance DIA_Addon_Tom_Juan(C_Info)
{
	npc = BDT_1080_Addon_Tom;
	nr = 2;
	condition = DIA_Addon_Tom_Juan_Condition;
	information = DIA_Addon_Tom_Juan_Info;
	permanent = FALSE;
	description = "What happened?";
};


func int DIA_Addon_Tom_Juan_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Tom_HI))
	{
		return TRUE;
	};
};

func void DIA_Addon_Tom_Juan_Info()
{
	AI_Output (other, self, "DIA_Addon_Tom_Juan_15_00");	//What happened?
	AI_Output (self, other, "DIA_Addon_Tom_Juan_11_01");	//Esteban sent Juan - one of his boys. The bastard waylaid us.
	AI_Output (self, other, "DIA_Addon_Tom_Juan_11_02");	//I was just about to make a deal with the pirates when he came out of the dark and knocked me down with two blows!
	AI_Output (self, other, "DIA_Addon_Tom_Juan_11_03");	//Man, that guy is fast! But not fast enough. I was able to get away from him.
	SC_Knows_JuanMurderedAngus = TRUE;
	if(MIS_Addon_Bill_SearchAngusMurder == LOG_Running)
	{
		B_LogEntry(TOPIC_Addon_KillJuan,"So Juan is responsible for the murder of Hank and Angus. He lay in wait for the two of them and then killed them.");
	};
};


instance DIA_Addon_Tom_Esteban(C_Info)
{
	npc = BDT_1080_Addon_Tom;
	nr = 3;
	condition = DIA_Addon_Tom_Esteban_Condition;
	information = DIA_Addon_Tom_Esteban_Info;
	permanent = FALSE;
	description = "And since the ambush you've been hiding here?";
};


func int DIA_Addon_Tom_Esteban_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Tom_Juan))
	{
		return TRUE;
	};
};

func void DIA_Addon_Tom_Esteban_Info()
{
	AI_Output (other, self, "DIA_Addon_Tom_Esteban_15_00");	//And since the ambush you've been hiding here?
	AI_Output (self, other, "DIA_Addon_Tom_Esteban_11_01");	//First I went back to the camp and let Fisk, Huno and the others know that they could forget their delivery.
	AI_Output (self, other, "DIA_Addon_Tom_Esteban_11_02");	//And that Esteban was behind it.
	AI_Output (self, other, "DIA_Addon_Tom_Esteban_11_03");	//If Esteban finds out that I told the others that HE was responsible, I'm dead.
	AI_Output (self, other, "DIA_Addon_Tom_Esteban_11_04");	//That's why I can't go back to the camp.
	Tom_Tells = TRUE;
};


instance DIA_Addon_Tom_Dead(C_Info)
{
	npc = BDT_1080_Addon_Tom;
	nr = 4;
	condition = DIA_Addon_Tom_Dead_Condition;
	information = DIA_Addon_Tom_Dead_Info;
	permanent = FALSE;
	description = "Esteban is dead.";
};


func int DIA_Addon_Tom_Dead_Condition()
{
	if(Npc_IsDead(Esteban) && Npc_KnowsInfo(other,DIA_Addon_Tom_Esteban))
	{
		return TRUE;
	};
};

func void DIA_Addon_Tom_Dead_Info()
{
	AI_Output (other, self, "DIA_Addon_Tom_Dead_15_00");	//Esteban is dead.
	AI_Output (self, other, "DIA_Addon_Tom_Dead_11_01");	//Really? Man, THAT'S lucky!
	AI_Output (self, other, "DIA_Addon_Tom_Dead_11_02");	//Who did it?
	AI_Output (other, self, "DIA_Addon_Tom_Dead_15_03");	//(mischieviously) Let's just say, someone you know...
	AI_Output (self, other, "DIA_Addon_Tom_Dead_11_04");	//Thanks for coming to me. Now I can go back to the camp...
	B_GivePlayerXP (XP_Ambient);
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "LAGER");
};


instance DIA_Addon_Tom_PERM(C_Info)
{
	npc = BDT_1080_Addon_Tom;
	nr = 5;
	condition = DIA_Addon_Tom_PERM_Condition;
	information = DIA_Addon_Tom_PERM_Info;
	permanent = TRUE;
	description = "What else?";
};


func int DIA_Addon_Tom_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Tom_Esteban))
	{
		return TRUE;
	};
};

func void DIA_Addon_Tom_PERM_Info()
{
	AI_Output (other, self, "DIA_Addon_Tom_PERM_15_00");	//What else?
	if (Npc_GetDistToWP (self, "BL_INN_05_B") <= 500)
	{
		AI_Output (self, other, "DIA_Addon_Tom_PERM_11_01");	//Now I can down Lucia's booze in peace again.
	}
	else if(Npc_KnowsInfo(other,DIA_Addon_Tom_Dead))
	{
		AI_Output (self, other, "DIA_Addon_Tom_PERM_11_02");	//Now I can finally show my face in the camp again!
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Tom_PERM_11_03");	//Else? Else I'll sit here counting rocks...
	};
};

