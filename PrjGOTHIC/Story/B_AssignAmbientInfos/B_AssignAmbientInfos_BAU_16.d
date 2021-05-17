
instance DIA_BAU_16_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_BAU_16_EXIT_Condition;
	information = DIA_BAU_16_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_BAU_16_EXIT_Condition()
{
	return TRUE;
};

func void DIA_BAU_16_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_BAU_16_JOIN(C_Info)
{
	nr = 4;
	condition = DIA_BAU_16_JOIN_Condition;
	information = DIA_BAU_16_JOIN_Info;
	permanent = TRUE;
	description = "Tell me more about those mercenaries!";
};


func int DIA_BAU_16_JOIN_Condition()
{
	if((hero.guild != GIL_SLD) && (hero.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_BAU_16_JOIN_Info()
{
	AI_Output (other, self, "DIA_BAU_16_JOIN_15_00");	//Tell me more about those mercenaries!
	AI_Output (self, other, "DIA_BAU_16_JOIN_16_01");	//They're loitering around the farm all day, beat each other up on occasion, and think it's a hoot.
};


instance DIA_BAU_16_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_BAU_16_PEOPLE_Condition;
	information = DIA_BAU_16_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in charge here?";
};


func int DIA_BAU_16_PEOPLE_Condition()
{
	return TRUE;
};

func void DIA_BAU_16_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_BAU_16_PEOPLE_15_00");	//Who's in charge here?
	AI_Output (self, other, "DIA_BAU_16_PEOPLE_16_01");	//If you ask me, it's the mercenaries.
	AI_Output (self, other, "DIA_BAU_16_PEOPLE_16_02");	//Onar pays them, but most of them do whatever they like.
};


instance DIA_BAU_16_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_BAU_16_LOCATION_Condition;
	information = DIA_BAU_16_LOCATION_Info;
	permanent = TRUE;
	description = "What can you tell me about this area?";
};


func int DIA_BAU_16_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_BAU_16_LOCATION_Info()
{
	AI_Output (other, self, "DIA_BAU_16_LOCATION_15_00");	//What can you tell me about this area?
	AI_Output (self, other, "DIA_BAU_16_LOCATION_16_01");	//There are three farms here. Onar's to the east and Sekob's in the north end of the valley.
	AI_Output (self, other, "DIA_BAU_16_LOCATION_16_02");	//There's a path up to the high plain in the southwest. That's where Bengar's farm is.
};


instance DIA_BAU_16_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_BAU_16_STANDARD_Condition;
	information = DIA_BAU_16_STANDARD_Info;
	permanent = TRUE;
	description = "What's new?";
};


func int DIA_BAU_16_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_BAU_16_STANDARD_Info()
{
	AI_Output (other, self, "DIA_BAU_16_STANDARD_15_00");	//What's new?
	if (Kapitel == 1)
	{
		AI_Output (self, other, "DIA_BAU_16_STANDARD_16_01");	//The troops from the city don't take away our livestock and harvest any more! We're no longer playing that game, we're able to defend ourselves now!
	};
	if(Kapitel == 2)
	{
		AI_Output (self, other, "DIA_BAU_16_STANDARD_16_02");	//They say an army is gathering in the Valley of Mines. They'll be here soon.
	};
	if(Kapitel == 3)
	{
		AI_Output (self, other, "DIA_BAU_16_STANDARD_16_03");	//I heard rumors that there are dragons in the Valley of Mines. I can hardly believe it.
	};
	if(Kapitel == 4)
	{
		AI_Output (self, other, "DIA_BAU_16_STANDARD_16_04");	//Some of the mercenaries have left. I don't know whether that's a good thing or a bad thing.
	};
	if(Kapitel >= 5)
	{
		AI_Output (self, other, "DIA_BAU_16_STANDARD_16_05");	//Sending the paladins to the Valley of Mines - what's that all about?
	};
};

func void B_AssignAmbientInfos_BAU_16(var C_Npc slf)
{
	dia_bau_16_exit.npc = Hlp_GetInstanceID(slf);
	dia_bau_16_join.npc = Hlp_GetInstanceID(slf);
	dia_bau_16_people.npc = Hlp_GetInstanceID(slf);
	dia_bau_16_location.npc = Hlp_GetInstanceID(slf);
	dia_bau_16_standard.npc = Hlp_GetInstanceID(slf);
};

