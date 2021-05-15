
instance DIA_Addon_Finn_EXIT(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 999;
	condition = DIA_Addon_Finn_EXIT_Condition;
	information = DIA_Addon_Finn_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Finn_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Finn_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Finn_PICKPOCKET(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 900;
	condition = DIA_Addon_Finn_PICKPOCKET_Condition;
	information = DIA_Addon_Finn_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Addon_Finn_PICKPOCKET_Condition()
{
	return C_Beklauen(35,50);
};

func void DIA_Addon_Finn_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Finn_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Finn_PICKPOCKET,Dialog_Back,DIA_Addon_Finn_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Finn_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Finn_PICKPOCKET_DoIt);
};

func void DIA_Addon_Finn_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Finn_PICKPOCKET);
};

func void DIA_Addon_Finn_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Finn_PICKPOCKET);
};


instance DIA_Addon_Finn_Hacker(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 9;
	condition = DIA_Addon_Finn_Hacker_Condition;
	information = DIA_Addon_Finn_Hacker_Info;
	permanent = TRUE;
	description = "Back at work?";
};


func int DIA_Addon_Finn_Hacker_Condition()
{
	if(Npc_GetDistToWP(self,"ADW_MINE_PICK_06") <= 500)
	{
		return TRUE;
	};
};

func void DIA_Addon_Finn_Hacker_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10004_Finn_Hacker_15_00");	//Back at work?
	AI_Output (self, other, "DIA_Addon_BDT_10004_Finn_Hacker_07_01");	//Yeah, now I'm getting the very last piece of gold out of this mine.
};


instance DIA_Addon_Finn_Hi(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 1;
	condition = DIA_Addon_Finn_Hi_Condition;
	information = DIA_Addon_Finn_Hi_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Finn_Hi_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Addon_Finn_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10004_Finn_Hi_15_00");	//Hi!
	AI_Output (self, other, "DIA_Addon_BDT_10004_Finn_Hi_07_01");	//(grumpily) What do you want?
};


instance DIA_Addon_Finn_Hacke(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 2;
	condition = DIA_Addon_Finn_Hacke_Condition;
	information = DIA_Addon_Finn_Hacke_Info;
	permanent = FALSE;
	description = "Where do I get a pickaxe?";
};


func int DIA_Addon_Finn_Hacke_Condition()
{
	return TRUE;
};

func void DIA_Addon_Finn_Hacke_Info()
{
	AI_Output (other, self, "DIA_Addon_Finn_Hacke_15_00");	//Where do I get a pickaxe?
	AI_Output (self, other, "DIA_Addon_Finn_Hacke_07_01");	//Go to Huno the smith. But even if you have a pick, that doesn't mean that you can get into the mine.
	AI_Output (self, other, "DIA_Addon_Finn_Hacke_07_02");	//If you want to get in, you have to talk to Esteban.
	AI_Output (self, other, "DIA_Addon_Finn_Hacke_07_03");	//Don't even bother going to Thorus - he'll only let you in if you have a red stone.
};


instance DIA_Addon_Finn_Esteban(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 3;
	condition = DIA_Addon_Finn_Esteban_Condition;
	information = DIA_Addon_Finn_Esteban_Info;
	permanent = FALSE;
	description = "Tell me, what do you think of Esteban?";
};


func int DIA_Addon_Finn_Esteban_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Finn_Hacke))
	{
		return TRUE;
	};
};

func void DIA_Addon_Finn_Esteban_Info()
{
	AI_Output (other, self, "DIA_Addon_Finn_Esteban_15_00");	//Tell me, what do you think of Esteban?
	AI_Output (self, other, "DIA_Addon_Finn_Esteban_07_01");	//(carefully) He's the boss here... he's... all right, I think.
	AI_Output (self, other, "DIA_Addon_Finn_Esteban_07_02");	//(hesitantly) He always lets the good boys into the mine. The ones who know something about mining, I mean.
};


instance DIA_Addon_Finn_Profi(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 4;
	condition = DIA_Addon_Finn_Profi_Condition;
	information = DIA_Addon_Finn_Profi_Info;
	permanent = FALSE;
	description = "And you know something about mining?";
};


func int DIA_Addon_Finn_Profi_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Finn_Esteban))
	{
		return TRUE;
	};
};

func void DIA_Addon_Finn_Profi_Info()
{
	AI_Output (other, self, "DIA_Addon_Finn_Profi_15_00");	//And you know something about mining?
	AI_Output (self, other, "DIA_Addon_Finn_Profi_07_01");	//I'm the best!
};


instance DIA_Addon_BDT_10004_Finn_Mine(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 5;
	condition = DIA_Addon_Finn_Mine_Condition;
	information = DIA_Addon_Finn_Mine_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_MINE_DESCRIPTION;
};


func int DIA_Addon_Finn_Mine_Condition()
{
	if((MIS_Send_Buddler == LOG_Running) && (Player_SentBuddler < 3) && Npc_HasItems(other,ItMi_Addon_Stone_01))
	{
		return TRUE;
	};
};

func void DIA_Addon_Finn_Mine_Info()
{
	B_Say (other, self, "$MINE_ADDON_DESCRIPTION");
	B_GiveInvItems (other, self, ItMi_Addon_Stone_01, 1);
	AI_Output (self, other, "DIA_Addon_BDT_10004_Finn_Mine_07_00");	//Sure thing, boss. You want to see the best in the mine? Then I'll get back to it...
	AI_Output (self, other, "DIA_Addon_BDT_10004_Finn_Mine_07_01");	//Oh, something else. I'll let you in on a digger's secret.
	AI_Output (self, other, "DIA_Addon_BDT_10004_Finn_Mine_07_02");	//Now and then it's a good idea to give it a really good whack.
	AI_Output (self, other, "DIA_Addon_BDT_10004_Finn_Mine_07_03");	//If you've hacked a couple of times and nothing has come out, then drag the point of the pick sideways across the rock.
	AI_Output (self, other, "DIA_Addon_BDT_10004_Finn_Mine_07_04");	//With a little luck, you'll get several chunks at once that way.
	B_Upgrade_Hero_HackChance (10);
	Knows_Truemmerschlag = TRUE;
	Player_SentBuddler += 1;
	B_GivePlayerXP(XP_Addon_MINE);
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"MINE");
};


instance DIA_Addon_Finn_Gold(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 6;
	condition = DIA_Addon_Finn_Gold_Condition;
	information = DIA_Addon_Finn_Gold_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_GOLD_DESCRIPTION;
};


func int DIA_Addon_Finn_Gold_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Finn_Profi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Finn_Gold_Info()
{
	B_Say (other, self, "$ADDON_GOLD_DESCRIPTION");
	AI_Output (self, other, "DIA_Addon_Finn_Gold_07_00");	//Well, there's something you should know. Gold isn't ore. There's one damn important difference.
	AI_Output (self, other, "DIA_Addon_Finn_Gold_07_01");	//I mean, what woman would hang a chain of ore around her neck? (laughs)
	AI_Output (self, other, "DIA_Addon_Finn_Gold_07_02");	//When picking, work from top to bottom. You can work the nuggets loose best that way.
	AI_Output (self, other, "DIA_Addon_Finn_Gold_07_03");	//There are also diggers who do it the other way around - but that's far more difficult.
	B_Upgrade_Hero_HackChance (10);
};


instance DIA_Addon_Finn_ein(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 7;
	condition = DIA_Addon_Finn_ein_Condition;
	information = DIA_Addon_Finn_ein_Info;
	permanent = TRUE;
	description = "Can you judge my gold-digging abilities?";
};


func int DIA_Addon_Finn_ein_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Finn_Profi))
	{
		return TRUE;
	};
};


var int Finn_einmal;
var int Finn_Gratulation;

func void DIA_Addon_Finn_ein_Info()
{
	var string concatText;
	AI_Output (other, self, "DIA_Addon_Finn_ein_15_00");	//Can you judge my gold-digging abilities?
	if (Finn_einmal == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Finn_ein_07_01");	//Sure. I've been at this for over 35 years. There's nothing I can't assess!
		Finn_einmal = TRUE;
	};
	AI_Output (self, other, "DIA_Addon_Finn_ein_07_02");	//For you, I'd say you're...
	if (Hero_HackChance < 20)
	{
		AI_Output (self, other, "DIA_Addon_Finn_ein_07_03");	//an absolute beginner.
	}
	else if(Hero_HackChance < 40)
	{
		AI_Output (self, other, "DIA_Addon_Finn_ein_07_04");	//a quite passable scraper.
	}
	else if(Hero_HackChance < 55)
	{
		AI_Output (self, other, "DIA_Addon_Finn_ein_07_05");	//an experienced gold scraper.
	}
	else if(Hero_HackChance < 75)
	{
		AI_Output (self, other, "DIA_Addon_Finn_ein_07_06");	//a genuine digger.
	}
	else if(Hero_HackChance < 90)
	{
		AI_Output (self, other, "DIA_Addon_Finn_ein_07_07");	//a damned good digger.
	}
	else if(Hero_HackChance < 98)
	{
		AI_Output (self, other, "DIA_Addon_Finn_ein_07_08");	//a master digger.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Finn_ein_07_09");	//a guru among diggers.
		if (Finn_Gratulation == FALSE)
		{
			AI_Output(self,other,"DIA_Addon_Finn_ein_07_10");	//So now you're as good as I am. Congratulations, partner.
			B_GivePlayerXP(XP_Ambient * 2);
			Snd_Play("LEVELUP");
			Finn_Gratulation = TRUE;
		};
	};
	concatText = ConcatStrings("Digging Skill: ",IntToString(Hero_HackChance));
	concatText = ConcatStrings(concatText," percent");
	PrintScreen(concatText,-1,-1,FONT_ScreenSmall,2);
};


instance DIA_Addon_Finn_Attentat(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 8;
	condition = DIA_Addon_Finn_Attentat_Condition;
	information = DIA_Addon_Finn_Attentat_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_ATTENTAT_DESCRIPTION2;
};


func int DIA_Addon_Finn_Attentat_Condition()
{
	if(MIS_Judas == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Finn_Attentat_Info()
{
	B_Say (other, self, "$ATTENTAT_ADDON_DESCRIPTION2");
	AI_Output (self, other, "DIA_Addon_Finn_Attentat_07_00");	//(warily) Yes?
	AI_Output (other, self, "DIA_Addon_Finn_Attentat_15_01");	//Do you have any idea who's behind this?
	AI_Output (self, other, "DIA_Addon_Finn_Attentat_07_02");	//Why do you want to know?
	Info_ClearChoices (DIA_Addon_Finn_Attentat);
	Info_AddChoice (DIA_Addon_Finn_Attentat, "I want to talk to the guy...", DIA_Addon_Finn_Attentat_WannaTalk);
	Info_AddChoice (DIA_Addon_Finn_Attentat, "Esteban wants to see him dead!", DIA_Addon_Finn_Attentat_ForTheBoss);
};

func void B_Addon_Finn_TellAll()
{
	AI_Output (self, other, "DIA_Addon_Finn_TellAll_07_00");	//(narrating) When the attack took place, I was trying to get my pickaxe from Huno the smith.
	AI_Output (self, other, "DIA_Addon_Finn_TellAll_07_01");	//But he wasn't there.
	AI_Output (other, self, "DIA_Addon_Finn_TellAll_15_02");	//And?
	AI_Output (self, other, "DIA_Addon_Finn_TellAll_07_03");	//Usually, he's ALWAYS there. VERY suspicious if you ask me.
	if(Finn_TellAll == FALSE)
	{
		B_LogEntry(Topic_Addon_Esteban,"Finn says that Huno was not present during the attack.");
		Finn_TellAll = TRUE;
	};
};

func void DIA_Addon_Finn_Attentat_ForTheBoss()
{
	AI_Output (other, self, "DIA_Addon_Finn_ForTheBoss_15_00");	//Esteban wants to see him dead!
	AI_Output (self, other, "DIA_Addon_Finn_ForTheBoss_07_01");	//Oh! You work for the boss?
	AI_Output (self, other, "DIA_Addon_Finn_ForTheBoss_07_02");	//Then I'll tell you what I know.
	B_Addon_Finn_TellAll ();
	Info_ClearChoices (DIA_Addon_Finn_Attentat);
};

func void DIA_Addon_Finn_Attentat_WannaTalk()
{
	AI_Output (other, self, "DIA_Addon_Finn_WannaTalk_15_00");	//I want to talk to the guy...
	AI_Output (self, other, "DIA_Addon_Finn_WannaTalk_07_01");	//(warily) So? And what do you want from him.
	Info_ClearChoices (DIA_Addon_Finn_Attentat);
	Info_AddChoice (DIA_Addon_Finn_Attentat, "That's none of your business!", DIA_Addon_Finn_Attentat_ForgetIt);
	Info_AddChoice (DIA_Addon_Finn_Attentat, "I have some interesting information for him!", DIA_Addon_Finn_Attentat_HaveInfos);
	Info_AddChoice (DIA_Addon_Finn_Attentat, "I want to bump off Esteban and I'm looking for an ally!", DIA_Addon_Finn_Attentat_KillEsteban);
};

func void DIA_Addon_Finn_Attentat_KillEsteban()
{
	AI_Output (other, self, "DIA_Addon_Finn_KillEsteban_15_00");	//I want to bump off Esteban and I'm looking for an ally!
	AI_Output (self, other, "DIA_Addon_Finn_KillEsteban_07_01");	//I won't have anything to do with that!
	Finn_Petzt = TRUE;
	Info_ClearChoices(DIA_Addon_Finn_Attentat);
	AI_StopProcessInfos(self);
};

func void DIA_Addon_Finn_Attentat_HaveInfos()
{
	AI_Output (other, self, "DIA_Addon_Finn_HaveInfos_15_00");	//I have some interesting information for him!
	AI_Output (self, other, "DIA_Addon_Finn_HaveInfos_07_01");	//You're in cahoots with the guy who ordered it, aren't you?
	Info_ClearChoices (DIA_Addon_Finn_Attentat);
	Info_AddChoice (DIA_Addon_Finn_Attentat, "I want to bump off Esteban and I'm looking for an ally!", DIA_Addon_Finn_Attentat_KillEsteban);
	Info_AddChoice (DIA_Addon_Finn_Attentat, "That's none of your business!", DIA_Addon_Finn_Attentat_ForgetIt);
	Info_AddChoice (DIA_Addon_Finn_Attentat, "Absolutely not!", DIA_Addon_Finn_Attentat_NoNo);
};

func void DIA_Addon_Finn_Attentat_NoNo()
{
	AI_Output (other, self, "DIA_Addon_Finn_NoNo_15_00");	//Absolutely not!
	AI_Output (self, other, "DIA_Addon_Finn_NoNo_07_01");	//(appraisingly) Good! I'll tell you what I know.
	B_Addon_Finn_TellAll ();
	Info_ClearChoices (DIA_Addon_Finn_Attentat);
};

func void DIA_Addon_Finn_Attentat_ForgetIt()
{
	AI_Output (other, self, "DIA_Addon_Finn_ForgetIt_15_00");	//That's none of your business!
	AI_Output (self, other, "DIA_Addon_Finn_ForgetIt_07_01");	//So? Well, then I don't know anything about the business.
	Info_ClearChoices (DIA_Addon_Finn_Attentat);
};


instance DIA_Addon_Finn_Again(C_Info)
{
	npc = BDT_10004_Addon_Finn;
	nr = 9;
	condition = DIA_Addon_Finn_Again_Condition;
	information = DIA_Addon_Finn_Again_Info;
	permanent = TRUE;
	description = "About the attack again...";
};


func int DIA_Addon_Finn_Again_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Finn_Attentat) && !Npc_IsDead(Esteban))
	{
		return TRUE;
	};
};

func void DIA_Addon_Finn_Again_Info()
{
	AI_Output (other, self, "DIA_Addon_Finn_Again_15_00");	//About the attack again...
	if (Finn_TellAll == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Finn_Again_07_01");	//I already told you everything I know.
		Info_ClearChoices (DIA_Addon_Finn_Again);
		Info_AddChoice (DIA_Addon_Finn_Again, "Okay... (back)", DIA_Addon_Finn_Again_Exit);
		Info_AddChoice (DIA_Addon_Finn_Again, "Then tell me again!", DIA_Addon_Finn_Again_Nochmal);
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Finn_Again_07_02");	//Just leave me alone with that crap!
		AI_StopProcessInfos (self);
	};
};

func void DIA_Addon_Finn_Again_Exit()
{
	AI_Output (other, self, "DIA_Addon_Finn_Again_Exit_15_00");	//(appraisingly) Okay...
	Info_ClearChoices (DIA_Addon_Finn_Again);
};

func void DIA_Addon_Finn_Again_Nochmal()
{
	AI_Output (other, self, "DIA_Addon_Finn_Again_Nochmal_15_00");	//Then tell me again!
	B_Addon_Finn_TellAll ();
	Info_ClearChoices (DIA_Addon_Finn_Again);
};

