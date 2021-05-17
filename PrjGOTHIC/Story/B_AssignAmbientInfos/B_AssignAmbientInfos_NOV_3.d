
instance DIA_NOV_3_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_NOV_3_EXIT_Condition;
	information = DIA_NOV_3_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_NOV_3_EXIT_Condition()
{
	return TRUE;
};

func void DIA_NOV_3_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_NOV_3_Fegen(C_Info)
{
	nr = 2;
	condition = DIA_NOV_3_Fegen_Condition;
	information = DIA_NOV_3_Fegen_Info;
	permanent = TRUE;
	description = "I need help sweeping the novices' chambers.";
};


var int Feger1_Permanent;
var int Feger2_Permanent;
var int Feger2_Once;

func int DIA_NOV_3_Fegen_Condition()
{
	if((MIS_ParlanFegen == LOG_Running) && (NOV_Helfer < 4))
	{
		if(Kapitel == 1)
		{
			return TRUE;
		}
		else if(GuildlessMode == TRUE)
		{
			return TRUE;
		};
	};
};

func void DIA_NOV_3_Fegen_Info()
{
	AI_Output (other, self, "DIA_NOV_3_Fegen_15_00");	//I need help sweeping the novices' chambers.
	if (Hlp_GetInstanceID (Feger1) == Hlp_GetInstanceID (self))
	{
		if((NOV_Helfer < 1) && (Feger1_Permanent == FALSE))
		{
			AI_Output (self, other, "DIA_NOV_3_Fegen_03_01");	//No one has agreed to help you so far, huh? I'll help you only if you find at least one other person to join in.
			B_LogEntry (Topic_ParlanFegen, "The novice sweeping the cellar will help me if I can find another novice prepared to lend a hand with sweeping the chambers.");
		}
		else if((NOV_Helfer >= 1) && (Feger1_Permanent == FALSE))
		{
			AI_Output (self, other, "DIA_NOV_3_Fegen_03_02");	//Am I the only one helping you?
			AI_Output (other, self, "DIA_NOV_3_Fegen_15_03");	//No, I've already got some help.
			AI_Output (self, other, "DIA_NOV_3_Fegen_03_04");	//Then I'm in.
			NOV_Helfer += 1;
			Feger1_Permanent = TRUE;
			B_GivePlayerXP (XP_Feger);
			AI_StopProcessInfos (self);
			Npc_ExchangeRoutine (self, "FEGEN");
			B_LogEntry (Topic_ParlanFegen, "The novice from the cellar will help me sweep the chambers now.");
		}
		else if(Feger1_Permanent == TRUE)
		{
			AI_Output (self, other, "DIA_NOV_3_Fegen_03_05");	//Hey, Brother - I'm already helping you. You don't have to talk me into it.
		};
	};
	if(Hlp_GetInstanceID(Feger2) == Hlp_GetInstanceID(self))
	{
		if(Feger2_Permanent == FALSE)
		{
			AI_Output (self, other, "DIA_NOV_3_Fegen_03_08");	//Sure, I'll help. We novices have to stick together. One hand washes the other.
			AI_Output (self, other, "DIA_NOV_3_Fegen_03_09");	//I only need 50 gold pieces because I still have to pay Parlan.
			if(Feger2_Once == FALSE)
			{
				B_LogEntry(Topic_ParlanFegen,"The novice outside the church will help me if I give him 50 pieces of gold.");
				Feger2_Once = TRUE;
			};
			Info_ClearChoices(DIA_NOV_3_Fegen);
			Info_AddChoice(DIA_NOV_3_Fegen,"Maybe later...",DIA_NOV_3_Fegen_Nein);
			if(Npc_HasItems(other,ItMi_Gold) >= 50)
			{
				Info_AddChoice(DIA_NOV_3_Fegen,"All right. I'll pay.",DIA_NOV_3_Fegen_Ja);
			};
		}
		else
		{
			AI_Output (self, other, "DIA_NOV_3_Fegen_03_06");	//But I already promised. You helped me and I'll help you.
		};
	};
	if((Hlp_GetInstanceID(Feger1) != Hlp_GetInstanceID(self)) && (Hlp_GetInstanceID(Feger2) != Hlp_GetInstanceID(self)))
	{
		AI_Output (self, other, "DIA_NOV_3_Fegen_03_07");	//Forget it - I don't have time for that. Look for somebody else to help you.
	};
};

func void DIA_NOV_3_Fegen_Nein()
{
	AI_Output (other, self, "DIA_NOV_3_Fegen_Nein_15_00");	//Maybe later. Right now, I can't afford it.
	Info_ClearChoices (DIA_NOV_3_Fegen);
};

func void DIA_NOV_3_Fegen_Ja()
{
	AI_Output (other, self, "DIA_NOV_3_Fegen_Ja_15_00");	//All right. I'll pay.
	AI_Output (self, other, "DIA_NOV_3_Fegen_Ja_03_01");	//Good, then I'll get started.
	B_GiveInvItems(other,self,ItMi_Gold,50);
	NOV_Helfer += 1;
	B_GivePlayerXP(XP_Feger);
	Feger2_Permanent = TRUE;
	Info_ClearChoices (DIA_NOV_3_Fegen);
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "FEGEN");
	B_LogEntry (Topic_ParlanFegen, "The novice outside the church will help me sweep the chambers now.");
};


instance DIA_NOV_3_Wurst(C_Info)
{
	nr = 3;
	condition = DIA_NOV_3_Wurst_Condition;
	information = DIA_NOV_3_Wurst_Info;
	permanent = TRUE;
	description = "Would you like a sausage?";
};


func int DIA_NOV_3_Wurst_Condition()
{
	if(C_CanFeedNOV(self))
	{
		return TRUE;
	};
};

func void DIA_NOV_3_Wurst_Info()
{
	AI_Output (other, self, "DIA_NOV_3_Wurst_15_00");	//Would you like a sausage?
	AI_Output (self, other, "DIA_NOV_3_Wurst_03_01");	//Sure, give it here. A sausage like this is not to be sneezed at.
	B_FeedNOV(self);
};


instance DIA_NOV_3_JOIN(C_Info)
{
	nr = 4;
	condition = DIA_NOV_3_JOIN_Condition;
	information = DIA_NOV_3_JOIN_Info;
	permanent = TRUE;
	description = "I want to become a mage!";
};


func int DIA_NOV_3_JOIN_Condition()
{
	if(hero.guild == GIL_NOV)
	{
		return TRUE;
	};
};

func void DIA_NOV_3_JOIN_Info()
{
	AI_Output (other, self, "DIA_NOV_3_JOIN_15_00");	//I want to become a mage!
	AI_Output (self, other, "DIA_NOV_3_JOIN_03_01");	//That's what many of the novices want. But only a very few are ordained as Chosen and get the chance to be accepted into the Circle of Fire.
	AI_Output (self, other, "DIA_NOV_3_JOIN_03_02");	//To be a magician of the Circle of Fire is the highest honor which can be granted to you in our order.
	AI_Output (self, other, "DIA_NOV_3_JOIN_03_03");	//You will have to work hard in order to get your chance.
};


instance DIA_NOV_3_PEOPLE(C_Info)
{
	nr = 5;
	condition = DIA_NOV_3_PEOPLE_Condition;
	information = DIA_NOV_3_PEOPLE_Info;
	permanent = TRUE;
	description = "Who is the leader of this monastery?";
};


func int DIA_NOV_3_PEOPLE_Condition()
{
	return TRUE;
};

func void DIA_NOV_3_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_NOV_3_PEOPLE_15_00");	//Who is the leader of this monastery?
	AI_Output (self, other, "DIA_NOV_3_PEOPLE_03_01");	//We novices serve the magicians of the Circle of Fire. They in turn are led by the High Council, which consists of the three most powerful magicians.
	AI_Output (self, other, "DIA_NOV_3_PEOPLE_03_02");	//But Parlan is responsible for all the affairs of the novices. He is always in the courtyard watching the novices work.
};


instance DIA_NOV_3_LOCATION(C_Info)
{
	nr = 6;
	condition = DIA_NOV_3_LOCATION_Condition;
	information = DIA_NOV_3_LOCATION_Info;
	permanent = TRUE;
	description = "What can you tell me about this monastery?";
};


func int DIA_NOV_3_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_NOV_3_LOCATION_Info()
{
	AI_Output (other, self, "DIA_NOV_3_LOCATION_15_00");	//What can you tell me about this monastery?
	AI_Output (self, other, "DIA_NOV_3_LOCATION_03_01");	//We grow our modest provisions here ourselves. We raise sheep and make wine.
	AI_Output (self, other, "DIA_NOV_3_LOCATION_03_02");	//There is a library, but its use is limited to the magicians and the chosen novices.
	AI_Output (self, other, "DIA_NOV_3_LOCATION_03_03");	//We other novices mainly see to it that the magicians of the Circle of Fire want for nothing.
};


instance DIA_NOV_3_STANDARD(C_Info)
{
	nr = 10;
	condition = DIA_NOV_3_STANDARD_Condition;
	information = DIA_NOV_3_STANDARD_Info;
	permanent = TRUE;
	description = "What's new?";
};


func int DIA_NOV_3_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_NOV_3_STANDARD_Info()
{
	AI_Output (other, self, "DIA_NOV_3_STANDARD_15_00");	//What's new?
	if (Kapitel == 1)
	{
		if(hero.guild == GIL_KDF)
		{
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_01");	//You're a fine one to ask! You're the only thing the novices are talking about.
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_02");	//It's rare indeed that a newcomer like you is chosen for the Circle of Fire.
		}
		else
		{
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_03");	//The time has come again. One of the novices will soon be accepted into the Circle of Fire.
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_04");	//The tests will soon begin.
		};
	};
	if((Kapitel == 2) || (Kapitel == 3))
	{
		if((Pedro_Traitor == TRUE) && (MIS_NovizenChase != LOG_SUCCESS))
		{
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_05");	//Our order has been touched by Beliar! Evil must be very strong if it is able to find allies even here.
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_06");	//Pedro had been here in the monastery for years. I believe that the great amount of time which he spent outside these walls weakened his faith and thus made him susceptible to the temptations of Beliar.
		}
		else if(MIS_NovizenChase == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_07");	//You have come at the right time. Innos himself could not have chosen a better moment for your appearance.
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_08");	//You will enter the annals of our monastery as the savior of the Eye.
		}
		else if(MIS_OLDWORLD == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_09");	//The news from the Valley of Mines is alarming. I believe that Innos is putting us through a severe test.
		}
		else
		{
			AI_Output (self, other, "DIA_NOV_3_STANDARD_03_10");	//It is said that there is no news from the paladins who set off for the Valley of Mines. The High Council will know best what is to be done.
		};
	};
	if(Kapitel == 4)
	{
		AI_Output (self, other, "DIA_NOV_3_STANDARD_03_11");	//They say that we shall destroy the dragons with the help of our Lord. The wrath of Innos will smite the creatures of Beliar.
	};
	if(Kapitel >= 5)
	{
		AI_Output (self, other, "DIA_NOV_3_STANDARD_03_12");	//Thank Innos there is no new crisis. We must return to the path of our Lord, for only with his help can we face evil.
	};
};

func void B_AssignAmbientInfos_NOV_3(var C_Npc slf)
{
	dia_nov_3_exit.npc = Hlp_GetInstanceID(slf);
	dia_nov_3_join.npc = Hlp_GetInstanceID(slf);
	dia_nov_3_people.npc = Hlp_GetInstanceID(slf);
	dia_nov_3_location.npc = Hlp_GetInstanceID(slf);
	dia_nov_3_standard.npc = Hlp_GetInstanceID(slf);
	DIA_NOV_3_Fegen.npc = Hlp_GetInstanceID(slf);
	DIA_NOV_3_Wurst.npc = Hlp_GetInstanceID(slf);
};

