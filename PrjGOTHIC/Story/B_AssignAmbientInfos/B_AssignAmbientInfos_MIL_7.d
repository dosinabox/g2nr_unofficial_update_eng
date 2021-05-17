
instance DIA_MIL_7_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_MIL_7_EXIT_Condition;
	information = DIA_MIL_7_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_MIL_7_EXIT_Condition()
{
	return TRUE;
};

func void DIA_MIL_7_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_MIL_7_JOIN(C_Info)
{
	nr = 4;
	condition = DIA_MIL_7_JOIN_Condition;
	information = DIA_MIL_7_JOIN_Info;
	permanent = TRUE;
	description = "I want to join the militia!";
};


func int DIA_MIL_7_JOIN_Condition()
{
	if(hero.guild == GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_MIL_7_JOIN_Info()
{
	AI_Output (other, self, "DIA_MIL_7_JOIN_15_00");	//I want to join the militia!
	if (Player_IsApprentice == APP_NONE)
	{
		AI_Output (self, other, "DIA_MIL_7_JOIN_07_01");	//You're not even a citizen of Khorinis! Why do you think Lord Andre should accept you?
		AI_Output (self, other, "DIA_MIL_7_JOIN_07_02");	//Anyone could come along  - get issued a weapon and some armor in passing, and then disappear with it!
		AI_Output(other,self,"DIA_MIL_7_JOIN_15_03");	//But I'm serious!
	};
	AI_Output(self,other,"DIA_MIL_7_JOIN_07_04");	//Don't explain that to me, explain it to Lord Andre. You'll find him in the barracks.
};


instance DIA_MIL_7_PEOPLE(C_Info)
{
	nr = 3;
	condition = DIA_MIL_7_PEOPLE_Condition;
	information = DIA_MIL_7_PEOPLE_Info;
	permanent = TRUE;
	description = "What do you know about the paladins?";
};


func int DIA_MIL_7_PEOPLE_Condition()
{
	if(hero.guild != GIL_PAL)
	{
		return TRUE;
	};
};

func void DIA_MIL_7_PEOPLE_Info()
{
	AI_Output (other, self, "DIA_MIL_7_PEOPLE_15_00");	//What do you know about the paladins?
	AI_Output (self, other, "DIA_MIL_7_PEOPLE_07_01");	//Not much. Nobody knows exactly why they're here. Not even those of us in the city guard.
	AI_Output (self, other, "DIA_MIL_7_PEOPLE_07_02");	//They've taken control of the city, chased the governor out of his council chamber and relieved the judge of his office.
	AI_Output (self, other, "DIA_MIL_7_PEOPLE_07_03");	//If you ask me, it's a good thing. Those pompous asses bitterly needed a lesson in humility.
};


instance DIA_MIL_7_LOCATION(C_Info)
{
	nr = 2;
	condition = DIA_MIL_7_LOCATION_Condition;
	information = DIA_MIL_7_LOCATION_Info;
	permanent = TRUE;
	description = "What are my options here in town?";
};


func int DIA_MIL_7_LOCATION_Condition()
{
	return TRUE;
};

func void DIA_MIL_7_LOCATION_Info()
{
	AI_Output(other,self,"DIA_MIL_7_LOCATION_15_00");	//What are my options here in town?
	if(((hero.guild == GIL_NONE) || (hero.guild == GIL_NOV)) && (Player_IsApprentice == APP_NONE))
	{
		AI_Output(self,other,"DIA_MIL_7_LOCATION_07_01");	//If you don't want to end up in the gutter in the harbor district, find a regular job. Ask around in the lower part of town - maybe you'll get lucky.
	};
	if(hero.guild == GIL_NONE)
	{
		AI_Output(self,other,"DIA_MIL_7_LOCATION_07_02");	//If you're planning on staying longer here in the city, you should join the militia or at least get trained in combat.
		AI_Output(self,other,"DIA_MIL_7_LOCATION_07_03");	//The combat instructors in the barracks also train civilians.
	};
	AI_Output(self,other,"DIA_MIL_7_LOCATION_07_04");	//The orcs will come soon, and then you'll be glad of every hour you spent on the drill ground.
};


instance DIA_MIL_7_STANDARD(C_Info)
{
	nr = 1;
	condition = DIA_MIL_7_STANDARD_Condition;
	information = DIA_MIL_7_STANDARD_Info;
	permanent = TRUE;
	description = "What's new?";
};


func int DIA_MIL_7_STANDARD_Condition()
{
	return TRUE;
};

func void DIA_MIL_7_STANDARD_Info()
{
	AI_Output(other,self,"DIA_MIL_7_STANDARD_15_00");	//What's new?
	if((SC_HearedAboutMissingPeople == FALSE) && (MissingPeopleReturnedHome == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_MIL_7_STANDARD_07_00");	//Citizens are disappearing from here one by one. Up to now, we haven't been able to find out what's happening to them. Could the orcs be behind it?
		Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
		B_LogEntry(TOPIC_Addon_WhoStolePeople,LogText_Addon_SCKnowsMisspeapl);
		SC_HearedAboutMissingPeople = TRUE;
	}
	else if(Kapitel == 1)
	{
		if(hero.guild == GIL_MIL)
		{
			AI_Output(self,other,"DIA_SLD_7_JOIN_07_01");	//I heard you really gave it to the militia. We could use someone like you here!
		}
		else
		{
			AI_Output (self, other, "DIA_MIL_7_STANDARD_07_01");	//They say the farmers have rebelled. We can't use crap like that now, when we're in the middle of a war with the orcs!
		};
	}
	else if(Kapitel == 2)
	{
		AI_Output (self, other, "DIA_MIL_7_STANDARD_07_02");	//It's time the paladins ended the farmers' rebellion. He who breaks the law must be punished. Especially now, when we're at war.
	};
	else if(Kapitel == 3)
	{
		if(MIS_RescueBennet == LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_MIL_7_STANDARD_07_03");	//The mercenary who was accused of murdering Lothar is supposedly innocent. Someone found proof that he was being framed.
		}
		else
		{
			AI_Output (self, other, "DIA_MIL_7_STANDARD_07_04");	//One of Onar's mercenaries murdered the honorable paladin Lothar. But the bastard was caught and tossed in prison.
		};
	}
	else if(Kapitel == 4)
	{
		AI_Output (self, other, "DIA_MIL_7_STANDARD_07_05");	//Some of the mercenaries have already left Onar's farm. Some problems solve themselves.
	};
	else if(Kapitel >= 5)
	{
		AI_Output (self, other, "DIA_MIL_7_STANDARD_07_06");	//The dragons are finished, but it isn't over. The orcs are next. We'll clean things up properly!
	};
};

func void B_AssignAmbientInfos_MIL_7(var C_Npc slf)
{
	dia_mil_7_exit.npc = Hlp_GetInstanceID(slf);
	dia_mil_7_join.npc = Hlp_GetInstanceID(slf);
	dia_mil_7_people.npc = Hlp_GetInstanceID(slf);
	dia_mil_7_location.npc = Hlp_GetInstanceID(slf);
	dia_mil_7_standard.npc = Hlp_GetInstanceID(slf);
};

