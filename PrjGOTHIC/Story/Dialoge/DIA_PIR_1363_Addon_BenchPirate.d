
instance DIA_Addon_BenchPirate_EXIT(C_Info)
{
	npc = PIR_1363_Addon_Pirat;
	nr = 999;
	condition = DIA_Addon_BenchPirate_EXIT_Condition;
	information = DIA_Addon_BenchPirate_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_BenchPirate_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_BenchPirate_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_BenchPirate_Hello(C_Info)
{
	npc = PIR_1363_Addon_Pirat;
	nr = 1;
	condition = DIA_Addon_BenchPirate_Hello_Condition;
	information = DIA_Addon_BenchPirate_Hello_Info;
	permanent = TRUE;
	description = "How are things?";
};


func int DIA_Addon_BenchPirate_Hello_Condition()
{
	return TRUE;
};

func void DIA_Addon_BenchPirate_Hello_Info()
{
	var int randy;
	AI_Output(other,self,"DIA_Addon_Pir_7_Hello_15_00");	//How are things?
	randy = Hlp_Random(3);
	if(GregIsBack == TRUE)
	{
		if(!Npc_IsDead(Greg))
		{
			if(randy == 0)
			{
				AI_Output(self,other,"DIA_Addon_Pir_7_Hello_07_01");	//Greg's back at last. And none too soon.
			}
			else if(randy == 1)
			{
				AI_Output(self,other,"DIA_Addon_Pir_7_Hello_07_02");	//Francis should get some wood for the palisade. Hope that's not too much for him.
			}
			else
			{
				AI_Output(self,other,"DIA_Addon_Pir_7_Hello_07_03");	//Bring on the bandits, then. With Greg by our side, we're not afraid of them.
			};
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_BenchPirate_GoHome_07_02");	//I don't like this at all.
		};
	}
	else if(randy == 0)
	{
		AI_Output(self,other,"DIA_Addon_Pir_7_Hello_07_04");	//Francis, the camp leader, is nothing but a clown. How can anyone take him seriously?
	}
	else if(randy == 1)
	{
		AI_Output(self,other,"DIA_Addon_Pir_7_Hello_07_05");	//Greg trusts Francis because he's too dumb to cheat! But to make him our leader for that...
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Pir_7_Hello_07_06");	//If Greg doesn't come back soon and I don't get a deck under my feet before too long, I'll be getting landsick!
	};
};


instance DIA_Addon_BenchPirate_Anheuern(C_Info)
{
	npc = PIR_1363_Addon_Pirat;
	nr = 11;
	condition = DIA_Addon_BenchPirate_Anheuern_Condition;
	information = DIA_Addon_BenchPirate_Anheuern_Info;
	permanent = FALSE;
	description = "You're supposed to help me.";
};


func int DIA_Addon_BenchPirate_Anheuern_Condition()
{
	if(MIS_Addon_Greg_ClearCanyon == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_BenchPirate_Anheuern_Info()
{
	AI_Output (other, self, "DIA_Addon_BenchPirate_Anheuern_15_00");	//You're supposed to help me.
	AI_Output (self, other, "DIA_Addon_BenchPirate_Anheuern_07_01");	//Orders from Greg?
	AI_Output (other, self, "DIA_Addon_BenchPirate_Anheuern_15_08");	//You've got it.
};


instance DIA_Addon_BenchPirate_ComeOn(C_Info)
{
	npc = PIR_1363_Addon_Pirat;
	nr = 12;
	condition = DIA_Addon_BenchPirate_ComeOn_Condition;
	information = DIA_Addon_BenchPirate_ComeOn_Info;
	permanent = TRUE;
	description = "The canyon awaits.";
};


func int DIA_Addon_BenchPirate_ComeOn_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == FALSE) && (MIS_Addon_Greg_ClearCanyon == LOG_Running) && Npc_KnowsInfo(other,DIA_Addon_BenchPirate_Anheuern))
	{
		return TRUE;
	};
};

func void DIA_Addon_BenchPirate_ComeOn_Info()
{
	AI_Output(other,self,"DIA_Addon_BenchPirate_ComeOn_15_01");	//The canyon awaits.
	if(C_GregsPiratesTooFar())
	{
		AI_Output(self,other,"DIA_Addon_BenchPirate_ComeOn_07_02");	//That's exactly where I'm headed back to...
		AI_StopProcessInfos(self);
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_BenchPirate_ComeOn_07_01");	//Aye aye, Cap'n!
		if(C_BodyStateContains(self,BS_SIT))
		{
			AI_Standup(self);
			B_TurnToNpc(self,other);
		};
		AI_StopProcessInfos(self);
		B_Addon_PiratesFollowAgain();
		Npc_ExchangeRoutine(self,"FOLLOW");
		self.aivar[AIV_PARTYMEMBER] = TRUE;
	};
};


instance DIA_Addon_BenchPirate_GoHome(C_Info)
{
	npc = PIR_1363_Addon_Pirat;
	nr = 13;
	condition = DIA_Addon_BenchPirate_GoHome_Condition;
	information = DIA_Addon_BenchPirate_GoHome_Info;
	permanent = TRUE;
	description = "I no longer need you.";
};


func int DIA_Addon_BenchPirate_GoHome_Condition()
{
	if(self.aivar[AIV_PARTYMEMBER] == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_BenchPirate_GoHome_Info()
{
	AI_Output (other, self, "DIA_Addon_BenchPirate_GoHome_15_00");	//I no longer need you.
	AI_Output (self, other, "DIA_Addon_BenchPirate_GoHome_07_01");	//I'm back in camp, Cap'n!
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
};


instance DIA_Addon_BenchPirate_TooFar(C_Info)
{
	npc = PIR_1363_Addon_Pirat;
	nr = 14;
	condition = DIA_Addon_BenchPirate_TooFar_Condition;
	information = DIA_Addon_BenchPirate_TooFar_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_BenchPirate_TooFar_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == TRUE) && C_GregsPiratesTooFar())
	{
		return TRUE;
	};
};

func void DIA_Addon_BenchPirate_TooFar_Info()
{
	AI_Output (self, other, "DIA_Addon_BenchPirate_TooFar_07_01");	//We're too far away from the camp.
	AI_Output (self, other, "DIA_Addon_BenchPirate_GoHome_07_02");	//I don't like this at all.
	if(C_HowManyPiratesInParty() >= 2)
	{
		AI_Output(self,other,"DIA_Addon_Matt_TooFar_07_03");	//I'm headed back to the camp!
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Matt_TooFar_07_02");	//The boys and I are headed back for camp!
	};
	B_Addon_PiratesGoHome();
	AI_StopProcessInfos(self);
};

