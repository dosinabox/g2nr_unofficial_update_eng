
instance DIA_Igaranz_Kap1_EXIT(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 999;
	condition = DIA_Igaraz_Kap1_EXIT_Condition;
	information = DIA_Igaraz_Kap1_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Igaraz_Kap1_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Igaraz_Kap1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Igaranz_Hello(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 2;
	condition = DIA_Igaraz_Hello_Condition;
	information = DIA_Igaraz_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Igaraz_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (self.aivar[AIV_TalkedToPlayer] == FALSE) && (KNOWS_FIRE_CONTEST == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_Hello_Info()
{
	if(other.guild == GIL_NOV)
	{
		AI_Output (self, other, "DIA_Igaranz_Hello_13_00");	//What can I do for you, Brother?
	}
	else
	{
		AI_Output (self, other, "DIA_Igaranz_Hello_13_01");	//What can I do for you?
	};
};


instance DIA_Igaraz_Wurst(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 2;
	condition = DIA_Igaraz_Wurst_Condition;
	information = DIA_Igaraz_Wurst_Info;
	permanent = FALSE;
	description = "I'm busy distributing sausages.";
};


func int DIA_Igaraz_Wurst_Condition()
{
	if(C_CanFeedNOV(self))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_Wurst_Info()
{
	AI_Output (other, self, "DIA_Igaraz_Wurst_15_00");	//I'm busy distributing sausages.
	AI_Output (self, other, "DIA_Igaraz_Wurst_13_01");	//So you work for Gorax, huh? All right, pass the sausage, then.
	B_FeedNOV(self);
};


instance DIA_Igaranz_NotWork(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 3;
	condition = DIA_Igaraz_NotWork_Condition;
	information = DIA_Igaraz_NotWork_Info;
	permanent = FALSE;
	description = "Why aren't you working?";
};


func int DIA_Igaraz_NotWork_Condition()
{
	if((Npc_GetDistToWP(self,"NW_MONASTERY_GRASS_01") <= 500) && (KNOWS_FIRE_CONTEST == FALSE) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_NotWork_Info()
{
	AI_Output (other, self, "DIA_Igaranz_NotWork_15_00");	//Why aren't you working?
	AI_Output (self, other, "DIA_Igaranz_NotWork_13_01");	//I am permitted to study the teachings of Innos. I seek wisdom in his words.
	AI_Output (self, other, "DIA_Igaranz_NotWork_13_02");	//One day he will choose me - and then I shall take the test of magic and enter the Circle of Fire.
};


instance DIA_Igaranz_Choosen(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 2;
	condition = DIA_Igaraz_Choosen_Condition;
	information = DIA_Igaraz_Choosen_Info;
	permanent = TRUE;
	description = "Who are the Chosen?";
};


func int DIA_Igaraz_Choosen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Igaranz_NotWork) && (Npc_GetDistToWP(self,"NW_MONASTERY_GRASS_01") <= 500) && (KNOWS_FIRE_CONTEST == FALSE) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_Choosen_Info()
{
	AI_Output (other, self, "DIA_Igaranz_Choosen_15_00");	//Who are the Chosen?
	AI_Output (self, other, "DIA_Igaranz_Choosen_13_01");	//The novices whom Innos has ordained to take the test of magic.
	AI_Output (self, other, "DIA_Igaranz_Choosen_13_02");	//He who passes it is accepted into the ranks of the Magicians of Fire.
	Info_ClearChoices (DIA_Igaranz_Choosen);
	Info_AddChoice (DIA_Igaranz_Choosen, Dialog_Back, DIA_Igaranz_Choosen_back);
	Info_AddChoice (DIA_Igaranz_Choosen, "What is the Test of Magic?", DIA_Igaranz_Choosen_TestOfMagic);
	Info_AddChoice (DIA_Igaranz_Choosen, "How can I be chosen?", DIA_Igaranz_Choosen_HowChoosen);
};

func void DIA_Igaranz_Choosen_back()
{
	Info_ClearChoices(DIA_Igaranz_Choosen);
};

func void DIA_Igaranz_Choosen_TestOfMagic()
{
	AI_Output (other, self, "DIA_Igaranz_Choosen_TestOfMagic_15_00");	//What is the Test of Magic?
	AI_Output (self, other, "DIA_Igaranz_Choosen_TestOfMagic_13_01");	//A test which is announced by the high council to all chosen novices.
	AI_Output (self, other, "DIA_Igaranz_Choosen_TestOfMagic_13_02");	//It is an assignment in which faith and cleverness are put to the test.
	AI_Output (self, other, "DIA_Igaranz_Choosen_TestOfMagic_13_03");	//All the chosen novices take part - but it is only possible for one of them to complete it successfully.
};

func void DIA_Igaranz_Choosen_HowChoosen()
{
	AI_Output (other, self, "DIA_Igaranz_Choosen_HowChoosen_15_00");	//How can I be chosen?
	AI_Output (self, other, "DIA_Igaranz_Choosen_HowChoosen_13_01");	//You have no influence on that. Innos alone chooses his novices, and the High Council announces his will.
};


instance DIA_Igaranz_StudyInnos(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 2;
	condition = DIA_Igaraz_StudyInnos_Condition;
	information = DIA_Igaraz_StudyInnos_Info;
	permanent = FALSE;
	description = "How can I study the scriptures?";
};


func int DIA_Igaraz_StudyInnos_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Igaranz_NotWork) && (Npc_GetDistToWP(self,"NW_MONASTERY_GRASS_01") <= 500) && (Parlan_Erlaubnis == FALSE) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_StudyInnos_Info()
{
	AI_Output (other, self, "DIA_Igaranz_StudyInnos_15_00");	//How can I study the scriptures?
	AI_Output (self, other, "DIA_Igaranz_StudyInnos_13_01");	//You must gain access to the library.
	AI_Output (self, other, "DIA_Igaranz_StudyInnos_13_02");	//However, Master Parlan will only give you the key if you have first finished your duties.
};


instance DIA_Igaraz_IMTHEMAN(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 2;
	condition = DIA_Igaraz_IMTHEMAN_Condition;
	information = DIA_Igaraz_IMTHEMAN_Info;
	important = TRUE;
};


func int DIA_Igaraz_IMTHEMAN_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && (other.guild == GIL_NOV) && (Npc_GetDistToWP(self,"NW_TAVERNE_TROLLAREA_05") <= 3500) && !Npc_KnowsInfo(other,DIA_Igaraz_Stein))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_IMTHEMAN_Info()
{
	AI_Output (self, other, "DIA_Igaraz_IMTHEMAN_13_00");	//(proudly) It has happened. Innos has chosen me and I shall take part in the test of magic.
};


instance DIA_Igaraz_METOO(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 19;
	condition = DIA_Igaraz_METOO_Condition;
	information = DIA_Igaraz_METOO_Info;
	permanent = FALSE;
	description = "I'm in it, too ...";
};


func int DIA_Igaraz_METOO_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Igaraz_IMTHEMAN) && (other.guild == GIL_NOV) && (Npc_GetDistToWP(self,"NW_TAVERNE_TROLLAREA_05") <= 3500) && !Npc_KnowsInfo(other,DIA_Igaraz_Stein))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_METOO_Info()
{
	AI_Output (other, self, "DIA_Igaraz_METOO_15_00");	//I'm in it, too - I demanded the Test of Fire.
	AI_Output (self, other, "DIA_Igaraz_METOO_13_01");	//You did WHAT? So either you are a favorite of Innos, or completely crazy.
	AI_Output (other, self, "DIA_Igaraz_METOO_15_02");	//I've already done a lot of crazy things, so I'm positive I can pull this off, too ...
	AI_Output (self, other, "DIA_Igaraz_METOO_13_03");	//Innos holds his hand over me - therefore I shall pass this test.
	Info_ClearChoices (DIA_Igaraz_METOO);
	Info_AddChoice (DIA_Igaraz_METOO, Dialog_Back, DIA_Igaraz_METOO_BACK);
	Info_AddChoice (DIA_Igaraz_METOO, "Maybe we could work together ...", DIA_Igaraz_METOO_HELP);
	Info_AddChoice (DIA_Igaraz_METOO, "So, found anything out yet?", DIA_Igaraz_METOO_TELL);
	Info_AddChoice (DIA_Igaraz_METOO, "Have you seen Agon or Ulf?", DIA_Igaraz_METOO_AGON);
};

func void DIA_Igaraz_METOO_BACK()
{
	Info_ClearChoices(DIA_Igaraz_METOO);
};

func void DIA_Igaraz_METOO_TELL()
{
	AI_Output (other, self, "DIA_Igaraz_METOO_TELL_15_00");	//And, found out anything yet?
	AI_Output (self, other, "DIA_Igaraz_METOO_TELL_13_01");	//Since you stand no chance anyway, I may as well tell you:
	AI_Output (self, other, "DIA_Igaraz_METOO_TELL_13_02");	//Don't bother looking near the farms - there is nothing there that will get you anywhere.
};

func void DIA_Igaraz_METOO_HELP()
{
	AI_Output (other, self, "DIA_Igaraz_METOO_HELP_15_00");	//Maybe we could work together ...
	AI_Output (self, other, "DIA_Igaraz_METOO_HELP_13_01");	//Forget it. I'll accomplish this mission alone. You would just be a hindrance to me.
};

func void DIA_Igaraz_METOO_AGON()
{
	AI_Output (other, self, "DIA_Igaraz_METOO_AGON_15_00");	//Have you seen Agon or Ulf?
	AI_Output (self, other, "DIA_Igaraz_METOO_AGON_13_01");	//We split up at the inn. I went to the farms and those two set out together - but where to, I don't know.
};


instance DIA_Igaraz_ADD(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 23;
	condition = DIA_Igaraz_ADD_Condition;
	information = DIA_Igaraz_ADD_Info;
	permanent = FALSE;
	description = "Do you know anything about a 'living rock'?";
};


func int DIA_Igaraz_ADD_Condition()
{
	if(((Npc_GetDistToWP(self,"NW_TAVERNE_TROLLAREA_05") <= 3500) || (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_66") <= 3500)) && (MIS_Golem == LOG_Running) && !Npc_IsDead(Magic_Golem) && !Npc_KnowsInfo(other,DIA_Igaraz_Stein) && Npc_KnowsInfo(other,DIA_Igaraz_METOO))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_ADD_Info()
{
	AI_Output (other, self, "DIA_Igaraz_Add_15_00");	//Do you know anything about a 'living rock'?
	AI_Output (self, other, "DIA_Igaraz_Add_13_01");	//(cackling) No! Did Serpentes give you this test?
	AI_Output (other, self, "DIA_Igaraz_Add_15_02");	//Yes, why?
	AI_Output (self, other, "DIA_Igaraz_Add_13_03");	//I think I can imagine what he means...
	AI_Output (self, other, "DIA_Igaraz_Add_13_04");	//You wouldn't be the first person to fail this test...
	AI_Output (other, self, "DIA_Igaraz_Add_15_05");	//Where exactly can I find this living rock?
	AI_Output (self, other, "DIA_Igaraz_Add_13_06");	//Just keep following this path. After quite a while, you'll come to a river.
	AI_Output (self, other, "DIA_Igaraz_Add_13_07");	//Just continue to follow the path up the mountain. It's got to be up there someplace.
	AI_Output (self, other, "DIA_Igaraz_Add_13_08");	//When you come to a bridge, you've gone too far.
	AI_Output (self, other, "DIA_Igaraz_Add_13_09");	//(laughs) IF you get that far in the first place...
	AI_Output (self, other, "DIA_Igaraz_Add_13_10");	//That's all I'm going to tell you... (sarcastic) It's supposed to be your TEST after all!
};


instance DIA_Igaraz_Pruefung(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 22;
	condition = DIA_Igaraz_Pruefung_Condition;
	information = DIA_Igaraz_Pruefung_Info;
	permanent = TRUE;
	description = "Have you found out anything new?";
};


func int DIA_Igaraz_Pruefung_Condition()
{
	if((other.guild == GIL_NOV) && Npc_KnowsInfo(other,DIA_Igaraz_METOO))
	{
		if(!C_FireContestRuneFound())
		{
			return TRUE;
		};
	};
};

func void DIA_Igaraz_Pruefung_Info()
{
	AI_Output (other, self, "DIA_Igaraz_Pruefung_15_00");	//Have you found out anything new?
	AI_Output (self, other, "DIA_Igaraz_Pruefung_13_01");	//Not yet, but I'm still searching.
	AI_StopProcessInfos (self);
	if (Igaraz_Wait == FALSE)
	{
		Npc_ExchangeRoutine(self,"CONTESTWAIT");
		Igaraz_Wait = TRUE;
	};
};


instance DIA_Igaraz_Stein(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 1;
	condition = DIA_Igaraz_Stein_Condition;
	information = DIA_Igaraz_Stein_Info;
	important = TRUE;
	permanent = FALSE;
};


func int DIA_Igaraz_Stein_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && (other.guild == GIL_NOV))
	{
		if(C_FireContestRuneFound())
		{
			return TRUE;
		};
	};
};

func void DIA_Igaraz_Stein_Info()
{
	AI_Output (self, other, "DIA_Igaraz_Seufz_13_00");	//Hey, wait. We need to talk ...
	AI_Output (other, self, "DIA_Igaraz_Seufz_15_01");	//Actually, I don't think so ...
	AI_Output (self, other, "DIA_Igaraz_Seufz_13_02");	//I've waited years for this test. Innos is with me and I MUST pass this test.
	if (Npc_KnowsInfo (other, DIA_Ulf_Abrechnung))
	{
		AI_Output (other, self, "DIA_Igaraz_Seufz_15_03");	//That sounds familiar.
	}
	else
	{
		AI_Output (other, self, "DIA_Igaraz_Seufz_15_04");	//You're not the only one who says that.
	};
	AI_Output(self,other,"DIA_Igaraz_Seufz_13_05");	//Enough chatter. I need what you found. So, time for you to die!
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,0);
};


instance DIA_Igaranz_TalkAboutBabo(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 31;
	condition = DIA_Igaraz_TalkAboutBabo_Condition;
	information = DIA_Igaraz_TalkAboutBabo_Info;
	permanent = FALSE;
	description = "We need to talk about Babo.";
};


func int DIA_Igaraz_TalkAboutBabo_Condition()
{
	if(MIS_BabosDocs == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Igaraz_TalkAboutBabo_Info()
{
	AI_Output (other, self, "DIA_Igaranz_TalkAboutBabo_15_00");	//We need to talk about Babo.
	AI_Output (self, other, "DIA_Igaranz_TalkAboutBabo_13_01");	//(reserved) Yes, what's wrong?
};


instance DIA_Igaranz_BabosBelongings(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 31;
	condition = DIA_Igaraz_BabosBelongings_Condition;
	information = DIA_Igaraz_BabosBelongings_Info;
	permanent = FALSE;
	description = "You've got something which belongs to Babo.";
};


func int DIA_Igaraz_BabosBelongings_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Igaranz_TalkAboutBabo))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_BabosBelongings_Info()
{
	AI_Output (other, self, "DIA_Igaranz_BabosBelongings_15_00");	//You've got something which belongs to Babo.
	AI_Output (self, other, "DIA_Igaranz_BabosBelongings_13_01");	//What might that be?
	AI_Output (other, self, "DIA_Igaranz_BabosBelongings_15_02");	//A few papers. Babo would like them back.
	AI_Output (self, other, "DIA_Igaranz_BabosBelongings_13_03");	//(mocking) He would, wouldn't he. I can imagine. Unfortunately, I prefer to keep them, which brings us to a bit of a dilemma.
};


instance DIA_Igaranz_WhereDocs(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 31;
	condition = DIA_Igaraz_WhereDocs_Condition;
	information = DIA_Igaraz_WhereDocs_Info;
	permanent = FALSE;
	description = "Where have you got the papers?";
};


func int DIA_Igaraz_WhereDocs_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Igaranz_BabosBelongings) && (GotIgarazChestKey == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_WhereDocs_Info()
{
	AI_Output (other, self, "DIA_Igaranz_WhereDocs_15_00");	//Where have you got the papers?
	AI_Output (self, other, "DIA_Igaranz_WhereDocs_13_01");	//(smugly) Well, of course I don't have them on me. I'm afraid I can't help you further.
	AI_Output (other, self, "DIA_Igaranz_WhereDocs_15_02");	//Where are they?
	AI_Output (self, other, "DIA_Igaranz_WhereDocs_13_03");	//I have them safely locked up. And you will never get the key from me.
};


instance DIA_Igaranz_BabosJob(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 31;
	condition = DIA_Igaraz_BabosJob_Condition;
	information = DIA_Igaraz_BabosJob_Info;
	permanent = FALSE;
	description = "What was Babo supposed to do for you?";
};


func int DIA_Igaraz_BabosJob_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Igaranz_BabosBelongings))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_BabosJob_Info()
{
	AI_Output (other, self, "DIA_Igaranz_BabosJob_15_00");	//What was Babo supposed to do for you?
	AI_Output (self, other, "DIA_Igaranz_BabosJob_13_01");	//If I had known the baby would do it in his pants over a few swampweeds, then I would have seen to it that someone else took care of the monastery garden.
	AI_Output (other, self, "DIA_Igaranz_BabosJob_15_02");	//He's supposed to grow swampweed?
	AI_Output (self, other, "DIA_Igaranz_BabosJob_13_03");	//Of course. Since none of that stuff comes out from behind the barrier anymore, the price in the city has tripled.
	AI_Output (self, other, "DIA_Igaranz_BabosJob_13_04");	//It could have been a good bargain for everyone involved. But Babo didn't want to play along.
};


instance DIA_Igaranz_Price(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 31;
	condition = DIA_Igaraz_Price_Condition;
	information = DIA_Igaraz_Price_Info;
	permanent = FALSE;
	description = "How much do you want for the papers?";
};


func int DIA_Igaraz_Price_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Igaranz_BabosBelongings))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_Price_Info()
{
	AI_Output (other, self, "DIA_Igaranz_Price_15_00");	//How much do you want for the papers?
	AI_Output (self, other, "DIA_Igaranz_Price_13_01");	//(laughs) Ha, actually they're almost priceless. You very rarely see something like that here.
	AI_Output (self, other, "DIA_Igaranz_Price_13_02");	//But I have no desire to wager my future against a few gold pieces.
	AI_Output (self, other, "DIA_Igaranz_Price_13_03");	//300 gold pieces and you can do what you like with the papers.
};


instance DIA_Igaranz_BuyIt(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 31;
	condition = DIA_Igaraz_BuyIt_Condition;
	information = DIA_Igaraz_BuyIt_Info;
	permanent = TRUE;
	description = "I want to buy those papers.";
};


func int DIA_Igaraz_BuyIt_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Igaranz_Price) && (GotIgarazChestKey == FALSE) && Npc_HasItems(self,ItKe_IgarazChest_Mis))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_BuyIt_Info()
{
	AI_Output(other,self,"DIA_Igaranz_BuyIt_15_00");	//I want to buy those papers.
	if(B_GiveInvItems(other,self,ItMi_Gold,300))
	{
		AI_Output(self,other,"DIA_Igaranz_BuyIt_13_01");	//Look, I can't leave here right now. I'll give you the key to my chest, there's nothing else in there anyway.
		self.aivar[AIV_IGNORE_Theft] = TRUE;
		Feger2.aivar[AIV_IGNORE_Theft] = TRUE;
		Feger3.aivar[AIV_IGNORE_Theft] = TRUE;
		B_GiveInvItems(self,other,ItKe_IgarazChest_Mis,1);
		GotIgarazChestKey = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Igaranz_Price_13_03");	//300 gold pieces and you can do what you like with the papers.
		AI_StopProcessInfos(self);
	};
};


instance DIA_Igaraz_PICKPOCKET(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 900;
	condition = DIA_Igaraz_PICKPOCKET_Condition;
	information = DIA_Igaraz_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40_Key;
};


func int DIA_Igaraz_PICKPOCKET_Condition()
{
//	if(C_StealItems(40,Hlp_GetInstanceID(ItKe_IgarazChest_Mis),1) && (MIS_BabosDocs == LOG_Running))
	if(Npc_HasItems(self,ItKe_IgarazChest_Mis) && (MIS_BabosDocs == LOG_Running))
	{
		return C_StealItem(40);
	};
	return FALSE;
};

func void DIA_Igaraz_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Igaraz_PICKPOCKET);
	Info_AddChoice(DIA_Igaraz_PICKPOCKET,Dialog_Back,DIA_Igaraz_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Igaraz_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Igaraz_PICKPOCKET_DoIt);
};

func void DIA_Igaraz_PICKPOCKET_DoIt()
{
//	B_StealItems(40,Hlp_GetInstanceID(ItKe_IgarazChest_Mis),1);
	B_StealItem(40,Hlp_GetInstanceID(ItKe_IgarazChest_Mis));
	Info_ClearChoices(DIA_Igaraz_PICKPOCKET);
};

func void DIA_Igaraz_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Igaraz_PICKPOCKET);
};


instance DIA_Igaranz_Perm(C_Info)
{
	npc = NOV_601_Igaraz;
	nr = 2;
	condition = DIA_Igaraz_Perm_Condition;
	information = DIA_Igaraz_Perm_Info;
	permanent = FALSE;
	description = "Have you got anything interesting for me?";
};


func int DIA_Igaraz_Perm_Condition()
{
	if((Kapitel >= 3) && (other.guild != GIL_KDF) && (MIS_BabosDocs != LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Igaraz_Perm_Info()
{
	AI_Output (other, self, "DIA_Igaranz_Perm_15_00");	//Have you got anything interesting for me?
	AI_Output (self, other, "DIA_Igaranz_Perm_13_01");	//Ehm... no.
	AI_StopProcessInfos (self);
};

