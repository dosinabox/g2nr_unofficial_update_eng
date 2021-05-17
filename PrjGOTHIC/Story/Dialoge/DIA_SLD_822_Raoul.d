
instance DIA_Raoul_EXIT(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 999;
	condition = DIA_Raoul_EXIT_Condition;
	information = DIA_Raoul_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Raoul_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Raoul_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Raoul_NoSentenza(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 1;
	condition = DIA_Raoul_NoSentenza_Condition;
	information = DIA_Raoul_NoSentenza_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Raoul_NoSentenza_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Sentenza_Hello) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Raoul_NoSentenza_Info()
{
	AI_Output (self, other, "DIA_Raoul_NoSentenza_01_00");	//Wait a minute, pal!
	AI_Output (self, other, "DIA_Raoul_NoSentenza_01_01");	//I didn't see Sentenza search you.
	if (Hlp_IsValidNpc (Sentenza) && !C_NpcIsDown (Sentenza))
	{
		AI_TurnToNPC(self,Sentenza);
		AI_Output(self,other,"DIA_Raoul_NoSentenza_01_02");	//SENTENZA! Come here!
		AI_TurnToNPC(self,other);
		AI_Output (self, other, "DIA_Raoul_NoSentenza_01_03");	//(feigned polite) One moment, he'll be right here!
		AI_Output (self, other, "DIA_Raoul_NoSentenza_01_04");	//Then you're in for a nasty surprise!
		B_Attack(Sentenza,other,AR_NONE,0);
	}
	else
	{
		AI_PlayAni(self,"T_SEARCH");
		AI_Output(self,other,"DIA_Raoul_NoSentenza_01_05");	//Where is he, anyway? Well, doesn't matter, you got lucky...
	};
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"Start");
};


instance DIA_Raoul_Hello(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 1;
	condition = DIA_Raoul_Hello_Condition;
	information = DIA_Raoul_Hello_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Raoul_Hello_Condition()
{
	if((other.guild == GIL_NONE) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Raoul_Hello_Info()
{
	if(self.aivar[AIV_TalkedToPlayer] == FALSE)
	{
		AI_Output (self, other, "DIA_Raoul_Hello_01_00");	//(bored) What do you want?
	}
	else
	{
		AI_Output(self,other,"DIA_Raoul_Hello_01_01");	//(annoyed) What do you want this time?
	};
	if(Npc_KnowsInfo(other,DIA_Sentenza_Hello))
	{
		Npc_ExchangeRoutine(self,"Start");
	};
};


var int Raoul_gesagt;

instance DIA_Raoul_PERMNone(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 1;
	condition = DIA_Raoul_PERMNone_Condition;
	information = DIA_Raoul_PERMNone_Info;
	permanent = TRUE;
	description = "I want to have a look around the farm!";
};


func int DIA_Raoul_PERMNone_Condition()
{
	if(other.guild != GIL_DJG)
	{
		return TRUE;
	};
};

func void DIA_Raoul_PERMNone_Info()
{
	AI_Output(other,self,"DIA_Raoul_PERMNone_15_00");	//I want to have a look around the farm!
	if((Raoul_gesagt == FALSE) && (MIS_ReadyforChapter4 == FALSE))
	{
		AI_Output (self, other, "DIA_Raoul_PERMNone_01_01");	//Don't go into the building on the left. Sylvio's in there. He's not in a good mood right now.
		AI_Output (self, other, "DIA_Raoul_PERMNone_01_02");	//If he sees a weakling who doesn't belong on the farm, he might get the idea of venting his bad mood on him.
		Raoul_gesagt = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Raoul_PERMNone_01_03");	//Have fun!
		AI_StopProcessInfos (self);
	};
};


instance DIA_Raoul_WannaJoin(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 2;
	condition = DIA_Raoul_WannaJoin_Condition;
	information = DIA_Raoul_WannaJoin_Info;
	permanent = FALSE;
	description = "I want to join up with Lee!";
};


func int DIA_Raoul_WannaJoin_Condition()
{
	if(other.guild == GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_Raoul_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Raoul_WannaJoin_15_00");	//I want to join up with Lee!
	AI_Output (self, other, "DIA_Raoul_WannaJoin_01_01");	//Lee won't have much to say around here if he keeps on this way!
	AI_Output (other, self, "DIA_Raoul_WannaJoin_15_02");	//What do you mean?
	AI_Output (self, other, "DIA_Raoul_WannaJoin_01_03");	//He wants us all to sit around here and twiddle our thumbs. Intimidate a few farmers now and then, and that's it.
	AI_Output (self, other, "DIA_Raoul_WannaJoin_01_04");	//Sylvio always says offense is the best defense, and damn right he is.
};


instance DIA_Raoul_AboutSylvio(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 2;
	condition = DIA_Raoul_AboutSylvio_Condition;
	information = DIA_Raoul_AboutSylvio_Info;
	permanent = FALSE;
	description = "Who is Sylvio?";
};


func int DIA_Raoul_AboutSylvio_Condition()
{
	if((Raoul_gesagt == TRUE) || Npc_KnowsInfo(other,DIA_Raoul_WannaJoin))
	{
		return TRUE;
	};
};

func void DIA_Raoul_AboutSylvio_Info()
{
	AI_Output(other,self,"DIA_Raoul_AboutSylvio_15_00");	//Who is Sylvio?
	if(other.guild == GIL_NONE)
	{
		AI_Output(self,other,"DIA_Raoul_AboutSylvio_01_01");	//Our next leader, if you ask me. If you plan on asking him if you can join us - forget it!
		if(self.aivar[AIV_DefeatedByPlayer] == FALSE)
		{
			AI_Output(self,other,"DIA_Raoul_AboutSylvio_01_02");	//You look like you're barely good for herding sheep.
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Raoul_AboutSylvio_01_01_add");	//Наш следующий предводитель, если тебе интересно мое мнение.@@@
	};
};


func void B_Raoul_GetLost()
{
	AI_Output(self,other,"DIA_Raoul_TROLL_weg_01_01");	//Yeah. Beat it.
	AI_StopProcessInfos(self);
};

var int Raoul_Voted;

instance DIA_Raoul_Stimme(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 2;
	condition = DIA_Raoul_Stimme_Condition;
	information = DIA_Raoul_Stimme_Info;
	permanent = TRUE;
	description = "I'd like to become a mercenary here. Do you mind?";
};


func int DIA_Raoul_Stimme_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Raoul_WannaJoin) && (other.guild == GIL_NONE) && (Raoul_Voted == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Raoul_Stimme_Info()
{
	AI_Output(other,self,"DIA_Raoul_Stimme_15_00");	//I'd like to become a mercenary here. Do you mind?
	if(self.aivar[AIV_DefeatedByPlayer] == TRUE)
	{
		AI_Output(self,other,"DIA_Raoul_Stimme_01_01");	//Aah, do whatever you want...
		if(Torlof_GenugStimmen == FALSE)
		{
			Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
		};
		B_LogEntry(TOPIC_SLDRespekt,"Raoul doesn't mind my joining the mercenaries.");
		Raoul_Voted = TRUE;
	}
	else
	{
		B_Raoul_GetLost();
	};
};


instance DIA_Raoul_Duell(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 2;
	condition = DIA_Raoul_Duell_Condition;
	information = DIA_Raoul_Duell_Info;
	permanent = TRUE;
	description = "Methinks I'm going to punch you in the face ...";
};


func int DIA_Raoul_Duell_Condition()
{
	if(((Raoul_gesagt == TRUE) || Npc_KnowsInfo(other,DIA_Raoul_AboutSylvio) || Npc_KnowsInfo(other,DIA_Jarvis_MissionKO)) && (MIS_ReadyforChapter4 == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Raoul_Duell_Info()
{
	AI_Output (other, self, "DIA_Raoul_Duell_15_00");	//Methinks I'm going to punch you in the face ...
	AI_Output (self, other, "DIA_Raoul_Duell_01_01");	//What?
	AI_Output (other, self, "DIA_Raoul_Duell_15_02");	//That's exactly what you need right now ...
	AI_Output (self, other, "DIA_Raoul_Duell_01_03");	//I've been too nice to you so far, haven't I?
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};


instance DIA_Raoul_PERM(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 900;
	condition = DIA_Raoul_PERM_Condition;
	information = DIA_Raoul_PERM_Info;
	permanent = TRUE;
	description = "Everything else all right?";
};


func int DIA_Raoul_PERM_Condition()
{
	if(other.guild != GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_Raoul_PERM_Info()
{
	AI_Output (other, self, "DIA_Raoul_PERM_15_00");	//Everything else all right?
	if (MIS_Raoul_KillTrollBlack == LOG_Running)
	{
		AI_Output (self, other, "DIA_Raoul_PERM_01_01");	//Don't babble so much. Go and get me that black troll hide.
	}
	else
	{
		AI_Output(self,other,"DIA_Raoul_PERM_01_02");	//Are you trying to get on my good side now, or what? Beat it!
		if(self.aivar[AIV_DefeatedByPlayer] == TRUE)
		{
			AI_Output (self, other, "DIA_Raoul_PERM_01_03");	//I haven't forgotten what you did to me.
		};
	};
};


instance DIA_Raoul_TROLL(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 2;
	condition = DIA_Raoul_TROLL_Condition;
	information = DIA_Raoul_TROLL_Info;
	important = TRUE;
};


func int DIA_Raoul_TROLL_Condition()
{
	if(hero.guild != GIL_NONE)
	{
		return TRUE;
	};
};

func void DIA_Raoul_TROLL_Info()
{
	AI_Output (self, other, "DIA_Raoul_TROLL_01_00");	//(cynical) Will you look at that!
	AI_Output (other, self, "DIA_Raoul_TROLL_15_01");	//What do you want?
	if((VisibleGuild(other) == GIL_MIL) || (VisibleGuild(other) == GIL_PAL))
	{
		AI_Output (self, other, "DIA_Raoul_TROLL_01_02");	//Have you joined the city beggars? Looks like it.
	};
	if((VisibleGuild(other) == GIL_SLD) || (VisibleGuild(other) == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Raoul_TROLL_01_03");	//Don't think that I respect you now, just because you're one of us.
	};
	if((VisibleGuild(other) == GIL_NOV) || (VisibleGuild(other) == GIL_KDF) || (VisibleGuild(other) == GIL_KDW))
	{
		AI_Output (self, other, "DIA_Raoul_TROLL_01_04");	//Playing the grand magician here, eh?
	};
	AI_Output (self, other, "DIA_Raoul_TROLL_01_05");	//I'll tell you something. No matter what you're wearing, I can see right through you.
	AI_Output (self, other, "DIA_Raoul_TROLL_01_06");	//To me, you're just a greasy little idler, nothing more.
	Info_ClearChoices (DIA_Raoul_TROLL);
	Info_AddChoice (DIA_Raoul_TROLL, "I've got to go.", DIA_Raoul_TROLL_weg);
	Info_AddChoice (DIA_Raoul_TROLL, "What's your problem?", DIA_Raoul_TROLL_rechnung);
};

func void DIA_Raoul_TROLL_weg()
{
	AI_Output(other,self,"DIA_Raoul_TROLL_weg_15_00");	//I've got to go.
	B_Raoul_GetLost();
};

func void DIA_Raoul_TROLL_rechnung()
{
	AI_Output (other, self, "DIA_Raoul_TROLL_rechnung_15_00");	//What's your problem?
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_01_01");	//I know people of your sort. All talk, no guts.
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_01_02");	//I detest somebody who dresses up all important and brags about his heroic deeds.
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_01_03");	//Just yesterday, I slugged one of the boys here in the mouth, because he claimed he could bring down a black troll with one hand tied behind his back.
	AI_Output (other, self, "DIA_Raoul_TROLL_rechnung_15_04");	//So what?
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_01_05");	//(tartly) What's that supposed to mean, 'so what'?
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_01_06");	//Have you ever even seen a black troll, big mouth? Do you have any idea how big those monsters are, man?
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_01_07");	//If you get just one step too close to them, they'll tear you to pieces.
	Info_ClearChoices (DIA_Raoul_TROLL);
	Info_AddChoice (DIA_Raoul_TROLL, "That doesn't concern me.", DIA_Raoul_TROLL_rechnung_hastrecht);
	if (Npc_IsDead (Troll_Black))
	{
		Info_AddChoice (DIA_Raoul_TROLL, "I've killed a black troll already.", DIA_Raoul_TROLL_rechnung_ich);
	}
	else
	{
		Info_AddChoice (DIA_Raoul_TROLL, "Black troll? No problem.", DIA_Raoul_TROLL_rechnung_noProb);
	};
};

func void B_Raoul_Blame()
{
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_B_Raoul_Blame_01_00");	//You're asking for it, huh? I ought to rip your head off. But I've got a better idea.
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_B_Raoul_Blame_01_01");	//If you're such a great fighter, then prove it.
	AI_Output (other, self, "DIA_Raoul_TROLL_rechnung_B_Raoul_Blame_15_02");	//What's in it for me?
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_B_Raoul_Blame_01_03");	//Stupid question. Your honor and your jaw in one piece?
	AI_Output (other, self, "DIA_Raoul_TROLL_rechnung_B_Raoul_Blame_15_04");	//That's not a whole lot, is it?
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_B_Raoul_Blame_01_05");	//Mmh. Shall we say, I'll pay you a ton of money if you bring me the hide of a black troll. How's that sound?
	AI_Output (other, self, "DIA_Raoul_TROLL_rechnung_B_Raoul_Blame_15_06");	//Better.
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_B_Raoul_Blame_01_07");	//Then what are you waiting for?
	MIS_Raoul_KillTrollBlack = LOG_Running;
	Log_CreateTopic(TOPIC_KillTrollBlack,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_KillTrollBlack,LOG_Running);
	B_LogEntry(TOPIC_KillTrollBlack,"Raoul wants me to bring him the hide of a black troll.");
	Info_ClearChoices(DIA_Raoul_TROLL);
};

func void DIA_Raoul_TROLL_rechnung_hastrecht()
{
	AI_Output (other, self, "DIA_Raoul_TROLL_rechnung_hastrecht_15_00");	//I'm not interested.
	AI_Output (self, other, "DIA_Raoul_TROLL_rechnung_hastrecht_01_01");	//That's probably better for you.
	Info_ClearChoices (DIA_Raoul_TROLL);
};

func void DIA_Raoul_TROLL_rechnung_ich()
{
	AI_Output(other,self,"DIA_Raoul_TROLL_rechnung_ich_15_00");	//I've killed a black troll already.
	if(TrollBlackFurWasted == FALSE)
	{
		B_Raoul_Blame();
	}
	else
	{
		B_Raoul_GetLost();
	};
};

func void DIA_Raoul_TROLL_rechnung_noProb()
{
	AI_Output(other,self,"DIA_Raoul_TROLL_rechnung_noProb_15_00");	//Black troll? No problem.
	B_Raoul_Blame();
};


instance DIA_Raoul_TrophyFur(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 3;
	condition = DIA_Raoul_TrophyFur_Condition;
	information = DIA_Raoul_TrophyFur_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Сначала скажи мне, как снять шкуру с черного тролля.",B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_Fur));
	description = B_BuildLearnString(NAME_TROPHY_Fur,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALFUR,TROPHY_Fur));
};


func int DIA_Raoul_TrophyFur_Condition()
{
	if((PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] == FALSE) && (MIS_Raoul_KillTrollBlack == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Raoul_TrophyFur_Info()
{
	AI_Output (other, self, "DIA_Raoul_TrophyFur_15_00");	//First tell me how to get the hide off the troll.
	if (B_TeachPlayerTalentTakeAnimalTrophy (self, other, TROPHY_Fur))
	{
		AI_Output (self, other, "DIA_Raoul_TrophyFur_01_01");	//Then open your ears. This tip is for free.
		AI_Output (self, other, "DIA_Raoul_TrophyFur_01_02");	//You grab the beast and cut a slit in each of his legs.
		AI_Output (self, other, "DIA_Raoul_TrophyFur_01_03");	//Then you pull the thing's skin over its ears. Is that difficult or what?
	};
};


instance DIA_Raoul_TROLLFELL(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 3;
	condition = DIA_Raoul_TROLLFELL_Condition;
	information = DIA_Raoul_TROLLFELL_Info;
	description = "I've got the hide of a black troll.";
};


func int DIA_Raoul_TROLLFELL_Condition()
{
	if(Npc_HasItems(other,ItAt_TrollBlackFur) && Npc_KnowsInfo(other,DIA_Raoul_TROLL))
	{
		return TRUE;
	};
};

func void DIA_Raoul_TROLLFELL_Info()
{
	AI_Output (other, self, "DIA_Raoul_TROLLFELL_15_00");	//I've got the hide of a black troll.
	AI_Output (self, other, "DIA_Raoul_TROLLFELL_01_01");	//Impossible. Show me.
	B_GiveInvItems (other, self, ItAt_TrollBlackFur, 1);
	AI_Output (self, other, "DIA_Raoul_TROLLFELL_01_02");	//Incredible. What do you want for it?
	AI_Output (other, self, "DIA_Raoul_TROLLFELL_15_03");	//Give me what you've got.
	AI_Output (self, other, "DIA_Raoul_TROLLFELL_01_04");	//Okay. I'll give you 500 gold pieces and toss in three strong healing potions, what do you say?
	Info_ClearChoices (DIA_Raoul_TROLLFELL);
	Info_AddChoice (DIA_Raoul_TROLLFELL, "That's not enough.", DIA_Raoul_TROLLFELL_nein);
	Info_AddChoice (DIA_Raoul_TROLLFELL, "Done.", DIA_Raoul_TROLLFELL_ja);
	MIS_Raoul_KillTrollBlack = LOG_SUCCESS;
	B_GivePlayerXP(XP_Raoul_KillTrollBlack);
};

func void DIA_Raoul_TROLLFELL_ja()
{
	AI_Output (other, self, "DIA_Raoul_TROLLFELL_ja_15_00");	//Sold.
	AI_Output (self, other, "DIA_Raoul_TROLLFELL_ja_01_01");	//It was a pleasure.
	CreateInvItems(other,ItPo_Health_03,3);
	CreateInvItems(other,ItMi_Gold,500);
	AI_PrintScreen("Received: Elixir of Healing (3)",-1,40,FONT_ScreenSmall,4);
	AI_PrintScreen("Received: 500 gold",-1,43,FONT_ScreenSmall,4);
	Info_ClearChoices(DIA_Raoul_TROLLFELL);
};

func void DIA_Raoul_TROLLFELL_nein()
{
	AI_Output (other, self, "DIA_Raoul_TROLLFELL_nein_15_00");	//That's not enough.
	AI_Output (self, other, "DIA_Raoul_TROLLFELL_nein_01_01");	//Suit yourself. I'll keep the hide, anyway.
	AI_Output (self, other, "DIA_Raoul_TROLLFELL_nein_01_02");	//I'm not going to let this chance slip through my fingers.
	MIS_Raoul_DoesntPayTrollFur = LOG_Running;
	AI_StopProcessInfos(self);
};


instance DIA_Raoul_FELLZURUECK(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 3;
	condition = DIA_Raoul_FELLZURUECK_Condition;
	information = DIA_Raoul_FELLZURUECK_Info;
	permanent = TRUE;
	description = "Give me my troll hide back.";
};


func int DIA_Raoul_FELLZURUECK_Condition()
{
	if((MIS_Raoul_DoesntPayTrollFur == LOG_Running) && Npc_HasItems(self,ItAt_TrollBlackFur))
	{
		return TRUE;
	};
};

func void DIA_Raoul_FELLZURUECK_Info()
{
	AI_Output (other, self, "DIA_Raoul_FELLZURUECK_15_00");	//Give me my troll hide back.
	AI_Output (self, other, "DIA_Raoul_FELLZURUECK_01_01");	//No.
	AI_StopProcessInfos (self);
};


instance DIA_Raoul_GotTrollFurBack(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 3;
	condition = DIA_Raoul_GotTrollFurBack_Condition;
	information = DIA_Raoul_GotTrollFurBack_Info;
	description = "Never try to fleece me again, understood?";
};


func int DIA_Raoul_GotTrollFurBack_Condition()
{
	if((MIS_Raoul_DoesntPayTrollFur == LOG_Running) && !Npc_HasItems(self,ItAt_TrollBlackFur) && (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST))
	{
		return TRUE;
	};
};

func void DIA_Raoul_GotTrollFurBack_Info()
{
	AI_Output (other, self, "DIA_Raoul_GotTrollFurBack_15_00");	//Never try to fleece me again, understood?
	AI_Output (self, other, "DIA_Raoul_GotTrollFurBack_01_01");	//All right. You know how things work around here, don't you? So calm down.
	MIS_Raoul_DoesntPayTrollFur = LOG_SUCCESS;
	AI_StopProcessInfos(self);
};


instance DIA_Raoul_Ship(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 2;
	condition = DIA_Raoul_Ship_Condition;
	information = DIA_Raoul_Ship_Info;
	description = "Would you like an ocean cruise out of here?";
};


func int DIA_Raoul_Ship_Condition()
{
	if((Kapitel >= 5) && (MIS_SCKnowsWayToIrdorath == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Raoul_Ship_Info()
{
	AI_Output (other, self, "DIA_Raoul_Ship_15_00");	//Would you fancy an ocean cruise out of here?
	AI_Output (self, other, "DIA_Raoul_Ship_01_01");	//What are you planning? Are you going to capture the paladins' ship? (laughs)
	AI_Output (other, self, "DIA_Raoul_Ship_15_02");	//And what if I am?
	AI_Output (self, other, "DIA_Raoul_Ship_01_03");	//(serious) You are completely crazy. No, thanks. Not for me.
	AI_Output (self, other, "DIA_Raoul_Ship_01_04");	//I don't see any reason to leave Khorinis. Whether I earn my dough here or on the mainland - it's all the same to me.
	AI_Output (self, other, "DIA_Raoul_Ship_01_05");	//Find somebody else.
	if(!Npc_IsDead(Torlof))
	{
		AI_Output(self,other,"DIA_Raoul_Ship_01_06");	//Ask Torlof. He used to go to sea, as far as I know.
		TorlofIsSailor = TRUE;
	};
};


instance DIA_Raoul_PICKPOCKET(C_Info)
{
	npc = SLD_822_Raoul;
	nr = 900;
	condition = DIA_Raoul_PICKPOCKET_Condition;
	information = DIA_Raoul_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Raoul_PICKPOCKET_Condition()
{
	return C_Beklauen(45,85);
};

func void DIA_Raoul_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Raoul_PICKPOCKET);
	Info_AddChoice(DIA_Raoul_PICKPOCKET,Dialog_Back,DIA_Raoul_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Raoul_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Raoul_PICKPOCKET_DoIt);
};

func void DIA_Raoul_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Raoul_PICKPOCKET);
};

func void DIA_Raoul_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Raoul_PICKPOCKET);
};

