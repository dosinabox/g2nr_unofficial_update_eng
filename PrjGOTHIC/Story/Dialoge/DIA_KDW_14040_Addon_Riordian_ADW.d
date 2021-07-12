
instance DIA_Addon_Riordian_ADW_EXIT(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 999;
	condition = DIA_Addon_Riordian_ADW_EXIT_Condition;
	information = DIA_Addon_Riordian_ADW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Riordian_ADW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Riordian_ADW_EXIT_Info()
{
	if(MIS_Addon_Saturas_BringRiordian2Me == LOG_Running)
	{
		MIS_Addon_Saturas_BringRiordian2Me = LOG_FAILED;
		B_CheckLog();
	};
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Riordian_HelloADW(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 1;
	condition = DIA_Addon_Riordian_HelloADW_Condition;
	information = DIA_Addon_Riordian_HelloADW_Info;
	description = "Did you expect THIS here?";
};


func int DIA_Addon_Riordian_HelloADW_Condition()
{
	return TRUE;
};

func void DIA_Addon_Riordian_HelloADW_Info()
{
	AI_Output (other, self, "DIA_Addon_Riordian_HelloADW_15_00");	//Did you expect THIS here?
	AI_Output (self, other, "DIA_Addon_Riordian_HelloADW_10_01");	//Not at all. I am awestruck at how large the city must have been.
	AI_Output (self, other, "DIA_Addon_Riordian_HelloADW_10_02");	//Most of the buildings are buried under stone and earth, but the ruins that have survived the ages are spread all over the land.
	AI_Output (self, other, "DIA_Addon_Riordian_HelloADW_10_03");	//There must have been thousands living here.
};


instance DIA_Addon_Riordian_WhatToFind(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 1;
	condition = DIA_Addon_Riordian_WhatToFind_Condition;
	information = DIA_Addon_Riordian_WhatToFind_Info;
	description = "What will I find out there?";
};


func int DIA_Addon_Riordian_WhatToFind_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Riordian_HelloADW))
	{
		return TRUE;
	};
};

func void DIA_Addon_Riordian_WhatToFind_Info()
{
	AI_Output(other,self,"DIA_Addon_Riordian_WhatToFind_15_00");	//What will I find out there?
	AI_Output(self,other,"DIA_Addon_Riordian_Gegend_west_10_03");	//To the east, not far from here, we found the body of a fisherman.
	AI_Output(self,other,"DIA_Addon_Riordian_Gegend_west_10_04");	//You should take a look at it.
	if(!Npc_HasItems(William,ITWr_Addon_William_01))
	{
		DIA_Common_IFoundHim();
		AI_Output(self,other,"DIA_Addon_Riordian_FoundAllHouses_10_04");	//Thank you.
		if(FoundDeadWilliam == FALSE)
		{
			if(Sklaven_Flucht == FALSE)
			{
				Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
				Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
			};
			B_LogEntry(TOPIC_Addon_MissingPeople,"Wiliam the fisherman is dead. I found his dead body in Jharkendar.");
		};
		FoundDeadWilliam = TRUE;
	}
	else if(!Npc_KnowsInfo(other,DIA_Addon_Saturas_MissingPeople))
	{
		if(Sklaven_Flucht == FALSE)
		{
			Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
		};
		B_LogEntry(TOPIC_Addon_MissingPeople,LogText_Addon_WilliamLeiche);
	};
	AI_Output (self, other, "DIA_Addon_Riordian_WhatToFind_10_01");	//In the east, there is a large fortress in a gigantic swamp.
	AI_Output (self, other, "DIA_Addon_Riordian_WhatToFind_10_02");	//As far as we can judge from here, the bandits have taken refuge there.
	AI_Output (self, other, "DIA_Addon_Riordian_WhatToFind_10_03");	//If I were you, I wouldn't go down there. They have set up many outposts and guards.
	AI_Output (self, other, "DIA_Addon_Riordian_WhatToFind_10_04");	//You had better avoid the swamp until you have more experience, or find a way to go around the bandits.
	AI_Output (self, other, "DIA_Addon_Riordian_WhatToFind_10_05");	//In the west we have discovered some pirates.
	AI_Output (self, other, "DIA_Addon_Riordian_WhatToFind_10_06");	//I'm not sure, but I believe they have also discovered us.
	AI_Output (self, other, "DIA_Addon_Riordian_WhatToFind_10_07");	//They don't seem too perturbed by our presence, though.
};


instance DIA_Addon_Riordian_Gegend(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 1;
	condition = DIA_Addon_Riordian_Gegend_Condition;
	information = DIA_Addon_Riordian_Gegend_Info;
	permanent = TRUE;
	description = "Tell me more about the area.";
};


func int DIA_Addon_Riordian_Gegend_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Riordian_WhatToFind) && (Saturas_RiesenPlan == FALSE))
	{
		return TRUE;
	};
};


var int DIA_Addon_Riordian_Gegend_Info_OneTime;

func void DIA_Addon_Riordian_Gegend_Info()
{
	AI_Output (other, self, "DIA_Addon_Riordian_Gegend_15_00");	//Tell me more about the area.
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_10_01");	//What do you want to know?
	Info_ClearChoices(DIA_Addon_Riordian_Gegend);
	Info_AddChoice(DIA_Addon_Riordian_Gegend,Dialog_Back,DIA_Addon_Riordian_Gegend_Back);
	if((DIA_Addon_Riordian_Gegend_Info_OneTime == FALSE) && !Npc_HasItems(other,ItWr_Map_AddonWorld))
	{
		Info_AddChoice(DIA_Addon_Riordian_Gegend,"Is there a map of this area?",DIA_Addon_Riordian_Gegend_map);
	};
	Info_AddChoice (DIA_Addon_Riordian_Gegend, "Where did you see the pirates?", DIA_Addon_Riordian_Gegend_Piraten);
	Info_AddChoice (DIA_Addon_Riordian_Gegend, "Where were the bandits again?", DIA_Addon_Riordian_Gegend_bandits);
	Info_AddChoice (DIA_Addon_Riordian_Gegend, "Were you ever in the west?", DIA_Addon_Riordian_Gegend_west);
	Info_AddChoice (DIA_Addon_Riordian_Gegend, "What was in the east again?", DIA_Addon_Riordian_Gegend_ost);
	Info_AddChoice (DIA_Addon_Riordian_Gegend, "What will I find I go to the south?", DIA_Addon_Riordian_Gegend_sued);
	Info_AddChoice (DIA_Addon_Riordian_Gegend, "What is in the north?", DIA_Addon_Riordian_Gegend_nord);
};

func void DIA_Addon_Riordian_Gegend_Back()
{
	Info_ClearChoices(DIA_Addon_Riordian_Gegend);
};

func void DIA_Addon_Riordian_Gegend_map()
{
	AI_Output (other, self, "DIA_Addon_Riordian_Gegend_map_15_00");	//Is there a map of this area?
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_map_10_01");	//Cronos has made one. He will surely let you have it.
	DIA_Addon_Riordian_Gegend_Info_OneTime = TRUE;
};

func void DIA_Addon_Riordian_Gegend_bandits()
{
	AI_Output (other, self, "DIA_Addon_Riordian_Gegend_bandits_15_00");	//Where were the bandits again?
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_bandits_10_01");	//They have a sort of fortress with many outposts in the east.
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_bandits_10_02");	//To get to them you will have to cross the large swamp.
};

func void DIA_Addon_Riordian_Gegend_Piraten()
{
	AI_Output (other, self, "DIA_Addon_Riordian_Gegend_Piraten_15_00");	//Where did you see the pirates?
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_Piraten_10_01");	//They were running around not far to the west of here.
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_Piraten_10_02");	//I think they were hunting.
};

func void DIA_Addon_Riordian_Gegend_nord()
{
	AI_Output (other, self, "DIA_Addon_Riordian_Gegend_nord_15_00");	//What is in the north?
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_nord_10_01");	//If the records of the builders are to be believed, then you will find a large valley encircled by cliffs.
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_nord_10_02");	//Drought and desert sand dominate the landscape there.
};

func void DIA_Addon_Riordian_Gegend_sued()
{
	AI_Output (other, self, "DIA_Addon_Riordian_Gegend_sued_15_00");	//What will I find I go to the south?
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_sued_10_01");	//The land in the south is very rugged.
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_sued_10_02");	//You will find serpentine paths, waterfalls and ruins carved out of the rock there.
};

func void DIA_Addon_Riordian_Gegend_ost()
{
	AI_Output (other, self, "DIA_Addon_Riordian_Gegend_ost_15_00");	//What was in the east again?
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_ost_10_01");	//The great swamp. The area is very dangerous.
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_ost_10_02");	//Not only are the bandits lurking there, but also extremely dangerous animals.
	AI_Output (self, other, "DIA_Addon_Riordian_Gegend_ost_10_03");	//You should be careful.
};

func void DIA_Addon_Riordian_Gegend_west()
{
	AI_Output(other,self,"DIA_Addon_Riordian_Gegend_west_15_00");	//Were you ever in the west?
	AI_Output(self,other,"DIA_Addon_Riordian_Gegend_west_10_01");	//No. But the coast must be there somewhere.
	AI_Output(self,other,"DIA_Addon_Riordian_Gegend_west_10_02");	//That's probably where the pirates have their camp.
};


instance DIA_Addon_Riordian_HousesOfRulers(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 2;
	condition = DIA_Addon_Riordian_HousesOfRulers_Condition;
	information = DIA_Addon_Riordian_HousesOfRulers_Info;
	description = "Saturas sent me.";
};


func int DIA_Addon_Riordian_HousesOfRulers_Condition()
{
	if(SaturasSendsToRiordian == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Riordian_HousesOfRulers_Info()
{
	AI_Output (other, self, "DIA_Addon_Riordian_HousesOfRulers_15_00");	//Saturas sent me. I'm supposed to search through the five mansions of Jharkendar.
	AI_Output (self, other, "DIA_Addon_Riordian_HousesOfRulers_10_01");	//It took me a long time to find the location of the mansions in the writings of the builders.
	AI_Output (self, other, "DIA_Addon_Riordian_HousesOfRulers_10_02");	//But now I can tell you exactly.
	MIS_Riordian_HousesOfRulers = LOG_Running;
};


var int B_WhereAreHousesOfRulersOneTime;

func void B_WhereAreHousesOfRulers()
{
	AI_Output (self, other, "DIA_Addon_Riordian_WhereAreHouses_10_00");	//The house of the scholars is a large library. It must be somewhere far to the north.
	AI_Output (self, other, "DIA_Addon_Riordian_WhereAreHouses_10_01");	//The house of the warriors was a fortress ringed by rocks in the east.
	AI_Output (self, other, "DIA_Addon_Riordian_WhereAreHouses_10_02");	//The priests and guardians of the dead had their dwellings near each other. You should find them in the southwest.
	AI_Output (self, other, "DIA_Addon_Riordian_WhereAreHouses_10_03");	//And the healers had their house of convalescence in the southeast.
	AI_Output(self,other,"DIA_Addon_Riordian_WhereAreHouses_10_04");	//If these houses are still standing, then you will recognize them from their method of construction.
	AI_Output(self,other,"DIA_Addon_Riordian_WhereAreHouses_10_05");	//They are elevated. A steep stairway leads to the entrance covered by high columns.
	if(B_WhereAreHousesOfRulersOneTime == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Riordian_WhereAreHouses_10_06");	//I hope that helps you.
		B_LogEntry (TOPIC_Addon_HousesOfRulers, "The mansion of the scholars is a large library. It must be somewhere in the north.");
		Log_AddEntry (TOPIC_Addon_HousesOfRulers, "The mansion of the warriors was a fortress surrounded by cliffs in the east.");
		Log_AddEntry (TOPIC_Addon_HousesOfRulers, "The priests and guardians of the dead had their quarters close to each other. I should be able to find them in the southwest.");
		Log_AddEntry (TOPIC_Addon_HousesOfRulers, "The healers had their house of convalescence in the southeast.");
		B_WhereAreHousesOfRulersOneTime = TRUE;
	};
};

instance DIA_Addon_Riordian_WhereAreHouses(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 2;
	condition = DIA_Addon_Riordian_WhereAreHouses_Condition;
	information = DIA_Addon_Riordian_WhereAreHouses_Info;
	description = "Where do I find the 5 mansions?";
};


func int DIA_Addon_Riordian_WhereAreHouses_Condition()
{
	if(MIS_Riordian_HousesOfRulers == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Riordian_WhereAreHouses_Info()
{
	AI_Output(other,self,"DIA_Addon_Riordian_WhereAreHouses_15_00");	//Where do I find the 5 mansions?
	B_WhereAreHousesOfRulers();
};


var int FOUNDHOUSEINFO[6];
const int Scientists = 1;
const int Healers = 2;
const int Warriors = 3;
const int Priests = 4;
const int Guardians = 5;
var int RiordianHouseNeuigkeit;
var int RiordianHousesFoundCount;

instance DIA_Addon_Riordian_FoundHouse(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 2;
	condition = DIA_Addon_Riordian_FoundHouse_Condition;
	information = DIA_Addon_Riordian_FoundHouse_Info;
	permanent = TRUE;
	description = "About the mansions...";
};


func int DIA_Addon_Riordian_FoundHouse_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Riordian_WhereAreHouses) && (RiordianHousesFoundCount < 5))
	{
		return TRUE;
	};
};

func void DIA_Addon_Riordian_FoundHouse_Info()
{
	var int RiordianHouseXPs;
	RiordianHouseNeuigkeit = 0;
	AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_00");	//Eh, about the mansions...
	AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_01");	//Yes?
	if((SC_COMESINTO_CANYONLIBRARY_FUNC_OneTime == TRUE) && (FOUNDHOUSEINFO[Scientists] == FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_02");	//The orcs seem to be interested in the library of the scholars.
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_03");	//Do you think they can read the ancient language?
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_04");	//I don't think so, but who knows.
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_05");	//Perhaps you should make sure that they go away, nevertheless.
		FOUNDHOUSEINFO[Scientists] = TRUE;
		RiordianHouseNeuigkeit += 1;
		Log_CreateTopic(TOPIC_Addon_CanyonOrcs,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_CanyonOrcs,LOG_Running);
		B_LogEntry(TOPIC_Addon_CanyonOrcs,"The Water Mage Riordian would prefer it if the orcs disappeared from the canyon.");
	};
	if((Npc_IsDead(Stoneguardian_Heiler) || Npc_HasItems(other,ItMi_Addon_Stone_04) || (Saturas_SCFound_ItMi_Addon_Stone_04 == TRUE)) && (FOUNDHOUSEINFO[Healers] == FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_06");	//The house of the healers is in the middle of the swampy area and is defended by many stone sentinels.
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_07");	//So it is still standing?
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_08");	//Yes, but I wonder for how much longer...
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_09");	//It pains my soul to see the witnesses of the past in this dilapidated condition.
		FOUNDHOUSEINFO[Healers] = TRUE;
		RiordianHouseNeuigkeit += 1;
	};
	if((RavenIsInTempel == TRUE) && (FOUNDHOUSEINFO[Warriors] == FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_10");	//The mansion of the warriors is being used by Raven as a hide-out.
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_11");	//(cynically) He made a good choice.
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_12");	//It is probably the most secure fortress still to be found in this region.
		FOUNDHOUSEINFO[Warriors] = TRUE;
		RiordianHouseNeuigkeit += 1;
	};
	if((Npc_IsDead(Minecrawler_Priest) || Npc_HasItems(other,ItMi_Addon_Stone_03) || (Saturas_SCFound_ItMi_Addon_Stone_03 == TRUE)) && (FOUNDHOUSEINFO[Priests] == FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_13");	//There were a lot of minecrawlers in the house of the priests...
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_14");	//Aren't these animals very uncommon for the area?
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_15");	//They certainly are.
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_16");	//By Adanos. Curious things are happening in this area.
		FOUNDHOUSEINFO[Priests] = TRUE;
		RiordianHouseNeuigkeit += 1;
	};
	if((Npc_IsDead(MayaZombie04_Totenw) || Npc_HasItems(other,ItMi_Addon_Stone_02) || (Saturas_SCFound_ItMi_Addon_Stone_02 == TRUE)) && (FOUNDHOUSEINFO[Guardians] == FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_17");	//The house of the guardians of the dead is dominated by the power of Evil.
		AI_Output (other, self, "DIA_Addon_Riordian_FoundHouse_15_18");	//I think I have rarely seen so many zombies in one place.
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_19");	//That is unfortunate. The guardians of the dead were obviously the victims of their special skills.
		AI_Output (self, other, "DIA_Addon_Riordian_FoundHouse_10_20");	//Their connection to the world of the dead damaged them greatly. I hope you were able to free them from their suffering.
		FOUNDHOUSEINFO[Guardians] = TRUE;
		RiordianHouseNeuigkeit += 1;
	};
	if(RiordianHouseNeuigkeit > 0)
	{
		RiordianHouseXPs = XP_Addon_Riordian_FoundHouse * RiordianHouseNeuigkeit;
		B_GivePlayerXP(RiordianHouseXPs);
		RiordianHousesFoundCount += RiordianHouseNeuigkeit;
	}
	else
	{
		AI_Output(other,self,"DIA_Addon_Riordian_FoundHouse_15_21");	//Tell me again where each one is located.
		B_WhereAreHousesOfRulers();
	};
};


instance DIA_Addon_Riordian_FoundAllHouses(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 2;
	condition = DIA_Addon_Riordian_FoundAllHouses_Condition;
	information = DIA_Addon_Riordian_FoundAllHouses_Info;
	description = "I found all of the mansions.";
};


func int DIA_Addon_Riordian_FoundAllHouses_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Riordian_WhereAreHouses) && (RiordianHousesFoundCount >= 5))
	{
		return TRUE;
	};
};

func void DIA_Addon_Riordian_FoundAllHouses_Info()
{
	AI_Output(other,self,"DIA_Addon_Riordian_FoundAllHouses_15_00");	//I found all of the mansions.
	AI_Output(self,other,"DIA_Addon_Riordian_FoundAllHouses_10_01");	//Were they all where I said they would be?
	AI_Output(other,self,"DIA_Addon_Riordian_FoundAllHouses_15_02");	//More or less.
	AI_Output(self,other,"DIA_Addon_Riordian_FoundAllHouses_10_03");	//ery good. Then my work WAS worth it.
	AI_Output(self,other,"DIA_Addon_Riordian_FoundAllHouses_10_04");	//Thank you.
	MIS_Riordian_HousesOfRulers = LOG_SUCCESS;
	B_GivePlayerXP(XP_Addon_FoundAllHouses);
};


instance DIA_Addon_Riordian_OrksWeg(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 3;
	condition = DIA_Addon_Riordian_OrksWeg_Condition;
	information = DIA_Addon_Riordian_OrksWeg_Info;
	description = "The orcs will soon lose interest in this area.";
};


func int DIA_Addon_Riordian_OrksWeg_Condition()
{
	if(Npc_IsDead(OrcShaman_Sit_CanyonLibraryKey) && (FOUNDHOUSEINFO[Scientists] == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Riordian_OrksWeg_Info()
{
	AI_Output(other,self,"DIA_Addon_Riordian_OrksWeg_15_00");	//The orcs will soon lose interest in this area.
	AI_Output(self,other,"DIA_Addon_Riordian_OrksWeg_10_01");	//What makes you say that?
	if(OrcShaman_CanyonLibrary_KilledByPlayer == TRUE)
	{
		AI_Output(other,self,"DIA_Addon_Riordian_OrksWeg_15_02");	//I killed their leader.
	}
	else
	{
		AI_Output(other,self,"DIA_Addon_Riordian_OrksWeg_15_03");	//Their leader is dead.
	};
	AI_Output(self,other,"DIA_Addon_Riordian_OrksWeg_10_04");	//Let's just hope you are right.
	AI_Output(self,other,"DIA_Addon_Riordian_OrksWeg_10_05");	//We really don't need disturbances of that sort right now.
	TOPIC_END_CanyonOrcs = TRUE;
	B_GivePlayerXP(XP_Addon_Riordian_OrksWeg);
};


instance DIA_Addon_Riordian_ADW_PreTeach(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 4;
	condition = DIA_Addon_Riordian_ADW_PreTeach_Condition;
	information = DIA_Addon_Riordian_ADW_PreTeach_Info;
	description = "Can you teach me your skills?";
};


func int DIA_Addon_Riordian_ADW_PreTeach_Condition()
{
	return TRUE;
};

func void DIA_Addon_Riordian_ADW_PreTeach_Info()
{
	AI_Output (other, self, "DIA_Addon_Riordian_ADW_PreTeach_15_00");	//Can you teach me your skills?
	AI_Output (self, other, "DIA_Addon_Riordian_ADW_PreTeach_10_01");	//I can instruct you in the art of alchemy.
	if((Riordian_Addon_TeachWisp == TRUE) && (Riordian_Addon_TeachWisp_NoPerm == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_Riordian_ADW_PreTeach_10_02");	//And I can show you how to teach your will-o'-the-wisp to search for objects.
	};
	Log_CreateTopic(TOPIC_Addon_KDWTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_Addon_KDWTeacher,LogText_Addon_RiordianTeachAlchemy);
	Riordian_Addon_TeachAlchemy = TRUE;
};

instance DIA_Addon_RiordianADW_TeachPre(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 90;
	condition = DIA_Addon_RiordianADW_TeachPre_Condition;
	information = DIA_Addon_Riordian_TeachPre_Info;
	description = "Vatras gave me this amulet with will-o'-the-wisp...";
};


func int DIA_Addon_RiordianADW_TeachPre_Condition()
{
	if((Riordian_Addon_TeachWisp == FALSE) && Npc_HasItems(other,ItAm_Addon_WispDetector))
	{
		return TRUE;
	};
};

instance DIA_Addon_Riordian_ADW_Teach(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 90;
	condition = DIA_Addon_Riordian_ADW_Teach_Condition;
	information = DIA_Addon_Riordian_ADW_Teach_Info;
	permanent = TRUE;
	description = "Show me how to train my will-o'-the-wisp.";
};


func int DIA_Addon_Riordian_ADW_Teach_Condition()
{
	if((Riordian_Addon_TeachWisp == TRUE) && (Riordian_Addon_TeachWisp_NoPerm == FALSE) && Npc_HasItems(other,ItAm_Addon_WispDetector))
	{
		return TRUE;
	};
};

func void DIA_Addon_Riordian_ADW_Teach_Info()
{
	B_DIA_Addon_Riordian_Teach_15_00();
	if((PLAYER_TALENT_WISPDETECTOR[WISPSKILL_NF] == FALSE) || (PLAYER_TALENT_WISPDETECTOR[WISPSKILL_FF] == FALSE) || (PLAYER_TALENT_WISPDETECTOR[WISPSKILL_NONE] == FALSE) || (PLAYER_TALENT_WISPDETECTOR[WISPSKILL_RUNE] == FALSE) || (PLAYER_TALENT_WISPDETECTOR[WISPSKILL_MAGIC] == FALSE) || (PLAYER_TALENT_WISPDETECTOR[WISPSKILL_FOOD] == FALSE) || (PLAYER_TALENT_WISPDETECTOR[WISPSKILL_POTIONS] == FALSE))
	{
		Info_ClearChoices(DIA_Addon_Riordian_ADW_Teach);
		Info_AddChoice(DIA_Addon_Riordian_ADW_Teach,Dialog_Back,DIA_Addon_Riordian_ADW_Teach_BACK);
		B_DIA_Addon_Riordian_Teach_10_01();
		if(PLAYER_TALENT_WISPDETECTOR[WISPSKILL_FF] == FALSE)
		{
			Info_AddChoice(DIA_Addon_Riordian_ADW_Teach,B_BuildLearnString(NAME_ADDON_WISPSKILL_FF,B_GetLearnCostTalent(other,NPC_TALENT_WISPDETECTOR,WISPSKILL_FF)),DIA_Addon_Riordian_ADW_Teach_WISPSKILL_FF);
		};
		if(PLAYER_TALENT_WISPDETECTOR[WISPSKILL_NONE] == FALSE)
		{
			Info_AddChoice(DIA_Addon_Riordian_ADW_Teach,B_BuildLearnString(NAME_ADDON_WISPSKILL_NONE,B_GetLearnCostTalent(other,NPC_TALENT_WISPDETECTOR,WISPSKILL_NONE)),DIA_Addon_Riordian_ADW_Teach_WISPSKILL_NONE);
		};
		if((PLAYER_TALENT_WISPDETECTOR[WISPSKILL_RUNE] == FALSE) && (WISPSKILL_LEVEL >= 2))
		{
			Info_AddChoice(DIA_Addon_Riordian_ADW_Teach,B_BuildLearnString(NAME_ADDON_WISPSKILL_RUNE,B_GetLearnCostTalent(other,NPC_TALENT_WISPDETECTOR,WISPSKILL_RUNE)),DIA_Addon_Riordian_ADW_Teach_WISPSKILL_RUNE);
		};
		if((PLAYER_TALENT_WISPDETECTOR[WISPSKILL_MAGIC] == FALSE) && (WISPSKILL_LEVEL >= 2))
		{
			Info_AddChoice(DIA_Addon_Riordian_ADW_Teach,B_BuildLearnString(NAME_ADDON_WISPSKILL_MAGIC,B_GetLearnCostTalent(other,NPC_TALENT_WISPDETECTOR,WISPSKILL_MAGIC)),DIA_Addon_Riordian_ADW_Teach_WISPSKILL_MAGIC);
		};
		if((PLAYER_TALENT_WISPDETECTOR[WISPSKILL_FOOD] == FALSE) && (WISPSKILL_LEVEL >= 3))
		{
			Info_AddChoice(DIA_Addon_Riordian_ADW_Teach,B_BuildLearnString(NAME_ADDON_WISPSKILL_FOOD,B_GetLearnCostTalent(other,NPC_TALENT_WISPDETECTOR,WISPSKILL_FOOD)),DIA_Addon_Riordian_ADW_Teach_WISPSKILL_FOOD);
		};
		if((PLAYER_TALENT_WISPDETECTOR[WISPSKILL_POTIONS] == FALSE) && (WISPSKILL_LEVEL >= 3))
		{
			Info_AddChoice(DIA_Addon_Riordian_ADW_Teach,B_BuildLearnString(NAME_ADDON_WISPSKILL_POTIONS,B_GetLearnCostTalent(other,NPC_TALENT_WISPDETECTOR,WISPSKILL_POTIONS)),DIA_Addon_Riordian_ADW_Teach_WISPSKILL_POTIONS);
		};
	}
	else
	{
		B_DIA_Addon_Riordian_Teach_10_08();
		Riordian_Addon_TeachWisp_NoPerm = TRUE;
	};
};

func void DIA_Addon_Riordian_ADW_Teach_WISPSKILL_X()
{
	B_DIA_Addon_Riordian_Teach_WISPSKILL_X_10_00();
};

func void DIA_Addon_Riordian_ADW_Teach_BACK()
{
	Info_ClearChoices(DIA_Addon_Riordian_ADW_Teach);
};

func void DIA_Addon_Riordian_ADW_Teach_WISPSKILL_FF()
{
	if(B_TeachPlayerTalentWispDetector(self,other,WISPSKILL_FF))
	{
		if(WISPSKILL_LEVEL < 2)
		{
			WISPSKILL_LEVEL = 2;
		};
		DIA_Addon_Riordian_ADW_Teach_WISPSKILL_X();
	};
	Info_ClearChoices(DIA_Addon_Riordian_ADW_Teach);
};

func void DIA_Addon_Riordian_ADW_Teach_WISPSKILL_NONE()
{
	if(B_TeachPlayerTalentWispDetector(self,other,WISPSKILL_NONE))
	{
		if(WISPSKILL_LEVEL < 2)
		{
			WISPSKILL_LEVEL = 2;
		};
		DIA_Addon_Riordian_ADW_Teach_WISPSKILL_X();
	};
	Info_ClearChoices(DIA_Addon_Riordian_ADW_Teach);
};

func void DIA_Addon_Riordian_ADW_Teach_WISPSKILL_RUNE()
{
	if(B_TeachPlayerTalentWispDetector(self,other,WISPSKILL_RUNE))
	{
		if(WISPSKILL_LEVEL < 3)
		{
			WISPSKILL_LEVEL = 3;
		};
		DIA_Addon_Riordian_ADW_Teach_WISPSKILL_X();
	};
	Info_ClearChoices(DIA_Addon_Riordian_ADW_Teach);
};

func void DIA_Addon_Riordian_ADW_Teach_WISPSKILL_MAGIC()
{
	if(B_TeachPlayerTalentWispDetector(self,other,WISPSKILL_MAGIC))
	{
		if(WISPSKILL_LEVEL < 3)
		{
			WISPSKILL_LEVEL = 3;
		};
		DIA_Addon_Riordian_ADW_Teach_WISPSKILL_X();
	};
	Info_ClearChoices(DIA_Addon_Riordian_ADW_Teach);
};

func void DIA_Addon_Riordian_ADW_Teach_WISPSKILL_FOOD()
{
	if(B_TeachPlayerTalentWispDetector(self,other,WISPSKILL_FOOD))
	{
		DIA_Addon_Riordian_ADW_Teach_WISPSKILL_X();
	};
	Info_ClearChoices(DIA_Addon_Riordian_ADW_Teach);
};

func void DIA_Addon_Riordian_ADW_Teach_WISPSKILL_POTIONS()
{
	if(B_TeachPlayerTalentWispDetector(self,other,WISPSKILL_POTIONS))
	{
		DIA_Addon_Riordian_ADW_Teach_WISPSKILL_X();
	};
	Info_ClearChoices(DIA_Addon_Riordian_ADW_Teach);
};


instance DIA_Riordian_ADW_TeachAlchemy(C_Info)
{
	npc = KDW_14040_Addon_Riordian_ADW;
	nr = 4;
	condition = DIA_Riordian_ADW_TeachAlchemy_Condition;
	information = DIA_Riordian_ADW_TeachAlchemy_Info;
	permanent = TRUE;
	description = "Teach me the art of brewing potions.";
};


func int DIA_Riordian_ADW_TeachAlchemy_Condition()
{
	if((Riordian_Addon_TeachAlchemy == TRUE) && (Riordian_Addon_TeachAlchemy_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Riordian_ADW_TeachAlchemy_Info()
{
	var int talente;
	talente = 0;
	AI_Output (other, self, "DIA_Addon_Riordian_ADW_TeachAlchemy_15_00");	//Teach me the art of brewing potions.
	if ((PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Health_02] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Health_03] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Perm_Mana] == FALSE) || (PLAYER_TALENT_ALCHEMY[POTION_Perm_Health] == FALSE))
	{
		Info_ClearChoices(DIA_Riordian_ADW_TeachAlchemy);
		Info_AddChoice(DIA_Riordian_ADW_TeachAlchemy,Dialog_Back,DIA_Riordian_ADW_TeachAlchemy_BACK);
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE)
	{
		Info_AddChoice(DIA_Riordian_ADW_TeachAlchemy,B_BuildLearnString(NAME_HP_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_01)),DIA_Riordian_ADW_TeachAlchemy_Health_01);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Health_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_01] == TRUE))
	{
		Info_AddChoice(DIA_Riordian_ADW_TeachAlchemy,B_BuildLearnString(NAME_HP_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_02)),DIA_Riordian_ADW_TeachAlchemy_Health_02);
		talente += 1;
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE)
	{
		Info_AddChoice(DIA_Riordian_ADW_TeachAlchemy,B_BuildLearnString(NAME_Mana_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_01)),DIA_Riordian_ADW_TeachAlchemy_Mana_01);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == TRUE))
	{
		Info_AddChoice(DIA_Riordian_ADW_TeachAlchemy,B_BuildLearnString(NAME_Mana_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_02)),DIA_Riordian_ADW_TeachAlchemy_Mana_02);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == TRUE))
	{
		Info_AddChoice(DIA_Riordian_ADW_TeachAlchemy,B_BuildLearnString(NAME_Mana_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_03)),DIA_Riordian_ADW_TeachAlchemy_Mana_03);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Perm_Mana] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == TRUE))
	{
		Info_AddChoice(DIA_Riordian_ADW_TeachAlchemy,B_BuildLearnString(NAME_ManaMax_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_Mana)),DIA_Riordian_ADW_TeachAlchemy_Perm_Mana);
		talente += 1;
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Perm_DEX] == FALSE) && C_ShowAlchemySTRDEXDialog())
	{
		Info_AddChoice(DIA_Riordian_ADW_TeachAlchemy,B_BuildLearnString(NAME_DEX_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_DEX)),DIA_Riordian_ADW_TeachAlchemy_Perm_DEX);
		talente += 1;
	};
	if(talente > 0)
	{
		if(Alchemy_Explain == FALSE)
		{
			AI_Output (self, other, "DIA_Addon_Riordian_ADW_TeachAlchemy_10_01");	//Magical potions are brewed on an alchemist's bench. We have one up here in our dwelling.
			AI_Output (self, other, "DIA_Addon_Riordian_ADW_TeachAlchemy_10_02");	//You need an empty laboratory flask, the necessary ingredients and the knowledge of how the potion is created.
			AI_Output (self, other, "DIA_Addon_Riordian_ADW_TeachAlchemy_10_03");	//You can get that knowledge from me. The other things you will have to find for yourself.
			Alchemy_Explain = TRUE;
		};
		AI_Output(self,other,"DIA_Addon_Riordian_ADW_TeachAlchemy_10_04");	//What do you want to brew?
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Riordian_ADW_TeachAlchemy_10_05");	//I can't show you anything else that you don't already know.
		Riordian_Addon_TeachAlchemy_NoPerm = TRUE;
	};
};

func void DIA_Riordian_ADW_TeachAlchemy_BACK()
{
	Info_ClearChoices(DIA_Riordian_ADW_TeachAlchemy);
};

func void DIA_Riordian_ADW_TeachAlchemy_Health_01()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_01);
};

func void DIA_Riordian_ADW_TeachAlchemy_Health_02()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_02);
};

func void DIA_Riordian_ADW_TeachAlchemy_Mana_01()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_01);
};

func void DIA_Riordian_ADW_TeachAlchemy_Mana_02()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_02);
};

func void DIA_Riordian_ADW_TeachAlchemy_Mana_03()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_03);
};

func void DIA_Riordian_ADW_TeachAlchemy_Perm_Mana()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_Mana);
};

func void DIA_Riordian_ADW_TeachAlchemy_Perm_DEX()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_DEX);
};

