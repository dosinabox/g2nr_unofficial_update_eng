
func int C_BragoBanditsDead()
{
	if((Npc_IsDead(Ambusher_1013) || (Bdt_1013_Away == TRUE)) && Npc_IsDead(Ambusher_1014) && Npc_IsDead(Ambusher_1015))
	{
		return TRUE;
	};
	return FALSE;
};


var int SC_ForgotAboutCavalorn;
var int CavalornWeakComment;

instance DIA_Addon_Cavalorn_EXIT(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 999;
	condition = DIA_Addon_Cavalorn_EXIT_Condition;
	information = DIA_Addon_Cavalorn_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Cavalorn_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Cavalorn_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Cavalorn_PICKPOCKET(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 900;
	condition = DIA_Addon_Cavalorn_PICKPOCKET_Condition;
	information = DIA_Addon_Cavalorn_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be easy to steal his quiver of arrows)";
};


func int DIA_Addon_Cavalorn_PICKPOCKET_Condition()
{
	return C_StealItem(25);
};

func void DIA_Addon_Cavalorn_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Cavalorn_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Cavalorn_PICKPOCKET,Dialog_Back,DIA_Addon_Cavalorn_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Cavalorn_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Cavalorn_PICKPOCKET_DoIt);
};

func void DIA_Addon_Cavalorn_PICKPOCKET_DoIt()
{
	if(other.attribute[ATR_DEXTERITY] >= 25)
	{
		CreateInvItems(self,ItRw_Arrow,44);
		B_GiveInvItems(self,other,ItRw_Arrow,44);
		self.aivar[AIV_PlayerHasPickedMyPocket] = TRUE;
		B_GiveThiefXP();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Cavalorn",PRINT_PickPocketSuccess));
	}
	else
	{
		B_ResetThiefLevel();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Cavalorn",PRINT_PickPocketFailed));
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_Theft,1);
	};
	Info_ClearChoices(DIA_Addon_Cavalorn_PICKPOCKET);
};

func void DIA_Addon_Cavalorn_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Cavalorn_PICKPOCKET);
};


instance DIA_Addon_Cavalorn_MeetingIsRunning(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 1;
	condition = DIA_Addon_Cavalorn_MeetingIsRunning_Condition;
	information = DIA_Addon_Cavalorn_MeetingIsRunning_Info;
	important = TRUE;
	permanent = TRUE;
};


var int DIA_Addon_Cavalorn_MeetingIsRunning_OneTime;

func int DIA_Addon_Cavalorn_MeetingIsRunning_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (RangerMeetingRunning == LOG_Running))
	{
		if(Npc_GetDistToWP(self,"NW_LITTLESTONEHENDGE") < 2000)
		{
			return FALSE;
		}
		else if(Npc_GetDistToWP(self,"NW_XARDAS_GOBBO_01") < 2000)
		{
			return FALSE;
		}
		else if(Npc_GetDistToWP(self,"NW_XARDAS_BANDITS_LEFT") < 2000)
		{
			return FALSE;
		};
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_MeetingIsRunning_Info()
{
	if(DIA_Addon_Cavalorn_MeetingIsRunning_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Cavalorn_MeetingIsRunning_08_00");	//Welcome to the 'Ring', my friend.
		DIA_Addon_Cavalorn_MeetingIsRunning_OneTime = TRUE;
	};
	AI_Output(self,other,"DIA_Addon_Gaan_MeetingIsRunning_08_01");	//Vatras will give you your next assignment.
	AI_StopProcessInfos(self);
};


func void B_CavalornAboutHut()
{
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Bauern_08_01");	//(amazed) Really? Mmh. I wish I could follow you, but I have to finish my duties here first.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Bauern_08_02");	//When you're in the Valley of Mines, could you please look around and see if my old hut is still standing? I'd like to return there one day.
	MIS_Addon_Cavalorn_TheHut = LOG_Running;
	Log_CreateTopic(TOPIC_Addon_CavalornTheHut,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_CavalornTheHut,LOG_Running);
	B_LogEntry(TOPIC_Addon_CavalornTheHut,"Cavalorn wants me to look and see if his old hut in the Valley of Mines is still standing. As far as I can remember, his hut is located in the hilly country west of the former Old Camp. I suspect he left something there.");
};

instance DIA_Addon_Cavalorn_HALLO(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_HALLO_Condition;
	information = DIA_Addon_Cavalorn_HALLO_Info;
	description = "Are you in trouble?";
};


func int DIA_Addon_Cavalorn_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Addon_Cavalorn_HALLO_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_HALLO_15_00");	//Trouble?
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_08_01");	//(annoyed) Damn. I don't know where they're all hiding. You kill one, and shortly afterwards they're all back again.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_08_02");	//(slyly) Wait a moment. I know you. You're the fellow who was constantly begging arrows from me in the Valley of Mines.
	Info_ClearChoices (DIA_Addon_Cavalorn_HALLO);
	Info_AddChoice (DIA_Addon_Cavalorn_HALLO, "Your name is Cavalorn, right?", DIA_Addon_Cavalorn_HALLO_Ja);
	Info_AddChoice (DIA_Addon_Cavalorn_HALLO, "I can barely remember...?", DIA_Addon_Cavalorn_HALLO_weissNicht);
};

func void DIA_Addon_Cavalorn_HALLO_weissNicht()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_HALLO_weissNicht_15_00");	//I can barely remember...?
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_weissNicht_08_01");	//Oh, come on. Back then in my hut outside the Old Camp, I taught you how to shoot a bow and how to sneak. Ring a bell?
	SC_ForgotAboutCavalorn = TRUE;
};

func void DIA_Addon_Cavalorn_HALLO_Ja()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_HALLO_Ja_15_00");	//Your name is Cavalorn, right?
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Ja_08_01");	//Ah. I see you haven't forgotten me after all we went through in the cursed colony.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Ja_08_02");	//Where are you heading?
	Info_ClearChoices (DIA_Addon_Cavalorn_HALLO);
	Info_AddChoice (DIA_Addon_Cavalorn_HALLO, "I don't have a specific goal.", DIA_Addon_Cavalorn_HALLO_keinZiel);
	Info_AddChoice (DIA_Addon_Cavalorn_HALLO, "Back to the Valley of Mines.", DIA_Addon_Cavalorn_HALLO_Bauern);
	if(PlayerEnteredCity == FALSE)
	{
		Info_AddChoice (DIA_Addon_Cavalorn_HALLO, "To the city.", DIA_Addon_Cavalorn_HALLO_Stadt);
	};
};

func void DIA_Addon_Cavalorn_HALLO_Stadt()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_HALLO_Stadt_15_00");	//To the city.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Stadt_08_01");	//(laughs) Well, well. To the city, eh.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Stadt_08_02");	//You may run into problems with the guards.They aren't letting just anyone in any more, since the area here is swarming with bandits.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Stadt_08_03");	//In the past few days, one of those former psionics from the Valley of Mines came by here. He said he constantly goes in and out of Khorinis.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Stadt_08_04");	//He went into the valley below the big tower. There must be a way in there somewhere near the waterfall.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HALLO_Stadt_08_05");	//Maybe you should talk to the fellow.
	Info_ClearChoices (DIA_Addon_Cavalorn_HALLO);
};

func void DIA_Addon_Cavalorn_HALLO_Bauern()
{
	AI_Output(other,self,"DIA_Addon_Cavalorn_HALLO_Bauern_15_00");	//Back to the Valley of Mines.
	B_CavalornAboutHut();
	Info_ClearChoices(DIA_Addon_Cavalorn_HALLO);
};

func void DIA_Addon_Cavalorn_HALLO_keinZiel()
{
	AI_Output(other,self,"DIA_Addon_Cavalorn_HALLO_keinZiel_15_00");	//I don't have a specific goal.
	AI_Output(self,other,"DIA_Addon_Cavalorn_HALLO_keinZiel_08_01");	//You don't want to tell me, huh? All right.
	Info_ClearChoices(DIA_Addon_Cavalorn_HALLO);
};


//////////////////////////////////////////////////////////////////////////////

instance DIA_Addon_Cavalorn_ImGoingToMineValley(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_ImGoingToMineValley_Condition;
	information = DIA_Addon_Cavalorn_ImGoingToMineValley_Info;
	description = "I was at your hut in the Valley of Mines.";
};


func int DIA_Addon_Cavalorn_ImGoingToMineValley_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_HALLO) && (Hagen_BringProof == TRUE) && (Kapitel < 3) && (MIS_Addon_Cavalorn_TheHut == FALSE) && !Npc_HasItems(other,ItSe_ADDON_CavalornsBeutel) && (SC_OpenedCavalornsBeutel == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_ImGoingToMineValley_Info()
{
	AI_Output(other,self,"DIA_Lee_RescueGorn_15_00");	//I'm going to head for the Valley of Mines.
	B_CavalornAboutHut();
};


////////////////////////////////////////////////////////////

instance DIA_Addon_Cavalorn_Beutel(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_Beutel_Condition;
	information = DIA_Addon_Cavalorn_Beutel_Info;
	description = "I was at your hut in the Valley of Mines.";
};


func int DIA_Addon_Cavalorn_Beutel_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_HALLO) && (Npc_HasItems(other,ItSe_ADDON_CavalornsBeutel) || (SC_OpenedCavalornsBeutel == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_Beutel_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_Beutel_15_00");	//I was at your hut in the Valley of Mines.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Beutel_08_01");	//So it's still standing.
	if(MIS_Addon_Cavalorn_TheHut == LOG_Running)
	{
		AI_Output(other,self,"DIA_Addon_Cavalorn_Beutel_15_02");	//Yes. And I also know what you wanted there.
	};
	AI_Output (self, other, "DIA_Addon_Cavalorn_Beutel_08_03");	//Did you find it?
	AI_Output (other, self, "DIA_Addon_Cavalorn_Beutel_15_04");	//If you mean your pouch with the lumps of ore... yes, I have it.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Beutel_08_05");	//You're a fox, you know that?
	if(MIS_Addon_Cavalorn_TheHut == LOG_Running)
	{
		AI_Output(other,self,"DIA_Addon_Cavalorn_Beutel_15_06");	//What else could you have wanted in that old shack? There isn't anything else.
	};
	AI_Output(self,other,"DIA_Addon_Cavalorn_Beutel_08_07");	//Do you have it with you? I'll give you 100 gold coins for it.
	TOPIC_End_CavalornTheHut = TRUE;
	B_GivePlayerXP(XP_Ambient);
	Info_ClearChoices(DIA_Addon_Cavalorn_Beutel);
	if(Npc_HasItems(other,ItSe_ADDON_CavalornsBeutel))
	{
		Info_AddChoice (DIA_Addon_Cavalorn_Beutel, "Sure.", DIA_Addon_Cavalorn_Beutel_ja);
	}
	else if(Npc_HasItems(other,ItMi_Nugget))
	{
		Info_AddChoice (DIA_Addon_Cavalorn_Beutel, "No, but I have a lump of ore here.", DIA_Addon_Cavalorn_Beutel_jaerz);
	};
	Info_AddChoice (DIA_Addon_Cavalorn_Beutel, "No.", DIA_Addon_Cavalorn_Beutel_no);
};

func void DIA_Addon_Cavalorn_Beutel_back()
{
	if(!Npc_HasItems(self,ItSe_ADDON_CavalornsBeutel) && !Npc_HasItems(self,ItMi_Nugget))
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_back_08_00");	//I hope that I'll get it back soon.
	};
	Info_ClearChoices(DIA_Addon_Cavalorn_Beutel);
};

func void DIA_Addon_Cavalorn_Beutel_jaerz()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_Beutel_jaerz_15_00");	//No, but I have a lump of ore here.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Beutel_jaerz_08_01");	//Also good.
	Info_ClearChoices(DIA_Addon_Cavalorn_Beutel);
	Info_AddChoice(DIA_Addon_Cavalorn_Beutel,Dialog_Back,DIA_Addon_Cavalorn_Beutel_back);
	Info_AddChoice(DIA_Addon_Cavalorn_Beutel,"Why did you leave it there in the first place?",DIA_Addon_Cavalorn_Beutel_why);
	if(Npc_HasItems(other,ItSe_ADDON_CavalornsBeutel) || Npc_HasItems(other,ItMi_Nugget))
	{
		Info_AddChoice(DIA_Addon_Cavalorn_Beutel,"Give me 100 gold coins and I'll give you your ore back.",DIA_Addon_Cavalorn_ErzGeben_Info);
	};
};

func void DIA_Addon_Cavalorn_Beutel_ja()
{
	AI_Output(other,self,"DIA_Addon_Cavalorn_Beutel_ja_15_00");	//Sure.
	AI_Output(self,other,"DIA_Addon_Cavalorn_Triggered_OBack_08_01");	//Terrific.
	Info_ClearChoices(DIA_Addon_Cavalorn_Beutel);
	Info_AddChoice(DIA_Addon_Cavalorn_Beutel,Dialog_Back,DIA_Addon_Cavalorn_Beutel_back);
	Info_AddChoice(DIA_Addon_Cavalorn_Beutel,"Why did you leave it there in the first place?",DIA_Addon_Cavalorn_Beutel_why);
	if(Npc_HasItems(other,ItSe_ADDON_CavalornsBeutel) || Npc_HasItems(other,ItMi_Nugget))
	{
		Info_AddChoice(DIA_Addon_Cavalorn_Beutel,"Give me 100 gold coins and I'll give you your ore back.",DIA_Addon_Cavalorn_ErzGeben_Info);
	};
};

func void DIA_Addon_Cavalorn_Beutel_no()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_Beutel_no_15_00");	//No.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Beutel_no_08_01");	//Then get it BACK for me. After all, I would even have gone back into that cursed Valley of Mines.
	AI_Output (other, self, "DIA_Addon_Cavalorn_Beutel_no_15_02");	//I'm getting all misty-eyed.
	Info_ClearChoices(DIA_Addon_Cavalorn_Beutel);
	Info_AddChoice(DIA_Addon_Cavalorn_Beutel,Dialog_Back,DIA_Addon_Cavalorn_Beutel_back);
	Info_AddChoice(DIA_Addon_Cavalorn_Beutel,"Why did you leave it there in the first place?",DIA_Addon_Cavalorn_Beutel_why);
	if(Npc_HasItems(other,ItSe_ADDON_CavalornsBeutel) || Npc_HasItems(other,ItMi_Nugget))
	{
		Info_AddChoice(DIA_Addon_Cavalorn_Beutel,"Give me 100 gold coins and I'll give you your ore back.",DIA_Addon_Cavalorn_ErzGeben_Info);
	};
};

func void DIA_Addon_Cavalorn_Beutel_why()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_Beutel_why_15_00");	//Why did you leave it there in the first place?
	AI_Output (self, other, "DIA_Addon_Cavalorn_Beutel_why_08_01");	//I had no idea that ore was so valuable here in Khorinis.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Beutel_why_08_02");	//For one measly piece of ore, you couldn't get so much as a place to sleep back in the penal colony.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Beutel_why_08_03");	//In the harbor city, they'll practically bash your skull in if they find out you have ore on you.
};


instance DIA_Addon_Cavalorn_ErzGeben(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_ErzGeben_Condition;
	information = DIA_Addon_Cavalorn_ErzGeben_Info;
	description = "Give me 100 gold coins and I'll give you your ore back.";
};


func int DIA_Addon_Cavalorn_ErzGeben_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_Beutel) && (Npc_HasItems(other,ItSe_ADDON_CavalornsBeutel) || Npc_HasItems(other,ItMi_Nugget)) && (MIS_Addon_Cavalorn_TheHut != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_ErzGeben_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_ErzGeben_15_00");	//Give me 100 gold coins and I'll give you your ore back.
	AI_Output (self, other, "DIA_Addon_Cavalorn_ErzGeben_08_01");	//Deal. Here you go.
	CreateInvItems(self,ItMi_Gold,100);
	B_GiveInvItems(self,other,ItMi_Gold,100);
	if(Npc_HasItems(other,ItSe_ADDON_CavalornsBeutel))
	{
		B_GiveInvItems(other,self,ItSe_ADDON_CavalornsBeutel,1);
	}
	else
	{
		B_GiveInvItems(other,self,ItMi_Nugget,1);
	};
	AI_Output (self, other, "DIA_Addon_Cavalorn_ErzGeben_08_02");	//You're a real friend. Thanks a lot.
	MIS_Addon_Cavalorn_TheHut = LOG_SUCCESS;
	B_GivePlayerXP(XP_Addon_CavalornsBeutel);
};


instance DIA_Addon_Cavalorn_WASMACHSTDU(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_WASMACHSTDU_Condition;
	information = DIA_Addon_Cavalorn_WASMACHSTDU_Info;
	description = "What are you doing here?";
};


func int DIA_Addon_Cavalorn_WASMACHSTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_HALLO) && (MIS_Addon_Nefarius_BringMissingOrnaments == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_WASMACHSTDU_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_WASMACHSTDU_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Addon_Cavalorn_WASMACHSTDU_08_01");	//I'm sitting tight. If it hadn't been for these damned bandits, I wouldn't be here.
};


instance DIA_Addon_Cavalorn_Banditen(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 10;
	condition = DIA_Addon_Cavalorn_Banditen_Condition;
	information = DIA_Addon_Cavalorn_Banditen_Info;
	description = "What was that about bandits?";
};


func int DIA_Addon_Cavalorn_Banditen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_WASMACHSTDU) && (MIS_Addon_Nefarius_BringMissingOrnaments == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_Banditen_Info()
{
	AI_Output(other,self,"DIA_Addon_Cavalorn_Banditen_15_00");	//What was that about bandits?
	AI_Output(self,other,"DIA_Addon_Cavalorn_Banditen_08_01");	//Have you slept through the last few weeks?
	AI_Output(other,self,"DIA_Addon_Cavalorn_Banditen_15_02");	//Eh...
	AI_Output(self,other,"DIA_Addon_Cavalorn_Banditen_08_03");	//I'm talking about all the riff-raff from the penal colony that are making themselves at home here in the area. Plundering and murdering for all
	AI_Output(self,other,"DIA_Addon_Cavalorn_Banditen_08_04");	//(sighs) I guess I'm lucky they didn't kill me. I let down my guard for one moment, and they clubbed me from behind.
	if(!C_BragoBanditsDead())
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_Banditen_08_05");	//No idea how I'll get all my stuff back now.
	};
};


instance DIA_Addon_Cavalorn_ARTEFAKT(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_ARTEFAKT_Condition;
	information = DIA_Addon_Cavalorn_ARTEFAKT_Info;
	description = "You were robbed by the bandits?";
};


func int DIA_Addon_Cavalorn_ARTEFAKT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_Banditen) && (MIS_Addon_Cavalorn_KillBrago != LOG_SUCCESS) && (MIS_Addon_Nefarius_BringMissingOrnaments == FALSE) && (MIS_Addon_Cavalorn_Letter2Vatras != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_ARTEFAKT_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_ARTEFAKT_15_00");	//You were robbed by the bandits?
	AI_Output (self, other, "DIA_Addon_Cavalorn_ARTEFAKT_08_01");	//(furious) Yes. They beat me down and tossed me to the goblins for lunch.
	AI_Output (self, other, "DIA_Addon_Cavalorn_ARTEFAKT_08_02");	//It was damned important stuff. A letter and all my money. I absolutely have to get it back.
	AI_Output (self, other, "DIA_Addon_Cavalorn_ARTEFAKT_08_03");	//But without someone to watch my back, I'm not going back there. That cowardly rabble...
};


instance DIA_Addon_Cavalorn_HELFEN(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_HELFEN_Condition;
	information = DIA_Addon_Cavalorn_HELFEN_Info;
	description = "Can I help you with the bandits?";
};


func int DIA_Addon_Cavalorn_HELFEN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_ARTEFAKT) && (MIS_Addon_Nefarius_BringMissingOrnaments == FALSE) && (MIS_Addon_Cavalorn_Letter2Vatras != LOG_SUCCESS) && !C_BragoBanditsDead())
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_HELFEN_Info()
{
	AI_Output(other,self,"DIA_Addon_Cavalorn_HELFEN_15_00");	//Can I help you with the bandits?
	if(!Npc_HasEquippedArmor(other) && (hero.guild == GIL_NONE))
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_HELFEN_08_01");	//(slyly) Maybe. But as scrawny as you look, you surely haven't held a proper sword in your hands for weeks.
		CavalornWeakComment = TRUE;
	};
	AI_Output (self, other, "DIA_Addon_Cavalorn_HELFEN_08_02");	//Well. I don't have any choice but to take your offer. My time is running out.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HELFEN_08_03");	//So, pay attention. Down this path here, you'll find one of those filthy holes in the ground that bandits like to hide in.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HELFEN_08_04");	//The fellows there are the same ones who stole my stuff.
	AI_Output (self, other, "DIA_Addon_Cavalorn_HELFEN_08_05");	//Let me know when you're ready and we'll nab the rabble.
	MIS_Addon_Cavalorn_KillBrago = LOG_Running;
	Log_CreateTopic(TOPIC_Addon_KillBrago,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_KillBrago,LOG_Running);
	B_LogEntry(TOPIC_Addon_KillBrago,"The bandits near Cavalorn stole something valuable from him. He wants us to tangle with the bandits together.");
};


instance DIA_Addon_Cavalorn_AUSRUESTUNG(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_AUSRUESTUNG_Condition;
	information = DIA_Addon_Cavalorn_AUSRUESTUNG_Info;
	description = "I need better equipment.";
};


func int DIA_Addon_Cavalorn_AUSRUESTUNG_Condition()
{
	if((MIS_Addon_Cavalorn_KillBrago != FALSE) && (MIS_Addon_Nefarius_BringMissingOrnaments == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_AUSRUESTUNG_Info()
{
	AI_Output(other,self,"DIA_Addon_Cavalorn_AUSRUESTUNG_15_00");	//I need better equipment.
	if(!C_BragoBanditsDead())
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_AUSRUESTUNG_08_01");	//Those swine haven't left me much.
	};
	AI_Output(self,other,"DIA_Addon_Cavalorn_AUSRUESTUNG_08_02");	//I can give you a wolf knife. Will that do for now?
	CreateInvItems(self,ItMW_Addon_Knife01,1);
	B_GiveInvItems(self,other,ItMW_Addon_Knife01,1);
	AI_Output(other,self,"DIA_Addon_Cavalorn_AUSRUESTUNG_15_03");	//You call that a knife?
	AI_Output (other, self, "DIA_Addon_Cavalorn_AUSRUESTUNG_15_04");//But what about healing?
	AI_Output (self, other, "DIA_Addon_Cavalorn_AUSRUESTUNG_08_05");//I still have 2 healing potions here. Interested?
	AI_Output (other, self, "DIA_Addon_Cavalorn_AUSRUESTUNG_15_06");//Sure. Give 'em here.
	CreateInvItems(self,ItPo_Health_01,2);
	B_GiveInvItems(self,other,ItPo_Health_01,2);
};


instance DIA_Addon_Cavalorn_LETSKILLBANDITS(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_LETSKILLBANDITS_Condition;
	information = DIA_Addon_Cavalorn_LETSKILLBANDITS_Info;
	description = "Let's mix it up with those guys.";
};


func int DIA_Addon_Cavalorn_LETSKILLBANDITS_Condition()
{
	if((MIS_Addon_Cavalorn_KillBrago == LOG_Running) && (MIS_Addon_Nefarius_BringMissingOrnaments == FALSE) && (MIS_Addon_Cavalorn_Letter2Vatras != LOG_SUCCESS) && !C_BragoBanditsDead())
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_LETSKILLBANDITS_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_LETSKILLBANDITS_15_00");	//Let's mix it up with those guys.
	AI_Output (self, other, "DIA_Addon_Cavalorn_LETSKILLBANDITS_08_01");	//Sure thing. Just keep my back clear, ok?
	AI_Output (self, other, "DIA_Addon_Cavalorn_LETSKILLBANDITS_08_02");	//Now they're in for a nasty surprise.
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"KillBandits");
	if(Bdt_1013_Away == FALSE)
	{
		Ambusher_1013.aivar[AIV_EnemyOverride] = FALSE;
	};
	Ambusher_1014.aivar[AIV_EnemyOverride] = FALSE;
	Ambusher_1015.aivar[AIV_EnemyOverride] = FALSE;
};

func void B_Addon_Cavalorn_VatrasBrief()
{
	if(MIS_Addon_Cavalorn_Letter2Vatras != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_00");	//Then I can finally fulfill my mission. I've lost too much time already.
		AI_Output (other, self, "DIA_Addon_Cavalorn_VatrasBrief_15_01");	//What sort of mission... ?
		AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_02");	//(to himself) Ah. Yeah. First I have to get into the city and then later...
		AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_03");	//(sighs) I don't know how I'm going to get all that done in time.
		AI_Output (other, self, "DIA_Addon_Cavalorn_VatrasBrief_15_04");	//(drily) What about me?
		AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_05");	//(appraisingly) Mmh. Why not. You could take the letter into the city.
		MIS_Addon_Cavalorn_Letter2Vatras = LOG_Running;
		Log_CreateTopic(TOPIC_Addon_KDW,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_KDW,LOG_Running);
		B_LogEntry(TOPIC_Addon_KDW,"Cavalorn wants me to deliver a letter stolen from bandits to Vatras, the Water Mage in the seaport Khorinis. He preaches in the Adanos temple there");
	};
	AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_06");	//Then I'll have a bit more time to take care of my equipment.
	if (MIS_Addon_Cavalorn_Letter2Vatras != LOG_SUCCESS)
	{
		AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_07");	//One of the bandits must have the letter in his pocket.
		AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_08");	//Take it to Vatras, the Water Mage in the city. You'll find him in the Tempel of Adanos. He preaches there all day.
		AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_09");	//Tell him that I wasn't able to get it done.
		AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_10");	//And if he asks where I am, just tell him I'm already on my way to the meeting point, ok?
	};
	if(!Npc_HasEquippedArmor(other) && (hero.guild == GIL_NONE))
	{
			AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_11");	//Oh, yeah, one more thing. First buy some decent clothes from the farmers.
			AI_Output (self, other, "DIA_Addon_Cavalorn_VatrasBrief_08_12");	//Otherwise you may be taken for a bandit. Here's a couple of coins.
		CreateInvItems(self,ItMi_Gold,50);
		B_GiveInvItems(self,other,ItMi_Gold,50);
		if((Mil_310_schonmalreingelassen == FALSE) && (Mil_333_schonmalreingelassen == FALSE))
		{
			Log_CreateTopic(TOPIC_City,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_City,LOG_Running);
			Log_AddEntry(TOPIC_City,"Cavalorn advised me to buy some decent clothes so that I won't look too suspicious for the city guards.");
		};
	};
	self.aivar[AIV_PARTYMEMBER] = FALSE;
	Npc_ExchangeRoutine(self,"Start");
	MIS_Addon_Cavalorn_KillBrago = LOG_SUCCESS;
	B_GivePlayerXP(XP_Addon_Cavalorn_KillBrago);
};


instance DIA_Addon_Cavalorn_BragoKilled(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_BragoKilled_Condition;
	information = DIA_Addon_Cavalorn_BragoKilled_Info;
	important = TRUE;
};


func int DIA_Addon_Cavalorn_BragoKilled_Condition()
{
	if((Npc_GetDistToWP(self,"NW_XARDAS_BANDITS_LEFT") < 500) && (MIS_Addon_Cavalorn_KillBrago == LOG_Running) && C_BragoBanditsDead())
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_BragoKilled_Info()
{
	AI_Output (self, other, "DIA_Addon_Cavalorn_BragoKilled_08_00");	//So, that's done. Hah. They shouldn't have messed with me.
	B_Addon_Cavalorn_VatrasBrief ();
};


instance DIA_Addon_Cavalorn_PCKilledBrago(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_PCKilledBrago_Condition;
	information = DIA_Addon_Cavalorn_PCKilledBrago_Info;
	description = "The bandits are finished.";
};


func int DIA_Addon_Cavalorn_PCKilledBrago_Condition()
{
	if(((MIS_Addon_Cavalorn_KillBrago == FALSE) || ((Npc_GetDistToWP(self,"NW_XARDAS_GOBBO_01") < 500) && (MIS_Addon_Cavalorn_KillBrago == LOG_Running))) && Npc_KnowsInfo(other,DIA_Addon_Cavalorn_Banditen) && C_BragoBanditsDead())
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_PCKilledBrago_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_PCKilledBrago_15_00");	//The bandits are finished.
	B_Addon_Cavalorn_VatrasBrief ();
};


instance DIA_Addon_Cavalorn_JUNGS(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 2;
	condition = DIA_Addon_Cavalorn_JUNGS_Condition;
	information = DIA_Addon_Cavalorn_JUNGS_Info;
	description = "That's some interesting armor you're wearing.";
};


func int DIA_Addon_Cavalorn_JUNGS_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_JUNGS_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_JUNGS_15_00");	//Interesting armor you're wearing. Don't you belong to the Shadows any more?
	AI_Output (self, other, "DIA_Addon_Cavalorn_JUNGS_08_01");	//Shadows? They haven't existed since the fall of the Barrier.
	AI_Output (self, other, "DIA_Addon_Cavalorn_JUNGS_08_02");	//The moment we could finally leave the Valley of Mines there was no reason for me to stick with them.
	AI_Output (self, other, "DIA_Addon_Cavalorn_JUNGS_08_03");	//Now I work for the Water Mages. I belong to the 'Ring of Water'.
	SC_KnowsRanger = TRUE;
	Log_CreateTopic (TOPIC_Addon_RingOfWater, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_RingOfWater, LOG_Running);
	B_LogEntry (TOPIC_Addon_RingOfWater, "Cavalorn told me that he belongs to a community that calls itself the 'Ring of Water'.");
	Cavalorn_RangerHint = TRUE;
};


instance DIA_Addon_Cavalorn_Ring(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_Ring_Condition;
	information = DIA_Addon_Cavalorn_Ring_Info;
	permanent = FALSE;
	description = "Tell me more about the 'Ring of Water'!";
};


func int DIA_Addon_Cavalorn_Ring_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_JUNGS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_Ring_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_Ring_15_00");	//Tell me more about the 'Ring of Water'!
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ring_08_01");	//I'm not really allowed to talk about it.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ring_08_02");	//All I can do is send you to Vatras. He is the representative of the Water Mages in Khorinis.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ring_08_03");	//The best thing would be to talk to him. Tell him you come from me.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ring_08_04");	//Maybe he'll take you on as one of us. We urgently need more good people...
	B_LogEntry (TOPIC_Addon_RingOfWater, "Vatras the Water Mage can tell me more about the 'Ring of Water'.");
};


instance DIA_Addon_Cavalorn_Feinde(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 6;
	condition = DIA_Addon_Cavalorn_Feinde_Condition;
	information = DIA_Addon_Cavalorn_Feinde_Info;
	permanent = FALSE;
	description = "Weren't you and your people enemies of the Water Mages back then?";
};


func int DIA_Addon_Cavalorn_Feinde_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_JUNGS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_Feinde_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_Feinde_15_00");	//Weren't you and your people enemies of the Water Mages back then?
	AI_Output (self, other, "DIA_Addon_Cavalorn_Feinde_08_01");	//Those crazy old days are over. There isn't any more 'New Camp' or 'Old Camp'.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Feinde_08_02");	//Now that the penal colony no longer exists, everyone is on his own.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Feinde_08_03");	//Most of us former prisoners are still being hunted.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Feinde_08_04");	//The Water Mages were able to get my sentence commuted and now I can move around freely.
};


instance DIA_Addon_Cavalorn_KdWTask(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 6;
	condition = DIA_Addon_Cavalorn_KdWTask_Condition;
	information = DIA_Addon_Cavalorn_KdWTask_Info;
	permanent = FALSE;
	description = "What are the Water Mages doing now?";
};


func int DIA_Addon_Cavalorn_KdWTask_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_JUNGS) && (MIS_Addon_Nefarius_BringMissingOrnaments == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_KdWTask_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_KdWTask_15_00");	//What are the Water Mages doing now?
	AI_Output (self, other, "DIA_Addon_Cavalorn_KdWTask_08_01");	//They're up to something big. It has to do with an unknown region of the island.
	AI_Output (other, self, "DIA_Addon_Cavalorn_KdWTask_15_02");	//An unknown region? Where is it supposed to be?
	AI_Output (self, other, "DIA_Addon_Cavalorn_KdWTask_08_03");	//I can't tell you more. Talk to Vatras in Khorinis.
};


instance DIA_Addon_Cavalorn_BroughtLetter(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_BroughtLetter_Condition;
	information = DIA_Addon_Cavalorn_BroughtLetter_Info;
	description = "I gave Vatras your letter.";
};


func int DIA_Addon_Cavalorn_BroughtLetter_Condition()
{
	if((MIS_Addon_Cavalorn_Letter2Vatras == LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_Addon_Cavalorn_JUNGS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_BroughtLetter_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_BroughtLetter_15_00");	//I gave Vatras your letter.
	AI_Output (self, other, "DIA_Addon_Cavalorn_BroughtLetter_08_01");	//I didn't expect anything else. Thanks.
	B_GivePlayerXP (XP_Ambient);
};


instance DIA_Addon_Cavalorn_Ornament(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 2;
	condition = DIA_Addon_Cavalorn_Ornament_Condition;
	information = DIA_Addon_Cavalorn_Ornament_Info;
	description = "Are you looking for something?";
};


func int DIA_Addon_Cavalorn_Ornament_Condition()
{
	if((MIS_Addon_Nefarius_BringMissingOrnaments == LOG_Running) && Npc_KnowsInfo(other,DIA_Addon_Cavalorn_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_Ornament_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_Ornament_15_00");	//Are you looking for something?
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ornament_08_01");	//Is it that obvious? Yes, I have an assignment from the Water Mages to look for some lost ornament.
	AI_Output (other, self, "DIA_Addon_Cavalorn_Ornament_15_02");	//That's convenient. I have the same assignement from Nefarius.
	if (SC_KnowsRanger == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Cavalorn_Ornament_08_03");	//So you belong to the 'Ring of Water'?
		if (SC_IsRanger == TRUE)
		{
			AI_Output (other, self, "DIA_Addon_Cavalorn_Ornament_15_04");	//Yes.
		}
		else
		{
			AI_Output (other, self, "DIA_Addon_Cavalorn_Ornament_15_05");	//Not yet, but I'm working on it.
		};
	};
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ornament_08_06");	//I'm glad. Then I don't have to do this alone.
	AI_Output (other, self, "DIA_Addon_Cavalorn_Ornament_15_07");	//Have you already found an ornament?
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ornament_08_08");	//I found the place where we should find one.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ornament_08_09");	//This stone circle could be one of those structures that Nefarius described.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Ornament_08_10");	//Now we just have to find the mechanism we're supposed to look for.
};


instance DIA_Addon_Cavalorn_Triggered(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_Triggered_Condition;
	information = DIA_Addon_Cavalorn_Triggered_Info;
	description = "I operated the mechanism.";
};


func int DIA_Addon_Cavalorn_Triggered_Condition()
{
	if((MIS_Addon_Nefarius_BringMissingOrnaments == LOG_Running) && Npc_KnowsInfo(other,DIA_Addon_Cavalorn_Ornament) && (ORNAMENT_SWITCHED_FARM == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_Triggered_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_Triggered_15_00");	//I tried the mechanism. It doesn't do anything at all.
	AI_Output(self,other,"DIA_Addon_Cavalorn_Beutel_ja_08_01");	//Terrific.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Triggered_08_01");	//Then Lobart's farmers were right.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Triggered_08_02");	//They said that one of them had already played around with the stones here.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Triggered_08_03");	//A stone sentinel appeared out of nowhere and attacked them.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Triggered_08_04");	//The farmers called the militia, the militiamen called the paladins who came and destroyed the monster.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Triggered_08_05");	//I've already searched the whole area. If there was an ornament here, the paladins have it now.
	Info_ClearChoices (DIA_Addon_Cavalorn_Triggered);
	Info_AddChoice (DIA_Addon_Cavalorn_Triggered, "Then one of us has to get into the upper quarter of the city.", DIA_Addon_Cavalorn_Triggered_Pal);
	Info_AddChoice (DIA_Addon_Cavalorn_Triggered, "Then I'll go to them and demand the ornament back.", DIA_Addon_Cavalorn_Triggered_OBack);
};

func void B_Cavalorn_Triggered_Wohin()
{
	AI_Output (self, other, "DIA_Addon_Cavalorn_Triggered_Wohin_08_00");	//I'm going to the city now. We'll meet again at Vatras'.
	AI_StopProcessInfos (self);
	Npc_ExchangeRoutine (self, "Stadt");
	Log_CreateTopic (TOPIC_Addon_Ornament, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_Ornament, LOG_Running);
	B_LogEntry (TOPIC_Addon_Ornament, "One of the missing ornament fragments is with the paladins in the upper quarter.");
	MIS_Addon_Cavalorn_GetOrnamentFromPAL = LOG_Running;
	self.flags = 0;
};

func void DIA_Addon_Cavalorn_Triggered_OBack()
{
//	AI_UnequipArmor(self);
	CreateInvItems(self,ITAR_Bau_L,1);
//	Npc_RemoveInvItems(self,ITAR_RANGER_Addon,Npc_HasItems(self,ITAR_RANGER_Addon));
//	Npc_RemoveInvItems(self,ITAR_Fake_RANGER,Npc_HasItems(self,ITAR_Fake_RANGER));
//	AI_EquipBestArmor(self);
	AI_EquipArmor(self,ITAR_Bau_L);
	AI_Output (other, self, "DIA_Addon_Cavalorn_Triggered_OBack_15_00");	//Then I'll go to them and demand the ornament back.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Triggered_OBack_08_01");	//All right.
	B_Cavalorn_Triggered_Wohin();
};

func void DIA_Addon_Cavalorn_Triggered_Pal()
{
//	AI_UnequipArmor(self);
	CreateInvItems(self,ITAR_Bau_L,1);
//	Npc_RemoveInvItems(self,ITAR_RANGER_Addon,Npc_HasItems(self,ITAR_RANGER_Addon));
//	Npc_RemoveInvItems(self,ITAR_Fake_RANGER,Npc_HasItems(self,ITAR_Fake_RANGER));
//	AI_EquipBestArmor(self);
	AI_EquipArmor(self,ITAR_Bau_L);
	AI_Output (other, self, "DIA_Addon_Cavalorn_Triggered_Pal_15_00");	//Then one of us has to get into the upper quarter of the city.
	AI_Output (self, other, "DIA_Addon_Cavalorn_Triggered_Pal_08_01");	//I don't have any time for that. You'll have to do it.
	B_Cavalorn_Triggered_Wohin();
};


instance DIA_Addon_Cavalorn_GotOrnaFromHagen(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 5;
	condition = DIA_Addon_Cavalorn_GotOrnaFromHagen_Condition;
	information = DIA_Addon_Cavalorn_GotOrnaFromHagen_Info;
	description = "I got the missing ornament from Lord Hagen.";
};


func int DIA_Addon_Cavalorn_GotOrnaFromHagen_Condition()
{
	if(Lord_Hagen_GotOrnament == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_GotOrnaFromHagen_Info()
{
	AI_Output (other, self, "DIA_Addon_Cavalorn_GotOrnaFromHagen_15_00");	//I got the missing ornament from Lord Hagen.
	AI_Output (self, other, "DIA_Addon_Cavalorn_GotOrnaFromHagen_08_01");	//You see? I thought the paladins had it.
	B_GivePlayerXP (XP_Ambient);
	MIS_Addon_Cavalorn_GetOrnamentFromPAL = LOG_SUCCESS;
};


instance DIA_Addon_Cavalorn_WannaLearn(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 7;
	condition = DIA_Addon_Cavalorn_WannaLearn_Condition;
	information = DIA_Addon_Cavalorn_WannaLearn_Info;
	permanent = FALSE;
	description = "Can you teach me something?";
};


func int DIA_Addon_Cavalorn_WannaLearn_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Cavalorn_HALLO) && C_BragoBanditsDead())
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_WannaLearn_Info()
{
	AI_Output(other,self,"DIA_Addon_Cavalorn_WannaLearn_15_00");	//Can you teach me something?
	if((CavalornWeakComment == FALSE) && (SC_ForgotAboutCavalorn == FALSE))
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_WannaLearn_08_01_add");	//Sure. You know that.
	};
	if(CavalornWeakComment == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_WannaLearn_08_01");	//Sure. You know that. Man, they really took a lot out of you.
	};
	if(SC_ForgotAboutCavalorn == TRUE)
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_WannaLearn_08_02");	//You can't remember anything at all, can you?
	};
	Cavalorn_Addon_TeachPlayer = TRUE;
	Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_OutTeacher,LogText_Addon_Cavalorn_Teach);
};


var int DIA_Cavalorn_Teacher_permanent;
var int Cavalorn_Merke_Bow;
var int Cavalorn_Merke_1h;
var int Cavalorn_Sneak_Comment;

func void B_BuildLearnDialog_Cavalorn()
{
	Info_ClearChoices(DIA_Addon_Cavalorn_TEACH);
	Info_AddChoice(DIA_Addon_Cavalorn_TEACH,Dialog_Back,DIA_Addon_Cavalorn_Teach_Back);
	if(!Npc_GetTalentSkill(other,NPC_TALENT_SNEAK))
	{
		Info_AddChoice(DIA_Addon_Cavalorn_TEACH,B_BuildLearnString(NAME_Skill_Sneak,B_GetLearnCostTalent(other,NPC_TALENT_SNEAK,1)),DIA_Addon_Cavalorn_Teach_Sneak);
	};
	if(VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Cavalorn)
	{
		Info_AddChoice(DIA_Addon_Cavalorn_TEACH,B_BuildLearnString(PRINT_LearnBow1,B_GetLearnCostTalent(other,NPC_TALENT_BOW,1)),DIA_Addon_Cavalorn_Teach_Bow_1);
		Info_AddChoice(DIA_Addon_Cavalorn_TEACH,B_BuildLearnString(PRINT_LearnBow5,B_GetLearnCostTalent(other,NPC_TALENT_BOW,5)),DIA_Addon_Cavalorn_Teach_Bow_5);
	};
	if(VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Cavalorn)
	{
		Info_AddChoice(DIA_Addon_Cavalorn_TEACH,B_BuildLearnString(PRINT_Learn1h1,B_GetLearnCostTalent(other,NPC_TALENT_1H,1)),DIA_Addon_Cavalorn_Teach_1H_1);
		Info_AddChoice(DIA_Addon_Cavalorn_TEACH,B_BuildLearnString(PRINT_Learn1h5,B_GetLearnCostTalent(other,NPC_TALENT_1H,5)),DIA_Addon_Cavalorn_Teach_1H_5);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_SNEAK) && (VisibleTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_Cavalorn) && (VisibleTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Cavalorn))
	{
		if((RealTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_Cavalorn) && (RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Cavalorn))
		{
			DIA_Cavalorn_Teacher_permanent = TRUE;
		};
		PrintScreen(PRINT_NoLearnTotalMAXReached,-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

instance DIA_Addon_Cavalorn_TEACH(C_Info)
{
	npc = BAU_4300_Addon_Cavalorn;
	nr = 8;
	condition = DIA_Addon_Cavalorn_TEACH_Condition;
	information = DIA_Addon_Cavalorn_TEACH_Info;
	permanent = TRUE;
	description = "I want to learn your abilities.";
};


func int DIA_Addon_Cavalorn_TEACH_Condition()
{
	if((Cavalorn_Addon_TeachPlayer == TRUE) && (DIA_Cavalorn_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Cavalorn_TEACH_Info()
{
	AI_Output(other,self,"DIA_Addon_Cavalorn_TEACH_15_00");	//I want to learn your abilities.
	if(!Npc_GetTalentSkill(other,NPC_TALENT_SNEAK) || (VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Cavalorn) || (VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Cavalorn))
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_TEACH_08_01");	//Sure. What do you want to know?
		Cavalorn_Merke_Bow = other.HitChance[NPC_TALENT_BOW];
		Cavalorn_Merke_1h = other.HitChance[NPC_TALENT_1H];
	};
	B_BuildLearnDialog_Cavalorn();
};

func void DIA_Addon_Cavalorn_Teach_Sneak()
{
	if(B_TeachThiefTalent(self,other,NPC_TALENT_SNEAK))
	{
		AI_Output(self,other,"DIA_Addon_Cavalorn_Teach_Sneak_08_00");	//With soft soles, you have a better chance of getting close to your opponents without them noticing.
		Cavalorn_Sneak_Comment = TRUE;
		B_BuildLearnDialog_Cavalorn();
	};
};

func void DIA_Addon_Cavalorn_Teach_Bow_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,1,TeachLimit_Bow_Cavalorn))
	{
		B_BuildLearnDialog_Cavalorn();
	};
};

func void DIA_Addon_Cavalorn_Teach_Bow_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,5,TeachLimit_Bow_Cavalorn))
	{
		B_BuildLearnDialog_Cavalorn();
	};
};

func void DIA_Addon_Cavalorn_Teach_1H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,1,TeachLimit_1H_Cavalorn))
	{
		B_BuildLearnDialog_Cavalorn();
	};
};

func void DIA_Addon_Cavalorn_Teach_1H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,5,TeachLimit_1H_Cavalorn))
	{
		B_BuildLearnDialog_Cavalorn();
	};
};

func void DIA_Addon_Cavalorn_Teach_Back()
{
	if((Cavalorn_Merke_Bow < other.HitChance[NPC_TALENT_BOW]) || (Cavalorn_Merke_1h < other.HitChance[NPC_TALENT_1H]) || (Cavalorn_Sneak_Comment == TRUE))
	{
		if((CavalornWeakComment == TRUE) || (SC_ForgotAboutCavalorn == TRUE))
		{
			AI_Output(self,other,"DIA_Addon_Cavalorn_Teach_BACK_08_00");	//That's better. You've forgotten a lot since then, but we'll get it back.
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Cavalorn_Teach_BACK_08_00_add");	//That's better.
		};
	};
	Info_ClearChoices(DIA_Addon_Cavalorn_TEACH);
};

