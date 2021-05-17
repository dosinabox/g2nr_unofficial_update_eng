
instance DIA_PAL_9_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_PAL_9_EXIT_Condition;
	information = DIA_PAL_9_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_PAL_9_EXIT_Condition()
{
	return TRUE;
};

func void DIA_PAL_9_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_PAL_9_JOIN(C_Info)
{
	nr = 4;
	condition = DIA_PAL_9_JOIN_Condition;
	information = DIA_PAL_9_JOIN_Info;
	permanent = TRUE;
	description = "How can I become a paladin?";
};


func int DIA_PAL_9_JOIN_Condition()
{
	if((other.guild == GIL_NONE) || (other.guild == GIL_MIL))
	{
		return TRUE;
	};
};

func void DIA_PAL_9_JOIN_Info()
{
	AI_Output (other, self, "DIA_PAL_9_JOIN_15_00");	//How can I become a paladin?
	AI_Output (self, other, "DIA_PAL_9_JOIN_09_01");	//Those who prove themselves worthy in the service of Innos or the king will be chosen!
	AI_Output (self, other, "DIA_PAL_9_JOIN_09_02");	//Put simply: Only the best will be chosen. But YOU are a long way from that, my boy!
};


instance DIA_PAL_9_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_PAL_9_PEOPLE_Condition;
	information = DIA_PAL_9_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in command here?";
};


func int DIA_PAL_9_PEOPLE_Condition()
{
	if(other.guild != GIL_PAL)
	{
		return TRUE;
	};
};

func void DIA_PAL_9_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_PAL_9_PEOPLE_15_00");	//Who's in command here?
	AI_Output (self, other, "DIA_PAL_9_PEOPLE_09_01");	//Lord Hagen.
	AI_Output (other, self, "DIA_PAL_9_PEOPLE_15_02");	//And?
	AI_Output (self, other, "DIA_PAL_9_PEOPLE_09_03");	//And no one else. Lord Hagen is the supreme commander over the entire island.
	Player_KnowsLordHagen = TRUE;
};


instance DIA_PAL_9_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_PAL_9_LOCATION_Condition;
	information = DIA_PAL_9_LOCATION_Info;
	permanent = TRUE;
	description = "Why have you paladins come to Khorinis?";
};


func int DIA_PAL_9_LOCATION_Condition()
{
	if(KnowsPaladins_Ore == FALSE)
	{
		return TRUE;
	};
};

func void DIA_PAL_9_LOCATION_Info()
{
	AI_Output (other, self, "DIA_PAL_9_LOCATION_15_00");	//Why have you paladins come to Khorinis?
	AI_Output (self, other, "DIA_PAL_9_LOCATION_09_01");	//That's none of your business, pal! It's enough for you to know that we are in the service of Innos and the King!
};


instance DIA_PAL_9_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_PAL_9_STANDARD_Condition;
	information = DIA_PAL_9_STANDARD_Info;
	permanent = TRUE;
	description = "What's up?";
};


func int DIA_PAL_9_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_PAL_9_STANDARD_Info()
{
	AI_Output (other, self, "DIA_PAL_9_STANDARD_15_00");	//What's up?
	if ((other.guild == GIL_PAL) || (other.guild == GIL_KDF))
	{
		if(Kapitel <= 4)
		{
			if(MIS_OLDWORLD == LOG_SUCCESS)
			{
				AI_Output (self, other, "DIA_PAL_9_STANDARD_09_01");	//Now that we know we're dealing with dragons, our commander will surely do something soon.
			}
			else
			{
				AI_Output (self, other, "DIA_PAL_9_STANDARD_09_02");	//We still don't have any news from our detachment in the Valley of Mines. That is very disturbing.
			};
		};
		if(Kapitel >= 5)
		{
			AI_Output (self, other, "DIA_PAL_9_STANDARD_09_03");	//Thanks be to Innos! The threat of the dragons has been averted. Now we only have to deal with the orcs to get to the ore.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_PAL_9_STANDARD_09_04");	//If you don't have anything more important to say, then beat it, punk!
	};
};

func void B_AssignAmbientInfos_PAL_9(var C_Npc slf)
{
	dia_pal_9_exit.npc = Hlp_GetInstanceID(slf);
	dia_pal_9_join.npc = Hlp_GetInstanceID(slf);
	dia_pal_9_people.npc = Hlp_GetInstanceID(slf);
	dia_pal_9_location.npc = Hlp_GetInstanceID(slf);
	dia_pal_9_standard.npc = Hlp_GetInstanceID(slf);
};

