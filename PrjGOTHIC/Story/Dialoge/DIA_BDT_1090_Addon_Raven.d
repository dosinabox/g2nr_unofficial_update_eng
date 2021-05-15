
instance DIA_Addon_Raven_EXIT(C_Info)
{
	npc = BDT_1090_Addon_Raven;
	nr = 999;
	condition = DIA_Addon_Raven_EXIT_Condition;
	information = DIA_Addon_Raven_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Raven_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Raven_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Raven_Hi(C_Info)
{
	npc = BDT_1090_Addon_Raven;
	nr = 1;
	condition = DIA_Addon_Raven_Hi_Condition;
	information = DIA_Addon_Raven_Hi_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Raven_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Raven_Hi_Info()
{
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_00");	//Look who has come.
	if (C_BodyStateContains (self, BS_SIT))
	{
		Npc_StopAni(self,"T_PRAY_RANDOM");
		AI_PlayAniBS(self,"T_PRAY_2_STAND",BS_STAND);
		AI_TurnToNPC(self,other);
	};
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_01");	//My master warned me that Innos would send his henchmen.
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_02");	//But I had not expected that you would appear so soon.
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_03");	//Well, since you were so quick (laughs), I shall give you a quick death.
	Info_ClearChoices (DIA_Addon_Raven_Hi);
	Info_AddChoice (DIA_Addon_Raven_Hi, "YOU are the one who is going to die.", DIA_Addon_Raven_Hi_DU);
	Info_AddChoice (DIA_Addon_Raven_Hi, "You sold your soul to Beliar!", DIA_Addon_Raven_Hi_Soul);
};

func void DIA_Addon_Raven_Hi_DU()
{
	AI_Output (other, self, "DIA_Addon_Raven_Add_15_00");	//YOU are the one who is going to die.
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_04");	//(laughs) You are no threat to me. I bear Beliar's sword.
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_05");	//I shall lead the dragons to the mainland. Together we will plunge the world of men into the deepest darkness.
};

func void DIA_Addon_Raven_Hi_Soul()
{
	AI_Output (other, self, "DIA_Addon_Raven_Add_15_01");	//You sold your soul to Beliar!
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_06");	//For a good price. I will command his armies as a general.
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_07");	//And what about you? Do you know how much YOUR soul is worth?
	Info_ClearChoices (DIA_Addon_Raven_Hi);
	Info_AddChoice (DIA_Addon_Raven_Hi, "I've had it. Let us begin...", DIA_Addon_Raven_Hi_Attack);
	Info_AddChoice (DIA_Addon_Raven_Hi, "I'm only doing what has to be done.", DIA_Addon_Raven_Hi_only);
};

func void DIA_Addon_Raven_Hi_only()
{
	AI_Output (other, self, "DIA_Addon_Raven_Add_15_02");	//I'm only doing what has to be done.
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_08");	//(laughs) Listen to him. You have sent me a humble servant, Innos! (laughs loud)
	Info_ClearChoices (DIA_Addon_Raven_Hi);
	Info_AddChoice (DIA_Addon_Raven_Hi, "I've had it. Let us begin...", DIA_Addon_Raven_Hi_Attack);
	Info_AddChoice (DIA_Addon_Raven_Hi, "Are you sure that I am a servant of Innos?", DIA_Addon_Raven_Hi_Sure);
};

func void DIA_Addon_Raven_Hi_Sure()
{
	AI_Output (other, self, "DIA_Addon_Raven_Add_15_03");	//Are you sure that I am a servant of Innos?
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_09");	//What? What are you saying?
	AI_Output (other, self, "DIA_Addon_Raven_Add_15_04");	//Don't you consider it possible that I could be a servant of Adanos?
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_10");	//(laughs) Nonsense!
	AI_Output (other, self, "DIA_Addon_Raven_Add_15_05");	//Maybe I ALSO serve Beliar - or only myself.
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_11");	//(sneering) Well, in that case, you are not even a worthy opponent for me!
	Info_ClearChoices (DIA_Addon_Raven_Hi);
	Info_AddChoice (DIA_Addon_Raven_Hi, "I've had it. Let us begin...", DIA_Addon_Raven_Hi_Attack);
};

func void DIA_Addon_Raven_Hi_Attack()
{
	AI_Output (other, self, "DIA_Addon_Raven_Add_15_06");	//I've had it. Let us begin...
	AI_Output (self, other, "DIA_Addon_Raven_Add_10_12");	//(sneering) Are you in such a hurry to die? Well, since you insist...
	self.aivar[AIV_EnemyOverride] = FALSE;
	Npc_ExchangeRoutine(self,"WaitForPlayer");
	Raven_Awaken = TRUE;
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_SuddenEnemyInferno,1);
};

