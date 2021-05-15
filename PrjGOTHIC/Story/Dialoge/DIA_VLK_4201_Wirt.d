
instance DIA_Wirt_EXIT(C_Info)
{
	npc = VLK_4201_Wirt;
	nr = 999;
	condition = DIA_Wirt_EXIT_Condition;
	information = DIA_Wirt_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Wirt_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Wirt_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Wirt_PICKPOCKET(C_Info)
{
	npc = VLK_4201_Wirt;
	nr = 900;
	condition = DIA_Wirt_PICKPOCKET_Condition;
	information = DIA_Wirt_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Wirt_PICKPOCKET_Condition()
{
	return C_Beklauen(60,65);
};

func void DIA_Wirt_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Wirt_PICKPOCKET);
	Info_AddChoice(DIA_Wirt_PICKPOCKET,Dialog_Back,DIA_Wirt_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Wirt_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Wirt_PICKPOCKET_DoIt);
};

func void DIA_Wirt_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Wirt_PICKPOCKET);
};

func void DIA_Wirt_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Wirt_PICKPOCKET);
};

/*func void B_GiveBeer(var int DailyQuantity)
{
	var int Wirt_GiveBeer_Day;
	var int Beer_Count;
	if(Wld_GetDay() != 0)
	{
		if((Beer_Count < DailyQuantity) && (Wirt_GiveBeer_Day != Wld_GetDay()))
		{
			B_GiveInvItems(self,other,ItFo_Beer,1);
			Beer_Count += 1;
		};
		if(Beer_Count >= DailyQuantity)
		{
			Wirt_GiveBeer_Day = Wld_GetDay();
			Beer_Count = 0;
		};
	}
	else
	{
		if((Beer_Count < DailyQuantity) && (Wirt_GiveBeer_Day != 999))
		{
			B_GiveInvItems(self,other,ItFo_Beer,1);
			Beer_Count += 1;
		};
		if(Beer_Count >= DailyQuantity)
		{
			Wirt_GiveBeer_Day = 999;
			Beer_Count = 0;
		};
	};
};*/

var int Wirt_GiveBeer_Day;
var int Wirt_GiveBeer_Day_Zero_OneTime;

instance DIA_Wirt_Hallo(C_Info)
{
	npc = VLK_4201_Wirt;
	nr = 2;
	condition = DIA_Wirt_Hallo_Condition;
	information = DIA_Wirt_Hallo_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Wirt_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Wirt_Hallo_Info()
{
	var int randy;
	if(other.guild == GIL_PAL)
	{
		randy = Hlp_Random(3);
	}
	else
	{
		randy = Hlp_Random(4);
	};
	if(((Wld_GetDay() == 0) && (Wirt_GiveBeer_Day_Zero_OneTime == FALSE)) || (Wirt_GiveBeer_Day < Wld_GetDay()))
	{
		AI_Output(self,other,"DIA_Wirt_Hallo_14_00");	//Hey, come closer. Take a break and have a sip of cool beer.
		B_GiveInvItems(self,other,ItFo_Beer,1);
		Wirt_GiveBeer_Day = B_GetDayPlus();
		Wirt_GiveBeer_Day_Zero_OneTime = TRUE;
	};
	if(randy == 0)
	{
		AI_Output(self,other,"DIA_Wirt_Hallo_14_02");	//Nothing hits the spot like a cool pint after work.
	}
	else if(randy == 1)
	{
		AI_Output(self,other,"DIA_Wirt_Hallo_14_01");	//Lord Andre is springing for a few barrels of free beer.
	}
	else if(randy == 2)
	{
		AI_Output(self,other,"DIA_Wirt_Hallo_14_04");	//You can say what you want about Khorinis, but our 'Dark Paladine' is simply the best in all of Myrtana.
	}
	else if(randy == 3)
	{
		AI_Output(self,other,"DIA_Wirt_Hallo_14_03");	//The paladins will set everything right. So take another draught and have a good time.
	};
	if(!Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) || (self.aivar[AIV_PlayerHasPickedMyPocket] == TRUE))
	{
		AI_StopProcessInfos(self);
	}
	else if(Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) && (other.attribute[ATR_DEXTERITY] < 50))
	{
		AI_StopProcessInfos(self);
	};
};

