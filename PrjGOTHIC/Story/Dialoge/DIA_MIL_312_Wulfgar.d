
instance DIA_Wulfgar_EXIT(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 999;
	condition = DIA_Wulfgar_EXIT_Condition;
	information = DIA_Wulfgar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Wulfgar_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Wulfgar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Wulfgar_Hallo(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 1;
	condition = DIA_Wulfgar_Hallo_Condition;
	information = DIA_Wulfgar_Hallo_Info;
	permanent = FALSE;
	description = "How's your duty?";
};


func int DIA_Wulfgar_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Wulfgar_Hallo_Info()
{
	AI_Output (other, self, "DIA_Wulfgar_Hallo_15_00");	//How's your duty?
	AI_Output (self, other, "DIA_Wulfgar_Hallo_04_01");	//(scornful) These boys swing their swords like farmers.
	AI_Output (self, other, "DIA_Wulfgar_Hallo_04_02");	//(convinced) But when I'm done with them, every single one of them will be a tough, hard bastard.
};


instance DIA_Wulfgar_WannaJoin(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 2;
	condition = DIA_Wulfgar_WannaJoin_Condition;
	information = DIA_Wulfgar_WannaJoin_Info;
	permanent = FALSE;
	description = "I want to join the militia!";
};


func int DIA_Wulfgar_WannaJoin_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wulfgar_Hallo) && (other.guild == GIL_NONE))
	{
		return TRUE;
	};
};

func void DIA_Wulfgar_WannaJoin_Info()
{
	AI_Output (other, self, "DIA_Wulfgar_WannaJoin_15_00");	//I want to join the militia!
	AI_Output (self, other, "DIA_Wulfgar_WannaJoin_04_01");	//So? Are you a citizen of the town?
	if (Player_IsApprentice == APP_NONE)
	{
		AI_Output (other, self, "DIA_Wulfgar_WannaJoin_15_02");	//No.
		AI_Output (self, other, "DIA_Wulfgar_WannaJoin_04_03");	//Then Lord Andre won't take you.
		AI_Output (self, other, "DIA_Wulfgar_WannaJoin_04_04");	//Sure, you can talk to him - but I don't think he'll make an exception for you.
	}
	else
	{
		AI_Output (other, self, "DIA_Wulfgar_WannaJoin_15_05");	//Yes.
		AI_Output (self, other, "DIA_Wulfgar_WannaJoin_04_06");	//Then talk to Lord Andre. He decides who gets accepted here.
	};
};


instance DIA_Wulfgar_AboutMiliz(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 3;
	condition = DIA_Wulfgar_AboutMiliz_Condition;
	information = DIA_Wulfgar_AboutMiliz_Info;
	permanent = FALSE;
	description = "What's it like with the militia?";
};


func int DIA_Wulfgar_AboutMiliz_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wulfgar_Hallo) && (other.guild != GIL_PAL))
	{
		return TRUE;
	};
};

func void DIA_Wulfgar_AboutMiliz_Info()
{
	AI_Output (other, self, "DIA_Wulfgar_AboutMiliz_15_00");	//What's it like with the militia?
	AI_Output (self, other, "DIA_Wulfgar_AboutMiliz_04_01");	//Lord Andre is our commander now.
	AI_Output (self, other, "DIA_Wulfgar_AboutMiliz_04_02");	//The militia used to report to the governor. (laughs) He had no idea what we do here.
	AI_Output (self, other, "DIA_Wulfgar_AboutMiliz_04_03");	//But Lord Andre knows what he's doing. He takes good care of the men.
	if(other.guild == GIL_NONE)
	{
		AI_Output(self,other,"DIA_Wulfgar_AboutMiliz_04_04");	//Everyone who starts here gets some decent armor and a good weapon.
	};
	if((other.guild == GIL_NONE) || (other.guild == GIL_MIL))
	{
		AI_Output(self,other,"DIA_Wulfgar_AboutMiliz_04_05");	//And there are bonuses if you've done a good job. He pays a bounty for every criminal captured.
	};
};


instance DIA_Wulfgar_CanYouTrain(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 4;
	condition = DIA_Wulfgar_CanYouTrain_Condition;
	information = DIA_Wulfgar_CanYouTrain_Info;
	permanent = FALSE;
	description = "Can you also train me in sword fighting?";
};


func int DIA_Wulfgar_CanYouTrain_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wulfgar_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Wulfgar_CanYouTrain_Info()
{
	AI_Output (other, self, "DIA_Wulfgar_CanYouTrain_15_00");	//Can you also train me in sword fighting?
	AI_Output (self, other, "DIA_Wulfgar_CanYouTrain_04_01");	//Lord Andre has ordered that we train everyone who is in a position to defend the city.
	if ((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Wulfgar_CanYouTrain_04_02");	//However, that isn't true for mercenaries. Beat it.
	}
	else
	{
		if(other.guild != GIL_MIL)
		{
			if((other.guild == GIL_PAL) || (other.guild == GIL_KDF))
			{
				AI_Output(self,other,"DIA_Wulfgar_CanYouTrain_04_03_add");	//But that's only true for combat training.
			}
			else
			{
				AI_Output(self,other,"DIA_Wulfgar_CanYouTrain_04_03");	//But that's only true for combat training. All other kinds of training are reserved for the militia.
			};
		};
		if((other.guild == GIL_MIL) || (other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			AI_Output(self,other,"DIA_Wulfgar_CanYouTrain_04_04");	//Can you at least halfway handle a weapon?
			AI_Output(other,self,"DIA_Wulfgar_CanYouTrain_15_05");	//I think so...
			AI_Output(self,other,"DIA_Wulfgar_CanYouTrain_04_06");	//(sighs) All right - you can start when you're ready.
		};
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Wulfgar, the city guardsman, can teach me one-handed and two-handed fighting.");
		Wulfgar_Teach1H = TRUE;
	};
};


instance DIA_Wulfgar_Advantage(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 5;
	condition = DIA_Wulfgar_Advantage_Condition;
	information = DIA_Wulfgar_Advantage_Info;
	permanent = FALSE;
	description = "What are the advantages of one or two-handed weapons?";
};


func int DIA_Wulfgar_Advantage_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wulfgar_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Wulfgar_Advantage_Info()
{
	AI_Output (other, self, "DIA_Wulfgar_Advantage_15_00");	//What are the advantages of one or two-handed weapons?
	AI_Output (self, other, "DIA_Wulfgar_Advantage_04_01");	//Quite simple. With a one-handed weapon, you're faster. That can be a considerable advantage in battle.
	AI_Output (self, other, "DIA_Wulfgar_Advantage_04_02");	//Two-handed weapons are more ponderous. You have to fight with foresight - but you do a lot more damage when you hit.
};


instance DIA_Wulfgar_HowToBegin(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 6;
	condition = DIA_Wulfgar_HowToBegin_Condition;
	information = DIA_Wulfgar_HowToBegin_Info;
	permanent = FALSE;
	description = "Where should I start? With one-handed or two-handed weapons?";
};


func int DIA_Wulfgar_HowToBegin_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wulfgar_Hallo) && (RealTalentValue(NPC_TALENT_1H) < 100) && (RealTalentValue(NPC_TALENT_2H) < 100))
	{
		return TRUE;
	};
};

func void DIA_Wulfgar_HowToBegin_Info()
{
	AI_Output (other, self, "DIA_Wulfgar_HowToBegin_15_00");	//Where should I start? With one-handed or two-handed weapons?
	AI_Output (self, other, "DIA_Wulfgar_HowToBegin_04_01");	//That's entirely up to you.
	AI_Output (self, other, "DIA_Wulfgar_HowToBegin_04_02");	//If you specialize in only one type of weapon, you automatically learn the other at the same time.
	AI_Output (self, other, "DIA_Wulfgar_HowToBegin_04_03");	//If, for instance, you are good at fighting with one-handed swords, but still a beginner with two-handed weapons ...
	AI_Output (self, other, "DIA_Wulfgar_HowToBegin_04_04");	//... your two-handed skills will go up as well whenever you train with a one-hander.
	AI_Output (self, other, "DIA_Wulfgar_HowToBegin_04_05");	//In that case, the training is more exhausting than if you train with both types of weapons.
	AI_Output (self, other, "DIA_Wulfgar_HowToBegin_04_06");	//Just start and you'll soon see what I'm talking about.
};


var int DIA_Wulfgar_Teacher_permanent;
var int DIA_Wulfgar_TeachState_1H;
var int DIA_Wulfgar_TeachState_2H;
var int Wulfgar_Merke_1h;
var int Wulfgar_Merke_2h;

func void B_Wulfgar_NoMoreTeach()
{
	AI_Output(self,other,"DIA_Hagen_Teach_04_00");	//You are now a worthy swordmaster. I can teach you no more.
};

func void B_Wulfgar_SkillComment()
{
	AI_Output(self,other,"DIA_Wulfgar_AlsMil_04_04");	//I'll make a good fighter of you yet!
};

func void B_BuildLearnDialog_Wulfgar()
{
	Info_ClearChoices(DIA_Wulfgar_Teach);
	Info_AddChoice(DIA_Wulfgar_Teach,Dialog_Back,DIA_Wulfgar_Teach_Back);
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Wulfgar)
	{
		Info_AddChoice(DIA_Wulfgar_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Wulfgar_Teach_2H_1);
		Info_AddChoice(DIA_Wulfgar_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Wulfgar_Teach_2H_5);
		DIA_Wulfgar_TeachState_2H = 1;
	}
	else
	{
		if((DIA_Wulfgar_TeachState_2H == 1) && (DIA_Wulfgar_TeachState_1H != 2))
		{
			PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_2H_Wulfgar)),-1,53,FONT_Screen,2);
			B_Henry_NoMore_2H();
		};
		DIA_Wulfgar_TeachState_2H = 2;
	};
	if(VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Wulfgar)
	{
		Info_AddChoice(DIA_Wulfgar_Teach,B_BuildLearnString(PRINT_Learn1h1,B_GetLearnCostTalent(other,NPC_TALENT_1H,1)),DIA_Wulfgar_Teach_1H_1);
		Info_AddChoice(DIA_Wulfgar_Teach,B_BuildLearnString(PRINT_Learn1h5,B_GetLearnCostTalent(other,NPC_TALENT_1H,5)),DIA_Wulfgar_Teach_1H_5);
		DIA_Wulfgar_TeachState_1H = 1;
	}
	else
	{
		if((DIA_Wulfgar_TeachState_1H == 1) && (DIA_Wulfgar_TeachState_2H != 2))
		{
			PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_1H_Wulfgar)),-1,53,FONT_Screen,2);
			B_Say(self,other,"$NOLEARNYOUREBETTER");
		};
		DIA_Wulfgar_TeachState_1H = 2;
	};
	if((RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Wulfgar) && (RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Wulfgar))
	{
		DIA_Wulfgar_Teacher_permanent = TRUE;
	};
	if((DIA_Wulfgar_TeachState_1H == 2) && (DIA_Wulfgar_TeachState_2H == 2))
	{
		PrintScreen(PRINT_NoLearnTotalMAXReached,-1,53,FONT_Screen,2);
		B_Wulfgar_NoMoreTeach();
		AI_StopProcessInfos(self);
	};
};

instance DIA_Wulfgar_Teach(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 7;
	condition = DIA_Wulfgar_Teach_Condition;
	information = DIA_Wulfgar_Teach_Info;
	permanent = TRUE;
	description = "Let's begin with the training.";
};


func int DIA_Wulfgar_Teach_Condition()
{
	if((Wulfgar_Teach1H == TRUE) && (DIA_Wulfgar_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Wulfgar_Teach_Info()
{
	AI_Output (other, self, "DIA_Wulfgar_Teach_15_00");	//Let's begin with the training.
	if ((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		AI_Output(self,other,"DIA_Wulfgar_Add_04_00");	//I don't train mercenaries!
		DIA_Wulfgar_Teacher_permanent = TRUE;
	}
	else
	{
		if(other.guild == GIL_KDF)
		{
			if((VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Wulfgar) || (VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Wulfgar))
			{
				AI_Output(self,other,"DIA_Wulfgar_Add_04_01");	//Of course, reverend.
			};
		};
		Wulfgar_Merke_1h = other.HitChance[NPC_TALENT_1H];
		Wulfgar_Merke_2h = other.HitChance[NPC_TALENT_2H];
		B_BuildLearnDialog_Wulfgar();
	};
};

func void DIA_Wulfgar_Teach_Back()
{
	if((Wulfgar_Merke_1h < other.HitChance[NPC_TALENT_1H]) || (Wulfgar_Merke_2h < other.HitChance[NPC_TALENT_2H]))
	{
		B_Wulfgar_SkillComment();
	};
	Info_ClearChoices(DIA_Wulfgar_Teach);
};

func void DIA_Wulfgar_Teach_1H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,1,TeachLimit_1H_Wulfgar))
	{
		B_BuildLearnDialog_Wulfgar();
	};
};

func void DIA_Wulfgar_Teach_1H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,5,TeachLimit_1H_Wulfgar))
	{
		B_BuildLearnDialog_Wulfgar();
	};
};

func void DIA_Wulfgar_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Wulfgar))
	{
		B_BuildLearnDialog_Wulfgar();
	};
};

func void DIA_Wulfgar_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Wulfgar))
	{
		B_BuildLearnDialog_Wulfgar();
	};
};

func void B_Ruga_Teach_Log()
{
	if(Ruga_Teach_Log == FALSE)
	{
		if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL) || (hero.guild == GIL_KDF))
		{
			Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
			B_LogEntry(TOPIC_CityTeacher,"Ruga, the city guardsman, can help me improve my dexterity and teach me to use a crossbow.");
		}
		else if((hero.guild == GIL_NONE) || (hero.guild == GIL_NOV))
		{
			Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
			B_LogEntry(TOPIC_CityTeacher,"Ruga, the city guardsman, can help me improve my dexterity and teach me to use a crossbow. But for that I have to serve the King or become a magician.");
		};
		Ruga_Teach_Log = TRUE;
	};
};

func int C_WulfgarCanGiveBonus()
{
	if(Wld_IsTime(5,0,6,54) && (Npc_GetDistToWP(self,"NW_CITY_HABOUR_KASERN_CENTRE_01") < 600))
	{
		return TRUE;
	};
	return FALSE;
};

instance DIA_Wulfgar_AlsMil(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 1;
	condition = DIA_Wulfgar_AlsMil_Condition;
	information = DIA_Wulfgar_AlsMil_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Wulfgar_AlsMil_Condition()
{
	if(other.guild == GIL_MIL)
	{
		if(Npc_KnowsInfo(other,DIA_Wulfgar_Bonus) || !C_WulfgarCanGiveBonus())
		{
			return TRUE;
		};
	};
};

func void DIA_Wulfgar_AlsMil_Info()
{
	AI_Output (self, other, "DIA_Wulfgar_AlsMil_04_00");	//So Lord Andre accepted you!
	AI_Output (self, other, "DIA_Wulfgar_AlsMil_04_01");	//I expect you to come here and train regularly.
	AI_Output (self, other, "DIA_Wulfgar_AlsMil_04_02");	//Ruga will train you in the art of the crossbow and Mortis will help you to increase your strength.
	AI_Output (self, other, "DIA_Wulfgar_AlsMil_04_03");	//But the most important thing is for you to learn to handle your sword properly.
	B_Wulfgar_SkillComment();
	if(Mortis_TeachSTR == FALSE)
	{
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Mortis, the city guardsman, can help me train my strength.");	
	};
	B_Ruga_Teach_Log();
};


instance DIA_Wulfgar_Bonus(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 2;
	condition = DIA_Wulfgar_Bonus_Condition;
	information = DIA_Wulfgar_Bonus_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Wulfgar_Bonus_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && C_WulfgarCanGiveBonus())
	{
		return TRUE;
	};
};

func void DIA_Wulfgar_Bonus_Info()
{
	AI_Output (self, other, "DIA_Wulfgar_Bonus_04_00");	//Out and about so early? I'm usually alone at this time of day. But since you're already here, you might as well learn something.
	AI_Output (self, other, "DIA_Wulfgar_Bonus_04_01");	//So pay attention. You can deceive some opponents if you dodge their blows and attack at the right moment.
	AI_Output (self, other, "DIA_Wulfgar_Bonus_04_02");	//Remember that in your next fight!
	B_RaiseTalentByPermBonus(other,NPC_TALENT_1H,2);
};


instance DIA_Wulfgar_PICKPOCKET(C_Info)
{
	npc = MIL_312_Wulfgar;
	nr = 900;
	condition = DIA_Wulfgar_PICKPOCKET_Condition;
	information = DIA_Wulfgar_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Wulfgar_PICKPOCKET_Condition()
{
	return C_Beklauen(58,80);
};

func void DIA_Wulfgar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Wulfgar_PICKPOCKET);
	Info_AddChoice(DIA_Wulfgar_PICKPOCKET,Dialog_Back,DIA_Wulfgar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Wulfgar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Wulfgar_PICKPOCKET_DoIt);
};

func void DIA_Wulfgar_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Wulfgar_PICKPOCKET);
};

func void DIA_Wulfgar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Wulfgar_PICKPOCKET);
};

