
instance DIA_OCVLK_6_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_OCVLK_6_EXIT_Condition;
	information = DIA_OCVLK_6_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_OCVLK_6_EXIT_Condition()
{
	return TRUE;
};

func void DIA_OCVLK_6_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


func void B_EngorTradeLog()
{
	if(Engor_Trade == FALSE)
	{
		Log_CreateTopic(TOPIC_Trader_OC,LOG_NOTE);
		B_LogEntry(TOPIC_Trader_OC,"Engor manages the supplies at the castle and does a bit of business on the side.");
		Engor_Trade = TRUE;
	};
};

instance DIA_OCVLK_6_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_OCVLK_6_PEOPLE_Condition;
	information = DIA_OCVLK_6_PEOPLE_Info;
	permanent = TRUE;
	description = "Who's in charge here?";
};


func int DIA_OCVLK_6_PEOPLE_Condition()
{
	return TRUE;
};

func void DIA_OCVLK_6_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_OCVLK_6_PEOPLE_15_00");	//Who's in charge here?
	AI_Output (self, other, "DIA_OCVLK_6_PEOPLE_06_01");	//Garond has the command over the entire fort - or what's left of it.
	AI_Output (self, other, "DIA_OCVLK_6_PEOPLE_06_02");	//But he himself takes care of practically nothing - except when one of his people gets into trouble.
	if(!Npc_IsDead(Engor))
	{
		AI_Output(self,other,"DIA_OCVLK_6_PEOPLE_06_03");	//If it's equipment you want, you better went to Engor. You'll find him in the house opposite Garond.
		B_EngorTradeLog();
	};
};


instance DIA_OCVLK_6_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_OCVLK_6_LOCATION_Condition;
	information = DIA_OCVLK_6_LOCATION_Info;
	permanent = TRUE;
	description = "What can you tell me about the situation in the Valley of Mines?";
};


func int DIA_OCVLK_6_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_OCVLK_6_LOCATION_Info()
{
	AI_Output (other, self, "DIA_OCVLK_6_LOCATION_15_00");	//What can you tell me about the situation in the Valley of Mines?
	AI_Output (self, other, "DIA_OCVLK_6_LOCATION_06_01");	//I'm worried about the orcs' protective wall. I don't even want to know what the orcs are hiding behind there.
	AI_Output (self, other, "DIA_OCVLK_6_LOCATION_06_02");	//First there were only a few of them - they built that wall. Then, one night, they brought in the siege engines.
	AI_Output (self, other, "DIA_OCVLK_6_LOCATION_06_03");	//We were lucky and managed to fend off the attack.
	AI_Output (self, other, "DIA_OCVLK_6_LOCATION_06_04");	//Behind the wall lies the sea. If more ships arrive bringing additional orcs, we won't stand a chance.
};


instance DIA_OCVLK_6_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_OCVLK_6_STANDARD_Condition;
	information = DIA_OCVLK_6_STANDARD_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_OCVLK_6_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_OCVLK_6_STANDARD_Info()
{
	AI_Output (other, self, "DIA_OCVLK_6_STANDARD_15_00");	//How's it going?
	if (Kapitel <= 3)
	{
		AI_Output (self, other, "DIA_OCVLK_6_STANDARD_06_01");	//Join the army and live the good life, they said. And now look at this.
		AI_Output (self, other, "DIA_OCVLK_6_STANDARD_06_02");	//It is now prohibited under penalty of death to even go near the food supplies. Garond seems to be afraid that we might raid the vittles and hit the road. (bitter laugh)
		AI_Output (self, other, "DIA_OCVLK_6_STANDARD_06_03");	//We're all going to starve here if those blasted dragons don't kill us first!
	};
	if(Kapitel == 4)
	{
		if(!Npc_KnowsInfo(other,DIA_Garond_AllDragonDead))
		{
			AI_Output (self, other, "DIA_OCVLK_6_STANDARD_06_04");	//Dragon hunters. Don't make me laugh! They're not going to change a thing.
		}
		else
		{
			AI_Output (self, other, "DIA_OCVLK_6_STANDARD_06_05");	//They say the dragons have all been killed! Now we stand a chance!
		};
	};
	if(Kapitel >= 5)
	{
		if(MIS_OCGateOpen == FALSE)
		{
			AI_Output (self, other, "DIA_OCVLK_6_STANDARD_06_06");	//This accursed ore. We should throw our entire ore supply down from the battlements. Maybe the orcs will leave us in peace then.
		}
		else
		{
			AI_Output (self, other, "DIA_OCVLK_6_STANDARD_06_07");	//Those ridiculous boxes which they have piled up haphazardly in front of the entrance will do nothing to deter the orcs!
		};
	};
};

func void B_AssignAmbientInfos_OCVLK_6(var C_Npc slf)
{
	dia_ocvlk_6_exit.npc = Hlp_GetInstanceID(slf);
	dia_ocvlk_6_people.npc = Hlp_GetInstanceID(slf);
	dia_ocvlk_6_location.npc = Hlp_GetInstanceID(slf);
	dia_ocvlk_6_standard.npc = Hlp_GetInstanceID(slf);
};

