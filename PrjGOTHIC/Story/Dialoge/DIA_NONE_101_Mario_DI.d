
instance DIA_NONE_101_MARIO_DI_EXIT(C_Info)
{
	npc = NONE_101_Mario_DI;
	nr = 999;
	condition = DIA_NONE_101_MARIO_DI_EXIT_Condition;
	information = DIA_NONE_101_MARIO_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_NONE_101_MARIO_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_NONE_101_MARIO_DI_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_NONE_101_MARIO_DI_Job(C_Info)
{
	npc = NONE_101_Mario_DI;
	nr = 4;
	condition = DIA_NONE_101_MARIO_DI_Job_Condition;
	information = DIA_NONE_101_MARIO_DI_Job_Info;
	permanent = TRUE;
	description = "Here's your chance to prove your fighting abilities.";
};


func int DIA_NONE_101_MARIO_DI_Job_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (OrkSturmDI == FALSE))
	{
		return TRUE;
	};
};

func void DIA_NONE_101_MARIO_DI_Job_Info()
{
	AI_Output (other, self, "DIA_NONE_101_MARIO_DI_Job_15_00");	//Here's your chance to prove your fighting abilities.
	AI_Output (self, other, "DIA_NONE_101_MARIO_DI_Job_07_01");	//Slowly. Everything in its time.
	AI_Output (other, self, "DIA_NONE_101_MARIO_DI_Job_15_02");	//Mmh. That's just what I'd expected from you.
	AI_Output (self, other, "DIA_NONE_101_MARIO_DI_Job_07_03");	//Just wait.
};


instance DIA_NONE_101_MARIO_DI_ambush(C_Info)
{
	npc = NONE_101_Mario_DI;
	nr = 4;
	condition = DIA_NONE_101_MARIO_DI_ambush_Condition;
	information = DIA_NONE_101_MARIO_DI_ambush_Info;
	important = TRUE;
};


func int DIA_NONE_101_MARIO_DI_ambush_Condition()
{
	if(OrkSturmDI == TRUE)
	{
		return TRUE;
	};
};

func void DIA_NONE_101_MARIO_DI_ambush_Info()
{
	AI_Output (self, other, "DIA_NONE_101_MARIO_DI_ambush_07_00");	//Come closer. So, my friend. Now show me what you've got.
	AI_Output (other, self, "DIA_NONE_101_MARIO_DI_ambush_15_01");	//What do you mean by that?
	AI_Output (self, other, "DIA_NONE_101_MARIO_DI_ambush_07_02");	//Quite simple. The Master has had more than enough of you.
	AI_Output (self, other, "DIA_NONE_101_MARIO_DI_ambush_07_03");	//I should have killed you sooner. But my friends and I will correct that mistake here and now.
	B_GivePlayerXP(XP_Mario_Ambush);
	Info_ClearChoices(DIA_NONE_101_MARIO_DI_ambush);
	Info_AddChoice(DIA_NONE_101_MARIO_DI_ambush,Dialog_Ende,DIA_NONE_101_MARIO_DI_ambush_ambush);
};

func void DIA_NONE_101_MARIO_DI_ambush_ambush()
{
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_SuddenEnemyInferno,1);
	Skeleton_Mario1.aivar[AIV_EnemyOverride] = FALSE;
	Skeleton_Mario2.aivar[AIV_EnemyOverride] = FALSE;
	Skeleton_Mario3.aivar[AIV_EnemyOverride] = FALSE;
	Skeleton_Mario4.aivar[AIV_EnemyOverride] = FALSE;
};


instance DIA_MARIO_DI_PICKPOCKET(C_Info)
{
	npc = NONE_101_Mario_DI;
	nr = 900;
	condition = DIA_MARIO_DI_PICKPOCKET_Condition;
	information = DIA_MARIO_DI_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_MARIO_DI_PICKPOCKET_Condition()
{
	return C_Beklauen(71,110);
};

func void DIA_MARIO_DI_PICKPOCKET_Info()
{
	Info_ClearChoices(dia_mario_di_pickpocket);
	Info_AddChoice(dia_mario_di_pickpocket,Dialog_Back,dia_mario_di_pickpocket_back);
	Info_AddChoice(dia_mario_di_pickpocket,DIALOG_PICKPOCKET,DIA_MARIO_DI_PICKPOCKET_DoIt);
};

func void DIA_MARIO_DI_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(dia_mario_di_pickpocket);
};

func void dia_mario_di_pickpocket_back()
{
	Info_ClearChoices(dia_mario_di_pickpocket);
};


