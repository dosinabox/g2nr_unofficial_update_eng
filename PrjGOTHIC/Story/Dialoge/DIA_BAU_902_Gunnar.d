
instance DIA_Gunnar_EXIT(C_Info)
{
	npc = BAU_902_Gunnar;
	nr = 999;
	condition = DIA_Gunnar_EXIT_Condition;
	information = DIA_Gunnar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Gunnar_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Gunnar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Gunnar_GuildComment(C_Info)
{
	npc = BAU_902_Gunnar;
	nr = 1;
	condition = DIA_Gunnar_GuildComment_Condition;
	information = DIA_Gunnar_GuildComment_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Gunnar_GuildComment_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && ((other.guild == GIL_SLD) || (other.guild == GIL_DJG) || (other.guild == GIL_NOV) || (other.guild == GIL_KDF) || (other.guild == GIL_MIL) || (other.guild == GIL_PAL)))
	{
		return TRUE;
	};
};

func void DIA_Gunnar_GuildComment_Info()
{
	if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		AI_Output(self,other,"DIA_Gunnar_Hallo_10_04");	//So you're a mercenary now too, hm?
	}
	else if((other.guild == GIL_NOV) || (other.guild == GIL_KDF))
	{
		AI_Output(self,other,"DIA_Gunnar_Hallo_10_05");	//Innos be with you!
	}
	else if((other.guild == GIL_MIL) || (other.guild == GIL_PAL))
	{
		AI_Output(self,other,"DIA_Gunnar_Hallo_10_06");	//People from the city aren't welcome here.
	};
};


var int Gunnar_HalloGesagt;
var int Gunnar_ToldAboutSLD;

instance DIA_Gunnar_Hallo(C_Info)
{
	npc = BAU_902_Gunnar;
	nr = 1;
	condition = DIA_Gunnar_Hallo_Condition;
	information = DIA_Gunnar_Hallo_Info;
	permanent = TRUE;
	description = "What's up?";
};


func int DIA_Gunnar_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Gunnar_Hallo_Info()
{
	AI_Output(other,self,"DIA_Gunnar_Hallo_15_00");	//What's up?
	if((other.guild != GIL_SLD) && (other.guild != GIL_DJG) && (Gunnar_ToldAboutSLD == FALSE))
	{
		AI_Output (self, other, "DIA_Gunnar_Hallo_10_01");	//Since Onar announced he was hiring mercenaries, the court has been overflowing with nothing but rogues.
		AI_Output (self, other, "DIA_Gunnar_Hallo_10_02");	//All the rabble who didn't have the guts to come out of the woods before are here now.
		AI_Output (self, other, "DIA_Gunnar_Hallo_10_03");	//The bastards really came from everywhere...
		Gunnar_ToldAboutSLD = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Gunnar_Hallo_10_03_add");	//Times are tough...
	};
	Gunnar_HalloGesagt = TRUE;
};


instance DIA_Gunnar_Everywhere(C_Info)
{
	npc = BAU_902_Gunnar;
	nr = 2;
	condition = DIA_Gunnar_Everywhere_Condition;
	information = DIA_Gunnar_Everywhere_Info;
	permanent = FALSE;
	description = "The mercenaries came from everywhere?";
};


func int DIA_Gunnar_Everywhere_Condition()
{
	if(Gunnar_HalloGesagt == TRUE)
	{
		if(Gunnar_ToldAboutSLD == TRUE)
		{
			DIA_Gunnar_Everywhere.description = "The mercenaries came from everywhere?";
		}
		else
		{
			DIA_Gunnar_Everywhere.description = "What do you know about the mercenaries?";
		};
		return TRUE;
	};
};

func void DIA_Gunnar_Everywhere_Info()
{
	if(Gunnar_ToldAboutSLD == TRUE)
	{
		AI_Output(other,self,"DIA_Gunnar_Everywhere_15_00");	//The mercenaries came from everywhere?
	}
	else
	{
		DIA_Common_TellMeAboutSLD();
	};
	AI_Output (self, other, "DIA_Gunnar_Everywhere_10_01");	//Most of them came from the penal colony.
	AI_Output (self, other, "DIA_Gunnar_Everywhere_10_02");	//Another group of mercenaries came from the south, where they were probably hunting orcs.
	AI_Output (self, other, "DIA_Gunnar_Everywhere_10_03");	//And I bet that a few bandits from the mountains have shown up as well by now to get a free meal!
};


instance DIA_Gunnar_South(C_Info)
{
	npc = BAU_902_Gunnar;
	nr = 3;
	condition = DIA_Gunnar_South_Condition;
	information = DIA_Gunnar_South_Info;
	permanent = FALSE;
	description = "What do you know about the mercenaries from the south?";
};


func int DIA_Gunnar_South_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gunnar_Everywhere))
	{
		return TRUE;
	};
};

func void DIA_Gunnar_South_Info()
{
	AI_Output (other, self, "DIA_Gunnar_South_15_00");	//What do you know about the mercenaries from the south?
	AI_Output (self, other, "DIA_Gunnar_South_10_01");	//Not much. So far as I know, they were hunting orcs there.
	AI_Output (self, other, "DIA_Gunnar_South_10_02");	//Sylvio is their boss. Bullco, Sentenza, Raoul and a few others work for him...
};


instance DIA_Gunnar_Colony(C_Info)
{
	npc = BAU_902_Gunnar;
	nr = 4;
	condition = DIA_Gunnar_Colony_Condition;
	information = DIA_Gunnar_Colony_Info;
	permanent = FALSE;
	description = "Which one of them came from the colony?";
};


func int DIA_Gunnar_Colony_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gunnar_Everywhere))
	{
		return TRUE;
	};
};

func void DIA_Gunnar_Colony_Info()
{
	AI_Output (other, self, "DIA_Gunnar_Colony_15_00");	//Which one of them came from the colony?
	AI_Output (self, other, "DIA_Gunnar_Colony_10_01");	//Lee and his people. Torlof, Cord, Jarvis, Wolf and whoever else.
};


instance DIA_Gunnar_Bandits(C_Info)
{
	npc = BAU_902_Gunnar;
	nr = 5;
	condition = DIA_Gunnar_Bandits_Condition;
	information = DIA_Gunnar_Bandits_Info;
	permanent = FALSE;
	description = "What bandits were you talking about?";
};


func int DIA_Gunnar_Bandits_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gunnar_Everywhere))
	{
		return TRUE;
	};
};

func void DIA_Gunnar_Bandits_Info()
{
	AI_Output (other, self, "DIA_Gunnar_Bandits_15_00");	//What bandits were you talking about?
	AI_Output (self, other, "DIA_Gunnar_Bandits_10_01");	//Ah, I'm just blabbering. I'm not really sure about it.
	AI_Output (self, other, "DIA_Gunnar_Bandits_10_02");	//There are mountains with abandoned mines south of the valley. Some bandits are hiding up there.
	AI_Output (self, other, "DIA_Gunnar_Bandits_10_03");	//They are also convicts from the colony, just like most of the mercenaries in this court.
	AI_Output (self, other, "DIA_Gunnar_Bandits_10_04");	//The only difference is that they're even worse scum. They kill anyone who gets too close.
};


instance DIA_Gunnar_PICKPOCKET(C_Info)
{
	npc = BAU_902_Gunnar;
	nr = 900;
	condition = DIA_Gunnar_PICKPOCKET_Condition;
	information = DIA_Gunnar_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Gunnar_PICKPOCKET_Condition()
{
	return C_Beklauen(45,70);
};

func void DIA_Gunnar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Gunnar_PICKPOCKET);
	Info_AddChoice(DIA_Gunnar_PICKPOCKET,Dialog_Back,DIA_Gunnar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Gunnar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Gunnar_PICKPOCKET_DoIt);
};

func void DIA_Gunnar_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Gunnar_PICKPOCKET);
};

func void DIA_Gunnar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Gunnar_PICKPOCKET);
};

