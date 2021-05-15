
instance DIA_Keroloth_EXIT(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 999;
	condition = DIA_Keroloth_EXIT_Condition;
	information = DIA_Keroloth_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Keroloth_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Keroloth_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


func void B_Keroloth_GetLost()
{
	AI_Output(self,other,"DIA_Keroloth_KAP4_ENTSPANNDICH_07_05");	//Don't push me, boy! Clear off!
	AI_StopProcessInfos(self);
};

instance DIA_Keroloth_HELLO(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 2;
	condition = DIA_Keroloth_HELLO_Condition;
	information = DIA_Keroloth_HELLO_Info;
	permanent = FALSE;
	description = "You train people?";
};


func int DIA_Keroloth_HELLO_Condition()
{
	return TRUE;
};

func void DIA_Keroloth_HELLO_Info()
{
	AI_Output (other, self, "DIA_Keroloth_HELLO_15_00");	//You train people?
	AI_Output (self, other, "DIA_Keroloth_HELLO_07_01");	//Yes. Once those orcs or, even worse, the dragons attack again, every single hand will be needed.
};


instance DIA_Keroloth_WantTeach(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 3;
	condition = DIA_Keroloth_WantTeach_Condition;
	information = DIA_Keroloth_WantTeach_Info;
	permanent = FALSE;
	description = "Can you train me, too?";
};


func int DIA_Keroloth_WantTeach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Keroloth_HELLO))
	{
		return TRUE;
	};
};

func void DIA_Keroloth_WantTeach_Info()
{
	AI_Output(other,self,"DIA_Keroloth_WantTeach_15_00");	//Can you train me, too?
	if(Keroloths_BeutelLeer == FALSE)
	{
		AI_Output (self, other, "DIA_Keroloth_WantTeach_07_01");	//Sure. I'll train any good man.
		AI_Output (self, other, "DIA_Keroloth_WantTeach_07_02");	//But besides your talent, you need a good weapon if you want to survive here.
		AI_Output (self, other, "DIA_Keroloth_WantTeach_07_03");	//Ask the knight Tandor. He'll take care of you.
		Keroloth_TeachPlayer = TRUE;
		if(!Npc_KnowsInfo(other,DIA_Sengrath_Perm) && !Npc_KnowsInfo(other,DIA_Garond_Equipment) && !Npc_KnowsInfo(other,DIA_Tandor_Hallo) && !Npc_KnowsInfo(other,DIA_Dobar_Waffe))
		{
			Log_CreateTopic(TOPIC_Teacher_OC,LOG_NOTE);
			B_LogEntries(TOPIC_Teacher_OC,"Keroloth trains swordfighters at the castle.");
			Log_CreateTopic(TOPIC_Trader_OC,LOG_NOTE);
			B_LogNextEntry(TOPIC_Trader_OC,"Tandor trades in weapons at the castle.");
		}
		else
		{
			if(!Npc_KnowsInfo(other,DIA_Sengrath_Perm))
			{
				Log_CreateTopic(TOPIC_Teacher_OC,LOG_NOTE);
				B_LogEntry(TOPIC_Teacher_OC,"Keroloth trains swordfighters at the castle.");
			};
			if(!Npc_KnowsInfo(other,DIA_Garond_Equipment) && !Npc_KnowsInfo(other,DIA_Tandor_Hallo) && !Npc_KnowsInfo(other,DIA_Dobar_Waffe))
			{
				Log_CreateTopic(TOPIC_Trader_OC,LOG_NOTE);
				B_LogEntry(TOPIC_Trader_OC,"Tandor trades in weapons at the castle.");
			};
		};
	}
	else
	{
		B_Keroloth_GetLost();
	};
};


var int DIA_Keroloth_Teacher_permanent;
var int DIA_Keroloth_TeachState_1H;
var int DIA_Keroloth_TeachState_2H;

func void B_Keroloth_TeachNoMore()
{
	AI_Output(self,other,"B_Keroloth_TeachNoMore2_07_00");	//Only a trained swordmaster can help you now.
};

func void B_BuildLearnDialog_Keroloth()
{
	Info_ClearChoices(DIA_Keroloth_Teacher);
	Info_AddChoice(DIA_Keroloth_Teacher,Dialog_Back,DIA_Keroloth_Teacher_Back);
	if(VisibleTalentValue(NPC_TALENT_2H) < TeachLimit_2H_Keroloth)
	{
		Info_AddChoice(DIA_Keroloth_Teacher,B_BuildLearnString(PRINT_Learn2h1,B_GetLearnCostTalent(other,NPC_TALENT_2H,1)),DIA_Keroloth_Teacher_2H_1);
		Info_AddChoice(DIA_Keroloth_Teacher,B_BuildLearnString(PRINT_Learn2h5,B_GetLearnCostTalent(other,NPC_TALENT_2H,5)),DIA_Keroloth_Teacher_2H_5);
		DIA_Keroloth_TeachState_2H = 1;
	}
	else
	{
		if(DIA_Keroloth_TeachState_2H != 2)
		{
			if((VisibleTalentValue(NPC_TALENT_2H) < 100) && (DIA_Keroloth_TeachState_1H != 2))
			{
				if(DIA_Keroloth_TeachState_2H != 0)
				{
					PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_2H_Keroloth)),-1,53,FONT_Screen,2);
					B_Keroloth_TeachNoMore();
				};
			};
		};
		DIA_Keroloth_TeachState_2H = 2;
	};
	if(VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Keroloth)
	{
		Info_AddChoice(DIA_Keroloth_Teacher,B_BuildLearnString(PRINT_Learn1h1,B_GetLearnCostTalent(other,NPC_TALENT_1H,1)),DIA_Keroloth_Teacher_1H_1);
		Info_AddChoice(DIA_Keroloth_Teacher,B_BuildLearnString(PRINT_Learn1h5,B_GetLearnCostTalent(other,NPC_TALENT_1H,5)),DIA_Keroloth_Teacher_1H_5);
		DIA_Keroloth_TeachState_1H = 1;
	}
	else
	{
		if(DIA_Keroloth_TeachState_1H != 2)
		{
			if((VisibleTalentValue(NPC_TALENT_1H) < 100) && (DIA_Keroloth_TeachState_2H != 2))
			{
				if(DIA_Keroloth_TeachState_1H != 0)
				{
					PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_1H_Keroloth)),-1,53,FONT_Screen,2);
					B_Keroloth_TeachNoMore();
				};
			};
		};
		DIA_Keroloth_TeachState_1H = 2;
	};
	if((RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Keroloth) && (RealTalentValue(NPC_TALENT_2H) >= TeachLimit_2H_Keroloth))
	{
		DIA_Keroloth_Teacher_permanent = TRUE;
	};
	if((DIA_Keroloth_TeachState_1H == 2) && (DIA_Keroloth_TeachState_2H == 2))
	{
		PrintScreen(PRINT_NoLearnTotalMAXReached,-1,53,FONT_Screen,2);
		AI_Output(self,other,"B_Keroloth_TeachNoMore1_07_00");	//You are very good. There's nothing I can still teach you.
		AI_StopProcessInfos(self);
	};
};

instance DIA_Keroloth_Teacher(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 99;
	condition = DIA_Keroloth_Teacher_Condition;
	information = DIA_Keroloth_Teacher_Info;
	permanent = TRUE;
	description = "(Learn two-handed combat)";
};


func int DIA_Keroloth_Teacher_Condition()
{
	if((Keroloth_TeachPlayer == TRUE) && (DIA_Keroloth_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Keroloth_Teacher_Info()
{
	AI_Output(other,self,"DIA_Keroloth_Teacher_15_00");	//Let's begin.
	if(Keroloths_BeutelLeer == FALSE)
	{
		B_BuildLearnDialog_Keroloth();
	}
	else
	{
		B_Keroloth_GetLost();
	};
};

func void DIA_Keroloth_Teacher_Back()
{
	Info_ClearChoices(DIA_Keroloth_Teacher);
};

func void DIA_Keroloth_Teacher_1H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,1,TeachLimit_1H_Keroloth))
	{
		B_BuildLearnDialog_Keroloth();
	};
};

func void DIA_Keroloth_Teacher_1H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,5,TeachLimit_1H_Keroloth))
	{
		B_BuildLearnDialog_Keroloth();
	};
};

func void DIA_Keroloth_Teacher_2H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,1,TeachLimit_2H_Keroloth))
	{
		B_BuildLearnDialog_Keroloth();
	};
};

func void DIA_Keroloth_Teacher_2H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_2H,5,TeachLimit_2H_Keroloth))
	{
		B_BuildLearnDialog_Keroloth();
	};
};

instance DIA_Keroloth_Udar(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 4;
	condition = DIA_Keroloth_Udar_Condition;
	information = DIA_Keroloth_Udar_Info;
	permanent = FALSE;
	description = "What about long-range combat?";
};


func int DIA_Keroloth_Udar_Condition()
{
	if(Keroloth_TeachPlayer == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Keroloth_Udar_Info()
{
	AI_Output(other,self,"DIA_Keroloth_Udar_15_00");	//What about long-range combat?
	if(Keroloths_BeutelLeer == FALSE)
	{
		AI_Output (self, other, "DIA_Keroloth_Udar_07_01");	//What about it?
		AI_Output (other, self, "DIA_Keroloth_Udar_15_02");	//Can you teach me that, too?
		AI_Output (self, other, "DIA_Keroloth_Udar_07_03");	//No, but you can ask Udar, he's a good - no, he is the BEST crossbowman I know.
		Log_CreateTopic(TOPIC_Teacher_OC,LOG_NOTE);
		B_LogEntry(TOPIC_Teacher_OC,"Udar, from the castle in the Valley of Mines, knows all about crossbows.");
	}
	else
	{
		B_Keroloth_GetLost();
	};
};


instance DIA_Keroloth_KAP4_HELLO(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 40;
	condition = DIA_Keroloth_KAP4_HELLO_Condition;
	information = DIA_Keroloth_KAP4_HELLO_Info;
	description = "You're pulling such a long face.";
};


func int DIA_Keroloth_KAP4_HELLO_Condition()
{
	if(Kapitel >= 4)
	{
		return TRUE;
	};
};

func void DIA_Keroloth_KAP4_HELLO_Info()
{
	DIA_Common_YouLookSoSad();
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_07_01");	//(agitated) Damn it to hell. I tell you, you have to watch like a hawk.
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_07_02");	//If you turn your back for a moment, all your stuff is gone. Dirty scum!
//	Info_AddChoice(DIA_Keroloth_KAP4_HELLO,Dialog_Back,DIA_Keroloth_KAP4_HELLO_ende);
	Info_ClearChoices(DIA_Keroloth_KAP4_HELLO);
	Info_AddChoice(DIA_Keroloth_KAP4_HELLO,"A paladin shouldn't lose his temper like that.",DIA_Keroloth_KAP4_HELLO_ruhig);
	Info_AddChoice(DIA_Keroloth_KAP4_HELLO,"Did someone steal from you?",DIA_Keroloth_KAP4_HELLO_bestohlen);
	Info_AddChoice(DIA_Keroloth_KAP4_HELLO,"What scum?",DIA_Keroloth_KAP4_HELLO_pack);
};


func void DIA_Keroloth_KAP4_HELLO_ende()
{
	DIA_Common_IHaveToGo_v2();
	AI_Output(self,other,"DIA_Keroloth_KAP4_HELLO_bestohlen_wasfehlt_07_04");	//When I get my hands on him...
	Info_ClearChoices(DIA_Keroloth_KAP4_HELLO);
};

func void DIA_Keroloth_KAP4_HELLO_bestohlen()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_HELLO_bestohlen_15_00");	//Did someone steal from you?
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_bestohlen_07_01");	//No. They smuggled 20 gold pieces into my pocket. Of course they stole something, you idiot!
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_bestohlen_07_02");	//I tell you, when I get my hands on the dirty swine ...
	Info_AddChoice (DIA_Keroloth_KAP4_HELLO, "So what are you missing?", DIA_Keroloth_KAP4_HELLO_bestohlen_wasfehlt);
	Info_AddChoice(DIA_Keroloth_KAP4_HELLO,Dialog_Ende_v2,DIA_Keroloth_KAP4_HELLO_ende);
};

func void DIA_Keroloth_KAP4_HELLO_bestohlen_wasfehlt()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_HELLO_bestohlen_wasfehlt_15_00");	//So what are you missing?
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_bestohlen_wasfehlt_07_01");	//My purse, with all my savings in it.
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_bestohlen_wasfehlt_07_02");	//And now it's gone!
	AI_Output (other, self, "DIA_Keroloth_KAP4_HELLO_bestohlen_wasfehlt_15_03");	//It'll turn up somewhere.
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_bestohlen_wasfehlt_07_04");	//When I get my hands on him ...
	Log_CreateTopic (TOPIC_KerolothsGeldbeutel, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_KerolothsGeldbeutel, LOG_Running);
	B_LogEntry (TOPIC_KerolothsGeldbeutel, "The paladin Keroloth is missing his purse. He claims the Dragon Hunters stole it from him.");
	Info_ClearChoices (DIA_Keroloth_KAP4_HELLO);
};

func void DIA_Keroloth_KAP4_HELLO_pack()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_HELLO_pack_15_00");	//What scum?
	if (hero.guild == GIL_DJG)
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_pack_07_01");	//You shabby dragon hunters, of course. Who else?
	}
	else
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_pack_07_02");	//Those dragon hunting riff-raff, of course. Who did you think I was talking about?
	};
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_pack_07_03");	//(to himself) You've got to watch out, I tell you.
};

func void DIA_Keroloth_KAP4_HELLO_ruhig()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_HELLO_ruhig_15_00");	//Calm down! A paladin shouldn't lose his temper like that.
	AI_Output (self, other, "DIA_Keroloth_KAP4_HELLO_ruhig_07_01");	//But I don't want to calm down. That was everything I own, damnit!
};


instance DIA_Keroloth_KAP4_GELDGEFUNDEN(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 42;
	condition = DIA_Keroloth_KAP4_GELDGEFUNDEN_Condition;
	information = DIA_Keroloth_KAP4_GELDGEFUNDEN_Info;
	description = "I think I found your purse.";
};


func int DIA_Keroloth_KAP4_GELDGEFUNDEN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Keroloth_KAP4_HELLO) && (Npc_HasItems(other,ItMi_KerolothsGeldbeutel_MIS) || Npc_HasItems(other,ItMi_KerolothsGeldbeutelLeer_MIS)))
	{
		return TRUE;
	};
};

func void DIA_Keroloth_KAP4_GELDGEFUNDEN_Info()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_GELDGEFUNDEN_15_00");	//I think I found your purse.
	TOPIC_END_KerolothsGeldbeutel = TRUE;
	B_GivePlayerXP(XP_KerolothsGeldbeutel);
	if(B_GiveInvItems(other,self,ItMi_KerolothsGeldbeutelLeer_MIS,1))
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_GELDGEFUNDEN_07_01");	//The pouch is empty. What swine did this?
		Keroloths_BeutelLeer = TRUE;
	}
	else if(B_GiveInvItems(other,self,ItMi_KerolothsGeldbeutel_MIS,1))
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_GELDGEFUNDEN_07_02");	//What? Where? What bastard did that?
	};
	if(hero.guild == GIL_DJG)
	{
		Info_AddChoice (DIA_Keroloth_KAP4_GELDGEFUNDEN, "Just a minute. What about a reward?", DIA_Keroloth_KAP4_GELDGEFUNDEN_Lohn);
	};
	Info_AddChoice (DIA_Keroloth_KAP4_GELDGEFUNDEN, "It was over there, by the smithy.", DIA_Keroloth_KAP4_GELDGEFUNDEN_Schmiede);
	Info_AddChoice (DIA_Keroloth_KAP4_GELDGEFUNDEN, "I suspect one of the dragon hunters.", DIA_Keroloth_KAP4_GELDGEFUNDEN_DJG);
	Info_AddChoice (DIA_Keroloth_KAP4_GELDGEFUNDEN, "How would I know?", DIA_Keroloth_KAP4_GELDGEFUNDEN_keineAhnung);
};

func void DIA_Keroloth_KAP4_GELDGEFUNDEN_keineAhnung()
{
	AI_Output(other,self,"DIA_Keroloth_KAP4_GELDGEFUNDEN_keineAhnung_15_00");	//How would I know?
	if(hero.guild == GIL_DJG)
	{
		AI_Output(self,other,"DIA_Keroloth_KAP4_GELDGEFUNDEN_keineAhnung_07_01");	//Are you trying to pull my leg? It was you, admit it.
		Info_ClearChoices(DIA_Keroloth_KAP4_GELDGEFUNDEN);
		Info_AddChoice(DIA_Keroloth_KAP4_GELDGEFUNDEN,"I suspect one of the dragon hunters.",DIA_Keroloth_KAP4_GELDGEFUNDEN_DJG);
		Info_AddChoice(DIA_Keroloth_KAP4_GELDGEFUNDEN,"Kiss my ass.",DIA_Keroloth_KAP4_GELDGEFUNDEN_keineAhnung_kannstmich);
	}
	else if(other.guild == GIL_PAL)
	{
		AI_Output(self,other,"DIA_CipherDJG_GOTOGETHERAGAIN_07_01");	//Just give the word!
		DIA_Common_YeahJustRelax();
		AI_Output(self,other,"DIA_Keroloth_KAP4_HELLO_ruhig_07_01");	//But I don't want to calm down. That was everything I own, damnit!
		AI_StopProcessInfos(self);
	}
	else
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_GELDGEFUNDEN_keineAhnung_07_02");	//I'll find that out yet.
		AI_StopProcessInfos (self);
	};
};

func void DIA_Keroloth_KAP4_GELDGEFUNDEN_keineAhnung_kannstmich()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_kannstmich_15_00");	//Kiss my ass.
	AI_Output (self, other, "DIA_Keroloth_KAP4_kannstmich_07_01");	//I'll teach you to steal from decent folks.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_Keroloth_KAP4_GELDGEFUNDEN_DJG()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_GELDGEFUNDEN_DJG_15_00");	//I suspect one of the dragon hunters.
	AI_Output (self, other, "DIA_Keroloth_KAP4_GELDGEFUNDEN_DJG_07_01");	//(angry) I knew it.
	if (hero.guild == GIL_DJG)
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_GELDGEFUNDEN_DJG_07_02");	//(bellows) They never should have let you into the castle.
	}
	else
	{
		AI_Output(self,other,"DIA_Keroloth_KAP4_GELDGEFUNDEN_DJG_07_02");	//(bellows) They never should have let you into the castle.
	};
	AI_StopProcessInfos(self);
	other.aivar[AIV_INVINCIBLE] = FALSE;
	if(!Npc_IsDead(Ferros) && (Npc_GetDistToNpc(self,Ferros) <= 2000))
	{
		B_Attack(self,Ferros,AR_NONE,1);
	}
	else if(!Npc_IsDead(Jan) && (Npc_GetDistToNpc(self,Jan) <= 2000))
	{
		B_Attack(self,Jan,AR_NONE,1);
	}
	else if(!Npc_IsDead(Rethon) && (Npc_GetDistToNpc(self,Rethon) <= 2000))
	{
		B_Attack(self,Rethon,AR_NONE,1);
	};
};

func void DIA_Keroloth_KAP4_GELDGEFUNDEN_Schmiede()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_GELDGEFUNDEN_Schmiede_15_00");	//Ehm. It was over there, by the smithy.
	AI_Output (self, other, "DIA_Keroloth_KAP4_GELDGEFUNDEN_Schmiede_07_01");	//Where? Near the smithy? It must have fallen out of a dragon hunter's pocket there, don't tell me otherwise.
};

func void DIA_Keroloth_KAP4_GELDGEFUNDEN_Lohn()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_GELDGEFUNDEN_Lohn_15_00");	//Just a moment. What about a reward?
	if (Keroloths_BeutelLeer == TRUE)
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_GELDGEFUNDEN_Lohn_07_01");	//That's the last straw. It's been a while since you've had a knuckle sandwich, huh?
		AI_StopProcessInfos (self);
		B_Attack (self, other, AR_NONE, 1);
	}
	else
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_GELDGEFUNDEN_Lohn_07_02");	//Arrh. All right. Here's a few coins. And now tell me, who did it?
		CreateInvItems (self, ItMi_Gold, 50);
		B_GiveInvItems (self, other, ItMi_Gold, 50);
		Keroloth_HasPayed = TRUE;
	};
};


instance DIA_Keroloth_KAP4_BELOHNUNG(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 43;
	condition = DIA_Keroloth_KAP4_BELOHNUNG_Condition;
	information = DIA_Keroloth_KAP4_BELOHNUNG_Info;
	permanent = TRUE;
	description = "I want my finder's fee for your purse.";
};


func int DIA_Keroloth_KAP4_BELOHNUNG_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Keroloth_KAP4_GELDGEFUNDEN) && (Keroloth_HasPayed == FALSE) && (hero.guild != GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Keroloth_KAP4_BELOHNUNG_Info()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_BELOHNUNG_15_00");	//I want my finder's fee for your purse.
	if ((Keroloths_BeutelLeer == TRUE) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_BELOHNUNG_07_01");	//You can have a punch in the jaw!
		AI_StopProcessInfos (self);
		B_Attack (self, other, AR_NONE, 1);
	}
	else
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_BELOHNUNG_07_02");	//Is that your biggest worry? Here's a couple of damn coins, and now beat it.
		CreateInvItems (self, ItMi_Gold, 50);
		B_GiveInvItems (self, other, ItMi_Gold, 50);
		Keroloth_HasPayed = TRUE;
	};
};


instance DIA_Keroloth_KAP4_ENTSPANNDICH(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 44;
	condition = DIA_Keroloth_KAP4_ENTSPANNDICH_Condition;
	information = DIA_Keroloth_KAP4_ENTSPANNDICH_Info;
	permanent = TRUE;
	description = "Relax.";
};


func int DIA_Keroloth_KAP4_ENTSPANNDICH_Condition()
{
	if((Npc_KnowsInfo(other,DIA_Keroloth_KAP4_GELDGEFUNDEN) && (Kapitel >= 4)) || (MIS_OCGateOpen == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Keroloth_KAP4_ENTSPANNDICH_Info()
{
	AI_Output (other, self, "DIA_Keroloth_KAP4_ENTSPANNDICH_15_00");	//Relax.
	if (hero.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_ENTSPANNDICH_07_01");	//Yes, Master. I'll try.
	}
	else if(MIS_OCGateOpen == TRUE)
	{
		AI_Output (self, other, "DIA_Keroloth_KAP4_ENTSPANNDICH_07_02");	//I can't prove it, but I think you're the traitor who opened the gate.
		AI_Output (self, other, "DIA_Keroloth_KAP4_ENTSPANNDICH_07_03");	//You'll pay for that now.
		AI_StopProcessInfos (self);
		B_Attack (self, other, AR_NONE, 1);
	}
	else
	{
		AI_Output(other,self,"DIA_Keroloth_KAP4_ENTSPANNDICH_15_04");	//You've got your purse back, haven't you?
		B_Keroloth_GetLost();
	};
};


instance DIA_Keroloth_PICKPOCKET(C_Info)
{
	npc = PAL_258_Keroloth;
	nr = 900;
	condition = DIA_Keroloth_PICKPOCKET_Condition;
	information = DIA_Keroloth_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Keroloth_PICKPOCKET_Condition()
{
	return C_Beklauen(25,45);
};

func void DIA_Keroloth_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Keroloth_PICKPOCKET);
	Info_AddChoice(DIA_Keroloth_PICKPOCKET,Dialog_Back,DIA_Keroloth_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Keroloth_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Keroloth_PICKPOCKET_DoIt);
};

func void DIA_Keroloth_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Keroloth_PICKPOCKET);
};

func void DIA_Keroloth_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Keroloth_PICKPOCKET);
};

