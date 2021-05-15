
instance DIA_1017_BANDIT_EXIT(C_Info)
{
	npc = BDT_1024_MalethsBandit;
	nr = 999;
	condition = DIA_1017_BANDIT_EXIT_Condition;
	information = DIA_1017_BANDIT_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_1017_BANDIT_EXIT_Condition()
{
	return TRUE;
};

func void DIA_1017_BANDIT_EXIT_Info()
{
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_SuddenEnemyInferno,1);
	self.aivar[AIV_IgnoresArmor] = TRUE;
	//ch1
	if(!Npc_IsDead(BDT_1001_Bandit_L)) //уникальный в мире
	{
		BDT_1001_Bandit_L.aivar[AIV_IgnoresArmor] = TRUE;
		B_Attack(BDT_1001_Bandit_L,other,AR_SuddenEnemyInferno,1);
	};
	if(!Npc_IsDead(BDT_1017_Bandit_L)) //уникальный неиспользуемый
	{
		BDT_1017_Bandit_L.aivar[AIV_IgnoresArmor] = TRUE;
		B_Attack(BDT_1017_Bandit_L,other,AR_SuddenEnemyInferno,1);
	};
	if(!Npc_IsDead(BDT_1012_Bandit_L)) //новый
	{
		BDT_1012_Bandit_L.aivar[AIV_IgnoresArmor] = TRUE;
		B_Attack(BDT_1012_Bandit_L,other,AR_SuddenEnemyInferno,1);
	};
	if(!Npc_IsDead(BDT_1018_Bandit_L)) //новый
	{
		BDT_1018_Bandit_L.aivar[AIV_IgnoresArmor] = TRUE;
		B_Attack(BDT_1018_Bandit_L,other,AR_SuddenEnemyInferno,1);
	};
	//ch3
	if(!Npc_IsDead(BDT_1004_Bandit_M)) //уникальный в мире
	{
		BDT_1004_Bandit_M.aivar[AIV_IgnoresArmor] = TRUE;
		B_Attack(BDT_1004_Bandit_M,other,AR_SuddenEnemyInferno,1);
	};
	if(!Npc_IsDead(BDT_1006_Bandit_H)) //уникальный в мире
	{
		BDT_1006_Bandit_H.aivar[AIV_IgnoresArmor] = TRUE;
	};
	if(!Npc_IsDead(BDT_1007_Bandit_H)) //уникальный в мире
	{
		BDT_1007_Bandit_H.aivar[AIV_IgnoresArmor] = TRUE;
	};
	if(!Npc_IsDead(BDT_1008_Bandit_H)) //уникальный в мире
	{
		BDT_1008_Bandit_H.aivar[AIV_IgnoresArmor] = TRUE;
		B_Attack(BDT_1008_Bandit_H,other,AR_SuddenEnemyInferno,1);
	};
	if(!Npc_IsDead(BDT_1016_Bandit_M)) //уникальный неиспользуемый
	{
		BDT_1016_Bandit_M.aivar[AIV_IgnoresArmor] = TRUE;
		B_Attack(BDT_1016_Bandit_M,other,AR_SuddenEnemyInferno,1);
	};
};


instance DIA_1017_BANDIT_AMBUSH(C_Info)
{
	npc = BDT_1024_MalethsBandit;
	nr = 2;
	condition = DIA_1017_BANDIT_AMBUSH_Condition;
	information = DIA_1017_BANDIT_AMBUSH_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_1017_BANDIT_AMBUSH_Condition()
{
	return TRUE;
};

func void DIA_1017_BANDIT_AMBUSH_Info()
{
	AI_Output(self,other,"DIA_Canthar_Hallo_09_00");	//Who do we have here then?
	B_UseFakeHeroFace(self,other);
	B_Say(self,other,"$IGETYOUSTILL");
	AI_Output(other,self,"DIA_Attila_Willkommen_15_01");	//Who are you, and what do you want from me?
	AI_Output(self,other,"DIA_Addon_Dexter_Hallo_09_06");	//Me? Nothing whatsoever. But my boss is hell-bent on seeing you dead.
	AI_Output(other,self,"DIA_Attila_Hallo_Warum_15_00");	//Why do you want to kill me?
	AI_Output(self,other,"DIA_Dexter_Hallo_09_05");	//When i tried to escape the Valley of Mines, the soldiers discovered me and drove me into a trap.
	AI_Output(self,other,"DIA_Dexter_Hallo_09_06");	//I thought I was done for, but then suddenly this... figure appeared out of the darkness.
	AI_Output(self,other,"DIA_Dexter_Hallo_09_07");	//He wore a black robe with a hood and a mask over his face. And he spoke with a voice that was altogether not human.
	AI_Output(self,other,"DIA_Dexter_Hallo_09_08");	//But he offered me his help. he brought me out of the valley, and offered me a thousand gold pieces for your head.
	AI_Output(self,other,"DIA_Dexter_Hallo_09_09");	//Hey, what was I supposed to do? If I'd turned him down, he'd have killed me!
	AI_Output(other,self,"DIA_Dexter_Wo_15_00");	//Where can I find this man?
	AI_Output(self,other,"DIA_Dexter_Wo_09_02");	//The guy is here, and he's not alone. There's a whole mob of those boys everywhere, and they're looking for you.
	AI_Output(self,other,"DIA_Dexter_Kill_09_00");	//I warned you, if I don't kill you, he'll kill me. So, you leave me no choice.
};

