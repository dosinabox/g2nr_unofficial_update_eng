
instance DIA_Dyrian_EXIT(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 999;
	condition = DIA_Dyrian_EXIT_Condition;
	information = DIA_Dyrian_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Dyrian_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Dyrian_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Dyrian_Hello(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 2;
	condition = DIA_Dyrian_Hello_Condition;
	information = DIA_Dyrian_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dyrian_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (MIS_Rune == FALSE) && (MIS_Schnitzeljagd == FALSE) && (MIS_Golem == FALSE) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_Hello_Info()
{
	AI_Output (self, other, "DIA_Dyrian_Hello_13_00");	//(sadly) What do you want?
};


instance DIA_Dyrian_Wurst(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 3;
	condition = DIA_Dyrian_Wurst_Condition;
	information = DIA_Dyrian_Wurst_Info;
	permanent = FALSE;
	description = "I'm busy distributing sausages.";
};


func int DIA_Dyrian_Wurst_Condition()
{
	if(C_CanFeedNOV(self))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_Wurst_Info()
{
	AI_Output(other,self,"DIA_Dyrian_Wurst_15_00");	//I'm busy distributing sausages.
	AI_Output(self,other,"DIA_Dyrian_Wurst_13_01");	//Thanks. Hopefully, that won't be the last sausage I get around here.
	B_FeedNOV(self);
};


instance DIA_Dyrian_Job(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 1;
	condition = DIA_Dyrian_Job_Condition;
	information = DIA_Dyrian_Job_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Dyrian_Job_Condition()
{
	if((Kapitel == 1) && Npc_KnowsInfo(hero,DIA_Dyrian_Hello) && (MIS_Rune == FALSE) && (MIS_Schnitzeljagd == FALSE) && (MIS_Golem == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_Job_Info()
{
	AI_Output (other, self, "DIA_Dyrian_Job_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Dyrian_Job_13_01");	//I have transgressed against the precepts of the community.
	AI_Output (self, other, "DIA_Dyrian_Job_13_02");	//Now I'm waiting for the decision of the High Council whether I may remain in the monastery.
};


instance DIA_Dyrian_WhatDone(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 3;
	condition = DIA_Dyrian_WhatDone_Condition;
	information = DIA_Dyrian_WhatDone_Info;
	permanent = FALSE;
	description = "Tell me what happened.";
};


func int DIA_Dyrian_WhatDone_Condition()
{
	if((Kapitel == 1) && Npc_KnowsInfo(other,DIA_Dyrian_Job) && (MIS_Rune == FALSE) && (MIS_Schnitzeljagd == FALSE) && (MIS_Golem == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_WhatDone_Info()
{
	AI_Output (other, self, "DIA_Dyrian_WhatDone_15_00");	//Tell me what happened.
	AI_Output (self, other, "DIA_Dyrian_WhatDone_13_01");	//I took a book from the rooms of the magicians while I was sweeping, so I could read it later.
	AI_Output (self, other, "DIA_Dyrian_WhatDone_13_02");	//Master Hyglas noticed it immediately, of course, and asked me about the book.
	AI_Output (self, other, "DIA_Dyrian_WhatDone_13_03");	//Out of fear of being punished, I lied about it - but he caught me later when I was in my chamber with the book.
	AI_Output (self, other, "DIA_Dyrian_WhatDone_13_04");	//He was really angry and informed the High Council. Now they are discussing whether I can stay.
};


instance DIA_Dyrian_CanHelp(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 4;
	condition = DIA_Dyrian_CanHelp_Condition;
	information = DIA_Dyrian_CanHelp_Info;
	permanent = TRUE;
	description = "Is there any way I can help you?";
};


func int DIA_Dyrian_CanHelp_Condition()
{
	if((Kapitel == 1) && Npc_KnowsInfo(hero,DIA_Dyrian_Job) && (MIS_Rune == FALSE) && (MIS_Schnitzeljagd == FALSE) && (MIS_Golem == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_CanHelp_Info()
{
	AI_Output (other, self, "DIA_Dyrian_CanHelp_15_00");	//Is there any way I can help you?
	AI_Output (self, other, "DIA_Dyrian_CanHelp_13_01");	//No, I've been delivered up to the mercy of Innos and the magicians.
};


instance DIA_Dyrian_Scroll(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 1;
	condition = DIA_Dyrian_Scroll_Condition;
	information = DIA_Dyrian_Scroll_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dyrian_Scroll_Condition()
{
	if((Kapitel == 1) && (MIS_Schnitzeljagd == LOG_Running) || (MIS_Rune == LOG_Running) || (MIS_Golem == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_Scroll_Info()
{
	AI_Output (self, other, "DIA_Dyrian_Scroll_13_00");	//Hey, have you really demanded the test of fire?
	AI_Output (other, self, "DIA_Dyrian_Scroll_15_01");	//Yes. And I intend to pass it.
	AI_Output (self, other, "DIA_Dyrian_Scroll_13_02");	//Good - maybe I can help you with it. I can give you a very useful spell scroll. A SLEEP spell. Interested?
	Info_ClearChoices (DIA_Dyrian_Scroll);
	Info_AddChoice (DIA_Dyrian_Scroll, "No, I don't need your help.", DIA_Dyrian_Scroll_No);
	Info_AddChoice (DIA_Dyrian_Scroll, "What do you want for it?", DIA_Dyrian_Scroll_How);
	Info_AddChoice (DIA_Dyrian_Scroll, "What can I do with it?", DIA_Dyrian_Scroll_What);
};

func void DIA_Dyrian_Scroll_What()
{
	AI_Output (other, self, "DIA_Dyrian_Scroll_What_15_00");	//What can I do with it?
	AI_Output (self, other, "DIA_Dyrian_Scroll_What_13_01");	//With this spell you can put people into a magic sleep for a short time. But only if their will is weaker than yours.
	AI_Output (self, other, "DIA_Dyrian_Scroll_What_13_02");	//That could be very useful if someone is standing in your way ...
	AI_Output (other, self, "DIA_Dyrian_Scroll_What_15_03");	//And how do I know whether the other person has a weaker will?
	AI_Output (self, other, "DIA_Dyrian_Scroll_What_13_04");	//You needn't bother trying it with the magicians. But you could put most of the novices to sleep.
};

func void DIA_Dyrian_Scroll_No()
{
	AI_Output (other, self, "DIA_Dyrian_Scroll_No_15_00");	//No, I don't need your help.
	AI_Output (self, other, "DIA_Dyrian_Scroll_No_13_01");	//You can come to me any time if you change your mind.
	Info_ClearChoices (DIA_Dyrian_Scroll);
};

func void DIA_Dyrian_Scroll_How()
{
	AI_Output (other, self, "DIA_Dyrian_Scroll_How_15_00");	//What do you want for it?
	AI_Output (self, other, "DIA_Dyrian_Scroll_How_13_01");	//Every magician who is accepted gets one wish.
	AI_Output (self, other, "DIA_Dyrian_Scroll_How_13_02");	//And if you really pass the test of Fire, then you could fix it so that I can stay in the monastery.
	Info_ClearChoices (DIA_Dyrian_Scroll);
	Info_AddChoice (DIA_Dyrian_Scroll, "No, I don't need your help.", DIA_Dyrian_Scroll_No);
	Info_AddChoice (DIA_Dyrian_Scroll, "All right, give me the spell scroll.", DIA_Dyrian_Scroll_Yes);
};

func void DIA_Dyrian_Scroll_Yes()
{
	AI_Output (other, self, "DIA_Dyrian_Scroll_Yes_15_00");	//All right, give me the spell scroll.
	AI_Output (self, other, "DIA_Dyrian_Scroll_Yes_13_01");	//Good luck in your test. May Innos help you.
	CreateInvItems(self,ItSc_Sleep,1);
	B_GiveInvItems(self,other,ItSc_Sleep,1);
	MIS_HelpDyrian = LOG_Running;
	Log_CreateTopic (Topic_DyrianDrin, LOG_MISSION);
	Log_SetTopicStatus (Topic_DyrianDrin, LOG_Running);
	B_LogEntry (Topic_DyrianDrin, "Dyrian gave me a Sleep spell scroll. In return, he wants me to see to it that he's allowed to stay in the monastery, if I become a magician.");
	Info_ClearChoices (DIA_Dyrian_Scroll);
};


instance DIA_Dyrian_Doch(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 4;
	condition = DIA_Dyrian_Doch_Condition;
	information = DIA_Dyrian_Doch_Info;
	permanent = TRUE;
	description = "I changed my mind. Give me the sleep spell.";
};


func int DIA_Dyrian_Doch_Condition()
{
	if((Kapitel == 1) && Npc_KnowsInfo(hero,DIA_Dyrian_Scroll) && (MIS_HelpDyrian != LOG_Running) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_Doch_Info()
{
	AI_Output (other, self, "DIA_Dyrian_Doch_15_00");	//I changed my mind. Give me the sleep spell.
	AI_Output (self, other, "DIA_Dyrian_Doch_13_01");	//Good, if you pass the test, you'll see to it that I can stay in the monastery.
	CreateInvItems(self,ItSc_Sleep,1);
	B_GiveInvItems(self,other,ItSc_Sleep,1);
	MIS_HelpDyrian = LOG_Running;
	Log_CreateTopic(Topic_DyrianDrin,LOG_MISSION);
	Log_SetTopicStatus(Topic_DyrianDrin,LOG_Running);
	B_LogEntry(Topic_DyrianDrin,"Dyrian gave me a Sleep spell scroll. In return, he wants me to see to it that he's allowed to stay in the monastery, if I become a magician.");
};


instance DIA_Dyrian_HelloAgain(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 2;
	condition = DIA_Dyrian_HelloAgain_Condition;
	information = DIA_Dyrian_HelloAgain_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dyrian_HelloAgain_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (other.guild == GIL_KDF) && (MIS_HelpDyrian == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_HelloAgain_Info()
{
	AI_Output (self, other, "DIA_Dyrian_HelloAgain_13_00");	//(joyful) Thanks, you saved me!
	AI_Output (self, other, "DIA_Dyrian_HelloAgain_13_01");	//(frightened) Oh - forgive me Master - I didn't mean to impose.
	AI_Output (self, other, "DIA_Dyrian_HelloAgain_13_02");	//(respectfully) I thank you for being allowed to stay in the monastery. My life will be different from now on ...
	B_GivePlayerXP (XP_Ambient);
	AI_StopProcessInfos (self);
};

func void B_Dyrian_PlayerHowIsIt()
{
	AI_Output (other, self, "DIA_Dyrian_HowIsIt_15_00");	//How's it going?
};


instance DIA_Dyrian_HowIsIt(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 3;
	condition = DIA_Dyrian_HowIsIt_Condition;
	information = DIA_Dyrian_HowIsIt_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_Dyrian_HowIsIt_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dyrian_HelloAgain))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_HowIsIt_Info()
{
	B_Dyrian_PlayerHowIsIt();
	AI_Output(self,other,"DIA_Dyrian_HowIsIt_13_01");	//Good. I really enjoy the work, Master.
	AI_Output(self,other,"DIA_Dyrian_HowIsIt_13_02");	//I thank Innos that I can be here in the monastery.
//	AI_StopProcessInfos(self);
};


instance DIA_Dyrian_other(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 3;
	condition = DIA_Dyrian_other_Condition;
	information = DIA_Dyrian_other_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_Dyrian_other_Condition()
{
	if((other.guild != GIL_KDF) && (other.guild != GIL_NOV) && (other.guild != GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_other_Info()
{
	B_Dyrian_PlayerHowIsIt();
	B_Say(self,other,"$NOTNOW");
	AI_StopProcessInfos(self);
//	AI_Output(self,other,"DIA_Dyrian_HowIsIt_13_02");	//I thank Innos that I can be here in the monastery.
//	AI_StopProcessInfos(self);
};


instance DIA_Dyrian_Kneipe(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 3;
	condition = DIA_Dyrian_Kneipe_Condition;
	information = DIA_Dyrian_Kneipe_Info;
//	permanent = TRUE;
	permanent = FALSE;
	description = "How's it going?";
};


func int DIA_Dyrian_Kneipe_Condition()
{
	if((MIS_HelpDyrian == LOG_FAILED) && (other.guild == GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_Kneipe_Info()
{
	AI_Output (other, self, "DIA_Dyrian_Kneipe_15_00");	//How's it going?
	AI_Output (self, other, "DIA_Dyrian_Kneipe_13_01");	//You're asking me that? I put all my hopes on you and you left me in the lurch.
	AI_Output (self, other, "DIA_Dyrian_Kneipe_13_02");	//Now I've got nothing left but alcohol. And it's all your fault!
	Info_ClearChoices (DIA_Dyrian_Kneipe);
	Info_AddChoice (DIA_Dyrian_Kneipe, "Here, 5 gold for you.", DIA_Dyrian_Kneipe_Gold);
	Info_AddChoice (DIA_Dyrian_Kneipe, "I can explain everything.", DIA_Dyrian_Kneipe_CanExplain);
	Info_AddChoice (DIA_Dyrian_Kneipe, "Watch what you're saying there.", DIA_Dyrian_Kneipe_ShutUp);
};

func void DIA_Dyrian_Kneipe_Gold()
{
	AI_Output (other, self, "DIA_Dyrian_Kneipe_Gold_15_00");	//Here, 5 gold pieces for you.
	AI_Output (self, other, "DIA_Dyrian_Kneipe_Gold_13_01");	//(nervously) 5 gold? You're giving me 5 gold to make up for destroying my life?
	AI_Output (self, other, "DIA_Dyrian_Kneipe_Gold_13_02");	//I'll take all your gold!
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 0);
};

func void DIA_Dyrian_Kneipe_CanExplain()
{
	AI_Output (other, self, "DIA_Dyrian_Kneipe_CanExplain_15_00");	//I can explain everything.
	AI_Output (self, other, "DIA_Dyrian_Kneipe_CanExplain_13_01");	//Save your cheap excuses.
	AI_Output (self, other, "DIA_Dyrian_Kneipe_CanExplain_13_02");	//You lie every time you open your mouth. Now leave me alone.
	AI_StopProcessInfos (self);
};

func void DIA_Dyrian_Kneipe_ShutUp()
{
	AI_Output (other, self, "DIA_Dyrian_Kneipe_ShutUp_15_00");	//Watch what you're saying there.
	AI_Output (self, other, "DIA_Dyrian_Kneipe_ShutUp_13_01");	//Yeah, go ahead and threaten me. It won't do you any good.
	AI_Output (self, other, "DIA_Dyrian_Kneipe_ShutUp_13_02");	//I'll tell the whole world what a hypocritical bastard you are! As soon as I've finished this bottle ...
	AI_Output (self, other, "DIA_Dyrian_Kneipe_ShutUp_13_03");	//Now get out of my sight, you disgust me!
	AI_StopProcessInfos (self);
};


instance DIA_Dyrian_nachher(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 3;
	condition = DIA_Dyrian_nachher_Condition;
	information = DIA_Dyrian_nachher_Info;
	permanent = TRUE;
	description = "What's up?";
};


func int DIA_Dyrian_nachher_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dyrian_Kneipe))
	{
		return TRUE;
	};
};

func void DIA_Dyrian_nachher_Info()
{
	AI_Output (other, self, "DIA_Dyrian_nachher_15_00");	//What's up?
	AI_Output (self, other, "DIA_Dyrian_nachher_13_01");	//Aah, just leave me alone! I don't want anything more to do with you!
	AI_StopProcessInfos (self);
};


instance DIA_Dyrian_PICKPOCKET(C_Info)
{
	npc = NOV_604_Dyrian;
	nr = 900;
	condition = DIA_Dyrian_PICKPOCKET_Condition;
	information = DIA_Dyrian_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Dyrian_PICKPOCKET_Condition()
{
	return C_Beklauen(10,15);
};

func void DIA_Dyrian_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Dyrian_PICKPOCKET);
	Info_AddChoice(DIA_Dyrian_PICKPOCKET,Dialog_Back,DIA_Dyrian_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Dyrian_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Dyrian_PICKPOCKET_DoIt);
};

func void DIA_Dyrian_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Dyrian_PICKPOCKET);
};

func void DIA_Dyrian_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Dyrian_PICKPOCKET);
};

