
instance DIA_Jack_DI_EXIT(C_Info)
{
	npc = VLK_444_Jack_DI;
	nr = 999;
	condition = DIA_Jack_DI_EXIT_Condition;
	information = DIA_Jack_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Jack_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Jack_DI_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Jack_DI_GREET(C_Info)
{
	npc = VLK_444_Jack_DI;
	nr = 4;
	condition = DIA_Jack_DI_GREET_Condition;
	information = DIA_Jack_DI_GREET_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Jack_DI_GREET_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};


var int DIA_Jack_DI_GREET_OneTime;

func void DIA_Jack_DI_GREET_Info()
{
	if(OrkSturmDI == FALSE)
	{
		AI_Output (self, other, "DIA_Jack_DI_GREET_14_00");	//I hope you know what you're doing, matey.
		AI_Output (other, self, "DIA_Jack_DI_GREET_15_01");	//It won't be long now.
		AI_Output (self, other, "DIA_Jack_DI_GREET_14_02");	//Keep your head on your shoulders and come back in one piece.
		AI_StopProcessInfos (self);
	}
	else
	{
		if(DIA_Jack_DI_GREET_OneTime == FALSE)
		{
			AI_Output(other,self,"DIA_Jack_DI_GREET_15_03");	//What are you doing down here?
			B_GivePlayerXP(XP_AmbientKap6);
			DIA_Jack_DI_GREET_OneTime = TRUE;
		};
		AI_Output (self, other, "DIA_Jack_DI_GREET_14_04");	//If this hell breaks loose over us one more time, I'll get the ship out of here. With or without you, d'you hear?
		AI_Output (other, self, "DIA_Jack_DI_GREET_15_05");	//None of this nonsense. I'll handle this.
		AI_Output (self, other, "DIA_Jack_DI_GREET_14_06");	//Make haste, then.
		AI_StopProcessInfos(self);
		if(CaptainIsBackToStartPosition == FALSE)
		{
			Npc_ExchangeRoutine(self,"Start");
			CaptainIsBackToStartPosition = TRUE;
		};
	};
};


instance DIA_Jack_DI_UndeadDragonDead(C_Info)
{
	npc = VLK_444_Jack_DI;
	nr = 4;
	condition = DIA_Jack_DI_UndeadDragonDead_Condition;
	information = DIA_Jack_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "I did it. I eliminated the enemy.";
};


func int DIA_Jack_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Jack_DI_UndeadDragonDead_Info()
{
	AI_Output (other, self, "DIA_Jack_DI_UndeadDragonDead_15_00");	//I did it. I eliminated the enemy.
	AI_Output (self, other, "DIA_Jack_DI_UndeadDragonDead_14_01");	//I had hoped that everything would turn out well. But I must admit that, during those last few hours, I haven't been so sure.
	AI_Output (self, other, "DIA_Jack_DI_UndeadDragonDead_14_02");	//Can we finally set sail again now?
	Info_ClearChoices (DIA_Jack_DI_UndeadDragonDead);
	Info_AddChoice (DIA_Jack_DI_UndeadDragonDead, "One more minute.", DIA_Jack_DI_UndeadDragonDead_moment);
	Info_AddChoice (DIA_Jack_DI_UndeadDragonDead, "Yes. Let us end it.", DIA_Jack_DI_UndeadDragonDead_over);
};

func void DIA_Jack_DI_UndeadDragonDead_moment()
{
	AI_Output (other, self, "DIA_Jack_DI_UndeadDragonDead_moment_15_00");	//Just a moment, now. There's something else I need to do.
	AI_Output (self, other, "DIA_Jack_DI_UndeadDragonDead_moment_14_01");	//Make haste, will you. I don't want to catch scurvy here.
	AI_StopProcessInfos (self);
};

func void DIA_Jack_DI_UndeadDragonDead_over()
{
	AI_StopProcessInfos(self);
	B_Extro_Avi();
};

