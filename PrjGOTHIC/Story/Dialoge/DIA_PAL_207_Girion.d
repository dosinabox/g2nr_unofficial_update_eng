
instance DIA_Girion_EXIT(C_Info)
{
	npc = PAL_207_Girion;
	nr = 999;
	condition = DIA_Girion_EXIT_Condition;
	information = DIA_Girion_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Girion_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Girion_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Girion_Hallo(C_Info)
{
	npc = PAL_207_Girion;
	nr = 2;
	condition = DIA_Girion_Hallo_Condition;
	information = DIA_Girion_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Girion_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (MIS_ShipIsFree == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Girion_Hallo_Info()
{
	AI_Output (self, other, "DIA_Girion_Hallo_08_00");	//I am Girion, master of two-handed combat and paladin of the king. Why are you disturbing me?
};


var int DIA_Girion_Teach_permanent;

instance DIA_Girion_CanTeach(C_Info)
{
	npc = PAL_207_Girion;
	nr = 5;
	condition = DIA_Girion_CanTeach_Condition;
	information = DIA_Girion_CanTeach_Info;
	permanent = TRUE;
	description = "Could you train me?";
};


func int DIA_Girion_CanTeach_Condition()
{
	if(Girion_Teach2H == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Girion_CanTeach_Info()
{
	AI_Output (other, self, "DIA_Girion_CanTeach_15_00");	//Can you train me?
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Girion_CanTeach_08_01");	//You do well to train in the noblest of all combat styles. As is proper for a warrior of Innos.
		AI_Output (self, other, "DIA_Girion_CanTeach_08_02");	//I shall instruct you. Report to me when you are ready.
		Girion_Teach2H = TRUE;
		Log_CreateTopic(TOPIC_CityTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_CityTeacher,"Paladin Girion can teach me to fight with two-handed weapons.");
	}
	else
	{
		AI_Output(self,other,"DIA_Girion_CanTeach_08_03");	//If you wish to learn something, you must turn to a teacher from outside of our order.
		AI_Output(self,other,"DIA_Girion_CanTeach_08_04");	//I am a warrior, not a teacher.
		if((other.guild != GIL_NONE) && (other.guild != GIL_MIL))
		{
			Girion_Teach2H = TRUE;
			DIA_Girion_Teach_permanent = TRUE;
		};
	};
};


func void B_BuildLearnDialog_Girion()
{
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Girion)
	{
		Info_ClearChoices(DIA_Girion_Teach);
		Info_AddChoice(DIA_Girion_Teach,Dialog_Back,DIA_Girion_Teach_Back);
		Info_AddChoice(DIA_Girion_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Girion_Teach_2H_1);
		Info_AddChoice(DIA_Girion_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Girion_Teach_2H_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Girion)
		{
			DIA_Girion_Teach_permanent = TRUE;
		};
		if(VisibleTalentValue(NPC_TALENT_2H) < 100)
		{
			PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_2H_Girion)),-1,53,FONT_Screen,2);
				AI_Output (self, other, "DIA_DIA_Girion_Teach_08_00");	//Naturally, your education is not finished, but there is nothing more that I can teach you.
				AI_Output (self, other, "DIA_DIA_Girion_Teach_08_01");	//If you wish to improve your talent with the weapon further, you will have to seek out a true swordmaster.
				AI_Output (other, self, "DIA_DIA_Girion_Teach_15_02");	//Where can I find such a man?
				AI_Output (self, other, "DIA_DIA_Girion_Teach_08_03");	//Lord Hagen is a swordmaster. He will certainly instruct you.
		}
		else
		{
			PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
			B_Say(self,other,"$NOLEARNYOUREBETTER");
		};
		AI_StopProcessInfos(self);
	};
};

func void B_GirionTeachComment()
{
	if(Girion_Labercount == 0)
	{
		AI_Output(self,other,"DIA_DIA_Girion_Teach_2H_1_08_00");	//Fight with honor. Combat is our life - and what is your life without honor?
		Girion_Labercount = 1;
	}
	else if(Girion_Labercount == 1)
	{
		AI_Output(self,other,"DIA_DIA_Girion_Teach_2H_1_08_01");	//Be cautious and quick in combat. Surprise your opponent.
		Girion_Labercount = 2;
	}
	else if(Girion_Labercount == 2)
	{
		AI_Output(self,other,"DIA_DIA_Girion_Teach_2H_1_08_02");	//Never go into combat unprepared. You can never know if it is your last.
		Girion_Labercount = 3;
	}
	else if(Girion_Labercount == 3)
	{
		AI_Output(self,other,"DIA_DIA_Girion_Teach_2H_1_08_03");	//A paladin is always prepared for combat. But he never begins a fight he cannot win.
		Girion_Labercount = 4;
	}
	else if(Girion_Labercount == 4)
	{
		AI_Output(self,other,"DIA_DIA_Girion_Teach_2H_5_08_00");	//A paladin fights not only with the sword, but also with his mind.
	}
	else if(Girion_Labercount == 5)
	{
		AI_Output(self,other,"DIA_DIA_Girion_Teach_2H_5_08_02");	//Remember, you fight well if you control your opponent and don't give him a chance to be in control himself.
		Girion_Labercount = 6;
	}
	else if(Girion_Labercount == 6)
	{
		AI_Output(self,other,"DIA_DIA_Girion_Teach_2H_5_08_03");	//You have only lost when you have given up.
		Girion_Labercount = 0;
	};
};

instance DIA_Girion_Teach(C_Info)
{
	npc = PAL_207_Girion;
	nr = 100;
	condition = DIA_Girion_Teach_Condition;
	information = DIA_Girion_Teach_Info;
	permanent = TRUE;
	description = "I'm ready for training.";
};


func int DIA_Girion_Teach_Condition()
{
	if((Girion_Teach2H == TRUE) && (DIA_Girion_Teach_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Girion_Teach_Info()
{
	AI_Output(other,self,"DIA_Girion_Teach_15_00");	//I am ready to be trained.
	B_BuildLearnDialog_Girion();
};

func void DIA_Girion_Teach_Back()
{
	Info_ClearChoices(DIA_Girion_Teach);
};

func void DIA_Girion_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Girion))
	{
		B_GirionTeachComment();
		B_BuildLearnDialog_Girion();
	};
};

func void DIA_Girion_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Girion))
	{
		B_GirionTeachComment();
		B_BuildLearnDialog_Girion();
	};
};

instance DIA_Girion_CATCHPLAYERSTOLENSHIP(C_Info)
{
	npc = PAL_207_Girion;
	nr = 5;
	condition = DIA_Girion_CATCHPLAYERSTOLENSHIP_Condition;
	information = DIA_Girion_CATCHPLAYERSTOLENSHIP_Info;
	important = TRUE;
};


func int DIA_Girion_CATCHPLAYERSTOLENSHIP_Condition()
{
	if((Kapitel >= 5) && (MIS_ShipIsFree == TRUE) && (Npc_GetDistToWP(self,"NW_CITY_WAY_TO_SHIP_25") < 1000))
	{
		return TRUE;
	};
};

func void DIA_Girion_CATCHPLAYERSTOLENSHIP_Info()
{
	AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_08_00");	//Hey! Can you tell me what you are doing here?
	Info_ClearChoices (DIA_Girion_CATCHPLAYERSTOLENSHIP);
	Info_AddChoice (DIA_Girion_CATCHPLAYERSTOLENSHIP, "I don't know what you're talking about.", DIA_Girion_CATCHPLAYERSTOLENSHIP_no);
	Info_AddChoice (DIA_Girion_CATCHPLAYERSTOLENSHIP, "Get out of my way, or I'll have to kill you.", DIA_Girion_CATCHPLAYERSTOLENSHIP_weg);
	Info_AddChoice (DIA_Girion_CATCHPLAYERSTOLENSHIP, "I need the ship.", DIA_Girion_CATCHPLAYERSTOLENSHIP_ship);
};

func void DIA_Girion_CATCHPLAYERSTOLENSHIP_no()
{
	AI_Output (other, self, "DIA_Girion_CATCHPLAYERSTOLENSHIP_no_15_00");	//I don't know what you're talking about.
	AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_no_08_01");	//I am talking about what you have worked out with the ship's guards up there. That stinks to high heaven.
	if((hero.guild == GIL_KDF) && !Npc_IsDead(Schiffswache_212) && !Npc_IsDead(Schiffswache_213))
	{
		AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_no_08_02");	//Even if you are a magician, I still don't trust you.
	};
};


var int Girion_WantstoKillSC;

func void DIA_Girion_CATCHPLAYERSTOLENSHIP_weg()
{
	AI_Output(other,self,"DIA_Girion_CATCHPLAYERSTOLENSHIP_weg_15_00");	//Get out of my way, or I'll have to kill you.
	if(!Npc_IsDead(Schiffswache_212) && !Npc_IsDead(Schiffswache_213))
	{
		AI_Output(self,other,"DIA_Girion_CATCHPLAYERSTOLENSHIP_weg_08_01");	//You may be able to deceive the ship's guard, but you will find me a tough nut to crack, my little friend.
		if(hero.guild == GIL_PAL)
		{
			AI_Output(self,other,"DIA_Girion_CATCHPLAYERSTOLENSHIP_weg_08_02");	//Even if you are one of us, that does not give you the right to steal the king's property. Die, you damned traitor.
		};
	}
	else
	{
		AI_Output(self,other,"DIA_Girion_Verrat_08_00");	//Traitor!
	};
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
	Girion_WantstoKillSC = TRUE;
};

func void B_GirionStayOnShip()
{
	AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_08_09");	//When we have finished this business, you will turn the ship back over to me, understood?
};

func void DIA_Girion_CATCHPLAYERSTOLENSHIP_ship()
{
	AI_Output (other, self, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_15_00");	//I need the ship. So I will take it.
	if ((hero.guild == GIL_PAL) || (hero.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_08_01");	//You cannot do that. The ore transport ...
	}
	else
	{
		AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_08_02");	//How dare you, you stinking son of a ...
	};
	AI_Output (other, self, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_15_03");	//The ore in the Valley of Mines is not enough to satisfy the king. I was there. There's nothing more to be had there. Hagen's mission is a farce.
	AI_Output (other, self, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_15_04");	//The real threat has its roots on an offshore island not far from here. I shall sail there and put an end to it.
	AI_Output (other, self, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_15_05");	//Either you join me, or I'll have to do away with you. It's your choice.
	AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_08_06");	//Mmh. It sounds as though I have no choice.
	AI_Output (other, self, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_15_07");	//Correct.
	AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_08_08");	//Well, all right. I shall join you, but only under one condition.
	B_GirionStayOnShip ();
	AI_Output (other, self, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_15_10");	//I can live with that.
	AI_Output (self, other, "DIA_Girion_CATCHPLAYERSTOLENSHIP_ship_08_11");	//Then do what you must do. I shall wait here for you.
	B_JoinShip(self);
};


instance DIA_Girion_Verrat(C_Info)
{
	npc = PAL_207_Girion;
	nr = 2;
	condition = DIA_Girion_Verrat_Condition;
	information = DIA_Girion_Verrat_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Girion_Verrat_Condition()
{
	if(Girion_WantstoKillSC == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Girion_Verrat_Info()
{
	AI_Output(self,other,"DIA_Girion_Verrat_08_00");	//Traitor!
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
};


instance DIA_Girion_OnShip(C_Info)
{
	npc = PAL_207_Girion;
	nr = 2;
	condition = DIA_Girion_OnShip_Condition;
	information = DIA_Girion_OnShip_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Girion_OnShip_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Girion_IsOnBoard == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Girion_OnShip_Info()
{
	B_GirionStayOnShip();
	AI_StopProcessInfos(self);
};


instance DIA_Girion_PICKPOCKET(C_Info)
{
	npc = PAL_207_Girion;
	nr = 900;
	condition = DIA_Girion_PICKPOCKET_Condition;
	information = DIA_Girion_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Girion_PICKPOCKET_Condition()
{
	return C_Beklauen(73,280);
};

func void DIA_Girion_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Girion_PICKPOCKET);
	Info_AddChoice(DIA_Girion_PICKPOCKET,Dialog_Back,DIA_Girion_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Girion_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Girion_PICKPOCKET_DoIt);
};

func void DIA_Girion_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Girion_PICKPOCKET);
};

func void DIA_Girion_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Girion_PICKPOCKET);
};

