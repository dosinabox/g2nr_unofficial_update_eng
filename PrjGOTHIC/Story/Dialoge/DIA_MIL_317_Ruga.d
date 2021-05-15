
instance DIA_Ruga_EXIT(C_Info)
{
	npc = MIL_317_Ruga;
	nr = 999;
	condition = DIA_Ruga_EXIT_Condition;
	information = DIA_Ruga_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Ruga_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Ruga_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Ruga_PICKPOCKET(C_Info)
{
	npc = MIL_317_Ruga;
	nr = 900;
	condition = DIA_Ruga_PICKPOCKET_Condition;
	information = DIA_Ruga_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40_Key;
};


func int DIA_Ruga_PICKPOCKET_Condition()
{
//	return C_StealItems(40,Hlp_GetInstanceID(ItKe_City_Tower_03),1);
	if(Npc_HasItems(self,ItKe_City_Tower_03))
	{
		return C_StealItem(40);
	};
	return FALSE;
};

func void DIA_Ruga_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Ruga_PICKPOCKET);
	Info_AddChoice(DIA_Ruga_PICKPOCKET,Dialog_Back,DIA_Ruga_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Ruga_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Ruga_PICKPOCKET_DoIt);
};

func void DIA_Ruga_PICKPOCKET_DoIt()
{
//	B_StealItems(40,Hlp_GetInstanceID(ItKe_City_Tower_03),1);
	B_StealItem(40,Hlp_GetInstanceID(ItKe_City_Tower_03));
	Info_ClearChoices(DIA_Ruga_PICKPOCKET);
};

func void DIA_Ruga_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Ruga_PICKPOCKET);
};


instance DIA_Ruga_Hallo(C_Info)
{
	npc = MIL_317_Ruga;
	nr = 2;
	condition = DIA_Ruga_Hallo_Condition;
	information = DIA_Ruga_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ruga_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Ruga_Hallo_Info()
{
	AI_Output (other, self, "DIA_Ruga_Hallo_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Ruga_Hallo_11_01");	//I'm training the boys to use a crossbow and help them become a little more dexterous.
};


instance DIA_Ruga_Train(C_Info)
{
	npc = MIL_317_Ruga;
	nr = 5;
	condition = DIA_Ruga_Train_Condition;
	information = DIA_Ruga_Train_Info;
	permanent = TRUE;
	description = "Could you train me?";
};


func int DIA_Ruga_Train_Condition()
{
	if(Ruga_TeachCrossbow == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Ruga_Train_Info()
{
	AI_Output(other,self,"DIA_Ruga_Train_15_00");	//Could you train me?
	B_Ruga_Teach_Log();
	if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL) || (hero.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Ruga_Train_11_01");	//Sure thing. If you have enough experience, I can help you.
		AI_Output (self, other, "DIA_Ruga_Train_11_02");	//Always remember, dexterity and long-range combat belong together like crossbow and bolt. The one ...
		AI_Output (other, self, "DIA_Ruga_Train_15_03");	//... isn't worth a thing without the other. I understand.
		Ruga_TeachCrossbow = TRUE;
		Ruga_TeachDEX = TRUE;
	}
	else if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output(self,other,"DIA_Ruga_Train_11_04");	//Get out of my sight, (contemptuously) mercenary.
		AI_StopProcessInfos(self);
	}
	else if(hero.guild == GIL_NOV)
	{
		B_Say(self,other,"$NOLEARNNOPOINTS");
	}
	else
	{
		AI_Output (self, other, "DIA_Ruga_Train_11_05");	//No, I only train the men in the service of the King. Nobody else.
		AI_Output (self, other, "DIA_Ruga_Train_11_06");	//But we can always use good people. So, if you want to joint the militia, go talk to Lord Andre.
	};
};


var int DIA_Ruga_Teach_permanent;

func void B_BuildLearnDialog_Ruga()
{
	if(VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Ruga)
	{
		Info_ClearChoices(DIA_Ruga_Teach);
		Info_AddChoice(DIA_Ruga_Teach,Dialog_Back,DIA_Ruga_Teach_Back);
		Info_AddChoice(DIA_Ruga_Teach,B_BuildLearnString(PRINT_LearnCrossBow1,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,1)),DIA_Ruga_Teach_CROSSBOW_1);
		Info_AddChoice(DIA_Ruga_Teach,B_BuildLearnString(PRINT_LearnCrossBow5,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,5)),DIA_Ruga_Teach_CROSSBOW_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_CROSSBOW) >= TeachLimit_Crossbow_Ruga)
		{
			DIA_Ruga_Teach_permanent = TRUE;
		};
		PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_Crossbow_Ruga)),-1,53,FONT_Screen,2);
		AI_Output(self,other,"DIA_Ruga_Teach_11_00");	//There is nothing more that I could teach you. It is time that you found yourself another teacher.
		AI_StopProcessInfos(self);
	};
};

instance DIA_Ruga_Teach(C_Info)
{
	npc = MIL_317_Ruga;
	nr = 100;
	condition = DIA_Ruga_Teach_Condition;
	information = DIA_Ruga_Teach_Info;
	permanent = TRUE;
	description = "Show me how to use a crossbow.";
};


func int DIA_Ruga_Teach_Condition()
{
	if((Ruga_TeachCrossbow == TRUE) && (DIA_Ruga_Teach_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Ruga_Teach_Info()
{
	AI_Output(other,self,"DIA_Ruga_Teach_15_00");	//Show me how to use a crossbow.
	B_BuildLearnDialog_Ruga();
};

func void DIA_Ruga_Teach_Back()
{
	Info_ClearChoices(DIA_Ruga_Teach);
};

func void DIA_Ruga_Teach_CROSSBOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,1,TeachLimit_Crossbow_Ruga))
	{
		B_BuildLearnDialog_Ruga();
	};
};

func void DIA_Ruga_Teach_CROSSBOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,5,TeachLimit_Crossbow_Ruga))
	{
		B_BuildLearnDialog_Ruga();
	};
};

var int DIA_Ruga_TEACHDEX_permanent;

func void B_BuildLearnDialog_Ruga_DEX()
{
	if(other.aivar[REAL_DEXTERITY] >= T_HIGH)
	{
		AI_Output(self,other,"DIA_Ruga_TEACHDEX_11_00");	//This is all I can teach you. If you want to become more dexterous, go find a different teacher.
		DIA_Ruga_TEACHDEX_permanent = TRUE;
	}
	else
	{
		Info_ClearChoices(DIA_Ruga_TEACHDEX);
		Info_AddChoice(DIA_Ruga_TEACHDEX,Dialog_Back,DIA_Ruga_TEACHDEX_BACK);
		Info_AddChoice(DIA_Ruga_TEACHDEX,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_Ruga_TEACHDEX_1);
		Info_AddChoice(DIA_Ruga_TEACHDEX,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_Ruga_TEACHDEX_5);
	};
};

instance DIA_Ruga_TEACHDEX(C_Info)
{
	npc = MIL_317_Ruga;
	nr = 101;
	condition = DIA_Ruga_TEACHDEX_Condition;
	information = DIA_Ruga_TEACHDEX_Info;
	permanent = TRUE;
	description = "I want to become more dexterous.";
};


func int DIA_Ruga_TEACHDEX_Condition()
{
	if((Ruga_TeachDEX == TRUE) && (DIA_Ruga_TEACHDEX_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Ruga_TEACHDEX_Info()
{
	AI_Output(other,self,"DIA_Ruga_TEACHDEX_15_00");	//I want to become more dexterous.
	B_BuildLearnDialog_Ruga_DEX();
};

func void DIA_Ruga_TEACHDEX_BACK()
{
	Info_ClearChoices(DIA_Ruga_TEACHDEX);
};

func void DIA_Ruga_TEACHDEX_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_HIGH))
	{
		B_BuildLearnDialog_Ruga_DEX();
	};
};

func void DIA_Ruga_TEACHDEX_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_HIGH))
	{
		B_BuildLearnDialog_Ruga_DEX();
	};
};

