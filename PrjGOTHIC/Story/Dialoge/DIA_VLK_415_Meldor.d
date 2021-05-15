
instance DIA_Meldor_EXIT(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 999;
	condition = DIA_Meldor_EXIT_Condition;
	information = DIA_Meldor_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Meldor_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Meldor_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Meldor_Hallo(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 2;
	condition = DIA_Meldor_Hallo_Condition;
	information = DIA_Meldor_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Meldor_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		if((Lehmar_GeldGeliehen_Day > (Wld_GetDay() - 2)) || (Lehmar_GeldGeliehen == 0) || (RangerHelp_LehmarKohle == TRUE))
		{
			return TRUE;
		};
	};
};

func void DIA_Meldor_Hallo_Info()
{
	AI_Output (self, other, "DIA_Meldor_Hallo_07_00");	//What do you want?
	AI_Output (other, self, "DIA_Meldor_Hallo_15_01");	//I wanted to have a look around here ...
	AI_Output (self, other, "DIA_Meldor_Hallo_07_02");	//And where exactly are you headed?
};


var int MeldorToldAboutLehmar;

instance DIA_Meldor_Interessantes(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 2;
	condition = DIA_Meldor_Interessantes_Condition;
	information = DIA_Meldor_Interessantes_Info;
	permanent = FALSE;
	description = "What interesting things are there to see here?";
};


func int DIA_Meldor_Interessantes_Condition()
{
	return TRUE;
};

func void DIA_Meldor_Interessantes_Info()
{
	AI_Output (other, self, "DIA_Meldor_Interessantes_15_00");	//What interesting things are there to see here?
	AI_Output (self, other, "DIA_Meldor_Interessantes_07_01");	//There's a cathouse here, and a pub. The landlord's name is Kardif. If it's information you want, he'll be the right person to talk to.
	if(!Npc_KnowsInfo(other,DIA_Kardif_Hallo))
	{
		Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
		B_LogEntry(TOPIC_CityTrader,"Кардиф, владелец кабака в гавани, приторговывает информацией.");
	};
	if(!Npc_IsDead(Lehmar) && (Lehmar_GeldGeliehen == 0))
	{
		AI_Output(self,other,"DIA_Meldor_Interessantes_07_02");	//Тебе, кстати, не нужны деньги?
	AI_Output (other, self, "DIA_Meldor_Lehmar_15_00");	//Are you giving it away?
	AI_Output (self, other, "DIA_Meldor_Lehmar_07_01");	//(bored) No. But right across the street here is the house of Lehmar, the moneylender.
	AI_Output (self, other, "DIA_Meldor_Lehmar_07_02");	//I'm sure he'll give you a few gold pieces, just go ahead.
		MeldorToldAboutLehmar = TRUE;
	};
};


instance DIA_Meldor_Arbeitest(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 4;
	condition = DIA_Meldor_Arbeitest_Condition;
	information = DIA_Meldor_Arbeitest_Info;
	permanent = FALSE;
	description = "Do you work for Lehmar?";
};


func int DIA_Meldor_Arbeitest_Condition()
{
	if((MeldorToldAboutLehmar == TRUE) && !Npc_IsDead(Lehmar) && !Npc_KnowsInfo(other,DIA_Meldor_VonLehmar))
	{
		return TRUE;
	};
};

func void DIA_Meldor_Arbeitest_Info()
{
	AI_Output (other, self, "DIA_Meldor_Arbeitest_15_00");	//Do you work for Lehmar?
	AI_Output (self, other, "DIA_Meldor_Arbeitest_07_01");	//Smart kid.
};


instance DIA_Meldor_InsOV(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 5;
	condition = DIA_Meldor_InsOV_Condition;
	information = DIA_Meldor_InsOV_Info;
	permanent = FALSE;
	description = "Actually, I was on my way to the upper quarter ...";
};


func int DIA_Meldor_InsOV_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Meldor_Hallo) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Meldor_InsOV_Info()
{
	AI_Output (other, self, "DIA_Meldor_InsOV_15_00");	//Actually, I was on my way to the upper quarter ...
	AI_Output (self, other, "DIA_Meldor_InsOV_07_01");	//(sarcastically) Yeah, right. And I was about to board a ship and have it take me to the King for an audience.
	AI_Output (self, other, "DIA_Meldor_InsOV_07_02");	//People like you and me haven't been allowed in the upper quarter since the paladins came.
};


instance DIA_Meldor_Citizen(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 6;
	condition = DIA_Meldor_Citizen_Condition;
	information = DIA_Meldor_Citizen_Info;
	permanent = FALSE;
	description = "Are you a citizen of this town?";
};


func int DIA_Meldor_Citizen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Meldor_InsOV) || (other.guild != GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Meldor_Citizen_Info()
{
	AI_Output (other, self, "DIA_Meldor_Citizen_15_00");	//Are you a citizen of this town?
	AI_Output (self, other, "DIA_Meldor_Citizen_07_01");	//If you mean, do I live here - yes. But still they won't let me into the upper quarter.
	AI_Output (self, other, "DIA_Meldor_Citizen_07_02");	//Only the toffs can get in there, or the merchants and craftsmen from the lower end of town.
	AI_Output (self, other, "DIA_Meldor_Citizen_07_03");	//The people from the harbor district don't carry much weight in Khorinis. There isn't even a regular militia patrol down here.
};


instance DIA_Meldor_Smoke(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 5;
	condition = DIA_Meldor_Smoke_Condition;
	information = DIA_Meldor_Smoke_Info;
	permanent = FALSE;
	description = "Do you know where I can buy some weed?";
};


func int DIA_Meldor_Smoke_Condition()
{
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Meldor_Smoke_Info()
{
	AI_Output(other,self,"DIA_Meldor_Smoke_15_00");	//Do you know where I can buy some weed?
	if(Meldor_Busted == TRUE)
	{
		AI_Output(self,other,"DIA_Meldor_Smoke_07_01");	//(appraisingly) Nope, no idea.
		Undercover_Failed_Meldor = TRUE;
		B_CheckRedLightUndercover();
	}
	else
	{
		AI_Output (self, other, "DIA_Meldor_Smoke_07_02");	//If I were you, I'd try my luck in the 'Red Lantern'.
	};
};


var int Meldor_ThievesNews1;
var int Meldor_ThievesNews2;
var int Meldor_DragonsNews1;
var int Meldor_DragonsNews2;

instance DIA_Meldor_PERM(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 7;
	condition = DIA_Meldor_PERM_Condition;
	information = DIA_Meldor_PERM_Info;
	permanent = TRUE;
	description = "Has anything exciting happened here lately?";
};


func int DIA_Meldor_PERM_Condition()
{
	return TRUE;
};

func void DIA_Meldor_PERM_Info()
{
	AI_Output(other,self,"DIA_Meldor_PERM_15_00");	//Has anything exciting happened lately?
	if((Andre_FoundThieves_KilledByMilitia == FALSE) && (Meldor_ThievesNews1 == FALSE))
	{
		AI_Output (self, other, "DIA_Meldor_PERM_07_01");	//Not long ago, the city guards turned the entire harbor district upside down.
		AI_Output (self, other, "DIA_Meldor_PERM_07_02");	//They were searching for stolen property. There have been plenty of thefts here lately. Especially in the better quarters.
		AI_Output (self, other, "DIA_Meldor_PERM_07_03");	//They're obviously trying to blame the poor suckers at the harbor for everything.
		Meldor_ThievesNews1 = TRUE;
	}
	else if((Andre_FoundThieves_KilledByMilitia == TRUE) && (Meldor_ThievesNews2 == FALSE))
	{
		AI_Output(self,other,"DIA_Meldor_PERM_07_04");	//I've heard they broke up a gang of thieves down in the sewers. The thieves were all killed.
		Meldor_ThievesNews2 = TRUE;
	}
	else if(((Kapitel == 3) || (Kapitel == 4)) && (Meldor_DragonsNews1 == FALSE))
	{
		AI_Output(self,other,"DIA_Meldor_PERM_07_05");	//They say there are dragons in the Valley of Mines. I'm curious to see when the paladins will set out from here to fight them.
		Meldor_DragonsNews1 = TRUE;
	}
	else if((Kapitel == 5) && (Meldor_DragonsNews2 == FALSE))
	{
		AI_Output(self,other,"DIA_Meldor_PERM_07_06");	//Reportedly, the dragons are all dead. Someone must have swept there with an iron broom.
		Meldor_DragonsNews2 = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Meldor_PERM_07_07");	//No.
	};
};


instance DIA_Meldor_VonLehmar(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 1;
	condition = DIA_Meldor_VonLehmar_Condition;
	information = DIA_Meldor_VonLehmar_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Meldor_VonLehmar_Condition()
{
	if((Lehmar_GeldGeliehen_Day <= (Wld_GetDay() - 2)) && (Lehmar_GeldGeliehen != 0) && (RangerHelp_LehmarKohle == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Meldor_VonLehmar_Info()
{
	AI_Output (self, other, "DIA_Meldor_VonLehmar_07_00");	//Hey, wait up ...
	AI_Output (self, other, "DIA_Meldor_VonLehmar_07_01");	//I have a message for you from Lehmar ...
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};


instance DIA_Meldor_PICKPOCKET(C_Info)
{
	npc = VLK_415_Meldor;
	nr = 900;
	condition = DIA_Meldor_PICKPOCKET_Condition;
	information = DIA_Meldor_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Meldor_PICKPOCKET_Condition()
{
	return C_Beklauen(34,55);
};

func void DIA_Meldor_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Meldor_PICKPOCKET);
	Info_AddChoice(DIA_Meldor_PICKPOCKET,Dialog_Back,DIA_Meldor_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Meldor_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Meldor_PICKPOCKET_DoIt);
};

func void DIA_Meldor_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Meldor_PICKPOCKET);
};

func void DIA_Meldor_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Meldor_PICKPOCKET);
};

