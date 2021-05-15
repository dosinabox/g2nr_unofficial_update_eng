
var int Lothar_ImOV;

instance DIA_Lothar_EXIT(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 999;
	condition = DIA_Lothar_EXIT_Condition;
	information = DIA_Lothar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Lothar_EXIT_Condition()
{
	if(Lothar_ImOV == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lothar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Lothar_FirstEXIT(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 999;
	condition = DIA_Lothar_FirstEXIT_Condition;
	information = DIA_Lothar_FirstEXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende_v1;
};


func int DIA_Lothar_FirstEXIT_Condition()
{
	if(Lothar_ImOV == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Lothar_FirstEXIT_Info()
{
	DIA_Common_IHaveToGo_v1();
	if((Lothar_Regeln == FALSE) && (Mil_305_schonmalreingelassen == FALSE))
	{
		AI_Output(self,other,"DIA_Lothar_FirstEXIT_01_01");	//Подожди! Ты даже не знаешь новых законов города!
		AI_Output(other,self,"DIA_Lothar_FirstEXIT_15_02");	//Позже.
	}
	else
	{
		if(Npc_KnowsInfo(other,DIA_Lothar_Dragons) && (hero.guild != GIL_PAL) && (hero.guild != GIL_KDF))
		{
			AI_Output (self, other, "DIA_Lothar_FirstEXIT_01_03");	//If I hear ONE more time that you are telling people here about dragons, you will be in big trouble, do I make myself clear?
		}
		else
		{
			AI_Output (self, other, "DIA_Lothar_FirstEXIT_01_04");	//As long as you are in Khorinis, you can feel safe.
			if (hero.guild != GIL_PAL)
			{
				AI_Output (self, other, "DIA_Lothar_FirstEXIT_01_05");	//The king's paladins watch over this city now!
			};
		};
		Lothar_ImOV = TRUE;
		Npc_ExchangeRoutine(self,"START");
	};
	AI_StopProcessInfos(self);
};


instance DIA_Lothar_Hallo(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 1;
	condition = DIA_Lothar_Hallo_Condition;
	information = DIA_Lothar_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lothar_Hallo_Condition()
{
	if((self.aivar[AIV_TalkedToPlayer] == FALSE) && (Mil_305_schonmalreingelassen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lothar_Hallo_Info()
{
	if(other.guild == GIL_NONE)
	{
		AI_Output(self,other,"DIA_Lothar_Hallo_01_00");	//Halt, stranger!
	};
	if((Mil_310_schonmalreingelassen == FALSE) && (Mil_333_schonmalreingelassen == FALSE) && (hero.guild != GIL_PAL) && (hero.guild != GIL_KDF) && (hero.guild != GIL_MIL))
	{
		AI_Output (self, other, "DIA_Lothar_Hallo_01_01");	//I haven't seen you come through this gate.
		AI_Output (other, self, "DIA_Lothar_Hallo_15_02");	//And?
		AI_Output (self, other, "DIA_Lothar_Hallo_01_03");	//And the guards on the other gate have orders not to let any unknown persons into the city.
		AI_Output (other, self, "DIA_Lothar_Hallo_15_04");	//Weeell...
		AI_Output (self, other, "DIA_Lothar_Hallo_01_05");	//I shall have to have a word with those two!
		AI_Output (self, other, "DIA_Lothar_Hallo_01_06");	//But now for us two:
	};
	AI_Output(self,other,"DIA_Lothar_Hallo_01_07");	//I am Lothar. Paladin of the King and humble servant of Innos, your Lord.
	AI_Output(self,other,"DIA_Lothar_Hallo_01_08");	//Our commander, Lord Hagen, has entrusted me with the task of explaining to all newcomers the new laws which apply to all inhabitants of the city.
	AI_Output(self,other,"DIA_Addon_Lothar_Hallo_01_00");	//Since people have started simply vanishing all over this town, everybody needs to watch out that they don't suffer the same fate.
	Player_KnowsLordHagen = TRUE;
	B_PlayerEnteredCity();
};


instance DIA_Lothar_MESSAGE(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 1;
	condition = DIA_Lothar_MESSAGE_Condition;
	information = DIA_Lothar_MESSAGE_Info;
	permanent = FALSE;
	description = "I have an important message for the leader of the paladins!";
};


func int DIA_Lothar_MESSAGE_Condition()
{
	if(PAL_205_schonmalreingelassen == FALSE)
	{
		if((hero.guild == GIL_NONE) || (hero.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Lothar_MESSAGE_Info()
{
	AI_Output(other,self,"DIA_Lothar_MESSAGE_15_00");	//I have an important message for the leader of the paladins!
	AI_Output(self,other,"DIA_Lothar_MESSAGE_01_01");	//The honorable Lord Hagen is not receiving anyone.
	AI_Output(self,other,"DIA_Lothar_MESSAGE_01_02");	//Lord Andre, the commander of the city guard, is responsible for all issues pertaining to the common folk.
	AI_Output(other,self,"DIA_Lothar_Add_15_00");	//But I MUST see Lord Hagen!
	AI_Output(self,other,"DIA_Lothar_Add_01_01");	//You must obey the rules, just like everybody else!
	AI_Output(self,other,"DIA_Lothar_Add_01_02");	//Lord Hagen is not available.
	AI_Output(self,other,"DIA_Lothar_Add_01_03");	//If you have something IMPORTANT to say, go to Lord Andre. He will help you!
	Player_KnowsLordHagen = TRUE;
	if(!Npc_KnowsInfo(other,DIA_Lothar_Hagen))
	{
		Lothar_Day = B_GetDayPlus();
	};
};


instance DIA_Lothar_EyeInnos(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 2;
	condition = DIA_Lothar_EyeInnos_Condition;
	information = DIA_Lothar_EyeInnos_Info;
	permanent = FALSE;
	description = "I have come to get the Eye of Innos!";
};


func int DIA_Lothar_EyeInnos_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Lothar_MESSAGE) && (LordHagen.aivar[AIV_TalkedToPlayer] == FALSE))
	if(Npc_KnowsInfo(other,DIA_Lothar_MESSAGE))
	{
		return TRUE;
	};
};

func void DIA_Lothar_EyeInnos_Info()
{
	AI_Output (other, self, "DIA_Lothar_EyeInnos_15_00");	//I have come to get the Eye of Innos!
	if ((hero.guild == GIL_PAL) || (hero.guild == GIL_KDF))
	{
		AI_Output(self,other,"DIA_Lothar_EyeInnos_01_01");	//The Eye is a matter for Lord Hagen. Speak to him about it.
		Player_KnowsLordHagen = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Lothar_EyeInnos_01_02");	//The sacred Eye of Innos! How do you know about that?! You are not a member of the order!
		AI_Output (other, self, "DIA_Lothar_EyeInnos_15_03");	//A magician told me about it.
		AI_Output (self, other, "DIA_Lothar_EyeInnos_01_04");	//I don't know what his motives were when he entrusted one of the secrets of our order to you.
		AI_Output (self, other, "DIA_Lothar_EyeInnos_01_05");	//But he certainly didn't mean for YOU to get your fingers on it.
		AI_Output (other, self, "DIA_Lothar_EyeInnos_15_06");	//But ...
		AI_Output (self, other, "DIA_Lothar_EyeInnos_01_07");	//I don't want to hear any more about it!
		if(Npc_KnowsInfo(other,DIA_Lothar_Dragons))
		{
			AI_Output (self, other, "DIA_Lothar_EyeInnos_01_08");	//First you start with fairy tales about dragons and then this - incredible!
		};
	};
};


instance DIA_Lothar_Dragons(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 1;
	condition = DIA_Lothar_Dragons_Condition;
	information = DIA_Lothar_Dragons_Info;
	permanent = FALSE;
	description = "Listen - the city is threatened by dragons!";
};


func int DIA_Lothar_Dragons_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Lothar_MESSAGE) && (LordHagen.aivar[AIV_TalkedToPlayer] == FALSE))
	if(Npc_KnowsInfo(other,DIA_Lothar_MESSAGE) || (other.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Lothar_Dragons_Info()
{
	AI_Output (other, self, "DIA_Lothar_Dragons_15_00");	//Listen - the city is threatened by dragons!
	if ((hero.guild != GIL_PAL) && (hero.guild != GIL_KDF))
	{
		AI_Output (self, other, "DIA_Lothar_Dragons_01_01");	//That can't be true!
		AI_Output (self, other, "DIA_Lothar_Dragons_01_02");	//Another lunatic!
		AI_Output (self, other, "DIA_Lothar_Dragons_01_03");	//We have enough unrest in the city as it is. And without some dimwit scaring people with fairy tales about dragons!
		AI_Output (self, other, "DIA_Lothar_Dragons_01_04");	//I immediately locked up the last person who was here telling dragon tales and sent him to the Valley of Mines with the prison transport. So mind your tongue!
		AI_Output(self,other,"DIA_Lothar_Dragons_01_05");	//We can't use anyone here who spreads panic among the people!
		if(Npc_KnowsInfo(other,DIA_DiegoOw_Hallo))
		{
			AI_Output(other,self,"DIA_Addon_Greg_NW_was_Diego_15_00");	//You're talking about Diego.
			AI_Output (other, self, "DIA_Lothar_WhoDragons_15_00");	//Somebody already reported the dragons here?
			AI_Output (self, other, "DIA_Lothar_WhoDragons_01_01");	//Yes. The fellow's name was Diego. I think so, in any case.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Lothar_Dragons_01_06");	//I have often heard that. But it is difficult to believe.
		AI_Output (self, other, "DIA_Lothar_Dragons_01_07");	//It would be better if you kept that to yourself. We must avoid fear and panic among the people.
	};
};


instance DIA_Addon_Lothar_Ornament(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 5;
	condition = DIA_Addon_Lothar_Ornament_Condition;
	information = DIA_Addon_Lothar_Ornament_Info;
	description = "Do you know anything about a stone creature from the stone circle at Lobart's farm?";
};


func int DIA_Addon_Lothar_Ornament_Condition()
{
//	if((LordHagen.aivar[AIV_TalkedToPlayer] == FALSE) && (MIS_Addon_Cavalorn_GetOrnamentFromPAL == LOG_Running))
	if(MIS_Addon_Cavalorn_GetOrnamentFromPAL == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Lothar_Ornament_Info()
{
	AI_Output (other, self, "DIA_Addon_Lothar_Ornament_15_00");	//Do you know anything about a stone creature from the stone circle at Lobart's farm?
	AI_Output (self, other, "DIA_Addon_Lothar_Ornament_01_01");	//Certainly. We destroyed it. It was a threat to the surrounding farms.
	AI_Output (self, other, "DIA_Addon_Lothar_Ornament_01_02");	//Why do you ask?
	Info_ClearChoices(DIA_Addon_Lothar_Ornament);
	if(Lord_Hagen_GotOrnament == FALSE)
	{
		Info_AddChoice(DIA_Addon_Lothar_Ornament,"I am looking for a metal fragment of a ring ornament.",DIA_Addon_Lothar_Ornament_suche);
	};
	Info_AddChoice(DIA_Addon_Lothar_Ornament,"Do you think that's normal?",DIA_Addon_Lothar_Ornament_normal);
};

func void DIA_Addon_Lothar_Ornament_normal()
{
	AI_Output (other, self, "DIA_Addon_Lothar_Ornament_normal_15_00");	//Do you think that's normal?
	AI_Output (self, other, "DIA_Addon_Lothar_Ornament_normal_01_01");	//That stone monster, you mean?
	AI_Output (self, other, "DIA_Addon_Lothar_Ornament_normal_01_02");	//As far as I know, the Water Mages are taking care of it.
	AI_Output (self, other, "DIA_Addon_Lothar_Ornament_normal_01_03");	//I don't give it much thought. We have our tasks here in town, and in the Valley of Mines.
	AI_Output (other, self, "DIA_Addon_Lothar_Ornament_normal_15_04");	//I see.
};

func void DIA_Addon_Lothar_Ornament_suche()
{
	AI_Output (other, self, "DIA_Addon_Lothar_Ornament_suche_15_00");	//I am looking for a metal fragment of a ring ornament.
	AI_Output (other, self, "DIA_Addon_Lothar_Ornament_suche_15_01");	//It should have been somewhere near Lobart's stone circle.
	AI_Output (self, other, "DIA_Addon_Lothar_Ornament_suche_01_02");	//Yes, there was such a thing. The stone creature was carrying it. I thought it was a rune of magic.
	AI_Output (self, other, "DIA_Addon_Lothar_Ornament_suche_01_03");	//I gave it to Lord Hagen. I've no idea whether he has still got it.
	Player_KnowsLordHagen = TRUE;
};


instance DIA_Lothar_WhoDragons(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 1;
	condition = DIA_Lothar_WhoDragons_Condition;
	information = DIA_Lothar_WhoDragons_Info;
	permanent = FALSE;
	description = "Somebody already reported the dragons here?";
};


func int DIA_Lothar_WhoDragons_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Lothar_Dragons) && (LordHagen.aivar[AIV_TalkedToPlayer] == FALSE))
	if(Npc_KnowsInfo(other,DIA_Lothar_Dragons) && !Npc_KnowsInfo(other,DIA_DiegoOw_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Lothar_WhoDragons_Info()
{
	AI_Output (other, self, "DIA_Lothar_WhoDragons_15_00");	//Somebody already reported the dragons here?
	AI_Output (self, other, "DIA_Lothar_WhoDragons_01_01");	//Yes. The fellow's name was Diego. I think so, in any case.
	if ((hero.guild != GIL_PAL) && (hero.guild != GIL_KDF))
	{
		AI_Output (self, other, "DIA_Lothar_WhoDragons_01_02");	//(threatens) I warned him - just like you! But the lunatic just wouldn't stop getting on my nerves!
	};
};


instance DIA_Lothar_Regeln(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 3;
	condition = DIA_Lothar_Regeln_Condition;
	information = DIA_Lothar_Regeln_Info;
	permanent = FALSE;
	description = "All right - explain the rules of the city to me!";
};


func int DIA_Lothar_Regeln_Condition()
{
	if(Mil_305_schonmalreingelassen == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Lothar_Regeln_Info()
{
	AI_Output (other, self, "DIA_Lothar_Regeln_15_00");	//(little sigh) All right - explain the rules of the city to me!
	AI_Output (self, other, "DIA_Lothar_Regeln_01_01");	//First: The honorable paladin Lord Hagen resides in the upper quarter, along with his troops.
	AI_Output (self, other, "DIA_Lothar_Regeln_01_02");	//That is why access to the upper quarter is allowed only to honorable citizens.
	AI_Output (self, other, "DIA_Lothar_Add_01_04");	//Second: The town hall in the upper quarter is now the command post of the paladins. Only the paladins themselves and members of the militia have access to it.
	AI_Output (self, other, "DIA_Lothar_Add_01_05");	//And third: Whoever is accused of a crime must exonerate himself with the commander of the militia.
	AI_Output (self, other, "DIA_Lothar_Regeln_01_05");	//Any questions?
	Player_KnowsLordHagen = TRUE;
	Lothar_Regeln = TRUE;
};


instance DIA_Addon_Lothar_MissingPeople(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 2;
	condition = DIA_Addon_Lothar_MissingPeople_Condition;
	information = DIA_Addon_Lothar_MissingPeople_Info;
	description = "Citizens of the town are simply disappearing?";
};


func int DIA_Addon_Lothar_MissingPeople_Condition()
{
	if(SC_HearedAboutMissingPeople == TRUE)
	{
		return TRUE;
	}
	else if(Npc_KnowsInfo(other,DIA_Lothar_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lothar_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Lothar_MissingPeople_15_00");	//The townspeople are simply disappearing?
	AI_Output (self, other, "DIA_Addon_Lothar_MissingPeople_01_01");	//Yes. It seems to be more every day.
	AI_Output (self, other, "DIA_Addon_Lothar_MissingPeople_01_02");	//It's most annoying that the militia have still not been able to discover what's behind these strange occurrences.
	AI_Output (self, other, "DIA_Addon_Lothar_MissingPeople_01_03");	//Small wonder that the town's inhabitants are very wary of strangers right now.
	AI_Output (self, other, "DIA_Addon_Lothar_MissingPeople_01_04");	//So don't provoke them when you're in town, understood?
	if (SC_HearedAboutMissingPeople == FALSE)
	{
		Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
		B_LogEntry(TOPIC_Addon_WhoStolePeople,LogText_Addon_SCKnowsMisspeapl);
	};
	SC_HearedAboutMissingPeople = TRUE;
};


instance DIA_Lothar_HowCitizen(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 4;
	condition = DIA_Lothar_HowCitizen_Condition;
	information = DIA_Lothar_HowCitizen_Info;
	permanent = FALSE;
	description = "How do I BECOME a citizen of the town?";
};


func int DIA_Lothar_HowCitizen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lothar_Regeln) && (Player_IsApprentice == APP_NONE))
	{
		if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Lothar_HowCitizen_Info()
{
	AI_Output (other, self, "DIA_Lothar_Add_15_06");	//How do I BECOME a citizen of the town?
	AI_Output (self, other, "DIA_Lothar_Add_01_07");	//Only those with regular jobs will be considered citizens of the town!
	AI_Output (self, other, "DIA_Lothar_Add_01_09");	//But don't think that you will be admitted to Lord Hagen just because you are a citizen of the town!
	AI_Output (self, other, "DIA_Lothar_Add_01_10");	//As a citizen you have access to the upper quarter - nothing more!
	AI_Output (self, other, "DIA_Lothar_Add_01_11");	//Only as a member of the militia will you have access to the town hall!
	Player_KnowsLordHagen = TRUE;
};


instance DIA_Lothar_WoArbeit(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 5;
	condition = DIA_Lothar_WoArbeit_Condition;
	information = DIA_Lothar_WoArbeit_Info;
	permanent = FALSE;
	description = "Where can I find work?";
};


func int DIA_Lothar_WoArbeit_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lothar_HowCitizen) && (Player_IsApprentice == APP_NONE))
	{
		if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Lothar_WoArbeit_Info()
{
	AI_Output (other, self, "DIA_Lothar_Add_15_14");	//Where can I find work?
	AI_Output (self, other, "DIA_Lothar_Add_01_15");	//You will have to apply as an apprentice to one of the masters here in the lower part of the city.
	AI_Output (self, other, "DIA_Lothar_Add_01_16");	//As soon as a master accepts you, you are a citizen of the town.
	AI_Output (self, other, "DIA_Lothar_Add_01_17");	//However, the other masters must agree to it, that is the custom here in Khorinis.
	AI_Output (self, other, "DIA_Lothar_Add_01_18");	//If you were thinking about looking for work in the harbor district - forget it!
	AI_Output (self, other, "DIA_Lothar_Add_01_19");	//The scum of the city live there. Don't even go there, you would regret it!
	AI_Output(other,self,"DIA_Lothar_Add_15_20");	//How many masters are there?
	AI_Output(self,other,"DIA_Lothar_Add_01_21");	//I believe there are five altogether.
};


instance DIA_Lothar_ToOV(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 6;
	condition = DIA_Lothar_ToOV_Condition;
	information = DIA_Lothar_ToOV_Info;
	permanent = FALSE;
	description = "How do I get to the upper quarter?";
};


func int DIA_Lothar_ToOV_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lothar_Regeln) && (Mil_305_schonmalreingelassen == FALSE) && (Player_IsApprentice == APP_NONE))
	{
		if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_Lothar_ToOV_Info()
{
	AI_Output (other, self, "DIA_Lothar_ToOV_15_00");	//How do I get to the upper quarter?
	AI_Output (self, other, "DIA_Lothar_ToOV_01_01");	//Say, are you listening to me at all?!
	AI_Output (self, other, "DIA_Lothar_ToOV_01_02");	//You are not a citizen of this town. You can save yourself the trip - the guards won't let you in.
	AI_Output (self, other, "DIA_Lothar_ToOV_01_03");	//The entire area behind the inner gate is off limits to you!
};


instance DIA_Lothar_ToMiliz(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 7;
	condition = DIA_Lothar_ToMiliz_Condition;
	information = DIA_Lothar_ToMiliz_Info;
	permanent = FALSE;
	description = "How do I get accepted into the militia?";
};


func int DIA_Lothar_ToMiliz_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lothar_Regeln) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Lothar_ToMiliz_Info()
{
	AI_Output (other, self, "DIA_Lothar_Add_15_26");	//How do I get accepted into the militia?
	if (Player_IsApprentice == APP_NONE)
	{
		AI_Output (self, other, "DIA_Lothar_Add_01_27");	//By express command of Lord Hagen, only citizens of the town will be admitted into the militia.
		AI_Output (other, self, "DIA_Lothar_Add_15_28");	//I see.
		Player_KnowsLordHagen = TRUE;
	};
	if((MIS_Harad_Orc == LOG_SUCCESS) || (MIS_HakonBandits == LOG_SUCCESS) || (MIS_Thorben_GetBlessings == LOG_SUCCESS) || (MIS_Matteo_Gold == LOG_SUCCESS) || (MIS_Bosper_WolfFurs == LOG_SUCCESS) || (MIS_Bosper_Bogen == LOG_SUCCESS))
	{
		AI_Output(self,other,"DIA_Lothar_Add_01_12");	//I have heard that you already have the approval of some of the masters.
	};
	AI_Output(self,other,"DIA_Lothar_Add_01_29");	//If you want to know more, speak to Lord Andre in the barracks.
};


instance DIA_Lothar_ToPaladins(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 7;
	condition = DIA_Lothar_ToPaladins_Condition;
	information = DIA_Lothar_ToPaladins_Info;
	permanent = FALSE;
	description = "What do I have to do to get armor like yours?";
};


func int DIA_Lothar_ToPaladins_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Lothar_ToMiliz) && (other.guild != GIL_PAL) && (other.guild != GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Lothar_ToPaladins_Info()
{
	AI_Output (other, self, "DIA_Lothar_Add_15_30");	//What do I have to do to get armor like yours?
	if (other.guild != GIL_MIL)
	{
		AI_Output (self, other, "DIA_Lothar_Add_01_31");	//(ranting) What? You aren't even a member of the militia!
	};
	if(Player_IsApprentice == APP_NONE)
	{
		AI_Output (self, other, "DIA_Lothar_Add_01_32");	//You're not even a CITIZEN!
	};
	AI_Output (self, other, "DIA_Lothar_Add_01_33");	//How can you even think of being allowed to wear the armor of a PALADIN?
	AI_Output (self, other, "DIA_Lothar_Add_01_34");	//Only a few militia soldiers, those who have performed extraordinary deeds, have been granted that honor so far.
	AI_Output (self, other, "DIA_Lothar_Add_01_35");	//(strictly) If you want to be a paladin, you have a long road ahead of you, my boy!
};


instance DIA_Lothar_WoAndre(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 8;
	condition = DIA_Lothar_WoAndre_Condition;
	information = DIA_Lothar_WoAndre_Info;
	permanent = FALSE;
	description = "Where can I find the commander of the city guard?";
};


func int DIA_Lothar_WoAndre_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Lothar_Regeln) || Npc_KnowsInfo(other,DIA_Lothar_MESSAGE)) && (Andre.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lothar_WoAndre_Info()
{
	AI_Output (other, self, "DIA_Lothar_WoAndre_15_00");	//Where can I find the commander of the city guard?
	AI_Output (self, other, "DIA_Lothar_WoAndre_01_01");	//Lord Andre can be found in the barracks at the other end of the city.
};


instance DIA_Lothar_Schlafen(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 9;
	condition = DIA_Lothar_Schlafen_Condition;
	information = DIA_Lothar_Schlafen_Info;
	permanent = FALSE;
	description = "Where can I spend the night here?";
};


func int DIA_Lothar_Schlafen_Condition()
{
	if(other.guild != GIL_MIL)
	{
		return TRUE;
	};
};

func void DIA_Lothar_Schlafen_Info()
{
	AI_Output (other, self, "DIA_Lothar_Add_15_22");	//Where can I spend the night here?
	AI_Output (self, other, "DIA_Lothar_Add_01_23");	//If you are looking for a place to sleep, go to the hotel directly across from the barracks.
	AI_Output (self, other, "DIA_Lothar_Add_01_24");	//The paladins pay for the lodging of all travelers who come to the city.
	AI_Output (self, other, "DIA_Lothar_Add_01_25");	//The traveling traders from the marketplace are also lodged there.
};


instance DIA_Lothar_PermB4OV(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 3;
	condition = DIA_Lothar_PermB4OV_Condition;
	information = DIA_Lothar_PermB4OV_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Lothar_PermB4OV_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Mil_305_schonmalreingelassen == FALSE) && (Lothar_Regeln == TRUE))
	{
		if(Npc_KnowsInfo(other,DIA_Lothar_MESSAGE) || Npc_KnowsInfo(other,DIA_Lothar_Hagen))
		{
			if((Lothar_Reported == TRUE) || (Lothar_Day >= Wld_GetDay()))
			{
				return TRUE;
			};
		}
		else
		{
			return TRUE;
		};
	};
};

func void DIA_Lothar_PermB4OV_Info()
{
	AI_Output (self, other, "DIA_Lothar_PermB4OV_01_00");	//You can talk to Lord Andre about everything else!
	AI_StopProcessInfos (self);
};

/*
func void B_Lothar_Blubb()
{
//	AI_Output(other,self,"DIA_Lothar_Add_15_00");	//But I MUST see Lord Hagen!
//	AI_Output(other,self,"DIA_Lothar_Add_15_20");	//How many masters are there?
//	AI_Output(self,other,"DIA_Lothar_Add_01_21");	//I believe there are five altogether.
//	AI_Output(self,other,"DIA_Lothar_Add_01_62");	//Tell me, didn't I make myself clear? No more tales about dragons!
//	AI_Output(other,self,"DIA_Lothar_Add_15_63");	//How do you know...?
//	AI_Output(self,other,"DIA_Lothar_Add_01_64");	//That is NONE of your business!
//	AI_Output(self,other,"DIA_Lothar_Add_01_65");	//That was the last time, understood?!
//	AI_Output(other,self,"DIA_Lothar_Add_15_66");	//Where do I find the commander of the militia?
//	AI_Output(other,self,"DIA_Lothar_Add_15_08");	//I am now an apprentice with one of the masters!
//	AI_Output(self,other,"DIA_Lothar_Add_01_43");	//I have heard that you saw Lord Andre?
//	AI_Output(self,other,"DIA_Lothar_Add_01_44");	//I told you that you could only join the militia if you were a citizen of the town.
//	AI_Output(self,other,"DIA_Lothar_Add_01_45");	//And as I see, he accepted you into the militia.
//	AI_Output(self,other,"DIA_Lothar_Add_01_46");	//Hm - he must know what he's doing.
//	AI_Output(self,other,"DIA_Lothar_Add_01_47");	//You again.
//	AI_Output(self,other,"DIA_Lothar_Add_01_48");	//I have reported to Lord Hagen that you wish to speak to him...
	AI_Output (other, self, "DIA_Lothar_Add_15_49");	//And? What did he say?
	AI_Output (self, other, "DIA_Lothar_Add_01_50");	//He has never heard of you.
	AI_Output (other, self, "DIA_Lothar_Add_15_51");	//Of course not. Did you tell him about the dragons?
	AI_Output (self, other, "DIA_Lothar_Add_01_52");	//Didn't I tell you to STOP these stories?!
	AI_Output (self, other, "DIA_Lothar_Add_01_12");	//I have heard that you already have the approval of some of the masters.
	AI_Output (self, other, "DIA_Lothar_Add_01_13");	//You're quite serious about this, aren't you?
	AI_Output (self, other, "DIA_Lothar_Add_01_01");	//You must obey the rules, just like everybody else!
	AI_Output (self, other, "DIA_Lothar_Add_01_02");	//Lord Hagen is not available.
	AI_Output (self, other, "DIA_Lothar_Add_01_03");	//If you have something IMPORTANT to say, go to Lord Andre. He will help you! Он поможет тебе!
};
*/

var int Lothar_Reported;

func int C_Lothar_Reported()
{
	if((Npc_KnowsInfo(other,DIA_Lothar_MESSAGE) || Npc_KnowsInfo(other,DIA_Lothar_Hagen)) && (LordHagen.aivar[AIV_TalkedToPlayer] == FALSE) && (Lothar_Day < Wld_GetDay()) && (Lothar_Reported == FALSE))
	{
		return TRUE;
	};
	return FALSE;
};

func void B_Lothar_Reported()
{
	AI_Output(self,other,"DIA_Lothar_Add_01_48");	//I have reported to Lord Hagen that you wish to speak to him...
	AI_Output (other, self, "DIA_Lothar_Add_15_49");	//And? What did he say?
	AI_Output (self, other, "DIA_Lothar_Add_01_50");	//He has never heard of you.
	if(Npc_KnowsInfo(other,DIA_Lothar_Dragons))
	{
		AI_Output (other, self, "DIA_Lothar_Add_15_51");	//Of course not. Did you tell him about the dragons?
		AI_Output (self, other, "DIA_Lothar_Add_01_52");	//Didn't I tell you to STOP these stories?!
	};
	Lothar_Reported = TRUE;
};

instance DIA_Lothar_HelloAgain(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 1;
	condition = DIA_Lothar_HelloAgain_Condition;
	information = DIA_Lothar_HelloAgain_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lothar_HelloAgain_Condition()
{
	if(Mil_305_schonmalreingelassen == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lothar_HelloAgain_Info()
{
	if(self.aivar[AIV_TalkedToPlayer] == TRUE)
	{
		AI_Output(self,other,"DIA_Lothar_HelloAgain_01_00");	//Ах! Опять ты!
		if((Player_IsApprentice > APP_NONE) && ((other.guild == GIL_NONE) || (other.guild == GIL_NOV)))
		{
			AI_Output(other,self,"DIA_Lothar_Add_15_08");	//I am now an apprentice with one of the masters!
		};
	};
	if(Player_TalkedAboutDragonsToSomeone == TRUE)
	{
		AI_Output(self,other,"DIA_Lothar_Add_01_62");	//Tell me, didn't I make myself clear? No more tales about dragons!
		AI_Output(other,self,"DIA_Lothar_Add_15_63");	//How do you know...?
		AI_Output(self,other,"DIA_Lothar_Add_01_64");	//That is NONE of your business!
		AI_Output(self,other,"DIA_Lothar_Add_01_65");	//That was the last time, understood?!
	};
	if(Npc_KnowsInfo(other,DIA_Lothar_ToOV))
	{
		AI_Output(self,other,"DIA_Lothar_HelloAgain_01_01");	//So you actually managed to get into the upper quarter!
		AI_Output(self,other,"DIA_Lothar_Add_01_13");	//You're quite serious about this, aren't you?
	};
	if((VisibleGuild(other) == GIL_KDF) || (VisibleGuild(other) == GIL_KDW))
	{
		AI_Output(self,other,"DIA_Lothar_Add_01_36");	//Where did you get that robe?
	};
	if(other.guild == GIL_KDF)
	{
		AI_Output(other,self,"DIA_Lothar_Add_15_37");	//I have passed the Test of Fire.
		AI_Output(self,other,"DIA_Lothar_Add_01_38");	//Incredible. Then what is happening here must be the will of Innos...
	}
	else if(other.guild == GIL_SLD)
	{
		if(self.aivar[AIV_TalkedToPlayer] == TRUE)
		{
			AI_Output(self,other,"DIA_Lothar_Add_01_39");	//You haven't joined Onar's mercenaries, have you?
		};
		AI_Output(self,other,"DIA_Lothar_Add_01_40");	//How did you get in here?
		if((Hagen_FriedenAbgelehnt == TRUE) || Npc_HasItems(other,ItWr_Passage_MIS))
		{
			AI_Output(other,self,"DIA_Lothar_Add_15_41");	//I bring a peace offering from Lee...
			AI_Output(self,other,"DIA_Lothar_Add_01_42");	//Bah! Lord Hagen will never agree to it.
			Player_KnowsLordHagen = TRUE;
		}
		else
		{
			if(Player_IsApprentice > APP_NONE)
			{
				AI_Output(other,self,"DIA_Lothar_Add_15_08");	//I am now an apprentice with one of the masters!
			}
			else
			{
				DIA_Common_Well();
			};
		};
	}
	else if(other.guild == GIL_MIL)
	{
		AI_Output(self,other,"DIA_Lothar_Add_01_43");	//I have heard that you saw Lord Andre?
		if(Npc_KnowsInfo(other,DIA_Lothar_ToMiliz))
		{
			AI_Output(self,other,"DIA_Lothar_Add_01_44");	//I told you that you could only join the militia if you were a citizen of the town.
			if(Player_IsApprentice > APP_NONE)
			{
				AI_Output(other,self,"DIA_Lothar_Add_15_08");	//I am now an apprentice with one of the masters!
			};
		};
		AI_Output (self, other, "DIA_Lothar_Add_01_45");	//And as I see, he accepted you into the militia.
		AI_Output (self, other, "DIA_Lothar_Add_01_46");	//Hm - he must know what he's doing.
	};
	if(!Npc_KnowsInfo(other,DIA_Lothar_Hallo))
	{
		AI_Output(self,other,"DIA_Lothar_Hallo_01_07");	//Я Лотар. Паладин короля и преданный слуга Инноса.
	};
	AI_Output(self,other,"DIA_Lothar_HelloAgain_01_02");	//There are some things you must heed here, otherwise you will wind up outside as fast as you got in here.
	AI_Output(self,other,"DIA_Lothar_HelloAgain_01_03");	//You are only allowed to enter the merchants' buildings. You can recognize them by the signs over the door - just so there are no misunderstandings.
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV) || (other.guild == GIL_SLD))
	{
		AI_Output(self,other,"DIA_Lothar_HelloAgain_01_04");	//The other buildings belong to important citizens - there is nothing there for you!
	}
	else
	{
		AI_Output(self,other,"DIA_Lothar_HelloAgain_01_08");	//The important citizens of this town live in this quarter. So treat them with respect.
	};
	if(other.guild == GIL_KDF)
	{
		AI_Output(self,other,"DIA_Lothar_HelloAgain_01_05");	//Even if you are now a member of the order of Innos.
	}
	else if(other.guild == GIL_MIL)
	{
		AI_Output (self, other, "DIA_Lothar_HelloAgain_01_06");	//As a member of the militia, you also have access to the rooms of the paladins.
		AI_Output (self, other, "DIA_Lothar_HelloAgain_01_07");	//But your quarters are still in the barracks.
	};
	AI_Output(self,other,"DIA_Lothar_HelloAgain_01_09");	//Do we understand each other?
	AI_Output(other,self,"DIA_Lothar_HelloAgain_15_10");	//Sure.
	if(C_Lothar_Reported())
	{
		B_Lothar_Reported();
	};
};


instance DIA_Lothar_Hagen(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 2;
	condition = DIA_Lothar_Hagen_Condition;
	information = DIA_Lothar_Hagen_Info;
	permanent = FALSE;
	description = "Where can I find Lord Hagen?";
};


func int DIA_Lothar_Hagen_Condition()
{
	if((Player_KnowsLordHagen == TRUE) && (LordHagen.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lothar_Hagen_Info()
{
	AI_Output (other, self, "DIA_Lothar_Hagen_15_00");	//Where can I find Lord Hagen?
	AI_Output (self, other, "DIA_Lothar_Hagen_01_01");	//He is in the town hall, at the end of the upper quarter.
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
	{
		AI_Output(self,other,"DIA_Lothar_Hagen_01_02");	//But you will not be admitted there without a good reason.
	};
	if(!Npc_KnowsInfo(other,DIA_Lothar_MESSAGE))
	{
		Lothar_Day = B_GetDayPlus();
	};
};


instance DIA_Lothar_Reported(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 1;
	condition = DIA_Lothar_Reported_Condition;
	information = DIA_Lothar_Reported_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Lothar_Reported_Condition()
{
	if(C_Lothar_Reported())
	{
		return TRUE;
	};
};

func void DIA_Lothar_Reported_Info()
{
	B_Lothar_Reported();
	AI_StopProcessInfos(self);
};


instance DIA_Lothar_OWRunning(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 2;
	condition = DIA_Lothar_OWRunning_Condition;
	information = DIA_Lothar_OWRunning_Info;
	permanent = FALSE;
	description = "I went to see Lord Hagen...";
};


func int DIA_Lothar_OWRunning_Condition()
{
	if((MIS_OLDWORLD == LOG_Running) && !Npc_HasItems(hero,ItWr_PaladinLetter_MIS) && Npc_KnowsInfo(other,DIA_Lothar_Dragons))
	{
		return TRUE;
	};
};

func void DIA_Lothar_OWRunning_Info()
{
	AI_Output (other, self, "DIA_Lothar_Add_15_53");	//I went to see Lord Hagen...
	AI_Output (self, other, "DIA_Lothar_Add_01_54");	//And? You didn't bother him with your dragon tales, did you?
	AI_Output (other, self, "DIA_Lothar_Add_15_55");	//Yes, I did...
	AI_Output (self, other, "DIA_Lothar_Add_01_56");	//Tell me this isn't true...
	AI_Output (other, self, "DIA_Lothar_Add_15_57");	//He sent me to get him some proof...
	AI_Output (self, other, "DIA_Lothar_Add_01_58");	//Well then, good luck. (to himself) What a lunatic...
	AI_StopProcessInfos (self);
};


instance DIA_Lothar_OWRunningBrief(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 2;
	condition = DIA_Lothar_OWRunningBrief_Condition;
	information = DIA_Lothar_OWRunningBrief_Info;
	permanent = FALSE;
	description = "I have the proof! Here is the letter from Commander Garond!";
};


func int DIA_Lothar_OWRunningBrief_Condition()
{
	if((MIS_OLDWORLD == LOG_Running) && Npc_HasItems(hero,ItWr_PaladinLetter_MIS) && Npc_KnowsInfo(other,DIA_Lothar_Dragons))
	{
		return TRUE;
	};
};

func void DIA_Lothar_OWRunningBrief_Info()
{
	AI_Output(other,self,"DIA_Lothar_Add_15_59");	//I have the proof! Here is the letter from Commander Garond!
	AI_PrintScreen("Given: Letter to Lord Hagen",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	AI_Output(self,other,"DIA_Lothar_Add_01_60");	//So there really are dragons?
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_UseMob(self,"THRONE",-1);
		B_TurnToNpc(self,other);
	};
	B_UseFakeScroll();
	AI_Output(self,other,"DIA_Lothar_Add_01_61");	//I have done you an injustice. I shall pray to Innos for forgiveness for my behavior.
	AI_PrintScreen("Received: Letter to Lord Hagen",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
};


instance DIA_Lothar_PERM(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 3;
	condition = DIA_Lothar_PERM_Condition;
	information = DIA_Lothar_PERM_Info;
	permanent = TRUE;
	description = "Has anything exciting happened lately?";
};


func int DIA_Lothar_PERM_Condition()
{
//	if((Mil_305_schonmalreingelassen == TRUE) && (LordHagen.aivar[AIV_TalkedToPlayer] == FALSE))
	if(Mil_305_schonmalreingelassen == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Lothar_PERM_Info()
{
	AI_Output(other,self,"DIA_Lothar_PERM_15_00");	//Has anything exciting happened lately?
	if((other.guild == GIL_NONE) || (other.guild == GIL_NOV) || (other.guild == GIL_SLD))
	{
		AI_Output (self, other, "DIA_Lothar_PERM_01_01");	//Yes, that they let someone like you in here. Such a thing hasn't happened in ages.
	}
	else if(other.guild == GIL_MIL)
	{
		AI_Output (self, other, "DIA_Lothar_PERM_01_02");	//You should know that best. As a member of the city guard, it is your task to see to law and order!
	}
	else
	{
		AI_Output (self, other, "DIA_Lothar_PERM_01_03");	//No.
	};
};


instance DIA_Lothar_PICKPOCKET(C_Info)
{
	npc = PAL_203_Lothar;
	nr = 900;
	condition = DIA_Lothar_PICKPOCKET_Condition;
	information = DIA_Lothar_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Lothar_PICKPOCKET_Condition()
{
	return C_Beklauen(56,95);
};

func void DIA_Lothar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Lothar_PICKPOCKET);
	Info_AddChoice(DIA_Lothar_PICKPOCKET,Dialog_Back,DIA_Lothar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Lothar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Lothar_PICKPOCKET_DoIt);
};

func void DIA_Lothar_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Lothar_PICKPOCKET);
};

func void DIA_Lothar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Lothar_PICKPOCKET);
};

