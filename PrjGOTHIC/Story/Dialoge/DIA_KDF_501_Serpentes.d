
instance DIA_Serpentes_Kap1_EXIT(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 999;
	condition = DIA_Serpentes_Kap1_EXIT_Condition;
	information = DIA_Serpentes_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Serpentes_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Serpentes_Kap1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Serpentes_NOTALK(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 10;
	condition = DIA_Serpentes_NOTALK_Condition;
	information = DIA_Serpentes_NOTALK_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Serpentes_NOTALK_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (KNOWS_FIRE_CONTEST == FALSE) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_NOTALK_Info()
{
	AI_Output(self,other,"DIA_Serpentes_NOTALK_10_00");	//(scolding) You dare to address me, novice? Return to your work.
	Info_ClearChoices(DIA_Serpentes_NOTALK);
	Info_AddChoice(DIA_Serpentes_NOTALK,Dialog_Ende_v1,DIA_Serpentes_NOTALK_EXIT);
	Info_AddChoice(DIA_Serpentes_NOTALK,"I've got one more question...",DIA_Serpentes_NOTALK_QUESTION);
};

func void DIA_Serpentes_NOTALK_QUESTION()
{
	AI_Output (other, self, "DIA_Serpentes_NOTALK_QUESTION_15_00");	//I've got one more question...
	AI_Output (self, other, "DIA_Serpentes_NOTALK_QUESTION_10_01");	//(furiously) You do not seem to want to understand. I decide when I see fit to talk to you. Who do you think you are?
	AI_Output (self, other, "DIA_Serpentes_NOTALK_QUESTION_10_02");	//And now get back to work!
	AI_StopProcessInfos (self);
};

func void DIA_Serpentes_NOTALK_EXIT()
{
	DIA_Common_IHaveToGo_v1();
	AI_StopProcessInfos(self);
};


instance DIA_Serpentes_GOAWAY(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 10;
	condition = DIA_Serpentes_GOAWAY_Condition;
	information = DIA_Serpentes_GOAWAY_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Serpentes_GOAWAY_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Serpentes_NOTALK) && Npc_IsInState(self,ZS_Talk) && !Npc_KnowsInfo(hero,DIA_Pyrokar_FIRE) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_GOAWAY_Info()
{
	AI_Output (self, other, "DIA_Serpentes_GOAWAY_10_00");	//Your presence here demonstrates not only your lack of respect, but also your stupidity, novice!
	AI_StopProcessInfos (self);
};


instance DIA_Serpentes_YOURSTORY(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 24;
	condition = DIA_Serpentes_YOURSTORY_Condition;
	information = DIA_Serpentes_YOURSTORY_Info;
	permanent = FALSE;
	description = "I heard that you passed the Test of Fire.";
};


func int DIA_Serpentes_YOURSTORY_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulthar_TEST) && (other.guild == GIL_NOV) && !Npc_KnowsInfo(hero,DIA_Pyrokar_MAGICAN) && (MIS_Golem != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_YOURSTORY_Info()
{
	AI_Output (other, self, "DIA_Serpentes_YOURSTORY_15_00");	//I heard that you passed the Test of Fire.
	AI_Output (self, other, "DIA_Serpentes_YOURSTORY_10_01");	//(smugly) In all humility, I can tell you this. Everyone else who has attempted this is dead.
	AI_Output (self, other, "DIA_Serpentes_YOURSTORY_10_02");	//(condescendingly) You really should not attempt to take this test. Your spirit is weak. Better to serve in the monastery and perhaps you will be chosen in a few years.
	AI_Output (other, self, "DIA_Serpentes_YOURSTORY_15_03");	//I am going to pass the test.
	AI_Output (self, other, "DIA_Serpentes_YOURSTORY_10_04");	//If it is the will of Innos, then you shall. But if not - then you will fail.
};


instance DIA_Serpentes_TEST(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 10;
	condition = DIA_Serpentes_TEST_Condition;
	information = DIA_Serpentes_TEST_Info;
	permanent = FALSE;
	description = "I am ready to face your test, Master.";
};


func int DIA_Serpentes_TEST_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Pyrokar_FIRE) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_TEST_Info()
{
	AI_Output (other, self, "DIA_Serpentes_TEST_15_00");	//I am ready to face your test, Master.
	AI_Output (self, other, "DIA_Serpentes_TEST_10_01");	//So, you want to put yourself to the test. Only a courageous novice demands the test. But courage is not all that you need.
	AI_Output (self, other, "DIA_Serpentes_TEST_10_02");	//Are you clever enough to pass the test? Are you strong enough to meet the dangers that await you?
	AI_Output (self, other, "DIA_Serpentes_TEST_10_03");	//If not, you will pay for it with your life.
	AI_Output (self, other, "DIA_Serpentes_TEST_10_04");	//And now hear your test: In the Place of Stones, seek the one who was never born - find him who once was summoned.
	AI_Output (self, other, "DIA_Serpentes_TEST_10_05");	//Overcome the one who cannot be overcome - measure yourself against the living rock, fight with the undying stone - and destroy it.
	Wld_InsertNpc(MagicGolem,"FP_MAGICGOLEM");
	B_InitNpcGlobals();
	MIS_Golem = LOG_Running;
	Log_CreateTopic (TOPIC_Golem, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Golem, LOG_Running);
	B_LogEntry (TOPIC_Golem, "Serpentes has put me to the test. He wants me to 'find him who once was summoned', the living rock, and defeat it.");
};


instance DIA_Serpentes_NOIDEA(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 10;
	condition = DIA_Serpentes_NOIDEA_Condition;
	information = DIA_Serpentes_NOIDEA_Info;
	permanent = FALSE;
	description = "What kind of a creature would that be?";
};


func int DIA_Serpentes_NOIDEA_Condition()
{
	if((MIS_Golem == LOG_Running) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_NOIDEA_Info()
{
	AI_Output (other, self, "DIA_Serpentes_NOIDEA_15_00");	//Living rock ... ? What kind of a creature would that be?
	AI_Output (self, other, "DIA_Serpentes_NOIDEA_10_01");	//I have told you everything. (mockingly) Or do you find this test too difficult?
	AI_Output (self, other, "DIA_Serpentes_NOIDEA_10_02");	//Now you will learn what it means to take the Test of Fire - I will answer no more of your questions.
	AI_StopProcessInfos (self);
};


instance DIA_Serpentes_NOHELP(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 10;
	condition = DIA_Serpentes_NOHELP_Condition;
	information = DIA_Serpentes_NOHELP_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Serpentes_NOHELP_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Serpentes_NOIDEA) && !Npc_IsDead(Magic_Golem) && (MIS_Golem == LOG_Running) && Npc_IsInState(self,ZS_Talk) && (other.guild == GIL_NOV) && (!Npc_KnowsInfo(other,DIA_Ulthar_TEST) || Npc_KnowsInfo(other,DIA_Serpentes_YOURSTORY)))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_NOHELP_Info()
{
	AI_Output (self, other, "DIA_Serpentes_NOHELP_10_00");	//(contemptibly) Go and carry out your task, novice!
	AI_StopProcessInfos (self);
};


instance DIA_Serpentes_SUCCESS(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 3;
	condition = DIA_Serpentes_SUCCESS_Condition;
	information = DIA_Serpentes_SUCCESS_Info;
	permanent = FALSE;
	description = "I have defeated the golem.";
};


func int DIA_Serpentes_SUCCESS_Condition()
{
	if(Npc_IsDead(Magic_Golem) && (MIS_Golem == LOG_Running) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_SUCCESS_Info()
{
	AI_Output (other, self, "DIA_Serpentes_SUCCESS_15_00");	//I have defeated the golem.
	AI_Output (self, other, "DIA_Serpentes_SUCCESS_10_01");	//What? You have actually done it? But without the hammer of Innos, you would never have been able to destroy the golem.
	if(Npc_IsDead(Garwig))
	{
		AI_Output (self, other, "DIA_Serpentes_SUCCESS_10_02");	//(triumphantly) But now you have betrayed yourself! It was you who killed Garwig!
		AI_Output (self, other, "DIA_Serpentes_SUCCESS_10_03");	//RECEIVE THE PUNISHMENT FOR THE MURDER OF A SERVANT OF INNOS!!!
		AI_StopProcessInfos (self);
		B_Attack (self, other, AR_HumanMurderedHuman, 0);
	}
	else
	{
		AI_Output (self, other, "DIA_Serpentes_SUCCESS_10_04");	//(regretfully) Nevertheless, I must admit that you have fulfilled the task I have given you.
	};
	if(Npc_HasItems(other,Holy_Hammer_MIS))
	{
		AI_Output(self,other,"DIA_Serpentes_SUCCESS_10_05");	//And I had best take the hammer myself.
		Npc_RemoveInvItems(other,Holy_Hammer_MIS,1);
		AI_PrintScreen("Given: Holy Hammer",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
		Wld_InsertItem(Holy_Hammer_MIS,"FP_HAMMER");
		GarwigThiefOneTime = FALSE;
	};
	MIS_Golem = LOG_SUCCESS;
	B_GivePlayerXP(XP_GOLEM);
};


instance DIA_Serpentes_PERM(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 99;
	condition = DIA_Serpentes_PERM_Condition;
	information = DIA_Serpentes_PERM_Info;
	permanent = TRUE;
	description = "Is there anything else you want to tell me?";
};


func int DIA_Serpentes_PERM_Condition()
{
	if((Kapitel >= 3) || Npc_KnowsInfo(other,DIA_Serpentes_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_PERM_Info()
{
	AI_Output (other, self, "DIA_Serpentes_PERM_15_00");	//Is there anything else you want to tell me?
	if (hero.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_Serpentes_PERM_10_01");	//No. Not at the moment, Brother.
	}
	else
	{
		AI_Output (self, other, "DIA_Serpentes_PERM_10_02");	//Dismissed. You know what you have to do.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Serpentes_MinenAnteile(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 30;
	condition = DIA_Serpentes_MinenAnteile_Condition;
	information = DIA_Serpentes_MinenAnteile_Info;
	important = TRUE;
};


func int DIA_Serpentes_MinenAnteile_Condition()
{
//	if((Pedro_Traitor == TRUE) && ((hero.guild == GIL_KDF) || (hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)) && (Kapitel >= 3))
	if((Pedro_Traitor == TRUE) && (Kapitel >= 3))
	{
		if(hero.guild == GIL_KDF)
		{
			if(!Npc_IsDead(Salandril) || !Npc_IsDead(Matteo) || !Npc_IsDead(Bosper) || !Npc_IsDead(Zuris) || !Npc_IsDead(Elena) || !Npc_IsDead(Orlan) || !Npc_IsDead(Hakon) || !Npc_IsDead(Rosi) || !Npc_IsDead(Canthar))
			{
				return TRUE;
			};
		}
		else if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
		{
			if(!Npc_IsDead(Salandril))
			{
				return TRUE;
			};
		};
	};
};

func void DIA_Serpentes_MinenAnteile_Info()
{
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_10_00");	//Not so fast. I have another task for you.
	if (hero.guild == GIL_KDF)
	{
		AI_Output (other, self, "DIA_Serpentes_MinenAnteile_15_01");	//(sighs) And that is?
		AI_Output (self, other, "DIA_Serpentes_MinenAnteile_10_02");	//Now that you belong to the Brotherhood of Fire, you must also fulfill the duties that come with being one of us.
		AI_Output (self, other, "DIA_Serpentes_MinenAnteile_10_03");	//The church is not only concerned with the affairs of magic - it is also the final authority in the administration of justice, as you know.
		AI_Output (self, other, "DIA_Serpentes_MinenAnteile_10_04");	//The latest case brought before opens up a bottomless abyss and must be dealt with once and for all.
		Info_ClearChoices (DIA_Serpentes_MinenAnteile);
		Info_AddChoice (DIA_Serpentes_MinenAnteile, "I've got enough on my plate as it is. Go find somebody else.", DIA_Serpentes_MinenAnteile_nein);
		Info_AddChoice (DIA_Serpentes_MinenAnteile, "What's this about?", DIA_Serpentes_MinenAnteile_was);
		Info_AddChoice (DIA_Serpentes_MinenAnteile, "Isn't that the militia's business?", DIA_Serpentes_MinenAnteile_miliz);
	}
	else
	{
		AI_Output (self, other, "DIA_Serpentes_MinenAnteile_10_05");	//A mercenary for hire of your stripe could be of use to us in this matter.
		Info_ClearChoices (DIA_Serpentes_MinenAnteile);
		Info_AddChoice (DIA_Serpentes_MinenAnteile, "I've got enough on my plate as it is. Go find somebody else.", DIA_Serpentes_MinenAnteile_nein);
		Info_AddChoice (DIA_Serpentes_MinenAnteile, "Whom should I kill?", DIA_Serpentes_MinenAnteile_KillSLD);
	};
};

func void DIA_Serpentes_MinenAnteile_miliz()
{
	AI_Output (other, self, "DIA_Serpentes_MinenAnteile_miliz_15_00");	//Isn't that the militia's business?
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_miliz_10_01");	//The militia is responsible for the city alone. This affair has farther-reaching consequences.
};

func void DIA_Serpentes_MinenAnteile_nein()
{
	AI_Output (other, self, "DIA_Serpentes_MinenAnteile_nein_15_00");	//I've got enough on my plate as it is. Go find somebody else.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_nein_10_01");	//(angrily) That is outrageous. You will never reach the upper circles of magic if you are not willing to do the Brotherhood a service.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_nein_10_02");	//I hereby reprimand you. I hope this will not happen again - else it will go badly with you.
	AI_StopProcessInfos(self);
};

func void DIA_Serpentes_MinenAnteile_nein_sld()
{
	AI_Output(other,self,"DIA_Vatras_Mission_No_15_00");	//Go find yourself another errand boy, old man.
	B_Say(self,other,"$YESGOOUTOFHERE");
	AI_StopProcessInfos(self);
};

func void DIA_Serpentes_MinenAnteile_was()
{
	AI_Output (other, self, "DIA_Serpentes_MinenAnteile_was_15_00");	//What's this about?
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_10_01");	//There is someone in the city who has sold falsified shares in the ore mines of the former penal colony.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_10_02");	//These papers are utterly worthless and of no importance, really. Still, they have the potential of stirring up trouble among the people, which we cannot afford to happen right now.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_10_03");	//The swindler is supposed to have approached all the most reputable traders in the city and the country, and has evidently even managed to sell his counterfeit mining shares to some of them.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_10_04");	//Find this evildoer and bring him before this panel. In such hard times we must not suffer swindlers and plunderers.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_10_05");	//We must make an example of him in order to deter the rest of the mob.
	Info_AddChoice (DIA_Serpentes_MinenAnteile, "I shall try to clear up the matter.", DIA_Serpentes_MinenAnteile_was_ja);
};

func void DIA_Serpentes_MinenAnteile_was_ja()
{
	AI_Output (other, self, "DIA_Serpentes_MinenAnteile_was_ja_15_00");	//I shall try to clear up the matter.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_ja_10_01");	//One thing more. When you visit those traders, do not let them know that you are looking for mining shares.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_ja_10_02");	//I think they probably want to sell them on and certainly would no longer offer them to you if they realized that you are dealing with them on behalf of the church, you see?
	AI_Output (other, self, "DIA_Serpentes_MinenAnteile_was_ja_15_03");	//Yes.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_ja_10_04");	//Then get to work. I wish you much success, Brother.
	Info_ClearChoices (DIA_Serpentes_MinenAnteile);
	MIS_Serpentes_MinenAnteil_KDF = LOG_Running;
	if(!Npc_IsDead(Salandril))
	{
		CreateInvItems(Salandril,ItWr_MinenAnteil_Mis,2);
		SalandrilMinenAnteil_MAINCounter += 2;
	};
	if(!Npc_IsDead(Matteo))
	{
		CreateInvItems(Matteo,ItWr_MinenAnteil_Mis,1);
		SalandrilMinenAnteil_MAINCounter += 1;
	};
	if(!Npc_IsDead(Bosper))
	{
		CreateInvItems(Bosper,ItWr_MinenAnteil_Mis,1);
		SalandrilMinenAnteil_MAINCounter += 1;
	};
	if(!Npc_IsDead(Zuris))
	{
		CreateInvItems(Zuris,ItWr_MinenAnteil_Mis,1);
		SalandrilMinenAnteil_MAINCounter += 1;
	};
	if(!Npc_IsDead(Elena))
	{
		CreateInvItems(Elena,ItWr_MinenAnteil_Mis,2);
		SalandrilMinenAnteil_MAINCounter += 2;
	};
	if(!Npc_IsDead(Orlan))
	{
		CreateInvItems(Orlan,ItWr_MinenAnteil_Mis,1);
		SalandrilMinenAnteil_MAINCounter += 1;
	};
	if(!Npc_IsDead(Hakon))
	{
		CreateInvItems(Hakon,ItWr_MinenAnteil_Mis,1);
		SalandrilMinenAnteil_MAINCounter += 1;
	};
	if(!Npc_IsDead(Rosi))
	{
		CreateInvItems(Rosi,ItWr_MinenAnteil_Mis,1);
		SalandrilMinenAnteil_MAINCounter += 1;
	};
	if(!Npc_IsDead(Canthar))
	{
		CreateInvItems(Canthar,ItWr_MinenAnteil_Mis,3);
		SalandrilMinenAnteil_MAINCounter += 3;
	};
	Log_CreateTopic(TOPIC_MinenAnteileKDF,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_MinenAnteileKDF,LOG_Running);
	B_LogEntry(TOPIC_MinenAnteileKDF,"Someone's selling illegal ore mine shares and enriching himself that way. I must find out who's been selling them to the merchants round here. Serpentes wants all those forged papers.");
};

func void DIA_Serpentes_MinenAnteile_KillSLD()
{
	AI_Output (other, self, "DIA_Serpentes_MinenAnteile_Kill_15_00");	//Whom should I kill?
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_Kill_10_01");	//For Innos' sake. No one, of course. This business demands a bit more finesse, you rude lout.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_Kill_10_02");	//Salandril, the alchemist from the upper end of town, is guilty of a serious crime and must be punished for it.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_Kill_10_03");	//However, he has refused to come to the monastery to be judged. Bring him here.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_Kill_10_04");	//How you accomplish this does not matter to us. You will, of course, be rewarded.
	Info_AddChoice (DIA_Serpentes_MinenAnteile, "Isn't that the militia's business?", DIA_Serpentes_MinenAnteile_miliz);
	Info_AddChoice (DIA_Serpentes_MinenAnteile, "No problem. I'll take care of it.", DIA_Serpentes_MinenAnteile_was_jaSLD);
};


var int MIS_Serpentes_BringSalandril_SLD;

func void DIA_Serpentes_MinenAnteile_was_jaSLD()
{
	AI_Output (other, self, "DIA_Serpentes_MinenAnteile_was_jaSLD_15_00");	//No problem. I'll take care of it.
	AI_Output (self, other, "DIA_Serpentes_MinenAnteile_was_jaSLD_10_01");	//Good. We expect to hear from you in a few days.
	MIS_Serpentes_BringSalandril_SLD = LOG_Running;
	Info_ClearChoices(DIA_Serpentes_MinenAnteile);
	Log_CreateTopic(TOPIC_MinenAnteileSLD,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_MinenAnteileSLD,LOG_Running);
	B_LogEntry(TOPIC_MinenAnteileSLD,"I'm to take Salandril, an alchemist from the upper quarter of Khorinis, to the monastery to be judged. I don't really care what he's supposed to have done, as long as I get paid.");
};


var int SerpentesMinenAnteilCounter;
var int AllMinenAnteilFound;

instance DIA_Serpentes_MinenAnteileBringen(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 2;
	condition = DIA_Serpentes_MinenAnteileBringen_Condition;
	information = DIA_Serpentes_MinenAnteileBringen_Info;
	permanent = TRUE;
	description = "About the forged mine shares...";
};


func int DIA_Serpentes_MinenAnteileBringen_Condition()
{
	if((MIS_Serpentes_MinenAnteil_KDF == LOG_Running) && Npc_HasItems(other,ItWr_MinenAnteil_Mis) && (hero.guild == GIL_KDF))
	{
		if(Npc_HasItems(other,ItWr_MinenAnteil_Mis) > 1)
		{
			DIA_Serpentes_MinenAnteileBringen.description = "I've been able to retrieve a mining share.";
		}
		else
		{
			DIA_Serpentes_MinenAnteileBringen.description = "I've been able to retrieve a mining share.";
		};
		return TRUE;
	};
};

func void DIA_Serpentes_MinenAnteileBringen_Info()
{
	var int SerpentesMinenAnteilCount;
	var int SerpentesMinenAnteilGeld;
	var int MinenAnteilLeft;
	SerpentesMinenAnteilCount = Npc_HasItems(other,ItWr_MinenAnteil_Mis);
	if(SerpentesMinenAnteilCount == 1)
	{
		AI_Output(other,self,"DIA_Serpentes_MinenAnteileBringen_15_00");	//I've been able to retrieve a mining share.
	}
	else
	{
		AI_Output(other,self,"DIA_Serpentes_MinenAnteileBringen_15_01");	//I've been able to retrieve a mining share.
	};
	B_GiveInvItems(other,self,ItWr_MinenAnteil_Mis,SerpentesMinenAnteilCount);
	Npc_RemoveInvItems(self,ItWr_MinenAnteil_Mis,SerpentesMinenAnteilCount);
	B_GivePlayerXP(SerpentesMinenAnteilCount * XP_BringSerpentesMinenAnteil);
	SerpentesMinenAnteilCounter += SerpentesMinenAnteilCount;
	MinenAnteilLeft = SalandrilMinenAnteil_MAINCounter - SerpentesMinenAnteilCounter;
	if(MinenAnteilLeft > 0)
	{
		AI_PrintScreen(ConcatStrings(PRINT_MinenAnteilLeft,IntToString(MinenAnteilLeft)),-1,YPOS_ItemTaken,FONT_ScreenSmall,3);
		AI_Output(self,other,"DIA_Serpentes_MinenAnteileBringen_10_02");	//Very good. You must remove them all from circulation. This is poison for the people. Bring them all to me.
		AI_Output(self,other,"DIA_Serpentes_MinenAnteileBringen_10_03");	//Here. I will give you the necessary means.
	}
	else if(AllMinenAnteilFound == FALSE)
	{
		AI_PrintScreen(PRINT_AllMinenAnteil,-1,YPOS_ItemTaken,FONT_ScreenSmall,3);
		AI_Output(other,self,"DIA_Serpentes_MinenAnteileBringen_15_04");	//Those were all, I think.
		if(SerpentesMinenAnteilCount == 1)
		{
			AI_Output(self,other,"DIA_Serpentes_MinenAnteileBringen_10_07");	//This is really the last one now, right?
		};
		AI_Output(self,other,"DIA_Serpentes_MinenAnteileBringen_10_05");	//Well done. You have earned a reward.
		AI_Output(self,other,"DIA_Serpentes_MinenAnteileBringen_10_06");	//Take this protective amulet. It will help you along the paths you have yet to tread.
		CreateInvItems(self,ItAm_Prot_Mage_01,1);
		B_GiveInvItems(self,other,ItAm_Prot_Mage_01,1);
		AllMinenAnteilFound = TRUE;
	}
	else
	{
		B_Say(self,other,"$NOTBAD");
	};
	SerpentesMinenAnteilGeld = SerpentesMinenAnteilCount * SerpentesMinenAnteilOffer;
	CreateInvItems(self,ItMi_Gold,SerpentesMinenAnteilGeld);
	B_GiveInvItems(self,other,ItMi_Gold,SerpentesMinenAnteilGeld);
};


instance DIA_Serpentes_GOTSalandril(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 32;
	condition = DIA_Serpentes_GOTSalandril_Condition;
	information = DIA_Serpentes_GOTSalandril_Info;
	description = "I know who brought those mining shares into circulation.";
};


func int DIA_Serpentes_GOTSalandril_Condition()
{
	if((SC_KnowsProspektorSalandril == TRUE) && (hero.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_GOTSalandril_Info()
{
	AI_Output (other, self, "DIA_Serpentes_GOTSalandril_15_00");	//I know who brought those mining shares into circulation. Salandril did, the alchemist from the upper quarter of town.
	AI_Output (self, other, "DIA_Serpentes_GOTSalandril_10_01");	//Then bring him here. We have things to discuss with him.
	B_GivePlayerXP (XP_Ambient);
};


instance DIA_Serpentes_SalandrilHERE(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 33;
	condition = DIA_Serpentes_SalandrilHERE_Condition;
	information = DIA_Serpentes_SalandrilHERE_Info;
	description = "Salandril is here, in the monastery.";
};


func int DIA_Serpentes_SalandrilHERE_Condition()
{
	if((Npc_GetDistToWP(Salandril,"ALTAR") < 10000) && !Npc_IsDead(Salandril))
	{
		if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
		{
			return TRUE;
		}
		else if(Npc_KnowsInfo(other,DIA_Serpentes_GOTSalandril) && (hero.guild == GIL_KDF))
		{
			return TRUE;
		};
	};
};

func void DIA_Serpentes_SalandrilHERE_Info()
{
	AI_Output (other, self, "DIA_Serpentes_SalandrilHERE_15_00");	//Salandril is here, in the monastery.
	AI_Output (self, other, "DIA_Serpentes_SalandrilHERE_10_01");	//Well done. We shall deal with him later.
	if ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Serpentes_SalandrilHERE_10_02");	//Here is your reward. And not another word about this, understood?
		CreateInvItems (self, ItMi_Gold, 400);
		B_GiveInvItems (self, other, ItMi_Gold, 400);
	};
	TOPIC_END_MinenAnteile = TRUE;
	B_GivePlayerXP(XP_SalandrilInKloster);
};


instance DIA_Serpentes_SalandrilDEAD(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 33;
	condition = DIA_Serpentes_SalandrilDEAD_Condition;
	information = DIA_Serpentes_SalandrilDEAD_Info;
	description = "Salandril is dead.";
};


func int DIA_Serpentes_SalandrilDEAD_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Serpentes_GOTSalandril) || (((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)) && (MIS_Serpentes_BringSalandril_SLD == LOG_Running))) && Npc_IsDead(Salandril))
	{
		return TRUE;
	};
};

func void DIA_Serpentes_SalandrilDEAD_Info()
{
	AI_Output (other, self, "DIA_Serpentes_SalandrilDEAD_15_00");	//Salandril is dead.
	AI_Output (self, other, "DIA_Serpentes_SalandrilDEAD_10_01");	//Well, then his deed has not gone unpunished. May Innos have mercy on his poor soul.
	TOPIC_END_MinenAnteile = TRUE;
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Serpentes_PICKPOCKET(C_Info)
{
	npc = KDF_501_Serpentes;
	nr = 900;
	condition = DIA_Serpentes_PICKPOCKET_Condition;
	information = DIA_Serpentes_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Serpentes_PICKPOCKET_Condition()
{
	return C_Beklauen(86,380);
};

func void DIA_Serpentes_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Serpentes_PICKPOCKET);
	Info_AddChoice(DIA_Serpentes_PICKPOCKET,Dialog_Back,DIA_Serpentes_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Serpentes_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Serpentes_PICKPOCKET_DoIt);
};

func void DIA_Serpentes_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Serpentes_PICKPOCKET);
};

func void DIA_Serpentes_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Serpentes_PICKPOCKET);
};

