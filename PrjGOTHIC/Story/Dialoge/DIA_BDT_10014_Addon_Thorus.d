
instance DIA_Addon_BDT_10014_Thorus_EXIT(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 999;
	condition = DIA_Addon_Thorus_EXIT_Condition;
	information = DIA_Addon_Thorus_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Thorus_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Thorus_EXIT_Info()
{
	EnteredBanditsCamp = TRUE;
	AI_StopProcessInfos(self);
};


instance DIA_Addon_BDT_10014_Thorus_Hi(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 2;
	condition = DIA_Addon_Thorus_Hi_Condition;
	information = DIA_Addon_Thorus_Hi_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Thorus_Hi_Condition()
{
	if(RavenIsDead == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Hi_Info()
{
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Hi_12_00");	//You know the rule. No one goes into the mine without a red stone tablet.
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Hi_15_01");	//Forget the mine - I have to see Raven.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Hi_12_02");	//Even then. We have rules here and they apply to everyone. Even to you.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Hi_12_03");	//Go back. If you try to enter the upper square without permission, the other guards will kill you. THOSE are the rules.
	if (!Npc_IsDead (Esteban))
	{
		AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Hi_12_04");	//If you have a problem with that, go talk to Esteban. He's responsible for the camp.
	};
	EnteredBanditsCamp = TRUE;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"START");
};


instance DIA_Addon_BDT_10014_Thorus_Raven(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 3;
	condition = DIA_Addon_Thorus_Raven_Condition;
	information = DIA_Addon_Thorus_Raven_Info;
	permanent = FALSE;
	description = "It's important that I get to Raven...";
};


func int DIA_Addon_Thorus_Raven_Condition()
{
	if(RavenIsDead == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Raven_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Raven_15_00");	//It's important that I get to Raven...
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Raven_12_01");	//Oh, yeah? Do you really think you can make it through to him?
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Raven_12_02");	//His guards have orders not to let ANYONE in. You'd be dead before you even saw him.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Raven_12_03");	//So knock that idea out of your head.
	Log_CreateTopic (TOPIC_Addon_RavenKDW, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Addon_RavenKDW, LOG_Running);
	B_LogEntry (TOPIC_Addon_RavenKDW, "Raven is the leader of the bandits. I will have to get some of them out of the way in order to get to him.");
};


instance DIA_Addon_BDT_10014_Thorus_Zeit(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 4;
	condition = DIA_Addon_Thorus_Zeit_Condition;
	information = DIA_Addon_Thorus_Zeit_Info;
	permanent = FALSE;
	description = "Don't you remember me? From the Old Camp...";
};


func int DIA_Addon_Thorus_Zeit_Condition()
{
	if((RavenIsDead == FALSE) && (MIS_Send_Buddler != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Zeit_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Zeit_15_00");	//Don't you remember me? From the Old Camp...
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Zeit_12_01");	//You were one of the prisoners?! Maybe you were one of my guards. And? Does that make us allies now?
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Zeit_12_02");	//No, it doesn't.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Zeit_12_03");	//Maybe you're the guy who brought down the Barrier - maybe you also killed my pals.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Zeit_12_04");	//So what?
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Zeit_12_05");	//Those times are over.
	if (!Npc_IsDead (Esteban))
	{
		AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Zeit_12_06");	//You want in? Then get yourself a red stone and don't waste my time.
	};
};


var int Thorus_GoodOldPerm;

instance DIA_Addon_BDT_10014_Thorus_GoodOldPerm(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 4;
	condition = DIA_Addon_Thorus_GoodOldPerm_Condition;
	information = DIA_Addon_Thorus_GoodOldPerm_Info;
	permanent = TRUE;
	description = "Come on, let me in. For old times' sake.";
};


func int DIA_Addon_Thorus_GoodOldPerm_Condition()
{
	if((MIS_Send_Buddler != LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_Addon_BDT_10014_Thorus_Zeit) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_GoodOldPerm_Info()
{
	AI_Output (other, self, "DIA_Addon_Thorus_Add_15_00");	//Come on, let me in. For old times' sake.
	if (Thorus_GoodOldPerm == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_Thorus_Add_12_01");	//Let me explain something to you. Do you know why I'm still alive?
		AI_Output (self, other, "DIA_Addon_Thorus_Add_12_02");	//Because I've always been loyal to my people.
		AI_Output (self, other, "DIA_Addon_Thorus_Add_12_03");	//I don't have to agree with everything Raven does. But I'll stick to the rules.
		AI_Output (self, other, "DIA_Addon_Thorus_Add_12_04");	//And so will you!
		Thorus_GoodOldPerm = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Thorus_Add_12_05");	//(firmly) No!
	};
};

func int C_PlayerHasWrongToken()
{
	if(C_ScHasMagicStonePlate() || Npc_HasItems(hero,ItWr_StonePlateCommon_Addon) || Npc_HasItems(hero,ItMi_Addon_Stone_02) || Npc_HasItems(hero,ItMi_Addon_Stone_03) || Npc_HasItems(hero,ItMi_Addon_Stone_04) || Npc_HasItems(hero,ItMi_Addon_Stone_05))
	{
		return TRUE;
	};
	return FALSE;
};


instance DIA_Addon_BDT_10014_Thorus_Stein(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 9;
	condition = DIA_Addon_Thorus_Stein_Condition;
	information = DIA_Addon_Thorus_Stein_Info;
	permanent = TRUE;
	description = "I have a stone tablet for you here...";
};


func int DIA_Addon_Thorus_Stein_Condition()
{
	if(C_PlayerHasWrongToken() && (RavenIsDead == FALSE) && (MIS_Send_Buddler != LOG_Running) && (MIS_Send_Buddler != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Stein_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Stein_15_00");	//I have a stone tablet for you here...
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Stein_12_01");	//You don't have the right stone. Only the red ones are important.
};


instance DIA_Addon_BDT_10014_Thorus_Rein(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 9;
	condition = DIA_Addon_Thorus_Rein_Condition;
	information = DIA_Addon_Thorus_Rein_Info;
	permanent = FALSE;
	description = "I have a red stone tablet here...";
};


func int DIA_Addon_Thorus_Rein_Condition()
{
	if((MIS_Send_Buddler != LOG_SUCCESS) && Npc_HasItems(other,ItMi_Addon_Stone_01) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Rein_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Rein_15_00");	//I have a red stone tablet here...
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Rein_12_01");	//Okay.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Rein_12_02");	//You killed Esteban - so YOU will do his job now.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Rein_12_03");	//They have a few problems with minecrawlers in the mine.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Rein_12_04");	//Three diggers have bought it already. It's your job to provide replacements.
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Rein_15_05");	//And when can I finally get into the damned mine?
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Rein_12_06");	//Do your job - afterwards you can do what you want.
	MIS_Send_Buddler = LOG_Running;
	Log_CreateTopic (Topic_Addon_Buddler, LOG_MISSION);
	Log_SetTopicStatus (Topic_Addon_Buddler, LOG_Running);
	B_LogEntry (Topic_Addon_Buddler, "Since I have taken over Esteban's job, I'm supposed to send three diggers to the mine.");
};


instance DIA_Addon_BDT_10014_Thorus_Sent(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 9;
	condition = DIA_Addon_Thorus_Sent_Condition;
	information = DIA_Addon_Thorus_Sent_Info;
	permanent = FALSE;
	description = "I sent out three guys.";
};


func int DIA_Addon_Thorus_Sent_Condition()
{
	if((Player_SentBuddler >= 3) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Sent_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Sent_15_00");	//I sent out three guys.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Sent_12_01");	//All right. Then as far as I'm concerned you can go in.
	MIS_Send_Buddler = LOG_SUCCESS;
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Addon_BDT_10014_Thorus_Armor(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 99;
	condition = DIA_Addon_Thorus_Armor_Condition;
	information = DIA_Addon_Thorus_Armor_Info;
	permanent = FALSE;
	description = "Hey, what's with your armor? Where can I get armor like that?";
};


func int DIA_Addon_Thorus_Armor_Condition()
{
	if(!Npc_HasItems(other,ITAR_Thorus_Addon))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Armor_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Armor_15_00");	//Hey, what's with your armor? Where can I get armor like that?
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Armor_12_01");	//You can't. This armor is reserved for Raven's guard.
	if(RavenIsDead == FALSE)
	{
		AI_Output(self,other,"DIA_Addon_BDT_10014_Thorus_Armor_12_02");	//I hardly think there's an entrance exam for new candidates. But the ultimate decision isn't mine, it's Raven's.
	};
};


instance DIA_Addon_Thorus_Gefangene(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 88;
	condition = DIA_Addon_Thorus_Gefangene_Condition;
	information = DIA_Addon_Thorus_Gefangene_Info;
	permanent = FALSE;
	description = "How are the prisoners?";
};


func int DIA_Addon_Thorus_Gefangene_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Patrick_Hi) && !Npc_KnowsInfo(other,DIA_Addon_Thorus_Answer))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Gefangene_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Gefangene_15_00");	//How are the prisoners?
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Gefangene_12_01");	//Mmh, they've done their job. As far as I know, they're supposed to be digging gold now.
	if(!Npc_IsDead(Bloodwyn))
	{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Gefangene_15_02");	//And if they escape...?
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Gefangene_12_03");	//...Bloodwyn will send his guards after them. But I hardly think they would be crazy enough to try to escape.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Gefangene_12_04");	//Unless...
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Gefangene_15_05");	//Unless, what?
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Gefangene_12_06");	//...someone else put them up to it. But I don't know anyone stupid enough to do that... at least, so long as Bloodwyn is here.
		B_Say(other,self,"$VERSTEHE");
	};
};


instance DIA_Addon_Thorus_Attack(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 90;
	condition = DIA_Addon_Thorus_Attack_Condition;
	information = DIA_Addon_Thorus_Attack_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Thorus_Attack_Condition()
{
	if((Npc_IsDead(Torwache2)) && (RavenIsDead == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Attack_Info()
{
	if(MIS_Send_Buddler != LOG_SUCCESS)
	{
		MIS_Send_Buddler = LOG_OBSOLETE;
	};
	B_CheckLog();
	EnteredBanditsCamp = TRUE;
	B_Say(self,other,"$ALARM");
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_GuardStopsIntruder,0);
};


instance DIA_Addon_Thorus_Speech(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 91;
	condition = DIA_Addon_Thorus_Speech_Condition;
	information = DIA_Addon_Thorus_Speech_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Addon_Thorus_Speech_Condition()
{
	if(Npc_IsDead(Bloodwyn))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Speech_Info()
{
	AI_Output(self,other,"DIA_Addon_Thorus_Speech_12_00");	//What are you planning?
	if(!Npc_KnowsInfo(other,DIA_Addon_Thorus_Raventot))
	{
		AI_Output(other,self,"DIA_Addon_Thorus_Speech_15_01");	//What???
		AI_Output(self,other,"DIA_Addon_Thorus_Speech_12_02");	//Now you've cleared Bloodwyn out of the way, too. I'm just asking myself who's next. Raven? Or me?
	};
	AI_Output (self, other, "DIA_Addon_Thorus_Speech_12_05");	//This camp is the only thing we have left.
	AI_Output (self, other, "DIA_Addon_Thorus_Speech_12_06");	//It may not have always run to perfection, but it DOES run.
	AI_Output (self, other, "DIA_Addon_Thorus_Speech_12_07");	//And with every person you kill, another piece of our community breaks up.
	AI_Output (self, other, "DIA_Addon_Thorus_Speech_12_08");	//We are bandits. Outcasts, lawbreakers, desperados.
	AI_Output (self, other, "DIA_Addon_Thorus_Speech_12_09");	//Wherever we go, we're hunted, locked up and killed.
	AI_Output (self, other, "DIA_Addon_Thorus_Speech_12_10");	//There is no better place for us than this, no better time than now.
	AI_Output (other, self, "DIA_Addon_Thorus_Speech_15_11");	//What are you getting at?
	AI_Output (self, other, "DIA_Addon_Thorus_Speech_12_12");	//These men need someone to lead them. Who should that be? You? You, who is constantly roaming from place to place?
	AI_Output(other,self,"DIA_Addon_BDT_10014_Thorus_Answer_15_00");	//Then you take over the leadership of the camp.
	if(!Npc_KnowsInfo(other,DIA_Addon_Thorus_Raventot))
	{
		AI_Output(self,other,"DIA_Addon_BDT_10014_Thorus_Answer_12_01");	//Okay, but what about Raven?
		if(RavenIsDead == FALSE)
		{
			AI_Output(other,self,"DIA_Addon_BDT_10014_Thorus_Answer_15_02");	//Raven will soon have other worries. I'll take care of him.
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Thorus_Add_12_01");	//Let me explain something to you. Do you know why I'm still alive?
		AI_Output(self,other,"DIA_Addon_Thorus_Add_12_02");	//Because I've always been loyal to my people.
	};
	if(!Npc_IsDead(Torwache2))
	{
		Torwache2.aivar[AIV_PASSGATE] = TRUE;
	};
};


instance DIA_Addon_Thorus_Answer(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 93;
	condition = DIA_Addon_Thorus_Answer_Condition;
	information = DIA_Addon_Thorus_Answer_Info;
	permanent = FALSE;
	description = "I did it. Raven is finished.";
};


func int DIA_Addon_Thorus_Answer_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Thorus_Speech) && Npc_KnowsInfo(other,DIA_Addon_Patrick_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Answer_Info()
{
	AI_Output(other,self,"DIA_Addon_BDT_10014_Thorus_Answer_15_03");	//Oh, yes, and make sure that the prisoners can leave the camp in peace.
	AI_Output(self,other,"DIA_Addon_BDT_10014_Thorus_Answer_12_04");	//All right. I shall take care of all the guards out here.
	B_LogEntry(TOPIC_Addon_Sklaven,"Bloodwyn is dead, and Thorus will make sure that the slaves can leave the camp.");
	if(!Npc_IsDead(PrisonGuard))
	{
		B_LogEntry(TOPIC_Addon_Sklaven,"Now I'll talk to the 'slave guard' again, then Patrick and his boys can take off.");
	}
	else
	{
		B_LogEntry(TOPIC_Addon_Sklaven,"Since the 'slave guard' is finished, Patrick can now leave with his boys.");
	};
};


instance DIA_Addon_Thorus_Raventot(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 92;
	condition = DIA_Addon_Thorus_Raventot_Condition;
	information = DIA_Addon_Thorus_Raventot_Info;
	permanent = FALSE;
	description = "I did it. Raven is finished.";
};


func int DIA_Addon_Thorus_Raventot_Condition()
{
	if(RavenIsDead == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Thorus_Raventot_Info()
{
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Raventot_15_00");	//I did it. Raven is finished.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Raventot_12_01");	//That means you've given Beliar a swift kick.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Raventot_12_02");	//Then you'll be moving on?
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Raventot_15_03");	//My job in this valley is done. I could use a few days' rest.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Raventot_12_04");	//(laughs) Yeah, you're constantly on the move, aren't you? (seriously) Have a good journey.
	AI_Output (other, self, "DIA_Addon_BDT_10014_Thorus_Raventot_15_05");	//Who knows, maybe we'll run into each other again.
	AI_Output (self, other, "DIA_Addon_BDT_10014_Thorus_Raventot_12_06");	//Who knows. There will be lots of gates and passages for you to go through. And you're bound to find me on one of them...
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"START");
};


instance DIA_Addon_Thorus_PICKPOCKET(C_Info)
{
	npc = BDT_10014_Addon_Thorus;
	nr = 900;
	condition = DIA_Addon_Thorus_PICKPOCKET_Condition;
	information = DIA_Addon_Thorus_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60_Key;
};


func int DIA_Addon_Thorus_PICKPOCKET_Condition()
{
//	return C_StealItems(60,Hlp_GetInstanceID(ItKe_Addon_Thorus),1);
	if(Npc_HasItems(self,ItKe_Addon_Thorus))
	{
		return C_StealItem(60);
	};
	return FALSE;
};

func void DIA_Addon_Thorus_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Thorus_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Thorus_PICKPOCKET,Dialog_Back,DIA_Addon_Thorus_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Thorus_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Thorus_PICKPOCKET_DoIt);
};

func void DIA_Addon_Thorus_PICKPOCKET_DoIt()
{
//	B_StealItems(60,Hlp_GetInstanceID(ItKe_Addon_Thorus),1);
	B_StealItem(60,Hlp_GetInstanceID(ItKe_Addon_Thorus));
	Info_ClearChoices(DIA_Addon_Thorus_PICKPOCKET);
};

func void DIA_Addon_Thorus_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Thorus_PICKPOCKET);
};

