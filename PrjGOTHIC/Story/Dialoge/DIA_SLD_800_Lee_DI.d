
instance DIA_Lee_DI_EXIT(C_Info)
{
	npc = SLD_800_Lee_DI;
	nr = 999;
	condition = DIA_Lee_DI_EXIT_Condition;
	information = DIA_Lee_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Lee_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Lee_DI_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Lee_DI_Hallo(C_Info)
{
	npc = SLD_800_Lee_DI;
	nr = 2;
	condition = DIA_Lee_DI_Hallo_Condition;
	information = DIA_Lee_DI_Hallo_Info;
	description = "What job will you take over?";
};


func int DIA_Lee_DI_Hallo_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Lee_DI_Hallo_Info()
{
	AI_Output (other, self, "DIA_Lee_DI_Hallo_15_00");	//What job will you take over?
	AI_Output (self, other, "DIA_Lee_DI_Hallo_04_01");	//Someone has to watch the ship. I'll stay here and make sure that it's still around when you come back.
};


instance DIA_Lee_DI_PERM6(C_Info)
{
	npc = SLD_800_Lee_DI;
	nr = 2;
	condition = DIA_Lee_DI_PERM6_Condition;
	information = DIA_Lee_DI_PERM6_Info;
	permanent = TRUE;
	description = "How's my ship?";
};


func int DIA_Lee_DI_PERM6_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && Npc_KnowsInfo(other,DIA_Lee_DI_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Lee_DI_PERM6_Info()
{
	AI_Output(other,self,"DIA_Lee_DI_PERM6_15_00");	//How's my ship?
	if(OrkSturmDI == FALSE)
	{
		AI_Output (self, other, "DIA_Lee_DI_PERM6_04_01");	//Don't worry. I've got everything under control.
	}
	else
	{
		AI_Output (self, other, "DIA_Lee_DI_PERM6_04_02");	//Everything's fine. Those miserable orcs are welcome to come back any time. Then they'll get their next hiding.
	};
	AI_StopProcessInfos(self);
};


var int DIA_Lee_DI_Teacher_permanent;
var int DIA_Lee_DI_TeachState_1H;
var int DIA_Lee_DI_TeachState_2H;

func void B_BuildLearnDialog_Lee_DI()
{
	Info_ClearChoices(DIA_Lee_DI_Teach);
	Info_AddChoice(DIA_Lee_DI_Teach,Dialog_Back,DIA_Lee_DI_Teach_Back);
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Lee)
	{
		Info_AddChoice(DIA_Lee_DI_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Lee_DI_Teach_2H_1);
		Info_AddChoice(DIA_Lee_DI_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Lee_DI_Teach_2H_5);
		DIA_Lee_DI_TeachState_2H = 1;
	}
	else
	{
		if((DIA_Lee_DI_TeachState_2H == 1) && (DIA_Lee_DI_TeachState_1H != 2))
		{
			PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
			B_Henry_NoMore_2H();
		};
		DIA_Lee_DI_TeachState_2H = 2;
	};
	if(VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Lee)
	{
		Info_AddChoice(DIA_Lee_DI_Teach,B_BuildLearnString(PRINT_Learn1h1,B_GetLearnCostTalent(other,NPC_TALENT_1H,1)),DIA_Lee_DI_Teach_1H_1);
		Info_AddChoice(DIA_Lee_DI_Teach,B_BuildLearnString(PRINT_Learn1h5,B_GetLearnCostTalent(other,NPC_TALENT_1H,5)),DIA_Lee_DI_Teach_1H_5);
		DIA_Lee_DI_TeachState_1H = 1;
	}
	else
	{
		if((DIA_Lee_DI_TeachState_1H == 1) && (DIA_Lee_DI_TeachState_2H != 2))
		{
			PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
			B_Say(self,other,"$NOLEARNYOUREBETTER");
		};
		DIA_Lee_DI_TeachState_1H = 2;
	};
	if((RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Lee) && (RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Lee))
	{
		DIA_Lee_DI_Teacher_permanent = TRUE;
	};
	if((DIA_Lee_DI_TeachState_1H == 2) && (DIA_Lee_DI_TeachState_2H == 2))
	{
		PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
		B_Henry_NoMoreTeach();
		AI_StopProcessInfos(self);
	};
};

instance DIA_Lee_DI_Teach(C_Info)
{
	npc = SLD_800_Lee_DI;
	nr = 10;
	condition = DIA_Lee_DI_Teach_Condition;
	information = DIA_Lee_DI_Teach_Info;
	permanent = TRUE;
	description = "I need training.";
};


func int DIA_Lee_DI_Teach_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (DIA_Lee_DI_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lee_DI_Teach_Info()
{
	AI_Output(other,self,"DIA_Lee_DI_Teach_15_00");	//I need some training.
	if((VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Lee) && (VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Lee))
	{
		if((VisibleTalentValue(NPC_TALENT_1H) <= 30) || (VisibleTalentValue(NPC_TALENT_2H) <= 30))
		{
			AI_Output(self,other,"DIA_Lee_DI_Teach_1H_1_04_00");	//Your defense is terrible, but it will have to do somehow.
		};
		AI_Output(self,other,"DIA_Lee_DI_Teach_04_01");	//What exactly do you want to train?
	};
	B_BuildLearnDialog_Lee_DI();
};

func void DIA_Lee_DI_Teach_1H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,1,TeachLimit_1H_Lee))
	{
		B_Lee_CommentFightSkill();
		B_BuildLearnDialog_Lee_DI();
	};
};

func void DIA_Lee_DI_Teach_1H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,5,TeachLimit_1H_Lee))
	{
		B_Lee_CommentFightSkill();
		B_BuildLearnDialog_Lee_DI();
	};
};

func void DIA_Lee_DI_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Lee))
	{
		B_Lee_CommentFightSkill();
		B_BuildLearnDialog_Lee_DI();
	};
};

func void DIA_Lee_DI_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Lee))
	{
		B_Lee_CommentFightSkill();
		B_BuildLearnDialog_Lee_DI();
	};
};

func void DIA_Lee_DI_Teach_Back()
{
	Info_ClearChoices(DIA_Lee_DI_Teach);
};

var int DIA_Lee_DI_UndeadDragonDead_OneTime;

instance DIA_Lee_DI_UndeadDragonDead(C_Info)
{
	npc = SLD_800_Lee_DI;
	nr = 2;
	condition = DIA_Lee_DI_UndeadDragonDead_Condition;
	information = DIA_Lee_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "We can be on our way now.";
};


func int DIA_Lee_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Lee_DI_UndeadDragonDead_Info()
{
	AI_Output (other, self, "DIA_Lee_DI_UndeadDragonDead_15_00");	//We can be on our way now. The enemy's dead.
	AI_Output (self, other, "DIA_Lee_DI_UndeadDragonDead_04_01");	//Very good. Then tell the captain to weigh anchor.
	if ((DIA_Lee_DI_UndeadDragonDead_OneTime == FALSE) && (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Lee_DI_UndeadDragonDead_04_02");	//You'll take me to the mainland, won't you?
		AI_Output (other, self, "DIA_Lee_DI_UndeadDragonDead_15_03");	//Yes. Khorinis will survive without you.
		AI_Output (self, other, "DIA_Lee_Add_04_26");	//Then I can finally pay my long delayed visit to the King.
		AI_Output (self, other, "DIA_Lee_Add_04_27");	//I've waited a long time for this...
		AI_Output (self, other, "DIA_Lee_DI_UndeadDragonDead_04_05");	//What do you think? Shouldn't patience finally be rewarded?
		AI_Output (other, self, "DIA_Lee_DI_UndeadDragonDead_15_06");	//Patience and some striking arguments.
		AI_Output (self, other, "DIA_Lee_DI_UndeadDragonDead_04_07");	//(laughs) Yeah. It won't work without a bit of armed force. It was an honor going into battle with you.
		DIA_Lee_DI_UndeadDragonDead_OneTime = TRUE;
	};
	AI_Output (self, other, "DIA_Lee_DI_UndeadDragonDead_04_08");	//May our paths cross again some day after this adventure.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Start");
};


instance DIA_Lee_DI_PICKPOCKET(C_Info)
{
	npc = SLD_800_Lee_DI;
	nr = 900;
	condition = DIA_Lee_DI_PICKPOCKET_Condition;
	information = DIA_Lee_DI_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_120;
};


func int DIA_Lee_DI_PICKPOCKET_Condition()
{
	return C_Beklauen(110,570);
};

func void DIA_Lee_DI_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Lee_DI_PICKPOCKET);
	Info_AddChoice(DIA_Lee_DI_PICKPOCKET,Dialog_Back,DIA_Lee_DI_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Lee_DI_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Lee_DI_PICKPOCKET_DoIt);
};

func void DIA_Lee_DI_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Lee_DI_PICKPOCKET);
};

func void DIA_Lee_DI_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Lee_DI_PICKPOCKET);
};

