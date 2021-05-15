
instance DIA_STRF_1107_EXIT(C_Info)
{
	npc = STRF_1107_Straefling;
	nr = 999;
	condition = DIA_STRF_1107_EXIT_Condition;
	information = DIA_STRF_1107_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_STRF_1107_EXIT_Condition()
{
	return TRUE;
};

func void DIA_STRF_1107_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_STRF_1107_FINGER(C_Info)
{
	npc = STRF_1107_Straefling;
	condition = DIA_STRF_1107_FINGER_Condition;
	information = DIA_STRF_1107_FINGER_Info;
	important = TRUE;
};


func int DIA_STRF_1107_FINGER_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_STRF_1107_FINGER_Info()
{
	AI_Output (self, other, "DIA_STRF_1107_FINGER_01_00");	//Hands off my pots! Nobody touches my pots, understand?!
	AI_Output (self, other, "DIA_STRF_1107_FINGER_01_01");	//I'm responsible for the food, and that means nobody else has any business here! I hope I made myself clear!
};


instance DIA_STRF_1107_COOK(C_Info)
{
	npc = STRF_1107_Straefling;
	condition = DIA_STRF_1107_COOK_Condition;
	information = DIA_STRF_1107_COOK_Info;
	description = "Who made you a cook, of all people?";
};


func int DIA_STRF_1107_COOK_Condition()
{
	return TRUE;
};

func void DIA_STRF_1107_COOK_Info()
{
	AI_Output (other, self, "DIA_STRF_1107_COOK_15_00");	//Who made you a cook, of all people?
	AI_Output (self, other, "DIA_STRF_1107_COOK_01_01");	//That was Commander Garond. Before I became a prisoner, I used to be the cook in the Raging Boar.
	AI_Output (other, self, "DIA_STRF_1107_COOK_15_02");	//And what did they lock you up for?
	AI_Output (self, other, "DIA_STRF_1107_COOK_01_03");	//There was a misunderstanding between a guest, a meat cleaver, and me.
};


instance DIA_STRF_1107_PERM(C_Info)
{
	npc = STRF_1107_Straefling;
	nr = 900;
	condition = DIA_STRF_1107_PERM_Condition;
	information = DIA_STRF_1107_PERM_Info;
	permanent = TRUE;
	description = "Anything new?";
};


func int DIA_STRF_1107_PERM_Condition()
{
	return TRUE;
};

func void DIA_STRF_1107_PERM_Info()
{
	AI_Output (other, self, "DIA_STRF_1107_PERM_15_00");	//Anything new?
	AI_Output (self, other, "DIA_STRF_1107_PERM_01_01");	//If you want to learn the news, then ask the knights. I'm just an imprisoned cook.
};

