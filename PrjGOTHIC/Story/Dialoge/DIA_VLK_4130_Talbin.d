
instance DIA_Talbin_EXIT(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 999;
	condition = DIA_Talbin_EXIT_Condition;
	information = DIA_Talbin_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Talbin_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Talbin_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


var int Talbin_Runs;

instance DIA_Talbin_HALLO(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 5;
	condition = DIA_Talbin_HALLO_Condition;
	information = DIA_Talbin_HALLO_Info;
	important = TRUE;
};


func int DIA_Talbin_HALLO_Condition()
{
	if(Kapitel <= 3)
	{
		return TRUE;
	};
};

func void DIA_Talbin_HALLO_Info()
{
	AI_Output (self, other, "DIA_Talbin_HALLO_07_00");	//Halt! Stop right where you are!
	AI_Output (other, self, "DIA_Talbin_HALLO_15_01");	//Ack! No problem!
	AI_Output (self, other, "DIA_Talbin_HALLO_07_02");	//Really! Another lost little lamb, huh? At first, I took you for one of those evil bastards who are haunting the area.
	AI_Output (self, other, "DIA_Talbin_HALLO_07_03");	//I can see you're probably not one of them. You look much too harmless!
	self.npcType = NPCTYPE_FRIEND;
};


instance DIA_Talbin_WASMACHTIHR(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 6;
	condition = DIA_Talbin_WASMACHTIHR_Condition;
	information = DIA_Talbin_WASMACHTIHR_Info;
	description = "You look like a hunter who doesn't know what to do with his time.";
};


func int DIA_Talbin_WASMACHTIHR_Condition()
{
	if(Talbin_Runs == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Talbin_WASMACHTIHR_Info()
{
	AI_Output (other, self, "DIA_Talbin_WASMACHTIHR_15_00");	//You look like a hunter who doesn't know what to do with his time.
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_07_01");	//Ha-ha! Yep - you've got a point there. But what am I to do - I cannot get back across the pass!
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_07_02");	//So I'm just staying here, doing what I do best.
	if(!Npc_IsDead(Engrom))
	{
		AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_07_03");	//I'm sorry, though, for my pal Engrom.
	};
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_07_04");	//Come close to my fire and warm yourself up.
	Info_ClearChoices (DIA_Talbin_WASMACHTIHR);
	Info_AddChoice (DIA_Talbin_WASMACHTIHR, Dialog_Back, DIA_Talbin_WASMACHTIHR_back);
	Info_AddChoice (DIA_Talbin_WASMACHTIHR, "You seem to be doing all right, though.", DIA_Talbin_WASMACHTIHR_gut);
	Info_AddChoice (DIA_Talbin_WASMACHTIHR, "Are you a former prisoner of the Barrier?", DIA_Talbin_WASMACHTIHR_strf);
};

func void DIA_Talbin_WASMACHTIHR_back()
{
	Info_ClearChoices(DIA_Talbin_WASMACHTIHR);
};

func void DIA_Talbin_WASMACHTIHR_strf()
{
	AI_Output (other, self, "DIA_Talbin_WASMACHTIHR_strf_15_00");	//Are you a former prisoner of the Barrier?
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_strf_07_01");	//No, no! What are you thinking? I actually meant to strike it rich out here.
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_strf_07_02");	//Someone from around here told me that these are the best hunting grounds there are.
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_strf_07_03");	//Rich pickings, if you know what I mean.
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_strf_07_04");	//The only thing that is to be had here since those orcs have shown up is a punch in the face if you venture out too far!
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_strf_07_05");	//And I let those idiots put a flea in my ear.
	AI_Output (other, self, "DIA_Talbin_WASMACHTIHR_strf_15_06");	//I know those jokers!
};

func void DIA_Talbin_WASMACHTIHR_gut()
{
	AI_Output (other, self, "DIA_Talbin_WASMACHTIHR_gut_15_00");	//You seem to be doing all right, though.
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_gut_07_01");	//Oh well! I guess I can't complain. In spite of those blasted orcs, the areas by the river are the least dangerous.
	AI_Output (self, other, "DIA_Talbin_WASMACHTIHR_gut_07_02");	//It looks like they don't dare go near the water. Mmh. Just a coincidence, maybe.
};


instance DIA_Talbin_SORRYFORENGROM(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 7;
	condition = DIA_Talbin_SORRYFORENGROM_Condition;
	information = DIA_Talbin_SORRYFORENGROM_Info;
	description = "Why are you sorry for Engrom?";
};


func int DIA_Talbin_SORRYFORENGROM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_WASMACHTIHR) && !Npc_IsDead(Engrom) && (Talbin_FollowsThroughPass == FALSE) && (Kapitel <= 3) && (Talbin_Runs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_SORRYFORENGROM_Info()
{
	AI_Output (other, self, "DIA_Talbin_SORRYFORENGROM_15_00");	//Why are you sorry for Engrom?
	AI_Output (self, other, "DIA_Talbin_SORRYFORENGROM_07_01");	//Because he simply followed me without asking any questions.
	AI_Output (self, other, "DIA_Talbin_SORRYFORENGROM_07_02");	//And now we've gotten ourselves into this mess. Greed doesn't pay after all.
};


instance DIA_Talbin_WASJAGDIHR(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 8;
	condition = DIA_Talbin_WASJAGDIHR_Condition;
	information = DIA_Talbin_WASJAGDIHR_Info;
	description = "What are you hunting here by the river?";
};


func int DIA_Talbin_WASJAGDIHR_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_WASMACHTIHR) && (Talbin_FollowsThroughPass == FALSE) && (Talbin_Runs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_WASJAGDIHR_Info()
{
	AI_Output (other, self, "DIA_Talbin_WASJAGDIHR_15_00");	//What are you hunting here by the river?
	AI_Output (self, other, "DIA_Talbin_WASJAGDIHR_07_01");	//What a question! Just take a stroll along the river and you'll know what I'm hunting here. Lurkers, of course!
	AI_Output (self, other, "DIA_Talbin_WASJAGDIHR_07_02");	//Those things aren't easy to catch, but they taste all the better for it.
	AI_Output (self, other, "DIA_Talbin_WASJAGDIHR_07_03");	//Once in a while, I stumble across a scavenger, too. I don't turn up my nose at those, either!
};


instance DIA_Talbin_ENGROMANGRY(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 9;
	condition = DIA_Talbin_ENGROMANGRY_Condition;
	information = DIA_Talbin_ENGROMANGRY_Info;
	description = "I think your buddy is a little stressed out!";
};


func int DIA_Talbin_ENGROMANGRY_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Engrom_WhatAboutLeaving) && Npc_KnowsInfo(other,DIA_Talbin_SORRYFORENGROM) && !Npc_IsDead(Engrom) && (Talbin_FollowsThroughPass == FALSE) && (Kapitel <= 3) && (Talbin_Runs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_ENGROMANGRY_Info()
{
	AI_Output (other, self, "DIA_Talbin_ENGROMANGRY_15_00");	//I think your buddy is a little stressed out!
	AI_Output (self, other, "DIA_Talbin_ENGROMANGRY_07_01");	//Just cut it out. Don't provoke him any further, or he'll have my head. At this point, there's nothing I can do about us being here.
	AI_Output (self, other, "DIA_Talbin_ENGROMANGRY_07_02");	//I'll make up for it some day!
};


instance DIA_Talbin_AskTeacher(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 10;
	condition = DIA_Talbin_AskTeacher_Condition;
	information = DIA_Talbin_AskTeacher_Info;
	description = "Ты можешь научить меня охотиться?";
};


func int DIA_Talbin_AskTeacher_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_WASJAGDIHR) && (Talbin_FollowsThroughPass == FALSE) && (Talbin_Runs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_AskTeacher_Info()
{
	AI_Output (other, self, "DIA_Talbin_AskTeacher_15_00");	//Can you teach me something about hunting?
	AI_Output (self, other, "DIA_Talbin_AskTeacher_07_01");	//I see! So you've acquired a taste for it now. All right. But it'll cost you!
	AI_Output (other, self, "DIA_Talbin_AskTeacher_15_02");	//What do you want for it?
	AI_Output (self, other, "DIA_Talbin_AskTeacher_07_03");	//Would you happen to have anything to eat other than lurker meat? Maybe a hunk of cheese. Yes, a hunk of cheese. I could die for a hunk ...
	AI_Output (other, self, "DIA_Talbin_AskTeacher_15_04");	//I'll see what I can do.
	MIS_TalbinCheese = LOG_Running;
	Log_CreateTopic(TOPIC_TalbinCheese,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_TalbinCheese,LOG_Running);
	B_LogEntry(TOPIC_TalbinCheese,"Talbin, the hunter in the Valley of Mines can teach me how to take animal trophies if I bring him cheese.");
};


instance DIA_Talbin_PayTeacher(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 11;
	condition = DIA_Talbin_PayTeacher_Condition;
	information = DIA_Talbin_PayTeacher_Info;
	permanent = TRUE;
	description = "Here's your cheese. Will you teach me now?";
};


func int DIA_Talbin_PayTeacher_Condition()
{
	if((MIS_TalbinCheese == LOG_Running) && Npc_HasItems(other,ItFo_Cheese))
	{
		return TRUE;
	};
};

func void DIA_Talbin_PayTeacher_Info()
{
	AI_Output(other,self,"DIA_Talbin_PayTeacher_15_00");	//Here's your cheese. Will you teach me now?
	B_GiveInvItems(other,self,ItFo_Cheese,1);
	AI_Output(self,other,"DIA_Talbin_PayTeacher_07_01");	//Really, you've got some? Oh man, it's been ages since I ate something like that. Thank you. Er, what about ... oh yeah. Sure!
	Talbin_TeachAnimalTrophy = TRUE;
	Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_OutTeacher,"Talbin can teach me to take animal trophies.");
	MIS_TalbinCheese = LOG_SUCCESS;
	B_CheckLog();
};

instance DIA_Talbin_PayTeacher_NoCheese(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 11;
	condition = DIA_Talbin_PayTeacher_NoCheese_Condition;
	information = DIA_Talbin_PayTeacher_NoCheese_Info;
	permanent = TRUE;
	description = "У меня сейчас нет сыра!";
};


func int DIA_Talbin_PayTeacher_NoCheese_Condition()
{
	if((MIS_TalbinCheese == LOG_Running) && !Npc_HasItems(other,ItFo_Cheese))
	{
		return TRUE;
	};
};

func void DIA_Talbin_PayTeacher_NoCheese_Info()
{
	AI_Output(other,self,"DIA_Talbin_PayTeacher_15_02");	//I don't have any cheese at the moment!
	AI_Output(self,other,"DIA_Talbin_PayTeacher_07_03");	//It would just have been too good to be true. Tell me when you've got some!
};


instance DIA_Talbin_TEACHHUNTING(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 12;
	condition = DIA_Talbin_TEACHHUNTING_Condition;
	information = DIA_Talbin_TEACHHUNTING_Info;
	permanent = TRUE;
	description = "What can you teach me?";
};


func int DIA_Talbin_TEACHHUNTING_Condition()
{
	if((Talbin_TeachAnimalTrophy == TRUE) && (Talbin_FollowsThroughPass == FALSE) && (Talbin_Runs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_TEACHHUNTING_Info()
{
	DIA_Common_WhatCanYouTeachMe();
	if((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ShadowHorn] == FALSE) || (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Heart] == FALSE))
	{
		AI_Output (self, other, "DIA_Talbin_TEACHHUNTING_07_01");	//What do you want to know?
		Info_AddChoice (DIA_Talbin_TEACHHUNTING, Dialog_Back, DIA_Talbin_TEACHHUNTING_BACK);
		if (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE)
		{
			Info_AddChoice(DIA_Talbin_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Claws,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Claws)),DIA_Talbin_TEACHHUNTING_Claws);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE)
		{
			Info_AddChoice(DIA_Talbin_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Fur,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_Fur)),DIA_Talbin_TEACHHUNTING_Fur);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ShadowHorn] == FALSE)
		{
			Info_AddChoice(DIA_Talbin_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_ShadowHorn,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_ShadowHorn)),DIA_Talbin_TEACHHUNTING_ShadowHorn);
		};
		if(PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Heart] == FALSE)
		{
			Info_AddChoice(DIA_Talbin_TEACHHUNTING,B_BuildLearnString(NAME_TROPHY_Heart,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Heart)),DIA_Talbin_TEACHHUNTING_Heart);
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Talbin_TEACHHUNTING_07_02");	//I'll have to disappoint you there. You already know everything I could teach you. Still, thanks again for the cheese!
	};
};

func void DIA_Talbin_TEACHHUNTING_BACK()
{
	Info_ClearChoices(DIA_Talbin_TEACHHUNTING);
};

func void DIA_Talbin_TEACHHUNTING_Claws()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Claws))
	{
		AI_Output (self, other, "DIA_Talbin_TEACHHUNTING_Claws_07_00");	//Chopping off claws is quite simple. You just grab the claw directly at the joint and press it down to the ground.
		AI_Output (self, other, "DIA_Talbin_TEACHHUNTING_Claws_07_01");	//Then you take your knife and carefully cut off the claw.
	};
	Info_ClearChoices(DIA_Talbin_TEACHHUNTING);
};

func void DIA_Talbin_TEACHHUNTING_Fur()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Fur))
	{
		AI_Output (self, other, "DIA_Talbin_TEACHHUNTING_Fur_07_00");	//The easiest way to skin a lurker is to make a cut along the length of its belly ...
		AI_Output (self, other, "DIA_Talbin_TEACHHUNTING_Fur_07_01");	//... then tug on its hind legs and thus pull off the skin in one piece from back to front.
	};
	Info_ClearChoices(DIA_Talbin_TEACHHUNTING);
};

func void DIA_Talbin_TEACHHUNTING_ShadowHorn()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_ShadowHorn))
	{
		AI_Output (self, other, "DIA_Talbin_TEACHHUNTING_ShadowHorn_07_00");	//Shadowbeast horns are very hard and can be used to create statues or tools.
	};
	Info_ClearChoices(DIA_Talbin_TEACHHUNTING);
};

func void DIA_Talbin_TEACHHUNTING_Heart()
{
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Heart))
	{
		AI_Output (self, other, "DIA_Talbin_TEACHHUNTING_Heart_07_00");	//Hearts of magical beings are very rare and hard to obtain. Be careful when you try that, especially with any kind of golem.
	};
	Info_ClearChoices(DIA_Talbin_TEACHHUNTING);
};

instance DIA_Talbin_KAP4_WASNEUES(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 13;
	condition = DIA_Talbin_KAP4_WASNEUES_Condition;
	information = DIA_Talbin_KAP4_WASNEUES_Info;
	description = "Have you seen anyone come by here?";
};


func int DIA_Talbin_KAP4_WASNEUES_Condition()
{
//	if((Kapitel >= 4) && (Talbin_FollowsThroughPass == FALSE) && (Talbin_Runs == FALSE))
	if((Kapitel >= 4) && (Talbin_FollowsThroughPass == FALSE) && (Talbin_Runs == FALSE) && Npc_KnowsInfo(other,DIA_Garond_BACKINKAP4))
	{
		return TRUE;
	};
};

func void DIA_Talbin_KAP4_WASNEUES_Info()
{
	AI_Output (other, self, "DIA_Talbin_KAP4_WASNEUES_15_00");	//Have you seen anyone come by here?
	AI_Output (self, other, "DIA_Talbin_KAP4_WASNEUES_07_01");	//Yes. There's been some mighty funny fellows running around here lately! They strut about in spiffed-up armor and act all important.
};


instance DIA_Talbin_KAP4_WASWOLLTENDJG(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 14;
	condition = DIA_Talbin_KAP4_WASWOLLTENDJG_Condition;
	information = DIA_Talbin_KAP4_WASWOLLTENDJG_Info;
	description = "What did those 'funny fellows' want here?";
};


func int DIA_Talbin_KAP4_WASWOLLTENDJG_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_KAP4_WASNEUES) && (Kapitel >= 4) && (Talbin_FollowsThroughPass == FALSE) && (Talbin_Runs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_KAP4_WASWOLLTENDJG_Info()
{
	AI_Output (other, self, "DIA_Talbin_KAP4_WASWOLLTENDJG_15_00");	//What did those 'funny fellows' want here?
	AI_Output (self, other, "DIA_Talbin_KAP4_WASWOLLTENDJG_07_01");	//They asked me about provisions and equipment. Man, I've barely got enough for myself!
	AI_Output (self, other, "DIA_Talbin_KAP4_WASWOLLTENDJG_07_02");	//They were going on about killing dragons and such. Lord knows where those boys came from, but they didn't look particularly trustworthy!
	if (Kapitel == 4)
	{
		B_LogEntry (TOPIC_Dragonhunter, "Some Dragon Hunters stopped by Talbin the Hunter's place.");
	};
};


instance DIA_Talbin_WOENGROM(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 15;
	condition = DIA_Talbin_WOENGROM_Condition;
	information = DIA_Talbin_WOENGROM_Info;
	description = "Are you alone here at the moment?";
};


func int DIA_Talbin_WOENGROM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_WASMACHTIHR) && (Kapitel >= 4) && (Talbin_FollowsThroughPass == FALSE) && (EngromIsGone == TRUE) && (Talbin_Runs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_WOENGROM_Info()
{
	AI_Output (other, self, "DIA_Talbin_WOENGROM_15_00");	//Are you alone here at the moment?
	AI_Output (self, other, "DIA_Talbin_WOENGROM_07_01");	//Yes. My buddy Engrom has up and left. Yesterday he said he was having a vision - someone speaking to him very softly.
	AI_Output (self, other, "DIA_Talbin_WOENGROM_07_02");	//I didn't hear a thing. I just thought to myself, he's gone off the deep end ...
	AI_Output (self, other, "DIA_Talbin_WOENGROM_07_03");	//... and then he was suddenly gone. I've no idea where he went.
	AI_Output (self, other, "DIA_Talbin_WOENGROM_07_04");	//If you should see Engrom anywhere, tell him he still owes me a lurker skin, the bastard.
	if (Npc_KnowsInfo (other, DIA_Engrom_WhatAboutLeaving))
	{
		AI_Output (other, self, "DIA_Talbin_WOENGROM_15_05");	//But I was under the impression that he didn't even want to leave here until the orcs are gone.
		AI_Output (self, other, "DIA_Talbin_WOENGROM_07_06");	//Like I said - something's wrong with him.
	};
	MIS_Tabin_LookForEngrom = LOG_Running;
};


instance DIA_Talbin_FOUNDENGROM(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 16;
	condition = DIA_Talbin_FOUNDENGROM_Condition;
	information = DIA_Talbin_FOUNDENGROM_Info;
	description = "I found your buddy Engrom.";
};


func int DIA_Talbin_FOUNDENGROM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_WOENGROM) && ((NpcObsessedByDMT_Engrom == TRUE) || Npc_HasItems(other,ItAt_TalbinsLurkerSkin)) && (Kapitel >= 4) && (Talbin_FollowsThroughPass == FALSE) && (Talbin_Runs == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_FOUNDENGROM_Info()
{
	AI_Output (other, self, "DIA_Talbin_FOUNDENGROM_15_00");	//I found your buddy Engrom.
	AI_Output (self, other, "DIA_Talbin_FOUNDENGROM_07_01");	//Yes? Where is he?
	if (Npc_IsDead (Engrom))
	{
		AI_Output (other, self, "DIA_Talbin_FOUNDENGROM_15_02");	//He's dead.
	}
	else
	{
		AI_Output (other, self, "DIA_Talbin_FOUNDENGROM_15_03");	//I don't think you'll see him ever again.
	};
	if(B_GiveInvItems(other,self,ItAt_TalbinsLurkerSkin,1))
	{
		AI_Output (other, self, "DIA_Talbin_FOUNDENGROM_15_04");	//Here. I found this lurker skin on him.
	};
	if(hero.guild == GIL_KDF)
	{
		AI_Output (other, self, "DIA_Talbin_FOUNDENGROM_15_05");	//The Seekers have taken possession of him.
		AI_Output (self, other, "DIA_Talbin_FOUNDENGROM_07_06");	//The Seekers? Who's that supposed to be?
		AI_Output (other, self, "DIA_Talbin_FOUNDENGROM_15_07");	//Henchmen of the nether realms. They are the true leaders of the orcs.
	};
	AI_Output(self,other,"DIA_Talbin_FOUNDENGROM_07_08");	//By Innos. I need to get out of here, even if it kills me. Now or never!
	AI_StopProcessInfos(self);
	MIS_TalbinCheese = LOG_OBSOLETE;
	MIS_Talbin_Runs = LOG_Running;
	Log_CreateTopic(TOPIC_Talbin_Runs,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Talbin_Runs,LOG_Running);
	B_LogEntry(TOPIC_Talbin_Runs,"Talbin, the hunter from the Valley of Mines, ran to the pass like there were swarms of bloodflies at his heels. I think he's headed for Khorinis.");
	B_GivePlayerXP(XP_Ambient);
	Npc_ExchangeRoutine(self,"FleePass");
	Wld_InsertNpc(Snapper,"START");
	Talbin_Runs = TRUE;
};


instance DIA_Talbin_WOHIN(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 17;
	condition = DIA_Talbin_WOHIN_Condition;
	information = DIA_Talbin_WOHIN_Info;
	permanent = TRUE;
	description = "Where will you go? ";
};


func int DIA_Talbin_WOHIN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Talbin_FOUNDENGROM) && (Talbin_FollowsThroughPass == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Talbin_WOHIN_Info()
{
	AI_Output (other, self, "DIA_Talbin_WOHIN_15_00");	//Where will you go?
	if (Npc_GetDistToWP (self, "START") < 1000)
	{
		AI_Output (self, other, "DIA_Talbin_WOHIN_07_01");	//Take me across the pass. Please!!
		Info_ClearChoices (DIA_Talbin_WOHIN);
		Info_AddChoice (DIA_Talbin_WOHIN, "I don't have time for you.", DIA_Talbin_WOHIN_);
		Info_AddChoice (DIA_Talbin_WOHIN, "Just go ahead and cross.", DIA_Talbin_WOHIN_durch);
		Info_AddChoice (DIA_Talbin_WOHIN, "All right.", DIA_Talbin_WOHIN_ok);
	}
	else
	{
		AI_Output (self, other, "DIA_Talbin_WOHIN_07_02");	//I must get out of here, across the pass. Out of my way!
		AI_StopProcessInfos (self);
	};
};

func void DIA_Talbin_WOHIN_ok()
{
	AI_Output (other, self, "DIA_Talbin_WOHIN_ok_15_00");	//All right.
	AI_Output (self, other, "DIA_Talbin_WOHIN_ok_07_01");	//Thank you. When you cross, I'll simply follow you.
	if(self.attribute[ATR_HITPOINTS] == 1)
	{
		self.attribute[ATR_HITPOINTS] += 1;
	};
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"IntoPass");
	Talbin_FollowsThroughPass = LOG_Running;
	MIS_TalbinCheese = LOG_OBSOLETE;
	B_CheckLog();
	self.flags = NPC_FLAG_IMMORTAL;
};

func void DIA_Talbin_WOHIN_durch()
{
	AI_Output (other, self, "DIA_Talbin_WOHIN_durch_15_00");	//Just go ahead and cross.
	AI_Output (self, other, "DIA_Talbin_WOHIN_durch_07_01");	//It's so dark in there. No way am I going in there by myself.
};

func void DIA_Talbin_WOHIN_()
{
	AI_Output (other, self, "DIA_Talbin_WOHIN_schwein_15_00");	//I don't have time for you.
	AI_Output (self, other, "DIA_Talbin_WOHIN_schwein_07_01");	//Simply leaving me here to croak. You'll fry in hell for this!
	Talbin_FollowsThroughPass = LOG_OBSOLETE;
	MIS_Talbin_Runs = LOG_OBSOLETE;
	MIS_TalbinCheese = LOG_FAILED;
	B_CheckLog();
	AI_StopProcessInfos(self);
};


instance DIA_Talbin_VERSCHWINDE(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 15;
	condition = DIA_Talbin_VERSCHWINDE_Condition;
	information = DIA_Talbin_VERSCHWINDE_Info;
	permanent = TRUE;
	description = "Hey.";
};


func int DIA_Talbin_VERSCHWINDE_Condition()
{
	if(Talbin_FollowsThroughPass == LOG_OBSOLETE)
	{
		return TRUE;
	};
};

func void DIA_Talbin_VERSCHWINDE_Info()
{
	AI_Output (other, self, "DIA_Talbin_VERSCHWINDE_15_00");	//Hey.
	AI_Output (self, other, "DIA_Talbin_VERSCHWINDE_07_01");	//Get lost. I can get along without you, scumbag!
	AI_StopProcessInfos(self);
};


instance DIA_Talbin_PICKPOCKET(C_Info)
{
	npc = VLK_4130_Talbin;
	nr = 900;
	condition = DIA_Talbin_PICKPOCKET_Condition;
	information = DIA_Talbin_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Talbin_PICKPOCKET_Condition()
{
	return C_Beklauen(40,25);
};

func void DIA_Talbin_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Talbin_PICKPOCKET);
	Info_AddChoice(DIA_Talbin_PICKPOCKET,Dialog_Back,DIA_Talbin_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Talbin_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Talbin_PICKPOCKET_DoIt);
};

func void DIA_Talbin_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Talbin_PICKPOCKET);
};

func void DIA_Talbin_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Talbin_PICKPOCKET);
};

