
instance DIA_Alwin_EXIT(C_Info)
{
	npc = VLK_424_Alwin;
	nr = 999;
	condition = DIA_Alwin_EXIT_Condition;
	information = DIA_Alwin_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Alwin_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Alwin_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Alwin_PICKPOCKET(C_Info)
{
	npc = VLK_424_Alwin;
	nr = 900;
	condition = DIA_Alwin_PICKPOCKET_Condition;
	information = DIA_Alwin_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Alwin_PICKPOCKET_Condition()
{
	return C_Beklauen(20,10);
};

func void DIA_Alwin_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Alwin_PICKPOCKET);
	Info_AddChoice(DIA_Alwin_PICKPOCKET,Dialog_Back,DIA_Alwin_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Alwin_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Alwin_PICKPOCKET_DoIt);
};

func void DIA_Alwin_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Alwin_PICKPOCKET);
};

func void DIA_Alwin_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Alwin_PICKPOCKET);
};


instance DIA_Alwin_Sheep(C_Info)
{
	npc = VLK_424_Alwin;
	nr = 3;
	condition = DIA_Alwin_Sheep_Condition;
	information = DIA_Alwin_Sheep_Info;
	permanent = FALSE;
	description = "Are those your sheep?";
};


func int DIA_Alwin_Sheep_Condition()
{
	if(!Npc_IsDead(Alwin_Sheep1) || !Npc_IsDead(Alwin_Sheep2) || !Npc_IsDead(Alwin_Sheep3))
	{
		return TRUE;
	};
};

func void DIA_Alwin_Sheep_Info()
{
	AI_Output(other,self,"DIA_Alwin_Sheep_15_00");	//Are those your sheep?
	AI_Output(self,other,"DIA_Alwin_Sheep_12_01");	//The only one that belongs to me is the one that answers to the name of Lucy. (laughs) That's my wife - Lucy.
	if(SC_KnowsKlosterTribut == TRUE)
	{
		DIA_Common_CanIBuySheep();
	};
	AI_Output(self,other,"DIA_Alwin_Sheep_12_02");	//The sheep belong to the militia. All the sheep they collect from the farmers they bring to me.
};


instance DIA_Alwin_Fellan(C_Info)
{
	npc = VLK_424_Alwin;
	nr = 2;
	condition = DIA_Alwin_Fellan_Condition;
	information = DIA_Alwin_Fellan_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Alwin_Fellan_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && !Npc_IsDead(Fellan))
	{
		return TRUE;
	};
};

func void DIA_Alwin_Fellan_Info()
{
	AI_Output (self, other, "DIA_Alwin_Fellan_12_00");	//Boy, that lunatic's hammering is wearing me down.
	AI_Output (other, self, "DIA_Alwin_Fellan_15_01");	//Who are you talking about?
	AI_Output (self, other, "DIA_Alwin_Fellan_12_02");	//Can't you hear that hammering? Who do you think hammers all day long in the harbor district?
	AI_Output (self, other, "DIA_Alwin_Fellan_12_03");	//I mean that lunatic Fellan. He takes the hammer to his hut every day.
};


instance DIA_Alwin_FellanRunning(C_Info)
{
	npc = VLK_424_Alwin;
	nr = 2;
	condition = DIA_Alwin_FellanRunning_Condition;
	information = DIA_Alwin_FellanRunning_Info;
	permanent = FALSE;
	description = "I could take care of Fellan ...";
};


func int DIA_Alwin_FellanRunning_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Alwin_Fellan))
	{
		return TRUE;
	};
};

func void DIA_Alwin_FellanRunning_Info()
{
	AI_Output (other, self, "DIA_Alwin_FellanRunning_15_00");	//I could take care of Fellan ...
	AI_Output (self, other, "DIA_Alwin_FellanRunning_12_01");	//You want to help me? What's in it for you?
	AI_Output (other, self, "DIA_Alwin_FellanRunning_15_02");	//You tell me.
	AI_Output (self, other, "DIA_Alwin_FellanRunning_12_03");	//Oh, that's how it is! All right - if you can get him to stop hammering, I'll pay you 25 gold pieces.
	AI_Output (self, other, "DIA_Alwin_FellanRunning_12_04");	//But I'll tell you one thing right now - you can't talk to the guy. He's nuts. The only thing that will help is a few decent punches!
	MIS_AttackFellan = LOG_Running;
	Log_CreateTopic (TOPIC_Alwin, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Alwin, LOG_Running);
	B_LogEntry (TOPIC_Alwin, "Alwin wants me to get Fellan to stop hammering. It doesn't seem appropriate to kill him.");
	Info_ClearChoices (DIA_Alwin_FellanRunning);
	Info_AddChoice (DIA_Alwin_FellanRunning, "I'll see what I can do ...", DIA_Alwin_FellanRunning_Ok);
	if ((hero.guild != GIL_MIL) && (hero.guild != GIL_PAL) && (hero.guild != GIL_KDF))
	{
		Info_AddChoice (DIA_Alwin_FellanRunning, "If I beat him up, I'll just get into trouble with the militia ...", DIA_Alwin_FellanRunning_Problems);
	};
};

func void DIA_Alwin_FellanRunning_Ok()
{
	AI_Output (other, self, "DIA_Alwin_FellanRunning_Ok_15_00");	//I'll see what I can do ...
	AI_Output (self, other, "DIA_Alwin_FellanRunning_Ok_12_01");	//You can think about it. Remember, I'll pay you 25 gold coins.
	Info_ClearChoices (DIA_Alwin_FellanRunning);
};

func void DIA_Alwin_FellanRunning_Problems()
{
	AI_Output (other, self, "DIA_Alwin_FellanRunning_Problems_15_00");	//If I beat him up, I'll just get into trouble with the militia ...
	AI_Output (self, other, "DIA_Alwin_Add_12_00");	//Down here at the harbor, no one pays much attention to brawls ...
	AI_Output (self, other, "DIA_Alwin_Add_12_01");	//But if you steal around here, or mess with the sheep, you'll be in trouble.
};


instance DIA_Alwin_FellanSuccess(C_Info)
{
	npc = VLK_424_Alwin;
	nr = 4;
	condition = DIA_Alwin_FellanSuccess_Condition;
	information = DIA_Alwin_FellanSuccess_Info;
	permanent = FALSE;
	description = "Fellan will hammer no longer.";
};


func int DIA_Alwin_FellanSuccess_Condition()
{
	if((MIS_AttackFellan == LOG_Running) && ((FellanGeschlagen == TRUE) || Npc_IsDead(Fellan)))
	{
		return TRUE;
	};
};

func void DIA_Alwin_FellanSuccess_Info()
{
	AI_Output(other,self,"DIA_Alwin_FellanSuccess_15_00");	//Fellan will hammer no longer.
	if(!Npc_IsDead(Fellan))
	{
		AI_Output(self,other,"DIA_Alwin_FellanSuccess_12_01");	//Hear that? No more hammering. At last. I thought the fellow would never quit.
		AI_Output(self,other,"DIA_Alwin_FellanSuccess_12_02");	//You've done me a huge favor. You know what, I'll give you 30 gold pieces.
		B_GiveInvItems(self,other,ItMi_Gold,30);
		MIS_AttackFellan = LOG_SUCCESS;
		B_GivePlayerXP(XP_Ambient);
	}
	else
	{
		B_Say(self,other,"$YOUMURDERER");
		B_Say(self,other,"$GETOUTOFHERE");
		MIS_AttackFellan = LOG_FAILED;
		B_MemorizePlayerCrime(self,other,CRIME_MURDER);
		B_CheckLog();
		AI_StopProcessInfos(self);
	};
};


func void B_AlwinAboutDeadSheeps()
{
	AI_Output(self,other,"DIA_Alwin_Endlos_12_13");	//Well, then at least I'll have more time for my wife.
};

instance DIA_Alwin_Endlos(C_Info)
{
	npc = VLK_424_Alwin;
	nr = 8;
	condition = DIA_Alwin_Endlos_Condition;
	information = DIA_Alwin_Endlos_Info;
	permanent = TRUE;
	description = "And, how are the sheep?";
};


func int DIA_Alwin_Endlos_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Alwin_Sheep))
	{
		return TRUE;
	};
};

func void DIA_Alwin_Endlos_Info()
{
	AI_Output(other,self,"DIA_Alwin_Endlos_15_00");	//Как твои овцы?
	if(Npc_IsDead(Alwin_Sheep1) && Npc_IsDead(Alwin_Sheep2) && Npc_IsDead(Alwin_Sheep3))
	{
		B_AlwinAboutDeadSheeps();
	}
	else if((MIS_AttackFellan != LOG_SUCCESS) && !Npc_IsDead(Fellan))
	{
		AI_Output(self,other,"DIA_Alwin_Endlos_12_01");	//Fellan's hammering is going to drive them crazy. One of these days they'll go completely to pieces.
	}
	else if(Kapitel <= 2)
	{
		AI_Output(self,other,"DIA_Alwin_Endlos_12_02");	//The sheep eat and get fatter and fatter. Just like my wife. HAHAHA (laughs loudly)
	}
	else if(Kapitel == 3)
	{
		if(MIS_RescueBennet != LOG_SUCCESS)
		{
			AI_Output (self, other, "DIA_Alwin_Endlos_12_03");	//I'll probably have to slaughter one of them. For the last meal!
			AI_Output (other, self, "DIA_Alwin_Endlos_15_04");	//For what?
			AI_Output (self, other, "DIA_Alwin_Endlos_12_05");	//For the mercenary who murdered the paladin. Of course he'll be executed.
			AI_Output (self, other, "DIA_Alwin_Endlos_12_06");	//I just have to decide which of the creatures will go to the slaughtering-block.
		}
		else
		{
			AI_Output (self, other, "DIA_Alwin_Endlos_12_07");	//Lucy is really lucky to be alive.
			AI_Output (other, self, "DIA_Alwin_Endlos_15_08");	//I thought you said Lucy was your wife.
			AI_Output (self, other, "DIA_Alwin_Endlos_12_09");	//Right, but I also called the sheep Lucy. I mean the sheep that was meant for the last meal for that Bennet.
			AI_Output (self, other, "DIA_Alwin_Endlos_12_10");	//But that all worked out. Lucy will be glad.
		};
	}
	else if(Kapitel == 4)
	{
		AI_Output (self, other, "DIA_Alwin_Endlos_12_11");	//As time goes by, watching the sheep eat gets to be pretty boring.
	}
	else
	{
		AI_Output(self,other,"DIA_Alwin_Endlos_12_12");	//I'm saying goodbye to them. Lord Hagen has ordered that all the sheep are to serve as provisions for his army.
		B_AlwinAboutDeadSheeps();
	};
};

