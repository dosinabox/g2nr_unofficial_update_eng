
instance DIA_OCPAL_9_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_OCPAL_9_EXIT_Condition;
	information = DIA_OCPAL_9_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_OCPAL_9_EXIT_Condition()
{
	return TRUE;
};

func void DIA_OCPAL_9_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_OCPAL_9_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_OCPAL_9_PEOPLE_Condition;
	information = DIA_OCPAL_9_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in command here?";
};


func int DIA_OCPAL_9_PEOPLE_Condition()
{
	return TRUE;
};

func void DIA_OCPAL_9_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_OCPAL_9_PEOPLE_15_00");	//Who's in command here?
	AI_Output (self, other, "DIA_OCPAL_9_PEOPLE_09_01");	//Garond is the commander of the castle. You can't exactly envy him his job.
};


instance DIA_OCPAL_9_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_OCPAL_9_LOCATION_Condition;
	information = DIA_OCPAL_9_LOCATION_Info;
	permanent = TRUE;
	description = "What do you know about this valley?";
};


func int DIA_OCPAL_9_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_OCPAL_9_LOCATION_Info()
{
	AI_Output (other, self, "DIA_OCPAL_9_LOCATION_15_00");	//What do you know about this valley?
	AI_Output (self, other, "DIA_OCPAL_9_LOCATION_09_01");	//In the east, the orcs have built a huge protective wall - to protect their supplies, I suppose. Behind the wall, there's a place where they can dock their ships.
	AI_Output (self, other, "DIA_OCPAL_9_LOCATION_09_02");	//I hope the orcs don't get their supplies too quickly. What we have to deal with NOW is enough for me.
};


instance DIA_OCPAL_9_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_OCPAL_9_STANDARD_Condition;
	information = DIA_OCPAL_9_STANDARD_Info;
	permanent = TRUE;
	description = "How are things?";
};


func int DIA_OCPAL_9_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_OCPAL_9_STANDARD_Info()
{
	DIA_Common_HowsItGoing();
	if(Kapitel <= 3)
	{
		AI_Output (self, other, "DIA_OCPAL_4_STANDARD_09_01");	//The dragons have attacked again! But Innos will protect us in battle. The creatures of Beliar will pay a high toll in blood!
	};
	if(Kapitel == 4)
	{
		if(!Npc_KnowsInfo(other,DIA_Garond_AllDragonDead))
		{
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_09_02");	//Dragon hunters! They should have sent us paladins!
		}
		else
		{
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_09_03");	//Now that we're rid of those dragons, we can take care of the orcs!
		};
	};
	if(Kapitel >= 5)
	{
		if(MIS_OCGateOpen == FALSE)
		{
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_09_04");	//We need to get the ore onto the ship and then get the hell out of this accursed land.
		}
		else
		{
			AI_Output (self, other, "DIA_OCPAL_4_STANDARD_09_05");	//Treason! The gate should never have been opened. Death to all traitors!
		};
	};
};

func void B_AssignAmbientInfos_OCPAL_9(var C_Npc slf)
{
	dia_ocpal_9_exit.npc = Hlp_GetInstanceID(slf);
	dia_ocpal_9_people.npc = Hlp_GetInstanceID(slf);
	dia_ocpal_9_location.npc = Hlp_GetInstanceID(slf);
	dia_ocpal_9_standard.npc = Hlp_GetInstanceID(slf);
};

