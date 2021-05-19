
instance DIA_Udar_EXIT(C_Info)
{
	npc = PAL_268_Udar;
	nr = 999;
	condition = DIA_Udar_EXIT_Condition;
	information = DIA_Udar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Udar_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Udar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Udar_Hello(C_Info)
{
	npc = PAL_268_Udar;
	nr = 2;
	condition = DIA_Udar_Hello_Condition;
	information = DIA_Udar_Hello_Info;
	important = TRUE;
};


func int DIA_Udar_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Kapitel < 4))
	{
		return TRUE;
	};
};

func void DIA_Udar_Hello_Info()
{
	AI_Output (self, other, "DIA_Udar_Hello_09_00");	//You had damned luck when you came in. I very nearly shot you.
	AI_Output (other, self, "DIA_Udar_Hello_15_01");	//Then I guess I should be glad that you have such keen eyesight.
	AI_Output (self, other, "DIA_Udar_Hello_09_02");	//Save your breath. Talk to Sengrath if you want something.
	AI_StopProcessInfos (self);
};


instance DIA_Udar_YouAreBest(C_Info)
{
	npc = PAL_268_Udar;
	nr = 3;
	condition = DIA_Udar_YouAreBest_Condition;
	information = DIA_Udar_YouAreBest_Info;
	permanent = FALSE;
	description = "I heard that you are the BEST crossbowman ...";
};


func int DIA_Udar_YouAreBest_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Keroloth_Udar))
	{
		return TRUE;
	};
};

func void DIA_Udar_YouAreBest_Info()
{
	AI_Output (other, self, "DIA_Udar_YouAreBest_15_00");	//I heard that you are the BEST crossbowman far and wide.
	AI_Output (self, other, "DIA_Udar_YouAreBest_09_01");	//If they say so, it must be true. What do you want?
};


instance DIA_Udar_TeachMe(C_Info)
{
	npc = PAL_268_Udar;
	nr = 3;
	condition = DIA_Udar_TeachMe_Condition;
	information = DIA_Udar_TeachME_Info;
	permanent = FALSE;
	description = "Teach me how to shoot a crossbow..";
};


func int DIA_Udar_TeachMe_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Udar_YouAreBest) && (Udar_TeachPlayer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Udar_TeachME_Info()
{
	AI_Output (other, self, "DIA_Udar_Teacher_15_00");	//Teach me how to shoot a crossbow..
	AI_Output (self, other, "DIA_Udar_Teacher_09_01");	//Scram! There are enough targets running around outside the castle. Practice on them.
};


instance DIA_Udar_ImGood(C_Info)
{
	npc = PAL_268_Udar;
	nr = 3;
	condition = DIA_Udar_ImGood_Condition;
	information = DIA_Udar_ImGood_Info;
	permanent = FALSE;
	description = "I am the greatest.";
};


func int DIA_Udar_ImGood_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Udar_YouAreBest))
	{
		return TRUE;
	};
};

func void DIA_Udar_ImGood_Info()
{
	AI_Output (other, self, "DIA_Udar_ImGood_15_00");	//I am the greatest.
	AI_Output (self, other, "DIA_Udar_ImGood_09_01");	//(laughing) You're all right!
	AI_Output (self, other, "DIA_Udar_ImGood_09_02");	//Well, if you want to learn, then I'll help you.
	Udar_TeachPlayer = TRUE;
	B_LogEntry (TOPIC_Teacher_OC, "Udar can teach me to use a crossbow.");
};


var int DIA_Udar_Teach_permanent;

func void B_BuildLearnDialog_Udar()
{
	if(VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Udar)
	{
		Info_ClearChoices(DIA_Udar_Teach);
		Info_AddChoice(DIA_Udar_Teach,Dialog_Back,DIA_Udar_Teach_Back);
		Info_AddChoice(DIA_Udar_Teach,B_BuildLearnString(PRINT_LearnCrossBow1,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,1)),DIA_Udar_Teach_CROSSBOW_1);
		Info_AddChoice(DIA_Udar_Teach,B_BuildLearnString(PRINT_LearnCrossBow5,B_GetLearnCostTalent(other,NPC_TALENT_CROSSBOW,5)),DIA_Udar_Teach_CROSSBOW_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_CROSSBOW) >= TeachLimit_Crossbow_Udar)
		{
			DIA_Udar_Teach_permanent = TRUE;
		};
		PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_Crossbow_Udar)),-1,53,FONT_Screen,2);
		AI_Output(self,other,"B_Udar_TeachNoMore1_09_00");	//You already know the basics - we don't have time for more.
		if(VisibleTalentValue(NPC_TALENT_CROSSBOW) < 100)
		{
			AI_Output(self,other,"B_Udar_TeachNoMore2_09_00");	//To improve your handling of the weapon, you should look for a proper teacher.
		};
		AI_StopProcessInfos(self);
	};
};

instance DIA_Udar_Teach(C_Info)
{
	npc = PAL_268_Udar;
	nr = 3;
	condition = DIA_Udar_Teach_Condition;
	information = DIA_Udar_Teach_Info;
	permanent = TRUE;
	description = "I want to learn form you.";
};


func int DIA_Udar_Teach_Condition()
{
	if((Udar_TeachPlayer == TRUE) && (DIA_Udar_Teach_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Udar_Teach_Info()
{
	AI_Output(other,self,"DIA_Udar_Teach_15_00");	//I want to learn form you.
	if(VisibleTalentValue(NPC_TALENT_CROSSBOW) < TeachLimit_Crossbow_Udar)
	{
		AI_Output(self,other,"DIA_Udar_Teach_09_01");	//Okay, fire away!
	};
	B_BuildLearnDialog_Udar();
};

func void DIA_Udar_Teach_Back()
{
	Info_ClearChoices(DIA_Udar_Teach);
};

func void DIA_Udar_Teach_CROSSBOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,1,TeachLimit_Crossbow_Udar))
	{
		B_BuildLearnDialog_Udar();
	};
};

func void DIA_Udar_Teach_CROSSBOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_CROSSBOW,5,TeachLimit_Crossbow_Udar))
	{
		B_BuildLearnDialog_Udar();
	};
};

instance DIA_Udar_Perm(C_Info)
{
	npc = PAL_268_Udar;
	nr = 11;
	condition = DIA_Udar_Perm_Condition;
	information = DIA_Udar_Perm_Info;
	permanent = TRUE;
	description = "How are things in the castle?";
};


func int DIA_Udar_Perm_Condition()
{
	return TRUE;
};

func void DIA_Udar_Perm_Info()
{
	AI_Output(other,self,"DIA_Udar_Perm_15_00");	//How are things in the castle?
	if(Kapitel <= 3)
	{
		AI_Output (self, other, "DIA_Udar_Perm_09_01");	//A few of the boys are practicing, but in principle we're all just waiting for something to happen.
		AI_Output (self, other, "DIA_Udar_Perm_09_02");	//This uncertainty is wearing us down. That's the strategy of those blasted orcs. They'll wait until our nerves are shot.
	}
	else if(MIS_OCGateOpen == TRUE)
	{
		AI_Output(self,other,"DIA_Udar_BADFEELING_09_00");	//Another underhanded attack like that and we're history.
	}
	else if(MIS_AllDragonsDead == TRUE)
	{
		AI_Output(self,other,"DIA_Udar_BADFEELING_09_01");	//The orcs are very worried. Something's given them a hell of a scare. I can feel it.
	}
	else
	{
		AI_Output(self,other,"DIA_Udar_BADFEELING_09_02");	//I've got a really bad feeling about this.
	};
};


instance DIA_Udar_Ring(C_Info)
{
	npc = PAL_268_Udar;
	nr = 11;
	condition = DIA_Udar_Ring_Condition;
	information = DIA_Udar_Ring_Info;
	permanent = FALSE;
	description = "Here, I bring you Tengron's ring ...";
};


func int DIA_Udar_Ring_Condition()
{
	if(Npc_HasItems(other,ItRi_HP_01_Tengron))
	{
		return TRUE;
	};
};

func void DIA_Udar_Ring_Info()
{
	AI_Output(other,self,"DIA_Udar_Ring_15_00");	//Here, I bring you Tengron's ring. It's supposed to protect you. Tengron sys he'll come and get it once he's back.
	B_GiveInvItems(other,self,ItRi_HP_01_Tengron,1);
	AI_Output (self, other, "DIA_Udar_Ring_09_01");	//What? Do you know what ring that is? He got that ring as an award for his courage in battle.
	AI_Output (self, other, "DIA_Udar_Ring_09_02");	//You say he wants to get it back? If it's the will of Innos, he is going to. If it's the will of Innos...
	TengronRing = TRUE;
	B_GivePlayerXP(XP_TengronRing);
};


instance DIA_Udar_Kap4WiederDa(C_Info)
{
	npc = PAL_268_Udar;
	nr = 40;
	condition = DIA_Udar_Kap4WiederDa_Condition;
	information = DIA_Udar_Kap4WiederDa_Info;
	important = TRUE;
};


func int DIA_Udar_Kap4WiederDa_Condition()
{
	if(Kapitel >= 4)
	{
		return TRUE;
	};
};

func void DIA_Udar_Kap4WiederDa_Info()
{
	AI_Output (self, other, "DIA_Udar_Kap4WiederDa_09_00");	//It's good that you've come. All hell is breaking loose here.
	if (hero.guild != GIL_DJG)
	{
		AI_Output (other, self, "DIA_Udar_Kap4WiederDa_15_01");	//What happened?
		AI_Output (self, other, "DIA_Udar_Kap4WiederDa_09_02");	//The dragon hunters are strutting around here in the castle and bragging that they can solve the dragon problem.
		AI_Output (self, other, "DIA_Udar_Kap4WiederDa_09_03");	//But I'll tell you what, the way they look, they won't even kill a sick, old snapper.
	};
	AI_Output (self, other, "DIA_Udar_Kap4WiederDa_09_04");	//A lot of us are getting really worried by now and no longer truly believe that we'll ever make it out of here alive.
};


instance DIA_Udar_Sengrath(C_Info)
{
	npc = PAL_268_Udar;
	nr = 41;
	condition = DIA_Udar_Sengrath_Condition;
	information = DIA_Udar_Sengrath_Info;
	description = "Weren't there two of you sentinels up here?";
};


func int DIA_Udar_Sengrath_Condition()
{
	if((Kapitel >= 4) && Npc_KnowsInfo(other,DIA_Udar_Kap4WiederDa) && (Sengrath_Missing == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Udar_Sengrath_Info()
{
	AI_Output (other, self, "DIA_Udar_Sengrath_15_00");	//Weren't there two of you sentinels up here?
	AI_Output (self, other, "DIA_Udar_Sengrath_09_01");	//Not any more. Sengrath stood here on the battlements when suddenly he fell asleep.
	AI_Output (self, other, "DIA_Udar_Sengrath_09_02");	//His good crossbow fell down when that happened.
	AI_Output (self, other, "DIA_Udar_Sengrath_09_03");	//We could only just see one of the orcs snatch it up and disappear with it into the darkness.
	AI_Output (self, other, "DIA_Udar_Sengrath_09_04");	//Sengrath woke up then and just ran into the night towards the Orc palisades. He hasn't come back since.
	AI_Output (self, other, "DIA_Udar_Sengrath_09_05");	//Innos be with us!
	Log_CreateTopic (TOPIC_Sengrath_Missing, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Sengrath_Missing, LOG_Running);
	B_LogEntry (TOPIC_Sengrath_Missing, "Udar, the guardsman at the castle, misses his pal Sengrath. The last time he saw him was late one night, and he was heading for the orc fence to get back his crossbow.");
};


instance DIA_Udar_SENGRATHGEFUNDEN(C_Info)
{
	npc = PAL_268_Udar;
	nr = 42;
	condition = DIA_Udar_SENGRATHGEFUNDEN_Condition;
	information = DIA_Udar_SENGRATHGEFUNDEN_Info;
	description = "I've found Sengrath.";
};


func int DIA_Udar_SENGRATHGEFUNDEN_Condition()
{
	if((Kapitel >= 4) && Npc_KnowsInfo(other,DIA_Udar_Sengrath) && !Npc_HasItems(DeadSengrath,ItRw_SengrathsArmbrust_MIS))
	{
		return TRUE;
	};
};

func void DIA_Udar_SENGRATHGEFUNDEN_Info()
{
	AI_Output (other, self, "DIA_Udar_SENGRATHGEFUNDEN_15_00");	//I've found Sengrath.
	AI_Output (self, other, "DIA_Udar_SENGRATHGEFUNDEN_09_01");	//Really? Where is he?
	if(Npc_HasItems(other,ItRw_SengrathsArmbrust_MIS))
	{
		AI_Output (other, self, "DIA_Udar_SENGRATHGEFUNDEN_15_02");	//He's dead. Here's his crossbow. He had it with him.
		AI_Output (self, other, "DIA_Udar_SENGRATHGEFUNDEN_09_03");	//He must have gotten his crossbow back, but then the orcs seem to have slain him after all.
	}
	else
	{
		DIA_Common_HeIsDead();
	};
	AI_Output(self,other,"DIA_Udar_SENGRATHGEFUNDEN_09_04");	//Damn fool. I knew it. We're all going to die.
	TOPIC_END_Sengrath_Missing = TRUE;
	B_GivePlayerXP(XP_SengrathFound);
};


instance DIA_Udar_PICKPOCKET(C_Info)
{
	npc = PAL_268_Udar;
	nr = 900;
	condition = DIA_Udar_PICKPOCKET_Condition;
	information = DIA_Udar_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Udar_PICKPOCKET_Condition()
{
	return C_Beklauen(20,15);
};

func void DIA_Udar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Udar_PICKPOCKET);
	Info_AddChoice(DIA_Udar_PICKPOCKET,Dialog_Back,DIA_Udar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Udar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Udar_PICKPOCKET_DoIt);
};

func void DIA_Udar_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Udar_PICKPOCKET);
};

func void DIA_Udar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Udar_PICKPOCKET);
};

