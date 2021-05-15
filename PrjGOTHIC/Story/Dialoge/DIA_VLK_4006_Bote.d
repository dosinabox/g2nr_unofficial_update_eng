
instance DIA_Bote_EXIT(C_Info)
{
	npc = VLK_4006_Bote;
	nr = 999;
	condition = DIA_Bote_EXIT_Condition;
	information = DIA_Bote_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Bote_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Bote_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Bote_Hello(C_Info)
{
	npc = VLK_4006_Bote;
	nr = 4;
	condition = DIA_Bote_Hello_Condition;
	information = DIA_Bote_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Bote_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Bote_Hello_Info()
{
	AI_Output(self,other,"DIA_Canthar_SARAHERLEDIGT_09_00");	//Don't you have a job to do?
	DIA_Common_IThinkNo();
	AI_Output(self,other,"DIA_Canthar_PersonalCRIMES_NotEnough_09_01");	//Then why are you stealing my time?
	AI_StopProcessInfos(self);
};

instance DIA_Bote_Talk(C_Info)
{
	npc = VLK_4006_Bote;
	nr = 5;
	condition = DIA_Bote_Talk_Condition;
	information = DIA_Bote_Talk_Info;
	permanent = TRUE;
	description = "What are you doing here?";
};


func int DIA_Bote_Talk_Condition()
{
	return TRUE;
};

func void DIA_Bote_Talk_Info()
{
	DIA_Common_WhatAreYouDoingHere();
	B_Say(self,other,"$NOTNOW");
	AI_StopProcessInfos(self);
};

