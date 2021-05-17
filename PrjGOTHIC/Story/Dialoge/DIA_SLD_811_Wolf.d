
instance DIA_Wolf_EXIT(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 999;
	condition = DIA_Wolf_EXIT_Condition;
	information = DIA_Wolf_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Wolf_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Wolf_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Wolf_Hallo(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 4;
	condition = DIA_Wolf_Hallo_Condition;
	information = DIA_Wolf_Hallo_Info;
	permanent = FALSE;
	description = "Everything all right?";
};


func int DIA_Wolf_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Wolf_Hallo_Info()
{
	AI_Output (other, self, "DIA_Wolf_Hallo_15_00");	//Doing all right?
	AI_Output (self, other, "DIA_Wolf_Hallo_08_01");	//Hey! I know you! From the colony.
	AI_Output (self, other, "DIA_Wolf_Hallo_08_02");	//What do you want here?
};


instance DIA_Wolf_WannaJoin(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 5;
	condition = DIA_Wolf_WannaJoin_Condition;
	information = DIA_Wolf_WannaJoin_Info;
	permanent = FALSE;
	description = "I've come to join you.";
};


func int DIA_Wolf_WannaJoin_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_Hallo) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Wolf_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Wolf_WannaJoin_15_00");	//I've come to join you.
	AI_Output (self, other, "DIA_Wolf_WannaJoin_08_01");	//Why not. I've got nothing against it. Anyway, you freed our mine from the guards back then.
	AI_Output (self, other, "DIA_Wolf_WannaJoin_08_02");	//But don't count on getting along with the others here so easily.
	AI_Output (self, other, "DIA_Wolf_WannaJoin_08_03");	//A lot of newbies have come along since then. And some of the old mercenaries won't remember you.
	AI_Output (self, other, "DIA_Wolf_WannaJoin_08_04");	//I almost didn't recognize you, you look rather haggard.
	AI_Output (other, self, "DIA_Wolf_WannaJoin_15_05");	//When the Barrier fell, I barely got away with my life.
	AI_Output (self, other, "DIA_Wolf_WannaJoin_08_06");	//Looks like you got lucky, then.
	if(Torlof_GenugStimmen == FALSE)
	{
		Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
	};
	B_LogEntry(TOPIC_SLDRespekt,"Wolf doesn't mind my joining the mercenaries.");
};


instance DIA_Wolf_WannaBuy(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 6;
	condition = DIA_Wolf_WannaBuy_Condition;
	information = DIA_Wolf_WannaBuy_Info;
	permanent = FALSE;
	description = "Do you have anything to sell?";
};


func int DIA_Wolf_WannaBuy_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Wolf_WannaBuy_Info()
{
	AI_Output (other, self, "DIA_Wolf_WannaBuy_15_00");	//Do you have anything to sell?
	AI_Output (self, other, "DIA_Wolf_WannaBuy_08_01");	//Oh, don't ask.
	AI_Output (self, other, "DIA_Wolf_WannaBuy_08_02");	//Bennet, one of the new guys, takes care of the weapons and armor now.
	AI_Output (self, other, "DIA_Wolf_WannaBuy_08_03");	//In the colony I was responsible for Lee's entire weapons store, and then along comes a trained smith and 'pow', I'm out of a job.
	if((MIS_BengarsHelpingSLD != LOG_SUCCESS) && (Wolf_IsOnBoard != LOG_SUCCESS))
	{
		AI_Output (self, other, "DIA_Wolf_WannaBuy_08_04");	//I desperately need a new job, even if I all I do is guard the farms out there.
		AI_Output (self, other, "DIA_Wolf_WannaBuy_08_05");	//I don't care, just as long as I'm not twiddling my thumbs here any more.
	};
};


instance DIA_Wolf_WannaLearn(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 7;
	condition = DIA_Wolf_WannaLearn_Condition;
	information = DIA_Wolf_WannaLearn_Info;
	permanent = FALSE;
	description = "Can you teach me something?";
};


func int DIA_Wolf_WannaLearn_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Wolf_WannaLearn_Info()
{
	AI_Output (other, self, "DIA_Wolf_WannaLearn_15_00");	//Can you teach me anything?
	AI_Output (self, other, "DIA_Wolf_WannaLearn_08_01");	//I can teach you a few tricks in handling a bow, if you want. I don't have anything better to do right now anyway.
	Wolf_TeachBow = TRUE;
	Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_SoldierTeacher,"Wolf can teach me to handle bows.");
};


var int Wolf_Merke_Bow;
var int Wolf_TeachComment;
var int DIA_Wolf_Teacher_permanent;

func void B_BuildLearnDialog_Wolf()
{
	if(VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Wolf)
	{
		Info_ClearChoices(DIA_Wolf_TEACH);
		Info_AddChoice(DIA_Wolf_TEACH,Dialog_Back,DIA_Wolf_Teach_Back);
		Info_AddChoice(DIA_Wolf_TEACH,B_BuildLearnString(PRINT_LearnBow1,B_GetLearnCostTalent(other,NPC_TALENT_BOW,1)),DIA_Wolf_Teach_Bow_1);
		Info_AddChoice(DIA_Wolf_TEACH,B_BuildLearnString(PRINT_LearnBow5,B_GetLearnCostTalent(other,NPC_TALENT_BOW,5)),DIA_Wolf_Teach_Bow_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_Wolf)
		{
			DIA_Wolf_Teacher_permanent = TRUE;
		};
		PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_Bow_Wolf)),-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

func void B_Wolf_YouAreBetterNow()
{
	AI_Output(self,other,"DIA_Wolf_Teach_BACK_08_00");	//Here you go. Your aim is more accurate already.
};

func void B_Wolf_TeachComment(var int skill)
{
	if(Wolf_TeachComment == 0)
	{
		AI_Output(self,other,"DIA_Wolf_DI_Training_CROSSBOW_5_08_00");	//A clever marksman makes use of the wind and tries never to shoot against it.
		Wolf_TeachComment = 1;
	}
	else if(Wolf_TeachComment == 1)
	{
		if(skill == NPC_TALENT_BOW)
		{
			AI_Output(self,other,"DIA_Wolf_DI_Training_BOW_1_08_00");	//Unlike the crossbow, the bow is very bulky and requires a lot of space. Always make sure that you have enough of that in battle.
		}
		else if(skill == NPC_TALENT_CROSSBOW)
		{
			AI_Output(self,other,"DIA_Wolf_DI_Training_CROSSBOW_1_08_00");	//Try not to jiggle when shooting the crossbow. That's why you should always press the trigger very carefully.
		};
		Wolf_TeachComment = 2;
	}
	else if(Wolf_TeachComment == 2)
	{
		if(skill == NPC_TALENT_BOW)
		{
			AI_Output(self,other,"DIA_Wolf_DI_Training_BOW_5_08_00");	//Let the string glide through your fingers when you shoot. A cramped finger will mess up the arrow's trajectory.
		}
		else if(skill == NPC_TALENT_CROSSBOW)
		{
			B_Wolf_YouAreBetterNow();
		};
		Wolf_TeachComment = 1;
	};
};

instance DIA_Wolf_TEACH(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 8;
	condition = DIA_Wolf_TEACH_Condition;
	information = DIA_Wolf_TEACH_Info;
	permanent = TRUE;
	description = "I want to learn more about archery.";
};


func int DIA_Wolf_TEACH_Condition()
{
	if((Wolf_TeachBow == TRUE) && (DIA_Wolf_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Wolf_TEACH_Info()
{
	AI_Output(other,self,"DIA_Wolf_TEACH_15_00");	//I want to learn more about archery.
	if(VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Wolf)
	{
		AI_Output(self,other,"DIA_Wolf_TEACH_08_01");	//What should I teach you?
		Wolf_Merke_Bow = other.HitChance[NPC_TALENT_BOW];
	};
	B_BuildLearnDialog_Wolf();
};

func void DIA_Wolf_Teach_Back()
{
	if(Wolf_Merke_Bow < other.HitChance[NPC_TALENT_BOW])
	{
		B_Wolf_YouAreBetterNow();
	};
	Info_ClearChoices(DIA_Wolf_TEACH);
};

func void DIA_Wolf_Teach_Bow_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,1,TeachLimit_Bow_Wolf))
	{
		B_Wolf_TeachComment(NPC_TALENT_BOW);
		B_BuildLearnDialog_Wolf();
	};
};

func void DIA_Wolf_Teach_Bow_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,5,TeachLimit_Bow_Wolf))
	{
		B_Wolf_TeachComment(NPC_TALENT_BOW);
		B_BuildLearnDialog_Wolf();
	};
};

instance DIA_Wolf_PERM(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 9;
	condition = DIA_Wolf_PERM_Condition;
	information = DIA_Wolf_PERM_Info;
	permanent = TRUE;
	description = "And? Found a new task yet?";
};


func int DIA_Wolf_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_WannaBuy) && (MIS_BengarsHelpingSLD == FALSE) && (Wolf_IsOnBoard != LOG_FAILED))
	{
		return TRUE;
	};
};

func void DIA_Wolf_PERM_Info()
{
	AI_Output (other, self, "DIA_Wolf_PERM_15_00");	//And? Found a new task yet?
	AI_Output (self, other, "DIA_Wolf_PERM_08_01");	//Not so far. Let me know if you have a job for me.
};


instance DIA_Wolf_Stadt(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 10;
	condition = DIA_Wolf_Stadt_Condition;
	information = DIA_Wolf_Stadt_Info;
	permanent = FALSE;
	description = "Have you tried finding a job in town?";
};


func int DIA_Wolf_Stadt_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_WannaBuy) && (MIS_BengarsHelpingSLD == FALSE) && (Wolf_IsOnBoard != LOG_FAILED))
	{
		return TRUE;
	};
};

func void DIA_Wolf_Stadt_Info()
{
	AI_Output (other, self, "DIA_Wolf_Stadt_15_00");	//Have you tried finding a job in town?
	AI_Output (self, other, "DIA_Wolf_Stadt_08_01");	//In the city? (laughs) Wild horses couldn't drag me there.
	AI_Output (self, other, "DIA_Wolf_Stadt_08_02");	//Or do you think I would want to work there as a militia soldier? I can just imagine myself in that courtier's uniform.
	AI_Output (self, other, "DIA_Wolf_Stadt_08_03");	//And then that obsession with obedience. Nah, forget it - there may not be anything to do here on the farm, but at least I can do what I want.
};


var int MIS_Wolf_BringCrawlerPlates;
var int Wolf_MakeArmor;
var int Player_GotCrawlerArmor;

instance DIA_Wolf_AboutCrawler(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 1;
	condition = DIA_Wolf_AboutCrawler_Condition;
	information = DIA_Wolf_AboutCrawler_Info;
	permanent = FALSE;
	description = "I heard you know how to make armor from crawler plates?";
};


func int DIA_Wolf_AboutCrawler_Condition()
{
	if((Kapitel >= 2) && (Wolf_ProduceCrawlerArmor == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Wolf_AboutCrawler_Info()
{
	AI_Output (other, self, "DIA_Wolf_AboutCrawler_15_00");	//I heard you know how to make armor from crawler plates?
	AI_Output (self, other, "DIA_Wolf_AboutCrawler_08_01");	//That's right. Who did you hear that from?
	AI_Output (other, self, "DIA_Wolf_AboutCrawler_15_02");	//A hunter by the name of Gestath told me.
	AI_Output (other, self, "DIA_Wolf_AboutCrawler_15_03");	//Could you make me armor like that?
	AI_Output (self, other, "DIA_Wolf_AboutCrawler_08_04");	//Sure. Bring me 10 crawler plates and I'll make you one.
	AI_Output (other, self, "DIA_Wolf_AboutCrawler_15_05");	//How much do you want for it?
	AI_Output (self, other, "DIA_Wolf_AboutCrawler_08_06");	//Forget it. I'll do it for nothing. For old times' sake.
	MIS_Wolf_BringCrawlerPlates = LOG_Running;
	Log_CreateTopic (TOPIC_Wolf_BringCrawlerPlates, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Wolf_BringCrawlerPlates, LOG_Running);
	B_LogEntry (TOPIC_Wolf_BringCrawlerPlates, "Wolf can make me an armor out of 10 crawler plates.");
};


instance DIA_Wolf_TeachCrawlerPlates(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 2;
	condition = DIA_Wolf_TeachCrawlerPlates_Condition;
	information = DIA_Wolf_TeachCrawlerPlates_Info;
	permanent = TRUE;
	//description = B_BuildLearnString("Teach me how to take the plates off crawlers!",B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_CrawlerPlate));
	description = B_BuildLearnString(NAME_TROPHY_CrawlerPlate,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_CrawlerPlate));
};


func int DIA_Wolf_TeachCrawlerPlates_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_AboutCrawler) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_CrawlerPlate] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Wolf_TeachCrawlerPlates_Info()
{
	AI_Output (other, self, "DIA_Wolf_TeachCrawlerPlates_15_00");	//Teach me how to take the plates off of crawlers!
	if (B_TeachPlayerTalentTakeAnimalTrophy (self, other, TROPHY_CrawlerPlate))
	{
		AI_Output (self, other, "DIA_Wolf_TeachCrawlerPlates_08_01");	//It's easy. The back plates are only attached to the body along the edges. Just take a sharp blade and cut them out.
		AI_Output (self, other, "DIA_Wolf_TeachCrawlerPlates_08_02");	//Got it?
		AI_Output (other, self, "DIA_Wolf_TeachCrawlerPlates_15_03");	//Sounds easy.
		AI_Output (self, other, "DIA_Wolf_TeachCrawlerPlates_08_04");	//That's what I'm saying.
	};
};


instance DIA_Wolf_BringPlates(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 3;
	condition = DIA_Wolf_BringPlates_Condition;
	information = DIA_Wolf_BringPlates_Info;
	permanent = TRUE;
	description = "I've got the crawler plates for the armor.";
};


func int DIA_Wolf_BringPlates_Condition()
{
	if((MIS_Wolf_BringCrawlerPlates == LOG_Running) && (Npc_HasItems(other,ItAt_CrawlerPlate) >= 10))
	{
		return TRUE;
	};
};

func void DIA_Wolf_BringPlates_Info()
{
	AI_Output(other,self,"DIA_Wolf_BringPlates_15_00");	//I've got the crawler plates for the armor.
	AI_Output(self,other,"DIA_Wolf_BringPlates_08_01");	//Good! Give them here.
	B_GiveInvItems(other,self,ItAt_CrawlerPlate,10);
	MIS_Wolf_BringCrawlerPlates = LOG_SUCCESS;
	B_CheckLog();
};


var int Wolf_Armor_Day;

instance DIA_Wolf_ArmorReady(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 4;
	condition = DIA_Wolf_ArmorReady_Condition;
	information = DIA_Wolf_ArmorReady_Info;
	permanent = TRUE;
	description = "OK, where's the armor?";
};


func int DIA_Wolf_ArmorReady_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_AboutCrawler) && (Player_GotCrawlerArmor == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Wolf_ArmorReady_Info()
{
	AI_Output (other, self, "DIA_Wolf_ArmorReady_15_00");	//OK, where's the armor?
	if (Npc_HasItems (self, ItAt_CrawlerPlate) >= 10)
	{
		if(Wolf_MakeArmor == FALSE)
		{
			Wolf_Armor_Day = B_GetDayPlus();
			Wolf_MakeArmor = TRUE;
		};
		if((Wolf_MakeArmor == TRUE) && (Wolf_Armor_Day >= Wld_GetDay()))
		{
			AI_Output (self, other, "DIA_Wolf_ArmorReady_08_01");	//I'll put it together for you. Come back tomorrow.
		}
		else
		{
			Npc_RemoveInvItems(self,ItAt_CrawlerPlate,10);
			AI_Output(self,other,"DIA_Wolf_ArmorReady_08_02");	//I finished it. Here it is.
			B_GiveArmor(ITAR_DJG_Crawler);
			AI_Output (self, other, "DIA_Wolf_ArmorReady_08_03");	//Turned out really well, I think...
			AI_Output (other, self, "DIA_Wolf_ArmorReady_15_04");	//Thank you!
			AI_Output (self, other, "DIA_Wolf_ArmorReady_08_05");	//Don't mention it.
			Player_GotCrawlerArmor = TRUE;
			CreateInvItems(Bennet,ItBE_Addon_MC,1);
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Wolf_ArmorReady_08_06");	//You joker. I need the crawler plates first ...
		Wolf_MakeArmor = FALSE;
		MIS_Wolf_BringCrawlerPlates = LOG_Running;
	};
};


instance DIA_Wolf_BENGAR(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 31;
	condition = DIA_Wolf_BENGAR_Condition;
	information = DIA_Wolf_BENGAR_Info;
	permanent = TRUE;
	description = "I may have found a job for you on Bengar's farm.";
};


func int DIA_Wolf_BENGAR_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_Hallo) && (MIS_BengarsHelpingSLD == LOG_Running) && (Kapitel >= 3) && (Wolf_IsOnBoard != LOG_SUCCESS))
	{
		return TRUE;
	};
};


var int DIA_Wolf_BENGAR_oneTime;
var int Wolf_BENGAR_geld;

func void DIA_Wolf_BENGAR_Info()
{
	AI_Output (other, self, "DIA_Wolf_BENGAR_15_00");	//I may have found a job for you on Bengar's farm.
	if (DIA_Wolf_BENGAR_oneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Wolf_BENGAR_08_01");	//Let's hear it.
		AI_Output (other, self, "DIA_Wolf_BENGAR_15_02");	//The pass to the Valley of Mines comes out directly at Bengar's farm. He's got problems with all the beasts who squeeze themselves through the pass.
		AI_Output (other, self, "DIA_Wolf_BENGAR_15_03");	//Someone needs to defend Bengar's farm.
		AI_Output (self, other, "DIA_Wolf_BENGAR_08_04");	//That would be something. Then at least I'd be away from the farm here and wouldn't have to stare at the smithy.
		DIA_Wolf_BENGAR_oneTime = TRUE;
	};
	if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Wolf_BENGAR_08_05");	//Agreed. And since you're one of us, I'll make you a fair price. Give me 300 gold coins and I'm on my way.
		Wolf_BENGAR_geld = 300;
	}
	else
	{
		AI_Output (self, other, "DIA_Wolf_BENGAR_08_06");	//Good. That comes to 800 gold coins.
		AI_Output (other, self, "DIA_Wolf_BENGAR_15_07");	//A hefty price.
		AI_Output (self, other, "DIA_Wolf_BENGAR_08_08");	//Well. For one of us, I'd do it for almost nothing. But for you...
		Wolf_BENGAR_geld = 800;
	};
	Info_ClearChoices (DIA_Wolf_BENGAR);
	Info_AddChoice (DIA_Wolf_BENGAR, "I'll think about it.", DIA_Wolf_BENGAR_nochnicht);
	Info_AddChoice (DIA_Wolf_BENGAR, "Here's your gold.", DIA_Wolf_BENGAR_geld);
};

func void DIA_Wolf_BENGAR_geld()
{
	AI_Output (other, self, "DIA_Wolf_BENGAR_geld_15_00");	//Here's your gold.
	if (B_GiveInvItems (other, self, ItMi_Gold, Wolf_BENGAR_geld))
	{
		AI_Output (self, other, "DIA_Wolf_BENGAR_geld_08_01");	//Good. I'm off, then, to see to those beasts. Let's see who else on this farm I can enlist.
		AI_Output (self, other, "DIA_Wolf_BENGAR_geld_08_02");	//See you later.
		MIS_BengarsHelpingSLD = LOG_SUCCESS;
		B_GivePlayerXP(XP_BengarsHelpingSLD);
		AI_StopProcessInfos(self);
		AI_UseMob(self,"BENCH",-1);
		Npc_ExchangeRoutine(self,"BengarsFarm");
		B_StartOtherRoutine(SLD_815_Soeldner,"BengarsFarm");
		B_StartOtherRoutine(SLD_817_Soeldner,"BengarsFarm");
	}
	else
	{
		AI_Output (self, other, "DIA_Wolf_BENGAR_geld_08_03");	//Well, if you had the money, I'd be on my way already.
	};
	Info_ClearChoices(DIA_Wolf_BENGAR);
};

func void DIA_Wolf_BENGAR_nochnicht()
{
	AI_Output (other, self, "DIA_Wolf_BENGAR_nochnicht_15_00");	//I'll think about it.
	AI_Output (self, other, "DIA_Wolf_BENGAR_nochnicht_08_01");	//Okay, but don't let me down.
	Info_ClearChoices (DIA_Wolf_BENGAR);
};


instance DIA_Wolf_PERMKAP3(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 80;
	condition = DIA_Wolf_PERMKAP3_Condition;
	information = DIA_Wolf_PERMKAP3_Info;
	permanent = TRUE;
	description = "Everything all right?";
};


func int DIA_Wolf_PERMKAP3_Condition()
{
	if((Kapitel >= 3) && (Npc_GetDistToWP(self,"FARM3") < 3000) && (MIS_BengarsHelpingSLD == LOG_SUCCESS) && (Wolf_IsOnBoard != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Wolf_PERMKAP3_Info()
{
	AI_Output(other,self,"DIA_Wolf_PERMKAP3_15_00");	//Everything going well?
	AI_Output(self,other,"DIA_Wolf_PERMKAP3_08_02");	//Sure! Everything's quiet.
	AI_StopProcessInfos(self);
};


var int Wolf_SaidNo;

instance DIA_Wolf_KAP5_EXIT(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 1;
	condition = DIA_Wolf_KAP5_EXIT_Condition;
	information = DIA_Wolf_KAP5_EXIT_Info;
	important = TRUE;
	permanent = FALSE;
};


func int DIA_Wolf_KAP5_EXIT_Condition()
{
	if((Kapitel >= 3) && (Npc_GetDistToWP(self,"FARM3") < 3000) && (MIS_BengarsHelpingSLD == LOG_SUCCESS) && (Wolf_IsOnBoard != LOG_SUCCESS) && Npc_IsDead(Bengar))
	{
		return TRUE;
	};
};

func void DIA_Wolf_KAP5_EXIT_Info()
{
	AI_Output(self,other,"DIA_Wolf_PERMKAP3_08_01");	//My employer is dead. Oh well. I always wanted to have my own farm.
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"BengarDead");
	Wolf_SaidNo = FALSE;
};


instance DIA_Wolf_SHIP(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 2;
	condition = DIA_Wolf_SHIP_Condition;
	information = DIA_Wolf_SHIP_Info;
	description = "Would you like to get out of here on a ship?";
};


func int DIA_Wolf_SHIP_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && Npc_KnowsInfo(other,DIA_Wolf_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Wolf_SHIP_Info()
{
	AI_Output(other,self,"DIA_Wolf_SHIP_15_00");	//Would you fancy getting out of here on a ship?
	if((MIS_BengarsHelpingSLD == LOG_SUCCESS) && !Npc_IsDead(Bengar))
	{
		AI_Output(self,other,"DIA_Wolf_SHIP_08_01");	//No. Not any more. I've found my task. Maybe another time.
		Wolf_SaidNo = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Wolf_SHIP_08_02");	//Yeah, sure. Let's get out of here. I could be a big help to you defending your ship. Where are we going?
		MIS_BengarsHelpingSLD = LOG_OBSOLETE;
		B_LogEntry(Topic_Crew,"Wolf's had enough of this island and he's willing to do anything to get out. He's a good fighter.");
	};
};


instance DIA_Wolf_KnowWhereEnemy(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 2;
	condition = DIA_Wolf_KnowWhereEnemy_Condition;
	information = DIA_Wolf_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "I'm headed for an island not far from this one.";
};


func int DIA_Wolf_KnowWhereEnemy_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wolf_SHIP) && (Wolf_SaidNo == FALSE) && (MIS_SCKnowsWayToIrdorath == TRUE) && (Wolf_IsOnBoard == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Wolf_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_Wolf_KnowWhereEnemy_15_00");	//I'm headed for an island not far from this one.
	AI_Output (self, other, "DIA_Wolf_KnowWhereEnemy_08_01");	//Yeah, what are we waiting for? I could teach you archery and crossbow shooting while we're at sea.
	if (Crewmember_Count >= Max_Crew)
	{
		AI_Output (other, self, "DIA_Wolf_KnowWhereEnemy_15_02");	//I just remembered that I've actually got enough people already.
		AI_Output (self, other, "DIA_Wolf_KnowWhereEnemy_08_03");	//(angry) So THAT'S the way it is. First you wave a red flag at me and then nothing comes of it, eh?
		AI_Output (self, other, "DIA_Wolf_KnowWhereEnemy_08_04");	//Screw you. I hope your tub sinks.
		AI_StopProcessInfos (self);
	}
	else
	{
		Info_ClearChoices (DIA_Wolf_KnowWhereEnemy);
		Info_AddChoice (DIA_Wolf_KnowWhereEnemy, "I'm going to think about it a little longer.", DIA_Wolf_KnowWhereEnemy_No);
		Info_AddChoice (DIA_Wolf_KnowWhereEnemy, "Welcome aboard!", DIA_Wolf_KnowWhereEnemy_Yes);
	};
};

func void DIA_Wolf_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_Wolf_KnowWhereEnemy_Yes_15_00");	//Welcome aboard!
	AI_Output (other, self, "DIA_Wolf_KnowWhereEnemy_Yes_15_01");	//Come down to the harbor. We're leaving soon.
	AI_Output (self, other, "DIA_Wolf_KnowWhereEnemy_Yes_08_02");	//I'm on my way.
	B_JoinShip(self);
};

func void DIA_Wolf_KnowWhereEnemy_No()
{
	AI_Output (other, self, "DIA_Wolf_KnowWhereEnemy_No_15_00");	//I'm going to think about it a little longer.
	AI_Output (self, other, "DIA_Wolf_KnowWhereEnemy_No_08_01");	//Oh, you know what, I think you're just a braggart. I don't believe a word of it. Take a hike.
	Wolf_IsOnBoard = LOG_OBSOLETE;
	AI_StopProcessInfos(self);
};


instance DIA_Wolf_LeaveMyShip(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 55;
	condition = DIA_Wolf_LeaveMyShip_Condition;
	information = DIA_Wolf_LeaveMyShip_Info;
	permanent = TRUE;
	description = "I can't use you after all.";
};


func int DIA_Wolf_LeaveMyShip_Condition()
{
	if((Wolf_IsOnBoard == LOG_SUCCESS) && (MIS_ReadyforChapter6 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Wolf_LeaveMyShip_Info()
{
	AI_Output (other, self, "DIA_Wolf_LeaveMyShip_15_00");	//I can't use you after all.
	AI_Output (self, other, "DIA_Wolf_LeaveMyShip_08_01");	//First you give me hope and then a rejection like that. You bastard, I'll pay you back for that.
	Wolf_IsOnBoard = LOG_FAILED;
	B_CheckLog();
	Crewmember_Count -= 1;
	AI_StopProcessInfos(self);
	self.flags = 0;
	B_Attack(self,other,AR_NONE,1);
	Npc_ExchangeRoutine(self,"Start");
};


instance DIA_Wolf_SHIPOFF(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 56;
	condition = DIA_Wolf_SHIPOFF_Condition;
	information = DIA_Wolf_SHIPOFF_Info;
	permanent = TRUE;
	description = "Listen.";
};


func int DIA_Wolf_SHIPOFF_Condition()
{
	if(Wolf_IsOnBoard == LOG_FAILED)
	{
		return TRUE;
	};
};

func void DIA_Wolf_SHIPOFF_Info()
{
	AI_Output (other, self, "DIA_Wolf_SHIPOFF_15_00");	//Listen.
	AI_Output (self, other, "DIA_Wolf_SHIPOFF_08_01");	//Piss off, you bastard.
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};


instance DIA_Wolf_PICKPOCKET(C_Info)
{
	npc = SLD_811_Wolf;
	nr = 900;
	condition = DIA_Wolf_PICKPOCKET_Condition;
	information = DIA_Wolf_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Wolf_PICKPOCKET_Condition()
{
	return C_Beklauen(32,35);
};

func void DIA_Wolf_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Wolf_PICKPOCKET);
	Info_AddChoice(DIA_Wolf_PICKPOCKET,Dialog_Back,DIA_Wolf_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Wolf_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Wolf_PICKPOCKET_DoIt);
};

func void DIA_Wolf_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Wolf_PICKPOCKET);
};

func void DIA_Wolf_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Wolf_PICKPOCKET);
};

