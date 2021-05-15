
instance DIA_1061_Wache_EXIT(C_Info)
{
	npc = BDT_1061_Wache;
	nr = 999;
	condition = DIA_1061_Wache_EXIT_Condition;
	information = DIA_1061_Wache_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_1061_Wache_EXIT_Condition()
{
	return TRUE;
};

func void DIA_1061_Wache_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_1061_Wache_Hallo(C_Info)
{
	npc = BDT_1061_Wache;
	nr = 1;
	condition = DIA_1061_Wache_Hallo_Condition;
	information = DIA_1061_Wache_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_1061_Wache_Hallo_Condition()
{
	return TRUE;
};

func void DIA_1061_Wache_Hallo_Info()
{
	AI_Output (self, other, "DIA_1061_Wache_Hallo_01_00");	//Halt - you can't go through here.
	AI_Output (other, self, "DIA_1061_Wache_Hallo_15_01");	//I want to talk to your leader.
	AI_Output (self, other, "DIA_1061_Wache_Hallo_01_02");	//(ironic) Oh, I see, you want to talk to my boss. Well, then OF COURSE I will let you through.
	AI_Output (self, other, "DIA_1061_Wache_Hallo_01_03");	//(deadly serious) But only if you know his name - because if you don't, I'll be obliged to kill you! Well?
	Info_ClearChoices (DIA_1061_Wache_Hallo);
	Info_AddChoice (DIA_1061_Wache_Hallo, "Lee", DIA_1061_Wache_Hallo_Lee);
	if ((Bdt13_Dexter_verraten == TRUE) || (Ranger_SCKnowsDexter == TRUE))
	{
		Info_AddChoice (DIA_1061_Wache_Hallo, "Dexter", DIA_1061_Wache_Hallo_Dexter);
	};
	Info_AddChoice (DIA_1061_Wache_Hallo, "Diego", DIA_1061_Wache_Hallo_Diego);
	Info_AddChoice (DIA_1061_Wache_Hallo, "No idea.", DIA_1061_Wache_Hallo_Ahnung);
};

func void DIA_1061_Wache_Hallo_Lee()
{
	AI_Output (other, self, "DIA_1061_Wache_Hallo_Lee_15_00");	//Lee.
	AI_Output (self, other, "DIA_1061_Wache_Hallo_Lee_01_01");	//Well, what can I say? You just forfeited your life, man!
	Info_ClearChoices (DIA_1061_Wache_Hallo);
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_SuddenEnemyInferno, 0);
};

func void DIA_1061_Wache_Hallo_Dexter()
{
	AI_Output (other, self, "DIA_1061_Wache_Hallo_Dexter_15_00");	//Dexter.
	AI_Output (self, other, "DIA_1061_Wache_Hallo_Dexter_01_01");	//Well... I guess you know the boss. Okay, I'll let you through. But I'm warning you.
	AI_Output (self, other, "DIA_1061_Wache_Hallo_Dexter_01_02");	//You get too close to anybody, you won't get out of here alive!
	AI_Output (self, other, "DIA_1061_Wache_Hallo_Dexter_01_03");	//So take a deep breath and leave your weapons where they are. You'll find Dexter in the house.
	Knows_Dexter = TRUE;
	BanditGuard.aivar[AIV_PASSGATE] = TRUE;
	Info_ClearChoices(DIA_1061_Wache_Hallo);
	AI_StopProcessInfos(self);
};

func void DIA_1061_Wache_Hallo_Diego()
{
	AI_Output (other, self, "DIA_1061_Wache_Hallo_Diego_15_00");	//Diego.
	AI_Output (self, other, "DIA_1061_Wache_Hallo_Diego_01_01");	//Right!
	AI_Output (self, other, "DIA_1061_Wache_Hallo_Diego_01_02");	//No, that was just a joke. You don't have any idea who my boss is.
	AI_Output (self, other, "DIA_1061_Wache_Hallo_Diego_01_03");	//So there's no reason why I shouldn't kill you.
	Info_ClearChoices (DIA_1061_Wache_Hallo);
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_SuddenEnemyInferno, 0);
};

func void DIA_1061_Wache_Hallo_Ahnung()
{
	AI_Output (other, self, "DIA_1061_Wache_Hallo_Ahnung_15_00");	//No idea.
	AI_Output (self, other, "DIA_1061_Wache_Hallo_Ahnung_01_01");	//Then you'll die ignorant.
	Info_ClearChoices (DIA_1061_Wache_Hallo);
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_SuddenEnemyInferno, 0);
};


instance DIA_1061_Wache_Perm(C_Info)
{
	npc = BDT_1061_Wache;
	nr = 2;
	condition = DIA_1061_Wache_Perm_Condition;
	information = DIA_1061_Wache_Perm_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_1061_Wache_Perm_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Knows_Dexter == TRUE))
	{
		return TRUE;
	};
};

func void DIA_1061_Wache_Perm_Info()
{
	AI_Output (self, other, "DIA_1061_Wache_Perm_01_00");	//Remember, stay cool and you'll get out of here alive.
	AI_StopProcessInfos (self);
};

