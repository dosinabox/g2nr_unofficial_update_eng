
instance DIA_Ingmar_EXIT(C_Info)
{
	npc = PAL_201_Ingmar;
	nr = 999;
	condition = DIA_Ingmar_EXIT_Condition;
	information = DIA_Ingmar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Ingmar_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Ingmar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Ingmar_Hallo(C_Info)
{
	npc = PAL_201_Ingmar;
	nr = 2;
	condition = DIA_Ingmar_Hallo_Condition;
	information = DIA_Ingmar_Hallo_Info;
	permanent = TRUE;
	important = TRUE;
};


var int DIA_Ingmar_Hallo_permanent;

func int DIA_Ingmar_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (DIA_Ingmar_Hallo_permanent == FALSE) && (Kapitel < 4))
	{
		return TRUE;
	};
};

func void DIA_Ingmar_Hallo_Info()
{
	if(MIS_OLDWORLD == FALSE)
	{
		AI_Output(self,other,"DIA_Ingmar_Hallo_06_03");	//I thought you had come to talk to Lord Hagen. So you should go ahead and do that.
	}
	else if(MIS_OLDWORLD == LOG_Running)
	{
		AI_Output(self,other,"DIA_Ingmar_Hallo_06_00");	//According to the reports I have received, the Valley of Mines is a dangerous place.
		AI_Output(self,other,"DIA_Ingmar_Hallo_06_01");	//Make sure to equip yourself well before you leave.
	}
	else
	{
		AI_Output(self,other,"DIA_Ingmar_Hallo_06_02");	//The situation in the Valley of Mines is quite worrying. But we shall develop plans to get rid of the dangers and get our boys out of there along with the ore.
		DIA_Ingmar_Hallo_permanent = TRUE;
	};
};


instance DIA_Ingmar_Krieg(C_Info)
{
	npc = PAL_201_Ingmar;
	nr = 99;
	condition = DIA_Ingmar_Krieg_Condition;
	information = DIA_Ingmar_Krieg_Info;
	permanent = FALSE;
	description = "How is the situation on the mainland.";
};


func int DIA_Ingmar_Krieg_Condition()
{
	return TRUE;
};

func void DIA_Ingmar_Krieg_Info()
{
	AI_Output (other, self, "DIA_Ingmar_Krieg_15_00");	//How is the situation on the mainland.
	AI_Output (self, other, "DIA_Ingmar_Krieg_06_01");	//The war isn't won yet, although the royal troops are already driving back the orcs.
	AI_Output (self, other, "DIA_Ingmar_Krieg_06_02");	//But small bands of orcs are gathering in many places, trying to scatter our army.
	AI_Output (self, other, "DIA_Ingmar_Krieg_06_03");	//They fight without honor and without faith - and therefore we shall prevail in the end.
};


instance DIA_Ingmar_CanTeach(C_Info)
{
	npc = PAL_201_Ingmar;
	nr = 100;
	condition = DIA_Ingmar_CanTeach_Condition;
	information = DIA_Ingmar_CanTeach_Info;
	permanent = TRUE;
	description = "Can you teach me?";
};


func int DIA_Ingmar_CanTeach_Condition()
{
	if(Ingmar_TeachSTR == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Ingmar_CanTeach_Info()
{
	AI_Output (other, self, "DIA_Ingmar_CanTeach_15_00");	//Can you teach me?
	if (other.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Ingmar_CanTeach_06_01");	//I can teach you how to fortify your arms in order to wield your weapons more effectively.
		Ingmar_TeachSTR = TRUE;
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"The paladin Ingmar can help me to become stronger.");
	}
	else
	{
		AI_Output(self,other,"DIA_Ingmar_CanTeach_06_02");	//I only instruct the followers of our Order.
	};
};


func void B_BuildLearnDialog_Ingmar()
{
	Info_ClearChoices(DIA_Ingmar_Teach);
	Info_AddChoice(DIA_Ingmar_Teach,Dialog_Back,DIA_Ingmar_Teach_BACK);
	if(other.aivar[REAL_STRENGTH] >= T_MAX)
	{
		AI_Output(self,other,"DIA_Ingmar_Teach_06_00");	//You are as strong as a troll. There is nothing more I can teach you.
	}
	else
	{
		Info_AddChoice(DIA_Ingmar_Teach,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_Ingmar_Teach_1);
		Info_AddChoice(DIA_Ingmar_Teach,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_Ingmar_Teach_5);
	};
};

instance DIA_Ingmar_Teach(C_Info)
{
	npc = PAL_201_Ingmar;
	nr = 6;
	condition = DIA_Ingmar_Teach_Condition;
	information = DIA_Ingmar_Teach_Info;
	permanent = TRUE;
	description = "I want to get stronger.";
};


func int DIA_Ingmar_Teach_Condition()
{
	if(Ingmar_TeachSTR == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Ingmar_Teach_Info()
{
	AI_Output(other,self,"DIA_Ingmar_Teach_15_00");	//I want to become stronger.
	B_BuildLearnDialog_Ingmar();
};

func void DIA_Ingmar_Teach_BACK()
{
	Info_ClearChoices(DIA_Ingmar_Teach);
};

func void DIA_Ingmar_Teach_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_MAX))
	{
		B_BuildLearnDialog_Ingmar();
	};
};

func void DIA_Ingmar_Teach_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_MAX))
	{
		B_BuildLearnDialog_Ingmar();
	};
};

instance DIA_Ingmar_ORKELITE(C_Info)
{
	npc = PAL_201_Ingmar;
	nr = 40;
	condition = DIA_Ingmar_ORKELITE_Condition;
	information = DIA_Ingmar_ORKELITE_Info;
	description = "The orcs are planning a major offensive.";
};


func int DIA_Ingmar_ORKELITE_Condition()
{
	if(((TalkedTo_AntiPaladin == TRUE) || Npc_HasItems(other,ItRi_OrcEliteRing) || (Hagen_SawOrcRing == TRUE)) && (hero.guild == GIL_PAL))
	{
		return TRUE;
	};
};

func void DIA_Ingmar_ORKELITE_Info()
{
	AI_Output (other, self, "DIA_Ingmar_ORKELITE_15_00");	//The orcs are planning a major offensive.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_06_01");	//Indeed. Well, that's very interesting. And how can you claim to know this?
	if (TalkedTo_AntiPaladin == TRUE)
	{
		AI_Output (other, self, "DIA_Ingmar_ORKELITE_15_02");	//I have talked to them.
	};
	AI_Output (other, self, "DIA_Ingmar_ORKELITE_15_03");	//Some of their leaders are haunting this area.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_06_04");	//Mmh. That doesn't sound like a typical Orc strategy.
	Info_ClearChoices (DIA_Ingmar_ORKELITE);
	Info_AddChoice (DIA_Ingmar_ORKELITE, "You had better come up with a way to get rid of them.", DIA_Ingmar_ORKELITE_loswerden);
	Info_AddChoice (DIA_Ingmar_ORKELITE, "What should we do now?", DIA_Ingmar_ORKELITE_wasTun);
	Info_AddChoice (DIA_Ingmar_ORKELITE, "What does that mean?", DIA_Ingmar_ORKELITE_wieso);
	Log_CreateTopic (TOPIC_OrcElite, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_OrcElite, LOG_Running);
	B_LogEntry (TOPIC_OrcElite, "Ingmar was deeply interested in the story of the orcish elite warriors.");
	MIS_KillOrkOberst = LOG_Running;
};

func void DIA_Ingmar_ORKELITE_loswerden()
{
	AI_Output (other, self, "DIA_Ingmar_ORKELITE_loswerden_15_00");	//You had better come up with a way to get rid of them.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_loswerden_06_01");	//It would suffice if we had more information. I shall send somebody to scout out the surroundings.
	Info_ClearChoices (DIA_Ingmar_ORKELITE);
};

func void DIA_Ingmar_ORKELITE_wieso()
{
	AI_Output (other, self, "DIA_Ingmar_ORKELITE_wieso_15_00");	//What does that mean?
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wieso_06_01");	//If what you say is right, that means that they hope to weaken us from the inside by attacking with their best warriors.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wieso_06_02");	//Usually, there is one warlord leading each horde of orc fighters. You rarely see two or more of them together.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wieso_06_03");	//They do this for a reason. Their leaders form the core of their attack strategy and are usually surrounded by the orc warriors.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wieso_06_04");	//Thus, it is really hard to get close to any of them without having to fight your way through a horde of at least 30 warriors.
	B_LogEntry (TOPIC_OrcElite, "Ingmar said something about a leader of the orcish warlords.");
};

func void DIA_Ingmar_ORKELITE_wasTun()
{
	AI_Output (other, self, "DIA_Ingmar_ORKELITE_wasTun_15_00");	//What should we do now?
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wasTun_06_01");	//When they are seen in numbers like this, they usually form a raiding patrol led by the highest among them.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wasTun_06_02");	//This highest warlord establishes the headquarters and withdraws to some cave from where he sends his troops into battle.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wasTun_06_03");	//If we could get hold of this leader, it would give us a decisive advantage.
//	AI_Output(other,self,"DIA_Addon_Greg_NW_DexterFound_wo_15_00");	//I know where you can find him.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wasTun_06_04");	//An orc leader usually likes to hang out in the vicinity of his enemies. It would be advisable to look for his cave somewhere not too far from the city.
	AI_Output (self, other, "DIA_Ingmar_ORKELITE_wasTun_06_05");	//Some orcs have been spotted near Lobart's farm. Maybe that's where you should begin your search.
	B_LogEntry (TOPIC_OrcElite, "According to Ingmar, I should find the orcish colonel in a cave somewhere near Lobart's farm. Ingmar wants me to find him and eliminate him.");
	Info_ClearChoices (DIA_Ingmar_ORKELITE);
};


instance DIA_Ingmar_HAUPTQUARTIER(C_Info)
{
	npc = PAL_201_Ingmar;
	nr = 41;
	condition = DIA_Ingmar_HAUPTQUARTIER_Condition;
	information = DIA_Ingmar_HAUPTQUARTIER_Info;
	permanent = FALSE;
	description = "I have been able to find the headquarters of the orcs.";
};


func int DIA_Ingmar_HAUPTQUARTIER_Condition()
{
	if(Npc_IsDead(AntiPaladin_NW) && Npc_KnowsInfo(other,DIA_Ingmar_ORKELITE))
	{
		return TRUE;
	};
};

func void DIA_Ingmar_HAUPTQUARTIER_Info()
{
	AI_Output (other, self, "DIA_Ingmar_HAUPTQUARTIER_15_00");	//I have been able to find the headquarters of the orcs. Their chief warlord has fallen.
	AI_Output (self, other, "DIA_Ingmar_HAUPTQUARTIER_06_01");	//This is great news. That will keep the orcs busy for a while.
	AI_Output (self, other, "DIA_Ingmar_HAUPTQUARTIER_06_02");	//Not bad, that. If we had more knights of your kind, the upcoming battle would be a piece of cake.
	AI_Output (self, other, "DIA_Ingmar_HAUPTQUARTIER_06_03");	//Here. Take our gold and use it towards your equipment.
	CreateInvItems(self,ItMi_Gold,300);
	B_GiveInvItems(self,other,ItMi_Gold,300);
	MIS_KillOrkOberst = LOG_SUCCESS;
	B_GivePlayerXP(XP_KilledOrkOberst);
};


instance DIA_Ingmar_PICKPOCKET(C_Info)
{
	npc = PAL_201_Ingmar;
	nr = 900;
	condition = DIA_Ingmar_PICKPOCKET_Condition;
	information = DIA_Ingmar_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be nearly impossible to steal his scroll)";
};


func int DIA_Ingmar_PICKPOCKET_Condition()
{
//	return C_StealItems(105,Hlp_GetInstanceID(ItWr_Manowar),1);
	if(Npc_HasItems(self,ItWr_Manowar))
	{
		return C_StealItem(105);
	};
	return FALSE;
};

func void DIA_Ingmar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Ingmar_PICKPOCKET);
	Info_AddChoice(DIA_Ingmar_PICKPOCKET,Dialog_Back,DIA_Ingmar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Ingmar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Ingmar_PICKPOCKET_DoIt);
};

func void DIA_Ingmar_PICKPOCKET_DoIt()
{
//	B_StealItems(105,Hlp_GetInstanceID(ItWr_Manowar),1);
	B_StealItem(105,Hlp_GetInstanceID(ItWr_Manowar));
	Info_ClearChoices(DIA_Ingmar_PICKPOCKET);
};

func void DIA_Ingmar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Ingmar_PICKPOCKET);
};

