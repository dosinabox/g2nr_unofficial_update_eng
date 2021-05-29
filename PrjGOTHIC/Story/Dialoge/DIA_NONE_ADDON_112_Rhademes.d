
instance DIA_Addon_Rhademes_EXIT(C_Info)
{
	npc = NONE_ADDON_112_Rhademes;
	nr = 999;
	condition = DIA_Addon_Rhademes_EXIT_Condition;
	information = DIA_Addon_Rhademes_EXIT_Info;
	permanent = TRUE;
	description = "I shall find my own way! (THE END)";
};


func int DIA_Addon_Rhademes_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Rhademes_EXIT_Info()
{
	AI_Output (other, self, "DIA_Addon_Rhademes_EXIT_15_00");	//I'll find a way myself!
	AI_Output (self, other, "DIA_Addon_Rhademes_EXIT_03_01");	//As you will ...
	AI_StopProcessInfos (self);
};


var int Rhademes_Understood;

instance DIA_Addon_Rhademes_First(C_Info)
{
	npc = NONE_ADDON_112_Rhademes;
	nr = 1;
	condition = DIA_Addon_Rhademes_First_Condition;
	information = DIA_Addon_Rhademes_First_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Rhademes_First_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Rhademes_Understood == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Rhademes_First_Info()
{
	if(PLAYER_TALENT_FOREIGNLANGUAGE[LANGUAGE_1] == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Rhademes_First_03_00");	//My spirit has been held captive for an eternity.
		AI_Output (self, other, "DIA_Addon_Rhademes_First_03_01");	//At last I am free. The sword has a NEW bearer.
		AI_Output (self, other, "DIA_Addon_Rhademes_First_03_02");	//The final chamber has been opened.
		AI_Output (other, self, "DIA_Addon_Rhademes_First_15_03");	//But the gate appears closed!
		AI_Output (self, other, "DIA_Addon_Rhademes_First_03_04");	//This is not the gate to the final chamber.
		AI_Output (self, other, "DIA_Addon_Rhademes_First_03_05");	//THIS gate merely leads to the antechamber.
		AI_Output (self, other, "DIA_Addon_Rhademes_First_03_06");	//The bearer... has closed it behind him.
		Rhademes_Understood = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Rhademes_First_03_07");	//(strained) Ghanima en Kandra Adanos?!
		B_Say (other, self, "$CANTUNDERSTANDTHIS");
		AI_Output (self, other, "DIA_Addon_Rhademes_First_03_08");	//(angry) Bengla anthani!
		AI_StopProcessInfos (self);
	};
};


instance DIA_Addon_Rhademes_Pforte(C_Info)
{
	npc = NONE_ADDON_112_Rhademes;
	nr = 2;
	condition = DIA_Addon_Rhademes_Pforte_Condition;
	information = DIA_Addon_Rhademes_Pforte_Info;
	permanent = FALSE;
	description = "How do I open the gate?";
};


func int DIA_Addon_Rhademes_Pforte_Condition()
{
	return TRUE;
};

func void DIA_Addon_Rhademes_Pforte_Info()
{
	AI_Output (other, self, "DIA_Addon_Rhademes_Pforte_15_00");	//How do I open the gate?
	AI_Output (self, other, "DIA_Addon_Rhademes_Pforte_03_01");	//Move... one of the levers.
	AI_Output (other, self, "DIA_Addon_Rhademes_Pforte_15_02");	//Any one?
	AI_Output (self, other, "DIA_Addon_Rhademes_Pforte_03_03");	//All of these levers open the gate.
};


instance DIA_Addon_Rhademes_Hebel(C_Info)
{
	npc = NONE_ADDON_112_Rhademes;
	nr = 3;
	condition = DIA_Addon_Rhademes_Hebel_Condition;
	information = DIA_Addon_Rhademes_Hebel_Info;
	permanent = FALSE;
	description = "Not all of the levers trigger the trap, right?";
};


func int DIA_Addon_Rhademes_Hebel_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Rhademes_Pforte) && !Npc_KnowsInfo(other,DIA_Addon_Rhademes_DeinVater))
	{
		return TRUE;
	};
};

func void DIA_Addon_Rhademes_Hebel_Info()
{
	AI_Output(other,self,"DIA_Addon_Rhademes_Hebel_15_00");	//Not all of the levers trigger the trap, right?
	AI_Output(self,other,"DIA_Addon_Rhademes_Hebel_03_01");	//Yes, they do!
};


instance DIA_Addon_Rhademes_DontBelieve(C_Info)
{
	npc = NONE_ADDON_112_Rhademes;
	nr = 4;
	condition = DIA_Addon_Rhademes_DontBelieve_Condition;
	information = DIA_Addon_Rhademes_DontBelieve_Info;
	permanent = FALSE;
	description = "I don't believe you!";
};


func int DIA_Addon_Rhademes_DontBelieve_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Rhademes_Pforte) && !Npc_KnowsInfo(other,DIA_Addon_Rhademes_DeinVater))
	{
		return TRUE;
	};
};

func void DIA_Addon_Rhademes_DontBelieve_Info()
{
	AI_Output (other, self, "DIA_Addon_Rhademes_DontBelieve_15_00");	//I don't believe you!
	AI_Output (self, other, "DIA_Addon_Rhademes_DontBelieve_03_01");	//Yet, I... speak only the truth.
};


instance DIA_Addon_Rhademes_DeinVater(C_Info)
{
	npc = NONE_ADDON_112_Rhademes;
	nr = 5;
	condition = DIA_Addon_Rhademes_DeinVater_Condition;
	information = DIA_Addon_Rhademes_DeinVater_Info;
	permanent = FALSE;
	description = "Your father built the trap, how would YOU know how it works?!";
};


func int DIA_Addon_Rhademes_DeinVater_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Rhademes_Pforte) && (SC_KnowsRhademesTrapDetails == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Rhademes_DeinVater_Info()
{
	AI_Output (other, self, "DIA_Addon_Rhademes_DeinVater_15_00");	//Your father built the trap, how would YOU know how it works?!
	AI_Output (self, other, "DIA_Addon_Rhademes_DeinVater_03_01");	//QUARHODRON! I can still hear the pounding of the hammers... on the other side of the gate... after so long a time...
	AI_Output (self, other, "DIA_Addon_Rhademes_DeinVater_03_02");	//The sword... showed me... revenge... for my failure...
	AI_Output (other, self, "DIA_Addon_Rhademes_DeinVater_15_03");	//You mean you have seen which lever is the right one?
	AI_Output (self, other, "DIA_Addon_Rhademes_DeinVater_03_04");	//I have long forgotten it.
	Info_ClearChoices (DIA_Addon_Rhademes_DeinVater);
	Info_AddChoice (DIA_Addon_Rhademes_DeinVater, "Then guess!", DIA_Addon_Rhademes_DeinVater_Guess);
	Info_AddChoice (DIA_Addon_Rhademes_DeinVater, "Try to remember!", DIA_Addon_Rhademes_DeinVater_Remember);
	Info_AddChoice (DIA_Addon_Rhademes_DeinVater, "Think!", DIA_Addon_Rhademes_DeinVater_Think);
};


func void B_Addon_Rhademes_Lever(var int Choice)
{
	AI_Output (self, other, "DIA_Addon_Rhademes_Lever_03_00");	//It was so long ago...
	AI_StopProcessInfos (self);
	if (Choice <= 1)
	{
		AI_GotoWP(self,"ADW_ADANOSTEMPEL_RHADEMES_04");
	}
	else if(Choice == 2)
	{
		AI_GotoWP(self,"ADW_ADANOSTEMPEL_RHADEMES_06");
	}
	else
	{
		AI_GotoWP(self,"ADW_ADANOSTEMPEL_RHADEMES_08");
	};
	AI_UseMob(self,"LEVER",1);
	AI_TurnToNPC(self,hero);
	Npc_ExchangeRoutine(self,"Wait");
	Rhademes_fertig = TRUE;
};

func void DIA_Addon_Rhademes_DeinVater_Think()
{
	AI_Output (other, self, "DIA_Addon_Rhademes_DeinVater_Think_15_00");	//Think!
	B_Addon_Rhademes_Lever (1);
};

func void DIA_Addon_Rhademes_DeinVater_Remember()
{
	AI_Output (other, self, "DIA_Addon_Rhademes_DeinVater_Remember_15_00");	//Try to remember!
	B_Addon_Rhademes_Lever (2);
};

func void DIA_Addon_Rhademes_DeinVater_Guess()
{
	AI_Output (other, self, "DIA_Addon_Rhademes_DeinVater_Guess_15_00");	//Then guess!
	B_Addon_Rhademes_Lever (3);
};


instance DIA_Addon_Rhademes_PERM(C_Info)
{
	npc = NONE_ADDON_112_Rhademes;
	nr = 2;
	condition = DIA_Addon_Rhademes_PERM_Condition;
	information = DIA_Addon_Rhademes_PERM_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Rhademes_PERM_Condition()
{
	if(Rhademes_fertig == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Rhademes_PERM_Info()
{
	AI_Output (self, other, "DIA_Addon_Rhademes_PERM_03_00");	//If you have the strength... sink it... in the depths of the sea...
	SC_TalkedToRhademAfter = TRUE;
	AI_StopProcessInfos(self);
};

