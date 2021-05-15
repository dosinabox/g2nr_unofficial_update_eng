
instance DIA_Pedro_EXIT(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 999;
	condition = DIA_Pedro_EXIT_Condition;
	information = DIA_Pedro_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Pedro_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Pedro_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Pedro_WELCOME(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 1;
	condition = DIA_Pedro_WELCOME_Condition;
	information = DIA_Pedro_WELCOME_Info;
	important = TRUE;
};


func int DIA_Pedro_WELCOME_Condition()
{
	return TRUE;
};

func void DIA_Pedro_WELCOME_Info()
{
	AI_Output (self, other, "DIA_Pedro_WELCOME_09_00");	//Welcome to the monastery of Innos, stranger.
	AI_Output (self, other, "DIA_Pedro_WELCOME_09_01");	//I am Brother Pedro, a humble servant of Innos and the warder of the gate to the holy monastery.
	AI_Output (self, other, "DIA_Pedro_WELCOME_09_02");	//What is it that you require?
};


instance DIA_Pedro_Wurst(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 2;
	condition = DIA_Pedro_Wurst_Condition;
	information = DIA_Pedro_Wurst_Info;
	permanent = FALSE;
	description = "Here, have a sausage, Brother!";
};


func int DIA_Pedro_Wurst_Condition()
{
	if(C_CanFeedNOV(self))
	{
		return TRUE;
	};
};

func void DIA_Pedro_Wurst_Info()
{
	AI_Output (other, self, "DIA_Pedro_Wurst_15_00");	//Here, have a sausage, Brother!
	AI_Output (self, other, "DIA_Pedro_Wurst_09_01");	//Good of you to think of me. Usually, I am forgotten.
	B_FeedNOV(self);
	AI_Output (self, other, "DIA_Pedro_Wurst_09_02");	//You could let me have another sausage.
	AI_Output (other, self, "DIA_Pedro_Wurst_15_03");	//Forget it, I won't have enough then.
	AI_Output (self, other, "DIA_Pedro_Wurst_09_04");	//Hey, one sausage - nobody will notice that. You'll get something for it - I know a place where some fire nettles grow.
	AI_Output (self, other, "DIA_Pedro_Wurst_09_05");	//If you take them to Neoras, he'll surely give you the key to the library. What do you say?
	Info_ClearChoices(DIA_Pedro_Wurst);
	if(Npc_HasItems(other,ItFo_Schafswurst))
	{
		Info_AddChoice(DIA_Pedro_Wurst,"OK, have another sausage.",DIA_Pedro_Wurst_JA);
	};
	Info_AddChoice(DIA_Pedro_Wurst,"No, forget it.",DIA_Pedro_Wurst_NEIN);
};

func void DIA_Pedro_Wurst_JA()
{
	AI_Output(other,self,"DIA_Pedro_Wurst_JA_15_00");	//Okay, have another sausage.
	B_GiveInvItems(other,self,ItFo_Schafswurst,1);
	AI_Output(self,other,"DIA_Pedro_Wurst_JA_09_01");	//All right. Some fire nettles are growing to the left and right on the other side of the bridge.
	if(C_WorldIsFixed(NEWWORLD_ZEN))
	{
		Wld_InsertItem(ItPl_Mana_Herb_01,"FP_ITEM_KLOSTER_HERB_01");
	};
	Info_ClearChoices(DIA_Pedro_Wurst);
};

func void DIA_Pedro_Wurst_NEIN()
{
	AI_Output (other, self, "DIA_Pedro_Wurst_NEIN_15_00");	//No, forget it.
	AI_Output (self, other, "DIA_Pedro_Wurst_NEIN_09_01");	//You want to get in good with Gorax, huh? It's always the same with the new novices ...
	Info_ClearChoices (DIA_Pedro_Wurst);
};


instance DIA_Pedro_EINLASS(C_Info)
{
	npc = NOV_600_Pedro;
	condition = DIA_Pedro_EINLASS_Condition;
	information = DIA_Pedro_EINLASS_Info;
	permanent = FALSE;
	description = "I want to enter the monastery.";
};


func int DIA_Pedro_EINLASS_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Pedro_WELCOME))
	{
		return TRUE;
	};
};

func void DIA_Pedro_EINLASS_Info()
{
	AI_Output (other, self, "DIA_Pedro_EINLASS_15_00");	//I want to enter the monastery.
	AI_Output (self, other, "DIA_Pedro_EINLASS_09_01");	//Only the servants of Innos are allowed to enter the monastery.
	AI_Output (self, other, "DIA_Pedro_EINLASS_09_02");	//If you want to pray to Innos, go find one of the roadside shrines. You will find the tranquility to pray there.
};


instance DIA_Pedro_TEMPEL(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 2;
	condition = DIA_Pedro_TEMPEL_Condition;
	information = DIA_Pedro_TEMPEL_Info;
	permanent = FALSE;
	description = "What do I have to do to be accepted in the monastery?";
};


func int DIA_Pedro_TEMPEL_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Pedro_EINLASS) && (other.guild != GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Pedro_TEMPEL_Info()
{
	AI_Output (other, self, "DIA_Pedro_TEMPEL_15_00");	//What do I have to do to be accepted in the monastery?
	if (other.guild != GIL_NONE)
	{
		AI_Output (self, other, "DIA_Pedro_TEMPEL_09_01");	//Acceptance into the monastery is denied to you - you have already chosen a path.
	}
	else
	{
		AI_Output(self,other,"DIA_Pedro_TEMPEL_09_02");	//If you want to be accepted into the Brotherhood of Innos, you must learn and obey the rules of the monastery.
		if(Pedro_NOV_Aufnahme_LostInnosStatue_Daron == FALSE)
		{
			AI_Output (self, other, "DIA_ADDON_Pedro_TEMPEL_09_03");	//Also, we demand the gifts to Innos from each new novice.
			AI_Output (self, other, "DIA_ADDON_Pedro_TEMPEL_09_04");	//A sheep and 1000 gold pieces.
				AI_Output (other, self, "DIA_Pedro_TEMPEL_15_04");	//That's a whole lot of gold.
		AI_Output (self, other, "DIA_Pedro_TEMPEL_09_05");	//It is a sign that you are beginning a new life as a servant of Innos. When you are accepted you will be forgiven all your previous transgressions.
			if(SC_KnowsKlosterTribut == FALSE)
			{
				SC_KnowsKlosterTribut = TRUE;
				Log_CreateTopic(Topic_Kloster,LOG_MISSION);
				Log_SetTopicStatus(Topic_Kloster,LOG_Running);
				B_LogEntry(Topic_Kloster,"To become a novice at the monastery of Innos, I need a sheep and 1000 gold.");
			};
		};
		AI_Output(self,other,"DIA_Pedro_TEMPEL_09_06");	//And consider - you cannot take back the decision to become a servant of Innos.
	};
};


func void B_GiveLostStatueToPedro()
{
	AI_Output(other,self,"DIA_Addon_Pedro_Statuette_Abgeben_15_00");	//Can I just hand the statuette over to you?
	AI_Output(self,other,"DIA_Addon_Pedro_Statuette_Abgeben_09_01");	//Of course, I shall take care of it. Thank you for this unselfish deed.
	B_GiveInvItems(other,self,ItMi_LostInnosStatue_Daron,1);
	Npc_RemoveInvItem(self,ItMi_LostInnosStatue_Daron);
	PedroGotLostInnosStatue = TRUE;
	LostInnosStatueInMonastery = TRUE;
	MIS_Addon_Daron_GetStatue = LOG_SUCCESS;
	B_GivePlayerXP(XP_Addon_ReportLostInnosStatue2Daron);
};

instance DIA_Addon_Pedro_Statuette(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 2;
	condition = DIA_Addon_Pedro_Statuette_Condition;
	information = DIA_Addon_Pedro_Statuette_Info;
	permanent = FALSE;
	description = "I've got this statuette...";
};


func int DIA_Addon_Pedro_Statuette_Condition()
{
	if(Npc_HasItems(other,ItMi_LostInnosStatue_Daron) && (MIS_Addon_Daron_GetStatue == LOG_Running))
	{
		return TRUE;
	};
};

func void DIA_Addon_Pedro_Statuette_Info()
{
	AI_Output(other,self,"DIA_Addon_Pedro_Statuette_15_00");	//I've got this statuette here. I think they're missing it in the monastery.
	if(Npc_KnowsInfo(other,DIA_Pedro_TEMPEL) && (other.guild != GIL_NOV) && (other.guild != GIL_KDF))
	{
		AI_Output(other,self,"DIA_Addon_Pedro_Statuette_15_01");	///Can I come in now?
	};
	if((other.guild == GIL_NONE) || ((other.guild == GIL_NOV) && (DIA_Gorax_GOLD_perm == FALSE)))
	{
		AI_Output(self,other,"DIA_Addon_Pedro_Statuette_09_02");	//Well, under these truly exceptional circumstances you are free to become a novice.
		Pedro_NOV_Aufnahme_LostInnosStatue_Daron = TRUE;
		B_LogEntry(TOPIC_Addon_RangerHelpKDF,TOPIC_Addon_PedroPass);
	}
	else if((other.guild != GIL_NOV) && (other.guild != GIL_KDF))
	{
		AI_Output(self,other,"DIA_Addon_Pedro_Statuette_09_03");	//I can't let you in even with this precious gem, I'm afraid.
		AI_Output(self,other,"DIA_Addon_Pedro_Statuette_09_04");	//You have already decided upon a different path. The way into the monastery is closed to you.
	}
	else
	{
		B_Say(self,other,"$ABS_GOOD");
		B_GiveLostStatueToPedro();
	};
};


instance DIA_Addon_Pedro_Statuette_Abgeben(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 2;
	condition = DIA_Addon_Pedro_Statuette_Abgeben_Condition;
	information = DIA_Addon_Pedro_Statuette_Abgeben_Info;
	permanent = FALSE;
	description = "Can I just hand the statuette over to you?";
};


func int DIA_Addon_Pedro_Statuette_Abgeben_Condition()
{
	if(Npc_HasItems(other,ItMi_LostInnosStatue_Daron) && Npc_KnowsInfo(other,DIA_Addon_Pedro_Statuette) && (LostInnosStatueInMonastery == FALSE))
	{
		if((hero.guild != GIL_NONE) && (hero.guild != GIL_NOV) && (hero.guild != GIL_KDF))
		{
			return TRUE;
		};
	};
};

func void DIA_Addon_Pedro_Statuette_Abgeben_Info()
{
	B_GiveLostStatueToPedro();
};


instance DIA_Pedro_Rules(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 2;
	condition = DIA_Pedro_Rules_Condition;
	information = DIA_Pedro_Rules_Info;
	permanent = FALSE;
	description = "What are the rules you live by?";
};


func int DIA_Pedro_Rules_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Pedro_TEMPEL))
	{
		return TRUE;
	};
};

func void DIA_Pedro_Rules_Info()
{
	AI_Output (other, self, "DIA_Pedro_Rules_15_00");	//What are the rules you live by?
	AI_Output (self, other, "DIA_Pedro_Rules_09_01");	//Innos is the god of truth and law and thus we may NEVER lie or commit a crime.
	AI_Output (self, other, "DIA_Pedro_Rules_09_02");	//Should you transgress against a brother of the community or steal our property, you will pay a penalty for it.
	AI_Output (self, other, "DIA_Pedro_Rules_09_03");	//Innos is also the god of rule and fire.
	AI_Output (self, other, "DIA_Pedro_Rules_09_04");	//As a novice you must show OBEDIENCE and RESPECT to all Magicians of Fire.
	AI_Output (other, self, "DIA_Pedro_Rules_15_05");	//I see.
	AI_Output (self, other, "DIA_Pedro_Rules_09_06");	//Furthermore, it is the DUTY of a novice to carry out all the work in the monastery for the good of the community.
	if (hero.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Pedro_Rules_09_07");	//If you are prepared to follow these rules and have the offering to Innos, we are willing to accept you into our monastery as a novice.
	};
};


instance DIA_Pedro_AUFNAHME(C_Info)
{
	npc = NOV_600_Pedro;
	condition = DIA_Pedro_AUFNAHME_Condition;
	information = DIA_Pedro_AUFNAHME_Info;
	permanent = TRUE;
	description = "I want to become a novice.";
};


var int DIA_Pedro_AUFNAHME_NOPERM;

func int DIA_Pedro_AUFNAHME_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Pedro_Rules) && (DIA_Pedro_AUFNAHME_NOPERM == FALSE))
	{
		return TRUE;
	};
};

func void B_DIA_Pedro_AUFNAHME_Choice()
{
	Info_ClearChoices (DIA_Pedro_AUFNAHME);
	Info_AddChoice (DIA_Pedro_AUFNAHME, "I'll think about it some more.", DIA_Pedro_AUFNAHME_NO);
	Info_AddChoice (DIA_Pedro_AUFNAHME, "Yes, I want to dedicate my life to the service of Innos.", DIA_Pedro_AUFNAHME_YES);
};

func void DIA_Pedro_AUFNAHME_Info()
{
	AI_Output (other, self, "DIA_Pedro_AUFNAHME_15_00");	//I want to become a novice.
	Npc_PerceiveAll (self);
	if (hero.guild != GIL_NONE)
	{
		AI_Output (self, other, "DIA_Pedro_AUFNAHME_09_01");	//You have already chosen your path. The path of magic is closed to you.
		DIA_Pedro_AUFNAHME_NOPERM = TRUE;
	}
	else if(Npc_KnowsInfo(other,DIA_Addon_Pedro_Statuette))
	{
		AI_Output (self, other, "DIA_Addon_Pedro_AUFNAHME_09_02");	//Is that really what you wish to do? For you must know that there will be no turning back for you then.
		B_DIA_Pedro_AUFNAHME_Choice ();
	}
	else if((Npc_HasItems(hero,ItMi_Gold) >= Summe_Kloster) && Wld_DetectNpc(self,Follow_Sheep,NOFUNC,-1) && (Npc_GetDistToNpc(self,other) < 1000))
	{
		AI_Output (self, hero, "DIA_Pedro_AUFNAHME_09_03");	//I see that you have brought the required offering. If you are truly willing, you are now free to become a novice.
		AI_Output (self, hero, "DIA_Pedro_AUFNAHME_09_04");	//However, if you make this decision there is no going back - consider well if this is your path!
		B_DIA_Pedro_AUFNAHME_Choice ();
	}
	else
	{
		AI_Output (self, other, "DIA_Pedro_AUFNAHME_09_02");	//You did not bring the required offering with you.
	};
};

func void DIA_Pedro_AUFNAHME_YES()
{
	AI_Output (other, self, "DIA_Pedro_AUFNAHME_YES_15_00");	//Yes, I want to dedicate my life to the service of Innos.
	AI_Output (self, other, "DIA_Pedro_AUFNAHME_YES_09_01");	//Then be welcome, Brother. I give to you the key to the monastery gate.
	CreateInvItems(self,ItKe_Innos_MIS,1);
	B_GiveInvItems(self,other,ItKe_Innos_MIS,1);
	if(Npc_HasItems(Gorax,ItKe_Innos_MIS))
	{
		Npc_RemoveInvItem(Gorax,ItKe_Innos_MIS);
	};
	AI_Output (self, other, "DIA_Pedro_AUFNAHME_YES_09_02");	//As a sign of your free decision, it is up to you to open the gate and step through.
	AI_Output (self, other, "DIA_Pedro_AUFNAHME_YES_09_03");	//You are now a novice. Wear this robe as a sign that you are now a member of this brotherhood.
	B_SetGuild(hero,GIL_NOV);
	B_GiveArmor(ITAR_NOV_L);
	AI_Output (self, other, "DIA_Pedro_AUFNAHME_YES_09_04");	//When you are in the monastery, go to Parlan. He'll see to your needs from now on.
	AI_Output (other, self, "DIA_Pedro_AUFNAHME_YES_15_05");	//Will my transgressions be forgiven now?
	AI_Output (self, other, "DIA_Pedro_AUFNAHME_YES_09_06");	//Not yet. Speak to Master Parlan. He will bless you and wash you clean of your sins.
	DIA_Pedro_AUFNAHME_NOPERM = TRUE;
	NOV_Aufnahme = LOG_SUCCESS;
	SLD_Aufnahme = LOG_OBSOLETE;
	MIL_Aufnahme = LOG_OBSOLETE;
	B_GivePlayerXP(XP_AufnahmeNovize);
	if(Npc_KnowsInfo(other,DIA_Addon_Pedro_Statuette))
	{
		Pedro_NOV_Aufnahme_LostInnosStatue_Daron = TRUE;
		Liesel_Giveaway = LOG_OBSOLETE;
	};
	if(MIS_Addon_Daron_GetStatue == LOG_Running)
	{
		Log_CreateTopic(TOPIC_Addon_HelpDaron,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_Addon_HelpDaron,LOG_Running);
		Log_AddEntry(TOPIC_Addon_HelpDaron,TOPIC_Addon_DaronGobbos);
		Log_AddEntry(TOPIC_Addon_HelpDaron,TOPIC_Addon_PedroPass);
	};
	AI_StopProcessInfos(self);
};

func void DIA_Pedro_AUFNAHME_NO()
{
	AI_Output (other, self, "DIA_Pedro_AUFNAHME_NO_15_00");	//I'll think about it some more.
	AI_Output (self, other, "DIA_Pedro_AUFNAHME_NO_09_01");	//Come back when you are ready.
	Info_ClearChoices (DIA_Pedro_AUFNAHME);
};


instance DIA_Pedro_Monastery(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 90;
	condition = DIA_Pedro_Monastery_Condition;
	information = DIA_Pedro_Monastery_Info;
	permanent = TRUE;
	description = "Tell me about life in the monastery.";
};


func int DIA_Pedro_Monastery_Condition()
{
	if(other.guild != GIL_KDF)
	{
		return TRUE;
	};
};

func void DIA_Pedro_Monastery_Info()
{
	AI_Output (other, self, "DIA_Pedro_Monastery_15_00");	//Tell me about life in the monastery.
	AI_Output (self, other, "DIA_Pedro_Monastery_09_01");	//We live in the monastery in order to serve Innos. We novices perform the work and study the scriptures when we have the opportunity.
	AI_Output (self, other, "DIA_Pedro_Monastery_09_02");	//The magicians watch over us, and they explore the arts of magic.
};


instance DIA_Pedro_PICKPOCKET(C_Info)
{
	npc = NOV_600_Pedro;
	nr = 900;
	condition = DIA_Pedro_PICKPOCKET_Condition;
	information = DIA_Pedro_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Pedro_PICKPOCKET_Condition()
{
	return C_Beklauen(45,60);
};

func void DIA_Pedro_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Pedro_PICKPOCKET);
	Info_AddChoice(DIA_Pedro_PICKPOCKET,Dialog_Back,DIA_Pedro_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Pedro_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Pedro_PICKPOCKET_DoIt);
};

func void DIA_Pedro_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Pedro_PICKPOCKET);
};

func void DIA_Pedro_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Pedro_PICKPOCKET);
};

