
instance DIA_GornNW_KAP3_EXIT(C_Info)
{
	npc = PC_Fighter_NW_vor_DJG;
	nr = 999;
	condition = DIA_GornNW_KAP3_EXIT_Condition;
	information = DIA_GornNW_KAP3_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_GornNW_KAP3_EXIT_Condition()
{
	return TRUE;
};

func void DIA_GornNW_KAP3_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_GornNW_Hallo(C_Info)
{
	npc = PC_Fighter_NW_vor_DJG;
	nr = 1;
	condition = DIA_GornNW_Hallo_Condition;
	information = DIA_GornNW_Hallo_Info;
	permanent = FALSE;
	description = "Everything all right with you?";
};


func int DIA_GornNW_Hallo_Condition()
{
	return TRUE;
};

func void DIA_GornNW_Hallo_Info()
{
	AI_Output (other, self, "DIA_GornNW_Add_15_00");	//Everything all right with you?
	if (MIS_RescueGorn == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_GornNW_Add_12_01");	//You saved my ass, man.
		AI_Output (self, other, "DIA_GornNW_Add_12_02");	//I'll never forget that.
		B_GivePlayerXP(XP_AmbientKap3);
	}
	else
	{
		AI_Output (self, other, "DIA_GornNW_Add_12_03");	//Milten got me out.
		AI_Output (self, other, "DIA_GornNW_Add_12_04");	//I'll never forget that.
	};
};


instance DIA_GornNW_WhatNext(C_Info)
{
	npc = PC_Fighter_NW_vor_DJG;
	nr = 1;
	condition = DIA_GornNW_WhatNext_Condition;
	information = DIA_GornNW_WhatNext_Info;
	permanent = TRUE;
	description = "What are your plans now?";
};


func int DIA_GornNW_WhatNext_Condition()
{
	return TRUE;
};

func void DIA_GornNW_WhatNext_Info()
{
	AI_Output (other, self, "DIA_GornNW_Add_15_05");	//What do you want to do now?
	AI_Output (self, other, "DIA_GornNW_Add_12_06");	//I think I'll load up on grub first.
	AI_Output (other, self, "DIA_GornNW_Add_15_07");	//And then?
	AI_Output (self, other, "DIA_GornNW_Add_12_08");	//Who knows... Maybe I'll go back to the mining colony.
	AI_Output (self, other, "DIA_GornNW_Add_12_09");	//Someone should keep an eye on the orcs - otherwise they'll all show up on the doorstep without warning.
};

