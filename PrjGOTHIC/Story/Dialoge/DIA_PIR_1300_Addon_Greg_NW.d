
instance DIA_Addon_Greg_NW_EXIT(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 999;
	condition = DIA_Addon_Greg_NW_EXIT_Condition;
	information = DIA_Addon_Greg_NW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Greg_NW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Greg_NW_EXIT_Info()
{
	AI_StopProcessInfos(self);
	if(GregWolfs == FALSE)
	{
		Wld_InsertNpc(YWolf,"NW_FARM1_PATH_CITY_05_B");
		Wld_InsertNpc(YWolf,"NW_FARM1_PATH_CITY_05_B");
		GregWolfs = TRUE;
	};
};


instance DIA_Addon_Greg_NW_Hallo(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_Hallo_Condition;
	information = DIA_Addon_Greg_NW_Hallo_Info;
	important = TRUE;
};


func int DIA_Addon_Greg_NW_Hallo_Condition()
{
	if(GregLocation == Greg_Farm1)
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_Hallo_Info()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_01_00");	//Psst. Hey, you. Come here.
	AI_Output (other, self, "DIA_Addon_Greg_NW_Hallo_15_01");	//What is it?
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_01_02");	//On your way to the city? And really busy, too.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_01_03");	//(slimily) Listen. You look like a smart guy to me. I bet you'll go far in life.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_01_04");	//You're certainly nobody's fool. I could see that right away.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_01_05");	//Say, you'd probably like to earn a couple of gold coins, wouldn't you?
	if(GregWolfs == FALSE)
	{
		Wld_InsertNpc(YWolf,"NW_FARM1_PATH_CITY_05_B");
		Wld_InsertNpc(YWolf,"NW_FARM1_PATH_CITY_05_B");
		GregWolfs = TRUE;
	};
//	SC_MeetsGregTime = 1;
	Info_ClearChoices(DIA_Addon_Greg_NW_Hallo);
	Info_AddChoice (DIA_Addon_Greg_NW_Hallo, "About the city guards ...", DIA_Addon_Greg_NW_Hallo_weg);
	Info_AddChoice (DIA_Addon_Greg_NW_Hallo, "Cut the crap. Tell me what you want.", DIA_Addon_Greg_NW_Hallo_schleim);
	Info_AddChoice (DIA_Addon_Greg_NW_Hallo, "You don't look like someone who has gold.", DIA_Addon_Greg_NW_Hallo_vorsicht);
	Info_AddChoice (DIA_Addon_Greg_NW_Hallo, "Are you hiding from someone?", DIA_Addon_Greg_NW_Hallo_hide);
	Info_AddChoice (DIA_Addon_Greg_NW_Hallo, "Why not?", DIA_Addon_Greg_NW_Hallo_ja);
};

func void DIA_Addon_Greg_NW_Hallo_weg()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Hallo_weg_15_00");	//I've got to be going.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_weg_01_01");	//(annoyed) So you won't help me. I'll remember that, pal. We'll meet again.
	AI_StopProcessInfos (self);
	MIS_Addon_Greg_BringMeToTheCity = LOG_FAILED;
	B_CheckLog();
};

func void DIA_Addon_Greg_NW_Hallo_ja()
{
	DIA_Common_WhyNot();
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_ja_01_01");	//You'll have to forgive an ignorant old seaman, I'm a stranger in these parts and I don't really know all the rules.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_ja_01_02");	//So I had to find out the hard way that traveling strangers aren't welcome in the harbor city.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_ja_01_03");	//(exaggerated self pity) Now I'm standing here with no idea how I'm supposed to get into the city.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_ja_01_04");	//I have some extremely important business to conduct and my client won't tolerate a delay, you see?
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_ja_01_05");	//You'll help me find a way to get past the city guard, won't you?
	Info_ClearChoices (DIA_Addon_Greg_NW_Hallo);
	Log_CreateTopic (TOPIC_Addon_Greg_NW, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Greg_NW, LOG_Running);
	B_LogEntry (TOPIC_Addon_Greg_NW, "The strange fellow with the eyepatch wants to get into the harbor city. I'm supposed to find a way for him to get past the city guards.");
	MIS_Addon_Greg_BringMeToTheCity = LOG_Running;
};

func void DIA_Addon_Greg_NW_Hallo_vorsicht()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Hallo_vorsicht_15_00");	//You don't look like someone who has gold.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_vorsicht_01_01");	//(exaggerated modesty) Well, I certainly don't move in the same circles as a gentleman like you.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_vorsicht_01_02");	//But you won't refuse my small contribution to your surely considerable fortune, will you?
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_vorsicht_01_03");	//Well, what do you say? Can I count on you?
};

func void DIA_Addon_Greg_NW_Hallo_schleim()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Hallo_schleim_15_00");	//Cut the crap. Tell me what you want.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_schleim_01_01");	//You see? That's exactly what I mean.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_schleim_01_02");	//Nobody gets anywhere with you just by using pretty words.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_schleim_01_03");	//I knew it. I'm dealing with a tough businessman here.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_schleim_01_04");	//You're a businessman, and certainly interested in a small addition to your purse, aren't you?
};

func void DIA_Addon_Greg_NW_Hallo_hide()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Hallo_hide_15_00");	//Are you hiding from someone?
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_hide_01_01");	//Of course not. What nonsense. I just enjoy standing among the trees so the wind won't blow right into my face.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Hallo_hide_01_02");	//But what about you, now? Do you want the job?
};


instance DIA_Addon_Greg_NW_Stadtwachen(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_Stadtwachen_Condition;
	information = DIA_Addon_Greg_NW_Stadtwachen_Info;
	permanent = TRUE;
	description = "About the city guards...";
};


func int DIA_Addon_Greg_NW_Stadtwachen_Condition()
{
	if((MIS_Addon_Greg_BringMeToTheCity == LOG_Running) && (GregLocation == Greg_Farm1))
	{
		return TRUE;
	};
};


var int DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_geld;
var int DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_Schein;
var int DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_constantino;

func void DIA_Addon_Greg_NW_Stadtwachen_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Stadtwachen_15_00");	//About the city guards ...
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_01_01");	//Yes? Got an idea?
	Info_ClearChoices (DIA_Addon_Greg_NW_Stadtwachen);
	Info_AddChoice (DIA_Addon_Greg_NW_Stadtwachen, "I'll have to think about it first.", DIA_Addon_Greg_NW_Stadtwachen_nochnicht);
	if (DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_geld == FALSE)
	{
		Info_AddChoice (DIA_Addon_Greg_NW_Stadtwachen, "What about bribery?", DIA_Addon_Greg_NW_Stadtwachen_geld);
	};
	if((DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_Schein == FALSE) && Npc_HasItems(other,ItWr_Passierschein))
	{
		Info_AddChoice (DIA_Addon_Greg_NW_Stadtwachen, "I have a pass for the city.", DIA_Addon_Greg_NW_Stadtwachen_Schein);
	};
	if((MIS_Addon_Lester_PickForConstantino != FALSE) && (DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_constantino == FALSE))
	{
		Info_AddChoice (DIA_Addon_Greg_NW_Stadtwachen, "You could get into the city as a herb gatherer.", DIA_Addon_Greg_NW_Stadtwachen_constantino);
	};
	if(Npc_HasItems(other,ITAR_Bau_L) || Npc_HasItems(other,ITAR_Bau_M))
	{
		Info_AddChoice (DIA_Addon_Greg_NW_Stadtwachen, "They should let you pass if you're wearing these farmer's clothes.", DIA_Addon_Greg_NW_Stadtwachen_klamotten);
	};
};

func void DIA_Addon_Greg_NW_Stadtwachen_klamotten()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Stadtwachen_klamotten_15_00");	//They should let you pass if you're wearing these farmer's clothes.
	if (Npc_HasItems (other, ITAR_Bau_L))
	{
		B_GiveInvItems(other,self,ITAR_Bau_L,1);
	}
	else
	{
		B_GiveInvItems(other,self,ITAR_Bau_M,1);
	};
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_klamotten_01_01");	//That's just what I need. Man, I knew I could count on you.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_klamotten_01_02");	//(maliciously) Nobody will bother me disguised as a local yokel. Ha ha.
	if (Npc_HasItems (self, ITAR_Bau_L))
	{
		AI_EquipArmor(self,ITAR_Bau_L);
	}
	else
	{
		AI_EquipArmor(self,ITAR_Bau_M);
	};
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_klamotten_01_03");	//Excellent. You did really well. Here's your promised reward.
	CreateInvItems (self, ItMi_Gold, 50);
	B_GiveInvItems (self, other, ItMi_Gold, 50);
	B_GivePlayerXP (XP_Greg_NW_GiveBauArmor);
	AI_Output (other, self, "DIA_Addon_Greg_NW_Stadtwachen_klamotten_15_04");	//(annoyed) What? 50 measly gold coins? You can't be serious.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_klamotten_01_05");	//(patronizingly) Gold isn't everything, my friend. Take them for now.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_klamotten_01_06");	//I have the feeling that we'll be seeing one another soon.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_klamotten_01_07");	//And who knows? Maybe I'll return the favor. Look after yourself.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Markt");
	B_LogEntry (TOPIC_Addon_Greg_NW, "I gave him some farmer's clothes. He can get past the city guards with those.");
	MIS_Addon_Greg_BringMeToTheCity = LOG_SUCCESS;
};

func void DIA_Addon_Greg_NW_Stadtwachen_nochnicht()
{
	DIA_Common_INeedToThinkAboutIt();
	AI_Output(self,other,"DIA_Addon_Greg_NW_Stadtwachen_nochnicht_01_01");	//(seriously) All right. But hurry up about it. I've got no time to lose.
	AI_StopProcessInfos(self);
};

func void DIA_Addon_Greg_NW_Stadtwachen_Schein()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Stadtwachen_Schein_15_00");	//I have a pass for the city.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_Schein_01_01");	//(cynically) Oh, I see. I'm supposed to act like I'm a citizen of the town, or what?
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_Schein_01_02");	//(annoyed) Take a look at me, boy. Nobody is going to believe that.
	DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_Schein = TRUE;
};

func void DIA_Addon_Greg_NW_Stadtwachen_constantino()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Stadtwachen_constantino_15_00");	//You could get into the city as a herb gatherer.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_constantino_01_01");	//(annoyed) What? Do I look like I'd be picking flowers in the woods?
	DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_constantino = TRUE;
};

func void DIA_Addon_Greg_NW_Stadtwachen_geld()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_Stadtwachen_geld_15_00");	//What about bribery?
	AI_Output (self, other, "DIA_Addon_Greg_NW_Stadtwachen_geld_01_01");	//(roguishly) Well, if that worked for me, I'd have tried it already.
	DIA_Addon_Greg_NW_Stadtwachen_ChoiceClose_geld = TRUE;
};


instance DIA_Addon_Greg_NW_PERM(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_PERM_Condition;
	information = DIA_Addon_Greg_NW_PERM_Info;
	permanent = TRUE;
	description = "One more thing ...";
};


func int DIA_Addon_Greg_NW_PERM_Condition()
{
	if(((MIS_Addon_Greg_BringMeToTheCity == LOG_SUCCESS) || (MIS_Addon_Greg_BringMeToTheCity == LOG_FAILED)) && (GregLocation == Greg_Farm1))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_PERM_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_PERM_15_00");	//One more thing ...
	AI_Output (self, other, "DIA_Addon_Greg_NW_PERM_01_01");	//(arrogantly) Listen, kid. I've got important things to do right now.
	AI_Output (self, other, "DIA_Addon_Greg_NW_PERM_01_02");	//(threatening) We'll talk again later. Got it?
	AI_StopProcessInfos (self);
};


instance DIA_Addon_Greg_NW_MeetGregSecondTime(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_MeetGregSecondTime_Condition;
	information = DIA_Addon_Greg_NW_MeetGregSecondTime_Info;
	important = TRUE;
};


func int DIA_Addon_Greg_NW_MeetGregSecondTime_Condition()
{
	if(GregLocation == Greg_Taverne)
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_MeetGregSecondTime_Info()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_MeetGregSecondTime_01_00");	//Look who just turned up.
	if (MIS_Addon_Greg_BringMeToTheCity == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_MeetGregSecondTime_01_01");	//The farmer boy.
	}
	else if(MIS_Addon_Greg_BringMeToTheCity == LOG_FAILED)
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_MeetGregSecondTime_01_02");	//The fellow who brushed me off so blatantly. So we meet again, eh?
	}
	else if(MIS_Addon_Greg_BringMeToTheCity == LOG_Running)
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_MeetGregSecondTime_01_03");	//(angry) I thought you wanted to help me. Instead, you just slipped away.
		AI_Output (self, other, "DIA_Addon_Greg_NW_MeetGregSecondTime_01_04");	//You thought I'd be stuck there forever, didn't you?
		AI_Output (self, other, "DIA_Addon_Greg_NW_MeetGregSecondTime_01_05");	//It just goes to show. Help yourself or no one else will help you. But I won't let you get away with it again.
	};
	AI_Output(self,other,"DIA_Addon_Greg_NW_MeetGregSecondTime_01_06");	//You're just in time.
	Knows_Taverne = TRUE;
	SC_SawGregInTaverne = TRUE;
};


instance DIA_Addon_Greg_NW_wer(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_wer_Condition;
	information = DIA_Addon_Greg_NW_wer_Info;
	description = "Who are you, anyway?";
};


func int DIA_Addon_Greg_NW_wer_Condition()
{
	if(GregLocation >= Greg_Taverne)
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_wer_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_wer_15_00");	//Who are you, anyway?
	AI_Output (self, other, "DIA_Addon_Greg_NW_wer_01_01");	//That's none of your business.
	AI_Output (self, other, "DIA_Addon_Greg_NW_wer_01_02");	//If I wanted to tell you who I am, I'd have done it already, got it?
};


func void B_Greg_Search_Dexter()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_Search_Dexter_01_00");	//I'm looking for a fellow. He isn't anywhere to be found in the city, and these losers here don't have a clue either.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Search_Dexter_01_01");	//He's thin, dark-haired and usually wears red armor.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Search_Dexter_01_02");	//As far as I know, he used to be a prisoner in the colony. I think his name starts with a 'D'.
	Log_CreateTopic(TOPIC_Addon_Greg_NW,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_Greg_NW,LOG_Running);
	B_LogEntry(TOPIC_Addon_Greg_NW,"The man with the eyepatch is looking for someone whose name starts with 'D'.");
	SC_KnowsGregsSearchsDexter = TRUE;
};

instance DIA_Addon_Greg_NW_was(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_was_Condition;
	information = DIA_Addon_Greg_NW_was_Info;
	description = "What do you want from me?";
};


func int DIA_Addon_Greg_NW_was_Condition()
{
	if(GregLocation == Greg_Taverne)
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_was_Info()
{
	AI_Output(other,self,"DIA_Addon_Greg_NW_was_15_00");	//What do you want from me?
	if(MIS_Addon_Greg_BringMeToTheCity != FALSE)
	{
		AI_Output (other, self, "DIA_Addon_Greg_NW_was_15_01");	//Are you still having problems with the city guards?
		AI_Output (self, other, "DIA_Addon_Greg_NW_was_01_02");	//(threatening) I'll GIVE you problems, you punk.
	};
	B_Greg_Search_Dexter ();
	Info_ClearChoices (DIA_Addon_Greg_NW_was);
	Info_AddChoice (DIA_Addon_Greg_NW_was, "You're talking about Diego.", DIA_Addon_Greg_NW_was_Diego);
	if ((Bdt13_Dexter_verraten == TRUE) || (Ranger_SCKnowsDexter == TRUE))
	{
		Info_AddChoice (DIA_Addon_Greg_NW_was, "Is his name maybe Dexter?", DIA_Addon_Greg_NW_was_Dexter);
	};
	Info_AddChoice (DIA_Addon_Greg_NW_was, "I don't know anyone who meets that description.", DIA_Addon_Greg_NW_was_no);
};

func void DIA_Addon_Greg_NW_was_GregUnsicher()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_GregUnsicher_01_00");	//It could be that that's his name. I'm not sure.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_GregUnsicher_01_01");	//I'll probably only know when I see him.
};

func void DIA_Addon_Greg_NW_was_UnNun()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_UnNun_15_00");	//Anything else?
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_UnNun_01_01");	//(angry) Yeah, you big mouth. There is something else.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_UnNun_01_02");	//I need weapons. I need provisions. Gold wouldn't be bad either.
	Info_ClearChoices(DIA_Addon_Greg_NW_was);
	Info_AddChoice(DIA_Addon_Greg_NW_was,"I can't help you.",DIA_Addon_Greg_NW_was_NoHelp);
	Info_AddChoice(DIA_Addon_Greg_NW_was,"Provisions? You're in a tavern.",DIA_Addon_Greg_NW_was_Orlan);
	Info_AddChoice(DIA_Addon_Greg_NW_was,"Weapons? The mercenaries have weapons.",DIA_Addon_Greg_NW_was_SLD);
	if(Npc_HasItems(other,ItMi_Gold) < 10)
	{
		Info_AddChoice(DIA_Addon_Greg_NW_was,"I just realized I haven't got ten gold pieces left.",DIA_Addon_Greg_NW_was_HierGold);
	}
	else
	{
		Info_AddChoice(DIA_Addon_Greg_NW_was,"Here's 10 gold coins.",DIA_Addon_Greg_NW_was_HierGold);
	};
	Info_AddChoice(DIA_Addon_Greg_NW_was,"Didn't you find a weapons dealer in the city?",DIA_Addon_Greg_NW_was_Waffenhaendler);
	Info_AddChoice(DIA_Addon_Greg_NW_was,"Gold? We all want gold.",DIA_Addon_Greg_NW_was_Gold);
};

func void DIA_Addon_Greg_NW_was_NoHelp()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_NoHelp_15_00");	//I can't help you.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_NoHelp_01_01");	//(angry) Oh. You don't WANT to.
	if ((MIS_Addon_Greg_BringMeToTheCity == LOG_Running) || (MIS_Addon_Greg_BringMeToTheCity == LOG_FAILED))
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_was_NoHelp_01_02");	//This is the second time you've left me hanging.
		AI_Output (self, other, "DIA_Addon_Greg_NW_was_NoHelp_01_03");	//Let me give you some good advice: Be careful that we don't meet again.
		Greg_NoHelpInNW = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Greg_NW_was_NoHelp_01_04");	//I'll remember that. You can count on it.
		Greg_NoHelpInNW_Cave = TRUE;
	};
	MIS_Addon_Greg_RakeCave = LOG_OBSOLETE;
	GregLocation = Greg_Bigcross;
	AI_StopProcessInfos(self);
	AI_UseMob(self,"BENCH",-1);
	Npc_ExchangeRoutine(self,"Bigcross");
	B_StartOtherRoutine(BAU_974_Bauer,"Start");
};

func void DIA_Addon_Greg_NW_was_Gold()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_Gold_15_00");	//Gold? We all want gold.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_Gold_01_01");	//Could be. And what would you do with it? Drink your way through it in the tavern or blow it in the brothel if I'm any judge.
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_Gold_15_02");	//And you have a better plan, eh?
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_Gold_01_03");	//(angry) You would crawl under a rock if you knew all I've done.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_Gold_01_04");	//So none of that cheek, or I'll shut your big mouth for you.
};

func void DIA_Addon_Greg_NW_was_Waffenhaendler()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_Waffenhaendler_15_00");	//Didn't you find a weapons dealer in the city?
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_Waffenhaendler_01_01");	//You can't be serious! They only have junk.
};

func void DIA_Addon_Greg_NW_was_HierGold()
{
	if(Npc_HasItems(other,ItMi_Gold) < 10)
	{
		DIA_Common_NotEven10Gold();
	}
	else
	{
		AI_Output(other,self,"DIA_Addon_Greg_NW_was_HierGold_15_00");	//Here's 10 gold coins.
	};
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_HierGold_01_01");	//(laughs) You poor sucker, you can keep your dough. I have a better idea.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_HierGold_01_02");	//There's a cave not far from here! I've been around here before, and I buried my stuff in a few places.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_HierGold_01_03");	//The cave is too dangerous for me alone. I want you to help me with it.
	Log_CreateTopic(TOPIC_Addon_Greg_NW,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_Greg_NW,LOG_Running);
	B_LogEntry(TOPIC_Addon_Greg_NW,"I offered gold to the man with the eyepatch but he doesn't want it. I'm supposed to follow him to his cave.");
	MIS_Addon_Greg_RakeCave = LOG_Running;
	Info_ClearChoices(DIA_Addon_Greg_NW_was);
};

func void DIA_Addon_Greg_NW_was_SLD()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_SLD_15_00");	//Weapons? The mercenaries have weapons.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_SLD_01_01");	//Interesting. I heard that the fat farmer Onar had hired the boys.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_SLD_01_02");	//(laughs) Not too bad for a landlubber.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_SLD_01_03");	//Not a bad idea. Maybe I really should pay them a visit.
};

func void DIA_Addon_Greg_NW_was_Orlan()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_Orlan_15_00");	//Provisions? You're in a tavern.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_Orlan_01_01");	//The stupid barman won't hand anything over unless you pay him for it.
};

func void DIA_Addon_Greg_NW_was_no()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_no_15_00");	//I don't know anyone who meets that description.
	AI_Output (self, other, "DIA_Addon_Greg_NW_was_no_01_01");	//I might have known.
	DIA_Addon_Greg_NW_was_UnNun ();
};

func void DIA_Addon_Greg_NW_was_Diego()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_Diego_15_00");	//You're talking about Diego.
	DIA_Addon_Greg_NW_was_GregUnsicher ();
	DIA_Addon_Greg_NW_was_UnNun ();
};

func void DIA_Addon_Greg_NW_was_Dexter()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_was_Dexter_15_00");	//Is his name maybe Dexter?
	DIA_Addon_Greg_NW_was_GregUnsicher ();
	DIA_Addon_Greg_NW_was_UnNun ();
};


instance DIA_Addon_Greg_NW_RakeCaveLos(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_RakeCaveLos_Condition;
	information = DIA_Addon_Greg_NW_RakeCaveLos_Info;
	description = "Let's visit the cave.";
};


func int DIA_Addon_Greg_NW_RakeCaveLos_Condition()
{
	if((MIS_Addon_Greg_RakeCave == LOG_Running) && (GregLocation >= Greg_Taverne) && (GregLocation < Greg_Dexter))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_RakeCaveLos_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_RakeCaveLos_15_00");	//Let's visit the cave.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCaveLos_01_01");	//Come with me.
	AI_StopProcessInfos (self);
	AI_UseMob (self, "BENCH", -1);
	Npc_ExchangeRoutine (self, "RakeCave");
};

func void B_Greg_GoNow()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCaveThere_01_03");	//(commanding) What are you waiting for? Go inside and get the stuff.
};


instance DIA_Addon_Greg_NW_RakeCaveThere(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_RakeCaveThere_Condition;
	information = DIA_Addon_Greg_NW_RakeCaveThere_Info;
	important = TRUE;
};


func int DIA_Addon_Greg_NW_RakeCaveThere_Condition()
{
	if((MIS_Addon_Greg_RakeCave == LOG_Running) && (GregLocation >= Greg_Taverne) && (GregLocation < Greg_Dexter) && (Npc_GetDistToWP(self,"NW_BIGFARM_LAKE_CAVE_01") < 1000))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_RakeCaveThere_Info()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCaveThere_01_00");	//All right, friend. Here's the cave.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCaveThere_01_01");	//And here's a pick for you.
	AI_WaitTillEnd(other,self);
	B_GiveInvItems(self,other,ItMw_2H_Axe_L_01,1);
	AI_Output(self,other,"DIA_Addon_Greg_NW_RakeCaveThere_01_02");	//I buried the stuff somewhere in there. X marks the spot.
	B_Greg_GoNow();
	AI_Output(other,self,"DIA_Addon_Greg_NW_RakeCaveThere_15_04");	//What about you, then?
	AI_Output(self,other,"DIA_Addon_Greg_NW_RakeCaveThere_01_05");	//Someone has to guard our backs. And now, in you go.
	Log_CreateTopic(TOPIC_Addon_Greg_NW,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_Greg_NW,LOG_Running);
	B_LogEntry(TOPIC_Addon_Greg_NW,"The fellow wants me to search the cave for his stuff. He buried it and marked the spot with a cross. He gave me a pick for my search.");
	MIS_Addon_Greg_RakeCave_Day = Wld_GetDay();
};


instance DIA_Addon_Greg_NW_RakeCavePlundered(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_RakeCavePlundered_Condition;
	information = DIA_Addon_Greg_NW_RakeCavePlundered_Info;
	important = TRUE;
};


func int DIA_Addon_Greg_NW_RakeCavePlundered_Condition()
{
	if(((MIS_Addon_Greg_RakeCave_Day <= (Wld_GetDay() - 2)) || (RAKEPLACE[1] == TRUE)) && (MIS_Addon_Greg_RakeCave == LOG_Running) && (GregLocation >= Greg_Taverne) && (GregLocation < Greg_Dexter) && (Npc_GetDistToWP(self,"NW_BIGFARM_LAKE_CAVE_01") < 1000))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_RakeCavePlundered_Info()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCavePlundered_01_00");	//What took you so long? Found anything yet?
	if (RAKEPLACE[1] == TRUE)
	{
		Info_AddChoice (DIA_Addon_Greg_NW_RakeCavePlundered, "Yes. I dug up a small bag of gold.", DIA_Addon_Greg_NW_RakeCavePlundered_gold);
	};
	Info_AddChoice (DIA_Addon_Greg_NW_RakeCavePlundered, "No.", DIA_Addon_Greg_NW_RakeCavePlundered_No);
};

func void DIA_Addon_Greg_NW_RakeCavePlundered_No()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_RakeCavePlundered_No_15_00");	//No.
	if (RAKEPLACE[1] == TRUE)
	{
		DIA_Common_01_AreYouTryingToPissMeOff();
		AI_Output(other,self,"DIA_Addon_Greg_NW_RakeCavePlundered_No_15_02");	//(acting innocent) There was nothing THERE.
	};
	AI_Output(self,other,"DIA_Addon_Greg_NW_RakeCavePlundered_No_01_03");	//Damnit. I knew it. Those vultures were faster than me - again.
	AI_Output(self,other,"DIA_Addon_Greg_NW_RakeCavePlundered_No_01_04");	//Oh well. Never mind, kiddo. Gotta go. Catch you later.
	AI_StopProcessInfos(self);
	MIS_Addon_Greg_RakeCave = LOG_OBSOLETE;
	GregLocation = Greg_Bigcross;
	Npc_ExchangeRoutine(self,"Bigcross");
	B_StartOtherRoutine(BAU_974_Bauer,"Start");
};


var int B_Greg_RakePlaceBriefing_OneTime;

func void B_Greg_RakePlaceBriefing()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakePlaceBriefing_01_00");	//Let's see. There's an islet in the small lake with the two waterfalls. One of my caches should be there.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakePlaceBriefing_01_01");	//There are two more spots where I buried something further up, in the high pastures.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakePlaceBriefing_01_02");	//One spot is behind the farm up there, and the other one's next to the entrance to the pass by the waterfalls.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakePlaceBriefing_01_03");	//There are stairs leading down from the fields of the farmer up there to those of the landowner.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakePlaceBriefing_01_04");	//There's another cache in the hollow where the stairs end.
	if (B_Greg_RakePlaceBriefing_OneTime == FALSE)
	{
		B_LogEntry(TOPIC_Addon_Greg_NW,"There is more than one place where he buried something:");
		Log_AddEntry(TOPIC_Addon_Greg_NW,"1) On the small island in the lake with the two waterfalls.");
		Log_AddEntry(TOPIC_Addon_Greg_NW,"2) Up on the high pastures behind the farm.");
		Log_AddEntry(TOPIC_Addon_Greg_NW,"3) Next to the entrance to the pass by the waterfalls.");
		Log_AddEntry(TOPIC_Addon_Greg_NW,"4) In the hollow below the stairs from that lead from the farmer's fields on the high pastures to those of the landowner.");
		Log_AddEntry(TOPIC_Addon_Greg_NW,"I'm supposed to get the buried stuff for him. He will wait for me at the crossroads between the fields.");
		B_Greg_RakePlaceBriefing_OneTime = TRUE;
	};
};

func void DIA_Addon_Greg_NW_RakeCavePlundered_gold()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_15_00");	//Yes. I dug up a small bag of gold.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_01_01");	//(greedily) Give it here.
	if (Npc_HasItems (other, ItSe_GoldPocket25) || (Npc_HasItems (other, ItMi_Gold) >= 25))
	{
		if(B_GiveInvItems(other,self,ItSe_GoldPocket25,1))
		{
			DIA_Common_TakeIt();
		}
		else if(B_GiveInvItems(other,self,ItMi_Gold,25))
		{
			AI_Output (other, self, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_15_03");	//There were 25 gold pieces in it. Here, take them.
		};
		AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_01_04");	//Great. So they're still there.
		AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_01_05");	//You're not all that useless after all.
		AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_01_06");	//Okay, listen. I've buried even more. And I want you to get it for me.
		B_Greg_RakePlaceBriefing ();
		Greg_SuchWeiter = TRUE;
		AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_01_07");	//I'll wait for you at the crossroads by the landowner's fields. Don't fail me. You'd regret that, buster.
		AI_StopProcessInfos (self);
		GregLocation = Greg_Bigcross;
		Npc_ExchangeRoutine(self,"Bigcross");
		B_GivePlayerXP(XP_Addon_RakeCavePlundered);
	}
	else
	{
		AI_Output (other, self, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_15_08");	//I don't have it any more.
		AI_Output (self, other, "DIA_Addon_Greg_NW_RakeCavePlundered_gold_01_09");	//Bullshit. Do I have to beat it out of you, then?
		AI_StopProcessInfos (self);
		MIS_Addon_Greg_RakeCave = LOG_FAILED;
		GregLocation = Greg_Bigcross;
		Npc_ExchangeRoutine(self,"Bigcross");
		B_Attack(self,other,AR_NONE,1);
	};
};


instance DIA_Addon_Greg_NW_LakeCave(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 100;
	condition = DIA_Addon_Greg_NW_LakeCave_Condition;
	information = DIA_Addon_Greg_NW_LakeCave_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Addon_Greg_NW_LakeCave_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (MIS_Addon_Greg_RakeCave == LOG_Running) && (GregLocation >= Greg_Taverne) && (GregLocation < Greg_Dexter) && (Npc_GetDistToWP(self,"NW_BIGFARM_LAKE_CAVE_01") < 1000) && (Greg_SuchWeiter == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_LakeCave_Info()
{
	B_Greg_GoNow();
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Greg_NW_WhereTreasures(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 10;
	condition = DIA_Addon_Greg_NW_WhereTreasures_Condition;
	information = DIA_Addon_Greg_NW_WhereTreasures_Info;
	permanent = TRUE;
	description = "Where exactly did you bury your stuff again?";
};


func int DIA_Addon_Greg_NW_WhereTreasures_Condition()
{
	if((MIS_Addon_Greg_RakeCave == LOG_Running) && (Greg_SuchWeiter == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_WhereTreasures_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_WhereTreasures_15_00");	//Where exactly did you bury your stuff again?
	B_Greg_RakePlaceBriefing ();
};


instance DIA_Addon_Greg_NW_PermTaverne(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 99;
	condition = DIA_Addon_Greg_NW_PermTaverne_Condition;
	information = DIA_Addon_Greg_NW_PermTaverne_Info;
	permanent = TRUE;
	description = "One more thing...";
};


func int DIA_Addon_Greg_NW_PermTaverne_Condition()
{
	if(((GregLocation == Greg_Bigcross) && !Npc_KnowsInfo(other,DIA_Addon_Greg_NW_Bigcross) && ((Npc_GetDistToWP(self,"BIGCROSS") >= 1000) || (MIS_Addon_Greg_RakeCave == LOG_SUCCESS))) || ((GregLocation == Greg_Dexter) && Npc_KnowsInfo(other,DIA_Addon_Greg_NW_WasWillstDu)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_PermTaverne_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_PermTaverne_15_00");	//One more thing ...
	if ((MIS_Addon_Greg_RakeCave == LOG_Running) && (Greg_SuchWeiter == TRUE))
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_PermTaverne_01_01");	//First, get me the stuff I buried. Then we can talk.
	}
	else if(MIS_Addon_Greg_RakeCave == LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_PermTaverne_01_02");	//I'm grateful that you helped me. But that doesn't make us friends, if you get my drift.
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_PermTaverne_01_03");	//We've been gabbing too much already.
	};
};


instance DIA_Addon_Greg_NW_Bigcross(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_Bigcross_Condition;
	information = DIA_Addon_Greg_NW_Bigcross_Info;
	description = "How are things?";
};


func int DIA_Addon_Greg_NW_Bigcross_Condition()
{
	if((GregLocation == Greg_Bigcross) && (Npc_GetDistToWP(self,"BIGCROSS") < 1000))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_Bigcross_Info()
{
	AI_Output(other,self,"DIA_Addon_Greg_NW_Bigcross_15_01");	//How are things?
	if((MIS_Addon_Greg_BringMeToTheCity == LOG_FAILED) || (MIS_Addon_Greg_RakeCave == LOG_FAILED))
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_Bigcross_01_00");	//Look, if it ain't Mr. Unreliable.
	};
	AI_Output (self, other, "DIA_Addon_Greg_NW_Bigcross_01_02");	//So-so. Those mercenaries aren't much help, really.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Bigcross_01_03");	//I had expected them to have a little more guts at least.
	AI_Output (self, other, "DIA_Addon_Greg_NW_Bigcross_01_04");	//But they're just a bunch of braggarts and loudmouths, if you ask me.
	if((MIS_Addon_Greg_RakeCave == LOG_Running) && (Greg_SuchWeiter == TRUE))
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_Bigcross_01_05");	//So what about those things I buried? Have you found them yet?
		if ((RAKEPLACE[1] == FALSE) || (RAKEPLACE[2] == FALSE) || (RAKEPLACE[3] == FALSE) || (RAKEPLACE[4] == FALSE) || (RAKEPLACE[5] == FALSE))
		{
			AI_Output (other, self, "DIA_Addon_Greg_NW_Bigcross_15_06");	//No, not all of them.
			AI_Output (self, other, "DIA_Addon_Greg_NW_Bigcross_01_07");	//Then hurry up, will you? It can't be all that difficult.
		};
	};
};


instance DIA_Addon_Greg_NW_WhatWantFromSLD(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_WhatWantFromSLD_Condition;
	information = DIA_Addon_Greg_NW_WhatWantFromSLD_Info;
	description = "What was your business with the mercenaries?";
};


func int DIA_Addon_Greg_NW_WhatWantFromSLD_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Greg_NW_Bigcross) && (GregLocation == Greg_Bigcross) && (Npc_GetDistToWP(self,"BIGCROSS") < 1000))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_WhatWantFromSLD_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_WhatWantFromSLD_15_00");	//What was your business with the mercenaries?
	if (SC_KnowsGregsSearchsDexter == FALSE)
	{
		B_Greg_Search_Dexter();
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Greg_NW_WhatWantFromSLD_01_01");	//I already told you. I'm looking for this fellow in red armor.
		AI_Output (self, other, "DIA_Addon_Greg_NW_WhatWantFromSLD_01_02");	//But the idiots here have no idea what I'm talking about.
	};
};


instance DIA_Addon_Greg_NW_DexterFound(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_DexterFound_Condition;
	information = DIA_Addon_Greg_NW_DexterFound_Info;
	description = "I take it you're looking for someone named Dexter.";
};


func int DIA_Addon_Greg_NW_DexterFound_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Addon_Greg_NW_Bigcross) && (GregLocation == Greg_Bigcross) && ((Bdt13_Dexter_verraten == TRUE) || (Ranger_SCKnowsDexter == TRUE)))
	if((SC_KnowsGregsSearchsDexter == TRUE) && ((Bdt13_Dexter_verraten == TRUE) || (Ranger_SCKnowsDexter == TRUE)) && !Npc_KnowsInfo(other,DIA_Addon_Greg_NW_CaughtDexter2))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_DexterFound_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_DexterFound_15_00");	//I take it you're looking for someone named Dexter.
	if(GregLocation == Greg_Dexter)
	{
		DIA_Common_01_AreYouTryingToPissMeOff();
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Greg_NW_DexterFound_01_01");	//Damnit. How would I know the fellow's name?
		Info_ClearChoices(DIA_Addon_Greg_NW_DexterFound);
		Info_AddChoice(DIA_Addon_Greg_NW_DexterFound,"It was just a thought.",DIA_Addon_Greg_NW_DexterFound_weg);
		Info_AddChoice(DIA_Addon_Greg_NW_DexterFound,"Maybe we should go see him together?",DIA_Addon_Greg_NW_DexterFound_together);
		Info_AddChoice(DIA_Addon_Greg_NW_DexterFound,"I know where you can find him.",DIA_Addon_Greg_NW_DexterFound_wo);
	};
};

func void DIA_Addon_Greg_NW_DexterFound_weg()
{
	AI_Output(other,self,"DIA_Addon_Greg_NW_DexterFound_weg_15_00");	//It was just a thought.
	Greg_Rejected = TRUE;
	Info_ClearChoices(DIA_Addon_Greg_NW_DexterFound);
};

func void DIA_Addon_Greg_NW_DexterFound_together()
{
	DIA_Common_LetsGoTogether();
	AI_Output(self,other,"DIA_Addon_Greg_NW_DexterFound_together_01_01");	//I've still got a bone to pick with him. I can handle that by myself.
};

func void DIA_Addon_Greg_NW_DexterFound_wo()
{
	AI_Output(other,self,"DIA_Addon_Greg_NW_DexterFound_together_15_00");	//Maybe we should go see him together?
	AI_Output(self,other,"DIA_Addon_Greg_NW_DexterFound_wo_01_01");	//(surprised) Really? TELL ME!
	if(GregLocation == Greg_Bigcross)
	{
		AI_Output(other,self,"DIA_Addon_Greg_NW_DexterFound_wo_15_02");	//Not far from here.
	}
	else
	{
		AI_Output(other,self,"DIA_Rosi_Hc");	//I'll bring you to the landowner's farm.
		AI_Output(self,other,"DIA_Addon_Greg_NW_PERM_01_01");	//arrogantly) Listen, kid. I've got important things to do right now.
	};
	AI_Output(other,self,"DIA_Addon_Greg_NW_DexterFound_wo_15_03");	//He seems to be the leader of an evil gang of bandits.
	AI_Output(self,other,"DIA_Addon_Greg_NW_DexterFound_wo_01_04");	//(sneering) HAH. Yep. That's him.
	if(GregLocation == Greg_Bigcross)
	{
		AI_Output(self,other,"DIA_Addon_Greg_NW_DexterFound_wo_01_05");	//I knew the old landlubber had holed up here somewhere.
	};
	AI_Output (self, other, "DIA_Addon_Greg_NW_DexterFound_wo_01_06");	//Now all I need to do is scour all the hideouts and ratholes around here.
	AI_Output (self, other, "DIA_Addon_Greg_NW_DexterFound_wo_01_07");	//I'll find that bastard - don't need your help for that.
	Info_ClearChoices(DIA_Addon_Greg_NW_DexterFound);
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Addon_Greg_NW_CaughtDexter(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_CaughtDexter_Condition;
	information = DIA_Addon_Greg_NW_CaughtDexter_Info;
	important = TRUE;
};


func int DIA_Addon_Greg_NW_CaughtDexter_Condition()
{
	if((GregLocation == Greg_Dexter) && !Npc_IsDead(Dexter))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_CaughtDexter_Info()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_CaughtDexter_01_00");	//(loudly) Where is that swine?
	AI_Output (other, self, "DIA_Addon_Greg_NW_CaughtDexter_15_01");	//Who? The captain? He's right here.
	AI_Output (self, other, "DIA_Addon_Greg_NW_CaughtDexter_01_02");	//(loudly) Then get out of my way.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "DexterHouseRun");
};


instance DIA_Addon_Greg_NW_WodennNu(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_WodennNu_Condition;
	information = DIA_Addon_Greg_NW_WodennNu_Info;
	important = TRUE;
};


func int DIA_Addon_Greg_NW_WodennNu_Condition()
{
	if((GregLocation == Greg_Dexter) && !Npc_IsDead(Dexter) && (Npc_GetDistToWP(self,"NW_CASTLEMINE_HUT_10") < 500))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_WodennNu_Info()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_WodennNu_01_00");	//(angrily) Now where did he go?
	AI_Output (other, self, "DIA_Addon_Greg_NW_WodennNu_15_01");	//He was here.
	AI_Output (self, other, "DIA_Addon_Greg_NW_WodennNu_01_02");	//(commanding) Well, go and find him then!
	AI_StopProcessInfos (self);
};


instance DIA_Addon_Greg_NW_CaughtDexter2(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_CaughtDexter2_Condition;
	information = DIA_Addon_Greg_NW_CaughtDexter2_Info;
	important = TRUE;
};


func int DIA_Addon_Greg_NW_CaughtDexter2_Condition()
{
	if((GregLocation == Greg_Dexter) && Npc_IsDead(Dexter))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_CaughtDexter2_Info()
{
	AI_Output (self, other, "DIA_Addon_Greg_NW_CaughtDexter2_01_00");	//Ah. Dexter has bought it, right?
	AI_Output (other, self, "DIA_Addon_Greg_NW_CaughtDexter2_15_01");	//Looks like he's dead.
	AI_Output (self, other, "DIA_Addon_Greg_NW_CaughtDexter2_01_02");	//None too soon, either. Go check out what he's got on him.
	Npc_ExchangeRoutine(self,"DexterHouseWalk");
	B_GivePlayerXP(XP_Ambient);
};


func void B_GregTalksAboutPortal()
{
	if(Greg_KnowsPortal == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_Greg_NW_RavensLetter_01_04");	//You wouldn't happen to know how to cross those mountains in the north-east of Khorinis?
		if(SC_KnowsPortal == TRUE)
		{
			AI_Output(other,self,"DIA_Addon_Greg_NW_RavensLetter_15_05");	//Maybe through an underground tunnel. The Water Mages are currently studying a portal which leads to the mountains in the north-east.
			AI_Output (self, other, "DIA_Addon_Greg_NW_RavensLetter_01_06");	//(angrily) What's this nonsense?
			AI_Output (self, other, "DIA_Addon_Greg_NW_RavensLetter_01_07");	//(mockingly) Bah. Water Mages. Can't you come up with something better?
		};
	AI_Output (other, self, "DIA_Addon_Greg_NW_RavensLetter_15_08");	//No.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RavensLetter_01_09");	//(with a resigned sigh) So I'm stranded here.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RavensLetter_01_10");	//Dexter was my last hope.
		Greg_KnowsPortal = TRUE;
	};
};


instance DIA_Addon_Greg_NW_RavensLetter(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_RavensLetter_Condition;
	information = DIA_Addon_Greg_NW_RavensLetter_Info;
	description = "Dexter carried nothing but this letter.";
};


func int DIA_Addon_Greg_NW_RavensLetter_Condition()
{
	if((GregLocation == Greg_Dexter) && Npc_KnowsInfo(other,DIA_Addon_Greg_NW_CaughtDexter2) && Npc_HasItems(other,ItWr_RavensKidnapperMission_Addon) && Npc_IsDead(Dexter))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_RavensLetter_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_RavensLetter_15_00");	//Dexter carried nothing but this letter.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RavensLetter_01_01");	//Show me that thing.
	AI_PrintScreen("Given: Orders",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	B_UseFakeScroll();
	AI_Output (self, other, "DIA_Addon_Greg_NW_RavensLetter_01_02");	//Aw, damnit. That doesn't help me at all.
	AI_Output (self, other, "DIA_Addon_Greg_NW_RavensLetter_01_03");	//We shouldn't have just let him croak like that.
	B_GregTalksAboutPortal();
	AI_PrintScreen("Received: Orders",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
};


instance DIA_Addon_Greg_NW_WasWillstDu(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_WasWillstDu_Condition;
	information = DIA_Addon_Greg_NW_WasWillstDu_Info;
	description = "What did you want from Dexter?";
};


func int DIA_Addon_Greg_NW_WasWillstDu_Condition()
{
	if((GregLocation == Greg_Dexter) && (Npc_KnowsInfo(other,DIA_Addon_Greg_NW_RavensLetter) || (MIS_Addon_Vatras_WhereAreMissingPeople == LOG_SUCCESS)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_WasWillstDu_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_WasWillstDu_15_00");	//What did you want from Dexter?
	AI_Output (self, other, "DIA_Addon_Greg_NW_WasWillstDu_01_01");	//I've come from beyond the mountains in the north-east of this island. And I want to go back.
	AI_Output (self, other, "DIA_Addon_Greg_NW_WasWillstDu_01_02");	//I had hoped that the bastard would know how to get there without a ship.
	B_GregTalksAboutPortal();
	Npc_ExchangeRoutine(self,"DexterThrone");
};

instance DIA_Addon_Greg_NW_Loc(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_Loc_Condition;
	information = DIA_Addon_Greg_NW_Loc_Info;
	description = "What is there beyond those mountains?";
};


func int DIA_Addon_Greg_NW_Loc_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Greg_NW_WasWillstDu))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_Loc_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_WasWillstDu_da_15_00");	//What is there beyond those mountains?
	AI_Output (self, other, "DIA_Addon_Greg_NW_WasWillstDu_da_01_01");	//You had better not try to go there.
	AI_Output (self, other, "DIA_Addon_Greg_NW_WasWillstDu_da_01_02");	//Those are rough lands. A wimp like you wouldn't last long.
};

instance DIA_Addon_Greg_NW_Skip(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 6;
	condition = DIA_Addon_Greg_NW_Skip_Condition;
	information = DIA_Addon_Greg_NW_Skip_Info;
	description = "I saw a pirate named Skip near the port.";
};


func int DIA_Addon_Greg_NW_Skip_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Greg_NW_WasWillstDu) && (PlayerTalkedToSkipNW == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_Skip_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_WasWillstDu_Skip_15_00");	//I saw a pirate named Skip near the port.
	AI_Output (self, other, "DIA_Addon_Greg_NW_WasWillstDu_Skip_01_01");	//That moron. I waited there for 3 days. So why's he coming so late?
	AI_Output (self, other, "DIA_Addon_Greg_NW_WasWillstDu_Skip_01_02");	//Once I get my strength back, I'll give him what for.
	SC_KnowsConnectionSkipGreg = TRUE;
	B_GivePlayerXP(XP_Ambient);
};

func int C_SCHasGregItems()
{
	if((Npc_HasItems(other,ItSe_GoldPocket100) || (Npc_HasItems(other,ItMi_Gold) >= 100)) && Npc_HasItems(other,ItMi_GoldCup) && Npc_HasItems(other,ItMi_SilverChalice) && Npc_HasItems(other,ItAm_Addon_Greg))
	{
		return TRUE;
	};
	return FALSE;
};

func void B_GiveGregItems()
{
	AI_Output(other,self,"DIA_Addon_Greg_NW_FoundTreasure_ja_15_00");	//Here's your stuff.
	if(B_GiveInvItems(other,self,ItSe_GoldPocket100,1))
	{
		AI_Output(other,self,"DIA_Addon_Greg_NW_FoundTreasure_ja_15_01");	//A bag with 100 gold coins.
	}
	else if(B_GiveInvItems(other,self,ItMi_Gold,100))
	{
		AI_Output(other,self,"DIA_Addon_Greg_NW_FoundTreasure_ja_15_02");	//100 gold coins.
	};
	B_GiveInvItems(other,self,ItMi_GoldCup,1);
	AI_Output(other,self,"DIA_Addon_Greg_NW_FoundTreasure_ja_15_03");	//A golden chalice.
	B_GiveInvItems(other,self,ItMi_SilverChalice,1);
	AI_Output(other,self,"DIA_Addon_Greg_NW_FoundTreasure_ja_15_04");	//A silver dish.
	B_GiveInvItems(other,self,ItAm_Addon_Greg,1);
	AI_Output(other,self,"DIA_Addon_Greg_NW_FoundTreasure_ja_15_05");	//And an amulet.
	AI_Output(self,other,"DIA_Addon_Greg_NW_FoundTreasure_ja_01_06");	//Very good. You're lucky that you weren't dumb enough to simply take the stuff and run.
	MIS_Addon_Greg_RakeCave = LOG_SUCCESS;
};


instance DIA_Addon_Greg_NW_FoundTreasure(C_Info)
{
	npc = PIR_1300_Addon_Greg_NW;
	nr = 5;
	condition = DIA_Addon_Greg_NW_FoundTreasure_Condition;
	information = DIA_Addon_Greg_NW_FoundTreasure_Info;
	permanent = TRUE;
	description = "I found your buried things.";
};


func int DIA_Addon_Greg_NW_FoundTreasure_Condition()
{
	if((RAKEPLACE[1] == TRUE) && (RAKEPLACE[2] == TRUE) && (RAKEPLACE[3] == TRUE) && (RAKEPLACE[4] == TRUE) && (RAKEPLACE[5] == TRUE) && (MIS_Addon_Greg_RakeCave == LOG_Running) && (Greg_SuchWeiter == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Greg_NW_FoundTreasure_Info()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_FoundTreasure_15_00");	//I found your buried things.
	AI_Output (self, other, "DIA_Addon_Greg_NW_FoundTreasure_01_01");	//Then you should be carrying about 100 gold coins, a golden chalice, a silver dish and an amulet, and they're all mine. Give them here.
	Info_ClearChoices (DIA_Addon_Greg_NW_FoundTreasure);
	Info_AddChoice (DIA_Addon_Greg_NW_FoundTreasure, "I don't happen to have it on me.", DIA_Addon_Greg_NW_FoundTreasure_not);
	if(C_SCHasGregItems())
	{
		Info_AddChoice (DIA_Addon_Greg_NW_FoundTreasure, "Here's your stuff.", DIA_Addon_Greg_NW_FoundTreasure_ja);
	};
};

func void DIA_Addon_Greg_NW_FoundTreasure_ja()
{
	B_GiveGregItems();
	AI_Output(self,other,"DIA_Addon_Greg_NW_FoundTreasure_ja_01_07");	//Here's your stuff.
	B_GiveInvItems(self,other,ItMi_Gold,30);
	Info_ClearChoices(DIA_Addon_Greg_NW_FoundTreasure);
	B_GivePlayerXP(XP_Addon_Greg_RakeCave);
};

func void DIA_Addon_Greg_NW_FoundTreasure_not()
{
	AI_Output (other, self, "DIA_Addon_Greg_NW_FoundTreasure_not_15_00");	//I don't happen to have it on me.
	AI_Output (self, other, "DIA_Addon_Greg_NW_FoundTreasure_not_01_01");	//Then get me those things before I get mad.
	AI_StopProcessInfos(self);
};

