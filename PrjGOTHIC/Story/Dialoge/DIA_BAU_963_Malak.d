
instance DIA_Malak_EXIT(C_Info)
{
	npc = BAU_963_Malak;
	nr = 999;
	condition = DIA_Malak_EXIT_Condition;
	information = DIA_Malak_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Malak_EXIT_Condition()
{
	if(Kapitel < 3)
	{
		return TRUE;
	};
};

func void DIA_Malak_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Malak_HALLO(C_Info)
{
	npc = BAU_963_Malak;
	nr = 3;
	condition = DIA_Malak_HALLO_Condition;
	information = DIA_Malak_HALLO_Info;
	description = "Everything all right?";
};


func int DIA_Malak_HALLO_Condition()
{
	if(Kapitel < 3)
	{
		return TRUE;
	};
};

func void DIA_Malak_HALLO_Info()
{
	AI_Output (other, self, "DIA_Malak_HALLO_15_00");	//Everything all right?
	if (hero.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Malak_HALLO_08_01");	//Yet another day laborer who doesn't know where to go? No problem. Talk with our farmer Bengar.
	}
	else
	{
		AI_Output (self, other, "DIA_Malak_HALLO_08_02");	//Sure.
	};
};


instance DIA_Malak_WASMACHSTDU(C_Info)
{
	npc = BAU_963_Malak;
	nr = 4;
	condition = DIA_Malak_WASMACHSTDU_Condition;
	information = DIA_Malak_WASMACHSTDU_Info;
	description = "What are you doing here?";
};


func int DIA_Malak_WASMACHSTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Malak_HALLO) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_WASMACHSTDU_Info()
{
	AI_Output (other, self, "DIA_Malak_WASMACHSTDU_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Malak_WASMACHSTDU_08_01");	//I'm the shepherd here. It's not exactly a demanding job.
	AI_Output (self, other, "DIA_Malak_WASMACHSTDU_08_02");	//But now and then, you really have to watch out. Especially if you get too close to the pass.
};


instance DIA_Malak_PASS(C_Info)
{
	npc = BAU_963_Malak;
	nr = 5;
	condition = DIA_Malak_PASS_Condition;
	information = DIA_Malak_PASS_Info;
	description = "What do you know about the pass?";
};


func int DIA_Malak_PASS_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Malak_WASMACHSTDU) || Npc_KnowsInfo(other,DIA_Malak_WOPASS)) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_PASS_Info()
{
	AI_Output (other, self, "DIA_Malak_PASS_15_00");	//What do you know about the pass?
	AI_Output (self, other, "DIA_Malak_PASS_08_01");	//Not much. Just that it leads to the old Valley of Mines that was surrounded by the Barrier until a few weeks ago.
	AI_Output (self, other, "DIA_Malak_PASS_08_02");	//Back then, the only thing we farmers had to be afraid of was the monthly caravan that took all kinds of goods to the Valley of Mines.
	AI_Output (self, other, "DIA_Malak_PASS_08_03");	//Those cut-throats often made life difficult for us out here.
};


instance DIA_Malak_WOPASS(C_Info)
{
	npc = BAU_963_Malak;
	nr = 6;
	condition = DIA_Malak_WOPASS_Condition;
	information = DIA_Malak_WOPASS_Info;
	description = "Where can I find the pass to the old Valley of Mines?";
};


func int DIA_Malak_WOPASS_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Malak_HALLO) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_WOPASS_Info()
{
	AI_Output (other, self, "DIA_Malak_WOPASS_15_00");	//Where can I find the pass to the old Valley of Mines?
	AI_Output (self, other, "DIA_Malak_WOPASS_08_01");	//Near the two waterfalls on the other side of the high pastures.
};


instance DIA_Malak_MINENTAL(C_Info)
{
	npc = BAU_963_Malak;
	nr = 7;
	condition = DIA_Malak_MINENTAL_Condition;
	information = DIA_Malak_MINENTAL_Info;
	description = "What is it they say about the Valley of Mines?";
};


func int DIA_Malak_MINENTAL_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Malak_PASS) || Npc_KnowsInfo(other,DIA_Malak_WOPASS)) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_MINENTAL_Info()
{
	AI_Output (other, self, "DIA_Malak_MINENTAL_15_00");	//What is it they say about the Valley of Mines?
	AI_Output (self, other, "DIA_Malak_MINENTAL_08_01");	//All sorts of things. Some of the boys say they've heard screams at night, some have seen strange lights over the mountains.
	AI_Output (self, other, "DIA_Malak_MINENTAL_08_02");	//But if you ask me, it's all just old wives' tales.
};


instance DIA_Malak_WARSTDUSCHONDA(C_Info)
{
	npc = BAU_963_Malak;
	nr = 8;
	condition = DIA_Malak_WARSTDUSCHONDA_Condition;
	information = DIA_Malak_WARSTDUSCHONDA_Info;
	description = "Have you ever been to the Valley of Mines?";
};


func int DIA_Malak_WARSTDUSCHONDA_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Malak_PASS) || Npc_KnowsInfo(other,DIA_Malak_WOPASS)) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_WARSTDUSCHONDA_Info()
{
	AI_Output (other, self, "DIA_Malak_WARSTDUSCHONDA_15_00");	//Have you ever been to the Valley of Mines?
	AI_Output (self, other, "DIA_Malak_WARSTDUSCHONDA_08_01");	//No. But I go near the pass once in a while. Then I always see those two paladins who stand around and keep watch.
	AI_Output (self, other, "DIA_Malak_WARSTDUSCHONDA_08_02");	//It looks like they're making sure that nothing comes out of the valley.
	AI_Output (self, other, "DIA_Malak_WARSTDUSCHONDA_08_03");	//Back then the Valley of Mines was a natural prison. If you went in, you never came out again.
};


instance DIA_Malak_PALADINE(C_Info)
{
	npc = BAU_963_Malak;
	nr = 9;
	condition = DIA_Malak_PALADINE_Condition;
	information = DIA_Malak_PALADINE_Info;
	description = "Tell me more about the paladins. How long have they been posted there?";
};


func int DIA_Malak_PALADINE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Malak_WARSTDUSCHONDA) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_PALADINE_Info()
{
	AI_Output (other, self, "DIA_Malak_PALADINE_15_00");	//Tell me more about the paladins. How long have they been posted there?
	AI_Output (self, other, "DIA_Malak_PALADINE_08_01");	//A week or two, I suppose. I don't know exactly.
	AI_Output (self, other, "DIA_Malak_PALADINE_08_02");	//Some time ago there was even a whole troop of them that disappeared into the pass. Since then, I haven't seen them again.
};


instance DIA_Malak_KEINEFRAUEN(C_Info)
{
	npc = BAU_963_Malak;
	nr = 10;
	condition = DIA_Malak_KEINEFRAUEN_Condition;
	information = DIA_Malak_KEINEFRAUEN_Info;
	description = "I don't see any women here at all.";
};


func int DIA_Malak_KEINEFRAUEN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Malak_WASMACHSTDU) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_KEINEFRAUEN_Info()
{
	AI_Output (other, self, "DIA_Malak_KEINEFRAUEN_15_00");	//I don't see any women here at all.
	AI_Output (self, other, "DIA_Malak_KEINEFRAUEN_08_01");	//You got that right. This is a men's farm, so to speak. Works pretty well, I think.
};


instance DIA_Malak_PERMKAP1(C_Info)
{
	npc = BAU_963_Malak;
	nr = 11;
	condition = DIA_Malak_PERMKAP1_Condition;
	information = DIA_Malak_PERMKAP1_Info;
	permanent = TRUE;
	description = "Don't work too hard.";
};


func int DIA_Malak_PERMKAP1_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Malak_HALLO) && Npc_KnowsInfo(other,DIA_Malak_WASMACHSTDU) && Npc_KnowsInfo(other,DIA_Malak_PASS) && Npc_KnowsInfo(other,DIA_Malak_MINENTAL) && Npc_KnowsInfo(other,DIA_Malak_WARSTDUSCHONDA) && Npc_KnowsInfo(other,DIA_Malak_PALADINE) && Npc_KnowsInfo(other,DIA_Malak_KEINEFRAUEN) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_PERMKAP1_Info()
{
	AI_Output (other, self, "DIA_Malak_PERMKAP1_15_00");	//Don't work too hard.
	AI_Output (self, other, "DIA_Malak_PERMKAP1_08_01");	//I'll try.
	AI_StopProcessInfos (self);
};


instance DIA_Malak_KAP3_EXIT(C_Info)
{
	npc = BAU_963_Malak;
	nr = 999;
	condition = DIA_Malak_KAP3_EXIT_Condition;
	information = DIA_Malak_KAP3_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Malak_KAP3_EXIT_Condition()
{
	if(Kapitel >= 3)
	{
		return TRUE;
	};
};

func void DIA_Malak_KAP3_EXIT_Info()
{
	B_NpcClearObsessionByDMT(self);
};


instance DIA_Malak_FLEEFROMPASS(C_Info)
{
	npc = BAU_963_Malak;
	nr = 30;
	condition = DIA_Malak_FLEEFROMPASS_Condition;
	information = DIA_Malak_FLEEFROMPASS_Info;
	description = "What are you doing here?";
};


func int DIA_Malak_FLEEFROMPASS_Condition()
{
	if(Kapitel >= 3)
	{
		return TRUE;
	};
};

func void DIA_Malak_FLEEFROMPASS_Info()
{
	AI_Output(other,self,"DIA_Malak_FLEEFROMPASS_15_00");	//What are you doing here?
	if((NpcObsessedByDMT_Malak == FALSE) && (hero.guild == GIL_KDF))
	{
		B_NpcObsessedByDMT(self);
	}
	else
	{
		AI_Output(self,other,"DIA_Malak_FLEEFROMPASS_08_01");	//I fled here from Bengar's farm. I didn't want to be butchered by all the creatures coming out of the pass.
		AI_Output(self,other,"DIA_Malak_FLEEFROMPASS_08_02");	//You can't imagine what sort of things came out of the pass the last few days.
		AI_Output(other,self,"DIA_Malak_FLEEFROMPASS_15_03");	//I can.
		MIS_GetMalakBack = LOG_Running;
		if(!Npc_KnowsInfo(other,DIA_Bengar_ALLEIN))
		{
			Log_CreateTopic(TOPIC_BengarMALAK,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_BengarMALAK,LOG_Running);
		};
		B_LogEntry(TOPIC_BengarMALAK,"Malak's entrenched himself in the south because he's scared of the creatures that were coming up to the high pastures from the pass.");
		B_GivePlayerXP(XP_FoundMalakFLEEFROMPASS);
	};
};


var int Malak_DementorCommentLog;

func void B_Malak_DementorComment()
{
	AI_Output(self,other,"DIA_Malak_BACKTOBENGAR_08_01_add");	//I'm not budging an inch from here!@@@
	if(Malak_DementorCommentLog == FALSE)
	{
		if(MIS_GetMalakBack != LOG_Running)
		{
			MIS_GetMalakBack = LOG_Running;
			Log_CreateTopic(TOPIC_BengarMALAK,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_BengarMALAK,LOG_Running);
		};
		B_LogEntry(TOPIC_BengarMALAK,"Those people in the black hoods are everywhere! Malak will not leave until that one found nearby is gone.");
		Malak_DementorCommentLog = TRUE;
	};
};

func void B_Malak_BackToBengar()
{
	MalakIsBackToBengar = TRUE;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Start");
	B_StartOtherRoutine(BAU_962_Bauer,"Start");
	B_StartOtherRoutine(BAU_964_Bauer,"Start");
	B_StartOtherRoutine(BAU_965_Bauer,"Start");
	B_StartOtherRoutine(BAU_966_Bauer,"Start");
	B_StartOtherRoutine(BAU_967_Bauer,"Start");
	B_StartOtherRoutine(BAU_968_Bauer,"Start");
	B_StartOtherRoutine(BAU_969_Bauer,"Start");
};

var int DIA_Malak_Heilung_oneTime;

instance DIA_Malak_Heilung(C_Info)
{
	npc = BAU_963_Malak;
	nr = 55;
	condition = DIA_Malak_Heilung_Condition;
	information = DIA_Malak_Heilung_Info;
	permanent = TRUE;
	description = "You need help.";
};


func int DIA_Malak_Heilung_Condition()
{
	if((NpcObsessedByDMT_Malak == TRUE) && (NpcObsessedByDMT == FALSE) && (hero.guild == GIL_KDF) && (Kapitel >= 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_Heilung_Info()
{
	AI_Output (other, self, "DIA_Malak_Heilung_15_00");	//You need help.
	if (DIA_Malak_Heilung_oneTime == FALSE)
	{
		if(!Npc_IsDead(DMT_DementorAmbientMalak))
		{
			B_Malak_DementorComment();
		}
		else
		{
			AI_Output(self,other,"DIA_Malak_Heilung_08_01");	//(weepy) I just want to go home. I'll go back to Bengar. I hope he's still alive.
			B_NpcClearObsessionByDMT(self);
			B_Malak_BackToBengar();
			DIA_Malak_Heilung_oneTime = TRUE;
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Malak_Heilung_08_02");	//Leave me alone, magician. I can manage.
		B_NpcClearObsessionByDMT (self);
	};
};


instance DIA_Malak_PERMCASTLE(C_Info)
{
	npc = BAU_963_Malak;
	nr = 31;
	condition = DIA_Malak_PERMCASTLE_Condition;
	information = DIA_Malak_PERMCASTLE_Info;
	permanent = TRUE;
	description = "What's it like here?";
};


func int DIA_Malak_PERMCASTLE_Condition()
{
	if((Npc_GetDistToWP(self,"CASTLEMINE") < 4000) && (MalakIsBackToBengar == FALSE) && Npc_KnowsInfo(other,DIA_Malak_FLEEFROMPASS) && (NpcObsessedByDMT_Malak == FALSE) && (hero.guild != GIL_KDF) && (Kapitel >= 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_PERMCASTLE_Info()
{
	AI_Output (other, self, "DIA_Malak_PERMCASTLE_15_00");	//What's it like here?
	AI_Output (self, other, "DIA_Malak_PERMCASTLE_08_01");	//Here I only have to put up with bandits. It's the lesser evil.
};


instance DIA_Malak_BACKTOBENGAR(C_Info)
{
	npc = BAU_963_Malak;
	nr = 31;
	condition = DIA_Malak_BACKTOBENGAR_Condition;
	information = DIA_Malak_BACKTOBENGAR_Info;
	permanent = TRUE;
	description = "Bengar needs you. He wants you to come back to his farm.";
};


func int DIA_Malak_BACKTOBENGAR_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Malak_FLEEFROMPASS) && Npc_KnowsInfo(other,DIA_Bengar_ALLEIN) && !Npc_IsDead(Bengar) && (NpcObsessedByDMT_Malak == FALSE) && (hero.guild != GIL_KDF) && (Kapitel >= 3) && (MalakIsBackToBengar == FALSE))
	{
		return TRUE;
	};
};

var int DIA_Malak_BACKTOBENGAR_Once;

func void DIA_Malak_BACKTOBENGAR_Info()
{
	AI_Output(other,self,"DIA_Malak_BACKTOBENGAR_15_00");	//Bengar needs you. He wants you to come back to his farm.
	if(!Npc_IsDead(DMT_DementorAmbientMalak))
	{
		B_Malak_DementorComment();
	}
	else
	{
		AI_Output(self,other,"DIA_Malak_BACKTOBENGAR_08_01");	//I'm not crazy. As long as we have to live defenseless on the farm, I'm not budging an inch from here!
		if(DIA_Malak_BACKTOBENGAR_Once == FALSE)
		{
			B_LogEntry(TOPIC_BengarMALAK,"Malak won't return to Bengar's farm while it's unprotected.");
			DIA_Malak_BACKTOBENGAR_Once = TRUE;
		};
		if(MIS_BengarsHelpingSLD == LOG_SUCCESS)
		{
			AI_Output(other,self,"DIA_Malak_BACKTOBENGAR_15_02");	//I've hired a mercenary. He will keep an eye on the farm.
			AI_Output(self,other,"DIA_Malak_BACKTOBENGAR_08_03");	//That's different, of course. But wait a minute. Who's paying the guy, then?
			AI_Output(other,self,"DIA_Malak_BACKTOBENGAR_15_04");	//That's my problem.
			AI_Output(self,other,"DIA_Malak_BACKTOBENGAR_08_05");	//(inquisitive) Mmh. No chance to say no, eh?
			Info_ClearChoices(DIA_Malak_BACKTOBENGAR);
			Info_AddChoice(DIA_Malak_BACKTOBENGAR,"No.",DIA_Malak_BACKTOBENGAR_los);
		};
	};
};

func void DIA_Malak_BACKTOBENGAR_los()
{
	AI_Output(other,self,"DIA_Malak_BACKTOBENGAR_los_15_00");	//No.
	AI_Output(self,other,"DIA_Malak_BACKTOBENGAR_los_08_01");	//Good. Then I'll go back. I hope the lad's good for something.
	B_GivePlayerXP(XP_Malak_BACKTOBENGAR);
	B_NpcClearObsessionByDMT(self);
	B_Malak_BackToBengar();
};


instance DIA_Malak_BACK(C_Info)
{
	npc = BAU_963_Malak;
	nr = 32;
	condition = DIA_Malak_BACK_Condition;
	information = DIA_Malak_BACK_Info;
	permanent = TRUE;
	description = "Will you stay on Bengar's farm now?";
};


func int DIA_Malak_BACK_Condition()
{
	if((MalakIsBackToBengar == TRUE) && (Npc_GetDistToWP(self,"FARM3") < 3000) && (NpcObsessedByDMT_Malak == FALSE) && (hero.guild != GIL_KDF) && (Kapitel >= 3))
	{
		return TRUE;
	};
};

func void DIA_Malak_BACK_Info()
{
	AI_Output (other, self, "DIA_Malak_BACK_15_00");	//Will you stay on Bengar's farm now?
	AI_Output (self, other, "DIA_Malak_BACK_08_01");	//Sure. I'll have to see this through now. We'll manage somehow.
	B_NpcClearObsessionByDMT(self);
};


instance DIA_Malak_PICKPOCKET(C_Info)
{
	npc = BAU_963_Malak;
	nr = 900;
	condition = DIA_Malak_PICKPOCKET_Condition;
	information = DIA_Malak_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Malak_PICKPOCKET_Condition()
{
	return C_Beklauen(43,40);
};

func void DIA_Malak_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Malak_PICKPOCKET);
	Info_AddChoice(DIA_Malak_PICKPOCKET,Dialog_Back,DIA_Malak_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Malak_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Malak_PICKPOCKET_DoIt);
};

func void DIA_Malak_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Malak_PICKPOCKET);
};

func void DIA_Malak_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Malak_PICKPOCKET);
};

