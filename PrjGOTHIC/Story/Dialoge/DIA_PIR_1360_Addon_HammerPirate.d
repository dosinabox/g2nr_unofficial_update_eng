
instance DIA_Addon_HammerPirate_EXIT(C_Info)
{
	npc = PIR_1360_Addon_Pirat;
	nr = 999;
	condition = DIA_Addon_HammerPirate_EXIT_Condition;
	information = DIA_Addon_HammerPirate_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_HammerPirate_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_HammerPirate_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_HammerPirate_Hello(C_Info)
{
	npc = PIR_1360_Addon_Pirat;
	nr = 1;
	condition = DIA_Addon_HammerPirate_Hello_Condition;
	information = DIA_Addon_HammerPirate_Hello_Info;
	permanent = TRUE;
	description = "Все в порядке?";
};


func int DIA_Addon_HammerPirate_Hello_Condition()
{
	return TRUE;
};

func void DIA_Addon_HammerPirate_Hello_Info()
{
	AI_Output(other,self,"DIA_Addon_HammerPirate_Hello_15_00");	//Everything ship-shape?
	if(self.aivar[AIV_PARTYMEMBER] == TRUE)
	{
		if(C_TowerBanditsDead())
		{
			AI_Output(self,other,"DIA_Addon_HammerPirate_Hello_07_01");	//Sure, now that we've got that over with. Those scumbags are as flat as flounders!
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_HammerPirate_Hello_07_02");	//Let's get it over with!
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_HammerPirate_Hello_07_03");	//No! Hammering's just not my thing.
	};
};


instance DIA_Addon_HammerPirate_Anheuern(C_Info)
{
	npc = PIR_1360_Addon_Pirat;
	nr = 11;
	condition = DIA_Addon_HammerPirate_Anheuern_Condition;
	information = DIA_Addon_HammerPirate_Anheuern_Info;
	permanent = FALSE;
	description = "You're supposed to help me.";
};


func int DIA_Addon_HammerPirate_Anheuern_Condition()
{
	if(MIS_Henry_FreeBDTTower == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_HammerPirate_Anheuern_Info()
{
	AI_Output(other,self,"DIA_Addon_Skip_Anheuern_15_00");	//You're supposed to help me.
	AI_Output(self,other,"DIA_Addon_HammerPirate_Anheuern_07_00");	//Don't tell me! You want me to come along and help you flatten those bandits!
	AI_Output(other,self,"DIA_Addon_PIR_6_JoinHenry_15_08");	//You got it.
	if(!Npc_IsDead(SawPirate))
	{
		AI_Output(self,other,"DIA_Addon_HammerPirate_Anheuern_07_01");	//Why don't you ask the guy who's manning the saw?
	};
	AI_Output(self,other,"DIA_Addon_HammerPirate_Anheuern_07_02");	//I... can't use all this stress...
};


instance DIA_Addon_HammerPirate_ComeOn(C_Info)
{
	npc = PIR_1360_Addon_Pirat;
	nr = 12;
	condition = DIA_Addon_HammerPirate_ComeOn_Condition;
	information = DIA_Addon_HammerPirate_ComeOn_Info;
	permanent = TRUE;
	description = "Пойдем со мной.";
};


func int DIA_Addon_HammerPirate_ComeOn_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == FALSE) && (MIS_Henry_FreeBDTTower == LOG_Running) && !C_TowerBanditsDead() && Npc_KnowsInfo(other,DIA_Addon_HammerPirate_Anheuern))
	{
		return TRUE;
	};
};

func void DIA_Addon_HammerPirate_ComeOn_Info()
{
	AI_Output(other,self,"DIA_Addon_HammerPirate_ComeOn_15_00");	//Come with me.
	if(SawPirate.aivar[AIV_PARTYMEMBER] == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_HammerPirate_ComeOn_07_01");	//Henry needs one of us to stay HERE...
	}
	else if(Npc_GetDistToWP(self,"ADW_PIRATECAMP_WAY_08") > 6000)
	{
		AI_Output(self,other,"DIA_Addon_HammerPirate_ComeOn_07_02");	//Let's go back a little towards the camp first.
		AI_StopProcessInfos(self);
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_HammerPirate_ComeOn_07_03");	//(sighs) Aye aye...
		AI_StopProcessInfos(self);
		Npc_ExchangeRoutine(self,"FOLLOW");
		self.aivar[AIV_PARTYMEMBER] = TRUE;
	};
};


instance DIA_Addon_HammerPirate_GoHome(C_Info)
{
	npc = PIR_1360_Addon_Pirat;
	nr = 13;
	condition = DIA_Addon_HammerPirate_GoHome_Condition;
	information = DIA_Addon_HammerPirate_GoHome_Info;
	permanent = TRUE;
	description = "I no longer need you.";
};


func int DIA_Addon_HammerPirate_GoHome_Condition()
{
	if(self.aivar[AIV_PARTYMEMBER] == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_HammerPirate_GoHome_Info()
{
	AI_Output(other,self,"DIA_Addon_HammerPirate_GoHome_15_00");	//I no longer need you.
	AI_Output(self,other,"DIA_Addon_HammerPirate_GoHome_07_01");	//If you say so...
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
};


instance DIA_Addon_HammerPirate_TooFar(C_Info)
{
	npc = PIR_1360_Addon_Pirat;
	nr = 14;
	condition = DIA_Addon_HammerPirate_TooFar_Condition;
	information = DIA_Addon_HammerPirate_TooFar_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_HammerPirate_TooFar_Condition()
{
	if((self.aivar[AIV_PARTYMEMBER] == TRUE) && (Npc_GetDistToWP(self,"ADW_PIRATECAMP_WAY_08") > 6000))
	{
		return TRUE;
	};
};

func void DIA_Addon_HammerPirate_TooFar_Info()
{
	AI_Output (self, other, "DIA_Addon_HammerPirate_TooFar_07_01");	//If you want to continue in that direction, don't let me keep you...
	AI_Output (self, other, "DIA_Addon_HammerPirate_GoHome_07_02");	//I think I'll be headed back now.
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
	AI_StopProcessInfos(self);
};


instance DIA_Addon_HammerPirate_Success(C_Info)
{
	npc = PIR_1360_Addon_Pirat;
	nr = 14;
	condition = DIA_Addon_HammerPirate_Success_Condition;
	information = DIA_Addon_HammerPirate_Success_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_HammerPirate_Success_Condition()
{
	if(C_TowerBanditsDead() && (self.aivar[AIV_PARTYMEMBER] == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_HammerPirate_Success_Info()
{
	AI_Output (self, other, "DIA_Addon_HammerPirate_Success_07_01");	//You know what - I've been doing some thinking. You're not such a bad sort!
	AI_Output (self, other, "DIA_Addon_HammerPirate_Success_07_02");	//I'm headed back to the camp, then. See ya!
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"START");
	AI_StopProcessInfos(self);
};

