
instance DIA_BDT_1_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_BDT_1_EXIT_Condition;
	information = DIA_BDT_1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_BDT_1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_BDT_1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_BDT_1_STANDARD(C_Info)
{
	nr = 2;
	condition = DIA_BDT_1_STANDARD_Condition;
	information = DIA_BDT_1_STANDARD_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_BDT_1_STANDARD_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_BDT_1_STANDARD_Info()
{
	var int randy;
	randy = Hlp_Random(3);
	if(randy == 0)
	{
		AI_Output (self, other, "DIA_BDT_1_STANDARD_01_00");	//Get out of my sight!
	};
	if(randy == 1)
	{
		AI_Output (self, other, "DIA_BDT_1_STANDARD_01_01");	//Are you looking for trouble?
	};
	if(randy == 2)
	{
		AI_Output (self, other, "DIA_BDT_1_STANDARD_01_02");	//Leave while you still can!
	};
	AI_StopProcessInfos(self);
};

func void B_AssignAmbientInfos_BDT_1(var C_Npc slf)
{
	dia_bdt_1_exit.npc = Hlp_GetInstanceID(slf);
	dia_bdt_1_standard.npc = Hlp_GetInstanceID(slf);
};

