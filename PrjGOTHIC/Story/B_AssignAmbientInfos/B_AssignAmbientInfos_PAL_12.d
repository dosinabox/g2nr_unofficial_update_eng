
instance DIA_PAL_12_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_PAL_12_EXIT_Condition;
	information = DIA_PAL_12_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_PAL_12_EXIT_Condition()
{
	return TRUE;
};

func void DIA_PAL_12_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_PAL_12_JOIN(C_Info)
{
	nr = 4;
	condition = DIA_PAL_12_JOIN_Condition;
	information = DIA_PAL_12_JOIN_Info;
	permanent = TRUE;
	description = "I want to become a paladin!";
};


func int DIA_PAL_12_JOIN_Condition()
{
	if((other.guild == GIL_NONE) || (other.guild == GIL_MIL))
	{
		return TRUE;
	};
};

func void DIA_PAL_12_JOIN_Info()
{
	AI_Output(other,self,"DIA_PAL_12_JOIN_15_00");	//I want to become a paladin!
	if(other.guild != GIL_MIL)
	{
		AI_Output (self, other, "DIA_PAL_12_JOIN_12_01");	//You? Don't make me laugh! You're not even a member of the city guard.
		AI_Output (self, other, "DIA_PAL_12_JOIN_12_02");	//If I couldn't plainly see what a dense yokel you are, I'd think you were trying to insult me.
	};
	AI_Output(self,other,"DIA_PAL_12_JOIN_12_03");	//Only the best of the best among the faithful followers of the king and our Lord Innos are accepted as paladins.
};


instance DIA_PAL_12_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_PAL_12_PEOPLE_Condition;
	information = DIA_PAL_12_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in command here?";
};


func int DIA_PAL_12_PEOPLE_Condition()
{
	if(other.guild != GIL_PAL)
	{
		return TRUE;
	};
};

func void DIA_PAL_12_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_PAL_12_PEOPLE_15_00");	//Who's in command here?
	AI_Output (self, other, "DIA_PAL_12_PEOPLE_12_01");	//The honorable Lord Hagen. But Lord Andre is responsible for all the matters concerning the simple folk.
	AI_Output (self, other, "DIA_PAL_12_PEOPLE_12_02");	//You'll find him in the barracks. Maybe you'll get lucky and he'll devote a few minutes of his valuable time to you.
	Player_KnowsLordHagen = TRUE;
};


instance DIA_PAL_12_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_PAL_12_LOCATION_Condition;
	information = DIA_PAL_12_LOCATION_Info;
	permanent = TRUE;
	description = "What are you paladins doing here in Khorinis?";
};


func int DIA_PAL_12_LOCATION_Condition()
{
	if(KnowsPaladins_Ore == FALSE)
	{
		return TRUE;
	};
};

func void DIA_PAL_12_LOCATION_Info()
{
	AI_Output(other,self,"DIA_PAL_12_LOCATION_15_00");	//What are you paladins doing here in Khorinis?
	if((other.guild != GIL_PAL) && (other.guild != GIL_KDF))
	{
		AI_Output(self,other,"DIA_PAL_12_LOCATION_12_01");	//People who ask questions like that wind up on the gallows before they know it.
	};
	AI_Output (self, other, "DIA_PAL_12_LOCATION_12_02");	//If there's ONE thing Lord Andre cannot afford, it's having knowledge of our mission falling into the hands of spies.
	AI_Output (self, other, "DIA_PAL_12_LOCATION_12_03");	//So, you'd better watch out what you ask.
};


instance DIA_PAL_12_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_PAL_12_STANDARD_Condition;
	information = DIA_PAL_12_STANDARD_Info;
	permanent = TRUE;
	description = "How are things?";
};


func int DIA_PAL_12_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_PAL_12_STANDARD_Info()
{
	AI_Output (other, self, "DIA_PAL_12_STANDARD_15_00");	//How are things?
	if ((other.guild == GIL_PAL) || (other.guild == GIL_KDF))
	{
		if(Kapitel <= 4)
		{
			if(MIS_OLDWORLD == LOG_SUCCESS)
			{
				AI_Output (self, other, "DIA_PAL_12_STANDARD_12_01");	//Now that we know we're dealing with dragons, our commander will surely do something soon.
			}
			else
			{
				AI_Output (self, other, "DIA_PAL_12_STANDARD_12_02");	//We still don't have any news from our detachment in the Valley of Mines. That is very disturbing.
			};
		};
		if(Kapitel >= 5)
		{
			AI_Output (self, other, "DIA_PAL_12_STANDARD_12_03");	//Thanks be to Innos! The threat of the dragons has been averted. Now we only have to deal with the orcs to get to the ore.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_PAL_12_STANDARD_12_04");	//You don't seriously expect me to answer that question, boy!
	};
};

func void B_AssignAmbientInfos_PAL_12(var C_Npc slf)
{
	dia_pal_12_exit.npc = Hlp_GetInstanceID(slf);
	dia_pal_12_join.npc = Hlp_GetInstanceID(slf);
	dia_pal_12_people.npc = Hlp_GetInstanceID(slf);
	dia_pal_12_location.npc = Hlp_GetInstanceID(slf);
	dia_pal_12_standard.npc = Hlp_GetInstanceID(slf);
};

