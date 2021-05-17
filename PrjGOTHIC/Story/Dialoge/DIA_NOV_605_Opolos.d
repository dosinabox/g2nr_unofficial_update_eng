
instance DIA_Opolos_Kap1_EXIT(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 999;
	condition = DIA_Opolos_Kap1_EXIT_Condition;
	information = DIA_Opolos_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Opolos_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Opolos_Kap1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Opolos_Hello(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 1;
	condition = DIA_Opolos_Hello_Condition;
	information = DIA_Opolos_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Opolos_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Opolos_Hello_Info()
{
	AI_Output (self, other, "DIA_Opolos_Hello_12_00");	//Hello, you must be the new fellow.
	AI_Output (self, other, "DIA_Opolos_Hello_12_01");	//I'm Opolos. I take care of the sheep around here.
};


instance DIA_Opolos_Wurst(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 2;
	condition = DIA_Opolos_Wurst_Condition;
	information = DIA_Opolos_Wurst_Info;
	permanent = FALSE;
	description = "I've got this mutton sausage here ...";
};


func int DIA_Opolos_Wurst_Condition()
{
	if(C_CanFeedNOV(self))
	{
		return TRUE;
	};
};

func void DIA_Opolos_Wurst_Info()
{
	AI_Output(other,self,"DIA_Opolos_Wurst_15_00");	//I've got this mutton sausage here...
	AI_Output(self,other,"DIA_Opolos_Wurst_12_01");	//Oh, man, fantastic! Finally another delicious mutton sausage.
	B_FeedNOV(self);
};


instance DIA_Opolos_HowLong(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 1;
	condition = DIA_Opolos_HowLong_Condition;
	information = DIA_Opolos_HowLong_Info;
	permanent = FALSE;
	description = "How long have you been in the monastery?";
};


func int DIA_Opolos_HowLong_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Opolos_Hello))
	{
		return TRUE;
	};
};

func void DIA_Opolos_HowLong_Info()
{
	AI_Output (other, self, "DIA_Opolos_HowLong_15_00");	//How long have you been in the monastery?
	AI_Output (self, other, "DIA_Opolos_HowLong_12_01");	//I've been here three years. But so far I haven't studied, although I'd like to.
	AI_Output (other, self, "DIA_Opolos_HowLong_15_02");	//Why not?
	AI_Output (self, other, "DIA_Opolos_HowLong_12_03");	//My job is looking after the sheep - not studying the scriptures.
	AI_Output (self, other, "DIA_Opolos_HowLong_12_04");	//And as long as Master Parlan doesn't release me from this duty, I'm not allowed to study in the library.
	MIS_HelpOpolos = LOG_Running;
	Log_CreateTopic (Topic_OpolosStudy, LOG_MISSION);
	Log_SetTopicStatus (Topic_OpolosStudy, LOG_Running);
	B_LogEntry (Topic_OpolosStudy, "Opolos guards the sheep. He'd like to study the writings in the library.");
};


instance DIA_Opolos_Monastery(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 3;
	condition = DIA_Opolos_Monastery_Condition;
	information = DIA_Opolos_Monastery_Info;
	permanent = FALSE;
	description = "How shall I act here in the monastery?";
};


func int DIA_Opolos_Monastery_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Opolos_Hello) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Opolos_Monastery_Info()
{
	AI_Output (other, self, "DIA_Opolos_Monastery_15_00");	//How shall I act here in the monastery?
	AI_Output (self, other, "DIA_Opolos_Monastery_12_01");	//Never lie to a magician. Don't transgress against a brother of the community.
	AI_Output (self, other, "DIA_Opolos_Monastery_12_02");	//Respect the property of the community. If you violate these rules, you have to pay a penalty to Master Parlan.
	AI_Output (self, other, "DIA_Opolos_Monastery_12_03");	//Apart from that, I can only advise you to be careful around Agon. If you don't watch out, you'll end up like Babo.
};


instance DIA_Opolos_beibringen(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 3;
	condition = DIA_Opolos_beibringen_Condition;
	information = DIA_Opolos_beibringen_Info;
	permanent = FALSE;
	description = "Can you teach me something?";
};


func int DIA_Opolos_beibringen_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Opolos_Hello) && ((other.guild == GIL_NOV) || (other.guild == GIL_KDF)))
	{
		return TRUE;
	};
};

func void DIA_Opolos_beibringen_Info()
{
	AI_Output (other, self, "DIA_Opolos_beibringen_15_00");	//Is there anything you can teach me?
	AI_Output (self, other, "DIA_Opolos_beibringen_12_01");	//Sure, I used to beat up people. I can show you how to strengthen your arms.
	AI_Output (self, other, "DIA_Opolos_beibringen_12_02");	//But I'd like to learn something about potions, especially about magic potions.
	AI_Output (other, self, "DIA_Opolos_beibringen_15_03");	//How can I help you with that?
	AI_Output (self, other, "DIA_Opolos_beibringen_12_04");	//Well, if you work for Neoras you'll certainly have an opportunity to 'borrow' one of his recipes for a short time.
	AI_Output (self, other, "DIA_Opolos_beibringen_12_05");	//If you bring it to me so that I can take a look at it, I'll train you.
	Log_CreateTopic (Topic_OpolosRezept, LOG_MISSION);
	Log_SetTopicStatus (Topic_OpolosRezept, LOG_Running);
	B_LogEntry (Topic_OpolosRezept, "Opolos wants to take a quick look at a recipe for brewing mana potions. Working for Neoras, I might be able to borrow it.");
};


instance DIA_Opolos_rezept(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 3;
	condition = DIA_Opolos_rezept_Condition;
	information = DIA_Opolos_rezept_Info;
	permanent = TRUE;
	description = "About the recipe ...";
};


var int DIA_Opolos_rezept_permanent;

func int DIA_Opolos_rezept_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Opolos_beibringen) && ((other.guild == GIL_NOV) || (other.guild == GIL_KDF)) && (DIA_Opolos_rezept_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Opolos_rezept_Info()
{
	DIA_Common_AboutThatRecipe();
	if(Npc_HasItems(other,ItWr_ManaRezept))
	{
		AI_Output (other, self, "DIA_Opolos_rezept_15_00");	//I've got the recipe you wanted.
		AI_Output (self, other, "DIA_Opolos_rezept_12_01");	//Good, then let me read it.
		AI_PrintScreen("Given: Recipe for Magical Potions",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
		B_UseFakeScroll();
		AI_Output(self,other,"DIA_Opolos_rezept_12_02");	//Aha... hm... yes... I see... well, well...
		B_UseFakeScroll();
		AI_Output(self,other,"DIA_Opolos_rezept_12_03");	//Good, thanks a lot. If you want, you can train with me.
		AI_PrintScreen("Received: Recipe for Magical Potions",-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
		Opolos_Rezept = LOG_SUCCESS;
		B_GivePlayerXP(XP_Ambient);
		DIA_Opolos_rezept_permanent = TRUE;
		Opolos_TeachSTR = TRUE;
		Log_CreateTopic(Topic_KlosterTeacher,LOG_NOTE);
		B_LogEntry(Topic_KlosterTeacher,"Opolos can help me to become stronger.");
	}
	else if(MIS_NeorasRezept == LOG_SUCCESS)
	{
		AI_Output (other, self, "DIA_Opolos_rezept_15_04");	//I already brought the recipe back to Neoras.
		AI_Output (self, other, "DIA_Opolos_rezept_12_05");	//Oh shit - I'll probably never get to study here. So what. I'll train you anyway.
		Opolos_Rezept = LOG_FAILED;
		B_CheckLog();
		DIA_Opolos_rezept_permanent = TRUE;
		Opolos_TeachSTR = TRUE;
		Log_CreateTopic (Topic_KlosterTeacher, LOG_NOTE);
		B_LogEntry (Topic_KlosterTeacher, "Opolos can help me to become stronger.");
	}
	else
	{
		DIA_Common_WeWillGetToThatLater();
	};
};


func void B_BuildLearnDialog_Opolos()
{
	Info_ClearChoices(DIA_Opolos_TEACH_STR);
	Info_AddChoice(DIA_Opolos_TEACH_STR,Dialog_Back,DIA_Opolos_TEACH_STR_BACK);
	if(other.aivar[REAL_STRENGTH] >= T_MED)
	{
		AI_Output(self,other,"DIA_Opolos_TEACH_STR_12_00");	//You're pretty strong now. I can't teach you any more.
	}
	else
	{
		Info_AddChoice(DIA_Opolos_TEACH_STR,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_Opolos_TEACH_STR_1);
		Info_AddChoice(DIA_Opolos_TEACH_STR,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_Opolos_TEACH_STR_5);
	};
};

instance DIA_Opolos_TEACH_STR(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 99;
	condition = DIA_Opolos_TEACH_STR_Condition;
	information = DIA_Opolos_TEACH_STR_Info;
	permanent = TRUE;
	description = "I want to get stronger.";
};


func int DIA_Opolos_TEACH_STR_Condition()
{
	if(((hero.guild == GIL_KDF) || (hero.guild == GIL_NOV)) && (Opolos_TeachSTR == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Opolos_TEACH_STR_Info()
{
	AI_Output(other,self,"DIA_Opolos_TEACH_STR_15_00");	//I want to become stronger.
	B_BuildLearnDialog_Opolos();
};

func void DIA_Opolos_TEACH_STR_BACK()
{
	Info_ClearChoices(DIA_Opolos_TEACH_STR);
};

func void DIA_Opolos_TEACH_STR_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_MED))
	{
		B_BuildLearnDialog_Opolos();
	};
};

func void DIA_Opolos_TEACH_STR_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_MED))
	{
		B_BuildLearnDialog_Opolos();
	};
};

instance DIA_Opolos_Agon(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 4;
	condition = DIA_Opolos_Agon_Condition;
	information = DIA_Opolos_Agon_Info;
	permanent = FALSE;
	description = "Who are Agon and Babo?";
};


func int DIA_Opolos_Agon_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Opolos_Monastery) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Opolos_Agon_Info()
{
	AI_Output (other, self, "DIA_Opolos_Agon_15_00");	//Who are Agon and Babo?
	AI_Output (self, other, "DIA_Opolos_Agon_12_01");	//Agon takes care of the herb garden. He's also a novice, but he acts like he was the Chosen One himself.
	AI_Output (self, other, "DIA_Opolos_Agon_12_02");	//Babo came to the monastery shortly before you. At first he helped Agon in the herb garden.
	AI_Output (self, other, "DIA_Opolos_Agon_12_03");	//But they must have had a fight, and Babo has been sweeping the courtyard ever since.
	AI_Output (other, self, "DIA_Opolos_Agon_15_04");	//Do you know what happened?
	AI_Output (self, other, "DIA_Opolos_Agon_12_05");	//Not exactly. You'll have to ask them. But Agon's word has more weight than that of the other novices because he's the governor's nephew.
};


instance DIA_Opolos_LIESEL(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 2;
	condition = DIA_Opolos_LIESEL_Condition;
	information = DIA_Opolos_LIESEL_Info;
	permanent = TRUE;
	description = "Look here, I brought Betsy.";
};


func int DIA_Opolos_LIESEL_Condition()
{
	if((other.guild == GIL_NOV) && (Liesel_Giveaway == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Opolos_LIESEL_Info()
{
	AI_Output(other,self,"DIA_Opolos_LIESEL_15_00");	//Look here, I brought Betsy. Can I leave her with you?
	Npc_PerceiveAll(self);
	if(Wld_DetectNpc(self,Follow_Sheep,NOFUNC,-1) && (Npc_GetDistToNpc(self,other) < 800))
	{
		other.aivar[AIV_PARTYMEMBER] = FALSE;
		other.aivar[AIV_TAPOSITION] = NOTINPOS;
//		other.wp = "FP_ROAM_MONASTERY_04";
		other.wp = "NW_MONASTERY_SHEEP_02";
		other.start_aistate = ZS_MM_AllScheduler;
		B_StartOtherRoutine(other,"Monastery");
		Liesel_Giveaway = TRUE;
		AI_Output (self, hero, "DIA_Opolos_LIESEL_12_01");	//Yes, of course. Good-looking animal. I'll take good care of her.
		AI_StopProcessInfos (self);
	}
	else
	{
		AI_Output (other, self, "DIA_Opolos_Add_15_00");	//Hm... somehow I seem to have misplaced it. I'll come back later.
	};
};


instance DIA_Opolos_Biblothek(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 98;
	condition = DIA_Opolos_Biblothek_Condition;
	information = DIA_Opolos_Biblothek_Info;
	permanent = TRUE;
	description = "About the library...";
};


func int DIA_Opolos_Biblothek_Condition()
{
	if((other.guild == GIL_NOV) && Npc_KnowsInfo(other,DIA_Opolos_HowLong))
	{
		return TRUE;
	};
};

func void DIA_Opolos_Biblothek_Info()
{
	AI_Output (other, self, "DIA_Opolos_Biblothek_15_00");	//About the library...
	if (Parlan_Erlaubnis == FALSE)
	{
		AI_Output (self, other, "DIA_Opolos_Biblothek_12_01");	//That's the locked room to the left, next to the gate.
		AI_Output (self, other, "DIA_Opolos_Biblothek_12_02");	//But you'll only get the key when Master Parlan decides that you may study the teachings.
	}
	else
	{
		AI_Output (self, other, "DIA_Opolos_Biblothek_12_03");	//You lucky duck! You got the key to the library, even though you've only been here for a short while.
		AI_Output (self, other, "DIA_Opolos_Biblothek_12_04");	//Use your chance and study the old scriptures!
	};
	AI_StopProcessInfos(self);
};


instance DIA_Opolos_HelloAgain(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 2;
	condition = DIA_Opolos_HelloAgain_Condition;
	information = DIA_Opolos_HelloAgain_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Opolos_HelloAgain_Condition()
{
	if((other.guild == GIL_KDF) && (MIS_HelpOpolos == LOG_SUCCESS) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Opolos_HelloAgain_Info()
{
	AI_Output (self, other, "DIA_Opolos_HelloAgain_12_00");	//Hello. Thank you for helping me. I shall make the most of this chance and learn a lot.
	AI_Output (self, other, "DIA_Opolos_HelloAgain_12_01");	//But you certainly don't have time now to talk to a simple novice, Master.
	B_GivePlayerXP (XP_Ambient);
	AI_StopProcessInfos (self);
};


instance DIA_Opolos_HowIsIt(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 3;
	condition = DIA_Opolos_HowIsIt_Condition;
	information = DIA_Opolos_HowIsIt_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_Opolos_HowIsIt_Condition()
{
	if(other.guild == GIL_KDF)
	{
		return TRUE;
	};
};

func void DIA_Opolos_HowIsIt_Info()
{
	AI_Output (other, self, "DIA_Opolos_HowIsIt_15_00");	//How's it going?
	if (MIS_HelpOpolos == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Opolos_HowIsIt_12_01");	//Great. Since I've been allowed to study, everything is wonderful.
	}
	else
	{
		AI_Output (self, other, "DIA_Opolos_HowIsIt_12_02");	//I loyally fulfill all of the tasks given me, Master.
		AI_Output (self, other, "DIA_Opolos_HowIsIt_12_03");	//Every day, Innos sets new challenges before me. I'll continue to work on improving myself.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Opolos_Kap3_PERM(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 39;
	condition = DIA_Opolos_Kap3_PERM_Condition;
	information = DIA_Opolos_Kap3_PERM_Info;
	permanent = TRUE;
	description = "How are the sheep?";
};


func int DIA_Opolos_Kap3_PERM_Condition()
{
	if((Kapitel >= 3) && (other.guild != GIL_KDF))
	{
		return TRUE;
	};
};


var int Opolos_Dragons;
var int Opolos_DMT;
var int Opolos_Pedro;

func void DIA_Opolos_Kap3_PERM_Info()
{
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_15_00");	//How are the sheep?
	AI_Output (self, other, "DIA_Opolos_Kap3_PERM_12_01");	//How do you think they are? They stand around and munch grass.
	AI_Output (self, other, "DIA_Opolos_Kap3_PERM_12_02");	//I'd rather know what's happening outside. The magicians seem to be very nervous.
	if((Opolos_Dragons == FALSE) || (Opolos_DMT == FALSE) || (Opolos_Pedro == FALSE))
	{
		Info_ClearChoices(DIA_Opolos_Kap3_PERM);
		Info_AddChoice(DIA_Opolos_Kap3_PERM,Dialog_Back,DIA_Opolos_Kap3_PERM_BACK);
		if(Opolos_Dragons == FALSE)
		{
			Info_AddChoice(DIA_Opolos_Kap3_PERM,"There are dragons in the Valley of Mines.",DIA_Opolos_Kap3_PERM_DRAGONS);
		};
		if(Opolos_DMT == FALSE)
		{
			Info_AddChoice(DIA_Opolos_Kap3_PERM,"Strangers in black robes roam the countryside.",DIA_Opolos_Kap3_PERM_DMT);
		};
		if(((MIS_NovizenChase == LOG_Running) || (MIS_NovizenChase == LOG_SUCCESS)) && (Opolos_Pedro == FALSE))
		{
			Info_AddChoice(DIA_Opolos_Kap3_PERM,"Педро предал нас.",DIA_Opolos_Kap3_PERM_PEDRO);
		};
	}
	else
	{
		DIA_Common_NothingImportantYet();
	};
};

func void DIA_Opolos_Kap3_PERM_BACK()
{
	Info_ClearChoices(DIA_Opolos_Kap3_PERM);
};


func void DIA_Opolos_Kap3_PERM_DRAGONS()
{
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_DRAGONS_15_00");	//There are dragons in the Valley of Mines. They are besieging the royal troops together with the army of orcs.
	AI_Output (self, other, "DIA_Opolos_Kap3_PERM_DRAGONS_12_01");	//Dragons - I always thought they only existed in horror stories.
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_DRAGONS_15_02");	//They are there, believe me.
	AI_Output (self, other, "DIA_Opolos_Kap3_PERM_DRAGONS_12_03");	//But the king's paladins will deal with them, won't they?
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_DRAGONS_15_04");	//We'll see.
	B_GivePlayerXP(XP_Ambient);
	Opolos_Dragons = TRUE;
};


func void DIA_Opolos_Kap3_PERM_DMT()
{
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_DMT_15_00");	//Strangers in black robes roam the countryside.
	AI_Output (self, other, "DIA_Opolos_Kap3_PERM_DMT_12_01");	//What do you mean? What sort of strangers?
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_DMT_15_02");	//Nobody knows where they've come from. They wear long, black robes, and they cover their faces.
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_DMT_15_03");	//They seem to be some kind of magician. At least they are capable of magic.
	AI_Output (self, other, "DIA_Opolos_Kap3_PERM_DMT_12_04");	//That sounds very disturbing, but I'm sure that the High Council will solve this problem.
	B_GivePlayerXP(XP_Ambient);
	Opolos_DMT = TRUE;
};


func void DIA_Opolos_Kap3_PERM_PEDRO()
{
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_PEDRO_15_00");	//Pedro betrayed us.
	AI_Output (self, other, "DIA_Opolos_Kap3_PERM_PEDRO_12_01");	//I'd heard that, but I didn't know that you were aware of that, too. That's why I didn't say anything.
	AI_Output (self, other, "DIA_Opolos_Kap3_PERM_PEDRO_12_02");	//Is the enemy stronger than us - I mean, can we defeat him?
	AI_Output (other, self, "DIA_Opolos_Kap3_PERM_PEDRO_15_03");	//We're not dead yet.
	B_GivePlayerXP(XP_Ambient);
	Opolos_Pedro = TRUE;
};


instance DIA_Opolos_PICKPOCKET(C_Info)
{
	npc = NOV_605_Opolos;
	nr = 900;
	condition = DIA_Opolos_PICKPOCKET_Condition;
	information = DIA_Opolos_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Opolos_PICKPOCKET_Condition()
{
	return C_Beklauen(54,70);
};

func void DIA_Opolos_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Opolos_PICKPOCKET);
	Info_AddChoice(DIA_Opolos_PICKPOCKET,Dialog_Back,DIA_Opolos_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Opolos_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Opolos_PICKPOCKET_DoIt);
};

func void DIA_Opolos_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Opolos_PICKPOCKET);
};

func void DIA_Opolos_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Opolos_PICKPOCKET);
};

