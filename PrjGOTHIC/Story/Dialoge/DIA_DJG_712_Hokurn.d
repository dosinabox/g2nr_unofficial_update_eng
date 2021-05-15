
var int Hokurn_BoozeGiven;
var int Hokurn_WineGiven;
var int Hokurn_DarkWineGiven;

func int C_GotDrinkForHokurn()
{
	if(Npc_HasItems(other,ItFo_Beer))
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItFo_Booze))
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItFo_Wine))
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItFo_Addon_Rum))
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItFo_Addon_Grog))
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItFo_Addon_Liquor))
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItFo_Addon_LousHammer))
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItFo_Addon_SchlafHammer))
	{
		return TRUE;
	};
	if(Npc_HasItems(other,ItFo_DarkWine))
	{
		return TRUE;
	};
	return FALSE;
};

func void B_GiveDrinkToHokurn()
{
	AI_WaitTillEnd(self,other);
	if(Npc_HasItems(other,ItFo_Beer))
	{
		B_GiveInvItems(other,self,ItFo_Beer,1);
		B_UseItem(self,ItFo_Beer);
	}
	else if(Npc_HasItems(other,ItFo_Booze))
	{
		B_GiveInvItems(other,self,ItFo_Booze,1);
		B_UseItem(self,ItFo_Booze);
		Hokurn_BoozeGiven = TRUE;
	}
	else if(Npc_HasItems(other,ItFo_Wine))
	{
		B_GiveInvItems(other,self,ItFo_Wine,1);
		B_UseItem(self,ItFo_Wine);
		Hokurn_WineGiven = TRUE;
	}
	else if(Npc_HasItems(other,ItFo_Addon_Rum))
	{
		B_GiveInvItems(other,self,ItFo_Addon_Rum,1);
		B_UseItem(self,ItFo_Addon_Rum);
	}
	else if(Npc_HasItems(other,ItFo_Addon_Grog))
	{
		B_GiveInvItems(other,self,ItFo_Addon_Grog,1);
		B_UseItem(self,ItFo_Addon_Grog);
	}
	else if(Npc_HasItems(other,ItFo_Addon_Liquor))
	{
		B_GiveInvItems(other,self,ItFo_Addon_Liquor,1);
		B_UseItem(self,ItFo_Addon_Liquor);
	}
	else if(Npc_HasItems(other,ItFo_Addon_LousHammer))
	{
		B_GiveInvItems(other,self,ItFo_Addon_LousHammer,1);
		B_UseItem(self,ItFo_Addon_LousHammer);
	}
	else if(Npc_HasItems(other,ItFo_Addon_SchlafHammer))
	{
		B_GiveInvItems(other,self,ItFo_Addon_SchlafHammer,1);
		B_UseItem(self,ItFo_Addon_SchlafHammer);
	}
	else if(Npc_HasItems(other,ItFo_DarkWine))
	{
		B_GiveInvItems(other,self,ItFo_DarkWine,1);
		B_UseItem(self,ItFo_DarkWine);
		Hokurn_WineGiven = TRUE;
		if(Hokurn_DarkWineGiven == FALSE)
		{
			B_GivePlayerXP(200);
			Hokurn_DarkWineGiven = TRUE;
		};
	};
};

instance DIA_Hokurn_EXIT(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 999;
	condition = DIA_Hokurn_EXIT_Condition;
	information = DIA_Hokurn_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Hokurn_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Hokurn_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Hokurn_Hello(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 4;
	condition = DIA_Hokurn_Hello_Condition;
	information = DIA_Hokurn_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Hokurn_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Hokurn_Hello_Info()
{
	AI_Output (self, other, "DIA_Hokurn_Hello_01_00");	//Do you have anything to drink?
	AI_Output (other, self, "DIA_Hokurn_Hello_15_01");	//I assume that it's not water you want.
	AI_Output (self, other, "DIA_Hokurn_Hello_01_02");	//No, damnit!! I need something alcoholic so I can finally get rid of these damned headaches.
	AI_Output (self, other, "DIA_Hokurn_Hello_01_03");	//When I haven't had anything to drink for a while, my skull feels like it's going to explode at any moment.
	Info_ClearChoices (DIA_Hokurn_Hello);
	Info_AddChoice (DIA_Hokurn_Hello, "There's nothing I can give you.", DIA_Hokurn_Hello_No);
	if(C_GotDrinkForHokurn())
	{
		Info_AddChoice (DIA_Hokurn_Hello, "Here, take this.", DIA_Hokurn_Hello_Yes);
	};
};

func void DIA_Hokurn_Hello_No()
{
	AI_Output (other, self, "DIA_Hokurn_Hello_No_15_00");	//There's nothing I can give you.
	AI_Output (self, other, "DIA_Hokurn_Hello_No_01_01");	//Then scram!
	Info_ClearChoices (DIA_Hokurn_Hello);
	Info_AddChoice (DIA_Hokurn_Hello, Dialog_Ende, DIA_Hokurn_Hello_END);
	Info_AddChoice (DIA_Hokurn_Hello, "One more thing...", DIA_Hokurn_Hello_ASK1);
};

func void DIA_Hokurn_Hello_ASK1()
{
	AI_Output (other, self, "DIA_Hokurn_Hello_ASK1_15_00");	//One more thing...
	AI_Output (self, other, "DIA_Hokurn_Hello_ASK1_01_01");	//(bellows) Didn't you understand me? PISS OFF!!!
	Info_ClearChoices (DIA_Hokurn_Hello);
	Info_AddChoice (DIA_Hokurn_Hello, Dialog_Ende, DIA_Hokurn_Hello_END);
	Info_AddChoice (DIA_Hokurn_Hello, "It's important.", DIA_Hokurn_Hello_ASK2);
};

func void DIA_Hokurn_Hello_ASK2()
{
	AI_Output (other, self, "DIA_Hokurn_Hello_ASK2_15_00");	//It's important.
	AI_Output (self, other, "DIA_Hokurn_Hello_ASK2_01_01");	//(bellows) You asked for it.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Hokurn_Hello_END()
{
	AI_StopProcessInfos(self);
};

func void B_Hokurn_Sauf()
{
	HokurnLastDrink = Wld_GetDay();
	HokurnGetsDrink = TRUE;
	AI_Output(self,other,"B_Hokurn_Sauf_01_00");	//(burps) Ha, that hit the spot.
	if(Hokurn_WineGiven == TRUE)
	{
		AI_Output(self,other,"DIA_Hokurn_WhereDragon_Booze_01_01");	//I'd fight every dragon in the world for a fine vintage.
	};
	AI_Output(self,other,"B_Hokurn_Sauf_01_01");	//So, now I can think clearly again. What can I do for you?
};

func void DIA_Hokurn_Hello_Yes()
{
	AI_Output(other,self,"DIA_Hokurn_Hello_Yes_15_00");	//Here, take this.
	B_GiveDrinkToHokurn();
	B_Hokurn_Sauf();
	Info_ClearChoices(DIA_Hokurn_Hello);
};


instance DIA_Hokurn_Drink(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 5;
	condition = DIA_Hokurn_Drink_Condition;
	information = DIA_Hokurn_Drink_Info;
	permanent = TRUE;
	description = "I brought you something to drink.";
};


func int DIA_Hokurn_Drink_Condition()
{
	if((HokurnGetsDrink == FALSE) && C_GotDrinkForHokurn())
	{
		return TRUE;
	};
};

func void DIA_Hokurn_Drink_Info()
{
	AI_Output (other, self, "DIA_Hokurn_Drink_15_00");	//I brought you something to drink.
	AI_Output (self, other, "DIA_Hokurn_Drink_01_01");	//(greedy) Gimme!!
	B_GiveDrinkToHokurn();
	B_Hokurn_Sauf();
};


instance DIA_Hokurn_Question(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 5;
	condition = DIA_Hokurn_Question_Condition;
	information = DIA_Hokurn_Question_Info;
	permanent = TRUE;
	description = "I need some information.";
};


func int DIA_Hokurn_Question_Condition()
{
	if(HokurnGetsDrink == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Hokurn_Question_Info()
{
	AI_Output (other, self, "DIA_Hokurn_Question_15_00");	//I need some information.
	AI_Output (self, other, "DIA_Hokurn_Question_01_01");	//(annoyed) I thought you understood me. I only talk to friends.
	AI_Output (self, other, "DIA_Hokurn_Question_01_02");	//And friends offer you something to drink. Got it? Now scram!
};


var int DIA_Hokurn_Teacher_permanent;

instance DIA_Hokurn_Learn(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 6;
	condition = DIA_Hokurn_Learn_Condition;
	information = DIA_Hokurn_Learn_Info;
	permanent = FALSE;
	description = "I'm looking for someone who can teach me something.";
};


func int DIA_Hokurn_Learn_Condition()
{
	if(HokurnGetsDrink == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Hokurn_Learn_Info()
{
	AI_Output(other,self,"DIA_Hokurn_Learn_15_00");	//I'm looking for someone who can teach me something.
	if(other.guild == GIL_KDF)
	{
		AI_Output(self,other,"DIA_Hokurn_Teach_01_03");	//What do you know. Even magicians use close combat weapons.
	};
	if((RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Hokurn) && (RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Hokurn))
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		Hokurn_TeachPlayer = TRUE;
		DIA_Hokurn_Teacher_permanent = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Hokurn_Learn_01_01");	//I could teach you a few things. I'm the best fighter for miles around.
		AI_Output(self,other,"DIA_Hokurn_Learn_01_02");	//Since we're friends, I'll give you a special price. 300 gold pieces.
		Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
		B_LogEntry(TOPIC_OutTeacher,"Hokurn the dragon hunter can train me as a fighter.");
		Info_ClearChoices(DIA_Hokurn_Learn);
		Info_AddChoice(DIA_Hokurn_Learn,"That's too expensive for me.",DIA_Hokurn_Learn_TooExpensive);
		if(Npc_HasItems(other,ItMi_Gold) >= 300)
		{
			Info_AddChoice(DIA_Hokurn_Learn,"All right, here's the money.",DIA_Hokurn_Learn_OK);
		};
	};
};

func void DIA_Hokurn_Learn_TooExpensive()
{
	AI_Output (other, self, "DIA_Hokurn_Learn_TooExpensive_15_00");	//That's too expensive for me.
	AI_Output (self, other, "DIA_Hokurn_Learn_TooExpensive_01_01");	//Too expensive? That's less than anyone else in my place would charge.
	AI_Output (self, other, "DIA_Hokurn_Learn_TooExpensive_01_02");	//Think about it.
	Info_ClearChoices (DIA_Hokurn_Learn);
};

func void B_Hokurn_TeachPlayer()
{
	B_GiveInvItems(other,self,ItMi_Gold,300);
	AI_Output(self,other,"DIA_Hokurn_PayTeacher_01_01");	//You won't be sorry!
	Hokurn_TeachPlayer = TRUE;
};

func void DIA_Hokurn_Learn_OK()
{
	AI_Output(other,self,"DIA_Hokurn_Learn_OK_15_00");	//Deal. Here's the money!
	B_Hokurn_TeachPlayer();
	Info_ClearChoices(DIA_Hokurn_Learn);
};


instance DIA_Hokurn_PayTeacher(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 6;
	condition = DIA_Hokurn_PayTeacher_Condition;
	information = DIA_Hokurn_PayTeacher_Info;
	permanent = TRUE;
	description = "Here's your money. I want to be trained.";
};


func int DIA_Hokurn_PayTeacher_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Hokurn_Learn) && (Npc_HasItems(other,ItMi_Gold) >= 300) && (Hokurn_TeachPlayer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Hokurn_PayTeacher_Info()
{
	AI_Output(other,self,"DIA_Hokurn_PayTeacher_15_00");	//Here's your money. I want to be trained.
	if((RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Hokurn) && (RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Hokurn))
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		Hokurn_TeachPlayer = TRUE;
		DIA_Hokurn_Teacher_permanent = TRUE;
	}
	else
	{
		B_Hokurn_TeachPlayer();
	};
};


instance DIA_Hokurn_DrinkAndLearn(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 7;
	condition = DIA_Hokurn_DrinkAndLearn_Condition;
	information = DIA_Hokurn_DrinkAndLearn_Info;
	permanent = TRUE;
	description = "Here's something to drink for you.";
};


func int DIA_Hokurn_DrinkAndLearn_Condition()
{
	if((HokurnGetsDrink == TRUE) && C_GotDrinkForHokurn())
	{
		return TRUE;
	};
};

func void DIA_Hokurn_DrinkAndLearn_Info()
{
	AI_Output(other,self,"DIA_Hokurn_DrinkAndLearn_15_00");	//Here's something to drink for you.
	B_GiveDrinkToHokurn();
	HokurnLastDrink = Wld_GetDay();
	AI_Output(self,other,"DIA_Hokurn_DrinkAndLearn_01_01");	//I'm feeling a lot better. I'm ready for anything.
};


var int DIA_Hokurn_TeachState_1H;
var int DIA_Hokurn_TeachState_2H;

func void B_Hokurn_TeachedEnough()
{
	AI_Output(self,other,"B_Hokurn_TeachedEnough_01_00");	//You don't need a teacher for this discipline any more.
};

func void B_BuildLearnDialog_Hokurn()
{
	Info_ClearChoices(DIA_Hokurn_Teach);
	Info_AddChoice(DIA_Hokurn_Teach,Dialog_Back,DIA_Hokurn_Teach_Back);
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Hokurn)
	{
		Info_AddChoice(DIA_Hokurn_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Hokurn_Teach_2H_1);
		Info_AddChoice(DIA_Hokurn_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Hokurn_Teach_2H_5);
		DIA_Hokurn_TeachState_2H = 1;
	}
	else
	{
		if(DIA_Hokurn_TeachState_2H != 2)
		{
			if(DIA_Hokurn_TeachState_1H != 2)
			{
				if(DIA_Hokurn_TeachState_2H != 0)
				{
					PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
					B_Hokurn_TeachedEnough();
				};
			};
		};
		DIA_Hokurn_TeachState_2H = 2;
	};
	if(VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Hokurn)
	{
		Info_AddChoice(DIA_Hokurn_Teach,B_BuildLearnString(PRINT_Learn1h1,B_GetLearnCostTalent(other,NPC_TALENT_1H,1)),DIA_Hokurn_Teach_1H_1);
		Info_AddChoice(DIA_Hokurn_Teach,B_BuildLearnString(PRINT_Learn1h5,B_GetLearnCostTalent(other,NPC_TALENT_1H,5)),DIA_Hokurn_Teach_1H_5);
		DIA_Hokurn_TeachState_1H = 1;
	}
	else
	{
		if(DIA_Hokurn_TeachState_1H != 2)
		{
			if(DIA_Hokurn_TeachState_2H != 2)
			{
				if(DIA_Hokurn_TeachState_1H != 0)
				{
					PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
					B_Hokurn_TeachedEnough();
				};
			};
		};
		DIA_Hokurn_TeachState_1H = 2;
	};
	if((RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Hokurn) && (RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Hokurn))
	{
		DIA_Hokurn_Teacher_permanent = TRUE;
	};
	if((DIA_Hokurn_TeachState_1H == 2) && (DIA_Hokurn_TeachState_2H == 2))
	{
		PrintScreen(PRINT_NoLearnOverMAX,-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

instance DIA_Hokurn_Teach(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 7;
	condition = DIA_Hokurn_Teach_Condition;
	information = DIA_Hokurn_Teach_Info;
	permanent = TRUE;
	description = "Let's start with the training.";
};


func int DIA_Hokurn_Teach_Condition()
{
	if((Hokurn_TeachPlayer == TRUE) && (DIA_Hokurn_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Hokurn_Teach_Info()
{
	AI_Output(other,self,"DIA_Hokurn_Teach_15_00");	//Let's start with the training.
	if(HokurnLastDrink < Wld_GetDay())
	{
		AI_Output(self,other,"DIA_Hokurn_Teach_01_01");	//First bring me something to drink!
		if(hero.guild == GIL_PAL)
		{
			AI_Output(self,other,"DIA_Hokurn_Teach_01_02");	//Then we'll see what we can get out of your rusty paladin bones, hey?
		};
	}
	else
	{
		B_BuildLearnDialog_Hokurn();
	};
};

func void DIA_Hokurn_Teach_Back()
{
	Info_ClearChoices(DIA_Hokurn_Teach);
};

func void DIA_Hokurn_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Hokurn))
	{
		B_BuildLearnDialog_Hokurn();
	};
};

func void DIA_Hokurn_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Hokurn))
	{
		B_BuildLearnDialog_Hokurn();
	};
};

func void DIA_Hokurn_Teach_1H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,1,TeachLimit_1H_Hokurn))
	{
		B_BuildLearnDialog_Hokurn();
	};
};

func void DIA_Hokurn_Teach_1H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,5,TeachLimit_1H_Hokurn))
	{
		B_BuildLearnDialog_Hokurn();
	};
};


instance DIA_Hokurn_StayHere(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 5;
	condition = DIA_Hokurn_StayHere_Condition;
	information = DIA_Hokurn_StayHere_Info;
	permanent = FALSE;
	description = "What are you doing here anyway?";
};


func int DIA_Hokurn_StayHere_Condition()
{
	if(HokurnGetsDrink == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Hokurn_StayHere_Info()
{
	AI_Output (other, self, "DIA_Hokurn_StayHere_15_00");	//What are you doing here anyway?
	AI_Output (self, other, "DIA_Hokurn_StayHere_01_01");	//I don't have any idea what we're doing here or when it'll start.
	AI_Output (self, other, "DIA_Hokurn_StayHere_01_02");	//And I don't care as long as I have enough to drink.
};


instance DIA_Hokurn_WhereDragon(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 5;
	condition = DIA_Hokurn_WhereDragon_Condition;
	information = DIA_Hokurn_WhereDragon_Info;
	permanent = TRUE;
	description = "Do you know where the dragons are then?";
};


func int DIA_Hokurn_WhereDragon_Condition()
{
	if((HokurnGetsDrink == TRUE) && (HokurnTellsDragon == FALSE) && Npc_KnowsInfo(other,DIA_Hokurn_StayHere))
	{
		return TRUE;
	};
};

func void DIA_Hokurn_WhereDragon_Info()
{
	AI_Output (other, self, "DIA_Hokurn_WhereDragon_15_00");	//Do you know where the dragons are then?
	AI_Output (self, other, "DIA_Hokurn_WhereDragon_01_01");	//What's in it for me, if I tell you?
	Info_ClearChoices(DIA_Hokurn_WhereDragon);
	Info_AddChoice(DIA_Hokurn_WhereDragon,"Nothing, I'm looking for them myself.",DIA_Hokurn_WhereDragon_FindMyself);
	Info_AddChoice(DIA_Hokurn_WhereDragon,"I'd be willing to pay you for that information.",DIA_Hokurn_WhereDragon_Gold);
	if((Hokurn_WineGiven == TRUE) && (Npc_HasItems(other,ItFo_Wine) || Npc_HasItems(other,ItFo_DarkWine)))
	{
		Info_AddChoice(DIA_Hokurn_WhereDragon,"Here's your wine.",DIA_Hokurn_WhereDragon_GiveDrink);
	}
	else if(Npc_HasItems(other,ItFo_Booze))
	{
		if(Hokurn_BoozeGiven == TRUE)
		{
			Info_AddChoice(DIA_Hokurn_WhereDragon,"У меня есть еще одна бутылочка джина!",DIA_Hokurn_WhereDragon_GiveDrink);
		}
		else
		{
			Info_AddChoice(DIA_Hokurn_WhereDragon,"У меня есть бутылочка джина!",DIA_Hokurn_WhereDragon_GiveDrink);
		};
	};
};

func void DIA_Hokurn_WhereDragon_FindMyself()
{
	AI_Output (other, self, "DIA_Hokurn_WhereDragon_FindMyself_15_00");	//Nothing, I'm looking for them myself.
	AI_Output (self, other, "DIA_Hokurn_WhereDragon_FindMyself_01_01");	//You'd better watch out. You've got a hell of a fight in front of you.
	Info_ClearChoices (DIA_Hokurn_WhereDragon);
};

func void DIA_Hokurn_WhereDragon_Gold()
{
	AI_Output (other, self, "DIA_Hokurn_WhereDragon_Gold_15_00");	//I'd be willing to pay you for that information.
	AI_Output (self, other, "DIA_Hokurn_WhereDragon_Gold_01_01");	//Pay me? Hmm. I'll give you the information for 200 gold pieces.
	Info_ClearChoices (DIA_Hokurn_WhereDragon);
	Info_AddChoice (DIA_Hokurn_WhereDragon, "Too much!", DIA_Hokurn_WhereDragon_TooMuch);
	if (Npc_HasItems (other, ItMi_Gold) >= 200)
	{
		Info_AddChoice (DIA_Hokurn_WhereDragon, "Deal. Here's the money!", DIA_Hokurn_WhereDragon_OK);
	};
};

func void DIA_Hokurn_WhereDragon_TooMuch()
{
	AI_Output (other, self, "DIA_Hokurn_WhereDragon_TooMuch_15_00");	//Too much!
	AI_Output (self, other, "DIA_Hokurn_WhereDragon_TooMuch_01_01");	//Then forget it.
	Info_ClearChoices (DIA_Hokurn_WhereDragon);
};

func void DIA_Hokurn_WhereDragon_OK()
{
	AI_Output (other, self, "DIA_Hokurn_WhereDragon_OK_15_00");	//Deal. Here's the money!
	B_GiveInvItems (other, self, ItMi_Gold, 200);
	HokurnTellsDragon = TRUE;
	Info_ClearChoices(DIA_Hokurn_WhereDragon);
};

func void B_HokurnGiveMeThat()
{
	AI_Output(self,other,"DIA_Hokurn_WhereDragon_Booze_01_02");	//Agreed. Give me the bottle!
	AI_Output(self,other,"DIA_Hokurn_WhereDragon_Booze_01_03");	//I'll keep that for a rainy day.
};

func void DIA_Hokurn_WhereDragon_GiveDrink()
{
	if((Hokurn_WineGiven == TRUE) && (Npc_HasItems(other,ItFo_Wine) || Npc_HasItems(other,ItFo_DarkWine)))
	{
		AI_Output(other,self,"DIA_Vino_BringWine_15_00");	//Here's your wine.
		B_HokurnGiveMeThat();
		if(Npc_HasItems(other,ItFo_Wine))
		{
			B_GiveInvItems(other,self,ItFo_Wine,1);
		}
		else if(Npc_HasItems(other,ItFo_DarkWine))
		{
			B_GiveInvItems(other,self,ItFo_DarkWine,1);
			if(Hokurn_DarkWineGiven == FALSE)
			{
				B_GivePlayerXP(200);
				Hokurn_DarkWineGiven = TRUE;
			};
		};
	}
	else if(Npc_HasItems(other,ItFo_Booze))
	{
		if(Hokurn_BoozeGiven == TRUE)
		{
			AI_Output(other,self,"DIA_Hokurn_WhereDragon_Booze_15_00");	//I've still got a bottle of gin!
		}
		else
		{
			AI_Output(other,self,"DIA_Hokurn_WhereDragon_Booze_15_00_add");	//У меня есть бутылочка джина!@@@
		};
		B_HokurnGiveMeThat();
		B_GiveInvItems(other,self,ItFo_Booze,1);
	};
	HokurnTellsDragon = TRUE;
	Info_ClearChoices(DIA_Hokurn_WhereDragon);
};


instance DIA_Hokurn_Dragon(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 5;
	condition = DIA_Hokurn_Dragon_Condition;
	information = DIA_Hokurn_Dragon_Info;
	permanent = TRUE;
	description = "All right, now, where are those dragons?";
};


func int DIA_Hokurn_Dragon_Condition()
{
	if(HokurnTellsDragon == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Hokurn_Dragon_Info()
{
	AI_Output (other, self, "DIA_Hokurn_Dragon_15_00");	//All right, now, where are those dragons?
	AI_Output (self, other, "DIA_Hokurn_Dragon_01_01");	//Naturally, I can't tell you anything precise, but I've heard that there are supposed to be four dragons.
	if(FireDragonIsDead == FALSE)
	{
		AI_Output (self, other, "DIA_Hokurn_Dragon_01_02");	//We've seen a red glow over the highest mountain at night.
		AI_Output (self, other, "DIA_Hokurn_Dragon_01_03");	//I swear by my mother, if you're looking for a dragon, then you'll definitely find one there.
	};
};


instance DIA_Hokurn_AllDragonsDead(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 5;
	condition = DIA_Hokurn_AllDragonsDead_Condition;
	information = DIA_Hokurn_AllDragonsDead_Info;
	permanent = TRUE;
	description = "I've killed all the dragons.";
};


func int DIA_Hokurn_AllDragonsDead_Condition()
{
	if(MIS_AllDragonsDead == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Hokurn_AllDragonsDead_Info()
{
	AI_Output (other, self, "DIA_Hokurn_AllDragonsDead_15_00");	//I've killed all the dragons.
	AI_Output (self, other, "DIA_Hokurn_AllDragonsDead_01_01");	//Take a hike and tell your fairy tales to someone else.
};


instance DIA_Hokurn_PICKPOCKET(C_Info)
{
	npc = DJG_712_Hokurn;
	nr = 900;
	condition = DIA_Hokurn_PICKPOCKET_Condition;
	information = DIA_Hokurn_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Hokurn_PICKPOCKET_Condition()
{
	return C_Beklauen(69,210);
};

func void DIA_Hokurn_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Hokurn_PICKPOCKET);
	Info_AddChoice(DIA_Hokurn_PICKPOCKET,Dialog_Back,DIA_Hokurn_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Hokurn_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Hokurn_PICKPOCKET_DoIt);
};

func void DIA_Hokurn_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Hokurn_PICKPOCKET);
};

func void DIA_Hokurn_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Hokurn_PICKPOCKET);
};

