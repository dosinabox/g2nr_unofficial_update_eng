
instance DIA_NOV_8_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_NOV_8_EXIT_Condition;
	information = DIA_NOV_8_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_NOV_8_EXIT_Condition()
{
	return TRUE;
};

func void DIA_NOV_8_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_NOV_8_Fegen(C_Info)
{
	nr = 2;
	condition = DIA_NOV_8_Fegen_Condition;
	information = DIA_NOV_8_Fegen_Info;
	permanent = TRUE;
	description = "I need help sweeping the novices' chambers.";
};


func int DIA_NOV_8_Fegen_Condition()
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


var int Feger3_Permanent;

func void DIA_NOV_8_Fegen_Info()
{
	AI_Output (other, self, "DIA_NOV_8_Fegen_15_00");	//I need help sweeping the novices' chambers.
	if (Hlp_GetInstanceID (Feger3) == Hlp_GetInstanceID (self))
	{
		if(Feger3_Permanent == FALSE)
		{
			AI_Output (self, other, "DIA_NOV_8_Fegen_08_01");	//Oh, man. You just got here and you let them make you do the sweeping already?
			AI_Output (self, other, "DIA_NOV_8_Fegen_08_02");	//Console yourself, it was exactly the same with me when I first got here. And that's why I'm going to help you. It would be ridiculous if we couldn't handle it.
			NOV_Helfer = NOV_Helfer + 1;
			Feger3_Permanent = TRUE;
			B_GivePlayerXP (XP_Feger);
			AI_StopProcessInfos (self);
			Npc_ExchangeRoutine (self, "FEGEN");
			B_LogEntry (Topic_ParlanFegen, "I've found a novice willing to help me sweep the chambers.");
		}
		else
		{
			AI_Output (self, other, "DIA_NOV_8_Fegen_08_03");	//Brother, I know the situation you're in. And I already told you that I will help you. And that's what I'm doing.
		};
	};
	if(Hlp_GetInstanceID(Feger3) != Hlp_GetInstanceID(self))
	{
		AI_Output (self, other, "DIA_NOV_8_Fegen_08_04");	//Hey, I'd do it, but I'm really busy.
	};
};


instance DIA_NOV_8_Wurst(C_Info)
{
	nr = 3;
	condition = DIA_NOV_8_Wurst_Condition;
	information = DIA_NOV_8_Wurst_Info;
	permanent = TRUE;
	description = "How about a delicious mutton sausage?";
};


func int DIA_NOV_8_Wurst_Condition()
{
	if(C_CanFeedNOV(self))
	{
		return TRUE;
	};
};

func void DIA_NOV_8_Wurst_Info()
{
	AI_Output (other, self, "DIA_NOV_8_Wurst_15_00");	//How about a delicious mutton sausage?
	AI_Output (self, other, "DIA_NOV_8_Wurst_08_01");	//I wouldn't say no to that. Thanks, man - that's just what I needed.
	B_FeedNOV(self);
};


instance DIA_NOV_8_JOIN(C_Info)
{
	nr = 4;
	condition = DIA_NOV_8_JOIN_Condition;
	information = DIA_NOV_8_JOIN_Info;
	permanent = TRUE;
	description = "What must I do to become a magician?";
};


func int DIA_NOV_8_JOIN_Condition()
{
	if(hero.guild == GIL_NOV)
	{
		return TRUE;
	};
};

func void DIA_NOV_8_JOIN_Info()
{
	AI_Output (other, self, "DIA_NOV_8_JOIN_15_00");	//What must I do to become a magician?
	AI_Output (self, other, "DIA_NOV_8_JOIN_08_01");	//You will become a Chosen of Innos only when the High Magicians of Fire allow it.
	AI_Output (self, other, "DIA_NOV_8_JOIN_08_02");	//As novices we are forbidden to study rune magic - and we may study the old scriptures only with the permission of the magicians.
};


instance DIA_NOV_8_PEOPLE(C_Info)
{
	nr = 5;
	condition = DIA_NOV_8_PEOPLE_Condition;
	information = DIA_NOV_8_PEOPLE_Info;
	permanent = TRUE;
	description = "Who is in charge of this monastery?";
};


func int DIA_NOV_8_PEOPLE_Condition()
{
	return TRUE;
};

func void DIA_NOV_8_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_NOV_8_PEOPLE_15_00");	//Who is in charge of this monastery?
	AI_Output (self, other, "DIA_NOV_8_PEOPLE_08_01");	//The High Council. It is composed of the three most powerful magicians of our order. They consult daily in the church.
	AI_Output (self, other, "DIA_NOV_8_PEOPLE_08_02");	//The Chosen of Innos are all magicians. Innos has provided them with this gift, so that they are able to carry out his will on earth.
};


instance DIA_NOV_8_LOCATION(C_Info)
{
	nr = 6;
	condition = DIA_NOV_8_LOCATION_Condition;
	information = DIA_NOV_8_LOCATION_Info;
	permanent = TRUE;
	description = "Tell me about this monastery.";
};


func int DIA_NOV_8_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_NOV_8_LOCATION_Info()
{
	AI_Output (other, self, "DIA_NOV_8_LOCATION_15_00");	//Tell me about this monastery.
	AI_Output (self, other, "DIA_NOV_8_LOCATION_08_01");	//It is ancient. It comes from the time before Rhobar the First.
	AI_Output (self, other, "DIA_NOV_8_LOCATION_08_02");	//Under the monastery are the catacombs. They stretch deep into the mountain.
};


instance DIA_NOV_8_STANDARD(C_Info)
{
	nr = 10;
	condition = DIA_NOV_8_STANDARD_Condition;
	information = DIA_NOV_8_STANDARD_Info;
	permanent = TRUE;
	description = "Is there anything new?";
};


func int DIA_NOV_8_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_NOV_8_STANDARD_Info()
{
	AI_Output (other, self, "DIA_NOV_8_STANDARD_15_00");	//Is there anything new?
	if (Kapitel == 1)
	{
		if(other.guild == GIL_KDF)
		{
			AI_Output (self, other, "DIA_NOV_8_STANDARD_08_01");	//You could say so. It has been more than a hundred years since a novice was accepted so quickly into the Circle of Fire.
			AI_Output (self, other, "DIA_NOV_8_STANDARD_08_02");	//I hope that this honor is also granted to me one day. I shall work hard for it.
		}
		else
		{
			AI_Output (self, other, "DIA_NOV_8_STANDARD_08_03");	//The paladins arrived in Khorinis recently. One of them is here in the monastery to pray.
		};
	};
	if((Kapitel == 2) || (Kapitel == 3))
	{
		if((Pedro_Traitor == TRUE) && (MIS_NovizenChase != LOG_SUCCESS))
		{
			AI_Output (self, other, "DIA_NOV_3_STANDARD_08_04");	//I still can't believe it. One of us has betrayed the monastery and stolen the Eye of Innos.
			AI_Output (self, other, "DIA_NOV_3_STANDARD_08_05");	//It was our task to build a community, but we were too weak. That is the only reason Beliar could have succeeded in drawing one of our own to his side.
		}
		else if(MIS_NovizenChase == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_NOV_3_STANDARD_08_06");	//Innos be praised, we were able to get the Eye back from the enemy.
			AI_Output (self, other, "DIA_NOV_3_STANDARD_08_07");	//Your courage can be a model for many despairing souls and help them to survive these dark times.
		}
		else if(MIS_OLDWORLD == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_NOV_8_STANDARD_08_08");	//I have heard of dragons and an army of Evil. Innos be with us!
		}
		else
		{
			AI_Output (self, other, "DIA_NOV_8_STANDARD_08_09");	//The High Council is very concerned about the situation our paladins are in. There has been no news from the Valley of Mines for some time.
		};
	};
	if(Kapitel == 4)
	{
		AI_Output (self, other, "DIA_NOV_8_STANDARD_08_10");	//No. And I thank our Lord for that. With the Eye of Innos we will be able to defeat the dragons!
	};
	if(Kapitel >= 5)
	{
		AI_Output (self, other, "DIA_NOV_8_STANDARD_08_11");	//Yes. We have achieved victory over the dragons! Innos has shown us that we must never give up hope.
		AI_Output (self, other, "DIA_NOV_8_STANDARD_08_12");	//Yet there are many shadows and we shall have to light many fires to drive them away.
	};
};

func void B_AssignAmbientInfos_NOV_8(var C_Npc slf)
{
	dia_nov_8_exit.npc = Hlp_GetInstanceID(slf);
	dia_nov_8_join.npc = Hlp_GetInstanceID(slf);
	dia_nov_8_people.npc = Hlp_GetInstanceID(slf);
	dia_nov_8_location.npc = Hlp_GetInstanceID(slf);
	dia_nov_8_standard.npc = Hlp_GetInstanceID(slf);
	DIA_NOV_8_Fegen.npc = Hlp_GetInstanceID(slf);
	DIA_NOV_8_Wurst.npc = Hlp_GetInstanceID(slf);
};

