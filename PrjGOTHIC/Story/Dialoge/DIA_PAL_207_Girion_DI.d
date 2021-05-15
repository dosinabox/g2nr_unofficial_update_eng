@@@
instance DIA_Girion_DI_EXIT(C_Info)
{
	npc = PAL_207_Girion_DI;
	nr = 999;
	condition = DIA_Girion_DI_EXIT_Condition;
	information = DIA_Girion_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Girion_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Girion_DI_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Girion_DI_Hallo(C_Info)
{
	npc = PAL_207_Girion_DI;
	nr = 2;
	condition = DIA_Girion_DI_Hallo_Condition;
	information = DIA_Girion_DI_Hallo_Info;
	permanent = TRUE;
	description = "��� � �������?";
};


func int DIA_Girion_DI_Hallo_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Girion_DI_Hallo_Info()
{
	AI_Output(other,self,"DIA_Girion_DI_Hallo_15_00");	//��� � �������?
	if(OrkSturmDI == TRUE)
	{
		AI_Output(self,other,"DIA_Girion_DI_Hallo_08_01");	//� ����� ������� ��������, ����� ��������� ����.
		AI_Output(self,other,"DIA_Girion_DI_Hallo_08_02");	//�� �� ������ ����� ��������, ������ ��� �������� �� �������� �� ����������� ������.
	}
	else if(hero.guild == GIL_PAL)
	{
		AI_Output(self,other,"DIA_Girion_DI_Hallo_08_03");	//�����, ��. ����� �� ��� ������ �������� �� ���� �����?
	}
	else
	{
		AI_Output(self,other,"DIA_Girion_DI_Hallo_08_04");	//�� ������ ���� �� ������. ����� ��, ��� ����� �������, � ��������� ��������� ������� ���.
	};
};


var int DIA_Girion_DI_Teacher_permanent;
var int Girion_DI_TeachComment_Swords;
var int Girion_DI_TeachComment_Crossbow;

func void B_BuildLearnDialog_Girion_DI()
{
	Info_ClearChoices(DIA_Girion_DI_Teach);
	Info_AddChoice(DIA_Girion_DI_Teach,Dialog_Back,DIA_Girion_DI_Teach_Back);
	if(VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Girion)
	{
		Info_AddChoice(DIA_Girion_DI_Teach,B_BuildLearnString(PRINT_LearnCrossBow1,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,1)),DIA_Girion_DI_Teach_CROSSBOW_1);
		Info_AddChoice(DIA_Girion_DI_Teach,B_BuildLearnString(PRINT_LearnCrossBow5,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,5)),DIA_Girion_DI_Teach_CROSSBOW_5);
	};
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Girion)
	{
		Info_AddChoice(DIA_Girion_DI_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Girion_DI_Teach_2H_1);
		Info_AddChoice(DIA_Girion_DI_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Girion_DI_Teach_2H_5);
	};
	if(VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Girion)
	{
		Info_AddChoice(DIA_Girion_DI_Teach,B_BuildLearnString(PRINT_Learn1h1,B_GetLearnCostTalent(other,NPC_TALENT_1H,1)),DIA_Girion_DI_Teach_1H_1);
		Info_AddChoice(DIA_Girion_DI_Teach,B_BuildLearnString(PRINT_Learn1h5,B_GetLearnCostTalent(other,NPC_TALENT_1H,5)),DIA_Girion_DI_Teach_1H_5);
	};
	if((RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Girion) && (RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Girion) && (RealTalentValue(NPC_TALENT_CROSSBOW) >= TeachLimit_Crossbow_Girion))
	{
		DIA_Girion_DI_Teacher_permanent = TRUE;
	};
	if((VisibleTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Girion) && (VisibleTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Girion) && (VisibleTalentValue(NPC_TALENT_CROSSBOW) >= TeachLimit_Crossbow_Girion))
	{
		PrintScreen(PRINT_NoLearnTotalMAXReached,-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

func void B_Girion_DI_TeachComment_Swords()
{
	if(Girion_DI_TeachComment_Swords == 0)
	{
		AI_Output(self,other,"DIA_Girion_DI_Teach_1H_1_08_00");	//���� ������ ������ ��������� ������ ��� �������� �� �����.
		Girion_DI_TeachComment_Swords = 1;
	}
	else if(Girion_DI_TeachComment_Swords == 1)
	{
		AI_Output(self,other,"DIA_Girion_DI_Teach_1H_5_08_00");	//���� ����� ��������� ����������. ���� �� ����� ������ ��������� �� ����������, ��� �� �������� ���� � ������.
		Girion_DI_TeachComment_Swords = 2;
	}
	else if(Girion_DI_TeachComment_Swords == 2)
	{
		AI_Output(self,other,"DIA_DIA_Girion_DI_Teach_2H_1_08_00");	//�� ������ �������� ������� ������, � ���� ���� ����� ������� ����.
		Girion_DI_TeachComment_Swords = 3;
	}
	else if(Girion_DI_TeachComment_Swords == 3)
	{
		AI_Output(self,other,"DIA_Girion_DI_Teach_2H_5_08_00");	//�� ������� � �����������. �� ������ ������� - ��� ��������� �� ����� �����.
		Girion_DI_TeachComment_Swords = 0;
	};
};

func void B_Girion_DI_TeachComment_Crossbow()
{
	if(Girion_DI_TeachComment_Crossbow == 0)
	{
		AI_Output(self,other,"DIA_Girion_DI_Teach_CROSSBOW_1_08_00");	//��� �������� ������� �� �������� �������. ��� ������� ���� ������ ������� �������, � �� ��������� ������� ������.
		Girion_DI_TeachComment_Crossbow = 1;
	}
	else if(Girion_DI_TeachComment_Crossbow == 1)
	{
		AI_Output(self,other,"DIA_Girion_DI_Teach_CROSSBOW_5_08_00");	//������ ���������� ����� ���� ����� ���������. ��� �������� ���� ����� ����� �����������.
		Girion_DI_TeachComment_Crossbow = 2;
	}
	else if(Girion_DI_TeachComment_Crossbow == 2)
	{
		AI_Output(self,other,"DIA_DIA_Girion_Teach_2H_5_08_01");	//�� ������ ��������, ����� ����� ���������.
		Girion_DI_TeachComment_Crossbow = 0;
	};
};

instance DIA_Girion_DI_Teach(C_Info)
{
	npc = PAL_207_Girion_DI;
	nr = 5;
	condition = DIA_Girion_DI_Teach_Condition;
	information = DIA_Girion_DI_Teach_Info;
	permanent = TRUE;
	description = "����� ����, ����� �� ������ ������� �������� � ����� �������.";
};


func int DIA_Girion_DI_Teach_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (DIA_Girion_DI_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Girion_DI_Teach_Info()
{
	AI_Output(other,self,"DIA_Girion_DI_Teach_15_00");	//����� ����, ����� �� ������ ������� �������� � ����� �������.
	if((VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Girion) || (VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Girion) || (VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Girion))
	{
		AI_Output(self,other,"DIA_Girion_DI_Teach_08_01");	//������, � ���� ��� ������� ������.
	};
	B_BuildLearnDialog_Girion_DI();
};

func void DIA_Girion_DI_Teach_CROSSBOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,1,TeachLimit_Crossbow_Girion))
	{
		B_Girion_DI_TeachComment_Crossbow();
		B_BuildLearnDialog_Girion_DI();
	};
};

func void DIA_Girion_DI_Teach_CROSSBOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,5,TeachLimit_Crossbow_Girion))
	{
		B_Girion_DI_TeachComment_Crossbow();
		B_BuildLearnDialog_Girion_DI();
	};
};

func void DIA_Girion_DI_Teach_1H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,1,TeachLimit_1H_Girion))
	{
		B_Girion_DI_TeachComment_Swords();
		B_BuildLearnDialog_Girion_DI();
	};
};

func void DIA_Girion_DI_Teach_1H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,5,TeachLimit_1H_Girion))
	{
		B_Girion_DI_TeachComment_Swords();
		B_BuildLearnDialog_Girion_DI();
	};
};

func void DIA_Girion_DI_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Girion))
	{
		B_Girion_DI_TeachComment_Swords();
		B_BuildLearnDialog_Girion_DI();
	};
};

func void DIA_Girion_DI_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Girion))
	{
		B_Girion_DI_TeachComment_Swords();
		B_BuildLearnDialog_Girion_DI();
	};
};

func void DIA_Girion_DI_Teach_Back()
{
	Info_ClearChoices(DIA_Girion_DI_Teach);
};

var int DIA_Girion_DI_OrcEliteRing_OneTime;
var int GirionRingCount;

instance DIA_Girion_DI_OrcEliteRing(C_Info)
{
	npc = PAL_207_Girion_DI;
	nr = 99;
	condition = DIA_Girion_DI_OrcEliteRing_Condition;
	information = DIA_Girion_DI_OrcEliteRing_Info;
	permanent = TRUE;
	description = "� ���� ���� ������ ������������� �����.";
};


func int DIA_Girion_DI_OrcEliteRing_Condition()
{
	if(Npc_HasItems(other,ItRi_OrcEliteRing))
	{
		return TRUE;
	};
};

func void DIA_Girion_DI_OrcEliteRing_Info()
{
	AI_Output(other,self,"DIA_Girion_DI_OrcEliteRing_15_00");	//� ���� ���� ������ ������������� �����.
	if(DIA_Girion_DI_OrcEliteRing_OneTime == FALSE)
	{
		AI_Output(self,other,"DIA_Girion_DI_OrcEliteRing_08_01");	//� �����, ���� ����� ������ ���-������ �����������.
		DIA_Girion_DI_OrcEliteRing_OneTime = TRUE;
	};
	AI_Output(self,other,"DIA_Girion_DI_OrcEliteRing_08_02");	//��� ��� ���. � ������ ��� ����� ������.
	Info_ClearChoices(DIA_Girion_DI_OrcEliteRing);
	Info_AddChoice(DIA_Girion_DI_OrcEliteRing,"� ����� ������� ��� ����.",DIA_Girion_DI_OrcEliteRing_behalten);
	Info_AddChoice(DIA_Girion_DI_OrcEliteRing,"���, ������.",DIA_Girion_DI_OrcEliteRing_geben);
};

func void DIA_Girion_DI_OrcEliteRing_geben()
{
	GirionRingCount = Npc_HasItems(other,ItRi_OrcEliteRing);
	AI_Output(other,self,"DIA_Girion_DI_OrcEliteRing_geben_15_00");	//���, ������.
	AI_Output(self,other,"DIA_Girion_DI_OrcEliteRing_geben_08_01");	//�������. ��� ����� � �� �����, ��� ��� ����� ���� �����������.
	if(GirionRingCount > 1)
	{
		DIA_Hagen_MoreOrcRings();
	};
	B_GiveInvItems(other,self,ItRi_OrcEliteRing,GirionRingCount);
	Npc_RemoveInvItems(self,ItRi_OrcEliteRing,GirionRingCount);
	B_GivePlayerXP(XP_AmbientKap6 * GirionRingCount);
	Info_ClearChoices(DIA_Girion_DI_OrcEliteRing);
};

func void DIA_Girion_DI_OrcEliteRing_behalten()
{
	AI_Output(other,self,"DIA_Girion_DI_OrcEliteRing_behalten_15_00");	//� ����� ������� ��� ����.
	AI_Output(self,other,"DIA_Girion_DI_OrcEliteRing_behalten_08_01");	//��� ������. ��� ����� ��� ���� �� ���� ����������.
	Info_ClearChoices(DIA_Girion_DI_OrcEliteRing);
};


var int DIA_Girion_DI_UndeadDragonDead_OneTime;

instance DIA_Girion_DI_UndeadDragonDead(C_Info)
{
	npc = PAL_207_Girion_DI;
	nr = 2;
	condition = DIA_Girion_DI_UndeadDragonDead_Condition;
	information = DIA_Girion_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "�� ������ � ��������.";
};


func int DIA_Girion_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Girion_DI_UndeadDragonDead_Info()
{
	AI_Output(other,self,"DIA_Girion_DI_UndeadDragonDead_15_00");	//�� ������ � ��������.
	AI_Output(self,other,"DIA_Girion_DI_UndeadDragonDead_08_01");	//��� ������. � �� � ��� ����� ������, ��� ������ ����� �� ���� �����.
	if(DIA_Girion_DI_UndeadDragonDead_OneTime == FALSE)
	{
		AI_Output(self,other,"DIA_Girion_DI_UndeadDragonDead_08_02");	//������ ���������� ����� ������� ���.
		AI_Output(other,self,"DIA_Girion_DI_UndeadDragonDead_15_03");	//�� ��� �� � ��������. �, ���� ������, � �� ��� �� ����� ������������ �����, �� �������.
		AI_Output(other,self,"DIA_Girion_DI_UndeadDragonDead_15_04");	//� � ��� ������ ��� ������� ����� �������.
		AI_Output(self,other,"DIA_Girion_DI_UndeadDragonDead_08_05");	//� ��� � �����. �� ������ �� ����� � �� ����� ��������� ���� ������. ����� �� ������� ��� � �������� ����.
		AI_Output(self,other,"DIA_Girion_DI_UndeadDragonDead_08_06");	//�����. �, ��� �� �����, ��� ������ ���� �� ����� � ������ �������.
		if(hero.guild == GIL_PAL)
		{
			AI_Output(self,other,"DIA_Girion_DI_UndeadDragonDead_08_07");	//�� ��������� ���� ������. � ���� ��� �������� �� ���� ����. � � ���, ��� �� �� ����� �������.
		}
		else
		{
			AI_Output(self,other,"DIA_Girion_DI_UndeadDragonDead_08_08");	//���� ���� �� � ��������, ��������� ����� �� ��� ���� ��� ��������� ���������.
		};
		DIA_Girion_DI_UndeadDragonDead_OneTime = TRUE;
	};
	AI_Output(self,other,"DIA_Girion_DI_UndeadDragonDead_08_09");	//������. ������ ��� � ��������. ����� �� ��������� �����.
	AI_StopProcessInfos(self);
};


instance DIA_Girion_DI_PICKPOCKET(C_Info)
{
	npc = PAL_207_Girion_DI;
	nr = 900;
	condition = DIA_Girion_DI_PICKPOCKET_Condition;
	information = DIA_Girion_DI_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Girion_DI_PICKPOCKET_Condition()
{
	return C_Beklauen(71,260);
};

func void DIA_Girion_DI_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Girion_DI_PICKPOCKET);
	Info_AddChoice(DIA_Girion_DI_PICKPOCKET,Dialog_Back,DIA_Girion_DI_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Girion_DI_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Girion_DI_PICKPOCKET_DoIt);
};

func void DIA_Girion_DI_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Girion_DI_PICKPOCKET);
};

func void DIA_Girion_DI_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Girion_DI_PICKPOCKET);
};


