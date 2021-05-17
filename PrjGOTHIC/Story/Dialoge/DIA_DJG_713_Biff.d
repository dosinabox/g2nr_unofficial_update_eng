
func void B_KommMit()
{
	AI_Output (other, self, "DIA_AkilsSchaf_KommMit_15_00");	//Come with me!
};

func void B_Biff_Verarschen()
{
	AI_Output (self, other, "DIA_Biff_ARBEITEN_lebenlassen_07_01");	//I don't need you to make a fool out of myself.
};

func void B_BiffsAnteil_Berechnung()
{
	var int momentanKohle;
	var int UeberschussKohle;
	momentanKohle = Npc_HasItems(hero,ItMi_Gold);
	UeberschussKohle = momentanKohle - DJG_Biff_SCGold;
	BiffsAnteil = UeberschussKohle / 2;
};

func void B_BiffsAnteil_PrintScreen()
{
	var string BiffsAnteilText_Teil;
	var string BiffsAnteilText;
	var string Anteil;
	Anteil = IntToString(BiffsAnteil);
	BiffsAnteilText_Teil = ConcatStrings(PRINT_BiffsAnteil,Anteil);
	BiffsAnteilText = ConcatStrings(BiffsAnteilText_Teil,PRINT_Gold);
	AI_PrintScreen(BiffsAnteilText,-1,45,FONT_ScreenSmall,4);
};

func void B_Biff_SetRefuseTalk()
{
	if(DJG_Biff_HalbeHalbe == TRUE)
	{
		Npc_SetRefuseTalk(Biff,1000);
	}
	else
	{
		Npc_SetRefuseTalk(Biff,600);
	};
};


instance DIA_Biff_EXIT(C_Info)
{
	npc = DJG_713_Biff;
	nr = 999;
	condition = DIA_Biff_EXIT_Condition;
	information = DIA_Biff_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Biff_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Biff_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Biff_HALLO(C_Info)
{
	npc = DJG_713_Biff;
	nr = 5;
	condition = DIA_Biff_HALLO_Condition;
	information = DIA_Biff_HALLO_Info;
	description = "What are you doing here?";
};


func int DIA_Biff_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Biff_HALLO_Info()
{
	AI_Output (other, self, "DIA_Biff_HALLO_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Biff_HALLO_07_01");	//That is truly the stupidest question I have heard in a long time. What does it look like?
	Info_AddChoice (DIA_Biff_HALLO, "I can't tell anything from that idiotic face you're making.", DIA_Biff_HALLO_spott);
	Info_AddChoice (DIA_Biff_HALLO, "I haven't a clue.", DIA_Biff_HALLO_keineAhnung);
	Info_AddChoice (DIA_Biff_HALLO, "Never mind.", DIA_Biff_HALLO_doof);
};

func void DIA_Biff_HALLO_doof()
{
	AI_Output (other, self, "DIA_Biff_HALLO_doof_15_00");	//Never mind.
	Info_ClearChoices (DIA_Biff_HALLO);
};

func void DIA_Biff_HALLO_spott()
{
	AI_Output (other, self, "DIA_Biff_HALLO_spott_15_00");	//I can't tell anything from that idiotic face you're making. That's why I have to ask.
	AI_Output (self, other, "DIA_Biff_HALLO_spott_07_01");	//You're mouth is too big for my taste. It's time somebody shut it for you.
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
	DJG_BiffParty_nomore += 1;
};

func void DIA_Biff_HALLO_keineAhnung()
{
	AI_Output (other, self, "DIA_Biff_HALLO_keineAhnung_15_00");	//I haven't a clue.
	AI_Output (self, other, "DIA_Biff_HALLO_keineAhnung_07_01");	//I'm waiting for something to finally happen here.
	Info_AddChoice (DIA_Biff_HALLO, "What do you expect to happen?", DIA_Biff_HALLO_keineAhnung_was);
};

func void DIA_Biff_HALLO_keineAhnung_was()
{
	AI_Output (other, self, "DIA_Biff_HALLO_keineAhnung_was_15_00");	//What do you expect to happen?
	AI_Output (self, other, "DIA_Biff_HALLO_keineAhnung_was_07_01");	//Oh, man, you are really not the sharpest knife in the drawer. If I knew that, I wouldn't have to wait.
	Info_AddChoice (DIA_Biff_HALLO, "What could happen, then?", DIA_Biff_HALLO_keineAhnung_was_was2);
};

func void DIA_Biff_HALLO_keineAhnung_was_was2()
{
	AI_Output (other, self, "DIA_Biff_HALLO_keineAhnung_was_was2_15_00");	//What could happen, then?
	AI_Output (self, other, "DIA_Biff_HALLO_keineAhnung_was_was2_07_01");	//You're getting on my nerves. Look, I don't care what happens. Just as long as something does happen.
	Info_AddChoice (DIA_Biff_HALLO, "Why don't you do something, then?", DIA_Biff_HALLO_keineAhnung_was_was2_was3);
};

func void DIA_Biff_HALLO_keineAhnung_was_was2_was3()
{
	AI_Output (other, self, "DIA_Biff_HALLO_keineAhnung_was_was2_was3_15_00");	//Why don't you do something, then?
	AI_Output (self, other, "DIA_Biff_HALLO_keineAhnung_was_was2_was3_07_01");	//If you don't stop asking stupid questions right now, I'm going to shut your dirty mouth.
	Info_AddChoice (DIA_Biff_HALLO, "If you just wait around here, nothing will ever happen!", DIA_Biff_HALLO_keineAhnung_was_was2_was3_was4);
};

func void DIA_Biff_HALLO_keineAhnung_was_was2_was3_was4()
{
	AI_Output (other, self, "DIA_Biff_HALLO_keineAhnung_was_was2_was3_was4_15_00");	//If you just wait around here, nothing will ever happen!
	AI_Output (self, other, "DIA_Biff_HALLO_keineAhnung_was_was2_was3_was4_07_01");	//That's it!
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
	DJG_BiffParty_nomore += 1;
};


instance DIA_Biff_WASHIERIMTAL(C_Info)
{
	npc = DJG_713_Biff;
	nr = 7;
	condition = DIA_Biff_WASHIERIMTAL_Condition;
	information = DIA_Biff_WASHIERIMTAL_Info;
	description = "What are you hoping to find here in the Valley of Mines?";
};


func int DIA_Biff_WASHIERIMTAL_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Biff_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Biff_WASHIERIMTAL_Info()
{
	AI_Output (other, self, "DIA_Biff_WASHIERIMTAL_15_00");	//What are you hoping to find here in the Valley of Mines?
	AI_Output (self, other, "DIA_Biff_WASHIERIMTAL_07_01");	//Gold and honor. What else? When I'm finished with the dragon, I'll be swimming in gold.
	AI_Output (self, other, "DIA_Biff_WASHIERIMTAL_07_02");	//Enough to spend the rest of my life frequenting every tavern and cathouse in the country.
	if(MIS_SCKnowsWayToIrdorath == TRUE)
	{
		B_LogEntry(Topic_Crew,"The prospect of rich pickings has persuaded Biff to accompany me. As long as he gets enough gold, I can count on him.");
	}
	else
	{
		B_LogEntry(TOPIC_Dragonhunter,"The prospect of rich pickings has persuaded Biff to accompany me. As long as he gets enough gold, I can count on him.");
	};
	Info_AddChoice(DIA_Biff_WASHIERIMTAL,"Well, then, I wish you luck.",DIA_Biff_WASHIERIMTAL_vielglueck);
	Info_AddChoice(DIA_Biff_WASHIERIMTAL,"Either that, or you'll be dead!",DIA_Biff_WASHIERIMTAL_ihrtot);
};

func void DIA_Biff_WASHIERIMTAL_ihrtot()
{
	AI_Output (other, self, "DIA_Biff_WASHIERIMTAL_ihrtot_15_00");	//Either that, or you'll be dead!
	AI_Output (self, other, "DIA_Biff_WASHIERIMTAL_ihrtot_07_01");	//So what? That's part of it. If you want to get rich, you've got to take a few risks.
	Info_ClearChoices (DIA_Biff_WASHIERIMTAL);
};

func void DIA_Biff_WASHIERIMTAL_vielglueck()
{
	AI_Output (other, self, "DIA_Biff_WASHIERIMTAL_vielglueck_15_00");	//Well, then, I wish you luck.
	AI_Output (self, other, "DIA_Biff_WASHIERIMTAL_vielglueck_07_01");	//I don't need luck. Just my axe.
	Info_ClearChoices (DIA_Biff_WASHIERIMTAL);
};


instance DIA_Biff_ARBEITEN(C_Info)
{
	npc = DJG_713_Biff;
	nr = 8;
	condition = DIA_Biff_ARBEITEN_Condition;
	information = DIA_Biff_ARBEITEN_Info;
	permanent = TRUE;
	description = "How would you like to work for me from now on?";
};


func int DIA_Biff_ARBEITEN_Condition()
{
	if((DJG_BiffParty == FALSE) && Npc_KnowsInfo(other,DIA_Biff_WASHIERIMTAL) && (DJG_Biff_Stay == FALSE) && (Biff_IsOnBoard != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Biff_ARBEITEN_Info()
{
	AI_Output(other,self,"DIA_Biff_ARBEITEN_15_00");	//How would you like to work for me from now on?
	if((DJG_BiffParty_nomore >= 6) || (Biff_IsOnBoard == LOG_FAILED))
	{
		AI_Output (self, other, "DIA_Biff_ARBEITEN_07_01");	//We tried that once. Didn't work very well. Thanks, not interested.
		AI_StopProcessInfos (self);
	}
	else
	{
		AI_Output (self, other, "DIA_Biff_ARBEITEN_07_02");	//Mmh. Why not? What are you paying?
	};
	Info_ClearChoices (DIA_Biff_ARBEITEN);
	Info_AddChoice (DIA_Biff_ARBEITEN, "Count yourself lucky if I spare your life.", DIA_Biff_ARBEITEN_lebenlassen);
	Info_AddChoice (DIA_Biff_ARBEITEN, "You'll get half of the booty.", DIA_Biff_ARBEITEN_HalbeHalbe);
	Info_AddChoice (DIA_Biff_ARBEITEN, "I'll pay you 100 gold coins for now.", DIA_Biff_ARBEITEN_100);
};

func void DIA_Biff_ARBEITEN_100()
{
	AI_Output (other, self, "DIA_Biff_ARBEITEN_100_15_00");	//I'll pay you 100 gold coins for now.
	if (B_GiveInvItems (other, self, ItMi_Gold, 100))
	{
		AI_Output (self, other, "DIA_Biff_ARBEITEN_100_07_01");	//All right then. It's a start, anyway. Go ahead. I'll follow you.
		AI_StopProcessInfos (self);
		Npc_ExchangeRoutine (self, "Follow");
		B_Biff_SetRefuseTalk ();
		self.aivar[AIV_PARTYMEMBER] = TRUE;
		DJG_BiffParty = TRUE;
	}
	else
	{
		B_Biff_Verarschen();
		AI_StopProcessInfos(self);
		DJG_BiffParty_nomore += 1;
	};
};

func void DIA_Biff_ARBEITEN_HalbeHalbe()
{
	AI_Output (other, self, "DIA_Biff_ARBEITEN_HalbeHalbe_15_00");	//You'll get half of the booty.
	AI_Output (self, other, "DIA_Biff_ARBEITEN_HalbeHalbe_07_01");	//That sounds good. But I'm warning you, don't try ticking me, or you'll regret it.
	AI_Output (self, other, "DIA_Biff_ARBEITEN_HalbeHalbe_07_02");	//And one more thing, I don't want any weapons or other junk you collect here. I'm only interested in gold, got it?
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Follow");
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	DJG_BiffParty = TRUE;
	DJG_Biff_HalbeHalbe = TRUE;
	B_Biff_SetRefuseTalk();
	if(DJG_Biff_HalbeHalbe_again == FALSE)
	{
		DJG_Biff_SCGold = Npc_HasItems(hero,ItMi_Gold);
		DJG_Biff_HalbeHalbe_again = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Biff_ARBEITEN_HalbeHalbe_07_03");	//But, what am I saying. You already know all that.
	};
};

func void DIA_Biff_ARBEITEN_lebenlassen()
{
	AI_Output(other,self,"DIA_Biff_ARBEITEN_lebenlassen_15_00");	//Count yourself lucky if I spare your life.
	B_Biff_Verarschen();
	AI_StopProcessInfos(self);
	DJG_BiffParty_nomore += 1;
};


var int BIFF_LABERT_GELDEINTREIBEN;

func void B_GiveBiffsAnteil()
{
	AI_Output(self,other,"DIA_Biff_GELDEINTREIBEN_geben_07_01");	//All right. Let's get going.
	AI_StopProcessInfos(self);
	B_GiveInvItems(other,self,ItMi_Gold,BiffsAnteil);
	B_Biff_SetRefuseTalk();
	BIFF_LABERT_GELDEINTREIBEN = FALSE;
	DJG_Biff_SCGold = Npc_HasItems(hero,ItMi_Gold);
};

instance DIA_Biff_GELDEINTREIBEN(C_Info)
{
	npc = DJG_713_Biff;
	nr = 9;
	condition = DIA_Biff_GELDEINTREIBEN_Condition;
	information = DIA_Biff_GELDEINTREIBEN_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Biff_GELDEINTREIBEN_Condition()
{
	if((DJG_Biff_SCGold < (Npc_HasItems(hero,ItMi_Gold) - 1)) && (Npc_GetBodyState(hero) != BS_INVENTORY) && (Npc_GetBodyState(hero) != BS_MOBINTERACT_INTERRUPT) && ((Npc_GetBodyState(hero) != BS_STAND) || (BIFF_LABERT_GELDEINTREIBEN == TRUE)) && ((Npc_GetBodyState(hero) != BS_ITEMINTERACT) || (BIFF_LABERT_GELDEINTREIBEN == TRUE)) && (DJG_Biff_HalbeHalbe == TRUE) && (DJG_BiffParty == TRUE) && (DJG_Biff_Stay == FALSE))
	{
		BIFF_LABERT_GELDEINTREIBEN = TRUE;
		return TRUE;
	};
};

func void DIA_Biff_GELDEINTREIBEN_Info()
{
	AI_Output (self, other, "DIA_Biff_GELDEINTREIBEN_07_00");	//Wait a minute! Didn't you say half the booty belonged to me? Give it here!
	B_BiffsAnteil_Berechnung ();
	B_BiffsAnteil_PrintScreen ();
	Info_ClearChoices (DIA_Biff_GELDEINTREIBEN);
	Info_AddChoice (DIA_Biff_GELDEINTREIBEN, "I can't afford you.", DIA_Biff_GELDEINTREIBEN_zuTeuer);
	Info_AddChoice (DIA_Biff_GELDEINTREIBEN, "Here's your share.", DIA_Biff_GELDEINTREIBEN_geben);
};

func void DIA_Biff_GELDEINTREIBEN_geben()
{
	AI_Output(other,self,"DIA_Biff_GELDEINTREIBEN_geben_15_00");	//Here's your share.
	B_GiveBiffsAnteil();
};

func void DIA_Biff_GELDEINTREIBEN_geben2()
{
	AI_Output(self,other,"DIA_Rengaru_GOTYOU_Anteil_15_02");	//All right, looks like I have no choice. I'll share half with you.
	B_GiveBiffsAnteil();
};

func void DIA_Biff_GELDEINTREIBEN_zuTeuer()
{
	AI_Output (other, self, "DIA_Biff_GELDEINTREIBEN_zuTeuer_15_00");	//I can't afford you.
	AI_Output (self, other, "DIA_Biff_GELDEINTREIBEN_zuTeuer_07_01");	//Stop whining at me. We agreed on half.
	Info_ClearChoices (DIA_Biff_GELDEINTREIBEN);
	Info_AddChoice (DIA_Biff_GELDEINTREIBEN, "We must part ways now, I'm afraid.", DIA_Biff_GELDEINTREIBEN_zuTeuer_trennen);
	Info_AddChoice (DIA_Biff_GELDEINTREIBEN, "Here's your share.", DIA_Biff_GELDEINTREIBEN_geben);
};

func void DIA_Biff_GELDEINTREIBEN_zuTeuer_trennen()
{
	DIA_Common_ImAfraidThatsTheEndForUs();
	AI_Output(self,other,"DIA_Biff_GELDEINTREIBEN_zuTeuer_trennen_07_01");	//If you say so. Then I'll just have to take my share.
	BIFF_LABERT_GELDEINTREIBEN = FALSE;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Start");
	B_Attack(self,other,AR_NONE,1);
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	DJG_BiffParty = FALSE;
	DJG_Biff_HalbeHalbe = FALSE;
	DJG_BiffParty_nomore += 1;
};

instance DIA_Biff_ICHBLEIBHIER(C_Info)
{
	npc = DJG_713_Biff;
	nr = 6;
	condition = DIA_Biff_ICHBLEIBHIER_Condition;
	information = DIA_Biff_ICHBLEIBHIER_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Biff_ICHBLEIBHIER_Condition()
{
	if((Npc_GetBodyState(hero) != BS_INVENTORY) && (Npc_GetBodyState(hero) != BS_MOBINTERACT_INTERRUPT) && (DJG_BiffParty == TRUE) && (DJG_Biff_Stay == FALSE))
	{
		if((Npc_GetDistToWP(self,"OW_SWAMPDRAGON_01") < 4000) && !Npc_IsDead(SwampDragon) && (SwampDragon.flags != 0))
		{
			return TRUE;
		}
		else if((Npc_GetDistToWP(self,"LOCATION_19_03_PATH_RUIN8") < 2000) && !Npc_IsDead(RockDragon) && (RockDragon.flags != 0))
		{
			return TRUE;
		}
		else if((Npc_GetDistToWP(self,"CASTLE_36") < 4000) && !Npc_IsDead(FireDragon) && (FireDragon.flags != 0))
		{
			return TRUE;
		}
		else if((Npc_GetDistToWP(self,"OW_ICEDRAGON_01") < 4000) && !Npc_IsDead(IceDragon) && (IceDragon.flags != 0))
		{
			return TRUE;
		}
		else if(Npc_GetDistToWP(self,"OC_CENTER_GUARD_02") < 4500)
		{	
			return TRUE;
		};
	};
};

func void DIA_Biff_ICHBLEIBHIER_Info()
{
	AI_Output (self, other, "DIA_Biff_ICHBLEIBHIER_07_00");	//Really dicey area here. You go in front. I'll keep in the background.
	AI_StopProcessInfos (self);
	Npc_SetRefuseTalk (self, 300);
	if (Npc_GetDistToWP (self, "OW_SWAMPDRAGON_01") < 10000)
	{
		Npc_ExchangeRoutine(self,"Stay_Swamp");
	};
	if(Npc_GetDistToWP(self,"LOCATION_19_03_PATH_RUIN8") < 10000)
	{
		Npc_ExchangeRoutine(self,"Stay_Rock");
	};
//	if(Npc_GetDistToWP(self,"CASTLE_36") < 10000)
	if(Npc_GetDistToWP(self,"CASTLE_30") < 1000)
	{
		Npc_ExchangeRoutine(self,"Stay_Fire");
	};
	if(Npc_GetDistToWP(self,"OW_ICEDRAGON_01") < 10000)
	{
		Npc_ExchangeRoutine(self,"Stay_Ice");
	};
	if(Npc_GetDistToWP(self,"OC_CENTER_GUARD_02") < 10000)
	{
		Npc_ExchangeRoutine(self,"Stay_AwayFromOC");
	};
	DJG_Biff_Stay = TRUE;
	DJG_Biff_SCGold = Npc_HasItems(hero,ItMi_Gold);
};


instance DIA_Biff_Stay_AwayFromOC(C_Info)
{
	npc = DJG_713_Biff;
	nr = 3;
	condition = DIA_Biff_Stay_AwayFromOC_Condition;
	information = DIA_Biff_Stay_AwayFromOC_Info;
	permanent = TRUE;
	description = "(Take Biff along again)";
};


func int DIA_Biff_Stay_AwayFromOC_Condition()
{
	if(((Npc_GetDistToWP(self,"OW_PATH_298") < 500) || (Npc_GetDistToWP(self,"LOCATION_19_01") < 500)) && (DJG_BiffParty == TRUE) && (DJG_Biff_Stay == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Biff_Stay_AwayFromOC_Info()
{
	B_KommMit();
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Follow");
	DJG_Biff_Stay = FALSE;
	DJG_Biff_SCGold = Npc_HasItems(hero,ItMi_Gold);
};


instance DIA_Biff_KOHLEWEGGEBEN(C_Info)
{
	npc = DJG_713_Biff;
	nr = 10;
	condition = DIA_Biff_KOHLEWEGGEBEN_Condition;
	information = DIA_Biff_KOHLEWEGGEBEN_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Biff_KOHLEWEGGEBEN_Condition()
{
	if((DJG_Biff_SCGold > Npc_HasItems(hero,ItMi_Gold)) && (DJG_Biff_HalbeHalbe == TRUE) && (DJG_BiffParty == TRUE) && (DJG_Biff_Stay == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Biff_KOHLEWEGGEBEN_Info()
{
	AI_Output (self, other, "DIA_Biff_KOHLEWEGGEBEN_07_00");	//Don't scatter your gold all over the place.
	AI_Output (self, other, "DIA_Biff_KOHLEWEGGEBEN_07_01");	//Better give it to me, then.
	AI_StopProcessInfos (self);
	DJG_Biff_SCGold = Npc_HasItems (hero, ItMi_Gold);
};


instance DIA_Biff_BIFFLOSWERDEN(C_Info)
{
	npc = DJG_713_Biff;
	nr = 11;
	condition = DIA_Biff_BIFFLOSWERDEN_Condition;
	information = DIA_Biff_BIFFLOSWERDEN_Info;
	permanent = TRUE;
	description = "This is where our collaboration should end, I think.";
};


func int DIA_Biff_BIFFLOSWERDEN_Condition()
{
	if((DJG_BiffParty == TRUE) || (Biff_IsOnBoard == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Biff_BIFFLOSWERDEN_Info()
{
	AI_Output (other, self, "DIA_Biff_BIFFLOSWERDEN_15_00");	//This is where our collaboration should end, I think.
	AI_Output (self, other, "DIA_Biff_BIFFLOSWERDEN_07_01");	//Suit yourself. I can think of better things, too. So long.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Start");
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	DJG_Biff_HalbeHalbe = FALSE;
	DJG_BiffParty = FALSE;
	DJG_BiffParty_nomore += 1;
	if(Biff_IsOnBoard == LOG_SUCCESS)
	{
		Biff_IsOnBoard = LOG_FAILED;
		Biff_FollowsThroughPass = LOG_FAILED;
		Crewmember_Count -= 1;
	};
};


instance DIA_Biff_MEHRGELD(C_Info)
{
	npc = DJG_713_Biff;
	nr = 12;
	condition = DIA_Biff_MEHRGELD_Condition;
	information = DIA_Biff_MEHRGELD_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Biff_MEHRGELD_Condition()
{
	if((DJG_BiffParty == TRUE) && !Npc_RefuseTalk(self) && (DJG_Biff_Stay == FALSE) && (Biff_IsOnBoard != LOG_SUCCESS))
	{
		return TRUE;
	};
};


var int DIA_Biff_MEHRGELD_Info_OneTime;

func void DIA_Biff_MEHRGELD_Info()
{
	AI_Output (self, other, "DIA_Biff_MEHRGELD_07_00");	//I'm starting to get the feeling that I should get more money from you.
	if (DJG_Biff_HalbeHalbe == TRUE)
	{
		AI_Output (self, other, "DIA_Biff_MEHRGELD_07_01");	//100 gold coins should do it.
		if (DIA_Biff_MEHRGELD_Info_OneTime == FALSE)
		{
			AI_Output (self, other, "DIA_Biff_MEHRGELD_07_02");	//No sweat. Of course, I haven't forgotten that we're splitting the booty.
			AI_Output (self, other, "DIA_Biff_MEHRGELD_07_03");	//That's why I won't bug you so often about giving me more money.
			DIA_Biff_MEHRGELD_Info_OneTime = TRUE;
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Biff_MEHRGELD_07_04");	//I want another 100 gold coins.
	};
	Info_ClearChoices (DIA_Biff_MEHRGELD);
	Info_AddChoice (DIA_Biff_MEHRGELD, "I can't afford you.", DIA_Biff_MEHRGELD_zuTeuer);
	Info_AddChoice (DIA_Biff_MEHRGELD, "All right. You're worth it.", DIA_Biff_MEHRGELD_ok);
};

func void DIA_Biff_MEHRGELD_ok()
{
	AI_Output (other, self, "DIA_Biff_MEHRGELD_ok_15_00");	//All right. You're worth it.
	if (B_GiveInvItems (other, self, ItMi_Gold, 100))
	{
		AI_Output (self, other, "DIA_Biff_MEHRGELD_ok_07_01");	//I should say so. Then let's get going.
		AI_StopProcessInfos (self);
		if (DJG_Biff_HalbeHalbe == TRUE)
		{
			DJG_Biff_SCGold = Npc_HasItems(hero,ItMi_Gold);
		};
		B_Biff_SetRefuseTalk();
	}
	else
	{
		AI_Output (self, other, "DIA_Biff_MEHRGELD_ok_07_02");	//You poor sucker, you can't even pay a man-at-arms.
		AI_Output (self, other, "DIA_Biff_MEHRGELD_ok_07_03");	//I think I'll find another business partner.
		AI_StopProcessInfos (self);
		Npc_ExchangeRoutine (self, "Start");
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		DJG_Biff_HalbeHalbe = FALSE;
		DJG_BiffParty = FALSE;
		DJG_BiffParty_nomore += 2;
	};
};

func void DIA_Biff_MEHRGELD_zuTeuer()
{
	AI_Output (other, self, "DIA_Biff_MEHRGELD_zuTeuer_15_00");	//I can't afford you.
	AI_Output (self, other, "DIA_Biff_MEHRGELD_zuTeuer_07_01");	//Then you can just do your crap alone from now on.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Start");
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	DJG_BiffParty = FALSE;
	DJG_BiffParty_nomore += 2;
};


func void B_Biff_NoTrankComment()
{
	var int randy;
	randy = Hlp_Random(2);
	if(randy == 0)
	{
		AI_Output(self,other,"DIA_Biff_HEILUNG_HeilTrank_07_00");	//I guess I need to wait until you've got one for me.
	}
	else
	{
		AI_Output(self,other,"DIA_Biff_HEILUNG_HeilTrankLow_07_00");	//Unfortunately, you don't have any at the moment. I'll get back to you later on that.
	};
};

instance DIA_Biff_HEILUNG(C_Info)
{
	npc = DJG_713_Biff;
	nr = 4;
	condition = DIA_Biff_HEILUNG_Condition;
	information = DIA_Biff_HEILUNG_Info;
	permanent = TRUE;
	description = "Do you need a healing potion?";
};


func int DIA_Biff_HEILUNG_Condition()
{
	if(DJG_BiffParty == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Biff_HEILUNG_Info()
{
	AI_Output (other, self, "DIA_Biff_HEILUNG_15_00");	//Do you need a healing potion?
	AI_Output (self, other, "DIA_Biff_HEILUNG_07_01");	//Sure. It can't hurt.
	Info_ClearChoices(DIA_Biff_HEILUNG);
	Info_AddChoice(DIA_Biff_HEILUNG,"I'll give you something later.",DIA_Biff_HEILUNG_Spaeter);
	if(Npc_HasItems(other,ItPo_Health_Addon_04))
	{
		Info_AddChoice(DIA_Biff_HEILUNG,"(give full healing)",DIA_Biff_HEILUNG_HeilTrankMax);
	};
	if(Npc_HasItems(other,ItPo_Health_03))
	{
		Info_AddChoice(DIA_Biff_HEILUNG,"(give elixir of healing)",DIA_Biff_HEILUNG_HeilTrankHigh);
	};
	if(Npc_HasItems(other,ItPo_Health_02))
	{
		Info_AddChoice(DIA_Biff_HEILUNG,"(give extract of healing)",DIA_Biff_HEILUNG_HeilTrankMed);
	};
	if(Npc_HasItems(other,ItPo_Health_01))
	{
		Info_AddChoice(DIA_Biff_HEILUNG,"(give essense of healing)",DIA_Biff_HEILUNG_HeilTrankLow);
	};
};

func void DIA_Biff_HEILUNG_HeilTrankMax()
{
	if(B_GiveInvItems(other,self,ItPo_Health_Addon_04,1))
	{
		if(self.attribute[ATR_HITPOINTS] < self.attribute[ATR_HITPOINTS_MAX])
		{
			B_UseItem(self,ItPo_Health_Addon_04);
		};
	}
	else
	{
		B_Biff_NoTrankComment();
	};
	AI_StopProcessInfos(self);
};

func void DIA_Biff_HEILUNG_HeilTrankHigh()
{
	if(B_GiveInvItems(other,self,ItPo_Health_03,1))
	{
		if(self.attribute[ATR_HITPOINTS] < self.attribute[ATR_HITPOINTS_MAX])
		{
			B_UseItem(self,ItPo_Health_03);
		};
	}
	else
	{
		B_Biff_NoTrankComment();
	};
	AI_StopProcessInfos(self);
};

func void DIA_Biff_HEILUNG_HeilTrankMed()
{
	if(B_GiveInvItems(other,self,ItPo_Health_02,1))
	{
		if(self.attribute[ATR_HITPOINTS] < self.attribute[ATR_HITPOINTS_MAX])
		{
			B_UseItem(self,ItPo_Health_02);
		};
	}
	else
	{
		B_Biff_NoTrankComment();
	};
	AI_StopProcessInfos(self);
};

func void DIA_Biff_HEILUNG_HeilTrankLow()
{
	if(B_GiveInvItems(other,self,ItPo_Health_01,1))
	{
		if(self.attribute[ATR_HITPOINTS] < self.attribute[ATR_HITPOINTS_MAX])
		{
			B_UseItem(self,ItPo_Health_01);
		};
	}
	else
	{
		B_Biff_NoTrankComment();
	};
	AI_StopProcessInfos(self);
};

func void DIA_Biff_HEILUNG_Spaeter()
{
	DIA_Common_IWillGiveYouSomethingLater();
	AI_Output(self,other,"DIA_Biff_HEILUNG_Spaeter_07_01");	//But don't forget.
	AI_StopProcessInfos(self);
};


instance DIA_Biff_DRACHENTOT(C_Info)
{
	npc = DJG_713_Biff;
	nr = 5;
	condition = DIA_Biff_DRACHENTOT_Condition;
	information = DIA_Biff_DRACHENTOT_Info;
	description = "That's it. All the dragons are dead.";
};


func int DIA_Biff_DRACHENTOT_Condition()
{
	if(DJG_BiffSurvivedLastDragon == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Biff_DRACHENTOT_Info()
{
	AI_Output (other, self, "DIA_Biff_DRACHENTOT_15_00");	//That's it. All the dragons are dead.
	AI_Output (self, other, "DIA_Biff_DRACHENTOT_07_01");	//Yeah. And I'm still standing.
	AI_Output (self, other, "DIA_Biff_DRACHENTOT_07_02");	//Are you sure that was the last one?
	AI_Output (other, self, "DIA_Biff_DRACHENTOT_15_03");	//I should think so.
	AI_Output (self, other, "DIA_Biff_DRACHENTOT_07_04");	//Too bad. I was just getting warmed up.
	B_GivePlayerXP (XP_BiffSurvivedLastDragon);
};


var int Biff_ToldLaterOnce;

instance DIA_Biff_KnowWhereEnemy(C_Info)
{
	npc = DJG_713_Biff;
	nr = 2;
	condition = DIA_Biff_KnowWhereEnemy_Condition;
	information = DIA_Biff_KnowWhereEnemy_Info;
	permanent = TRUE;
	description = "Would you fancy a little trip around the world?";
};


func int DIA_Biff_KnowWhereEnemy_Condition()
{
	if((MIS_SCKnowsWayToIrdorath == TRUE) && ((Biff_IsOnBoard == FALSE) || (Biff_IsOnBoard == LOG_OBSOLETE)) && Npc_KnowsInfo(other,DIA_Biff_WASHIERIMTAL))
	{
		return TRUE;
	};
};

func void DIA_Biff_KnowWhereEnemy_Info()
{
	AI_Output (other, self, "DIA_Biff_KnowWhereEnemy_15_00");	//Would you fancy a little trip around the world?
	AI_Output (self, other, "DIA_Biff_KnowWhereEnemy_07_01");	//What?
	if (Crewmember_Count >= Max_Crew)
	{
		AI_Output (other, self, "DIA_Biff_KnowWhereEnemy_15_02");	//Never mind. My ship is full anyway.
		AI_Output (self, other, "DIA_Biff_KnowWhereEnemy_07_03");	//Quit yanking my chain, man.
	}
	else
	{
		AI_Output(other,self,"DIA_Biff_KnowWhereEnemy_15_04");	//I'm going to leave Khorinis and go to an island to look for new opponents.
		Info_ClearChoices(DIA_Biff_KnowWhereEnemy);
		if(Biff_ToldLaterOnce == TRUE)
		{
			Info_AddChoice(DIA_Biff_KnowWhereEnemy,"I just thought I'd mention it.",DIA_Biff_KnowWhereEnemy_No);
		}
		else
		{
			Info_AddChoice(DIA_Biff_KnowWhereEnemy,"We'll get back to it later...",DIA_Biff_KnowWhereEnemy_No);
		};
		Info_AddChoice(DIA_Biff_KnowWhereEnemy,"Won't you come along?",DIA_Biff_KnowWhereEnemy_Yes);
	};
};

func void DIA_Biff_KnowWhereEnemy_Yes()
{
	AI_Output (other, self, "DIA_Biff_KnowWhereEnemy_Yes_15_00");	//Won't you come along?
	AI_Output (self, other, "DIA_Biff_KnowWhereEnemy_Yes_07_01");	//I don' t care about more opponents. I want ...
	AI_Output (other, self, "DIA_Biff_KnowWhereEnemy_Yes_15_02");	//Where we're going, there will be more gold than you can carry.
	AI_Output (self, other, "DIA_Biff_KnowWhereEnemy_Yes_07_03");	//If that's the case, I'm in. Where are we going?
	AI_Output (other, self, "DIA_Biff_KnowWhereEnemy_Yes_15_04");	//But first we need to get you out of the Valley of Mines.
	AI_Output (self, other, "DIA_Biff_KnowWhereEnemy_Yes_07_05");	//No problem. I'm on my way. Meet me at the pass.
	Biff_FollowsThroughPass = LOG_Running;
	B_JoinShip(self);
};

func void DIA_Biff_KnowWhereEnemy_No()
{
	if(Biff_ToldLaterOnce == TRUE)
	{
		AI_Output(other,self,"DIA_Biff_KnowWhereEnemy_No_15_00");	//I just thought I'd mention it.
	}
	else
	{
		DIA_Common_WeWillGetToThatLater();
	};
	AI_Output(self,other,"DIA_Biff_KnowWhereEnemy_No_07_01");	//Well, well. Have fun, then.
	Biff_ToldLaterOnce = TRUE;
	Biff_IsOnBoard = LOG_OBSOLETE;
	Info_ClearChoices(DIA_Biff_KnowWhereEnemy);
};


instance DIA_Biff_Pass(C_Info)
{
	npc = DJG_713_Biff;
	nr = 55;
	condition = DIA_Biff_Pass_Condition;
	information = DIA_Biff_Pass_Info;
	permanent = TRUE;
	description = "Will you make it across the pass?";
};


func int DIA_Biff_Pass_Condition()
{
	if((Npc_GetDistToWP(self,"START") < 1000) && (Biff_IsOnBoard == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Biff_Pass_Info()
{
	AI_Output (other, self, "DIA_Biff_Pass_15_00");	//Will you make it across the pass?
	AI_Output (self, other, "DIA_Biff_Pass_07_01");	//Quit babbling. Go on. I want to finally get over the top.
	AI_StopProcessInfos(self);
};


instance DIA_Biff_StillNeedYou(C_Info)
{
	npc = DJG_713_Biff;
	nr = 55;
	condition = DIA_Biff_StillNeedYou_Condition;
	information = DIA_Biff_StillNeedYou_Info;
	permanent = FALSE;
	description = "Are you still interested in the voyage?";
};


func int DIA_Biff_StillNeedYou_Condition()
{
	if((Biff_IsOnBoard == LOG_FAILED) && (Crewmember_Count < Max_Crew))
	{
		return TRUE;
	};
};

func void DIA_Biff_StillNeedYou_Info()
{
	AI_Output(other,self,"DIA_Lares_StillNeedYou_15_00");	//Are you still interested in the voyage?
	B_Biff_Verarschen();
	AI_StopProcessInfos(self);
};


instance DIA_Biff_PICKPOCKET(C_Info)
{
	npc = DJG_713_Biff;
	nr = 900;
	condition = DIA_Biff_PICKPOCKET_Condition;
	information = DIA_Biff_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Biff_PICKPOCKET_Condition()
{
	return C_Beklauen(92,320);
};

func void DIA_Biff_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Biff_PICKPOCKET);
	Info_AddChoice(DIA_Biff_PICKPOCKET,Dialog_Back,DIA_Biff_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Biff_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Biff_PICKPOCKET_DoIt);
};

func void DIA_Biff_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Biff_PICKPOCKET);
};

func void DIA_Biff_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Biff_PICKPOCKET);
};

