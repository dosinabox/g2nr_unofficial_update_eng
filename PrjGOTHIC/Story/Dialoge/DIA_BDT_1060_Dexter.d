
instance DIA_Dexter_EXIT(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 999;
	condition = DIA_Dexter_EXIT_Condition;
	information = DIA_Dexter_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Dexter_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Dexter_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Dexter_Hallo(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 1;
	condition = DIA_Dexter_Hallo_Condition;
	information = DIA_Dexter_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dexter_Hallo_Condition()
{
	if(Knows_Dexter == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Dexter_Hallo_Info()
{
	AI_Output (self, other, "DIA_Dexter_Hallo_09_00");	//Look who's here. The great emancipator. Well, hero - what are you doing here?
	AI_Output (other, self, "DIA_Dexter_Hallo_15_01");	//I'm looking for a few answers.
	if(Bdt13_Dexter_verraten == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Dexter_Hallo_09_00");	//I never thought you'd come here voluntarily.
		AI_Output (other, self, "DIA_Addon_Dexter_Hallo_15_01");	//What do you mean by that?
		AI_Output (self, other, "DIA_Addon_Dexter_Hallo_09_02");	//I mean that I've been looking for you. Haven't you seen any of my wanted posters?
		AI_Output (self, other, "DIA_Addon_Dexter_Hallo_09_03");	//They all bear YOUR mug. Oh yes ... you're very much wanted. Didn't you know that?
	}
	else
	{
		AI_Output (other, self, "DIA_Dexter_Hallo_15_02");	//SOMEONE is passing around pieces of paper with my face on them. SOMEONE told me that it's you.
		AI_Output (self, other, "DIA_Dexter_Hallo_09_03");	//Somebody talks too much.
		AI_Output (self, other, "DIA_Addon_Dexter_Hallo_09_04");	//But you're right. I distributed those wanted posters. And, lo and behold - here you are.
		MIS_Steckbriefe = LOG_SUCCESS;
		B_GivePlayerXP(XP_Ambient);
	};
	AI_Output (other, self, "DIA_Addon_Dexter_Hallo_15_05");	//So what do you want from me?
	AI_Output (self, other, "DIA_Addon_Dexter_Hallo_09_06");	//Me? Nothing whatsoever. But my boss is hell-bent on seeing you dead.
	AI_Output (self, other, "DIA_Addon_Dexter_Hallo_09_07");	//So he wants me to find you and bring him your head.
};


instance DIA_Dexter_Glaube(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 5;
	condition = DIA_Dexter_Glaube_Condition;
	information = DIA_Dexter_Glaube_Info;
	permanent = FALSE;
	description = "I don't believe a word you're saying.";
};


func int DIA_Dexter_Glaube_Condition()
{
	if(Knows_Dexter == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Dexter_Glaube_Info()
{
	AI_Output (other, self, "DIA_Dexter_Glaube_15_00");	//I don't believe a word you're saying.
	AI_Output (self, other, "DIA_Dexter_Glaube_09_01");	//Hey, it's true. I swear on my mother's grave!
};


instance DIA_Addon_Dexter_Patrick(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 2;
	condition = DIA_Addon_Dexter_Patrick_Condition;
	information = DIA_Addon_Dexter_Patrick_Info;
	description = "A mercenary named Patrick's been seen here.";
};


func int DIA_Addon_Dexter_Patrick_Condition()
{
	if((MIS_Addon_Cord_Look4Patrick == LOG_Running) && (Knows_Dexter == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Dexter_Patrick_Info()
{
	AI_Output (other, self, "DIA_Addon_Dexter_Patrick_15_00");	//A mercenary named Patrick's been seen here.
	AI_Output (self, other, "DIA_Addon_Dexter_Patrick_09_01");	//Patrick, huh? No idea what you're talking about.
	AI_Output (self, other, "DIA_Addon_Dexter_Patrick_09_02");	//I do recall some loud-mouthed mercenary who hung out with the boys out there sometimes.
	AI_Output (self, other, "DIA_Addon_Dexter_Patrick_09_03");	//(obviously lying) But I haven't seen him in ages.
	AI_Output (self, other, "DIA_Addon_Dexter_Patrick_09_04");	//(acting innocent) Maybe he got himself hanged at last. I wouldn't know.
	Log_CreateTopic (TOPIC_Addon_MissingPeople, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_MissingPeople, LOG_Running);
	B_LogEntry (TOPIC_Addon_MissingPeople, "Dexter claims not to know the mercenary Patrick.");
	Dexter_KnowsPatrick = TRUE;
	B_GivePlayerXP(XP_Addon_Dexter_KnowsPatrick);
};


instance DIA_Addon_Dexter_Greg(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 5;
	condition = DIA_Addon_Dexter_Greg_Condition;
	information = DIA_Addon_Dexter_Greg_Info;
	description = "There's this fellow with an eyepatch. He's looking for YOU!";
};


func int DIA_Addon_Dexter_Greg_Condition()
{
	if((SC_KnowsGregsSearchsDexter == TRUE) && (Knows_Dexter == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Dexter_Greg_Info()
{
	AI_Output (other, self, "DIA_Addon_Dexter_Greg_15_00");	//There's this fellow with an eyepatch. He's looking for YOU!
	AI_Output (self, other, "DIA_Addon_Dexter_Greg_09_01");	//Everybody's looking for me. I couldn't care less.
	AI_Output (self, other, "DIA_Addon_Dexter_Greg_09_02");	//If that guy has some business with me, let him come here.
	B_GivePlayerXP (XP_Ambient);
};


instance DIA_Addon_Dexter_missingPeople(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 2;
	condition = DIA_Addon_Dexter_missingPeople_Condition;
	information = DIA_Addon_Dexter_missingPeople_Info;
	description = "They say that you're kidnapping people from Khorinis.";
};


func int DIA_Addon_Dexter_missingPeople_Condition()
{
	if((SC_KnowsDexterAsKidnapper == TRUE) && (Knows_Dexter == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Dexter_missingPeople_Info()
{
	AI_Output (other, self, "DIA_Addon_Dexter_missingPeople_15_00");	//They say that you're kidnapping people from Khorinis.
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_09_01");	//So you found that out, too. Good work, buster.
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_09_02");	//And here I was thinking I had covered my tracks.
	Info_ClearChoices (DIA_Addon_Dexter_missingPeople);
	Info_AddChoice (DIA_Addon_Dexter_missingPeople, "Who gave you this order?", DIA_Addon_Dexter_missingPeople_wer);
	Info_AddChoice (DIA_Addon_Dexter_missingPeople, "Where did those people disappear to? Maybe down the mines, somewhere here?", DIA_Addon_Dexter_missingPeople_Wo);
};

func void DIA_Addon_Dexter_missingPeople_Wo()
{
	AI_Output (other, self, "DIA_Addon_Dexter_missingPeople_Wo_15_00");	//Where did those people disappear to? Maybe down the mines, somewhere here?
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_Wo_09_01");	//(laughs) They're far away in the north-east by now where you can't get to them.
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_Wo_09_02");	//I could show you where exactly, but I don't know why I would want to do that.
};

func void DIA_Addon_Dexter_missingPeople_wer()
{
	AI_Output (other, self, "DIA_Addon_Dexter_missingPeople_wer_15_00");	//Who gave you this order?
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_wer_09_01");	//My boss. He's a dangerous man. You know him: Raven, one of the former ore barons from the old camp in the Valley of Mines.
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_wer_09_02");	//He needs those people to fulfill his plans. And that's all you need to know.
	Info_AddChoice (DIA_Addon_Dexter_missingPeople, "Raven, dangerous? Oh well ...", DIA_Addon_Dexter_missingPeople_Raven);
	Info_AddChoice (DIA_Addon_Dexter_missingPeople, "An ore baron here, in Khorinis?", DIA_Addon_Dexter_missingPeople_RavenTot);
};

func void DIA_Addon_Dexter_missingPeople_Raven()
{
	AI_Output (other, self, "DIA_Addon_Dexter_missingPeople_Raven_15_00");	//Raven, dangerous? Oh well...
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_Raven_09_01");	//(irritated) What do YOU know? You don't know him like I do.
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_Raven_09_02");	//(unsure) He was a miserable swine even back then, but these days...
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_Raven_09_03");	//He has changed since the fall of the Barrier. There's a black shadow across his face.
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_Raven_09_04");	//(intimidated) His fierce glance will pierce you like the claws of a raptor if you look into his eyes for too long.
	AI_Output(self,other,"DIA_Dexter_Hallo_09_04");	//But it's true. I gave my boys the wanted posters. I didn't have any other choice.
	AI_Output(self,other,"DIA_Addon_Dexter_missingPeople_Raven_09_05");	//My only advice to you is: Leave Khorinis as fast as you can, before it's too late.
	AI_Output(self,other,"DIA_Addon_Dexter_missingPeople_Raven_09_06");	//(somberly) There's nothing here for you. Except for certain death.
	Log_CreateTopic(TOPIC_Addon_WhoStolePeople,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_WhoStolePeople,LOG_Running);
	B_LogEntry(TOPIC_Addon_WhoStolePeople,"Dexter has a client. His name is Raven. Raven is a former ore baron. It seems that this Raven is ultimately behind the whole kidnapping business. Now I just need proof of it.");
	Info_ClearChoices(DIA_Addon_Dexter_missingPeople);
};

func void DIA_Addon_Dexter_missingPeople_RavenTot()
{
	AI_Output (other, self, "DIA_Addon_Dexter_missingPeople_RavenTot_15_00");	//An ore baron here, in Khorinis?
	AI_Output (self, other, "DIA_Addon_Dexter_missingPeople_RavenTot_09_01");	//He's no longer an ore baron. He's got plans of his own, and Khorinis will feel that before long.
};


instance DIA_Addon_Dexter_Boss(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 3;
	condition = DIA_Addon_Dexter_Boss_Condition;
	information = DIA_Addon_Dexter_Boss_Info;
	description = "Your boss? Who's that supposed to be?";
};


func int DIA_Addon_Dexter_Boss_Condition()
{
	if((Knows_Dexter == TRUE) && (SC_KnowsDexterAsKidnapper == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Dexter_Boss_Info()
{
	AI_Output (other, self, "DIA_Addon_Dexter_Boss_15_00");	//Your boss? Who's that supposed to be?
	AI_Output (self, other, "DIA_Addon_Dexter_Boss_09_01");	//(laughs) Wouldn't you just love to know that? Yes, I can imagine.
	AI_Output (self, other, "DIA_Addon_Dexter_Boss_09_02");	//(serious) I don't see any reason why I should tell you.
};


instance DIA_Dexter_Vor(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 5;
	condition = DIA_Dexter_Vor_Condition;
	information = DIA_Dexter_Vor_Info;
	permanent = FALSE;
	description = "And what do you intend to do now? Kill me?";
};


func int DIA_Dexter_Vor_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Dexter_missingPeople))
	{
		return TRUE;
	};
};

func void DIA_Dexter_Vor_Info()
{
	AI_Output (other, self, "DIA_Dexter_Vor_15_00");	//And what do you intend to do now? Kill me?
	AI_Output (self, other, "DIA_Dexter_Vor_09_01");	//Yeah. But you set us all free. That's why I'm giving you another chance. Beat it - disappear, make yourself invisible. Go and don't cross my path again.
	AI_Output (other, self, "DIA_Addon_Dexter_Vor_15_00");	//I need to know where you brought those people.
	AI_Output (self, other, "DIA_Addon_Dexter_Vor_09_01");	//(laughs) Well. You could try beating it out of me ...
	AI_Output (self, other, "DIA_Addon_Dexter_Vor_09_02");	//(menacing) It's better for you if you leave now.
	AI_Output (self, other, "DIA_Dexter_Vor_09_02");	//If I see you around here again, I won't hesitate to kill you.
	Dexter_NoMoreSmallTalk = TRUE;
	AI_StopProcessInfos(self);
};


instance DIA_Dexter_Kill(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 2;
	condition = DIA_Dexter_Kill_Condition;
	information = DIA_Dexter_Kill_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dexter_Kill_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && ((Dexter_NoMoreSmallTalk == TRUE) || (Knows_Dexter == FALSE)))
	{
		return TRUE;
	};
};

func void DIA_Dexter_Kill_Info()
{
	if(Knows_Dexter == TRUE)
	{
		AI_Output (self, other, "DIA_Addon_Dexter_Add_09_02");	//(attacking) You asked for this...
	}
	else
	{
		AI_Output (self, other, "DIA_Dexter_Kill_09_01");	//Oh man, you'd have done better not to show up here. You're the wrong man in the wrong place.
	};
	MIS_Steckbriefe = LOG_OBSOLETE;
	B_CheckLog();
	B_Greg_ComesToDexter();
	Info_ClearChoices(DIA_Dexter_Kill);
	Info_AddChoice(DIA_Dexter_Kill,Dialog_Ende,DIA_Dexter_Kill_ENDE);
};

func void DIA_Dexter_Kill_ENDE()
{
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_SuddenEnemyInferno,1);
};


instance DIA_Dexter_Kopf(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 5;
	condition = DIA_Dexter_Kopf_Condition;
	information = DIA_Dexter_Kopf_Info;
	permanent = FALSE;
	description = "You want my head? Come and get it, then!";
};


func int DIA_Dexter_Kopf_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dexter_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Dexter_Kopf_Info()
{
	AI_Output (other, self, "DIA_Addon_Dexter_Add_15_00");	//You want my head? Come and get it, then!
	AI_Output (self, other, "DIA_Addon_Dexter_Add_09_01");	//(attacking) If that's what you want...
	DIA_Dexter_Kill_ENDE ();
};


instance DIA_Dexter_PICKPOCKET(C_Info)
{
	npc = BDT_1060_Dexter;
	nr = 900;
	condition = DIA_Dexter_PICKPOCKET_Condition;
	information = DIA_Dexter_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Dexter_PICKPOCKET_Condition()
{
	return C_Beklauen(96,370);
};

func void DIA_Dexter_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Dexter_PICKPOCKET);
	Info_AddChoice(DIA_Dexter_PICKPOCKET,Dialog_Back,DIA_Dexter_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Dexter_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Dexter_PICKPOCKET_DoIt);
};

func void DIA_Dexter_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Dexter_PICKPOCKET);
};

func void DIA_Dexter_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Dexter_PICKPOCKET);
};

