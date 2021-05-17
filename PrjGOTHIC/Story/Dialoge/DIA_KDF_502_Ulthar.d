
instance DIA_Ulthar_EXIT(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 999;
	condition = DIA_Ulthar_EXIT_Condition;
	information = DIA_Ulthar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Ulthar_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Ulthar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Ulthar_GREET(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 2;
	condition = DIA_Ulthar_GREET_Condition;
	information = DIA_Ulthar_GREET_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Ulthar_GREET_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && !Npc_KnowsInfo(hero,DIA_Pyrokar_FIRE) && (hero.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_GREET_Info()
{
	AI_Output (self, other, "DIA_Ulthar_GREET_05_00");	//Look, the new novice appears before the High Council. Innos be with you, son.
	AI_Output (other, self, "DIA_Ulthar_GREET_15_01");	//What exactly is the task of the High Council?
	AI_Output (self, other, "DIA_Ulthar_GREET_05_02");	//It is our duty to proclaim the will of Innos. Thus, we name the chosen novices who will be put to the Test of Magic.
	AI_Output (self, other, "DIA_Ulthar_GREET_05_03");	//Even though we lead a retired life, we turn our gaze upon the events of the world, for the church of Innos represents the highest earthly law.
	AI_Output (other, self, "DIA_Ulthar_GREET_15_04");	//Ah, so you're interested in what's going on in the world...
	AI_Output (other, self, "DIA_Ulthar_GREET_15_05");	//So what do you think of those dragons squatting in the Valley of Mines, with their army growing every day?
	AI_Output (self, other, "DIA_Ulthar_GREET_05_06");	//I understand that you are angry, but we must first weigh your words before we take any steps.
	AI_Output (self, other, "DIA_Ulthar_GREET_05_07");	//If we allow ourselves to be carried away and act rashly now, we will achieve nothing. Therefore, fulfill your tasks - and we shall discuss what is to be done.
};


instance DIA_Ulthar_MAGETEST(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 2;
	condition = DIA_Ulthar_MAGETEST_Condition;
	information = DIA_Ulthar_MAGETEST_Info;
	description = "Tell me about the Test of Magic.";
};


func int DIA_Ulthar_MAGETEST_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulthar_GREET))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_MAGETEST_Info()
{
	AI_Output (other, self, "DIA_Ulthar_MAGETEST_15_00");	//Tell me about the Test of Magic.
	AI_Output (self, other, "DIA_Ulthar_MAGETEST_05_01");	//It is the chance for the chosen novices to enter the guild of magicians. But only one can pass the test.
	AI_Output (self, other, "DIA_Ulthar_MAGETEST_05_02");	//And Innos alone chooses the novices for it.
};


instance DIA_Ulthar_WHEN(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 3;
	condition = DIA_Ulthar_WHEN_Condition;
	information = DIA_Ulthar_WHEN_Info;
	permanent = TRUE;
	description = "When's the test going to take place?";
};


func int DIA_Ulthar_WHEN_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Ulthar_MAGETEST) && (KNOWS_FIRE_CONTEST == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_WHEN_Info()
{
	AI_Output (other, self, "DIA_Ulthar_WHEN_15_00");	//When's the test going to take place?
	AI_Output (self, other, "DIA_Ulthar_WHEN_05_01");	//As soon as we have heard the will of Innos. We inform the chosen novices, and put them to the test.
};


instance DIA_Ulthar_TEST(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 10;
	condition = DIA_Ulthar_TEST_Condition;
	information = DIA_Ulthar_TEST_Info;
	permanent = FALSE;
	description = "I am ready to face your test, Master.";
};


func int DIA_Ulthar_TEST_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Pyrokar_FIRE))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_TEST_Info()
{
	AI_Output (other, self, "DIA_Ulthar_TEST_15_00");	//I am ready to face your test, Master.
	AI_Output (self, other, "DIA_Ulthar_TEST_05_01");	//I am not surprised that you know the old law.
	AI_Output (self, other, "DIA_Ulthar_TEST_05_02");	//But I suspect that you do not realize what risk you are taking. Bear in mind that an impatient spirit will not withstand the Test of Fire.
	AI_Output (self, other, "DIA_Ulthar_TEST_05_03");	//It has been a long time since anyone took this test. And there is only one man who ever survived it, and passed.
	AI_Output (self, other, "DIA_Ulthar_TEST_05_04");	//A young ambitious novice then, he has long since found his place in the High Council - I speak of Serpentes.
	AI_Output (other, self, "DIA_Ulthar_TEST_15_05");	//He won't be the only one who ever passed that test for much longer.
	AI_Output (self, other, "DIA_Ulthar_TEST_05_06");	//Then I shall not keep you waiting any longer. Hear my test for you:
	AI_Output (self, other, "DIA_Ulthar_TEST_05_07");	//Create a fire arrow rune. That is all - may Innos help you.
	MIS_Rune = LOG_Running;
	Log_CreateTopic (TOPIC_Rune, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_Rune, LOG_Running);
	B_LogEntry (TOPIC_Rune, "Ulthar has given me his test. I'm to create a Fire Arrow rune.");
	AI_StopProcessInfos (self);
};


instance DIA_Ulthar_RUNNING(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 10;
	condition = DIA_Ulthar_RUNNING_Condition;
	information = DIA_Ulthar_RUNNING_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Ulthar_RUNNING_Condition()
{
	if((MIS_Rune == LOG_Running) && Npc_IsInState(self,ZS_Talk) && !Npc_HasItems(other,ItRu_FireBolt))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_RUNNING_Info()
{
	AI_Output (self, other, "DIA_Ulthar_RUNNING_05_00");	//You know your task. Attend to it.
	AI_StopProcessInfos (self);
};


instance DIA_Ulthar_SUCCESS(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 2;
	condition = DIA_Ulthar_SUCCESS_Condition;
	information = DIA_Ulthar_SUCCESS_Info;
	permanent = FALSE;
	description = "I have created the rune!";
};


func int DIA_Ulthar_SUCCESS_Condition()
{
	if((MIS_Rune == LOG_Running) && Npc_HasItems(hero,ItRu_FireBolt))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_SUCCESS_Info()
{
	AI_Output (other, self, "DIA_Ulthar_SUCCESS_15_00");	//I have created the rune!
	AI_Output (self, other, "DIA_Ulthar_SUCCESS_05_01");	//Well done, novice. You shall keep this, your first rune.
	AI_Output (self, other, "DIA_Ulthar_SUCCESS_05_02");	//Once you have reached the first Circle of Fire, you will be able to use it.
	AI_Output (self, other, "DIA_Ulthar_SUCCESS_05_03");	//You have fulfilled this test to my satisfaction.
	if((MIS_Golem == LOG_Running) && !Npc_IsDead(Magic_Golem))
	{
		AI_Output (self, other, "DIA_Ulthar_SUCCESS_05_04");	//But the dangerous task which Serpentes has assigned you still lies before you!
	};
	MIS_Rune = LOG_SUCCESS;
	B_GivePlayerXP(XP_RUNE);
};


instance DIA_Ulthar_PermAbKap3(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 99;
	condition = DIA_Ulthar_PermAbKap3_Condition;
	information = DIA_Ulthar_PermAbKap3_Info;
	permanent = TRUE;
	description = "Any news?";
};


func int DIA_Ulthar_PermAbKap3_Condition()
{
	if((Kapitel >= 3) || Npc_KnowsInfo(other,DIA_Ulthar_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_PermAbKap3_Info()
{
	AI_Output (other, self, "DIA_Ulthar_PermAbKap3_15_00");	//Any news?
	if (hero.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_Ulthar_PermAbKap3_05_01");	//Not at the moment. Go and complete your tasks. You still have much to do.
	}
	else
	{
		AI_Output (self, other, "DIA_Ulthar_PermAbKap3_05_02");	//No. Nothing which you do not already know, Brother.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Ulthar_SCHREINEVERGIFTET(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 30;
	condition = DIA_Ulthar_SCHREINEVERGIFTET_Condition;
	information = DIA_Ulthar_SCHREINEVERGIFTET_Info;
	important = TRUE;
};


func int DIA_Ulthar_SCHREINEVERGIFTET_Condition()
{
	if((Pedro_Traitor == TRUE) && (hero.guild == GIL_PAL) && (Kapitel == 3))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_SCHREINEVERGIFTET_Info()
{
	AI_Output(self,other,"DIA_Ulthar_SCHREINEVERGIFTET_05_00");	//One more thing. Some of the roadside shrines dedicated to Innos have been desecrated by the enemy. They have lost their magical consecration.
	AI_Output (other, self, "DIA_Ulthar_SCHREINEVERGIFTET_15_01");	//I see. And now?
	AI_Output (self, other, "DIA_Ulthar_SCHREINEVERGIFTET_05_02");	//It is up to you to purify these shrines, so that the situation does not escalate.
	CreateInvItems(self,ItMi_UltharsHolyWater_Mis,1);
	B_GiveInvItems(self,other,ItMi_UltharsHolyWater_Mis,1);
	AI_Output (self, other, "DIA_Ulthar_SCHREINEVERGIFTET_05_03");	//Take this holy water and trickle it on the base of the shrine.
	AI_Output (self, other, "DIA_Ulthar_SCHREINEVERGIFTET_05_04");	//With the holy words of purification, the shrine will regain its old power.
	MIS_Ulthar_HeileSchreine_PAL = LOG_Running;
	Log_CreateTopic(TOPIC_Ulthar_HeileSchreine_PAL,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Ulthar_HeileSchreine_PAL,LOG_Running);
	if(!Npc_HasItems(other,ItWr_Map_Shrine_MIS) && !Npc_IsDead(Gorax) && (Gorax_Trade == FALSE))
	{
		B_LogEntries(TOPIC_Ulthar_HeileSchreine_PAL,"Ulthar has given me the task to purify all the shrines the enemy has desecrated with his holy water.");
	}
	else
	{
		B_LogEntry(TOPIC_Ulthar_HeileSchreine_PAL,"Ulthar has given me the task to purify all the shrines the enemy has desecrated with his holy water.");
	};
	if(!Npc_HasItems(other,ItWr_Map_Shrine_MIS))
	{
		if(!Npc_IsDead(Gorax))
		{
			AI_Output(self,other,"DIA_Ulthar_SCHREINEVERGIFTET_05_05");	//Gorax can sell you a map on which our shrines are marked.
			if(!Npc_HasItems(Gorax,ItWr_Map_Shrine_MIS))
			{
				CreateInvItems(Gorax,ItWr_Map_Shrine_MIS,1);
			};
			if(Gorax_Trade == FALSE)
			{
				Log_CreateTopic(Topic_KlosterTrader,LOG_NOTE);
				B_LogNextEntry(Topic_KlosterTrader,"Master Gorax from the monastery can supply me with anything I need");
				Gorax_Trade = TRUE;
			};
		}
		else
		{
			AI_Output(self,other,"DIA_Ulthar_SCHREINEVERGIFTET_05_06");	//Here's a map for you. The shrines which we have set up are marked on it.
			CreateInvItems(self,ItWr_Map_Shrine_MIS,1);
			B_GiveInvItems(self,other,ItWr_Map_Shrine_MIS,1);
		};
	};
	AI_Output(self,other,"DIA_Ulthar_SCHREINEVERGIFTET_05_07");	//Now go and perform your tasks.
	AI_StopProcessInfos(self);
};


instance DIA_Ulthar_WARN(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 30;
	condition = DIA_Ulthar_WARN_Condition;
	information = DIA_Ulthar_WARN_Info;
	important = TRUE;
};


func int DIA_Ulthar_WARN_Condition()
{
	if((Pedro_Traitor == TRUE) && (hero.guild != GIL_PAL) && (Kapitel == 3))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_WARN_Info()
{
	AI_Output(self,other,"DIA_Ulthar_SCHREINEVERGIFTET_05_08");	//One more little thing. Stay away from the roadside shrines. We have heard that some of them have been desecrated.
	AI_Output(self,other,"DIA_Ulthar_SCHREINEVERGIFTET_05_09");	//No one can say what effect they now have.
	if(hero.guild != GIL_MIL)
	{
		AI_Output(self,other,"DIA_Ulthar_SCHREINEVERGIFTET_05_10");	//It is not your task to solve this problem. The paladins will take care of this matter.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Ulthar_SchreineGeheilt(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 30;
	condition = DIA_Ulthar_SchreineGeheilt_Condition;
	information = DIA_Ulthar_SchreineGeheilt_Info;
	description = "I have purified all the shrines.";
};


func int DIA_Ulthar_SchreineGeheilt_Condition()
{
	if(MIS_Ulthar_HeileSchreine_PAL == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Ulthar_SchreineGeheilt_Info()
{
	AI_Output(other,self,"DIA_Ulthar_SchreineGeheilt_15_00");	//I have purified all the shrines.
	AI_Output(self,other,"DIA_Ulthar_SchreineGeheilt_05_01");	//Excellently done, my son. I am proud of you. May Innos watch over you.
	AI_Output(self,other,"DIA_Ulthar_SchreineGeheilt_05_02");	//Take this Amulet of Strength, that it may be of use to you in battle against the enemy.
	CreateInvItems(self,ItAm_Dex_Strg_01,1);
	B_GiveInvItems(self,other,ItAm_Dex_Strg_01,1);
	B_GivePlayerXP(XP_Ulthar_SchreineGereinigt);
	AI_StopProcessInfos(self);
};


instance DIA_Ulthar_SchreineGeheiltNoPAL(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 30;
	condition = DIA_Ulthar_SchreineGeheiltNoPAL_Condition;
	information = DIA_Ulthar_SchreineGeheiltNoPAL_Info;
	important = TRUE;
};


func int DIA_Ulthar_SchreineGeheiltNoPAL_Condition()
{
	if(((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG) || (hero.guild == GIL_KDF)) && (Kapitel >= 4))
	{
		return TRUE;
	};
};

func void DIA_Ulthar_SchreineGeheiltNoPAL_Info()
{
	AI_Output(self,other,"DIA_Ulthar_SchreineGeheiltNoPAL_05_00");	//Good news. The roadside shrines have been purified. The strength of Innos has helped the paladins to remove this problem from the world.
	AI_Output(self,other,"DIA_Ulthar_SchreineGeheiltNoPAL_05_01");	//You may once again make your donations to Innos without reservation or regret.
	AI_StopProcessInfos(self);
};


instance DIA_Ulthar_PICKPOCKET(C_Info)
{
	npc = KDF_502_Ulthar;
	nr = 900;
	condition = DIA_Ulthar_PICKPOCKET_Condition;
	information = DIA_Ulthar_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Ulthar_PICKPOCKET_Condition()
{
	return C_Beklauen(74,320);
};

func void DIA_Ulthar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Ulthar_PICKPOCKET);
	Info_AddChoice(DIA_Ulthar_PICKPOCKET,Dialog_Back,DIA_Ulthar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Ulthar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Ulthar_PICKPOCKET_DoIt);
};

func void DIA_Ulthar_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Ulthar_PICKPOCKET);
};

func void DIA_Ulthar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Ulthar_PICKPOCKET);
};

