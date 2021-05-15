
instance DIA_Mil_325_Miliz_EXIT(C_Info)
{
	npc = MIL_325_Miliz;
	nr = 999;
	condition = DIA_Mil_325_Miliz_EXIT_Condition;
	information = DIA_Mil_325_Miliz_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Mil_325_Miliz_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Mil_325_Miliz_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


const string Mil_325_Checkpoint = "NW_CITY_MERCHANT_PATH_03";

instance DIA_Mil_325_Miliz_FirstWarn(C_Info)
{
	npc = MIL_325_Miliz;
	nr = 1;
	condition = DIA_Mil_325_Miliz_FirstWarn_Condition;
	information = DIA_Mil_325_Miliz_FirstWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Mil_325_Miliz_FirstWarn_Condition()
{
/*	if(Npc_GetDistToWP(other,Mil_325_Checkpoint) < 650)
	{
		Npc_SetRefuseTalk(self,5);
		return FALSE;
	};*/
	if((self.aivar[AIV_Guardpassage_Status] == GP_NONE) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && !Npc_RefuseTalk(self))
	{
		return TRUE;
	};
};

func void DIA_Mil_325_Miliz_FirstWarn_Info()
{
	B_PlayerEnteredCity();
	if(Npc_GetDistToWP(other,Mil_325_Checkpoint) < 650)
	{
		other.aivar[AIV_LastDistToWP] = 0;
		self.aivar[AIV_Guardpassage_Status] = GP_NONE;
		B_Say(self,other,"$WHATDIDYOUDOINTHERE");
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,0);
	}
	else
	{
	AI_Output (self, other, "DIA_Mil_325_Miliz_FirstWarn_12_00");	//HALT!
	AI_Output (self, other, "DIA_Mil_325_Miliz_FirstWarn_12_01");	//No one may enter the store room.
		other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,Mil_325_Checkpoint);
		self.aivar[AIV_Guardpassage_Status] = GP_FirstWarnGiven;
	};
};


instance DIA_Mil_325_Miliz_SecondWarn(C_Info)
{
	npc = MIL_325_Miliz;
	nr = 2;
	condition = DIA_Mil_325_Miliz_SecondWarn_Condition;
	information = DIA_Mil_325_Miliz_SecondWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Mil_325_Miliz_SecondWarn_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_FirstWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,Mil_325_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Mil_325_Miliz_SecondWarn_Info()
{
	if(Npc_GetDistToWP(other,Mil_325_Checkpoint) < 650)
	{
		other.aivar[AIV_LastDistToWP] = 0;
		self.aivar[AIV_Guardpassage_Status] = GP_NONE;
		B_Say(self,other,"$WHATDIDYOUDOINTHERE");
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,0);
	}
	else
	{
		AI_Output(self,other,"DIA_Mil_325_Miliz_SecondWarn_12_00");	//re you deaf? One step closer and I'll chop you to bits!
		other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,Mil_325_Checkpoint);
		self.aivar[AIV_Guardpassage_Status] = GP_SecondWarnGiven;
		AI_StopProcessInfos(self);
	};
};


instance DIA_Mil_325_Miliz_Attack(C_Info)
{
	npc = MIL_325_Miliz;
	nr = 3;
	condition = DIA_Mil_325_Miliz_Attack_Condition;
	information = DIA_Mil_325_Miliz_Attack_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Mil_325_Miliz_Attack_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_SecondWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,Mil_325_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_Mil_325_Miliz_Attack_Info()
{
	if(Npc_GetDistToWP(other,Mil_325_Checkpoint) < 650)
	{
		other.aivar[AIV_LastDistToWP] = 0;
		self.aivar[AIV_Guardpassage_Status] = GP_NONE;
		B_Say(self,other,"$WHATDIDYOUDOINTHERE");
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,0);
	}
	else
	{
		other.aivar[AIV_LastDistToWP] = 0;
		self.aivar[AIV_Guardpassage_Status] = GP_NONE;
		AI_Output(self,other,"DIA_Mil_325_Miliz_Attack_12_00");	//That was a mistake!
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,0);
	};
};


instance DIA_Mil_325_Miliz_Pass(C_Info)
{
	npc = MIL_325_Miliz;
	nr = 5;
	condition = DIA_Mil_325_Miliz_Pass_Condition;
	information = DIA_Mil_325_Miliz_Pass_Info;
	permanent = FALSE;
	description = "I belong to the royal army. I want to equip myself!";
};


func int DIA_Mil_325_Miliz_Pass_Condition()
{
	if((self.aivar[AIV_PASSGATE] == FALSE) && ((other.guild == GIL_MIL) || (other.guild == GIL_PAL)))
	{
		return TRUE;
	};
};

func void DIA_Mil_325_Miliz_Pass_Info()
{
	AI_Output (other, self, "DIA_Mil_325_Miliz_Pass_15_00");	//I belong to the royal army. I want to equip myself!
	AI_Output (self, other, "DIA_Mil_325_Miliz_Pass_12_01");	//Do you have an order for that?
	Info_ClearChoices (DIA_Mil_325_Miliz_Pass);
	Info_AddChoice (DIA_Mil_325_Miliz_Pass, "No.", DIA_Mil_325_Miliz_Pass_No);
	Info_AddChoice (DIA_Mil_325_Miliz_Pass, "Sure.", DIA_Mil_325_Miliz_Pass_Yes);
};

func void DIA_Mil_325_Miliz_Pass_Yes()
{
	AI_Output (other, self, "DIA_Mil_325_Miliz_Pass_Yes_15_00");	//Sure.
	AI_Output (self, other, "DIA_Mil_325_Miliz_Pass_Yes_12_01");	//Fine, you can go in!
	self.aivar[AIV_PASSGATE] = TRUE;
	Info_ClearChoices(DIA_Mil_325_Miliz_Pass);
	AI_StopProcessInfos(self);
};

func void DIA_Mil_325_Miliz_Pass_No()
{
	AI_Output (other, self, "DIA_Mil_325_Miliz_Pass_No_15_00");	//No.
	AI_Output (self, other, "DIA_Mil_325_Miliz_Pass_No_12_01");	//Then get out of here.
	Info_ClearChoices (DIA_Mil_325_Miliz_Pass);
	AI_StopProcessInfos (self);
};


instance DIA_Mil_325_Miliz_PassAsMage(C_Info)
{
	npc = MIL_325_Miliz;
	nr = 5;
	condition = DIA_Mil_325_Miliz_PassAsMage_Condition;
	information = DIA_Mil_325_Miliz_PassAsMage_Info;
	permanent = FALSE;
	description = "I am a Fire Magician.";
};


func int DIA_Mil_325_Miliz_PassAsMage_Condition()
{
	if((self.aivar[AIV_PASSGATE] == FALSE) && (other.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Mil_325_Miliz_PassAsMage_Info()
{
	AI_Output(other,self,"DIA_PAL_205_Torwache_PassAsMage_15_00");	//I am a Fire Magician.
	AI_Output(self,other,"DIA_Mil_325_Miliz_Pass_Yes_12_01");	//Fine, you can go in!
	self.aivar[AIV_PASSGATE] = TRUE;
	AI_StopProcessInfos(self);
};


instance DIA_Mil_325_Miliz_PERM(C_Info)
{
	npc = MIL_325_Miliz;
	nr = 5;
	condition = DIA_Mil_325_Miliz_PERM_Condition;
	information = DIA_Mil_325_Miliz_PERM_Info;
	permanent = TRUE;
	description = "Why can't anyone enter the storeroom?";
};


func int DIA_Mil_325_Miliz_PERM_Condition()
{
	if(self.aivar[AIV_PASSGATE] == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Mil_325_Miliz_PERM_Info()
{
	AI_Output(other,self,"DIA_Mil_325_Miliz_PERM_15_00");	//Why can't anyone enter the storeroom?
	AI_Output(self,other,"DIA_Mil_325_Miliz_PERM_12_01");	//The honorable Lord Hagen has confiscated the goods for the king's army.
};

