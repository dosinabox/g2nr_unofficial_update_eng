
instance DIA_Wolf_DI_EXIT(C_Info)
{
	npc = SLD_811_Wolf_DI;
	nr = 999;
	condition = DIA_Wolf_DI_EXIT_Condition;
	information = DIA_Wolf_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Wolf_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Wolf_DI_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Wolf_DI_HALLO(C_Info)
{
	npc = SLD_811_Wolf_DI;
	nr = 4;
	condition = DIA_Wolf_DI_HALLO_Condition;
	information = DIA_Wolf_DI_HALLO_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_Wolf_DI_HALLO_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};


var int DIA_Wolf_DI_HALLO_OneTime;

func void DIA_Wolf_DI_HALLO_Info()
{
	AI_Output(other,self,"DIA_Wolf_DI_HALLO_15_00");	//How's it going?
	if((Bennet_IsOnBoard == LOG_SUCCESS) && !Npc_IsDead(Bennet_DI))
	{
		AI_Output (self, other, "DIA_Wolf_DI_HALLO_08_01");	//Did you HAVE to take Bennet along, man?
		AI_Output (other, self, "DIA_Wolf_DI_HALLO_15_02");	//What's the problem?
		AI_Output (self, other, "DIA_Wolf_DI_HALLO_08_03");	//Ah, nothing. It's all right. Do your job and then get out of here, okay?
	}
	else if(DIA_Wolf_DI_HALLO_OneTime == FALSE)
	{
		AI_Output(self,other,"DIA_Wolf_DI_HALLO_08_04");	//The smithy isn't the best, but I think I'll give it a try.
		B_GivePlayerXP(XP_AmbientKap6);
		DIA_Wolf_DI_HALLO_OneTime = TRUE;
		AI_StopProcessInfos(self);
		Npc_ExchangeRoutine(self,"SmithDI");
	}
	else
	{
		AI_Output (other, self, "DIA_Wolf_DI_HALLO_15_05");	//Could you build me some armor?
		AI_Output (self, other, "DIA_Wolf_DI_HALLO_08_06");	//Sorry, man. Not with these tools. That'll have to wait until we're on the mainland.
	};
};


var int DIA_Wolf_DI_Teacher_permanent;

func void B_BuildLearnDialog_Wolf_DI()
{
	Info_ClearChoices(DIA_Wolf_DI_Training);
	Info_AddChoice(DIA_Wolf_DI_Training,Dialog_Back,DIA_Wolf_DI_Training_BACK);
	if(VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Wolf)
	{
		Info_AddChoice(DIA_Wolf_DI_Training,B_BuildLearnString(PRINT_LearnBow1,B_GetLearnCostTalent(other,NPC_TALENT_BOW,1)),DIA_Wolf_DI_Training_BOW_1);
		Info_AddChoice(DIA_Wolf_DI_Training,B_BuildLearnString(PRINT_LearnBow5,B_GetLearnCostTalent(other,NPC_TALENT_BOW,5)),DIA_Wolf_DI_Training_BOW_5);
	};
	if(VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Wolf)
	{
		Info_AddChoice(DIA_Wolf_DI_Training,B_BuildLearnString(PRINT_LearnCrossBow1,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,1)),DIA_Wolf_DI_Training_CROSSBOW_1);
		Info_AddChoice(DIA_Wolf_DI_Training,B_BuildLearnString(PRINT_LearnCrossBow5,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,5)),DIA_Wolf_DI_Training_CROSSBOW_5);
	};
	if((VisibleTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_Wolf) && (VisibleTalentValue(NPC_TALENT_CROSSBOW) >= TeachLimit_Crossbow_Wolf))
	{
		if((RealTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_Wolf) && (RealTalentValue(NPC_TALENT_CROSSBOW) >= TeachLimit_Crossbow_Wolf))
		{
			DIA_Wolf_DI_Teacher_permanent = TRUE;
		};
		PrintScreen(PRINT_NoLearnTotalMAXReached,-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

instance DIA_Wolf_DI_Training(C_Info)
{
	npc = SLD_811_Wolf_DI;
	nr = 10;
	condition = DIA_Wolf_DI_Training_Condition;
	information = DIA_Wolf_DI_Training_Info;
	permanent = TRUE;
	description = "Train me in long-distance combat.";
};


func int DIA_Wolf_DI_Training_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (DIA_Wolf_DI_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Wolf_DI_Training_Info()
{
	AI_Output(other,self,"DIA_Wolf_DI_Training_15_00");	//Train me in long-distance combat.
	if((VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Wolf) || (VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Wolf))
	{
		AI_Output(self,other,"DIA_Wolf_DI_Training_08_01");	//What kind?
	};
	B_BuildLearnDialog_Wolf_DI();
};

func void DIA_Wolf_DI_Training_BOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,1,TeachLimit_Bow_Wolf))
	{
		B_Wolf_TeachComment(NPC_TALENT_BOW);
		B_BuildLearnDialog_Wolf_DI();
	};
};

func void DIA_Wolf_DI_Training_BOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,5,TeachLimit_Bow_Wolf))
	{
		B_Wolf_TeachComment(NPC_TALENT_BOW);
		B_BuildLearnDialog_Wolf_DI();
	};
};

func void DIA_Wolf_DI_Training_CROSSBOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,1,TeachLimit_Crossbow_Wolf))
	{
		B_Wolf_TeachComment(NPC_TALENT_CROSSBOW);
		B_BuildLearnDialog_Wolf_DI();
	};
};

func void DIA_Wolf_DI_Training_CROSSBOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,5,TeachLimit_Crossbow_Wolf))
	{
		B_Wolf_TeachComment(NPC_TALENT_CROSSBOW);
		B_BuildLearnDialog_Wolf_DI();
	};
};

func void DIA_Wolf_DI_Training_BACK()
{
	Info_ClearChoices(DIA_Wolf_DI_Training);
};

instance DIA_Wolf_DI_UndeadDragonDead(C_Info)
{
	npc = SLD_811_Wolf_DI;
	nr = 2;
	condition = DIA_Wolf_DI_UndeadDragonDead_Condition;
	information = DIA_Wolf_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "Everything all right?";
};


func int DIA_Wolf_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};


var int DIA_Wolf_DI_UndeadDragonDead_OneTime;

func void DIA_Wolf_DI_UndeadDragonDead_Info()
{
	AI_Output (other, self, "DIA_Wolf_DI_UndeadDragonDead_15_00");	//Everything all right?
	AI_Output (self, other, "DIA_Wolf_DI_UndeadDragonDead_08_01");	//Sure. And you? It was a tough one, huh?
	if (DIA_Wolf_DI_UndeadDragonDead_OneTime == FALSE)
	{
		AI_Output (other, self, "DIA_Wolf_DI_UndeadDragonDead_15_02");	//Where will you go now?
		AI_Output (self, other, "DIA_Wolf_DI_UndeadDragonDead_08_03");	//Anywhere but back. I've had a bellyful of Khorinis.
		AI_Output (self, other, "DIA_Wolf_DI_UndeadDragonDead_08_04");	//It's all the same to me where we sail. As long as it's away from here.
		DIA_Wolf_DI_UndeadDragonDead_OneTime = TRUE;
	};
	AI_StopProcessInfos(self);
};


instance DIA_Wolf_DI_PICKPOCKET(C_Info)
{
	npc = SLD_811_Wolf_DI;
	nr = 900;
	condition = DIA_Wolf_DI_PICKPOCKET_Condition;
	information = DIA_Wolf_DI_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Wolf_DI_PICKPOCKET_Condition()
{
	return C_Beklauen(32,45);
};

func void DIA_Wolf_DI_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Wolf_DI_PICKPOCKET);
	Info_AddChoice(DIA_Wolf_DI_PICKPOCKET,Dialog_Back,DIA_Wolf_DI_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Wolf_DI_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Wolf_DI_PICKPOCKET_DoIt);
};

func void DIA_Wolf_DI_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Wolf_DI_PICKPOCKET);
};

func void DIA_Wolf_DI_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Wolf_DI_PICKPOCKET);
};

