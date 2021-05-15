
instance DIA_Herold_Info(C_Info)
{
	npc = VLK_406_Herold;
	nr = 10;
	condition = DIA_Herold_Info_Condition;
	information = DIA_Herold_Info_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Herold_Info_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Herold_Info_Info()
{
	if(Wld_IsTime(5,0,23,55))
	{
		AI_Output(self,other,"DIA_Herold_Info_04_00");	//Don't bother me, I'm on duty.
	}
	else
	{
		B_Say(self,other,"$NOTNOW");
	};
	AI_StopProcessInfos(self);
};

