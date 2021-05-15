
instance DIA_Buster_EXIT(C_Info)
{
	npc = SLD_802_Buster;
	nr = 999;
	condition = DIA_Buster_EXIT_Condition;
	information = DIA_Buster_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Buster_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Buster_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Buster_Hello(C_Info)
{
	npc = SLD_802_Buster;
	nr = 1;
	condition = DIA_Buster_Hello_Condition;
	information = DIA_Buster_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Buster_Hello_Condition()
{
	if((self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_LOST) && ((hero.guild != GIL_SLD) && (hero.guild != GIL_DJG)))
	{
		return TRUE;
	};
};

func void DIA_Buster_Hello_Info()
{
	AI_Output (self, other, "DIA_Buster_Hello_13_00");	//Who do we have here? Don't I know you from somewhere?
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "If you say so. I'm on my way to see the landowner.", DIA_Buster_Hello_GoingToFarm);
	Info_AddChoice (DIA_Buster_Hello, "Who wants to know?", DIA_Buster_Hello_WhoAreYou);
};

func void DIA_Buster_Hello_WhoAreYou()
{
	AI_Output (other, self, "DIA_Buster_Hello_WhoAreYou_15_00");	//Who wants to know?
	AI_Output (self, other, "DIA_Buster_Hello_WhoAreYou_13_01");	//I'm Buster, one of Lee's mercenaries!
	AI_Output (self, other, "DIA_Buster_Hello_WhoAreYou_13_02");	//And YOU had better be a little nicer to me, or I'll have your hide!
	AI_Output (self, other, "DIA_Buster_Hello_WhoAreYou_13_03");	//All right, what do you want here?
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "That's none of your business.", DIA_Buster_Hello_NotYourBusiness);
	Info_AddChoice (DIA_Buster_Hello, "I know Lee!", DIA_Buster_Hello_IKnowLee);
	Info_AddChoice (DIA_Buster_Hello, "I'm just a traveler on his way to see the landlord.", DIA_Buster_Hello_GoingToFarm);
};

func void DIA_Buster_Hello_IKnowLee()
{
	AI_Output (other, self, "DIA_Buster_Hello_IKnowLee_15_00");	//I know Lee!
	AI_Output (self, other, "DIA_Buster_Hello_IKnowLee_13_01");	//Everyone knows Lee! That doesn't mean a thing, pal. Right now, you're talking to ME!
	AI_Output (self, other, "DIA_Buster_Hello_IKnowLee_13_02");	//So, where are you headed?
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "That's none of your business.", DIA_Buster_Hello_NotYourBusiness);
	Info_AddChoice (DIA_Buster_Hello, "I'm just a traveler on his way to see the landlord.", DIA_Buster_Hello_GoingToFarm);
};

func void DIA_Buster_Hello_NotYourBusiness()
{
	AI_Output (other, self, "DIA_Buster_Hello_NotYourBusiness_15_00");	//That's none of your business.
	AI_Output (self, other, "DIA_Buster_Hello_NotYourBusiness_13_01");	//Nobody talks to me like that, you worm! I think it's time for a sound thrashing.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Buster_Hello_GoingToFarm()
{
	AI_Output (other, self, "DIA_Buster_Hello_GoingToFarm_15_00");	//If you say so. I'm on my way to see the landowner.
	AI_Output (self, other, "DIA_Buster_Hello_GoingToFarm_13_01");	//Indeed ... Hm - you don't look all that dangerous to me.
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "Want to find out?", DIA_Buster_Hello_WannaTestIt);
	Info_AddChoice (DIA_Buster_Hello, "I've killed a beast or two on occasion.", DIA_Buster_Hello_SlewBeasts);
	Info_AddChoice (DIA_Buster_Hello, "You've got that right.", DIA_Buster_Hello_ImNoDanger);
};

func void DIA_Buster_Hello_ImNoDanger()
{
	AI_Output (other, self, "DIA_Buster_Hello_ImNoDanger_15_00");	//You've got that right.
	AI_Output (self, other, "DIA_Buster_Hello_ImNoDanger_13_01");	//(smugly) Yep, over the years you learn to spot these things, buddy.
	AI_Output (self, other, "DIA_Buster_Hello_ImNoDanger_13_02");	//We get to fight orcs here more often than not. Or the guards from town. Persistent little buggers, they are. (laughs)
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "Do you mean REAL orcs? Those big things?", DIA_Buster_Hello_RealOrcs);
	Info_AddChoice (DIA_Buster_Hello, "So?", DIA_Buster_Hello_SoWhat);
	Info_AddChoice (DIA_Buster_Hello, "Impressive.", DIA_Buster_Hello_Impressive);
};

func void DIA_Buster_Hello_SlewBeasts()
{
	AI_Output (other, self, "DIA_Buster_Hello_SlewBeasts_15_00");	//I've killed a beast or two on occasion.
	AI_Output (self, other, "DIA_Buster_Hello_SlewBeasts_13_01");	//Ha! (laughs) You probably flattened a few weevils in the fields and chased a couple of rats from their holes.
	AI_Output (self, other, "DIA_Buster_Hello_SlewBeasts_13_02");	//We're dealing with orcs here! Well, yeah, and with those scummy city guards. (derisive laugh)
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "Do you mean REAL orcs? Those big things?", DIA_Buster_Hello_RealOrcs);
	Info_AddChoice (DIA_Buster_Hello, "So?", DIA_Buster_Hello_SoWhat);
	Info_AddChoice (DIA_Buster_Hello, "Impressive.", DIA_Buster_Hello_Impressive);
};

func void DIA_Buster_Hello_WannaTestIt()
{
	AI_Output (other, self, "DIA_Buster_Hello_WannaTestIt_15_00");	//Want to find out?
	AI_Output (self, other, "DIA_Buster_Hello_WannaTestIt_13_01");	//Oh my! I picked on the wrong fella, didn't I?
	AI_Output (other, self, "DIA_Buster_Hello_WannaTestIt_15_02");	//You could say so.
	AI_Output (self, other, "DIA_Buster_Hello_WannaTestIt_13_03");	//Then come on, show me what you've got.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Buster_Hello_Impressive()
{
	AI_Output (other, self, "DIA_Buster_Hello_Impressive_15_00");	//Impressive.
	AI_Output (self, other, "DIA_Buster_Hello_Impressive_13_01");	//(laughs) That's our business, kid! We even produce our own weapons and armor!
	AI_Output (self, other, "DIA_Buster_Hello_Impressive_13_02");	//We defy death every day. But a country bumpkin like you wouldn't know about that.
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "I guess I'll have to show you how much I know about that!", DIA_Buster_Hello_LetMeShowYou);
	Info_AddChoice (DIA_Buster_Hello, "Whatever you say.", DIA_Buster_Hello_IfYouSaySo);
};

func void DIA_Buster_Hello_IfYouSaySo()
{
	AI_Output (other, self, "DIA_Buster_Hello_IfYouSaySo_15_00");	//Whatever you say.
	AI_Output (self, other, "DIA_Buster_Hello_IfYouSaySo_13_01");	//(with a bored grunt) Get a move on, you wimp!
	AI_StopProcessInfos (self);
};

func void DIA_Buster_Hello_LetMeShowYou()
{
	AI_Output (other, self, "DIA_Buster_Hello_LetMeShowYou_15_00");	//I guess I'll have to show you how much I know about that!
	AI_Output (self, other, "DIA_Buster_Hello_LetMeShowYou_13_01");	//Are you having a peasants' uprising all by yourself, then?
	AI_Output (self, other, "DIA_Buster_Hello_LetMeShowYou_13_02");	//All right then, show me what you've got.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Buster_Hello_SoWhat()
{
	AI_Output (other, self, "DIA_Buster_Hello_SoWhat_15_00");	//So?
	AI_Output (self, other, "DIA_Buster_Hello_SoWhat_13_01");	//(snorts) As if you knew what I'm talking about. You think you're mighty strong, don't you?
	AI_Output (self, other, "DIA_Buster_Hello_SoWhat_13_02");	//(angry) Maybe it's about time that somebody taught you a lesson!
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "Any time!", DIA_Buster_Hello_Whenever);
	Info_AddChoice (DIA_Buster_Hello, "Only kidding...", DIA_Buster_Hello_JustJoking);
};

func void DIA_Buster_Hello_RealOrcs()
{
	AI_Output (other, self, "DIA_Buster_Hello_RealOrcs_15_00");	//Do you mean REAL orcs? Those big things?
	AI_Output (self, other, "DIA_Buster_Hello_RealOrcs_13_01");	//(sighs) I mean ... Just a moment! Are you trying to pull my leg?
	AI_Output (other, self, "DIA_Buster_Hello_RealOrcs_15_02");	//(smiling) Far be that from me.
	AI_Output (self, other, "DIA_Buster_Hello_RealOrcs_13_03");	//You worm! (stupidly aggressive) You're really asking for it, huh?
	AI_Output (self, other, "DIA_Buster_Hello_RealOrcs_13_04");	//Then come and show me what you've got, you hero!
	Info_ClearChoices (DIA_Buster_Hello);
	Info_AddChoice (DIA_Buster_Hello, "Any time!", DIA_Buster_Hello_Whenever);
	Info_AddChoice (DIA_Buster_Hello, "Only kidding ...", DIA_Buster_Hello_JustJoking);
};

func void DIA_Buster_Hello_Whenever()
{
	AI_Output (other, self, "DIA_Buster_Hello_Whenever_15_00");	//Any time!
	AI_Output (self, other, "DIA_Buster_Hello_Whenever_13_01");	//Come closer, then, buddy!
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Buster_Hello_JustJoking()
{
	AI_Output (other, self, "DIA_Buster_Hello_JustJoking_15_00");	//Only kidding ...
	AI_Output (self, other, "DIA_Buster_Hello_JustJoking_13_01");	//Yeah, right, draw in your horns! Just get out of my sight!
	AI_StopProcessInfos (self);
};


instance DIA_Buster_FightNone(C_Info)
{
	npc = SLD_802_Buster;
	nr = 1;
	condition = DIA_Buster_FightNone_Condition;
	information = DIA_Buster_FightNone_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Buster_FightNone_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Buster_Hello) && (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE) && Npc_IsInState(self,ZS_Talk))
	{
		if((Kapitel >= 3) && ((other.guild == GIL_SLD) || (other.guild == GIL_DJG)))
		{
			return FALSE;
		};
		return TRUE;
	};
};

func void DIA_Buster_FightNone_Info()
{
	AI_Output (self, other, "DIA_Buster_FightNone_13_00");	//What do you want, you wimp?
};


instance DIA_Buster_Duell(C_Info)
{
	npc = SLD_802_Buster;
	nr = 3;
	condition = DIA_Buster_Duell_Condition;
	information = DIA_Buster_Duell_Info;
	permanent = TRUE;
	description = "I challenge you to a duel!";
};


func int DIA_Buster_Duell_Condition()
{
	if(self.aivar[AIV_LastFightAgainstPlayer] != FIGHT_LOST)
	{
		return TRUE;
	};
};

func void DIA_Buster_Duell_Info()
{
	AI_Output (other, self, "DIA_Buster_Duell_15_00");	//I challenge you to a duel!
	if (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE)
	{
		AI_Output (self, other, "DIA_Buster_Duell_13_01");	//Ah-ha! You won't take this sitting down, huh? All right - come here!
	}
	else
	{
		AI_Output (self, other, "DIA_Buster_Duell_13_02");	//You want to try again? Pesky little bugger - all right, come here!
		if (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_CANCEL)
		{
			AI_Output (self, other, "DIA_Buster_Duell_13_03");	//But don't run off again!
		};
	};
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};


instance DIA_Buster_WannaJoin(C_Info)
{
	npc = SLD_802_Buster;
	nr = 2;
	condition = DIA_Buster_WannaJoin_Condition;
	information = DIA_Buster_WannaJoin_Info;
	permanent = TRUE;
	description = "I want to join the mercenaries!";
};


func int DIA_Buster_WannaJoin_Condition()
{
	if((other.guild == GIL_NONE) && (Buster_Duell == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Buster_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Buster_WannaJoin_15_00");	//I want to join the mercenaries!
	if ((self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_WON) || (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST))
	{
		if(Torlof_GenugStimmen == FALSE)
		{
			Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
		};
		if(self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST)
		{
			AI_Output(self,other,"DIA_Buster_WannaJoin_13_01");	//Anyone who can whack as hard as you shouldn't have too much trouble around here.
			B_LogEntry(TOPIC_SLDRespekt,"Since I've defeated Buster, he doesn't mind me joining the mercenaries.");
		}
		else
		{
			AI_Output(self,other,"DIA_Buster_WannaJoin_13_02");	//You're not the best of fighters, but a coward you're not.
			B_LogEntry(TOPIC_SLDRespekt,"Buster doesn't mind me joining the mercenaries.");
		};
		AI_Output(self,other,"DIA_Buster_WannaJoin_13_03");	//My vote doesn't count much since I haven't been here for long, but when Lee asks me I'll vote for you.
		SCKnowsSLDVotes = TRUE;
		Buster_Duell = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Buster_WannaJoin_13_04");	//You? I don't recall that they ever let a coward join the mercenaries ...
		if (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_CANCEL)
		{
			AI_Output (self, other, "DIA_Buster_WannaJoin_13_05");	//Running away in a duel - that won't get you far around here!
		};
	};
};


var int Buster_SentenzaTip;

instance DIA_Buster_OtherSld(C_Info)
{
	npc = SLD_802_Buster;
	nr = 1;
	condition = DIA_Buster_OtherSld_Condition;
	information = DIA_Buster_OtherSld_Info;
	permanent = FALSE;
	description = "I want to find out more about the mercenaries and this region.";
};


func int DIA_Buster_OtherSld_Condition()
{
	if((hero.guild != GIL_SLD) && (hero.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Buster_OtherSld_Info()
{
	AI_Output (other, self, "DIA_Buster_OtherSld_15_00");	//I want to find out more about the mercenaries and this region.
	AI_Output (self, other, "DIA_Buster_OtherSld_13_01");	//I can't tell you much about this region. You had better ask the farmers.
	if(hero.guild == GIL_NONE)
	{
		AI_Output(self,other,"DIA_Buster_OtherSld_13_02");	//ј что касаетс€ наемников - то правила у нас просты: если можешь посто€ть за себ€ - добро пожаловать к нам.
	};
	if(self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_LOST)
	{
		if(hero.guild == GIL_NONE)
		{
		AI_Output (self, other, "DIA_Buster_OtherSld_13_03");	//I think you're made of the right stuff to be one of us.
		AI_Output (self, other, "DIA_Buster_OtherSld_13_04");	//But you shouldn't let it get to your head that you lucked out during our last fight.
		};
		AI_Output (self, other, "DIA_Buster_OtherSld_13_05");	//There are plenty of lads on the farm who are quite a bit better than I am...
		AI_Output (self, other, "DIA_Buster_OtherSld_13_06");	//Sentenza, for one. He guards the entry to the farm. Whatever you do, don't pick a fight with him.
		Buster_SentenzaTip = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Buster_OtherSld_13_07");	//But why am I telling that to YOU, you wuss!
		AI_StopProcessInfos (self);
	};
};


var int Buster_GoldZumBrennen;
var int Buster_Bonus;

instance DIA_Buster_AboutSentenza(C_Info)
{
	npc = SLD_802_Buster;
	nr = 1;
	condition = DIA_Buster_AboutSentenza_Condition;
	information = DIA_Buster_AboutSentenza_Info;
	permanent = FALSE;
	description = "What about this Sentenza?";
};


func int DIA_Buster_AboutSentenza_Condition()
{
	if((Buster_SentenzaTip == TRUE) && !Npc_IsDead(Sentenza) && (Sentenza.aivar[AIV_TalkedToPlayer] == FALSE))
	{
		if((Kapitel >= 3) && ((other.guild == GIL_SLD) || (other.guild == GIL_DJG)))
		{
			return FALSE;
		};
		return TRUE;
	};
};

func void DIA_Buster_AboutSentenza_Info()
{
	AI_Output (other, self, "DIA_Buster_AboutSentenza_15_00");	//What about this Sentenza?
	AI_Output (self, other, "DIA_Buster_AboutSentenza_13_01");	//He'll try to squeeze some gold out of you when you come to the farm - he does that to all newcomers.
	AI_Output (self, other, "DIA_Buster_AboutSentenza_13_02");	//And if I were you, I'd pay up. That's what I did back then. And the good thing was that he voted for me afterwards.
	AI_Output (self, other, "DIA_Buster_AboutSentenza_13_03");	//One good turn deserves another, he said. I lost all my gold in the bargain, but it wasn't much to begin with. And I was glad of it in the end.
	AI_Output (self, other, "DIA_Buster_AboutSentenza_13_04");	//I once watched him beat up a fellow who had decided NOT to pay him.
	AI_Output (other, self, "DIA_Buster_AboutSentenza_15_05");	//Thanks for the hint.
	AI_Output (self, other, "DIA_Buster_AboutSentenza_13_06");	//Indeed. Could it be worth anything to you?
	SCKnowsSLDVotes = TRUE;
	Info_ClearChoices(DIA_Buster_AboutSentenza);
	Info_AddChoice(DIA_Buster_AboutSentenza,"No.",DIA_Buster_AboutSentenza_No);
	if(Npc_HasItems(other,ItMi_Gold) >= 5)
	{
		Info_AddChoice(DIA_Buster_AboutSentenza,"Here you are - 5 gold pieces.",DIA_Buster_AboutSentenza_Give);
	};
};

func void DIA_Buster_AboutSentenza_Give()
{
	AI_Output(other,self,"DIA_Buster_AboutSentenza_Give_15_00");	//Here you are - 5 gold pieces.
	B_GiveInvItems(other,self,ItMi_Gold,5);
	AI_Output(self,other,"DIA_Buster_AboutSentenza_Give_13_01");	//Thanks, man. Looks like I can take a few tonight after all. I won't forget this.
	Buster_GoldZumBrennen = TRUE;
	Buster_Bonus = 50;
	Info_ClearChoices(DIA_Buster_AboutSentenza);
};

func void DIA_Buster_AboutSentenza_No()
{
	AI_Output (other, self, "DIA_Buster_AboutSentenza_No_15_00");	//No.
	AI_Output (self, other, "DIA_Buster_AboutSentenza_No_13_01");	//That's what I thought.
	Info_ClearChoices(DIA_Buster_AboutSentenza);
};


instance DIA_Buster_LeeLeader(C_Info)
{
	npc = SLD_802_Buster;
	nr = 2;
	condition = DIA_Buster_LeeLeader_Condition;
	information = DIA_Buster_LeeLeader_Info;
	permanent = FALSE;
	description = "Lee is the leader of the mercenaries, isn't he?";
};


func int DIA_Buster_LeeLeader_Condition()
{
	if(Buster_Duell == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Buster_LeeLeader_Info()
{
	AI_Output (other, self, "DIA_Buster_LeeLeader_15_00");	//Lee is the leader of the mercenaries, isn't he?
	AI_Output (self, other, "DIA_Buster_LeeLeader_13_01");	//Right - hey, now I remember where I know you from! You were in the colony, too.
	AI_Output (other, self, "DIA_Buster_LeeLeader_15_02");	//(sighs) So I was.
	AI_Output (self, other, "DIA_Buster_LeeLeader_13_03");	//I didn't see you when the big bang happened. Not for a while before that, either.
	AI_Output (other, self, "DIA_Buster_LeeLeader_15_04");	//I had other problems.
	AI_Output (self, other, "DIA_Buster_LeeLeader_13_05");	//You've missed out on quite a lot then - things have changed since we were in the slammer together.
};


instance DIA_Buster_WhatHappened(C_Info)
{
	npc = SLD_802_Buster;
	nr = 2;
	condition = DIA_Buster_WhatHappened_Condition;
	information = DIA_Buster_WhatHappened_Info;
	permanent = FALSE;
	description = "What became of the mercenaries in the colony?";
};


func int DIA_Buster_WhatHappened_Condition()
{
//	if(Npc_KnowsInfo(other,DIA_Buster_LeeLeader) && ((hero.guild != GIL_SLD) && (hero.guild != GIL_DJG)))
	if(Npc_KnowsInfo(other,DIA_Buster_LeeLeader))
	{
		return TRUE;
	};
};

func void DIA_Buster_WhatHappened_Info()
{
	AI_Output (other, self, "DIA_Buster_WhatHappened_15_00");	//What became of the mercenaries in the colony?
	AI_Output (self, other, "DIA_Buster_WhatHappened_13_01");	//Once the Barrier was gone, Lee led us out of the colony. He said that nothing could happen to us if we all stuck together. And he was right.
	AI_Output (self, other, "DIA_Buster_WhatHappened_13_02");	//It wasn't too long before we found ourselves a cozy spot right here. The landowner pays us to beat up the militia from the city.
	AI_Output (self, other, "DIA_Buster_WhatHappened_13_03");	//And most of us would have volunteered to do that even without pay.
	AI_Output (self, other, "DIA_Buster_WhatHappened_13_04");	//But Onar feeds us all and we can bide our time until we see a good opportunity to get away from this blasted island.
};


instance DIA_Buster_PreTeach(C_Info)
{
	npc = SLD_802_Buster;
	nr = 8;
	condition = DIA_Buster_PreTeach_Condition;
	information = DIA_Buster_PreTeach_Info;
	permanent = FALSE;
	description = "Can you teach me how to fight better?";
};


func int DIA_Buster_PreTeach_Condition()
{
	return TRUE;
};

func void DIA_Buster_PreTeach_Info()
{
	AI_Output (other, self, "DIA_Buster_Teach_15_00");	//Can you teach me how to fight better?
	if (self.aivar[AIV_DefeatedByPlayer] == TRUE)
	{
		AI_Output (self, other, "DIA_Buster_Teach_13_01");	//I might well be able to give you a hint or two...
	}
	else
	{
		AI_Output(self,other,"DIA_Buster_Teach_13_02");	//“ы не так уж глуп, как кажешьс€. ’орошо, € научу теб€ тому, что знаю сам. “огда, может быть, у теб€ по€в€тс€ шансы против мен€...
	};
	Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_SoldierTeacher,"Buster can teach me one-handed combat.");
};


var int DIA_Buster_Teach_permanent;

func void B_BuildLearnDialog_Buster()
{
	if(VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Buster)
	{
		Info_ClearChoices(DIA_Buster_Teach);
		Info_AddChoice(DIA_Buster_Teach,Dialog_Back,DIA_Buster_Teach_Back);
		Info_AddChoice(DIA_Buster_Teach,B_BuildLearnString(PRINT_Learn1h1,B_GetLearnCostTalent(other,NPC_TALENT_1H,1)),DIA_Buster_Teach_1H_1);
		Info_AddChoice(DIA_Buster_Teach,B_BuildLearnString(PRINT_Learn1h5,B_GetLearnCostTalent(other,NPC_TALENT_1H,5)),DIA_Buster_Teach_1H_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Buster)
		{
			DIA_Buster_Teach_permanent = TRUE;
		};
		PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_1H_Buster)),-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

instance DIA_Buster_Teach(C_Info)
{
	npc = SLD_802_Buster;
	nr = 8;
	condition = DIA_Buster_Teach_Condition;
	information = DIA_Buster_Teach_Info;
	permanent = TRUE;
	description = "Teach me.";
};


func int DIA_Buster_Teach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Buster_PreTeach) && (DIA_Buster_Teach_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Buster_Teach_Info()
{
	AI_Output(other,self,"DIA_Pyrokar_SPELLS_15_00");	//ќбучи мен€.
	B_BuildLearnDialog_Buster();
};

func void DIA_Buster_Teach_Back()
{
	Info_ClearChoices(DIA_Buster_Teach);
};

func void DIA_Buster_Teach_1H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,1,TeachLimit_1H_Buster))
	{
		B_BuildLearnDialog_Buster();
	};
};

func void DIA_Buster_Teach_1H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,5,TeachLimit_1H_Buster))
	{
		B_BuildLearnDialog_Buster();
	};
};

instance DIA_Buster_SHADOWBEASTS(C_Info)
{
	npc = SLD_802_Buster;
	nr = 30;
	condition = DIA_Buster_SHADOWBEASTS_Condition;
	information = DIA_Buster_SHADOWBEASTS_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Buster_SHADOWBEASTS_Condition()
{
	if(((Kapitel == 3) || (Kapitel == 4)) && ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)))
	{
		return TRUE;
	};
};

func void DIA_Buster_SHADOWBEASTS_Info()
{
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_13_00");	//Hey, you, buddy!
	AI_Output (other, self, "DIA_Buster_SHADOWBEASTS_15_01");	//What do you want?
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_13_02");	//These last few days, I've been thinking about how we could make some quick money in this dump.
	AI_Output (other, self, "DIA_Buster_SHADOWBEASTS_15_03");	//And?
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_13_04");	//I think I've stumbled across a possibility to make money fast.
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_13_05");	//A merchant from town would shell out a lot of dough for a certain thing.
	Info_ClearChoices (DIA_Buster_SHADOWBEASTS);
	Info_AddChoice (DIA_Buster_SHADOWBEASTS, "Who is this merchant you're talking about?", DIA_Buster_SHADOWBEASTS_wer);
	Info_AddChoice (DIA_Buster_SHADOWBEASTS, "What's this about?", DIA_Buster_SHADOWBEASTS_was);
	Info_AddChoice (DIA_Buster_SHADOWBEASTS, "Why are you telling me this?", DIA_Buster_SHADOWBEASTS_ich);
};

func void DIA_Buster_SHADOWBEASTS_ich()
{
	AI_Output (other, self, "DIA_Buster_SHADOWBEASTS_ich_15_00");	//Why are you telling me this?
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_ich_13_01");	//I can't do it myself. I need to stay here and watch those stupid sheep.
	AI_Output (other, self, "DIA_Buster_SHADOWBEASTS_ich_15_02");	//You mean, the farmers.
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_ich_13_03");	//That's what I'm saying.
};

func void DIA_Buster_SHADOWBEASTS_was()
{
	AI_Output (other, self, "DIA_Buster_SHADOWBEASTS_was_15_00");	//What's this about?
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_was_13_01");	//The merchant claims that he could market shadowbeast horns very profitably.
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_was_13_02");	//Someone would have to go to the woods and harvest those beasts. And that's where you come in.
	Info_AddChoice (DIA_Buster_SHADOWBEASTS, "How much is to be gained there?", DIA_Buster_SHADOWBEASTS_was_wieviel);
};

func void DIA_Buster_SHADOWBEASTS_was_wieviel()
{
	AI_Output (other, self, "DIA_Buster_SHADOWBEASTS_was_wieviel_15_00");	//How much is to be gained there?
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_was_wieviel_13_01");	//A bunch of money, I tell you. There will be enough for the two of us.
	if (Buster_GoldZumBrennen == TRUE)
	{
		AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_was_wieviel_13_02");	//And since you gave me that gold back then, I'll make you a special price.
	};
	AI_Output (other, self, "DIA_Buster_SHADOWBEASTS_was_wieviel_15_03");	//Sounds good! I'll let you know when I manage to get some horns.
	MIS_Buster_KillShadowbeasts_DJG = LOG_Running;
	Log_CreateTopic (TOPIC_Buster_KillShadowbeasts, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Buster_KillShadowbeasts, LOG_Running);
	B_LogEntry (TOPIC_Buster_KillShadowbeasts, "Buster will offer a good price for every horn of a shadowbeast that I bring him.");
	Info_ClearChoices (DIA_Buster_SHADOWBEASTS);
};

func void DIA_Buster_SHADOWBEASTS_wer()
{
	AI_Output (other, self, "DIA_Buster_SHADOWBEASTS_wer_15_00");	//Who is this merchant you're talking about?
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_wer_13_01");	//No can do, pal. I'd have to be really stupid to tell you my source. Were you trying to pull a fast one on me?
	AI_Output (self, other, "DIA_Buster_SHADOWBEASTS_wer_13_02");	//Either you make the deal with ME, or not at all, capisce?
};

var int Buster_TrophyTeacher;

instance DIA_Buster_TeachTrophyShadowbeast(C_Info)
{
	npc = SLD_802_Buster;
	nr = 6;
	condition = DIA_Buster_TeachTrophyShadowbeast_Condition;
	information = DIA_Buster_TeachTrophyShadowbeast_Info;
	permanent = TRUE;
	description = "About the shadowbeast horns ...";
};


func int DIA_Buster_TeachTrophyShadowbeast_Condition()
{
	if((MIS_Buster_KillShadowbeasts_DJG != FALSE) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ShadowHorn] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Buster_TeachTrophyShadowbeast_Info()
{
	AI_Output(other,self,"DIA_Buster_ANIMALTROPHYSHADOWBEAST_15_03");	//How do you gut a shadowbeast?
	AI_Output(self,other,"DIA_Buster_ANIMALTROPHYSHADOWBEAST_13_04");	//You don't know that? Oh man, I'd have expected more of you.
	if(Buster_TrophyTeacher == FALSE)
	{
		Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_SoldierTeacher,"Buster can teach me how to gut shadowbeasts");
		Buster_TrophyTeacher = TRUE;
	};
	Info_ClearChoices(DIA_Buster_TeachTrophyShadowbeast);
	Info_AddChoice(DIA_Buster_TeachTrophyShadowbeast,"I'll get back to you about that.",DIA_Buster_TeachTrophyShadowbeast_back);
	Info_AddChoice(DIA_Buster_TeachTrophyShadowbeast,B_BuildLearnString("Teach me.",B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_ShadowHorn)),DIA_Buster_TeachTrophyShadowbeast_teach);
};


func void DIA_Buster_TeachTrophyShadowbeast_teach()
{
	AI_Output(other,self,"DIA_Buster_BringTrophyShadowbeast_teach_15_00");	//Teach me.
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_ShadowHorn))
	{
		AI_Output (self, other, "DIA_Buster_BringTrophyShadowbeast_teach_13_01");	//Listen up, then. You do in that shadowbeast, and then you hold its horn with your right hand as tight as you can.
		AI_Output (self, other, "DIA_Buster_BringTrophyShadowbeast_teach_13_02");	//Then you stick your knife in its forehead and cut a furrow in the flesh around the horn.
		AI_Output(self,other,"DIA_Buster_BringTrophyShadowbeast_teach_13_03");	//Then you use your knife to lever the horn from the skull, and you put it in your pocket.
		if(MIS_Buster_KillShadowbeasts_DJG == LOG_Running)
		{
		AI_Output (self, other, "DIA_Buster_BringTrophyShadowbeast_teach_13_04");	//Well. And then you bring it to me. That shouldn't be too hard for you to do.

			AI_Output(other,self,"DIA_Buster_BringTrophyShadowbeast_back_15_00");	//I'll get back to you about that
		};
	};
	Info_ClearChoices(DIA_Buster_TeachTrophyShadowbeast);
};

func void DIA_Buster_TeachTrophyShadowbeast_back()
{
	DIA_Common_WeWillGetToThatLater();
	if(MIS_Buster_KillShadowbeasts_DJG == LOG_Running)
	{
		AI_Output(self,other,"DIA_Buster_BringTrophyShadowbeast_back_13_01");	//I hope so.
	};
	Info_ClearChoices(DIA_Buster_TeachTrophyShadowbeast);
};

var int BusterTrophyCounter;

instance DIA_Buster_BringTrophyShadowbeast(C_Info)
{
	npc = SLD_802_Buster;
	nr = 5;
	condition = DIA_Buster_BringTrophyShadowbeast_Condition;
	information = DIA_Buster_BringTrophyShadowbeast_Info;
	permanent = TRUE;
	description = "я принес тебе рог мракориса.";
};


func int DIA_Buster_BringTrophyShadowbeast_Condition()
{
	if((MIS_Buster_KillShadowbeasts_DJG == LOG_Running) && Npc_HasItems(other,ItAt_ShadowHorn) && ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG)))
	{
		if(Npc_HasItems(other,ItAt_ShadowHorn) > 1)
		{
			DIA_Buster_BringTrophyShadowbeast.description = "I've got some more shadowbeast horns for your merchant.";
		}
		else
		{
			DIA_Buster_BringTrophyShadowbeast.description = "I've got a shadowbeast horn for you.";
		};
		return TRUE;
	};
};

func void DIA_Buster_BringTrophyShadowbeast_Info()
{
	var int BusterTrophyCount;
	var int BusterTrophyGold;
	BusterTrophyCount = Npc_HasItems(other,ItAt_ShadowHorn);
	if(BusterTrophyCount > 1)
	{
		AI_Output(other,self,"DIA_Buster_BringTrophyShadowbeast_15_06");	//I've got some more shadowbeast horns for your merchant.
	}
	else
	{
		AI_Output(other,self,"DIA_Buster_BringTrophyShadowbeast_15_05");	//I've got a shadowbeast horn for you.
	};
	AI_Output(self,other,"DIA_Buster_BringTrophyShadowbeast_13_07");	//Great. Give here. And get me more. Who knows for how long that merchant will still want these things.
	B_GiveInvItems(other,self,ItAt_ShadowHorn,BusterTrophyCount);
	Npc_RemoveInvItems(self,ItAt_ShadowHorn,BusterTrophyCount);
	AI_Output(self,other,"DIA_Buster_BringTrophyShadowbeast_13_08");	//Here's your share.
	BusterTrophyGold = BusterTrophyCount * (Value_ShadowHorn + Buster_Bonus);
	CreateInvItems(self,ItMi_Gold,BusterTrophyGold);
	B_GiveInvItems(self,other,ItMi_Gold,BusterTrophyGold);
	B_GivePlayerXP(BusterTrophyCount * XP_BringBusterTrophy);
	BusterTrophyCounter += BusterTrophyCount;
};


instance DIA_Buster_DealerIsDead(C_Info)
{
	npc = SLD_802_Buster;
	nr = 5;
	condition = DIA_Buster_DealerIsDead_Condition;
	information = DIA_Buster_DealerIsDead_Info;
	important = TRUE;
};


func int DIA_Buster_DealerIsDead_Condition()
{
	if((MIS_Buster_KillShadowbeasts_DJG == LOG_Running) && (Kapitel >= 5))
	{
		return TRUE;
	};
};

func void DIA_Buster_DealerIsDead_Info()
{
		AI_Output(self,other,"DIA_Buster_BringTrophyShadowbeast_13_00");	//My city merchant has made his farewells.
		AI_Output (other, self, "DIA_Buster_BringTrophyShadowbeast_15_01");	//What is that supposed to mean?
		AI_Output (self, other, "DIA_Buster_BringTrophyShadowbeast_13_02");	//He's dead. You can keep the horns. I wouldn't know what to do with them now.
	MIS_Buster_KillShadowbeasts_DJG = LOG_SUCCESS;
	if((BusterTrophyCounter > 0) || Npc_HasItems(other,ItAt_ShadowHorn))
	{
		B_GivePlayerXP(XP_AmbientKap5);
	}
	else
	{
		B_CheckLog();
	};
	AI_StopProcessInfos(self);
};


instance DIA_Buster_Perm4(C_Info)
{
	npc = SLD_802_Buster;
	nr = 9;
	condition = DIA_Buster_Perm4_Condition;
	information = DIA_Buster_Perm4_Info;
	permanent = TRUE;
	description = "What do you think of this dragon hunter thing?";
};


func int DIA_Buster_Perm4_Condition()
{
	if(Kapitel >= 4)
	{
		return TRUE;
	};
};

func void DIA_Buster_Perm4_Info()
{
	AI_Output (other, self, "DIA_Buster_Perm4_15_00");	//What do you think of this dragon hunter thing?
	AI_Output (self, other, "DIA_Buster_Perm4_13_01");	//The boys could come away with a lot of gold - if they don't kick the bucket first.
	AI_Output (self, other, "DIA_Buster_Perm4_13_02");	//Myself, I prefer sticking with Lee.
};


instance DIA_Buster_PICKPOCKET(C_Info)
{
	npc = SLD_802_Buster;
	nr = 900;
	condition = DIA_Buster_PICKPOCKET_Condition;
	information = DIA_Buster_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Buster_PICKPOCKET_Condition()
{
	return C_Beklauen(34,60);
};

func void DIA_Buster_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Buster_PICKPOCKET);
	Info_AddChoice(DIA_Buster_PICKPOCKET,Dialog_Back,DIA_Buster_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Buster_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Buster_PICKPOCKET_DoIt);
};

func void DIA_Buster_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Buster_PICKPOCKET);
};

func void DIA_Buster_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Buster_PICKPOCKET);
};

