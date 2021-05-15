
instance DIA_DJG_715_Ferros_EXIT(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 999;
	condition = DIA_DJG_715_Ferros_EXIT_Condition;
	information = DIA_DJG_715_Ferros_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_DJG_715_Ferros_EXIT_Condition()
{
	return TRUE;
};

func void DIA_DJG_715_Ferros_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_DJG_715_Ferros_Hello(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 4;
	condition = DIA_DJG_715_Ferros_Hello_Condition;
	information = DIA_DJG_715_Ferros_Hello_Info;
	permanent = FALSE;
	description = "Where do you come from?";
};


func int DIA_DJG_715_Ferros_Hello_Condition()
{
	return TRUE;
};

func void DIA_DJG_715_Ferros_Hello_Info()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_Hello_15_00");	//Where do you come from?
	AI_Output (self, other, "DIA_DJG_715_Ferros_Hello_01_01");	//From the mainland. My people and I fled here.
	AI_Output (self, other, "DIA_DJG_715_Ferros_Hello_01_02");	//The situation there is getting worse. The orcs leave nothing but burned-out villages behind.
	AI_Output (self, other, "DIA_DJG_715_Ferros_Hello_01_03");	//The king has lost control of his realm.
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_DJG_715_Ferros_Hello_01_04");	//You paladins have failed, if you ask me.
	};
};


instance DIA_DJG_715_Ferros_Friends(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 5;
	condition = DIA_DJG_715_Ferros_Friends_Condition;
	information = DIA_DJG_715_Ferros_Friends_Info;
	permanent = FALSE;
	description = "Where are your people now?";
};


func int DIA_DJG_715_Ferros_Friends_Condition()
{
	if(Npc_KnowsInfo(other,DIA_DJG_715_Ferros_Hello))
	{
		return TRUE;
	};
};

func void DIA_DJG_715_Ferros_Friends_Info()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_Friends_15_00");	//Where are your people now?
	AI_Output (self, other, "DIA_DJG_715_Ferros_Friends_01_01");	//I left them.
	AI_Output (self, other, "DIA_DJG_715_Ferros_Friends_01_02");	//They thought they could take everything they wanted, even if it doesn't belong to them. Count me out.
};


instance DIA_DJG_715_Ferros_War(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 6;
	condition = DIA_DJG_715_Ferros_War_Condition;
	information = DIA_DJG_715_Ferros_War_Info;
	permanent = FALSE;
	description = "What else do you know about the war?";
};


func int DIA_DJG_715_Ferros_War_Condition()
{
	if(Npc_KnowsInfo(other,DIA_DJG_715_Ferros_Hello))
	{
		return TRUE;
	};
};

func void DIA_DJG_715_Ferros_War_Info()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_War_15_00");	//What else do you know about the war?
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_DJG_715_Ferros_War_01_01");	//You haven't been to see your king in a long time, huh?
	};
	AI_Output (self, other, "DIA_DJG_715_Ferros_War_01_02");	//The orcs are outside the capital. But whether it's fallen yet, I don't know.
	AI_Output (self, other, "DIA_DJG_715_Ferros_War_01_03");	//The last thing I heard was that the king is dead. But I don't believe that.
};


instance DIA_DJG_715_Ferros_OldCamp(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 7;
	condition = DIA_DJG_715_Ferros_OldCamp_Condition;
	information = DIA_DJG_715_Ferros_OldCamp_Info;
	permanent = FALSE;
	description = "What are you doing here in the castle?";
};


func int DIA_DJG_715_Ferros_OldCamp_Condition()
{
	return TRUE;
};

func void DIA_DJG_715_Ferros_OldCamp_Info()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_OldCamp_15_00");	//What are you doing here in the castle?
	AI_Output (self, other, "DIA_DJG_715_Ferros_OldCamp_01_01");	//I heard about the dragons and wanted to help fight them.
	AI_Output (self, other, "DIA_DJG_715_Ferros_OldCamp_01_02");	//Unfortunately, I lost my sword when I was sneaking past the orcs. Now I'm stuck here.
	AI_Output (self, other, "DIA_DJG_715_Ferros_OldCamp_01_03");	//Without a sword, I can't get out of here, and the swords I can buy here are the worst junk.
	Info_ClearChoices(DIA_DJG_715_Ferros_OldCamp);
	Info_AddChoice(DIA_DJG_715_Ferros_OldCamp,"I wish you luck with your search.",DIA_DJG_715_Ferros_OldCamp_No);
	Info_AddChoice(DIA_DJG_715_Ferros_OldCamp,"What will you give me if I find you a good sword?",DIA_DJG_715_Ferros_OldCamp_Price);
	Info_AddChoice(DIA_DJG_715_Ferros_OldCamp,"I shall find your sword.",DIA_DJG_715_Ferros_OldCamp_Yes);
	MIS_FerrosSword = LOG_Running;
};

func void DIA_DJG_715_Ferros_OldCamp_No()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_OldCamp_No_15_00");	//I wish you luck with your search.
	AI_Output (self, other, "DIA_DJG_715_Ferros_OldCamp_No_01_01");	//I really have to ask myself why I ever came here.
	Info_ClearChoices (DIA_DJG_715_Ferros_OldCamp);
};

func void DIA_DJG_715_Ferros_OldCamp_Price()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_OldCamp_Price_15_00");	//What will you give me if I find you a good sword?
	AI_Output (self, other, "DIA_DJG_715_Ferros_OldCamp_Price_01_01");	//Alas, I can't give you anything. I spent my last gold on the sword.
};

func void DIA_DJG_715_Ferros_OldCamp_Yes()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_OldCamp_Yes_15_00");	//I shall find your sword.
	AI_Output (self, other, "DIA_DJG_715_Ferros_OldCamp_Yes_01_01");	//That would be great. You should look for it on the high cliff to the south.
	AI_Output (self, other, "DIA_DJG_715_Ferros_OldCamp_Yes_01_02");	//I probably lost it there, near the orc tents.
	Log_CreateTopic(TOPIC_FerrosSword,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_FerrosSword,LOG_Running);
	B_LogEntry(TOPIC_FerrosSword,"It seems Feros lost his sword on the tall cliff in the south, where the orc tents are.Как безрассудно.");
	Info_ClearChoices(DIA_DJG_715_Ferros_OldCamp);
};


instance DIA_DJG_715_Ferros_FerrosAnySword(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 6;
	condition = DIA_DJG_715_Ferros_FerrosAnySword_Condition;
	information = DIA_DJG_715_Ferros_FerrosAnySword_Info;
	permanent = TRUE;
	description = "Maybe I've got another sword for you.";
};


func int DIA_DJG_715_Ferros_FerrosAnySword_Condition()
{
	if((MIS_FerrosSword == LOG_Running) && (Npc_HasItems(other,ItMw_1H_Special_01) || Npc_HasItems(other,ItMw_1H_Special_02)))
	{
		return TRUE;
	};
};

func void DIA_DJG_715_Ferros_FerrosAnySword_Info()
{
	AI_Output(other,self,"DIA_DJG_715_Ferros_FerrosAnySword_Silverblade_15_00");	//Maybe I've got another sword for you.
	Info_ClearChoices(DIA_DJG_715_Ferros_FerrosAnySword);
	Info_AddChoice(DIA_DJG_715_Ferros_FerrosAnySword,Dialog_Back,DIA_DJG_715_Ferros_FerrosAnySword_Back);
	if(Npc_HasItems(other,ItMw_1H_Special_01))
	{
		Info_AddChoice(DIA_DJG_715_Ferros_FerrosAnySword,"(give 'Ore Longsword')",DIA_DJG_715_Ferros_FerrosAnySword_Silverblade);
	};
	if(Npc_HasItems(other,ItMw_1H_Special_02))
	{
		Info_AddChoice(DIA_DJG_715_Ferros_FerrosAnySword,"(give 'Ore Bastard Sword')",DIA_DJG_715_Ferros_FerrosAnySword_Oreblade);
	};
};

func void DIA_DJG_715_Ferros_FerrosAnySword_Back()
{
	Info_ClearChoices(DIA_DJG_715_Ferros_FerrosAnySword);
};

func void B_Ferros_FerrosAnySword_Give()
{
	AI_Output (self, other, "DIA_DJG_715_Ferros_FerrosAnySword_Give_01_00");	//That's a good blade. Really excellent work.
	AI_Output (self, other, "DIA_DJG_715_Ferros_FerrosAnySword_Give_01_01");	//Are you sure you want to give it to me just like that?
};

func void DIA_DJG_715_Ferros_FerrosAnySword_Silverblade()
{
	B_Ferros_FerrosAnySword_Give ();
	Info_ClearChoices (DIA_DJG_715_Ferros_FerrosAnySword);
	Info_AddChoice (DIA_DJG_715_Ferros_FerrosAnySword, "No, I need it myself.", DIA_DJG_715_Ferros_FerrosAnySword_Silverblade_No);
	Info_AddChoice (DIA_DJG_715_Ferros_FerrosAnySword, "Yes, take it.", DIA_DJG_715_Ferros_FerrosAnySword_Silverblade_Yes);
};

func void DIA_DJG_715_Ferros_FerrosAnySword_Oreblade()
{
	B_Ferros_FerrosAnySword_Give ();
	Info_ClearChoices (DIA_DJG_715_Ferros_FerrosAnySword);
	Info_AddChoice (DIA_DJG_715_Ferros_FerrosAnySword, "No, I need it myself.", DIA_DJG_715_Ferros_FerrosAnySword_Oreblade_No);
	Info_AddChoice (DIA_DJG_715_Ferros_FerrosAnySword, "Yes, take it.", DIA_DJG_715_Ferros_FerrosAnySword_Oreblade_Yes);
};

func void B_Ferros_FerrosAnySword_Yes1()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_FerrosAnySword_Blade_Yes_15_00");	//Yes, take it.
};

func void B_Ferros_FerrosAnySword_Yes2()
{
	AI_Output (self, other, "DIA_DJG_715_Ferros_FerrosAnySword_Blade_Yes2_01_00");	//Thanks, I owe you.
	AI_Output (self, other, "DIA_DJG_715_Ferros_FerrosAnySword_Blade_Yes2_01_01");	//In return, I'll show you a couple of tricks that will allow you to use your strength and dexterity better in combat.
	Log_CreateTopic(TOPIC_Teacher_OC,LOG_NOTE);
	B_LogEntry(TOPIC_Teacher_OC,"Feros can teach me to improve my strength and dexterity.");
	MIS_FerrosSword = LOG_SUCCESS;
	B_GivePlayerXP(XP_FerrosSword);
};

func void B_Ferros_FerrosAnySword_No()
{
	AI_Output (other, self, "DIA_DJG_715_Ferros_FerrosAnySword_Blade_No_15_00");	//No, I need it myself.
	AI_Output (self, other, "DIA_DJG_715_Ferros_FerrosAnySword_Blade_No_01_01");	//I can understand.
};

func void DIA_DJG_715_Ferros_FerrosAnySword_Silverblade_Yes()
{
	B_Ferros_FerrosAnySword_Yes1();
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItMw_1H_Special_01,1);
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	B_InspectMeleeWeapon(self);
	B_Ferros_FerrosAnySword_Yes2();
	Info_ClearChoices(DIA_DJG_715_Ferros_FerrosAnySword);
};

func void DIA_DJG_715_Ferros_FerrosAnySword_Silverblade_No()
{
	B_Ferros_FerrosAnySword_No();
	Info_ClearChoices(DIA_DJG_715_Ferros_FerrosAnySword);
};

func void DIA_DJG_715_Ferros_FerrosAnySword_Oreblade_Yes()
{
	B_Ferros_FerrosAnySword_Yes1();
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItMw_1H_Special_02,1);
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	B_InspectMeleeWeapon(self);
	B_Ferros_FerrosAnySword_Yes2();
	Info_ClearChoices(DIA_DJG_715_Ferros_FerrosAnySword);
};

func void DIA_DJG_715_Ferros_FerrosAnySword_Oreblade_No()
{
	B_Ferros_FerrosAnySword_No();
	Info_ClearChoices(DIA_DJG_715_Ferros_FerrosAnySword);
};


instance DIA_DJG_715_Ferros_FerrosHisSword(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 6;
	condition = DIA_DJG_715_Ferros_FerrosHisSword_Condition;
	information = DIA_DJG_715_Ferros_FerrosHisSword_Info;
	permanent = FALSE;
	description = "I found your sword.";
};


func int DIA_DJG_715_Ferros_FerrosHisSword_Condition()
{
	if((MIS_FerrosSword == LOG_Running) && Npc_HasItems(other,ItMW_1H_FerrosSword_Mis))
	{
		return TRUE;
	};
};

func void DIA_DJG_715_Ferros_FerrosHisSword_Info()
{
	AI_Output(other,self,"DIA_DJG_715_Ferros_FerrosHisSword_15_00");	//I found your sword.
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItMW_1H_FerrosSword_Mis,1);
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	B_InspectMeleeWeapon(self);
	B_Ferros_FerrosAnySword_Yes2();
};


func void B_BuildLearnDialog_Ferros()
{
	Info_ClearChoices(DIA_Ferros_Teach);
	Info_AddChoice(DIA_Ferros_Teach,Dialog_Back,DIA_Ferros_Teach_Back);
	Info_AddChoice(DIA_Ferros_Teach,B_BuildLearnString(PRINT_LearnSTR1,B_GetLearnCostAttribute(other,ATR_STRENGTH)),DIA_Ferros_Teach_STR_1);
	Info_AddChoice(DIA_Ferros_Teach,B_BuildLearnString(PRINT_LearnSTR5,B_GetLearnCostAttribute(other,ATR_STRENGTH) * 5),DIA_Ferros_Teach_STR_5);
	Info_AddChoice(DIA_Ferros_Teach,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_Ferros_Teach_DEX_1);
	Info_AddChoice(DIA_Ferros_Teach,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_Ferros_Teach_DEX_5);
};

instance DIA_Ferros_Teach(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 1;
	condition = DIA_Ferros_Teach_Condition;
	information = DIA_Ferros_Teach_Info;
	permanent = TRUE;
	description = "Show me how to improve my abilities.";
};


func int DIA_Ferros_Teach_Condition()
{
	if(MIS_FerrosSword == LOG_SUCCESS)
	{
		return TRUE;
	};
};

func void DIA_Ferros_Teach_Info()
{
	AI_Output (other, self, "DIA_Ferros_Teach_15_00");	//Show me how to improve my abilities.
	if (MIS_OCGateOpen == TRUE)
	{
		AI_Output (self, other, "DIA_Ferros_Teach_01_01");	//After these orc attacks, I quit. I'm just glad to still be alive, man.
	}
	else
	{
		AI_Output(self,other,"DIA_Ferros_Teach_01_02");	//A good fighter has to learn to transfer his abilities directly to his weapon.
		B_BuildLearnDialog_Ferros();
	};
};

func void DIA_Ferros_Teach_Back()
{
	Info_ClearChoices(DIA_Ferros_Teach);
};

func void DIA_Ferros_Teach_STR_1()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,1,T_MED))
	{
		B_BuildLearnDialog_Ferros();
	};
};

func void DIA_Ferros_Teach_STR_5()
{
	if(B_TeachAttributePoints(self,other,ATR_STRENGTH,5,T_MED))
	{
		B_BuildLearnDialog_Ferros();
	};
};

func void DIA_Ferros_Teach_DEX_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MED))
	{
		B_BuildLearnDialog_Ferros();
	};
};

func void DIA_Ferros_Teach_DEX_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MED))
	{
		B_BuildLearnDialog_Ferros();
	};
};

instance DIA_Ferros_AllDragonsDead(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 5;
	condition = DIA_Ferros_AllDragonsDead_Condition;
	information = DIA_Ferros_AllDragonsDead_Info;
	permanent = FALSE;
	description = "All the dragons are dead.";
};


func int DIA_Ferros_AllDragonsDead_Condition()
{
	if(MIS_AllDragonsDead == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Ferros_AllDragonsDead_Info()
{
	AI_Output (other, self, "DIA_Ferros_AllDragonsDead_15_00");	//All the dragons are dead.
	AI_Output (self, other, "DIA_Ferros_AllDragonsDead_01_01");	//Well done! If we had more people like you, then it would probably never have gone this far.
};


instance DIA_Ferros_PICKPOCKET(C_Info)
{
	npc = DJG_715_Ferros;
	nr = 900;
	condition = DIA_Ferros_PICKPOCKET_Condition;
	information = DIA_Ferros_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Ferros_PICKPOCKET_Condition()
{
	return C_Beklauen(56,75);
};

func void DIA_Ferros_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Ferros_PICKPOCKET);
	Info_AddChoice(DIA_Ferros_PICKPOCKET,Dialog_Back,DIA_Ferros_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Ferros_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Ferros_PICKPOCKET_DoIt);
};

func void DIA_Ferros_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Ferros_PICKPOCKET);
};

func void DIA_Ferros_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Ferros_PICKPOCKET);
};

