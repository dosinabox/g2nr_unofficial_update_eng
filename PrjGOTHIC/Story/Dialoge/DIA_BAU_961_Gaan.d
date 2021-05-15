
var int GaanTeachHornOneTime;
var int DIA_Gaan_EXIT_oneTime;

func void B_GaanTeachHornComment()
{
	if((MIS_Gaan_Snapper == LOG_SUCCESS) && (Gaan_TeachPlayer == TRUE) && (GaanTeachHornOneTime == FALSE))
	{
		AI_Output(self,other,"DIA_Gaan_TEACHHUNTING_DrgSnapperHorn_03_00");	//“еперь, когда этот огромный снеппер мертв, € могу показать тебе, как вырезать его рог.
		GaanTeachHornOneTime = TRUE;
	};
};

instance DIA_Gaan_EXIT(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 999;
	condition = DIA_Gaan_EXIT_Condition;
	information = DIA_Gaan_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Gaan_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Gaan_EXIT_Info()
{
	B_GaanTeachHornComment();
	AI_StopProcessInfos(self);
	if(DIA_Gaan_EXIT_oneTime == FALSE)
	{
		Npc_ExchangeRoutine(self,"Start");
		DIA_Gaan_EXIT_oneTime = TRUE;
	};
};


instance DIA_Addon_Gaan_MeetingIsRunning(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 1;
	condition = DIA_Addon_Gaan_MeetingIsRunning_Condition;
	information = DIA_Addon_Gaan_MeetingIsRunning_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Addon_Gaan_MeetingIsRunning_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (RangerMeetingRunning == LOG_Running))
	{
		return TRUE;
	};
};


var int DIA_Addon_Gaan_MeetingIsRunning_One_time;

func void DIA_Addon_Gaan_MeetingIsRunning_Info()
{
	if(DIA_Addon_Gaan_MeetingIsRunning_One_time == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Gaan_MeetingIsRunning_03_00");	//A fresh face in our midst. Welcome to the 'Ring of Water'.
		DIA_Addon_Gaan_MeetingIsRunning_One_time = TRUE;
	};
	AI_Output(self,other,"DIA_Addon_Gaan_MeetingIsRunning_03_01");	//Vatras wants to see you. You had better go to him now.
	AI_StopProcessInfos(self);
};


instance DIA_Gaan_HALLO(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 3;
	condition = DIA_Gaan_HALLO_Condition;
	information = DIA_Gaan_HALLO_Info;
	description = "You've got a lot of space up here.";
};


func int DIA_Gaan_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Gaan_HALLO_Info()
{
	AI_Output (other, self, "DIA_Gaan_HALLO_15_00");	//You've got a lot of space up here.
	AI_Output (self, other, "DIA_Gaan_HALLO_03_01");	//It's nice enough. But if you go through the pass back there, you won't think so much longer.
	AI_Output (self, other, "DIA_Gaan_HALLO_03_02");	//If this little tract of land has impressed you, then wait till you see the Valley of Mines back there.
};


instance DIA_Gaan_WASMACHSTDU(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 4;
	condition = DIA_Gaan_WASMACHSTDU_Condition;
	information = DIA_Gaan_WASMACHSTDU_Info;
	description = "Who are you?";
};


func int DIA_Gaan_WASMACHSTDU_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Gaan_HALLO) && (self.aivar[AIV_TalkedToPlayer] == FALSE) && (RangerMeetingRunning != LOG_SUCCESS))
	if(Npc_KnowsInfo(other,DIA_Gaan_HALLO) && (RangerMeetingRunning != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Gaan_WASMACHSTDU_Info()
{
	AI_Output (other, self, "DIA_Gaan_WASMACHSTDU_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Gaan_WASMACHSTDU_03_01");	//My name is Gaan. I'm a hunter and work for Bengar, the farmer here on the high pastures.
	AI_Output (self, other, "DIA_Gaan_WASMACHSTDU_03_02");	//I spend most of my time here outside, basking in the sun.
};


instance DIA_Addon_Gaan_Ranger(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 2;
	condition = DIA_Addon_Gaan_Ranger_Condition;
	information = DIA_Addon_Gaan_Ranger_Info;
	description = "Why are you looking so solemn?";
};


func int DIA_Addon_Gaan_Ranger_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaan_HALLO) && AnyRangerRingEquipped() && (RangerMeetingRunning == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Gaan_Ranger_Info()
{
	AI_Output (other, self, "DIA_Addon_Gaan_Ranger_15_00");	//Why are you looking so solemn?
	AI_Output (self, other, "DIA_Addon_Gaan_Ranger_03_01");	//You're wearing our aquamarine ring.
	AI_Output (other, self, "DIA_Addon_Gaan_Ranger_15_02");	//You belong to the 'Ring of Water'?
	AI_Output (self, other, "DIA_Addon_Gaan_Ranger_03_03");	//I certainly do. Good to see a new face in our ranks.
	B_GivePlayerXP (XP_Ambient);
};


instance DIA_Addon_Gaan_AufgabeBeimRing(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 2;
	condition = DIA_Addon_Gaan_AufgabeBeimRing_Condition;
	information = DIA_Addon_Gaan_AufgabeBeimRing_Info;
	description = "What's your task within the 'Ring of Water'?";
};


func int DIA_Addon_Gaan_AufgabeBeimRing_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Addon_Gaan_Ranger) || (RangerMeetingRunning != FALSE)) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Addon_Gaan_AufgabeBeimRing_Info()
{
	AI_Output (other, self, "DIA_Addon_Gaan_AufgabeBeimRing_15_00");	//What's your task within the 'Ring of Water'?
	AI_Output (self, other, "DIA_Addon_Gaan_AufgabeBeimRing_03_01");	//I keep an eye on the entrance to the pass, to see who goes in and out.
	AI_Output (self, other, "DIA_Addon_Gaan_AufgabeBeimRing_03_02");	//Since the paladins have closed the gate to the pass, however, there hasn't been much coming and going.
};


instance DIA_Addon_Gaan_MissingPeople(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 2;
	condition = DIA_Addon_Gaan_MissingPeople_Condition;
	information = DIA_Addon_Gaan_MissingPeople_Info;
	description = "Have you heard of those missing people?";
};


func int DIA_Addon_Gaan_MissingPeople_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Gaan_AufgabeBeimRing) && (SC_HearedAboutMissingPeople == TRUE) && (MissingPeopleReturnedHome == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Gaan_MissingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Gaan_MissingPeople_15_00");	//Have you heard of those missing people?
	AI_Output (self, other, "DIA_Addon_Gaan_MissingPeople_03_01");	//Of course I have. That's why we're supposed to keep our eyes open.
	AI_Output (self, other, "DIA_Addon_Gaan_MissingPeople_03_02");	//But I haven't seen much that would give you a clue, to tell you the truth.
};


instance DIA_Gaan_WALD(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 5;
	condition = DIA_Gaan_WALD_Condition;
	information = DIA_Gaan_WALD_Info;
	description = "What do I need to know about the Valley of Mines?";
};


func int DIA_Gaan_WALD_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaan_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Gaan_WALD_Info()
{
	AI_Output (other, self, "DIA_Gaan_WALD_15_00");	//What do I need to know about the Valley of Mines?
	AI_Output (self, other, "DIA_Gaan_WALD_03_01");	//No idea. I've only taken a fleeting glance at the valley. Looked pretty dangerous.
	AI_Output (self, other, "DIA_Gaan_WALD_03_02");	//The best thing to do if you go there through the pass is to stay close to the beaten track.
	AI_Output (self, other, "DIA_Gaan_WALD_03_03");	//Either you take the way through the big gorge, or the road over the stone bridge. That one is shorter and safer.
	AI_Output (self, other, "DIA_Gaan_WALD_03_04");	//Now that the orcs are roaming all over the place, you have to be a bit careful.
	AI_Output (self, other, "DIA_Gaan_WALD_03_05");	//I don't want to have to drag you to the herb witch.
};


instance DIA_Gaan_SAGITTA(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 7;
	condition = DIA_Gaan_SAGITTA_Condition;
	information = DIA_Gaan_SAGITTA_Info;
	description = "Herb witch?";
};


func int DIA_Gaan_SAGITTA_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaan_WALD))
	{
		return TRUE;
	};
};

func void DIA_Gaan_SAGITTA_Info()
{
	AI_Output (other, self, "DIA_Gaan_SAGITTA_15_00");	//Herb witch?
	AI_Output (self, other, "DIA_Gaan_SAGITTA_03_01");	//Her name is Sagitta. She is the healer for the farmers and the other people who live outside the harbor city.
	AI_Output (self, other, "DIA_Gaan_SAGITTA_03_02");	//A truly curious female.
	AI_Output (self, other, "DIA_Gaan_SAGITTA_03_03");	//No one really likes going to her and everybody enjoys gossiping about her.
	AI_Output (self, other, "DIA_Gaan_SAGITTA_03_04");	//But if you're sick, you won't find better help than Sagitta and her kitchen full of healing herbs.
	AI_Output (self, other, "DIA_Gaan_SAGITTA_03_05");	//You'll find her in the strip of woods behind Sekob's farm.
};


instance DIA_Gaan_MONSTER(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 8;
	condition = DIA_Gaan_MONSTER_Condition;
	information = DIA_Gaan_MONSTER_Info;
	description = "What does this dangerous beast look like?";
};


func int DIA_Gaan_MONSTER_Condition()
{
	if(MIS_Gaan_Snapper == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Gaan_MONSTER_Info()
{
	AI_Output (other, self, "DIA_Gaan_MONSTER_15_00");	//What does this dangerous beast look like?
	AI_Output (self, other, "DIA_Gaan_MONSTER_03_01");	//I don't know exactly. Up to now, I've mostly heard grunting and scratching. But I've seen what it can do.
	AI_Output (self, other, "DIA_Gaan_MONSTER_03_02");	//Even wolves aren't safe from it. The beast even bit the head off of one.
};


instance DIA_Gaan_WASZAHLSTDU(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 9;
	condition = DIA_Gaan_WASZAHLSTDU_Condition;
	information = DIA_Gaan_WASZAHLSTDU_Info;
	description = "How much would you pay me if I killed that beast for you?";
};


func int DIA_Gaan_WASZAHLSTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaan_MONSTER) && (MIS_Gaan_Snapper == LOG_Running))
	{
		return TRUE;
	};
};

var int Gaan_Deal;

func void DIA_Gaan_WASZAHLSTDU_Info()
{
	AI_Output (other, self, "DIA_Gaan_WASZAHLSTDU_15_00");	//How much would you pay me if I killed that beast for you?
	AI_Output (self, other, "DIA_Gaan_WASZAHLSTDU_03_01");	//I'd give the person who killed it everything I could spare.
	if((Gaan_TeachPlayer == TRUE) && (Npc_HasItems(self,ItMi_Gold) >= 100))
	{
		Gaan_Deal = 150;
	}
	else
	{
		Gaan_Deal = 50;
	};
	B_Say_Gold(self,other,Gaan_Deal);
	MIS_Gaan_Deal = LOG_Running;
};


instance DIA_Gaan_WOHERMONSTER(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 10;
	condition = DIA_Gaan_WOHERMONSTER_Condition;
	information = DIA_Gaan_WOHERMONSTER_Info;
	description = "Where does this scummy beast come from?";
};


func int DIA_Gaan_WOHERMONSTER_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaan_MONSTER) && (MIS_Gaan_Snapper == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Gaan_WOHERMONSTER_Info()
{
	AI_Output (other, self, "DIA_Gaan_WOHERMONSTER_15_00");	//Where does this scummy beast come from?
	AI_Output (self, other, "DIA_Gaan_WOHERMONSTER_03_01");	//Somewhere from outside the woods. Maybe from the Valley of Mines. But I don't know for sure.
	AI_Output (self, other, "DIA_Gaan_WOHERMONSTER_03_02");	//I've never been to the Valley of Mines.
};


instance DIA_Gaan_MONSTERTOT(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 11;
	condition = DIA_Gaan_MONSTERTOT_Condition;
	information = DIA_Gaan_MONSTERTOT_Info;
	important = TRUE;
};


func int DIA_Gaan_MONSTERTOT_Condition()
{
	if(Npc_IsDead(Gaans_Snapper) && (RangerMeetingRunning != LOG_Running) && (MIS_Gaan_Snapper != LOG_SUCCESS) && (Npc_GetDistToWP(self,"NW_FARM3_GAAN") < 2000))
	{
		return TRUE;
	};
};

func void DIA_Gaan_MONSTERTOT_Info()
{
	AI_Output (self, other, "DIA_Gaan_MONSTERTOT_03_00");	//That horrible animal is dead, I assume.
	AI_Output (self, other, "DIA_Gaan_MONSTERTOT_03_01");	//Then I can finally hunt freely again.
	if (MIS_Gaan_Deal == LOG_Running)
	{
		CreateInvItems(self,ItMi_Gold,50);
		AI_Output(self,other,"DIA_Gaan_MONSTERTOT_03_02");	//Here's the money I promised you.
		AI_WaitTillEnd(other,self);
		B_GiveInvItems(self,other,ItMi_Gold,Gaan_Deal);
	};
	MIS_Gaan_Snapper = LOG_SUCCESS;
	B_GivePlayerXP(XP_Gaan_WaldSnapper);
	AI_StopProcessInfos(self);
};


instance DIA_Gaan_AskTeacher(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 10;
	condition = DIA_Gaan_AskTeacher_Condition;
	information = DIA_Gaan_AskTeacher_Info;
	description = "Can you teach me about hunting?";
};


func int DIA_Gaan_AskTeacher_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaan_WASMACHSTDU) || (RangerMeetingRunning == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Gaan_AskTeacher_Info()
{
	AI_Output(other,self,"DIA_Gaan_AskTeacher_15_00");	//Can you teach me about hunting?
	if((SC_IsRanger == TRUE) || Npc_KnowsInfo(other,DIA_Addon_Gaan_Ranger))
	{
		Gaan_TeachPlayer = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Gaan_AskTeacher_03_01");	//No problem. For 100 gold coins I can show you how to gut the animals you bring down.
	};
	AI_Output(self,other,"DIA_Gaan_AskTeacher_03_02");	//Pelts and other trophies bring a lot of money in the market.
	B_GaanTeachHornComment();
	Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_OutTeacher,"Gaan can teach me to take animal trophies.");
};


instance DIA_Gaan_PayTeacher(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 11;
	condition = DIA_Gaan_PayTeacher_Condition;
	information = DIA_Gaan_PayTeacher_Info;
	permanent = TRUE;
	description = "Here. 100 gold coins for your expertise on gutting animals. ";
};


func int DIA_Gaan_PayTeacher_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaan_AskTeacher) && (Gaan_TeachPlayer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Gaan_PayTeacher_Info()
{
	AI_Output (other, self, "DIA_Gaan_PayTeacher_15_00");	//Here. 100 gold coins for your expertise on gutting animals.
	if (B_GiveInvItems (other, self, ItMi_Gold, 100))
	{
		AI_Output (self, other, "DIA_Gaan_PayTeacher_03_01");	//Thanks. Now you're talking.
		Gaan_TeachPlayer = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Gaan_PayTeacher_03_02");	//Ask me later, when you have some money.
	};
};

instance DIA_Gaan_TEACHHUNTING(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 12;
	condition = DIA_Gaan_TEACHHUNTING_Condition;
	information = DIA_Gaan_TEACHHUNTING_Info;
	permanent = TRUE;
	description = "What can you teach me?";
};


func int DIA_Gaan_TEACHHUNTING_Condition()
{
	if(Gaan_TeachPlayer == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Gaan_TEACHHUNTING_Info()
{
	AI_Output(other,self,"DIA_Gaan_TEACHHUNTING_15_00");	//What can you teach me?
	if((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFSting] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFWing] == FALSE) || ((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DrgSnapperHorn] == FALSE) && (MIS_Gaan_Snapper == LOG_SUCCESS)))
	{
		AI_Output(self,other,"DIA_Gaan_TEACHHUNTING_03_01");	//That depends on what you want to know.
		B_GaanTeachHornComment();
		Info_AddChoice(DIA_Gaan_TEACHHUNTING,Dialog_Back,DIA_Gaan_TEACHHUNTING_BACK);
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] == FALSE)
		{
			Info_AddChoice(DIA_Gaan_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Teeth,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Teeth)),DIA_Gaan_TEACHHUNTING_Teeth);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE)
		{
			Info_AddChoice(DIA_Gaan_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Claws,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Claws)),DIA_Gaan_TEACHHUNTING_Claws);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE)
		{
			Info_AddChoice(DIA_Gaan_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Fur,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_Fur)),DIA_Gaan_TEACHHUNTING_Fur);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFSting] == FALSE)
		{
			Info_AddChoice(DIA_Gaan_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_BFSting,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_BFSting)),DIA_Gaan_TEACHHUNTING_BFSting);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFWing] == FALSE)
		{
			Info_AddChoice(DIA_Gaan_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_BFWing,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_BFWing)),DIA_Gaan_TEACHHUNTING_BFWing);
		};
		if((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DrgSnapperHorn] == FALSE) && (MIS_Gaan_Snapper == LOG_SUCCESS))
		{
			Info_AddChoice(DIA_Gaan_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_DrgSnapperHorn,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_DrgSnapperHorn)),DIA_Gaan_TEACHHUNTING_DrgSnapperHorn);
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_03_02");	//At the moment, I can't teach you anything you don't already know. Sorry.
	};
};

func void DIA_Gaan_TEACHHUNTING_BACK()
{
	Info_ClearChoices(DIA_Gaan_TEACHHUNTING);
};

func void DIA_Gaan_TEACHHUNTING_Claws()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Claws))
	{
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_Claws_03_00");	//Animals don't like to give up their claws. You have to place your knife very precisely.
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_Claws_03_01");	//Your hands should be slightly crossed. Then you separate the claw with a powerful tug.
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_Claws_03_02");	//Merchants are always eager to be paid in claws.
	};
	Info_ClearChoices(DIA_Gaan_TEACHHUNTING);
};

func void DIA_Gaan_TEACHHUNTING_Teeth()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Teeth))
	{
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_Teeth_03_00");	//The easiest thing to take from an animal are the teeth. You move your knife around the teeth in its mouth.
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_Teeth_03_01");	//Then you separate them from the skull with a skillful tug.
	};
	Info_ClearChoices(DIA_Gaan_TEACHHUNTING);
};

func void DIA_Gaan_TEACHHUNTING_Fur()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Fur))
	{
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_Fur_03_00");	//The best way to remove the pelt is by making a deep cut along the hind legs.
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_Fur_03_01");	//After that, it should be a cinch to pull off the skin from the front to the back.
	};
	Info_ClearChoices(DIA_Gaan_TEACHHUNTING);
};

func void DIA_Gaan_TEACHHUNTING_BFSting()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_BFSting))
	{
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_BFSting_03_00");	//These flies have a soft spot on their backs.
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_BFSting_03_01");	//If you press there, the stinger will be squeezed out very far, and you can detach it with your knife.
	};
	Info_ClearChoices(DIA_Gaan_TEACHHUNTING);
};

func void DIA_Gaan_TEACHHUNTING_BFWing()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_BFWing))
	{
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_BFWing_03_00");	//The best way to remove the wings of a bloodfly is with a blow from a sharp knife, very close to the fly's body.
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_BFWing_03_01");	//You have to watch out that you don't damage the delicate tissue of the wings. They're worthless if you don't do it carefully.
	};
	Info_ClearChoices(DIA_Gaan_TEACHHUNTING);
};

func void DIA_Gaan_TEACHHUNTING_DrgSnapperHorn()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_DrgSnapperHorn))
	{
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_DrgSnapperHorn_03_01");	//You push your knife deep into the animal's forehead and carefully lever the thing upwards.
		AI_Output (self, other, "DIA_Gaan_TEACHHUNTING_DrgSnapperHorn_03_02");	//If it won't come loose from the skull, you work on it with a second knife from the other side.
		CreateInvItems(Gaans_Snapper,ItAt_DrgSnapperHorn,2);
	};
	Info_ClearChoices(DIA_Gaan_TEACHHUNTING);
};


instance DIA_Gaan_JAGD(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 80;
	condition = DIA_Gaan_JAGD_Condition;
	information = DIA_Gaan_JAGD_Info;
	permanent = TRUE;
	description = "How's the hunting?";
};


func int DIA_Gaan_JAGD_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Gaan_WASMACHSTDU) || (RangerMeetingRunning == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void B_WasMachtJagd()
{
	AI_Output (other, self, "DIA_Gaan_JAGD_15_00");	//How's the hunting?
};

func void DIA_Gaan_JAGD_Info()
{
	B_WasMachtJagd();
//	if(!Npc_IsDead(Gaans_Snapper) && (Kapitel < 3))
	if((MIS_Gaan_Snapper != LOG_SUCCESS) && (Kapitel < 3))
	{
		AI_Output(self,other,"DIA_Gaan_JAGD_03_01");	//The last animal I could bring down was a large rat. Not very encouraging, and bad for business.
		AI_Output(self,other,"DIA_Gaan_JAGD_03_02");	//For several days now, some kind of snorting beast has been roaming the area.
		AI_Output(self,other,"DIA_Gaan_JAGD_03_03");	//It not only kills everything that moves, it also interferes with my work.
		if(Npc_IsDead(Gaans_Snapper))
		{
			DIA_Common_HeIsDead();
			AI_Output(self,other,"DIA_Gaan_MONSTERTOT_03_01");	//Then I can finally hunt freely again.
			MIS_Gaan_Snapper = LOG_SUCCESS;
			B_GivePlayerXP(XP_Gaan_WaldSnapper);
			AI_StopProcessInfos(self);
			Npc_ExchangeRoutine(self,"Start");
		}
		else if((MIS_Gaan_Snapper != LOG_Running) && (MIS_Gaan_Snapper != LOG_SUCCESS))
		{
			Log_CreateTopic(TOPIC_GaanSchnaubi,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_GaanSchnaubi,LOG_Running);
			B_LogEntry(TOPIC_GaanSchnaubi,"That snorting creature's causing trouble for the hunter Gaan. Unless I defeat the beast, he can't go hunting any more.");
			MIS_Gaan_Snapper = LOG_Running;
		};
	}
	else if(Kapitel >= 3)
	{
		AI_Output (self, other, "DIA_Gaan_JAGD_03_04");	//It's getting crazier out here. Meanwhile, dozens of these snorting animals have come out of the pass.
		AI_Output (self, other, "DIA_Gaan_JAGD_03_05");	//Under these circumstances, hunting is getting harder and harder up here.
	}
	else
	{
		AI_Output (self, other, "DIA_Gaan_JAGD_03_06");	//I can't complain.
	};
};


instance DIA_Gaan_PICKPOCKET(C_Info)
{
	npc = BAU_961_Gaan;
	nr = 900;
	condition = DIA_Gaan_PICKPOCKET_Condition;
	information = DIA_Gaan_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Gaan_PICKPOCKET_Condition()
{
	return C_Beklauen(23,35);
};

func void DIA_Gaan_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Gaan_PICKPOCKET);
	Info_AddChoice(DIA_Gaan_PICKPOCKET,Dialog_Back,DIA_Gaan_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Gaan_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Gaan_PICKPOCKET_DoIt);
};

func void DIA_Gaan_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Gaan_PICKPOCKET);
};

func void DIA_Gaan_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Gaan_PICKPOCKET);
};


