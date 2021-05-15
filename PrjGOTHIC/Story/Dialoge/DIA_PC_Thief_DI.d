
instance DIA_PC_Thief_DI_EXIT(C_Info)
{
	npc = PC_Thief_DI;
	nr = 999;
	condition = DIA_PC_Thief_DI_EXIT_Condition;
	information = DIA_PC_Thief_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_PC_Thief_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_PC_Thief_DI_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_PC_Thief_DI_Hallo(C_Info)
{
	npc = PC_Thief_DI;
	nr = 5;
	condition = DIA_PC_Thief_DI_Hallo_Condition;
	information = DIA_PC_Thief_DI_Hallo_Info;
	description = "Here we are.";
};


func int DIA_PC_Thief_DI_Hallo_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_PC_Thief_DI_Hallo_Info()
{
	AI_Output (other, self, "DIA_PC_Thief_DI_Hallo_15_00");	//Here we are.
	AI_Output (self, other, "DIA_PC_Thief_DI_Hallo_11_01");	//This island is not as far away from Khorinis as I thought.
	AI_Output (self, other, "DIA_PC_Thief_DI_Hallo_11_02");	//I didn't know about it. But now, of course, a few things are becoming clear to me.
	AI_Output (self, other, "DIA_PC_Thief_DI_Hallo_11_03");	//I had always asked myself how the orcs could keep their supplies coming so fast.
	AI_Output (self, other, "DIA_PC_Thief_DI_Hallo_11_04");	//With this outpost, that's a piece of cake.
	AI_Output (self, other, "DIA_PC_Thief_DI_Hallo_11_05");	//On your way to the interior of the island, you are probably going to encounter a trap or two.
	AI_Output (self, other, "DIA_PC_Thief_DI_Hallo_11_06");	//If you think you are stuck at some point, come to me. Maybe my experience can help you.
};


var int DIA_PC_Thief_DI_RAT_OneTime;

instance DIA_PC_Thief_DI_RAT(C_Info)
{
	npc = PC_Thief_DI;
	nr = 5;
	condition = DIA_PC_Thief_DI_RAT_Condition;
	information = DIA_PC_Thief_DI_RAT_Info;
	permanent = TRUE;
	description = "I need your advice.";
};


func int DIA_PC_Thief_DI_RAT_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && Npc_KnowsInfo(other,DIA_PC_Thief_DI_Hallo))
	{
		return TRUE;
	};
};

func void DIA_PC_Thief_DI_RAT_Info()
{
	AI_Output(other,self,"DIA_PC_Thief_DI_RAT_15_00");	//I need your advice.
	if(Npc_IsDead(AntiPaladin_DI) && (EVT_ORKOBERST_SWITCH_FOUND == FALSE))
	{
		AI_Output (other, self, "DIA_PC_Thief_DI_RAT_15_01");	//An orcish colonel has his headquarters up there. I can't get any further to the interior of the island from there.
		AI_Output (self, other, "DIA_PC_Thief_DI_RAT_11_02");	//Orcs are smart creatures. They are often underestimated. I assume they have a secret passage of some sort. Search the walls for secret switches.
		AI_Output (self, other, "DIA_PC_Thief_DI_RAT_11_03");	//Remember, however, that switches must often be used in a certain order before they have any effect.
	}
	else if(Npc_IsDead(FireDragonIsland) && (EVT_DIBRIDGE_OPENED == FALSE))
	{
		AI_Output (other, self, "DIA_PC_Thief_DI_RAT_15_04");	//I have fought with a dragon, and now I'm facing an abyss with a drawbridge. The bridge has been hauled up, and I cannot get across.
		AI_Output (self, other, "DIA_PC_Thief_DI_RAT_11_05");	//Mmh. Have you already tried a ranged weapon? Maybe the mechanism could be activated with a shot.
	}
	else if(Npc_IsDead(Archol) && (EnteredFinalDIHall == FALSE))
	{
		AI_Output (other, self, "DIA_PC_Thief_DI_RAT_15_06");	//I'm facing a host of undead and their complicated traps.
		AI_Output (self, other, "DIA_PC_Thief_DI_RAT_11_07");	//I'm sorry, I have no experience with the undead. You're on your own with this one.
	}
	else
	{
		AI_Output(self,other,"DIA_PC_Thief_DI_RAT_11_08");	//Come see me again when you have a problem which my experience can solve.
	};
	if((OrkSturmDI == TRUE) && (DIA_PC_Thief_DI_RAT_OneTime == FALSE))
	{
		AI_Output(self,other,"DIA_PC_Thief_DI_RAT_11_09");	//One more thing. I'd rather that you didn't draw all the creatures that crawl around here to the ship. I hope this orc raid was the last attack I had to fend off here!
		B_GivePlayerXP(XP_AmbientKap6);
		DIA_PC_Thief_DI_RAT_OneTime = TRUE;
	};
};


instance DIA_Diego_DI_TRADE(C_Info)
{
	npc = PC_Thief_DI;
	nr = 12;
	condition = DIA_Diego_DI_TRADE_Condition;
	information = DIA_Diego_DI_TRADE_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "I need ammunition.";
};


func int DIA_Diego_DI_TRADE_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Diego_DI_TRADE_Info()
{
	AI_Output(other,self,"DIA_Diego_DI_TRADE_15_00");	//I need ammunition.
	B_GiveTradeInv(self);
	if(TradersHaveLimitedAmmo == TRUE)
	{
		if(Diego_DI_Ammo_Day <= Wld_GetDay())
		{
			B_RefreshAmmo(self,50);
			Diego_DI_Ammo_Day = Wld_GetDay() + 1;
		};
	}
	else
	{
		B_RefreshAmmo(self,50);
	};
	AI_Output(self,other,"DIA_Diego_DI_TRADE_11_01");	//Maybe I can help you.
	Trade_IsActive = TRUE;
};


func void B_BuildLearnDialog_Diego_DI()
{
	Info_ClearChoices(DIA_PC_Thief_DI_Training_Talente);
	Info_AddChoice(DIA_PC_Thief_DI_Training_Talente,Dialog_Back,DIA_PC_Thief_DI_Training_Talente_BACK);
	if(!Npc_GetTalentSkill(other,NPC_TALENT_PICKLOCK))
	{
		Info_AddChoice(DIA_PC_Thief_DI_Training_Talente,B_BuildLearnString(NAME_Skill_PickLock,B_GetLearnCostTalent(other,NPC_TALENT_PICKLOCK,1)),DIA_PC_Thief_DI_Training_Talente_PICKLOCK);
	};
	Info_AddChoice(DIA_PC_Thief_DI_Training_Talente,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_PC_Thief_DI_Training_DEX_1);
	Info_AddChoice(DIA_PC_Thief_DI_Training_Talente,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_PC_Thief_DI_Training_DEX_5);
	if(VisibleTalentValue(NPC_TALENT_BOW) < 100)
	{
		Info_AddChoice(DIA_PC_Thief_DI_Training_Talente,B_BuildLearnString(PRINT_LearnBow1,B_GetLearnCostTalent(other,NPC_TALENT_BOW,1)),DIA_PC_Thief_DI_Training_Combat_BOW_1);
		Info_AddChoice(DIA_PC_Thief_DI_Training_Talente,B_BuildLearnString(PRINT_LearnBow5,B_GetLearnCostTalent(other,NPC_TALENT_BOW,5)),DIA_PC_Thief_DI_Training_Combat_BOW_5);
	};
};

instance DIA_PC_Thief_DI_Training_Talente(C_Info)
{
	npc = PC_Thief_DI;
	nr = 10;
	condition = DIA_PC_Thief_DI_Training_Talente_Condition;
	information = DIA_PC_Thief_DI_Training_Talente_Info;
	permanent = TRUE;
	description = "Train me.";
};


func int DIA_PC_Thief_DI_Training_Talente_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && Npc_KnowsInfo(other,DIA_PC_Thief_DI_Hallo))
	{
		return TRUE;
	};
};

func void DIA_PC_Thief_DI_Training_Talente_Info()
{
	AI_Output(other,self,"DIA_PC_Thief_DI_Training_15_00");	//Train me.
	if(Npc_GetTalentSkill(other,NPC_TALENT_PICKLOCK))
	{
		AI_Output(self,other,"DIA_DiegoNW_Teach_11_01");	//I can teach you to become more dexterous.
	}
	else
	{
		AI_Output(self,other,"DIA_PC_Thief_DI_Training_11_01");	//What is it you need?
	};
	B_BuildLearnDialog_Diego_DI();
};

func void DIA_PC_Thief_DI_Training_DEX_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MAX))
	{
		AI_Output(self,other,"DIA_PC_Thief_DI_Training_DEX_1_11_00");	//Life will be much easier for you if you always try to stay out of the line of fire.
		B_BuildLearnDialog_Diego_DI();
	};
};

func void DIA_PC_Thief_DI_Training_DEX_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MAX))
	{
		AI_Output(self,other,"DIA_PC_Thief_DI_Training_DEX_5_11_00");	//When you move, always have the litheness of a cat in mind. The rest will follow automatically.
		B_BuildLearnDialog_Diego_DI();
	};
};

func void DIA_PC_Thief_DI_Training_Combat_BOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,1,100))
	{
		AI_Output(self,other,"DIA_PC_Thief_DI_Training_Combat_BOW_1_11_00");	//For best results, put in a lot of dry practice.
		B_BuildLearnDialog_Diego_DI();
	};
};

func void DIA_PC_Thief_DI_Training_Combat_BOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,5,100))
	{
		AI_Output(self,other,"DIA_PC_Thief_DI_Training_Combat_BOW_5_11_00");	//To steady your hand, breathe out slowly while you aim.
		B_BuildLearnDialog_Diego_DI();
	};
};

func void DIA_PC_Thief_DI_Training_Talente_PICKLOCK()
{
	if(B_TeachThiefTalent(self,other,NPC_TALENT_PICKLOCK))
	{
		AI_Output(self,other,"DIA_PC_Thief_DI_Training_PICKLOCK_11_00");	//It was high time. It's strange you've never learned this ability before.
		B_BuildLearnDialog_Diego_DI();
	};
};

func void DIA_PC_Thief_DI_Training_Talente_BACK()
{
	Info_ClearChoices(DIA_PC_Thief_DI_Training_Talente);
};

func void B_PC_Thief_JustLucky()
{
	AI_Output(other,self,"DIA_PC_Thief_DI_UndeadDragonDead_15_03");	//Мне просто повезло, я думаю.
	AI_Output(self,other,"DIA_PC_Thief_DI_UndeadDragonDead_11_04");	//(смеется) Ну, если ты так думаешь...
};

var int DIA_PC_Thief_DI_UndeadDragonDead_OneTime;

instance DIA_PC_Thief_DI_UndeadDragonDead(C_Info)
{
	npc = PC_Thief_DI;
	nr = 5;
	condition = DIA_PC_Thief_DI_UndeadDragonDead_Condition;
	information = DIA_PC_Thief_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "It's all over. Now we can get out of here.";
};


func int DIA_PC_Thief_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_PC_Thief_DI_UndeadDragonDead_Info()
{
	AI_Output(other,self,"DIA_PC_Thief_DI_UndeadDragonDead_15_00");	//It's all over. Now we can get out of here.
	if((Npc_GetDistToWP(self,"WP_UNDEAD_MIDDLE_01") < 4000) && (DIA_PC_Thief_DI_UndeadDragonDead_OneTime == FALSE))
	{
		AI_Output (self, other, "DIA_PC_Thief_DI_UndeadDragonDead_11_01");	//Now will you look at this. I've never seen such a construction all my life.
		AI_Output (self, other, "DIA_PC_Thief_DI_UndeadDragonDead_11_02");	//How in earth did you manage to get past that thing?
		B_PC_Thief_JustLucky();
	}
	else
	{
		AI_Output (self, other, "DIA_PC_Thief_DI_UndeadDragonDead_11_05");	//Fine.
	};
	if(DIA_PC_Thief_DI_UndeadDragonDead_OneTime == FALSE)
	{
		AI_Output(other,self,"DIA_PC_Thief_DI_UndeadDragonDead_15_06");	//What are you going to do now?
		if(MIS_HelpDiegoNW != LOG_SUCCESS)
		{
			AI_Output(self,other,"DIA_DIEGONW_NEEDHELP_PROBLEM_WILLHELPYOU_11_01");	//I've hidden a small fortune in the Valley of the Mines.
		}
		else
		{
			AI_Output(self,other,"DIA_PC_Thief_DI_UndeadDragonDead_11_07");	//That's a good question. I think I'll go back to Khorinis first.
			if((Andre_FoundThieves_Reported == TRUE) || (MIS_Andre_GuildOfThieves == LOG_SUCCESS))
			{
				AI_Output(self,other,"DIA_DiegoDI_Add_11_00");	//There's no more thieves' guild there. That opens up some interesting possibilities.
			};
		};
		AI_Output (self, other, "DIA_PC_Thief_DI_UndeadDragonDead_11_09");	//Mmh. Or maybe I'll simply take over Bromor's business. There's always money in that. Honest money.
		DIA_PC_Thief_DI_UndeadDragonDead_OneTime = TRUE;
	};
	AI_Output(self,other,"DIA_PC_Thief_DI_UndeadDragonDead_11_10");	//Go to the captain now and let's get out of here.
	AI_StopProcessInfos(self);
	if(Lares_IsOnBoard != LOG_SUCCESS)
	{
		Npc_ExchangeRoutine(self,"SittingShipDI");
	}
	else
	{
		Npc_ExchangeRoutine(self,"Start");
	};
};


instance DIA_Thief_DI_PICKPOCKET(C_Info)
{
	npc = PC_Thief_DI;
	nr = 900;
	condition = DIA_Thief_DI_PICKPOCKET_Condition;
	information = DIA_Thief_DI_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_120;
};


func int DIA_Thief_DI_PICKPOCKET_Condition()
{
	return C_Beklauen(120,600);
};

func void DIA_Thief_DI_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Thief_DI_PICKPOCKET);
	Info_AddChoice(DIA_Thief_DI_PICKPOCKET,Dialog_Back,DIA_Thief_DI_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Thief_DI_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Thief_DI_PICKPOCKET_DoIt);
};

func void DIA_Thief_DI_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Thief_DI_PICKPOCKET);
};

func void DIA_Thief_DI_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Thief_DI_PICKPOCKET);
};

