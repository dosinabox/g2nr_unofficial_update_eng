
instance DIA_BAU_7_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_BAU_7_EXIT_Condition;
	information = DIA_BAU_7_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_BAU_7_EXIT_Condition()
{
	return TRUE;
};

func void DIA_BAU_7_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_BAU_7_JOIN(C_Info)
{
	nr = 4;
	condition = DIA_BAU_7_JOIN_Condition;
	information = DIA_BAU_7_JOIN_Info;
	permanent = TRUE;
	description = "What do you know about the mercenaries?";
};


func int DIA_BAU_7_JOIN_Condition()
{
	if(Kapitel == 1)
	{
		return TRUE;
	};
};

func void DIA_BAU_7_JOIN_Info()
{
	DIA_Common_TellMeAboutSLD();
	AI_Output (self, other, "DIA_BAU_7_JOIN_07_01");	//Onar hired them to defend his farm.
	AI_Output (self, other, "DIA_BAU_7_JOIN_07_02");	//Most of them behave like the farm belongs to them. But at any rate, they protect us.
};


instance DIA_BAU_7_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_BAU_7_PEOPLE_Condition;
	information = DIA_BAU_7_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in charge here?";
};


func int DIA_BAU_7_PEOPLE_Condition()
{
	return TRUE;
};

func void DIA_BAU_7_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_BAU_7_PEOPLE_15_00");	//Who's in charge here?
	AI_Output (self, other, "DIA_BAU_7_PEOPLE_07_01");	//The big farm belongs to Onar. The small farms around here, too. But he leases them out.
};


instance DIA_BAU_7_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_BAU_7_LOCATION_Condition;
	information = DIA_BAU_7_LOCATION_Info;
	permanent = TRUE;
	description = "Tell me more about the area.";
};


func int DIA_BAU_7_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_BAU_7_LOCATION_Info()
{
	AI_Output (other, self, "DIA_BAU_7_LOCATION_15_00");	//Tell me more about the area.
	AI_Output (self, other, "DIA_BAU_7_LOCATION_07_01");	//The big farm here in the east of the valley is Onar's. Sekob's farm lies to the north.
	AI_Output (self, other, "DIA_BAU_7_LOCATION_07_02");	//And Bengar's farm is on the high plain to the southwest. You can get there from the valley - there's a big stone stairway that leads there.
};


instance DIA_BAU_7_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_BAU_7_STANDARD_Condition;
	information = DIA_BAU_7_STANDARD_Info;
	permanent = TRUE;
	description = "What's new?";
};


func int DIA_BAU_7_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_BAU_7_STANDARD_Info()
{
	AI_Output (other, self, "DIA_BAU_7_STANDARD_15_00");	//What's new?
	if (Kapitel == 1)
	{
		AI_Output (self, other, "DIA_BAU_7_STANDARD_07_01");	//We have declared our independence - we're not paying taxes to the city any more. The king hasn't done anything for us - we've had enough!
	};
	if(Kapitel == 2)
	{
		AI_Output (self, other, "DIA_BAU_7_STANDARD_07_02");	//At the moment, there isn't much going on here.
	};
	if(Kapitel == 3)
	{
		AI_Output (self, other, "DIA_BAU_7_STANDARD_07_03");	//You hear stories about dragons now! The king is always coming up with new things to squeeze more money out of the people.
	};
	if(Kapitel == 4)
	{
		AI_Output (self, other, "DIA_BAU_7_STANDARD_07_04");	//Take care of yourself, an awful lot of dark figures and wild animals are coming through the pass.
	};
	if(Kapitel >= 5)
	{
		AI_Output (self, other, "DIA_BAU_7_STANDARD_07_05");	//Now that the dragons are dead, the lord paladins deign to come out of the city. It's about time that order prevailed here again.
	};
};

func void B_AssignAmbientInfos_BAU_7(var C_Npc slf)
{
	dia_bau_7_exit.npc = Hlp_GetInstanceID(slf);
	dia_bau_7_join.npc = Hlp_GetInstanceID(slf);
	dia_bau_7_people.npc = Hlp_GetInstanceID(slf);
	dia_bau_7_location.npc = Hlp_GetInstanceID(slf);
	dia_bau_7_standard.npc = Hlp_GetInstanceID(slf);
};

