
instance DIA_PAL_4_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_PAL_4_EXIT_Condition;
	information = DIA_PAL_4_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_PAL_4_EXIT_Condition()
{
	return TRUE;
};

func void DIA_PAL_4_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_PAL_4_JOIN(C_Info)
{
	nr = 4;
	condition = DIA_PAL_4_JOIN_Condition;
	information = DIA_PAL_4_JOIN_Info;
	permanent = TRUE;
	description = "How do I become a paladin?";
};


func int DIA_PAL_4_JOIN_Condition()
{
	if((other.guild == GIL_NONE) || (other.guild == GIL_MIL))
	{
		return TRUE;
	};
};

func void DIA_PAL_4_JOIN_Info()
{
	AI_Output(other,self,"DIA_PAL_4_JOIN_15_00");	//How do I become a paladin?
	if(other.guild == GIL_NONE)
	{
		AI_Output(self,other,"DIA_PAL_4_JOIN_04_01");	//If you are truly serious about it, then you should place yourself in the service of the paladins.
		AI_Output(self,other,"DIA_PAL_4_JOIN_04_02");	//Go to the barracks and talk to Lord Andre. Get yourself admitted to the militia.
	}
	else if(other.guild == GIL_MIL)
	{
		AI_Output(self,other,"DIA_PAL_4_JOIN_04_02_add");	//Go to the barracks and talk to Lord Andre.
	};
	AI_Output(self,other,"DIA_PAL_4_JOIN_04_03");	//Perhaps you will get a chance then to prove yourself worthy.
};


instance DIA_PAL_4_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_PAL_4_PEOPLE_Condition;
	information = DIA_PAL_4_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in command here?";
};


func int DIA_PAL_4_PEOPLE_Condition()
{
	if(other.guild != GIL_PAL)
	{
		return TRUE;
	};
};

func void DIA_PAL_4_PEOPLE_Info()
{
		AI_Output (other, self, "DIA_PAL_4_PEOPLE_15_00");	//Who's in command here?
		AI_Output (self, other, "DIA_PAL_4_PEOPLE_04_01");	//Lord Hagen is the commander-in-chief of all troops on the island. He also holds the office of governor for as long as we are here.
		AI_Output (self, other, "DIA_PAL_4_PEOPLE_04_02");	//But he is very busy. If there's anything you need to take care of, go to the barracks and talk to Lord Andre.
	Player_KnowsLordHagen = TRUE;
};


instance DIA_PAL_4_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_PAL_4_LOCATION_Condition;
	information = DIA_PAL_4_LOCATION_Info;
	permanent = TRUE;
	description = "What are you paladins doing here in Khorinis?";
};


func int DIA_PAL_4_LOCATION_Condition()
{
	if(KnowsPaladins_Ore == FALSE)
	{
		return TRUE;
	};
};

func void DIA_PAL_4_LOCATION_Info()
{
	AI_Output (other, self, "DIA_PAL_4_LOCATION_15_00");	//What are you paladins doing here in Khorinis?
	AI_Output (self, other, "DIA_PAL_4_LOCATION_04_01");	//I am not authorized to tell you that.
};


instance DIA_PAL_4_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_PAL_4_STANDARD_Condition;
	information = DIA_PAL_4_STANDARD_Info;
	permanent = TRUE;
	description = "What's new?";
};


func int DIA_PAL_4_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_PAL_4_STANDARD_Info()
{
	AI_Output (other, self, "DIA_PAL_4_STANDARD_15_00");	//What's new?
	if ((other.guild == GIL_PAL) || (other.guild == GIL_KDF))
	{
		if(Kapitel <= 4)
		{
			if(MIS_OLDWORLD == LOG_SUCCESS)
			{
				AI_Output (self, other, "DIA_PAL_4_STANDARD_04_01");	//Now that we know we're dealing with dragons, our commander will surely do something soon.
			}
			else
			{
				AI_Output (self, other, "DIA_PAL_4_STANDARD_04_02");	//We still don't have any news from our detachment in the Valley of Mines. That is very disturbing.
			};
		};
		if(Kapitel >= 5)
		{
			AI_Output (self, other, "DIA_PAL_4_STANDARD_04_03");	//Thanks be to Innos! The threat of the dragons has been averted. Now we only have to deal with the orcs to get to the ore.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_PAL_4_STANDARD_04_04");	//I have no time to bother myself with the rumors being told here in the city.
	};
};

func void B_AssignAmbientInfos_PAL_4(var C_Npc slf)
{
	dia_pal_4_exit.npc = Hlp_GetInstanceID(slf);
	dia_pal_4_join.npc = Hlp_GetInstanceID(slf);
	dia_pal_4_people.npc = Hlp_GetInstanceID(slf);
	dia_pal_4_location.npc = Hlp_GetInstanceID(slf);
	dia_pal_4_standard.npc = Hlp_GetInstanceID(slf);
};

