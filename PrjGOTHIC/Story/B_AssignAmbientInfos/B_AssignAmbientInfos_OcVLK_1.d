
instance DIA_OCVLK_1_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_OCVLK_1_EXIT_Condition;
	information = DIA_OCVLK_1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_OCVLK_1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_OCVLK_1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_OCVLK_1_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_OCVLK_1_PEOPLE_Condition;
	information = DIA_OCVLK_1_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in command here?";
};


func int DIA_OCVLK_1_PEOPLE_Condition()
{
	return TRUE;
};

func void DIA_OCVLK_1_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_OCVLK_1_PEOPLE_15_00");	//Who's in command here?
	AI_Output (self, other, "DIA_OCVLK_1_PEOPLE_01_01");	//Commander Garond. But since the situation here has become worse, he has not been seen outside the throne room. I'm afraid that will come to a bad end.
};


instance DIA_OCVLK_1_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_OCVLK_1_LOCATION_Condition;
	information = DIA_OCVLK_1_LOCATION_Info;
	permanent = TRUE;
	description = "What do you know about the Valley of Mines?";
};


func int DIA_OCVLK_1_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_OCVLK_1_LOCATION_Info()
{
	AI_Output (other, self, "DIA_OCVLK_1_LOCATION_15_00");	//What do you know about the Valley of Mines?
	AI_Output (self, other, "DIA_OCVLK_1_LOCATION_01_01");	//A few of our boys are at the mines and still prospecting, as far as I know.
	if(!Npc_KnowsInfo(other,DIA_Garond_AllDragonDead) && (Kapitel <= 4))
	{
		AI_Output(self,other,"DIA_OCVLK_1_LOCATION_01_02");	//I wouldn't want to trade with them. The whole valley is swarming with orcs. Not to mention the dragons.
	};
};


instance DIA_OCVLK_1_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_OCVLK_1_STANDARD_Condition;
	information = DIA_OCVLK_1_STANDARD_Info;
	permanent = TRUE;
	description = "How are things?";
};


func int DIA_OCVLK_1_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_OCVLK_1_STANDARD_Info()
{
	AI_Output (other, self, "DIA_OCVLK_1_STANDARD_15_00");	//How are things?
	if (Kapitel <= 3)
	{
		AI_Output (self, other, "DIA_OCVLK_1_STANDARD_01_01");	//The orcs have us right where they want us! Without reinforcements, none of us here will survive! I'm amazed the dragons haven't finished us off completely.
	};
	if(Kapitel == 4)
	{
		if(!Npc_KnowsInfo(other,DIA_Garond_AllDragonDead))
		{
			AI_Output (self, other, "DIA_OCVLK_1_STANDARD_01_02");	//At least we'll finally get some reinforcements.
		}
		else
		{
			AI_Output (self, other, "DIA_OCVLK_1_STANDARD_01_03");	//I heard that all the dragons have been slain? Thank Innos!
		};
	};
	if(Kapitel >= 5)
	{
		if(MIS_OCGateOpen == FALSE)
		{
			AI_Output (self, other, "DIA_OCVLK_1_STANDARD_01_04");	//This accursed ore. We should throw our entire ore supply down from the battlements. Maybe the orcs will leave us in peace then.
		}
		else
		{
			AI_Output (self, other, "DIA_OCVLK_1_STANDARD_01_05");	//Those ridiculous boxes which they have piled up haphazardly in front of the entrance will do nothing to deter the orcs!
		};
	};
};

func void B_AssignAmbientInfos_OCVLK_1(var C_Npc slf)
{
	dia_ocvlk_1_exit.npc = Hlp_GetInstanceID(slf);
	dia_ocvlk_1_people.npc = Hlp_GetInstanceID(slf);
	dia_ocvlk_1_location.npc = Hlp_GetInstanceID(slf);
	dia_ocvlk_1_standard.npc = Hlp_GetInstanceID(slf);
};

