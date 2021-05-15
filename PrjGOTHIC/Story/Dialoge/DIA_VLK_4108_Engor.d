
instance DIA_Engor_EXIT(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 999;
	condition = DIA_Engor_EXIT_Condition;
	information = DIA_Engor_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Engor_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Engor_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Engor_HALLO(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 2;
	condition = DIA_Engor_HALLO_Condition;
	information = DIA_Engor_HALLO_Info;
	important = TRUE;
};


func int DIA_Engor_HALLO_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Engor_HALLO_Info()
{
	AI_Output (self, other, "DIA_Engor_HALLO_13_00");	//Ah, so you're the guy who made it across the pass.
	AI_Output (other, self, "DIA_Engor_HALLO_15_01");	//Yes.
	AI_Output (self, other, "DIA_Engor_HALLO_13_02");	//Great. I'm Engor - I manage this expedition.
	AI_Output (self, other, "DIA_Engor_HALLO_13_03");	//Just don't get the idea that I give anything away for free!
	AI_Output (self, other, "DIA_Engor_HALLO_13_04");	//But if there's gold in your pockets, I'm always willing to cut a little deal.
	B_EngorTradeLog();
};


instance DIA_Engor_HANDELN(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 10;
	condition = DIA_Engor_HANDELN_Condition;
	information = DIA_Engor_HANDELN_Info;
	permanent = TRUE;
	trade = TRUE;
	description = DIALOG_TRADE_v4;
};


func int DIA_Engor_HANDELN_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Engor_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Engor_HANDELN_Info()
{
	var int McBolzenAmount;
	var int McArrowAmount;
	AI_Output(other,self,"DIA_Engor_HANDELN_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
	Npc_RemoveInvItems(self,ItRw_Bolt,Npc_HasItems(self,ItRw_Bolt));
	McBolzenAmount = Kapitel * 50;
	CreateInvItems(self,ItRw_Bolt,McBolzenAmount);
	Npc_RemoveInvItems(self,ItRw_Arrow,Npc_HasItems(self,ItRw_Arrow));
	McArrowAmount = Kapitel * 50;
	CreateInvItems(self,ItRw_Arrow,McArrowAmount);
	Trade_IsActive = TRUE;
};


instance DIA_Engor_ABOUTPARLAF(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 2;
	condition = DIA_Engor_ABOUTPARLAF_Condition;
	information = DIA_Engor_ABOUTPARLAF_Info;
	description = "You're the one who deals out the rations, or so I've heard.";
};


func int DIA_Engor_ABOUTPARLAF_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Parlaf_ENGOR))
	{
		return TRUE;
	};
};

func void DIA_Engor_ABOUTPARLAF_Info()
{
	AI_Output (other, self, "DIA_Engor_ABOUTPARLAF_15_00");	//You're the one who deals out the rations, or so I've heard.
	AI_Output (self, other, "DIA_Engor_ABOUTPARLAF_13_01");	//That's right. Why? Should I feed you now, too?
	AI_Output (self, other, "DIA_Engor_ABOUTPARLAF_13_02");	//If there's anything you want, you'll pay for it - just like everyone else.
};


instance DIA_Engor_Ruestung(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 2;
	condition = DIA_Engor_Ruestung_Condition;
	information = DIA_Engor_Ruestung_Info;
	permanent = FALSE;
	description = "Have you got anything interesting for me?";
};


func int DIA_Engor_Ruestung_Condition()
{
	if(other.guild == GIL_MIL)
	{
		return TRUE;
	};
};

func void DIA_Engor_Ruestung_Info()
{
	AI_Output(other,self,"DIA_Engor_Ruestung_15_00");	//Have you got anything interesting for me?
	if(DIA_MIL_ARMOR_M_perm == FALSE)
	{
	AI_Output (self, other, "DIA_Engor_Ruestung_13_01");	//I can get you better armor - heavy militia armor, if you're interested.
	AI_Output (self, other, "DIA_Engor_Ruestung_13_02");	//It's not cheap, of course. So go get the gold, and I'll give you the armor.
	}
	else
	{
		AI_Output(self,other,"DIA_Engor_RSkaufen_13_02");	//Go get the gold first.
	};
};


instance DIA_Engor_RSkaufen(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 2;
	condition = DIA_Engor_RSkaufen_Condition;
	information = DIA_Engor_RSkaufen_Info;
	permanent = TRUE;
	description = "Buy Heavy Milita Armor (Protection: 70/70/10/10. (2500 gold)";
};


func int DIA_Engor_RSkaufen_Condition()
{
	if((other.guild == GIL_MIL) && Npc_KnowsInfo(other,DIA_Engor_Ruestung) && (DIA_MIL_ARMOR_M_perm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Engor_RSkaufen_Info()
{
	AI_Output(other,self,"DIA_Engor_RSkaufen_15_00");	//Give me the armor.
	if(B_GiveInvItems(other,self,ItMi_Gold,VALUE_ITAR_MIL_M))
	{
		AI_Output(self,other,"DIA_Engor_RSkaufen_13_01");	//Here you are, it'll protect you well - it's a damn good piece of work.
		B_GiveArmor(ITAR_MIL_M);
		DIA_MIL_ARMOR_M_perm = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Engor_RSkaufen_13_02");	//Go get the gold first.
	};
};


instance DIA_Engor_HELP(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 3;
	condition = DIA_Engor_HELP_Condition;
	information = DIA_Engor_HELP_Info;
	description = "Maybe I can help you with your work.";
};


func int DIA_Engor_HELP_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Engor_ABOUTPARLAF))
	{
		return TRUE;
	};
};

func void DIA_Engor_HELP_Info()
{
	AI_Output (other, self, "DIA_Engor_HELP_15_00");	//Maybe I can help you with your work.
	AI_Output (self, other, "DIA_Engor_HELP_13_01");	//Hmm ... Sure, why not? I could use some help.
	AI_Output (other, self, "DIA_Engor_HELP_15_02");	//So, what needs to be done?
	AI_Output (self, other, "DIA_Engor_HELP_13_03");	//Our food supplies are low. Above all, we're almost out of meat.
	AI_Output (self, other, "DIA_Engor_HELP_13_04");	//So if you could get us some meat, raw or cooked, ham or sausages, that would be much appreciated. How about it, will you help us?
	Info_ClearChoices (DIA_Engor_HELP);
	Info_AddChoice (DIA_Engor_HELP, "I've got no time for that.", DIA_Engor_HELP_NO);
	Info_AddChoice (DIA_Engor_HELP, "Don't worry, I'll get you some meat.", DIA_Engor_HELP_YES);
};

func void DIA_Engor_HELP_NO()
{
	AI_Output (other, self, "DIA_Engor_HELP_NO_15_00");	//I don't have time for that.
	AI_Output (self, other, "DIA_Engor_HELP_NO_13_01");	//So what are you wasting mine for?
	MIS_Engor_BringMeat = LOG_OBSOLETE;
	AI_StopProcessInfos(self);
};

func void DIA_Engor_HELP_YES()
{
	AI_Output (other, self, "DIA_Engor_HELP_YES_15_00");	//Don't worry, I'll get you some meat.
	AI_Output (self, other, "DIA_Engor_HELP_YES_13_01");	//About two dozen chunks of meat would help me feed quite a few hungry mouths. Come back when you have the meat. I need to get back to my work now.
	Log_CreateTopic (TOPIC_BringMeat, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_BringMeat, LOG_Running);
	B_LogEntry(TOPIC_BringMeat,"Engor needs two dozen chunks of meat to supply the men with.");
	Log_AddEntry(TOPIC_BringMeat,"It doesn't matter whether it's sausages, ham, fried meat or raw meat. Just as long as the boys get something decent to bite.");
	MIS_Engor_BringMeat = LOG_Running;
	AI_StopProcessInfos(self);
};


instance DIA_Engor_BRINGMEAT(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 4;
	condition = DIA_Engor_BRINGMEAT_Condition;
	information = DIA_Engor_BRINGMEAT_Info;
	permanent = TRUE;
	description = "Here, I bought you something (give meat).";
};


func int DIA_Engor_BRINGMEAT_Condition()
{
	if((MIS_Engor_BringMeat == LOG_Running) && (Meat_Counter < Meat_Amount) && (Npc_HasItems(hero,ItFo_Bacon) || Npc_HasItems(hero,ItFoMuttonRaw) || Npc_HasItems(hero,ItFoMutton) || Npc_HasItems(hero,ItFo_Sausage) || (Npc_HasItems(hero,ItFo_Schafswurst) && ((Kapitel > 1) || (MIS_GoraxEssen == LOG_SUCCESS)))))
	{
		return TRUE;
	};
};

func void DIA_Engor_BRINGMEAT_Info()
{
	var int info_ypos;
	var string ConcatRaw;
	var string ConcatMutton;
	var string ConcatBacon;
	var string ConcatSausage;
	var string ConcatSchafswurst;
	var string GesamtFleisch;
	var int RawCounter;
	var int MuttonCounter;
	var int BaconCounter;
	var int SausageCounter;
	var int SchafswurstCounter;
	info_ypos = 35;
	AI_Output(other,self,"DIA_Engor_BRINGMEAT_15_00");	//Here, I bought you something.
	if(Npc_HasItems(other,ItFoMuttonRaw) && (Meat_Counter < Meat_Amount))
	{
		Npc_GetInvItem(other,ItFoMuttonRaw);
		RawCounter = Meat_Amount - Meat_Counter;
		if(Npc_HasItems(other,ItFoMuttonRaw) > RawCounter)
		{
			ConcatRaw = IntToString(RawCounter);
			Meat_Counter += RawCounter;
			Npc_RemoveInvItems(other,ItFoMuttonRaw,RawCounter);
		}
		else
		{
			ConcatRaw = IntToString(Npc_HasItems(other,ItFoMuttonRaw));
			Meat_Counter += Npc_HasItems(other,ItFoMuttonRaw);
			Npc_RemoveInvItems(other,ItFoMuttonRaw,Npc_HasItems(other,ItFoMuttonRaw));
		};
		ConcatRaw = ConcatStrings(ConcatRaw," pieces of Raw Meat given");
		AI_PrintScreen(ConcatRaw,-1,info_ypos,FONT_ScreenSmall,3);
		info_ypos += 3;
	};
	if(Npc_HasItems(other,ItFoMutton) && (Meat_Counter < Meat_Amount))
	{
		Npc_GetInvItem(other,ItFoMutton);
		MuttonCounter = Meat_Amount - Meat_Counter;
		if(Npc_HasItems(other,ItFoMutton) > MuttonCounter)
		{
			ConcatMutton = IntToString(MuttonCounter);
			Meat_Counter += MuttonCounter;
			Npc_RemoveInvItems(other,ItFoMutton,MuttonCounter);
		}
		else
		{
			ConcatMutton = IntToString(Npc_HasItems(other,ItFoMutton));
			Meat_Counter += Npc_HasItems(other,ItFoMutton);
			Npc_RemoveInvItems(other,ItFoMutton,Npc_HasItems(other,ItFoMutton));
		};
		ConcatMutton = ConcatStrings(ConcatMutton," pieces of Fried Meat given");
		AI_PrintScreen(ConcatMutton,-1,info_ypos,FONT_ScreenSmall,3);
		info_ypos += 3;
	};
	if(Npc_HasItems(other,ItFo_Bacon) && (Meat_Counter < Meat_Amount))
	{
		Npc_GetInvItem(other,ItFo_Bacon);
		BaconCounter = Meat_Amount - Meat_Counter;
		if(Npc_HasItems(other,ItFo_Bacon) > BaconCounter)
		{
			ConcatBacon = IntToString(BaconCounter);
			Meat_Counter += BaconCounter;
			Npc_RemoveInvItems(other,ItFo_Bacon,BaconCounter);
		}
		else
		{
			ConcatBacon = IntToString(Npc_HasItems(other,ItFo_Bacon));
			Meat_Counter += Npc_HasItems(other,ItFo_Bacon);
			Npc_RemoveInvItems(other,ItFo_Bacon,Npc_HasItems(other,ItFo_Bacon));
		};
		ConcatBacon = ConcatStrings(ConcatBacon," hams given");
		AI_PrintScreen(ConcatBacon,-1,info_ypos,FONT_ScreenSmall,3);
		info_ypos += 3;
	};
	if(Npc_HasItems(other,ItFo_Sausage) && (Meat_Counter < Meat_Amount))
	{
		Npc_GetInvItem(other,ItFo_Sausage);
		SausageCounter = Meat_Amount - Meat_Counter;
		if(Npc_HasItems(other,ItFo_Sausage) > SausageCounter)
		{
			ConcatSausage = IntToString(SausageCounter);
			Meat_Counter += SausageCounter;
			Npc_RemoveInvItems(other,ItFo_Sausage,SausageCounter);
		}
		else
		{
			ConcatSausage = IntToString(Npc_HasItems(other,ItFo_Sausage));
			Meat_Counter += Npc_HasItems(other,ItFo_Sausage);
			Npc_RemoveInvItems(other,ItFo_Sausage,Npc_HasItems(other,ItFo_Sausage));
		};
		ConcatSausage = ConcatStrings(ConcatSausage," sausages given");
		AI_PrintScreen(ConcatSausage,-1,info_ypos,FONT_ScreenSmall,3);
		info_ypos += 3;
	};
	if(Npc_HasItems(other,ItFo_Schafswurst) && ((Kapitel > 1) || (MIS_GoraxEssen == LOG_SUCCESS)) && (Meat_Counter < Meat_Amount))
	{
		Npc_GetInvItem(other,ItFo_Schafswurst);
		SchafswurstCounter = Meat_Amount - Meat_Counter;
		if(Npc_HasItems(other,ItFo_Schafswurst) > SchafswurstCounter)
		{
			ConcatSchafswurst = IntToString(SchafswurstCounter);
			Meat_Counter += SchafswurstCounter;
			Npc_RemoveInvItems(other,ItFo_Schafswurst,SchafswurstCounter);
		}
		else
		{
			ConcatSchafswurst = IntToString(Npc_HasItems(other,ItFo_Schafswurst));
			Meat_Counter += Npc_HasItems(other,ItFo_Schafswurst);
			Npc_RemoveInvItems(other,ItFo_Schafswurst,Npc_HasItems(other,ItFo_Schafswurst));
		};
		ConcatSchafswurst = ConcatStrings(ConcatSchafswurst," sheep sausages given");
		AI_PrintScreen(ConcatSchafswurst,-1,info_ypos,FONT_ScreenSmall,3);
		info_ypos += 3;
	};
	if(Npc_HasItems(other,ItFo_NiclasBacon) && (Meat_Counter < Meat_Amount))
	{
		Meat_Counter += 1;
		Npc_RemoveInvItems(other,ItFo_NiclasBacon,1);
		AI_PrintScreen("1 нога крысокрота отдано",-1,info_ypos,FONT_ScreenSmall,3);
		info_ypos += 3;
	};
	if(Meat_Amount > Meat_Counter)
	{
		AI_Output(self,other,"DIA_Engor_BRINGMEAT_13_01");	//That's not bad for starters, but I need more.
		GesamtFleisch = IntToString(Meat_Counter);
		GesamtFleisch = ConcatStrings("Всего отдано мяса: ",GesamtFleisch);
		AI_PrintScreen(GesamtFleisch,-1,info_ypos,FONT_ScreenSmall,3);
	};
	if(Meat_Counter >= Meat_Amount)
	{
		AI_Output(self,other,"DIA_Engor_BRINGMEAT_13_02");	//Great, you brought enough meat. That'll do for a while.
		AI_Output(self,other,"DIA_Engor_BRINGMEAT_13_03");	//But don't get the idea that I'll give you anything for free now!
		MIS_Engor_BringMeat = LOG_SUCCESS;
		B_GivePlayerXP(XP_BringMeat);
		Log_AddEntry(TOPIC_BringMeat,"Engor's got the meat. He'll make sure it's shared out among the men.");
	};
};


instance DIA_Engor_Business(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 1;
	condition = DIA_Engor_Business_Condition;
	information = DIA_Engor_Business_Info;
	permanent = FALSE;
	description = "How's business?";
};


func int DIA_Engor_Business_Condition()
{
	if((Kapitel >= 4) && (MIS_Engor_BringMeat == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Engor_Business_Info()
{
	AI_Output (other, self, "DIA_Engor_Business_15_00");	//How's business?
	if ((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL) || (hero.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Engor_Business_13_01");	//So-so. I hope that the dragon hunters are as full of gold as they are of hot air.
	};
	if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Engor_Business_13_02");	//Lousy! The paladins just aren't buying a thing.
	};
	AI_Output (self, other, "DIA_Engor_Business_13_03");	//How about you, is there anything else you need?
};


instance DIA_Engor_PICKPOCKET(C_Info)
{
	npc = VLK_4108_Engor;
	nr = 900;
	condition = DIA_Engor_PICKPOCKET_Condition;
	information = DIA_Engor_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be risky to steal his map)";
};


func int DIA_Engor_PICKPOCKET_Condition()
{
//	return C_StealItems(40,Hlp_GetInstanceID(ItWr_Map_OldWorld),0);
//	return C_StealItem(40,Hlp_GetInstanceID(ItWr_Map_OldWorld));
	if(Npc_HasItems(self,ItWr_Map_OldWorld))
	{
		return C_StealItem(40);
	};
	return FALSE;
};

func void DIA_Engor_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Engor_PICKPOCKET);
	Info_AddChoice(DIA_Engor_PICKPOCKET,Dialog_Back,DIA_Engor_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Engor_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Engor_PICKPOCKET_DoIt);
};

func void DIA_Engor_PICKPOCKET_DoIt()
{
//	CreateInvItem(self,ItWr_Map_OldWorld);
//	B_StealItems(40,Hlp_GetInstanceID(ItWr_Map_OldWorld),1);
	B_StealItem(40,Hlp_GetInstanceID(ItWr_Map_OldWorld));
	Info_ClearChoices(DIA_Engor_PICKPOCKET);
};

func void DIA_Engor_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Engor_PICKPOCKET);
};

