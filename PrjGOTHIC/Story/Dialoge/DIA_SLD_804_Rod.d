
instance DIA_Rod_EXIT(C_Info)
{
	npc = SLD_804_Rod;
	nr = 999;
	condition = DIA_Rod_EXIT_Condition;
	information = DIA_Rod_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Rod_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Rod_EXIT_Info()
{
	if(Npc_HasItems(hero,ItMw_2h_Rod_Fake))
	{
		Npc_RemoveInvItem(hero,ItMw_2h_Rod_Fake);
	};
	AI_EquipBestMeleeWeapon(self);
	AI_StopProcessInfos(self);
};


instance DIA_Rod_Hello(C_Info)
{
	npc = SLD_804_Rod;
	nr = 1;
	condition = DIA_Rod_Hello_Condition;
	information = DIA_Rod_Hello_Info;
	permanent = FALSE;
	description = "Everything all right?";
};


func int DIA_Rod_Hello_Condition()
{
	return TRUE;
};

func void DIA_Rod_Hello_Info()
{
	AI_Output (other, self, "DIA_Rod_Hello_15_00");	//How are things?
	if (other.guild != GIL_SLD)
	{
		AI_Output(self,other,"DIA_Rod_Hello_06_01");	//(dismissively) What do YOU want from me, weenie?
		if((other.guild == GIL_NOV) || (other.guild == GIL_KDF))
		{
			AI_Output (self, other, "DIA_Rod_Hello_06_02");	//Couldn't they find room for you in a monastery?
		};
	}
	else if(Wld_IsRaining())
	{
		B_Say(self,other,"$WEATHER");
	}
	else
	{
		B_Say(self,other,"$ABS_GOOD");
	};
};


var int Rod_SchwachGesagt;
var int DIA_Rod_Teach_permanent;
var int Rod_Merke_2h;

instance DIA_Rod_WannaLearn(C_Info)
{
	npc = SLD_804_Rod;
	nr = 2;
	condition = DIA_Rod_WannaLearn_Condition;
	information = DIA_Rod_WannaLearn_Info;
	permanent = TRUE;
	description = "Can you teach me how to handle two-handed weapons?";
};


func int DIA_Rod_WannaLearn_Condition()
{
	if(Rod_Teach2H == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Rod_WannaLearn_Info()
{
	AI_Output (other, self, "DIA_Rod_WannaLearn_15_00");	//Can you teach me how to handle two-handed weapons?
	if ((Rod_WetteGewonnen == TRUE) || (self.aivar[AIV_DefeatedByPlayer] == TRUE))
	{
		if(!Npc_HasItems(self,ItMw_2h_Rod))
		{
			AI_Output(self,other,"DIA_Rod_WannaLearn_06_03");	//That is, if you give me back my sword.
		}
		else if(RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Rod)
		{
			B_Say(self,other,"$NOLEARNYOUREBETTER");
			Rod_Teach2H = TRUE;
			DIA_Rod_Teach_permanent = TRUE;
		}
		else
		{
		AI_Output (self, other, "DIA_Rod_WannaLearn_06_01");	//I'm not a bad fighter, but that doesn't mean I'm a good teacher.
		AI_Output (self, other, "DIA_Rod_WannaLearn_06_02");	//Still, I think I can show you the basics of two-handed combat anyway.
			Rod_Teach2H = TRUE;
			Log_CreateTopic(TOPIC_SoldierTeacher,LOG_NOTE);
			B_LogEntry(TOPIC_SoldierTeacher,"Rod can show me how to fight with two haded weapons.");
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Rod_WannaLearn_06_04");	//Listen, boy. It takes a lot of strength to wield a two-handed weapon.
		AI_Output (self, other, "DIA_Rod_WannaLearn_06_05");	//Why don't you slink off to the pasture for a game of ring-around-a-rosy with the sheep?
		Rod_SchwachGesagt = TRUE;
	};
};


func void B_BuildLearnDialog_Rod()
{
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Rod)
	{
		Info_ClearChoices(DIA_Rod_Teach);
		Info_AddChoice(DIA_Rod_Teach,Dialog_Back,DIA_Rod_Teach_Back);
		Info_AddChoice(DIA_Rod_Teach,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Rod_Teach_2H_1);
		Info_AddChoice(DIA_Rod_Teach,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Rod_Teach_2H_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Rod)
		{
			DIA_Rod_Teach_permanent = TRUE;
		};
		PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_2H_Rod)),-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

instance DIA_Rod_Teach(C_Info)
{
	npc = SLD_804_Rod;
	nr = 3;
	condition = DIA_Rod_Teach_Condition;
	information = DIA_Rod_Teach_Info;
	permanent = TRUE;
	description = "I want to improve my two-handed fighting skills!";
};


func int DIA_Rod_Teach_Condition()
{
	if((Rod_Teach2H == TRUE) && (DIA_Rod_Teach_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Rod_Teach_Info()
{
	AI_Output (other, self, "DIA_Rod_Teach_15_00");	//I want to improve my two-handed fighting skills!
	Rod_Merke_2h = other.HitChance[NPC_TALENT_2H];
	B_BuildLearnDialog_Rod();
};

func void DIA_Rod_Teach_Back()
{
	if(Rod_Merke_2h < other.HitChance[NPC_TALENT_2H])
	{
		AI_Output (self, other, "DIA_Rod_Teach_BACK_06_00");	//You're getting better already.
	};
	Info_ClearChoices(DIA_Rod_Teach);
};

func void DIA_Rod_Teach_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Rod))
	{
		B_BuildLearnDialog_Rod();
	};
};

func void DIA_Rod_Teach_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Rod))
	{
		B_BuildLearnDialog_Rod();
	};
};

var int DIA_Rod_WannaJoin_noPerm;

instance DIA_Rod_WannaJoin(C_Info)
{
	npc = SLD_804_Rod;
	nr = 4;
	condition = DIA_Rod_WannaJoin_Condition;
	information = DIA_Rod_WannaJoin_Info;
	permanent = TRUE;
	description = "I want to join the mercenaries!";
};


func int DIA_Rod_WannaJoin_Condition()
{
	if((other.guild == GIL_NONE) && (DIA_Rod_WannaJoin_noPerm == FALSE))
	{
		return TRUE;
	};
};


func void DIA_Rod_WannaJoin_Info()
{
	AI_Output(other,self,"DIA_Rod_WannaJoin_15_00");	//I want to join the mercenaries!
	if(!Npc_HasItems(self,ItMw_2h_Rod))
	{
		AI_Output (self, other, "DIA_Rod_WannaJoin_06_01");	//So what about handing me my sword back first, eh?
	}
	else if((self.aivar[AIV_DefeatedByPlayer] == TRUE) || (Rod_WetteGewonnen == TRUE))
	{
		if(self.aivar[AIV_DefeatedByPlayer] == TRUE)
		{
			AI_Output (self, other, "DIA_Rod_WannaJoin_06_02");	//OK. I don't carry grudges.
			AI_Output (self, other, "DIA_Rod_WannaJoin_06_03");	//You can fight, and that's what counts.
			AI_Output (self, other, "DIA_Rod_WannaJoin_06_04");	//Most of the lads here think nothing of a little brawl among friends. You'll get used to that.
		}
		else
		{
			AI_Output (self, other, "DIA_Rod_WannaJoin_06_05");	//Oh well, you wield a decent sword. You'll learn the rest.
		};
		AI_Output(self,other,"DIA_Rod_WannaJoin_06_06");	//As far as I'm concerned, you're in.
		if(Torlof_GenugStimmen == FALSE)
		{
			Log_CreateTopic(TOPIC_SLDRespekt,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_SLDRespekt,LOG_Running);
		};
		SCKnowsSLDVotes = TRUE;
		B_LogEntry(TOPIC_SLDRespekt,"I'll get Rod's vote if I want to join the mercenaries.");
		DIA_Rod_WannaJoin_noPerm = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Rod_WannaJoin_06_07");	//There's no place for wimps around here!
		Rod_SchwachGesagt = TRUE;
	};
};


instance DIA_Rod_Duell(C_Info)
{
	npc = SLD_804_Rod;
	nr = 6;
	condition = DIA_Rod_Duell_Condition;
	information = DIA_Rod_Duell_Info;
	permanent = TRUE;
	description = "Looks like I'll have to teach you some manners, doesn't it?";
};


func int DIA_Rod_Duell_Condition()
{
	if(self.aivar[AIV_DefeatedByPlayer] == FALSE)
	{
		if(((Rod_WetteGewonnen == FALSE) && (Rod_SchwachGesagt == TRUE)) || (MIS_Jarvis_SldKO == LOG_Running))
		{
			return TRUE;
		};
	};
};

func void DIA_Rod_Duell_Info()
{
	AI_Output (other, self, "DIA_Rod_Duell_15_00");	//Looks like I'll have to teach you some manners, doesn't it?
	if (self.aivar[AIV_LastFightAgainstPlayer] == FIGHT_NONE)
	{
		AI_Output (self, other, "DIA_Rod_Duell_06_01");	//Go ahead, give it a try!
	}
	else
	{
		AI_Output (self, other, "DIA_Rod_Duell_06_02");	//You're just not going to learn this!
	};
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};


instance DIA_Rod_StarkGenug(C_Info)
{
	npc = SLD_804_Rod;
	nr = 5;
	condition = DIA_Rod_StarkGenug_Condition;
	information = DIA_Rod_StarkGenug_Info;
	permanent = FALSE;
	description = "I am strong enough!";
};


func int DIA_Rod_StarkGenug_Condition()
{
	if((self.aivar[AIV_DefeatedByPlayer] == FALSE) && (Rod_WetteGewonnen == FALSE) && (Rod_SchwachGesagt == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Rod_StarkGenug_Info()
{
	AI_Output (other, self, "DIA_Rod_StarkGenug_15_00");	//I am strong enough!
	AI_Output (self, other, "DIA_Rod_StarkGenug_06_01");	//Nonsense! You couldn't even LIFT a decent sword like mine!
	Log_CreateTopic (Topic_RodWette, LOG_MISSION);
	Log_SetTopicStatus (Topic_RodWette, LOG_Running);
	B_LogEntry (Topic_RodWette, "The mercenary Rod doesn't think I can hold up his sword.");
};


instance DIA_Rod_BINStarkGenug(C_Info)
{
	npc = SLD_804_Rod;
	nr = 5;
	condition = DIA_Rod_BINStarkGenug_Condition;
	information = DIA_Rod_BINStarkGenug_Info;
	permanent = FALSE;
	description = "I said I AM strong enough!";
};


func int DIA_Rod_BINStarkGenug_Condition()
{
	if((self.aivar[AIV_DefeatedByPlayer] == FALSE) && (Rod_WetteGewonnen == FALSE) && Npc_KnowsInfo(other,DIA_Rod_StarkGenug))
	{
		return TRUE;
	};
};

func void DIA_Rod_BINStarkGenug_Info()
{
	AI_Output (other, self, "DIA_Rod_BINStarkGenug_15_00");	//I said I AM strong enough!
	AI_Output (self, other, "DIA_Rod_BINStarkGenug_06_01");	//Ooh, you're killing me. Want to risk a little bet?
};


var int Rod_WetteGewonnen;
var int Rod_WetteAngenommen;
var int Rod_Gold;

instance DIA_Rod_Wette(C_Info)
{
	npc = SLD_804_Rod;
	nr = 5;
	condition = DIA_Rod_Wette_Condition;
	information = DIA_Rod_Wette_Info;
	permanent = TRUE;
	description = "I bet I can handle your sword!";
};


func int DIA_Rod_Wette_Condition()
{
	if((self.aivar[AIV_DefeatedByPlayer] == FALSE) && (Rod_WetteGewonnen == FALSE) && Npc_KnowsInfo(other,DIA_Rod_BINStarkGenug) && Npc_HasItems(self,ItMw_2h_Rod) && (Rod_WetteAngenommen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Rod_Wette_Info()
{
	AI_Output (other, self, "DIA_Rod_Wette_15_00");	//I bet I can handle your sword!
	AI_Output (self, other, "DIA_Rod_Wette_06_01");	//Really? Hmm... (thinking) How much should I relieve you of?
	AI_Output (self, other, "DIA_Rod_Wette_06_02");	//Well, you look like a poor sucker. Let's make it 30 gold pieces! Do you even have that much?
	Info_ClearChoices(DIA_Rod_Wette);
	Info_AddChoice (DIA_Rod_Wette, "No.", DIA_Rod_Wette_No);
	Info_AddChoice (DIA_Rod_Wette, "Sure.", DIA_Rod_Wette_Yes);
	if(Rod_Gold == FALSE)
	{
		B_LogEntry(Topic_RodWette,"Rod's wagering 30 pieces of gold that I can't hold up his sword.");
		Rod_Gold = TRUE;
	};
};

func void DIA_Rod_Wette_No()
{
	AI_Output (other, self, "DIA_Rod_Wette_No_15_00");	//No.
	AI_Output (self, other, "DIA_Rod_Wette_No_06_01");	//Oh, just go away.
	Info_ClearChoices (DIA_Rod_Wette);
};

func void DIA_Rod_Wette_Yes()
{
	AI_Output (other, self, "DIA_Rod_Wette_Yes_15_00");	//Sure.
	AI_Output (self, other, "DIA_Rod_Wette_Yes_06_01");	//Let me see, then ...
	if (B_GiveInvItems (other, self, ItMi_Gold, 30))
	{
		Rod_WetteAngenommen = TRUE;
		AI_Output (other, self, "DIA_Rod_Wette_Yes_15_02");	//Here!
		AI_Output (self, other, "DIA_Rod_Wette_Yes_06_03");	//(gloating) All right, let's see then how strong you are...
		B_GiveInvItems(self,other,ItMw_2h_Rod,1);
		if(other.attribute[ATR_STRENGTH] >= Condition_Rod)
		{
			if(Npc_HasReadiedMeleeWeapon(other) || Npc_HasReadiedRangedWeapon(other))
			{
				AI_RemoveWeapon(other);
			};
			AI_WaitTillEnd(other,self);
			CreateInvItem(other,ItMw_2h_Rod_Fake);
			AI_UseItem(other,ItMw_2h_Rod_Fake);
			AI_Wait(other,0.5);
				AI_Output (other, self, "DIA_Rod_Wette_Yes_15_04");	//About this strong?!
				AI_Output (self, other, "DIA_Rod_Wette_Yes_06_05");	//(perplexed) Looks like you got me there.
				AI_Output (self, other, "DIA_Rod_Wette_Yes_06_06");	//I never expected that. You really don't look like you have that much strength in you.
				AI_Output (self, other, "DIA_Rod_Wette_Yes_06_07");	//Well - I guess I just lost 30 gold pieces. Here you are.
			B_GiveInvItems(self,other,ItMi_Gold,60);
			B_LogEntry(Topic_RodWette,"I managed to handle Rod's weapon.");
			Rod_WetteGewonnen = TRUE;
			B_GivePlayerXP(XP_Rod);
		}
		else
		{
			AI_Output(other,self,"DIA_Rod_Wette_Yes_15_08");	//I can't wield this weapon.
			AI_Output(self,other,"DIA_Rod_Wette_Yes_06_09");	//(laughs) That's what I'm saying!
			B_LogEntry(Topic_RodWette,"I couldn't handle Rod's weapon.");
		};
		AI_Output (self, other, "DIA_Rod_Wette_Yes_06_10");	//And now give me back my weapon.
		Info_ClearChoices (DIA_Rod_Wette);
		Info_AddChoice (DIA_Rod_Wette, "I think not ...", DIA_Rod_Wette_KeepIt);
		Info_AddChoice (DIA_Rod_Wette, "Here you are.", DIA_Rod_Wette_GiveBack);
	}
	else
	{
		AI_Output (other, self, "DIA_Rod_Wette_Yes_15_11");	//Now where did I put it ...
		AI_Output (self, other, "DIA_Rod_Wette_Yes_06_12");	//That figures. Come back when you have gold to bet with.
		Info_ClearChoices (DIA_Rod_Wette);
	};
};

func void DIA_Rod_Wette_GiveBack()
{
	if(Npc_HasItems(hero,ItMw_2h_Rod_Fake))
	{
		Npc_RemoveInvItem(hero,ItMw_2h_Rod_Fake);
	};
	AI_Output(other,self,"DIA_Rod_Wette_GiveBack_15_00");	//Here you are.
	B_GiveInvItems(other,self,ItMw_2h_Rod,1);
	if(Rod_WetteGewonnen == FALSE)
	{
		AI_Output(self,other,"DIA_Rod_Wette_GiveBack_06_01_add");	//You're nothing but a wimp after all!
	};
	Info_ClearChoices(DIA_Rod_Wette);
};

func void DIA_Rod_Wette_KeepIt()
{
	if(Npc_HasItems(hero,ItMw_2h_Rod_Fake))
	{
		Npc_RemoveInvItem(hero,ItMw_2h_Rod_Fake);
	};
	DIA_Common_IThinkNo();
	AI_Output(self,other,"DIA_Rod_Wette_KeepIt_06_01");	//(threatening) What was that?
	AI_Output(other,self,"DIA_Rod_Wette_KeepIt_15_02");	//I think I'm going to keep it a little longer.
	AI_Output(self,other,"DIA_Rod_Wette_GiveBack_06_01");	//You're nothing but a wimp after all!
	AI_Output(self,other,"DIA_Rod_Wette_KeepIt_06_03");	//Just you wait, you bastard!
	Info_ClearChoices(DIA_Rod_Wette);
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};


instance DIA_Rod_GiveItBack(C_Info)
{
	npc = SLD_804_Rod;
	nr = 7;
	condition = DIA_Rod_GiveItBack_Condition;
	information = DIA_Rod_GiveItBack_Info;
	permanent = TRUE;
	description = "Here's your sword back!";
};


func int DIA_Rod_GiveItBack_Condition()
{
	if(Npc_HasItems(other,ItMw_2h_Rod))
	{
		return TRUE;
	};
};

func void DIA_Rod_GiveItBack_Info()
{
	B_GiveInvItems (other, self, ItMw_2h_Rod, 1);
	AI_Output (other, self, "DIA_Rod_GiveItBack_15_00");	//Here's your sword back!
	AI_Output (self, other, "DIA_Rod_GiveItBack_06_01");	//High time, too!
	if (Rod_SchwertXPGiven == FALSE)
	{
		if(CurrentLevel == NEWWORLD_ZEN)
		{
			B_GivePlayerXP(XP_Ambient);
		}
		else
		{
			B_GivePlayerXP(50);
		};
		Rod_SchwertXPGiven = TRUE;
	};
};


instance DIA_Rod_PERM(C_Info)
{
	npc = SLD_804_Rod;
	nr = 1;
	condition = DIA_Rod_PERM_Condition;
	information = DIA_Rod_PERM_Info;
	permanent = TRUE;
	description = "What's up?";
};


func int DIA_Rod_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rod_Hello))
	{
		return TRUE;
	};
};

func void DIA_Rod_PERM_Info()
{
	AI_Output (other, self, "DIA_Rod_PERM_15_00");	//How's it going?
	if (Kapitel <= 2)
	{
		if(other.guild == GIL_NONE)
		{
			if((self.aivar[AIV_DefeatedByPlayer] == FALSE) && (Rod_WetteGewonnen == FALSE))
			{
				AI_Output (self, other, "DIA_Rod_PERM_06_01");	//That's none of your business, weakling.
				Rod_SchwachGesagt = TRUE;
			}
			else
			{
				AI_Output (self, other, "DIA_Rod_PERM_06_02");	//I'm curious to see whether they'll let you join.
			};
		}
		else if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
		{
			AI_Output (self, other, "DIA_Rod_PERM_06_03");	//You're one of us now, kid. We'll get that settled somehow.
		}
		else
		{
			AI_Output (self, other, "DIA_Rod_PERM_06_04");	//You don't belong here, you'd better go hang out somewhere else!
		};
	};
	if(Kapitel >= 3)
	{
		AI_Output (self, other, "DIA_Rod_PERM_06_05");	//If all those stories about dragons are actually true, we should get a few people together and go flatten those beasts!
	};
};


instance DIA_RodSLD_PICKPOCKET(C_Info)
{
	npc = SLD_804_Rod;
	nr = 900;
	condition = DIA_RodSLD_PICKPOCKET_Condition;
	information = DIA_RodSLD_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_RodSLD_PICKPOCKET_Condition()
{
	return C_Beklauen(15,35);
};

func void DIA_RodSLD_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_RodSLD_PICKPOCKET);
	Info_AddChoice(DIA_RodSLD_PICKPOCKET,Dialog_Back,DIA_RodSLD_PICKPOCKET_BACK);
	Info_AddChoice(DIA_RodSLD_PICKPOCKET,DIALOG_PICKPOCKET,DIA_RodSLD_PICKPOCKET_DoIt);
};

func void DIA_RodSLD_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_RodSLD_PICKPOCKET);
};

func void DIA_RodSLD_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_RodSLD_PICKPOCKET);
};

