
instance DIA_PAL_263_EXIT(C_Info)
{
	npc = PAL_263_Wache;
	nr = 999;
	condition = DIA_PAL_263_EXIT_Condition;
	information = DIA_PAL_263_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_PAL_263_EXIT_Condition()
{
	return TRUE;
};

func void DIA_PAL_263_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_PAL_263_PERM(C_Info)
{
	npc = PAL_263_Wache;
	nr = 2;
	condition = DIA_PAL_263_PERM_Condition;
	information = DIA_PAL_263_PERM_Info;
	permanent = TRUE;
	description = "Report, soldier!";
};


func int DIA_PAL_263_PERM_Condition()
{
//	if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL))
	if(hero.guild == GIL_PAL)
	{
		return TRUE;
	};
};

func void DIA_PAL_263_PERM_Info()
{
	AI_Output (other, self, "DIA_PAL_263_PERM_15_00");	//Report, soldier!
	AI_Output (self, other, "DIA_PAL_263_PERM_04_01");	//Yes, sir! Holding position as ordered. No additional losses. Provisions getting short, the orcs are quiet.
	AI_Output (self, other, "DIA_PAL_263_PERM_04_02");	//The last dragon attack completely destroyed the outer wall. But since then, there haven't been any unusual events.
	AI_Output (other, self, "DIA_PAL_263_PERM_15_03");	//All right, carry on.
};


instance DIA_PAL_263_PERM_CIV(C_Info)
{
	npc = PAL_263_Wache;
	nr = 2;
	condition = DIA_PAL_263_PERM_CIV_Condition;
	information = DIA_PAL_263_PERM_CIV_Info;
	permanent = TRUE;
	description = "How are things?";
};


func int DIA_PAL_263_PERM_CIV_Condition()
{
	if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG) || (hero.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_PAL_263_PERM_CIV_Info()
{
		AI_Output (other, self, "DIA_PAL_263_PERM_OTH_15_00");	//How's the situation?
		AI_Output (self, other, "DIA_PAL_263_PERM_OTH_04_01");	//We have the situation under control. Don't concern yourself, civilian. Everything will turn out all right.
};

instance DIA_PAL_263_PERM_OTH(C_Info)
{
	npc = PAL_263_Wache;
	nr = 2;
	condition = DIA_PAL_263_PERM_OTH_Condition;
	information = DIA_PAL_263_PERM_OTH_Info;
	permanent = TRUE;
	description = "Who's in charge here?";
};


func int DIA_PAL_263_PERM_OTH_Condition()
{
	if((hero.guild == GIL_MIL) || (hero.guild == GIL_NOV) || (hero.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_PAL_263_PERM_OTH_Info()
{
	AI_Output(other,self,"DIA_WACHE_PERM_15_00");	//Who's in charge here?
	AI_Output(self,other,"DIA_WACHE_PERM_10_01");	//Our commander - Garond and his two advisors - the paladins Orik and Parcival.
	AI_Output(self,other,"DIA_WACHE_PERM_10_02");	//Just walk on in. Durning the day you can find him in the throne room on the ground floor.
};

