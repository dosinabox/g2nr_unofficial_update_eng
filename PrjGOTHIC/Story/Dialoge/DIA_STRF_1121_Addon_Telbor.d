
instance DIA_Addon_Telbor_EXIT(C_Info)
{
	npc = STRF_1121_Addon_Telbor;
	nr = 999;
	condition = DIA_Addon_Telbor_EXIT_Condition;
	information = DIA_Addon_Telbor_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Telbor_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Telbor_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


var int Telbor_Once;

instance DIA_Addon_Telbor_Hi(C_Info)
{
	npc = STRF_1121_Addon_Telbor;
	nr = 2;
	condition = DIA_Addon_Telbor_Hi_Condition;
	information = DIA_Addon_Telbor_Hi_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Telbor_Hi_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && !Npc_IsDead(Patrick))
	{
		return TRUE;
	};
};

func void DIA_Addon_Telbor_Hi_Info()
{
	AI_Output(self,other,"DIA_Addon_Telbor_Hi_12_00");	//Hey, I'm all right.
	if(!Npc_IsDead(Pardos) && (Sklaven_Flucht == FALSE))
	{
		if(Pardos_Geheilt == FALSE)
		{
			AI_Output(self,other,"DIA_Addon_Telbor_Hi_12_01");	//But Pardos is pretty much down and out.
			if(Pardos.attribute[ATR_HITPOINTS] > 70)
			{
				Pardos.attribute[ATR_HITPOINTS] = 70;
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Addon_Telbor_Hi_12_02");	//Thanks for helping Pardos.
			if (Telbor_Once == FALSE)
			{
				B_GivePlayerXP(XP_Ambient);
				Telbor_Once = TRUE;
			};
		};
	};
	AI_Output (self, other, "DIA_Addon_Telbor_Hi_12_03");	//If there's anything you want, talk to Patrick. He's our spokesman.
	AI_StopProcessInfos (self);
};

