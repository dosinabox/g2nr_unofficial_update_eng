
instance DIA_OCPAL_4_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_OCPAL_4_EXIT_Condition;
	information = DIA_OCPAL_4_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_OCPAL_4_EXIT_Condition()
{
	return TRUE;
};

func void DIA_OCPAL_4_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_OCPAL_4_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_OCPAL_4_PEOPLE_Condition;
	information = DIA_OCPAL_4_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in command here?";
};


func int DIA_OCPAL_4_PEOPLE_Condition()
{
	return TRUE;
};

func void DIA_OCPAL_4_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_OCPAL_4_PEOPLE_15_00");	//Who's in command here?
	AI_Output (self, other, "DIA_OCPAL_4_PEOPLE_04_01");	//Commander Garond. He's in the largest building here within the castle.
};


instance DIA_OCPAL_4_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_OCPAL_4_LOCATION_Condition;
	information = DIA_OCPAL_4_LOCATION_Info;
	permanent = TRUE;
	description = "What can you tell me about the Valley of Mines?";
};


func int DIA_OCPAL_4_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_OCPAL_4_LOCATION_Info()
{
	AI_Output (other, self, "DIA_OCPAL_4_LOCATION_15_00");	//What can you tell me about the Valley of Mines?
	AI_Output (self, other, "DIA_OCPAL_4_LOCATION_04_01");	//As far as I know, there are several mines out there - if they haven't all been overrun by the orcs.
	AI_Output (self, other, "DIA_OCPAL_4_LOCATION_04_02");	//The troops consist of prisoners for the most part, but there are also some paladins among them.
};


instance DIA_OCPAL_4_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_OCPAL_4_STANDARD_Condition;
	information = DIA_OCPAL_4_STANDARD_Info;
	permanent = TRUE;
	description = "How are things?";
};


func int DIA_OCPAL_4_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_OCPAL_4_STANDARD_Info()
{
	AI_Output (other, self, "DIA_OCPAL_4_STANDARD_15_00");	//How are things?
	if (Kapitel <= 3)
	{
		AI_Output (self, other, "DIA_OCPAL_4_STANDARD_04_01");	//The orcs have us surrounded! But we'll defend ourselves to the last man! And Innos will aid us against the dragons!
	};
	if(Kapitel == 4)
	{
		if(!Npc_KnowsInfo(other,DIA_Garond_AllDragonDead))
		{
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_04_02");	//It won't be long until the orcs attack. Where are the damned reinforcements?
			if (other.guild == GIL_DJG)
			{
				AI_Output (self, other, "DIA_OCPAL_4_STANDARD_04_03");	//You don't seriously believe that you dragon hunters really have a chance against ALL the dragons?
			}
			else
			{
				AI_Output (self, other, "DIA_OCPAL_4_STANDARD_04_04");	//Those so-called dragon hunters won't be able to accomplish much!
			};
		}
		else
		{
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_04_05");	//Thank Innos! Those damned beasts have been defeated!
		};
	};
	if(Kapitel >= 5)
	{
		if(MIS_OCGateOpen == FALSE)
		{
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_04_06");	//The death of the dragons doesn't seem to have particularly impressed the orcs. Why in the name of Innos don't they go away? There's some deviltry afoot here.
		}
		else
		{
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_04_07");	//The damned gate is stuck. The orcs are pouring into the castle, and nothing's stopping them.
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_04_08");	//Someone must inform Lord Hagen. We need him HERE now.
		};
	};
};

func void B_AssignAmbientInfos_OCPAL_4(var C_Npc slf)
{
	dia_ocpal_4_exit.npc = Hlp_GetInstanceID(slf);
	dia_ocpal_4_people.npc = Hlp_GetInstanceID(slf);
	dia_ocpal_4_location.npc = Hlp_GetInstanceID(slf);
	dia_ocpal_4_standard.npc = Hlp_GetInstanceID(slf);
};

