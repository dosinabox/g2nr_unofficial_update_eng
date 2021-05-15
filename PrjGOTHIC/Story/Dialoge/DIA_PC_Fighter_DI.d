
instance DIA_Gorn_DI_KAP5_EXIT(C_Info)
{
	npc = PC_Fighter_DI;
	nr = 999;
	condition = DIA_Gorn_DI_KAP5_EXIT_Condition;
	information = DIA_Gorn_DI_KAP5_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Gorn_DI_KAP5_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Gorn_DI_KAP5_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Gorn_DI_First(C_Info)
{
	npc = PC_Fighter_DI;
	nr = 1;
	condition = DIA_Gorn_DI_First_Condition;
	information = DIA_Gorn_DI_First_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Gorn_DI_First_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (OrkSturmDI == FALSE) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Gorn_DI_First_Info()
{
	AI_Output(self,other,"INTRO_DiegoGorn_12_04");	//The ground!
};


instance DIA_Gorn_DI_Hallo(C_Info)
{
	npc = PC_Fighter_DI;
	nr = 2;
	condition = DIA_Gorn_DI_Hallo_Condition;
	information = DIA_Gorn_DI_Hallo_Info;
	permanent = TRUE;
	description = "Everything ship-shape?";
};


func int DIA_Gorn_DI_Hallo_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Gorn_DI_Hallo_Info()
{
	AI_Output(other,self,"DIA_Gorn_DI_Hallo_15_00");	//Everything ship-shape?
	if(OrkSturmDI == FALSE)
	{
		AI_Output (self, other, "DIA_Gorn_DI_Hallo_12_01");	//Up to now. Remember, I want to see some action.
	}
	else
	{
		AI_Output (self, other, "DIA_Gorn_DI_Hallo_12_02");	//Are there more orcs up there? Send them to me. I just got warmed up.
	};
};


var int DIA_Gorn_DI_Teacher_permanent;
var int DIA_Gorn_DI_Teacher_Comment;

func void B_BuildLearnDialog_Gorn_DI()
{
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Gorn)
	{
		Info_ClearChoices(DIA_Gorn_DI_Teach);
		Info_AddChoice(DIA_Gorn_DI_Teach,Dialog_Back,DIA_Gorn_DI_Teach_Back);
		Info_AddChoice(DIA_Gorn_DI_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Gorn_DI_Teach_2H_1);
		Info_AddChoice(DIA_Gorn_DI_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Gorn_DI_Teach_2H_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Gorn)
		{
			DIA_Gorn_DI_Teacher_permanent = TRUE;
		};
		PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

instance DIA_Gorn_DI_Teach(C_Info)
{
	npc = PC_Fighter_DI;
	nr = 10;
	condition = DIA_Gorn_DI_Teach_Condition;
	information = DIA_Gorn_DI_Teach_Info;
	permanent = TRUE;
	description = "I need training.";
};


func int DIA_Gorn_DI_Teach_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (DIA_Gorn_DI_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Gorn_DI_Teach_Info()
{
	AI_Output(other,self,"DIA_Gorn_DI_Teach_15_00");	//I need training.
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Gorn)
	{
		if(DIA_Gorn_DI_Teacher_Comment == 0)
		{
			AI_Output(self,other,"DIA_Gorn_DI_Teach_12_01");	//Can't hurt.
			DIA_Gorn_DI_Teacher_Comment = 1;
		}
		else if(DIA_Gorn_DI_Teacher_Comment == 1)
		{
			AI_Output(self,other,"DIA_Gorn_DI_Teach_2H_1_12_00");	//Well. You used to be better than that.
			DIA_Gorn_DI_Teacher_Comment = 2;
		}
		else if(DIA_Gorn_DI_Teacher_Comment == 2)
		{
			AI_Output(self,other,"DIA_Gorn_DI_Teach_2H_5_12_00");	//You have to hold your weapon higher. A blind man could get through your guard with his cane.
			DIA_Gorn_DI_Teacher_Comment = 0;
		};
	};
	B_BuildLearnDialog_Gorn_DI();
};

func void DIA_Gorn_DI_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Gorn))
	{
		B_BuildLearnDialog_Gorn_DI();
	};
};

func void DIA_Gorn_DI_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Gorn))
	{
		B_BuildLearnDialog_Gorn_DI();
	};
};

func void DIA_Gorn_DI_Teach_Back()
{
	Info_ClearChoices(DIA_Gorn_DI_Teach);
};

var int DIA_Gorn_DI_UndeadDragonDead_OneTime;

instance DIA_Gorn_DI_UndeadDragonDead(C_Info)
{
	npc = PC_Fighter_DI;
	nr = 2;
	condition = DIA_Gorn_DI_UndeadDragonDead_Condition;
	information = DIA_Gorn_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "You stayed with the ship?";
};


func int DIA_Gorn_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Gorn_DI_UndeadDragonDead_Info()
{
	AI_Output (other, self, "DIA_Gorn_DI_UndeadDragonDead_15_00");	//You stayed with the ship?
	AI_Output (self, other, "DIA_Gorn_DI_UndeadDragonDead_12_01");	//Sure I did. Just imagine what we'd do if it weren't there any more.
	if((hero.guild == GIL_DJG) && (DIA_Gorn_DI_UndeadDragonDead_OneTime == FALSE))
	{
		AI_Output (self, other, "DIA_Gorn_DI_UndeadDragonDead_12_02");	//Now what happens?
		AI_Output (other, self, "DIA_Gorn_DI_UndeadDragonDead_15_03");	//Nothing more. I want to go home.
		AI_Output (self, other, "DIA_Gorn_DI_UndeadDragonDead_12_04");	//(laughs) Home? Where's that? As far as I know, there's no such thing for you.
		AI_Output (self, other, "DIA_Gorn_DI_UndeadDragonDead_12_05");	//Let me make a suggestion. We storm the next tavern and drink ourselves senseless.
		AI_Output (other, self, "DIA_Gorn_DI_UndeadDragonDead_15_06");	//Mmh. Maybe.
		AI_Output (self, other, "DIA_Gorn_DI_UndeadDragonDead_12_07");	//Hey, come off it, man. It's over.
		DIA_Gorn_DI_UndeadDragonDead_OneTime = TRUE;
	};
	AI_Output(self,other,"DIA_Gorn_DI_UndeadDragonDead_12_10");	//There's nothing left here for us. Tell the captain to clear the ship.
	if(Npc_KnowsInfo(other,DIA_Biff_DI_UNDEADDRGDEAD))
	{
		AI_Output(self,other,"DIA_Gorn_DI_UndeadDragonDead_12_08");	//Somebody still needs to tell Biff, otherwise he'll rot on this island.
		if(!Npc_IsDead(Biff_DI))
		{
			AI_Output (other, self, "DIA_Gorn_DI_UndeadDragonDead_15_09");	//He'll be here in time.
		};
	};
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Start");
};


instance DIA_Fighter_DI_PICKPOCKET(C_Info)
{
	npc = PC_Fighter_DI;
	nr = 900;
	condition = DIA_Fighter_DI_PICKPOCKET_Condition;
	information = DIA_Fighter_DI_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Fighter_DI_PICKPOCKET_Condition()
{
	return C_Beklauen(10,45);
};

func void DIA_Fighter_DI_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Fighter_DI_PICKPOCKET);
	Info_AddChoice(DIA_Fighter_DI_PICKPOCKET,Dialog_Back,DIA_Fighter_DI_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Fighter_DI_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Fighter_DI_PICKPOCKET_DoIt);
};

func void DIA_Fighter_DI_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Fighter_DI_PICKPOCKET);
};

func void DIA_Fighter_DI_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Fighter_DI_PICKPOCKET);
};


