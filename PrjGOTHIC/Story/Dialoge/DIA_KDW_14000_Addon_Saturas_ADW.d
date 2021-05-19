
func int C_SCHasBDTArmor()
{
	if(Npc_HasItems(hero,ITAR_BDT_M))
	{
		return TRUE;
	};
	if(Npc_HasItems(hero,ITAR_BDT_H))
	{
		return TRUE;
	};
	if(Npc_HasItems(hero,ITAR_Thorus_Addon))
	{
		return TRUE;
	};
	if(Npc_HasItems(hero,ITAR_OreBaron_Addon))
	{
		return TRUE;
	};
	if(Npc_HasItems(hero,ITAR_Bloodwyn_Addon))
	{
		return TRUE;
	};
	if(Npc_HasItems(hero,ITAR_Diego))
	{
		return TRUE;
	};
	return FALSE;
};

instance DIA_Addon_Saturas_ADW_EXIT(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 999;
	condition = DIA_Addon_Saturas_ADW_EXIT_Condition;
	information = DIA_Addon_Saturas_ADW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Saturas_ADW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Saturas_ADW_EXIT_Info()
{
	AI_StopProcessInfos (self);
	AI_Output (self, other, "DIA_Addon_Saturas_ADW_EXIT_14_00");	//May Adanos protect you.
};


instance DIA_Addon_Saturas_ADWStart(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 1;
	condition = DIA_Addon_Saturas_ADWStart_Condition;
	information = DIA_Addon_Saturas_ADWStart_Info;
	important = TRUE;
};


func int DIA_Addon_Saturas_ADWStart_Condition()
{
	return TRUE;
};

func void DIA_Addon_Saturas_ADWStart_Info()
{
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_14_00");	//Adanos be thanked. You are finally here. We thought you would not show up again.
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_15_01");	//(confused) What? How are you already HERE?
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_14_02");	//You went through the portal and we followed you. It did not take long before we arrived here.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_14_03");	//However, you were not there. We have been here for several days.
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_15_04");	//(surprised) SEVERAL DAYS? How can that be?
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_14_05");	//After we could not find you anywhere, Nefarius sought to ascertain what might have gone wrong. He seemed to be thoroughly baffeled until now.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_14_06");	//Well. Now you are here and can begin your work.
	Wld_InsertNpc (Giant_Rat, "ADW_PORTALTEMPEL_11");
	Wld_InsertNpc (Giant_Rat, "ADW_PORTALTEMPEL_11");
	Info_ClearChoices (DIA_Addon_Saturas_ADWStart);
	Info_AddChoice (DIA_Addon_Saturas_ADWStart, "What happened in the meantime?", DIA_Addon_Saturas_ADWStart_was);
};

func void DIA_Addon_Saturas_ADWStart_was()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_was_15_00");	//What happened in the meantime?
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_was_14_01");	//We have collected many new insights.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_was_14_02");	//The earthquakes do indeed appear to be STRONGER here. We are not very far from their center now.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_was_14_03");	//The builders of these old structures erected a city here in their day, so much we can already say.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_was_14_04");	//However, for some reason their culture came to an end.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_was_14_05");	//But so far, we can only speculate as to why.
	Info_AddChoice(DIA_Addon_Saturas_ADWStart,"What about Raven?",DIA_Addon_Saturas_ADWStart_Raven);
};

func void DIA_Addon_Saturas_ADWStart_Raven()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_Raven_15_00");	//What about Raven?
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_Raven_14_01");	//In his letter, Raven spoke of a temple and that he was trying to get inside.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_Raven_14_02");	//We are unanimously of the opinion that it is a temple of Adanos that Raven seeks to desecrate.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_Raven_14_03");	//The earthquakes are obviously the result of unholy incantations which keep colliding with a powerful spell.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_Raven_14_04");	//The gates of the temple are magically sealed, and this is the very magic that makes the stone sentinels arise.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_Raven_14_05");	//The temple is defending itself. We must stop Raven before he can penetrate into the holy of holies.
	Info_AddChoice (DIA_Addon_Saturas_ADWStart, "What happens next?", DIA_Addon_Saturas_ADWStart_wastun);
	Info_AddChoice (DIA_Addon_Saturas_ADWStart, "Raven is only a former ore baron, not a magician.", DIA_Addon_Saturas_ADWStart_RavenOnlyBaron);
	Info_AddChoice (DIA_Addon_Saturas_ADWStart, "What does Raven want in the temple?", DIA_Addon_Saturas_ADWStart_RavenAim);
};

func void DIA_Addon_Saturas_ADWStart_RavenAim()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_RavenAim_15_00");	//What does Raven want in the temple?
	AI_Output (self, other, "DIA_Addon_Bodo_14_01");	//We only know that it has to do with a powerful artifact that is somehow connected to Adanos and Beliar.
	AI_Output (self, other, "DIA_Addon_Bodo_14_02");	//(grimly) We can certainly assume that he is not up to anything good...
};

func void DIA_Addon_Saturas_ADWStart_RavenOnlyBaron()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_RavenOnlyBaron_15_00");	//Raven is only a former ore baron, not a magician. How can HE carry out an invocation like that?
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_RavenOnlyBaron_14_01");	//Perhaps it is not he himself, but rather a renegade magician in his pay.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_RavenOnlyBaron_14_02");	//One way or another, we MUST avert the evil.
};

func void DIA_Addon_Saturas_ADWStart_wastun()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_wastun_15_00");	//What happens next?
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun_14_01");	//WE shall remain here and continue studying the ancient culture.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun_14_02");	//The old scripts of the builders conceal a great many secrets which we must reveal - if we want to understand what happened here back then.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun_14_03");	//Meanwhile, YOU must do a few things for us...
	Info_AddChoice(DIA_Addon_Saturas_ADWStart,"What should I do?",DIA_Addon_Saturas_ADWStart_wastun2);
};

func void DIA_Addon_Saturas_ADWStart_wastun2()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_wastun2_15_00");	//What should I do?
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun2_14_01");	//You must find Raven and prevent him from desecrating the temple of Adanos.
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_wastun2_15_02");	//You mean I should KILL him.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun2_14_03");	//If that is the only way to stop him, then in Adanos' name...YES!
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun2_14_04");	//On your way, collect all the ancient relics and inscriptions of the builders you can find and bring them to us.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun2_14_05");	//We must know more about these people and their demise.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun2_14_06");	//Only when we see through Raven's plans can we  thwart them.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun2_14_07");	//Furthermore, you must find a way to free the slaves.
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_wastun2_15_08");	//(cynically) Is that all? I can do that left-handed.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_wastun2_14_09");	//(annoyed) I know that it is much to ask. Regard it as a chance to regain my trust.
	MIS_ADDON_Saturas_GoToRaven = LOG_Running;
	Log_CreateTopic(TOPIC_Addon_RavenKDW,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_RavenKDW,LOG_Running);
	B_LogEntries(TOPIC_Addon_RavenKDW,"Raven is desecrating the holy temple of Adanos. I must stop him. Even if it means that I have to kill him.");
	Log_CreateTopic(TOPIC_Addon_Sklaven,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_Sklaven,LOG_Running);
	B_LogNextEntry(TOPIC_Addon_Sklaven,"Saturas wants me to free the slaves.");
	Log_CreateTopic(TOPIC_Addon_Relicts,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_Relicts,LOG_Running);
	B_LogNextEntry(TOPIC_Addon_Relicts,"Saturas wants me to bring him anything that could provide more information about the old people of the builders.");
	Info_AddChoice(DIA_Addon_Saturas_ADWStart,"What should I do?",DIA_Addon_Saturas_ADWStart_back);
};

func void DIA_Addon_Saturas_ADWStart_back()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_back_15_00");	//I'll get going then.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_back_14_01");	//One more thing... Raven has gathered a large number of bandits about him.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_back_14_02");	//In your abscence, we have fetched another member of the Ring of Water here.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_back_14_03");	//We sent him into the swamp. He did not come back.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_back_14_04");	//We suspect that the bandits attack everyone who does not look as they do.
	if(!C_BanditArmorEquipped(other))
	{
		AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_back_14_05");	//So, acquire some of the bandits' armor.
		AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_back_14_06");	//That is the only way you will get close to them without being attacked right away.
		if(!C_SCHasBDTArmor())
		{
			Log_CreateTopic(TOPIC_Addon_BDTRuestung,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_BDTRuestung,LOG_Running);
			B_LogEntry(TOPIC_Addon_BDTRuestung,"The bandits shoot at anything that doesn't look like they do. I need some bandit armor if I want to get close to them.");
		};
	};
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Start");
};


instance DIA_Addon_Saturas_MissingPeople(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 3;
	condition = DIA_Addon_Saturas_MissingPeople_Condition;
	information = DIA_Addon_Saturas_MissingPeople_Info;
	description = "Have you found a trace of the missing people?";
};


func int DIA_Addon_Saturas_MissingPeople_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Addon_Patrick_Hi) && (Sklaven_Flucht == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADWStart_missingPeople_15_00");	//Have you found a trace of the missing people?
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_missingPeople_14_01");	//Only yesterday we found the body of a fisherman. He was lying under one of the ruins to the east.
	AI_Output (self, other, "DIA_Addon_Saturas_ADWStart_missingPeople_14_02");	//It looks as though the fisherman was from Khorinis. You should look into this.
	if(!Npc_HasItems(William,ITWr_Addon_William_01))
	{
		DIA_Common_IFoundHim();
		AI_Output(self,other,"DIA_Addon_Saturas_LanceLeiche_14_01");	//May his soul enter the realm of Adanos.
		if(FoundDeadWilliam == FALSE)
		{
			if(Sklaven_Flucht == FALSE)
			{
				Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
				Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
			};
			B_LogEntry(TOPIC_Addon_MissingPeople,"Wiliam the fisherman from Khorinis is dead. I found his bodu om Jharkendar.");
		};
		FoundDeadWilliam = TRUE;
	}
	else if(!Npc_KnowsInfo(other,DIA_Addon_Riordian_WhatToFind))
	{
		if(Sklaven_Flucht == FALSE)
		{
			Log_CreateTopic(TOPIC_Addon_MissingPeople,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_Addon_MissingPeople,LOG_Running);
		};
		B_LogEntry(TOPIC_Addon_MissingPeople,LogText_Addon_WilliamLeiche);
	};
};


instance DIA_Addon_Saturas_PoorRanger(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 2;
	condition = DIA_Addon_Saturas_PoorRanger_Condition;
	information = DIA_Addon_Saturas_PoorRanger_Info;
	description = "What poor swine did you send into the swamp?";
};


func int DIA_Addon_Saturas_PoorRanger_Condition()
{
	return TRUE;
};

func void DIA_Addon_Saturas_PoorRanger_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_PoorRanger_15_00");	//What poor swine did you send into the swamp?
	AI_Output (self, other, "DIA_Addon_Saturas_PoorRanger_14_01");	//His name was Lance.
	AI_Output (self, other, "DIA_Addon_Saturas_PoorRanger_14_02");	//I am afraid he did not get very far.
	Log_CreateTopic (TOPIC_Addon_Lance, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Lance, LOG_Running);
	B_LogEntry(TOPIC_Addon_Lance,"Saturas sent someone named Lance into the swamp. Saturas is afraid that Lance didn't get very far.");
};


instance DIA_Addon_Saturas_Piraten(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_Piraten_Condition;
	information = DIA_Addon_Saturas_Piraten_Info;
	description = "Where will I find bandit armor that fits me?";
};


func int DIA_Addon_Saturas_Piraten_Condition()
{
//	if((AlligatorJack.aivar[AIV_TalkedToPlayer] == FALSE) && (Greg.aivar[AIV_TalkedToPlayer] == FALSE))
	if(!C_SCHasBDTArmor() && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_Piraten_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_Piraten_15_00");	//Where will I find bandit armor that fits me?
	AI_Output (self, other, "DIA_Addon_Saturas_Piraten_14_01");	//There seems to be a camp of pirates to the west.
	AI_Output (self, other, "DIA_Addon_Saturas_Piraten_14_02");	//As far as we know, they are in contact with the bandits.
	AI_Output (self, other, "DIA_Addon_Saturas_Piraten_14_03");	//I do not think that they will attack you if you approach them.
	AI_Output (self, other, "DIA_Addon_Saturas_Piraten_14_04");	//Perhaps you can find some help with them...
	B_LogEntry (TOPIC_Addon_BDTRuestung, "Saturas says that the pirates could help me in my hunt for the armor.");
};


instance DIA_Addon_Saturas_LanceLeiche(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 2;
	condition = DIA_Addon_Saturas_LanceLeiche_Condition;
	information = DIA_Addon_Saturas_LanceLeiche_Info;
	description = "I found Lance's body.";
};


func int DIA_Addon_Saturas_LanceLeiche_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Saturas_PoorRanger) && !Npc_HasItems(Lance,ItRi_Ranger_Lance_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_LanceLeiche_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_LanceLeiche_15_00");	//I found Lance's body.
	AI_Output (self, other, "DIA_Addon_Saturas_LanceLeiche_14_01");	//May his soul enter the realm of Adanos.
	AI_Output (self, other, "DIA_Addon_Saturas_LanceLeiche_14_02");	//Be careful, my son. I do not want to mourn another such loss.
	TOPIC_End_Lance = TRUE;
	B_GivePlayerXP(XP_Addon_LanceLeiche);
};


instance DIA_Addon_Saturas_LanceRing(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_LanceRing_Condition;
	information = DIA_Addon_Saturas_LanceRing_Info;
	description = "I have Lance's aquamarine ring here.";
};


func int DIA_Addon_Saturas_LanceRing_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Saturas_LanceLeiche) && Npc_HasItems(other,ItRi_Ranger_Lance_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_LanceRing_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_LanceRing_15_00");	//I have Lance's aquamarine ring here.
	AI_Output (self, other, "DIA_Addon_Saturas_LanceRing_14_01");	//You had better give it to me so that it does not fall into the wrong hands.
	B_GiveInvItems(other,self,ItRi_Ranger_Lance_Addon,1);
	B_GivePlayerXP(XP_Addon_LanceRing);
};


var int DIA_Addon_Saturas_Tokens_OneTime;
var int Saturas_SCBroughtAllToken;
var int Saturas_BroughtTokenAmount;
var int ScBroughtToken;
var int Saturas_SCFound_ItMi_Addon_Stone_01;
var int Saturas_SCFound_ItMi_Addon_Stone_02;
var int Saturas_SCFound_ItMi_Addon_Stone_03;
var int Saturas_SCFound_ItMi_Addon_Stone_04;
var int Saturas_SCFound_ItMi_Addon_Stone_05;
var int Saturas_SCFound_SayWhereOnce;

func void B_Saturas_SCFound_SayWhereOnce()
{
	if(Saturas_SCFound_SayWhereOnce == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Saturas_Tokens_14_05");	//That looks good. Where did you find that?
		Saturas_SCFound_SayWhereOnce = TRUE;
	};
};

instance DIA_Addon_Saturas_Tokens(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 10;
	condition = DIA_Addon_Saturas_Tokens_Condition;
	information = DIA_Addon_Saturas_Tokens_Info;
	permanent = TRUE;
	description = "About the relics...";
};


func int DIA_Addon_Saturas_Tokens_Condition()
{
	if(Saturas_SCBroughtAllToken == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_Tokens_Info()
{
	var int BroughtToken;
	var int XP_BroughtTokens;
	var int Kohle;
	BroughtToken = 0;
	XP_BroughtTokens = 0;
	Saturas_SCFound_SayWhereOnce = FALSE;
	AI_Output(other,self,"DIA_Addon_Saturas_Tokens_15_00");	//About the relics.
	if((Npc_HasItems(other,ItMi_Addon_Stone_01) && (Saturas_SCFound_ItMi_Addon_Stone_01 == FALSE)) || (Npc_HasItems(other,ItMi_Addon_Stone_02) && (Saturas_SCFound_ItMi_Addon_Stone_02 == FALSE)) || (Npc_HasItems(other,ItMi_Addon_Stone_03) && (Saturas_SCFound_ItMi_Addon_Stone_03 == FALSE)) || (Npc_HasItems(other,ItMi_Addon_Stone_04) && (Saturas_SCFound_ItMi_Addon_Stone_04 == FALSE)) || (Npc_HasItems(other,ItMi_Addon_Stone_05) && (Saturas_SCFound_ItMi_Addon_Stone_05 == FALSE)))
	{
		AI_Output(other,self,"DIA_Addon_Saturas_Tokens_15_04");	//What about THIS?
		B_LogEntry(TOPIC_Addon_Relicts,"I have given Saturas the following relics:");
		if(Npc_HasItems(other,ItMi_Addon_Stone_01) && (Saturas_SCFound_ItMi_Addon_Stone_01 == FALSE))
		{
			B_GiveInvItems(other,self,ItMi_Addon_Stone_01,1);
			B_Saturas_SCFound_SayWhereOnce();
			AI_Output(other,self,"DIA_Addon_Saturas_Tokens_15_06");	//The bandits use these stone tablets as a sort of currency.
			B_UseStoneTablet(1);
			Saturas_SCFound_ItMi_Addon_Stone_01 = TRUE;
			BroughtToken += 1;
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_07");	//The tablets bear the sign of Quahodron, a great warrior.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_08");	//He is the commander whose son Rhademes caused the downfall of the entire city.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_09");	//(contemptuously) Tsk. I bet the bandits don't even know what it is they are trading there.
			Log_AddEntry(TOPIC_Addon_Relicts,"A red stone tablet that the bandits use as currency. It bears the name of the great warrior Quarhodron.");
		};
		if(Npc_HasItems(other,ItMi_Addon_Stone_02) && (Saturas_SCFound_ItMi_Addon_Stone_02 == FALSE))
		{
			B_GiveInvItems(other,self,ItMi_Addon_Stone_02,1);
			B_Saturas_SCFound_SayWhereOnce();
			AI_Output(other,self,"DIA_Addon_Saturas_Tokens_15_10");	//I found these tablets in a building to the south.
			B_UseStoneTablet(2);
			Saturas_SCFound_ItMi_Addon_Stone_02 = TRUE;
			BroughtToken += 1;
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_11");	//Ah! A tablet of the guardians of the dead. It was they who summoned the spirits of their dead.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_12");	//The builders' connection to their ancestors was very strong.
			Log_AddEntry(TOPIC_Addon_Relicts,"Purple stone tablet from the house of guardians of the dead.");
		};
		if(Npc_HasItems(other,ItMi_Addon_Stone_03) && (Saturas_SCFound_ItMi_Addon_Stone_03 == FALSE))
		{
			B_GiveInvItems(other,self,ItMi_Addon_Stone_03,1);
			B_Saturas_SCFound_SayWhereOnce();
			AI_Output(other,self,"DIA_Addon_Saturas_Tokens_15_13");	//I found these tablets in a structure to the southwest.
			B_UseStoneTablet(3);
			Saturas_SCFound_ItMi_Addon_Stone_03 = TRUE;
			BroughtToken += 1;
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_14");	//Judging from the tablet, it has something to do with the housing for the priests of the city.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_15");	//The name of the highest priest was KHARDIMON. We don't know much about him.
			Log_AddEntry(TOPIC_Addon_Relicts,"Blue stone tablet from the house of the priests.");
		};
		if(Npc_HasItems(other,ItMi_Addon_Stone_04) && (Saturas_SCFound_ItMi_Addon_Stone_04 == FALSE))
		{
			B_GiveInvItems(other,self,ItMi_Addon_Stone_04,1);
			B_Saturas_SCFound_SayWhereOnce();
			AI_Output(other,self,"DIA_Addon_Saturas_Tokens_15_15");	//This thing was lying in a building near the great swamp.
			B_UseStoneTablet(4);
			Saturas_SCFound_ItMi_Addon_Stone_04 = TRUE;
			BroughtToken += 1;
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_16");	//That would have been the house of the healers.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_17");	//We don't know much about them. They seem to have been the first to disappear.
			Log_AddEntry(TOPIC_Addon_Relicts,"Green stone tablet from the house of the healers.");
		};
		if(Npc_HasItems(other,ItMi_Addon_Stone_05) && (Saturas_SCFound_ItMi_Addon_Stone_05 == FALSE))
		{
			B_GiveInvItems(other,self,ItMi_Addon_Stone_05,1);
			B_Saturas_SCFound_SayWhereOnce();
			AI_Output(other,self,"DIA_Addon_Saturas_Tokens_15_18");	//This piece was lying in a large building in a deep ravine.
			B_UseStoneTablet(5);
			Saturas_SCFound_ItMi_Addon_Stone_05 = TRUE;
			BroughtToken += 1;
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_19");	//That was the library of the ancient people.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_20");	//Apparently a tablet of the scholars.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_80");	//Many of the scripts we have found can be traced to the leader of the 'Caste of Scholars'.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_81");	//Curiously enough, he did not leave his own name behind anywhere...
			Log_AddEntry(TOPIC_Addon_Relicts,"Yellow stone tablet from the lirbary of the scholars.");
		};
		XP_BroughtTokens = XP_Addon_ForOneToken * BroughtToken;
		B_GivePlayerXP(XP_BroughtTokens);
		Saturas_BroughtTokenAmount += BroughtToken;
		if(Saturas_BroughtTokenAmount < 5)
		{
			if(Saturas_KnowsHow2GetInTempel == FALSE)
			{
				AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_21");	//Very good. The image of this city is becoming clearer, but we still don't know enough.
			};
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_22");	//In all, there must be five of this sort of stone tablets hidden around here.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_23");	//Find them and bring them to me.
		};
		AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_24");	//Here is some gold as a reward.
		Kohle = 200 * BroughtToken;
		CreateInvItems(self,ItMi_Gold,Kohle);
		B_GiveInvItems(self,other,ItMi_Gold,Kohle);
		ScBroughtToken = TRUE;
	}
	else if((DIA_Addon_Saturas_Tokens_OneTime == FALSE) && (C_ScHasMagicStonePlate() || Npc_HasItems(other,ItWr_StonePlateCommon_Addon)))
	{
		AI_Output (other, self, "DIA_Addon_Saturas_Tokens_15_01");	//I think I have something here for you.
		AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_02");	//We already know this sort of stone tablet. They will not get us any further now.
		AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_03");	//There must be more than that.
		DIA_Addon_Saturas_Tokens_OneTime = TRUE;
	};
	if(Saturas_BroughtTokenAmount == 5)
	{
		AI_Output(self,other,"DIA_Addon_Saturas_Tokens_14_25");	//Now we have collected all of the relics we need.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_26");	//You have done us a great service. I thank you.
			AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_27");	//This will bring us a crucial step forward in our studies.
		Saturas_SCBroughtAllToken = TRUE;
		B_CheckLog();
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Saturas_Tokens_15_28");	//I'll see whether I can find anything.
		AI_Output (self, other, "DIA_Addon_Saturas_Tokens_14_29");	//Good. But hurry. Time is not our ally.
	};
};


instance DIA_Addon_Saturas_StonePlateHint(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_StonePlateHint_Condition;
	information = DIA_Addon_Saturas_StonePlateHint_Info;
	important = TRUE;
};


func int DIA_Addon_Saturas_StonePlateHint_Condition()
{
	if((Merdarion_GotFocusCount >= 2) || (RavenIsInTempel == TRUE))
	{
		if(RavenIsDead == FALSE)
		{
			return TRUE;
		}
		else if(Npc_KnowsInfo(other,DIA_Addon_Saturas_RavensDead) && (MyxirMovedToNW == TRUE))
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Saturas_StonePlateHint_Info()
{
	AI_Output (self, other, "DIA_Addon_Saturas_StonePlateHint_14_00");	//It is good that you came. We have new discoveries that we must share with you.
	AI_Output (other, self, "DIA_Addon_Saturas_StonePlateHint_15_01");	//Then let's hear it.
	AI_Output (self, other, "DIA_Addon_Saturas_StonePlateHint_14_02");	//The sunken city once bore the name of Jharkendar. There were 5 rulers in the city who shared the power over their people.
	AI_Output (self, other, "DIA_Addon_Saturas_StonePlateHint_14_03");	//Each of these rulers had a mansion where he lived and kept his belongings.
	AI_Output (self, other, "DIA_Addon_Saturas_StonePlateHint_14_04");	//Therefore, in your search for the relics of the ancient culture, it is crucial that you should search through these mansions.
	MIS_Saturas_LookingForHousesOfRulers = TRUE;
	Info_ClearChoices(DIA_Addon_Saturas_StonePlateHint);
	Info_AddChoice (DIA_Addon_Saturas_StonePlateHint, "What if these mansions no longer exist?", DIA_Addon_Saturas_StonePlateHint_unter);
	Info_AddChoice (DIA_Addon_Saturas_StonePlateHint, "Where should I look for these mansions?", DIA_Addon_Saturas_StonePlateHint_wo);
};

func void DIA_Addon_Saturas_StonePlateHint_wo()
{
	AI_Output (other, self, "DIA_Addon_Saturas_StonePlateHint_wo_15_00");	//Where should I look for these mansions?
	AI_Output (self, other, "DIA_Addon_Saturas_StonePlateHint_wo_14_01");	//Riordian has studied the structure of the buildings in Jharkendar.
	AI_Output (self, other, "DIA_Addon_Saturas_StonePlateHint_wo_14_02");	//He will tell you where you should look for the mansions.
	SaturasSendsToRiordian = TRUE;
	Log_CreateTopic(TOPIC_Addon_HousesOfRulers,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_HousesOfRulers,LOG_Running);
	B_LogEntry(TOPIC_Addon_HousesOfRulers,"Saturas wants me to search the mansions of the builders for something useful. Riordian will tell me where I can find these buildings.");
};

func void DIA_Addon_Saturas_StonePlateHint_unter()
{
	AI_Output (other, self, "DIA_Addon_Saturas_StonePlateHint_unter_15_00");	//What if these mansions no longer exist?
	AI_Output (self, other, "DIA_Addon_Saturas_StonePlateHint_unter_14_01");	//If you cannot find the houses, then they presumably sank with the city.
	AI_Output (self, other, "DIA_Addon_Saturas_StonePlateHint_unter_14_02");	//However, should they still exist, they would be of inestimable value for our studies.
};


instance DIA_Addon_Saturas_SCBroughtAllToken(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_SCBroughtAllToken_Condition;
	information = DIA_Addon_Saturas_SCBroughtAllToken_Info;
	description = "Why do you need these five stone tablets?";
};


func int DIA_Addon_Saturas_SCBroughtAllToken_Condition()
{
	if((ScBroughtToken == TRUE) && (Saturas_KnowsHow2GetInTempel == FALSE) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_SCBroughtAllToken_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_SCBroughtAllToken_15_00");	//Why do you need these five stone tablets?
	AI_Output (self, other, "DIA_Addon_Saturas_SCBroughtAllToken_14_01");	//The records which we have been able to find in these ruin are incomplete.
	AI_Output (self, other, "DIA_Addon_Saturas_SCBroughtAllToken_14_02");	//But the writings of the builders speak of five rulers who ruled this city.
	AI_Output (self, other, "DIA_Addon_Saturas_SCBroughtAllToken_14_03");	//Each of these rulers had one of these tablets as a symbol of his power.
	AI_Output (self, other, "DIA_Addon_Saturas_SCBroughtAllToken_14_04");	//I think these tablets are the key to our questions.
};


instance DIA_Addon_Saturas_Flut(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_Flut_Condition;
	information = DIA_Addon_Saturas_Flut_Info;
	description = "Nefarius told me about a flood...";
};


func int DIA_Addon_Saturas_Flut_Condition()
{
	if(NefariusADW_Talk2Saturas == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_Flut_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_Flut_15_00");	//Nefarius told me about a flood...
	AI_Output (self, other, "DIA_Addon_Saturas_Flut_14_02");	//It is written that Adanos himself descended from heaven to punish the unbelievers and banish them to the realm of the dead.
	AI_Output (self, other, "DIA_Addon_Saturas_Flut_14_03");	//Aroused by his holy wrath, he let the sea fall upon the builders of this city and swept them away.
	AI_Output (self, other, "DIA_Addon_Saturas_Flut_14_04");	//The swamp to the east still bears witness to these events of the past.
	TOPIC_END_Flut = TRUE;
	B_GivePlayerXP(XP_AmbientKap3);
};


instance DIA_Addon_Saturas_AdanosZorn(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_AdanosZorn_Condition;
	information = DIA_Addon_Saturas_AdanosZorn_Info;
	description = "What could have made Adanos so angry?";
};


func int DIA_Addon_Saturas_AdanosZorn_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Saturas_Flut))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_AdanosZorn_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_AdanosZorn_15_00");	//What could have made Adanos so angry?
	AI_Output (self, other, "DIA_Addon_Saturas_AdanosZorn_14_01");	//The temple of this city was once a great, glorious structure.
	AI_Output (self, other, "DIA_Addon_Saturas_AdanosZorn_14_02");	//Everyone honored it and prayed to our god Adanos.
	AI_Output (self, other, "DIA_Addon_Saturas_AdanosZorn_14_03");	//Rhademes, the son of the commander Quahodron, desecrated the temple.
	AI_Output (self, other, "DIA_Addon_Saturas_AdanosZorn_14_04");	//As a result, one after another fell victim to evil.
	AI_Output (self, other, "DIA_Addon_Saturas_AdanosZorn_14_05");	//I suspect that Adanos could not forgive this and his revenge fell upon the land.
	if(RavenIsDead == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Saturas_AdanosZorn_14_06");	//This makes it even more important that we stop Raven. He is about to do exactly the same thing...
	};
};


instance DIA_Addon_Saturas_RavenInfos(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 9;
	condition = DIA_Addon_Saturas_RavenInfos_Condition;
	information = DIA_Addon_Saturas_RavenInfos_Info;
	permanent = TRUE;
	description = "About Raven...";
};


var int DIA_Addon_Saturas_RavenInfos_OneTime1;
var int DIA_Addon_Saturas_RavenInfos_OneTime2;
var int DIA_Addon_Saturas_RavenInfos_OneTime3;
var int DIA_Addon_Saturas_RavenInfos_OneTime4;
var int DIA_Addon_Saturas_RavenInfos_OneTime5;
var int Addon_Saturas_Fortuno;

func int DIA_Addon_Saturas_RavenInfos_Condition()
{
	if((MIS_ADDON_Saturas_GoToRaven == LOG_Running) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_RavenInfos_Info()
{
	var int RavenNeuigkeit;
	var int XP_RavenNeuigkeit;
	AI_Output(other,self,"DIA_Addon_Saturas_RavenInfos_15_00");	//About Raven...
	RavenNeuigkeit = 0;
	if(((EnteredBanditsCamp == TRUE) || Npc_IsDead(Senyan) || Npc_IsDead(Esteban) || Npc_IsDead(Wache_01) || Npc_IsDead(Wache_02) || Npc_IsDead(Bloodwyn)) && (DIA_Addon_Saturas_RavenInfos_OneTime1 == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Saturas_RavenInfos_15_01");	//I was in the bandit camp to the east. Raven is their leader.
		if(Npc_IsDead(Franco) || Npc_IsDead(Ramon) || Npc_IsDead(Senyan) || Npc_IsDead(Esteban) || Npc_IsDead(Wache_01) || Npc_IsDead(Wache_02) || Npc_IsDead(Bloodwyn))
		{
			AI_Output(other,self,"DIA_Addon_Saturas_RavenInfos_15_02");	//But in order to get to Raven, I have to get some of the bandits out of the way first.
		};
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_03");	//Fine. Then good luck. But do not forget that it must happen quickly.
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_04");	//Raven must not reach his goal under any circumstances.
		DIA_Addon_Saturas_RavenInfos_OneTime1 = TRUE;
		RavenNeuigkeit += 1;
	};
	if((SC_KnowsRavensGoldmine == TRUE) && (DIA_Addon_Saturas_RavenInfos_OneTime2 == FALSE))
	{
		AI_Output(other,self,"DIA_Addon_Saturas_RavenInfos_15_05");	//He has a gold mine and has the prisoners digging for gold.
		if(!Npc_KnowsInfo(other,DIA_Addon_Saturas_FreedMissingPeople))
		{
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_06");	//That sounds like him. You must get the prisoners out of there.
		AI_Output (other, self, "DIA_Addon_Saturas_RavenInfos_15_07");	//(sighs) Yes, of course. I'm working on it.
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Saturas_TuerZu_14_10");	//Right!
		};
		DIA_Addon_Saturas_RavenInfos_OneTime2 = TRUE;
		RavenNeuigkeit += 1;
	};
	if((MIS_Fortuno_Delusion == LOG_SUCCESS) && (DIA_Addon_Saturas_RavenInfos_OneTime3 == FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Saturas_RavenInfos_15_08");	//There is even a fellow with the bandits who claims to know Raven's plans.
		AI_Output (other, self, "DIA_Addon_Saturas_RavenInfos_15_09");	//His name is Fortuno. He says that Raven wants to get into the temple to get a powerful artifact.
		AI_Output (self, other, "DIA_Addon_Bodo_14_03");	//And? Did he know more about this artifact?
		AI_Output (other, self, "DIA_Addon_Saturas_RavenInfos_15_11");	//He could only tell me that Raven has had the grave of a priest of Adanos opened.
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_12");	//This grave may contain the key to the temple. You should take a look around there.
		AI_Output (other, self, "DIA_Addon_Saturas_RavenInfos_15_13");	//Raven has forced the prisoners to excavate the grave of the priest.
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_14");	//That is not good. You must hurry and stop Raven.
		Addon_Saturas_Fortuno = TRUE;
		DIA_Addon_Saturas_RavenInfos_OneTime3 = TRUE;
		RavenNeuigkeit += 1;
	};
	if((RavenIsInTempel == TRUE) && (DIA_Addon_Saturas_RavenInfos_OneTime4 == FALSE))
	{
		AI_Output (other, self, "DIA_Addon_Saturas_RavenInfos_15_15");	//I made my way into Raven's quarters.
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_16");	//And? What about Raven?
		AI_Output (other, self, "DIA_Addon_Saturas_RavenInfos_15_17");	//I came too late. He disappeared into the Adanos temple right before my eyes.
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_18");	//(agitated) What?! That is a CATASTROPHE! Why didn't you follow him?!
		DIA_Addon_Saturas_RavenInfos_OneTime4 = TRUE;
		MIS_ADDON_Saturas_GoToRaven = LOG_SUCCESS;
		RavenNeuigkeit += 1;
	};
	if(RavenNeuigkeit != 0)
	{
		XP_RavenNeuigkeit = RavenNeuigkeit * XP_Ambient;
		B_GivePlayerXP(XP_RavenNeuigkeit);
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_19");	//Do you have anything new to report?
		AI_Output (other, self, "DIA_Addon_Saturas_RavenInfos_15_20");	//Nothing so far.
		AI_Output (self, other, "DIA_Addon_Saturas_RavenInfos_14_21");	//I advise you not to underestimate this Raven, do you hear me?
	};
};


instance DIA_Addon_Saturas_TuerZu(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_TuerZu_Condition;
	information = DIA_Addon_Saturas_TuerZu_Info;
	description = "I wasn't able to follow Raven!";
};


func int DIA_Addon_Saturas_TuerZu_Condition()
{
	if((MIS_ADDON_Saturas_GoToRaven == LOG_SUCCESS) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_TuerZu_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_TuerZu_15_00");	//I couldn't follow Raven. He blocked the entrance from inside.
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_02");	//(hurriedly) I must think...
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_03");	//The question is how did Raven get into the temple...
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_04");	//What did he do before he passed through the portal?
	AI_Output (other, self, "DIA_Addon_Saturas_TuerZu_15_05");	//He spoke an incantation at the gate.
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_06");	//And before that?
	AI_Output (other, self, "DIA_Addon_Saturas_TuerZu_15_07");	//He opened a burial chamber.
	if (Addon_Saturas_Fortuno == TRUE)
	{
		AI_Output (other, self, "DIA_Addon_Saturas_TuerZu_15_09");	//I already told you about that...
		AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_10");	//Right!
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Saturas_TuerZu_15_08");	//I only know that he must have performed some sort of ritual there...
	};
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_11");	//(considering) A ritual...
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_12");	//(figuring it out) Yes! That's it!
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_13");	//I fear that Raven has made the power of the guardians of the dead his own.
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_14");	//He got his knowledge of the temple from a spirit!
	AI_Output (self, other, "DIA_Addon_Saturas_TuerZu_14_15");	//You must go to Myxir and tell him about this!
	Log_CreateTopic (TOPIC_Addon_Quarhodron, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Quarhodron, LOG_Running);
	B_LogEntry (TOPIC_Addon_Quarhodron, "Raven has gained the power of the guardians of the dead. He got his knowledge of the temple of Adanos from a ghost. I must go to Myxir and tell him about it.");
	Saturas_RiesenPlan = TRUE;
};


instance DIA_Addon_Saturas_GhostQuestions(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_GhostQuestions_Condition;
	information = DIA_Addon_Saturas_GhostQuestions_Info;
	description = "I talked to Quarhodron.";
};


func int DIA_Addon_Saturas_GhostQuestions_Condition()
{
	if((SC_TalkedToGhost == TRUE) && (Ghost_SCKnowsHow2GetInAdanosTempel == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_GhostQuestions_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_GhostQuestions_15_00");	//I talked to Quarhodron.
	AI_Output (self, other, "DIA_Addon_Saturas_GhostQuestions_14_01");	//And? What did he say?
	AI_Output (other, self, "DIA_Addon_Saturas_GhostQuestions_15_02");	//He will only help me if I answer some questions.
	AI_Output (self, other, "DIA_Addon_Saturas_GhostQuestions_14_03");	//What is the problem?
	AI_Output (other, self, "DIA_Addon_Saturas_GhostQuestions_15_04");	//I'm not sure what I should answer.
	AI_Output (self, other, "DIA_Addon_Saturas_GhostQuestions_14_05");	//Mmh... we know that the scholars of this city built a library to the north.
	AI_Output (self, other, "DIA_Addon_Saturas_GhostQuestions_14_06");	//They made great efforts to record the events of the past.
	AI_Output (self, other, "DIA_Addon_Saturas_GhostQuestions_14_07");	//Perhaps you will find the answers that Quarhodron demands of you there.
	B_LogEntry (TOPIC_Addon_Quarhodron, "Saturas suspects that I can find the answers to Quarhodron's questions in the library of the scholars. The library is far to the north.");
};


instance DIA_Addon_Saturas_TalkedToGhost(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_TalkedToGhost_Condition;
	information = DIA_Addon_Saturas_TalkedToGhost_Info;
	description = "The problem with the temple gate is solved.";
};


func int DIA_Addon_Saturas_TalkedToGhost_Condition()
{
	if((Ghost_SCKnowsHow2GetInAdanosTempel == TRUE) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_TalkedToGhost_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_TalkedToGhost_15_00");	//The problem with the temple gate is solved.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_14_01");	//Has the spirit spoken?
	AI_Output (other, self, "DIA_Addon_Saturas_TalkedToGhost_15_02");	//Yes, he has.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_14_03");	//Then you know how to get into the temple.
	AI_Output (other, self, "DIA_Addon_Saturas_TalkedToGhost_15_04");	//Correct. And he also told me what is in the temple.
	AI_Output (other, self, "DIA_Addon_Saturas_TalkedToGhost_15_05");	//He spoke of a mighty sword and the chambers of Adanos.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_14_06");	//(despairing) By Adanos. What fools we are. How could we be so innocent.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_14_07");	//(shaken) The hints in the records...
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_14_08");	//(excited) This sword can only be the 'Claw of Beliar'.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_14_09");	//We must get through those chambers as soon as possible and take possession of the weapon.
	Info_ClearChoices (DIA_Addon_Saturas_TalkedToGhost);
	Info_AddChoice (DIA_Addon_Saturas_TalkedToGhost, "What is the 'Claw of Beliar'?", DIA_Addon_Saturas_TalkedToGhost_wasistdas);
	Info_AddChoice (DIA_Addon_Saturas_TalkedToGhost, "What are the chambers of Adanos?", DIA_Addon_Saturas_TalkedToGhost_kammern);
};

func void DIA_Addon_Saturas_TalkedToGhost_wasistdas()
{
	AI_Output (other, self, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_15_00");	//What is the 'Claw of Beliar'?
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_01");	//It is the incarnation of Evil. Beliar HIMSELF created it.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_02");	//Whoever bears it possesses a terrible tool of destruction.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_03");	//The more powerful the bearer is, the mightier the power of the 'Claw'.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_04");	//Only someone who is strong of spirit and steadfast in his faith can withstand its spell.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_05");	//Now it is clear to me why the builders sealed off this valley.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_06");	//They brought this weapon of Evil into their city and fell under its power.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_07");	//Those arrogant fools destroyed one another out of greed.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_08");	//The cruelty knew no end until Adanos' wrath swept across the land and sank everything into the sea.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_09");	//Indeed. The creators of the portal did well to hide these things from the rest of the world.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_10");	//What a tragic end for such a wonderful culture.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_11");	//Do you realize the urgency of our mission now?
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_12");	//Raven is a strong fighter and is blinded by his lust for power.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_13");	//In his hand, the Claw will be an instrument of destruction.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_wasistdas_14_14");	//He must not get the weapon or we shall all be lost.
	Log_CreateTopic (TOPIC_Addon_Klaue, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Klaue, LOG_Running);
	B_LogEntry (TOPIC_Addon_Klaue, "There is a powerful weapon in the temple of Adanos. It is called the 'Claw of Beliar'. Raven cannot be allowed to get his hands on this weapon.");
};

func void DIA_Addon_Saturas_TalkedToGhost_kammern()
{
	AI_Output (other, self, "DIA_Addon_Saturas_TalkedToGhost_kammern_15_00");	//What are the chambers of Adanos?
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_kammern_14_01");	//We now know that the entrance is not the only obstacle that prevents us from entering the depths of the temple.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_kammern_14_02");	//In the temple itself, there are three chambers which are meant to deter all intruders.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_kammern_14_03");	//The colored relics of the builders are the key.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_kammern_14_04");	//Only if we gather all of the relics and solve their riddles will we enter the inner sanctum of the temple.
	AI_Output (self, other, "DIA_Addon_Saturas_TalkedToGhost_kammern_14_05");	//I don't know whether Raven was able decipher the riddles of the temple, but if that is the case, we have a big problem.
	Log_CreateTopic(TOPIC_Addon_Kammern,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_Kammern,LOG_Running);
	B_LogEntry(TOPIC_Addon_Kammern,LogText_Addon_Relicts);
	B_LogEntry(TOPIC_Addon_Kammern,"Saturas has sent me to the temple of Adanos. I'm to get past the traps and stop Raven.");
	if(Saturas_SCBroughtAllToken == FALSE)
	{
		B_LogEntry(TOPIC_Addon_Relicts,LogText_Addon_Relicts);
	};
	Saturas_KnowsHow2GetInTempel = TRUE;
	B_CheckLog();
};


instance DIA_Addon_Saturas_RelictsBack(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_RelictsBack_Condition;
	information = DIA_Addon_Saturas_RelictsBack_Info;
	permanent = TRUE;
	description = "What exactly should I do with the relics in the temple?";
};


func int DIA_Addon_Saturas_RelictsBack_Condition()
{
	if((Saturas_KnowsHow2GetInTempel == TRUE) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_RelictsBack_Info()
{
	var int info_ypos;
	info_ypos = 35;
	AI_Output (other, self, "DIA_Addon_Saturas_RelictsBack_15_00");	//What exactly should I do with the relics in the temple?
	AI_Output (self, other, "DIA_Addon_Saturas_RelictsBack_14_03");	//We know too little. However, it is to be hoped that you will recognize their significance once you are in the temple.
	AI_Output (self, other, "DIA_Addon_Saturas_RelictsBack_14_05");	//I am sorry that I cannot tell you more. It is all up to you now.
	if(Npc_HasItems(self,ItMi_Addon_Stone_01) || Npc_HasItems(self,ItMi_Addon_Stone_02) || Npc_HasItems(self,ItMi_Addon_Stone_03) || Npc_HasItems(self,ItMi_Addon_Stone_04) || Npc_HasItems(self,ItMi_Addon_Stone_05))
	{
		AI_Output(self,other,"DIA_Addon_Saturas_RelictsBack_14_06");	//Take the relics and make your way immediately to the temple.
		if(Npc_HasItems(self,ItMi_Addon_Stone_01) && (Saturas_SCFound_ItMi_Addon_Stone_01 == TRUE))
		{
			Npc_RemoveInvItems(self,ItMi_Addon_Stone_01,1);
			CreateInvItems(hero,ItMi_Addon_Stone_01,1);
			AI_PrintScreen("Received: Red Stone Tablet",-1,info_ypos,FONT_ScreenSmall,3);
			info_ypos += 3;
		};
		if(Npc_HasItems(self,ItMi_Addon_Stone_02) && (Saturas_SCFound_ItMi_Addon_Stone_02 == TRUE))
		{
			Npc_RemoveInvItems(self,ItMi_Addon_Stone_02,1);
			CreateInvItems(hero,ItMi_Addon_Stone_02,1);
			AI_PrintScreen("Received: Purple Stone Tablet",-1,info_ypos,FONT_ScreenSmall,3);
			info_ypos += 3;
		};
		if(Npc_HasItems(self,ItMi_Addon_Stone_03) && (Saturas_SCFound_ItMi_Addon_Stone_03 == TRUE))
		{
			Npc_RemoveInvItems(self,ItMi_Addon_Stone_03,1);
			CreateInvItems(hero,ItMi_Addon_Stone_03,1);
			AI_PrintScreen("Received: Blue Stone Tablet",-1,info_ypos,FONT_ScreenSmall,3);
			info_ypos += 3;
		};
		if(Npc_HasItems(self,ItMi_Addon_Stone_04) && (Saturas_SCFound_ItMi_Addon_Stone_04 == TRUE))
		{
			Npc_RemoveInvItems(self,ItMi_Addon_Stone_04,1);
			CreateInvItems(hero,ItMi_Addon_Stone_04,1);
			AI_PrintScreen("Received: Green Stone Tablet",-1,info_ypos,FONT_ScreenSmall,3);
			info_ypos += 3;
		};
		if(Npc_HasItems(self,ItMi_Addon_Stone_05) && (Saturas_SCFound_ItMi_Addon_Stone_05 == TRUE))
		{
			Npc_RemoveInvItems(self,ItMi_Addon_Stone_05,1);
			CreateInvItems(hero,ItMi_Addon_Stone_05,1);
			AI_PrintScreen("Received: Yellow Stone Tablet",-1,info_ypos,FONT_ScreenSmall,3);
		};
	};
	AI_Output (self, other, "DIA_Addon_Saturas_RelictsBack_14_07");	//May Adanos be merciful and protect us all.
	AI_Output (self, other, "DIA_Addon_Saturas_RelictsBack_14_08");	//Perhaps it is not yet too late.
};


instance DIA_Addon_Saturas_RavensDead(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 2;
	condition = DIA_Addon_Saturas_RavensDead_Condition;
	information = DIA_Addon_Saturas_RavensDead_Info;
	important = TRUE;
};


func int DIA_Addon_Saturas_RavensDead_Condition()
{
	if(RavenIsDead == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_RavensDead_Info()
{
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_00");	//The earthquakes have stopped and, as I see, you are still among the living.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_01");	//Does this mean that your mission was successful?
	AI_Output (other, self, "DIA_Addon_Saturas_RavensDead_15_02");	//Yes. Raven is dead.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_03");	//Then it is over. Thank Adanos.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_04");	//You have done well, my son. We are deep in your debt.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_05");	//You have snatched a powerful weapon away from Evil and restored the balance in this part of the world.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_06");	//When the earthquakes died away, we discussed what should happen now and we have reached a conclusion.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_07");	//Go and take the 'Claw of Beliar'. May it be yours to bear from now on.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_08");	//In your hand, it may prove a mighty ally for us.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_09");	//Use it wisely, my son. May Adanos help you.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_11");	//We shall remain here and see to it that the temple is restored to its old brilliance.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_12");	//Only Myxir is already on his way to Khorinis to support Vatras.
	AI_Output (self, other, "DIA_Addon_Saturas_RavensDead_14_13");	//Vatras has been alone in the city for too long.
	Log_CreateTopic (TOPIC_Addon_VatrasAbloesung, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_VatrasAbloesung, LOG_Running);
	B_LogEntry (TOPIC_Addon_VatrasAbloesung, "Myxir has been sent to support Vatras in the seaport.");
	B_GivePlayerXP (XP_Addon_Saturas_RavensDead);
};


instance DIA_Addon_Saturas_FreedMissingPeople(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 2;
	condition = DIA_Addon_Saturas_FreedMissingPeople_Condition;
	information = DIA_Addon_Saturas_FreedMissingPeople_Info;
	description = "I have freed the prisoners.";
};


func int DIA_Addon_Saturas_FreedMissingPeople_Condition()
{
	if(Sklaven_Flucht == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_FreedMissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_FreedMissingPeople_15_00");	//I have freed the prisoners.
	AI_Output (self, other, "DIA_Addon_Saturas_FreedMissingPeople_14_01");	//Very good. May they return safe and sound to their homeland.
	B_GivePlayerXP (XP_Addon_Saturas_FreedMissingPeople);
};


instance DIA_Addon_Saturas_BeliarsWeapon(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_BeliarsWeapon_Condition;
	information = DIA_Addon_Saturas_BeliarsWeapon_Info;
	description = "I have taken the 'Claw of Beliar'.";
};


func int DIA_Addon_Saturas_BeliarsWeapon_Condition()
{
	if(RavenIsDead == TRUE)
	{
		if(C_ScHasBeliarsWeapon() || C_SCHasBeliarsRune())
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Saturas_BeliarsWeapon_Info()
{
	AI_UnequipWeapons (hero);
	AI_Output (other, self, "DIA_Addon_Saturas_BeliarsWeapon_15_00");	//I have taken the 'Claw of Beliar'.
	if (Npc_HasItems (hero, ItMw_BeliarWeapon_Raven) && (SC_FailedToEquipBeliarsWeapon == TRUE))
	{
		AI_Output (other, self, "DIA_Addon_Saturas_BeliarsWeapon_15_01");	//But I am unable to wear it.
	};
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_14_02");	//The 'Claw of Beliar' is a very SPECIAL weapon.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_14_03");	//It has its own will and consciousness.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_14_04");	//You, who now possess this mighty weapon, are its lord and master.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_14_05");	//It is a part of you and will adapt itself to your capabilities.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_14_06");	//However, it will not do that of its own free will.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_14_07");	//Only Beliar HIMSELF can force it to obey you.
	Info_ClearChoices (DIA_Addon_Saturas_BeliarsWeapon);
	Info_AddChoice (DIA_Addon_Saturas_BeliarsWeapon, "And why should Beliar help me?", DIA_Addon_Saturas_BeliarsWeapon_besser);
	Info_AddChoice (DIA_Addon_Saturas_BeliarsWeapon, "What can I do with the weapon?", DIA_Addon_Saturas_BeliarsWeapon_wastun);
};

func void DIA_Addon_Saturas_BeliarsWeapon_wastun()
{
	AI_Output (other, self, "DIA_Addon_Saturas_BeliarsWeapon_wastun_15_00");	//What can I do with the weapon?
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_wastun_14_01");	//That lies in your hands. You have conquered the weapon and are now its master.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_wastun_14_02");	//I can only recommend to you what you can do with it.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_wastun_14_03");	//Either you give it to ME and I shall see to it that it can do no further harm...
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_wastun_14_04");	//...or you put its power to use and wield it in battle.
	Info_AddChoice (DIA_Addon_Saturas_BeliarsWeapon, "Couldn't you keep the weapon safe?", DIA_Addon_Saturas_BeliarsWeapon_geben);
};

func void DIA_Addon_Saturas_BeliarsWeapon_geben()
{
	AI_Output (other, self, "DIA_Addon_Saturas_BeliarsWeapon_geben_15_00");	//Couldn't you keep the weapon safe?
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_geben_14_03");	//If you give it to me, then I shall render it harmless, so that it can no longer be misused.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_geben_14_04");	//So consider well what you will do.
	Log_CreateTopic (TOPIC_Addon_Klaue, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Klaue, LOG_Running);
	B_LogEntry (TOPIC_Addon_Klaue, "I can give the Claw of Beliar to Saturas, or keep it for myself.");
};

func void DIA_Addon_Saturas_BeliarsWeapon_besser()
{
	AI_Output (other, self, "DIA_Addon_Saturas_BeliarsWeapon_besser_15_00");	//And why should Beliar help me?
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_besser_14_01");	//Only a prayer to Beliar can achieve that.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_besser_14_02");	//But be careful. Beliar is malicious.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarsWeapon_besser_14_03");	//If you arouse his wrath, then he will let you feel it.
	Log_CreateTopic(TOPIC_Addon_Klaue,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_Klaue,LOG_Running);
	B_LogEntry(TOPIC_Addon_Klaue,"In order to subjugate the Claw to my will, I must pray to Beliar.");
	B_Say(other,self,"$VERSTEHE");
};


instance DIA_Addon_Saturas_PermENDE_ADDON(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_PermENDE_ADDON_Condition;
	information = DIA_Addon_Saturas_PermENDE_ADDON_Info;
	permanent = TRUE;
	description = "What will you do now?";
};


func int DIA_Addon_Saturas_PermENDE_ADDON_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Saturas_RavensDead))
	{
		return TRUE;
	};
};


var int DIA_Addon_Saturas_PermENDE_ADDON_OneTime;

func void DIA_Addon_Saturas_PermENDE_ADDON_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_PermENDE_ADDON_15_00");	//What will you do now?
	AI_Output (self, other, "DIA_Addon_Saturas_PermENDE_ADDON_14_01");	//We shall stay here and help the temple regain its former glory.
	AI_Output (self, other, "DIA_Addon_Saturas_PermENDE_ADDON_14_02");	//All too long have its walls been in this lamentable condition.
	if (DIA_Addon_Saturas_PermENDE_ADDON_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Saturas_PermENDE_ADDON_14_03");	//As far as you are concerned, my son...
		AI_Output (self, other, "DIA_Addon_Saturas_PermENDE_ADDON_14_04");	//I am glad to see that I was not mistaken about you. You are the Preserver of the Balance. There is no longer any doubt about that.
		AI_Output (self, other, "DIA_Addon_Saturas_PermENDE_ADDON_14_05");	//Without your courage and strength, the island of Khorinis would have drowned. We thank you and will honor you in our thoughts.
		AI_Output (self, other, "DIA_Addon_Saturas_PermENDE_ADDON_14_06");	//Devote yourself now to the other tasks that lie before you and return this world to balance and peace.
		AI_Output (self, other, "DIA_Addon_Saturas_PermENDE_ADDON_14_07");	//No go and fulfill your destiny, Preserver. Our prayers will go with you.
		DIA_Addon_Saturas_PermENDE_ADDON_OneTime = TRUE;
	};
};


instance DIA_Addon_Saturas_BeliarWeapGeben(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 5;
	condition = DIA_Addon_Saturas_BeliarWeapGeben_Condition;
	information = DIA_Addon_Saturas_BeliarWeapGeben_Info;
	description = "Take the 'Claw of Beliar' and destroy it.";
};


func int DIA_Addon_Saturas_BeliarWeapGeben_Condition()
{
	if((RavenIsDead == TRUE) && Npc_KnowsInfo(other,DIA_Addon_Saturas_BeliarsWeapon))
	{
		if(C_ScHasBeliarsWeapon() || C_SCHasBeliarsRune())
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Saturas_BeliarWeapGeben_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_BeliarWeapGeben_15_00");	//Take the 'Claw of Beliar' and destroy it.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarWeapGeben_14_01");	//As you wish, my son. Give it to me.
	B_ClearBeliarsWeapon();
	AI_PrintScreen("Given: Claw of Beliar",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarWeapGeben_14_02");	//So that it can do no more harm, I shall sink it in the depths of the sea.
	AI_Output (self, other, "DIA_Addon_Saturas_BeliarWeapGeben_14_03");	//Adanos' wisdom will watch over it.
	TOPIC_END_Klaue = TRUE;
	B_GivePlayerXP(XP_Addon_BeliarsWeaponAbgegeben);
	Saturas_KlaueInsMeer = TRUE;
};


func void B_Saturas_ADW_CantTeach5Circle()
{
		AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_10");	//That is no longer my task now.
		AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_11");	//In order to learn the sixth and final Circle of Magic, you had best go to the monastery of the Fire Magicians.
};

instance DIA_Addon_Saturas_ADW_PreTeachCircle(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 10;
	condition = DIA_Addon_Saturas_ADW_PreTeachCircle_Condition;
	information = DIA_Addon_Saturas_ADW_PreTeachCircle_Info;
	description = "Can you teach me the Circles of Magic?";
};


func int DIA_Addon_Saturas_ADW_PreTeachCircle_Condition()
{
//	if((hero.guild == GIL_KDF) && (Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) >= 1))
	if((hero.guild == GIL_KDF) && (Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) < 6))
	{
		return TRUE;
	};
};

func void DIA_Addon_Saturas_ADW_PreTeachCircle_Info()
{
	AI_Output(other,self,"DIA_Addon_Saturas_ADW_PreTeachCircle_15_00");	//Can you teach me the Circles of Magic?
	if(Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) == 5)
	{
		B_Saturas_ADW_CantTeach5Circle();
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Saturas_ADW_PreTeachCircle_14_01");	//You are a Magician of Fire. What would Pyrokar say abot that?
		AI_Output(other,self,"DIA_Addon_Saturas_ADW_PreTeachCircle_15_02");	//No one needs to know.
		AI_Output(self,other,"DIA_Addon_Saturas_ADW_PreTeachCircle_14_03");	//(sighs) I see that you are serious, so I shall comply with your request.
		if(RavenIsDead == FALSE)
		{
			AI_Output(self,other,"DIA_Addon_Saturas_ADW_PreTeachCircle_14_04");	//However, should I get the impression that our knowledge is in the wrong hands, you will no longer be able to count on my help.
			AI_Output(self,other,"DIA_Addon_Saturas_ADW_PreTeachCircle_14_05");	//So you had better not disappoint me.
		};
		Saturas_Addon_TeachCircle = TRUE;
		Log_CreateTopic(TOPIC_Addon_KDWTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_Addon_KDWTeacher,LogText_Addon_SaturasTeach);
	};
};


instance DIA_Addon_Saturas_ADW_CIRCLE(C_Info)
{
	npc = KDW_14000_Addon_Saturas_ADW;
	nr = 99;
	condition = DIA_Addon_Saturas_ADW_CIRCLE_Condition;
	information = DIA_Addon_Saturas_ADW_CIRCLE_Info;
	permanent = TRUE;
	description = "I want to learn a higher level of magic.";
};


var int DIA_Addon_Saturas_ADW_CIRCLE_NoPerm;

func int DIA_Addon_Saturas_ADW_CIRCLE_Condition()
{
	var int circle;
	var int kosten;
	circle = Npc_GetTalentSkill(other,NPC_TALENT_MAGE) + 1;
	kosten = B_GetLearnCostTalent(other,NPC_TALENT_MAGE,circle);
//	if((Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) >= 1) && (Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) < 6) && (Saturas_Addon_TeachCircle == TRUE) && (DIA_Addon_Saturas_ADW_CIRCLE_NoPerm == FALSE))
	if((Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) < 6) && (Saturas_Addon_TeachCircle == TRUE) && (DIA_Addon_Saturas_ADW_CIRCLE_NoPerm == FALSE))
	{
//		DIA_Addon_Saturas_ADW_CIRCLE.description = B_BuildLearnString("Я хочу перейти на следующий уровень магии",kosten);
		DIA_Addon_Saturas_ADW_CIRCLE.description = B_BuildLearnString("Next Circle of Magic",kosten);
		return TRUE;
	};
};

func void DIA_Addon_Saturas_ADW_CIRCLE_Info()
{
	AI_Output (other, self, "DIA_Addon_Saturas_ADW_CIRCLE_15_00");	//I want to learn a higher level of magic.
	if ((Npc_GetTalentSkill (hero, NPC_TALENT_MAGE) == 1) && (Kapitel >= 2))
	{
		if(B_TeachMagicCircle(self,other,2))
		{
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_01");	//Yes, you are ready to increase your knowledge.
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_02");	//Enter now the second Circle of Magic. May Adanos give you the strength to use the power now granted to you wisely.
		};
	}
	else if((Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) == 2) && (Kapitel >= 3))
	{
		if(B_TeachMagicCircle(self,other,3))
		{
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_03");	//Yes, the time is right. Enter now the third Circle of Magic.
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_04");	//Your knowledge will now allow you to effect new, more powerful magic. Use it with care.
		};
	}
	else if((Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) == 3) && (MIS_ReadyforChapter4 == TRUE))
	{
		if(B_TeachMagicCircle(self,other,4))
		{
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_05");	//The time has come. You are ready to enter the fourth Circle of Magic.
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_06");	//Mighty now are your words and deeds. Always choose your new spells with care and reason.
		};
	}
	else if((Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) == 4) && (Kapitel >= 5))
	{
		if(B_TeachMagicCircle(self,other,5))
		{
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_07");	//You will now be granted the privilege of entering the fifth Circle of Magic
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_08");	//The spells which you will now learn can be truly devastating.
			AI_Output (self, other, "DIA_Addon_Saturas_ADW_CIRCLE_14_09");	//So be aware of your power and do not succumb to delusions of grandeur.
		};
	}
	else if(Npc_GetTalentSkill(hero,NPC_TALENT_MAGE) == 5)
	{
		B_Saturas_ADW_CantTeach5Circle();
		DIA_Addon_Saturas_ADW_CIRCLE_NoPerm = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Saturas_ADW_CIRCLE_14_12");	//It is still too soon for you. Come back later.
		if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 0)
		{
			PrintScreen(PRINT_MAGCIRCLES_NEEDFIRST,-1,-1,FONT_ScreenSmall,2);
		};
	};
};

