
instance DIA_Tandor_EXIT(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 999;
	condition = DIA_Tandor_EXIT_Condition;
	information = DIA_Tandor_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Tandor_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Tandor_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Tandor_Hallo(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 2;
	condition = DIA_Tandor_Hallo_Condition;
	information = DIA_Tandor_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Tandor_Hallo_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Tandor_Hallo_Info()
{
	AI_Output (self, other, "DIA_Tandor_Hallo_08_00");	//You came over the pass? Well done. We have already lost a lot of men out there.
	AI_Output (self, other, "DIA_Tandor_Hallo_08_01");	//I know myself what it's like out there - I accompanied a reconnaissance unit for a while.
	AI_Output (self, other, "DIA_Tandor_Hallo_08_02");	//Do you have a weapon? If you need a good weapon, I'm your man.
	if(!Npc_KnowsInfo(other,DIA_Garond_Equipment) && !Npc_KnowsInfo(other,DIA_Keroloth_WantTeach) && !Npc_KnowsInfo(other,DIA_Dobar_Waffe))
	{
		Log_CreateTopic(TOPIC_Trader_OC,LOG_NOTE);
		B_LogEntry(TOPIC_Trader_OC,"Tandor trades in weapons at the castle.");
	};
};


instance DIA_Tandor_Trupp(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 2;
	condition = DIA_Tandor_Trupp_Condition;
	information = DIA_Tandor_Trupp_Info;
	permanent = FALSE;
	description = "What became of the unit?";
};


func int DIA_Tandor_Trupp_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Tandor_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Tandor_Trupp_Info()
{
	AI_Output (other, self, "DIA_Tandor_Trupp_15_00");	//What became of the unit?
	AI_Output (self, other, "DIA_Tandor_Trupp_08_01");	//We scouted the area and wanted to advance to the coast. We set up our camp in a cave.
	AI_Output (self, other, "DIA_Tandor_Trupp_08_02");	//It was late at night when the orcs came. They charged up the slope with torches and drums - and discovered us.
	AI_Output (self, other, "DIA_Tandor_Trupp_08_03");	//We tried to flee, but I was the only one who got through ...
	AI_Output (self, other, "DIA_Tandor_Trupp_08_04");	//Soon after that, the orcs erected their big palisade and we pulled back into the castle.
};


instance DIA_Tandor_Trade(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 900;
	condition = DIA_Tandor_Trade_Condition;
	information = DIA_Tandor_Trade_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "Show me your wares.";
};


func int DIA_Tandor_Trade_Condition()
{
	return TRUE;
};

func void DIA_Tandor_Trade_Info()
{
	AI_Output(other,self,"DIA_Tandor_Trade_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Tandor_Equipment(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 3;
	condition = DIA_Tandor_Equipment_Condition;
	information = DIA_Tandor_Equipment_Info;
	description = "Garond sent me - I need some gear.";
};


func int DIA_Tandor_Equipment_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garond_Equipment) && (other.guild == GIL_MIL) && (Kapitel == 2))
	{
		return TRUE;
	};
};

func void DIA_Tandor_Equipment_Info()
{
	AI_Output (other, self, "DIA_Tandor_Equipment_15_00");	//Garond sent me - I need some gear.
	AI_Output (self, other, "DIA_Tandor_Equipment_08_01");	//Close or long-range combat?
	Info_ClearChoices (DIA_Tandor_Equipment);
	Info_AddChoice (DIA_Tandor_Equipment, "Close combat.", DIA_Tandor_Equipment_Nah);
	Info_AddChoice (DIA_Tandor_Equipment, "Long-range combat.", DIA_Tandor_Equipment_Fern);
};

func void DIA_Tandor_Equipment_Nah()
{
	AI_Output (other, self, "DIA_Tandor_Equipment_Nah_15_00");	//Close combat.
	AI_Output (self, other, "DIA_Tandor_Equipment_Nah_08_01");	//One-handed or two-handed fighter?
	Info_ClearChoices (DIA_Tandor_Equipment);
	Info_AddChoice (DIA_Tandor_Equipment, "One-handed.", DIA_Tandor_Equipment_Ein);
	Info_AddChoice (DIA_Tandor_Equipment, "Two-handed.", DIA_Tandor_Equipment_Zwei);
};

func void DIA_Tandor_Equipment_Fern()
{
	AI_Output (other, self, "DIA_Tandor_Equipment_Fern_15_00");	//Long-range combat.
	AI_Output (self, other, "DIA_Tandor_Equipment_Fern_08_01");	//Bow or crossbow?
	Info_ClearChoices (DIA_Tandor_Equipment);
	Info_AddChoice (DIA_Tandor_Equipment, "Bow", DIA_Tandor_Equipment_Bow);
	Info_AddChoice (DIA_Tandor_Equipment, "Crossbow", DIA_Tandor_Equipment_Crossbow);
};

func void DIA_Tandor_Equipment_Ein()
{
	AI_Output (other, self, "DIA_Tandor_Equipment_Ein_15_00");	//One-handed.
	AI_Output (self, other, "DIA_Tandor_Equipment_Ein_08_01");	//Then take this stonebreaker. A good weapon.
	CreateInvItems(self,ItMw_Steinbrecher,1);
	B_GiveInvItems(self,other,ItMw_Steinbrecher,1);
	Info_ClearChoices(DIA_Tandor_Equipment);
};

func void DIA_Tandor_Equipment_Zwei()
{
	AI_Output (other, self, "DIA_Tandor_Equipment_Zwei_15_00");	//Two-handed.
	AI_Output (self, other, "DIA_Tandor_Equipment_Zwei_08_01");	//You are well-armed with this two-hander.
	CreateInvItems(self,ItMw_Zweihaender1,1);
	B_GiveInvItems(self,other,ItMw_Zweihaender1,1);
	Info_ClearChoices(DIA_Tandor_Equipment);
};

func void DIA_Tandor_Equipment_Bow()
{
	AI_Output (other, self, "DIA_Tandor_Equipment_Bow_15_00");	//Bow.
	AI_Output (self, other, "DIA_Tandor_Equipment_Bow_08_01");	//This hunting bow is exactly right for you. And I'll give you some arrows, too.
	CreateInvItems(self,ItRw_Bow_L_03,1);
	B_GiveInvItems(self,other,ItRw_Bow_L_03,1);
	CreateInvItems(other,ItRw_Arrow,50);
	AI_PrintScreen("Received: Arrows (50)",-1,43,FONT_ScreenSmall,2);
	Info_ClearChoices(DIA_Tandor_Equipment);
};

func void DIA_Tandor_Equipment_Crossbow()
{
	AI_Output (other, self, "DIA_Tandor_Equipment_Crossbow_15_00");	//Crossbow.
	AI_Output (self, other, "DIA_Tandor_Equipment_Crossbow_08_01");	//Then take this light crossbow. You can also get bolts from me.
	CreateInvItems(self,ItRw_Crossbow_L_02,1);
	B_GiveInvItems(self,other,ItRw_Crossbow_L_02,1);
	CreateInvItems(other,ItRw_Bolt,50);
	AI_PrintScreen("Received: Bolts (50)",-1,43,FONT_ScreenSmall,2);
	Info_ClearChoices(DIA_Tandor_Equipment);
};


instance DIA_Tandor_News(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 40;
	condition = DIA_Tandor_News_Condition;
	information = DIA_Tandor_News_Info;
	permanent = TRUE;
	description = "Do you have any news?";
};


func int DIA_Tandor_News_Condition()
{
	if((Kapitel == 4) && Npc_KnowsInfo(hero,DIA_Tandor_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Tandor_News_Info()
{
	AI_Output (other, self, "DIA_Tandor_News_15_00");	//Do you have any news?
	if (hero.guild == GIL_DJG)
	{
		AI_Output (self, other, "DIA_Tandor_News_08_01");	//The only thing that's happened recently is you dragon hunters coming here.
	}
	else
	{
		AI_Output (self, other, "DIA_Tandor_News_08_02");	//The dragon hunters have arrived.
		AI_Output (self, other, "DIA_Tandor_News_08_03");	//They strike me as tough bastards - and I hope they are, because otherwise they won't survive for long.
	};
};


instance DIA_Tandor_WASISTLOS(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 51;
	condition = DIA_Tandor_WASISTLOS_Condition;
	information = DIA_Tandor_WASISTLOS_Info;
	permanent = TRUE;
	description = "That's not a happy face you're making.";
};


func int DIA_Tandor_WASISTLOS_Condition()
{
	if((Kapitel == 5) && Npc_KnowsInfo(hero,DIA_Tandor_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Tandor_WASISTLOS_Info()
{
	AI_Output (other, self, "DIA_Tandor_WASISTLOS_15_00");	//That's not a happy face you're making.
	if (MIS_OCGateOpen == TRUE)
	{
		AI_Output (self, other, "DIA_Tandor_WASISTLOS_08_01");	//The orcs will keep on coming. Until we're all dead.
	}
	else
	{
		AI_Output (self, other, "DIA_Tandor_WASISTLOS_08_02");	//No decent food for weeks. I'm starving.
	};
};

/*
instance DIA_Tandor_KAP6_EXIT(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 999;
	condition = DIA_Tandor_KAP6_EXIT_Condition;
	information = DIA_Tandor_KAP6_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Tandor_KAP6_EXIT_Condition()
{
	if(Kapitel == 6)
	{
		return TRUE;
	};
};

func void DIA_Tandor_KAP6_EXIT_Info()
{
	AI_StopProcessInfos(self);
};
*/

instance DIA_Tandor_PICKPOCKET(C_Info)
{
	npc = PAL_260_Tandor;
	nr = 900;
	condition = DIA_Tandor_PICKPOCKET_Condition;
	information = DIA_Tandor_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Tandor_PICKPOCKET_Condition()
{
	return C_Beklauen(47,90);
};

func void DIA_Tandor_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Tandor_PICKPOCKET);
	Info_AddChoice(DIA_Tandor_PICKPOCKET,Dialog_Back,DIA_Tandor_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Tandor_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Tandor_PICKPOCKET_DoIt);
};

func void DIA_Tandor_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Tandor_PICKPOCKET);
};

func void DIA_Tandor_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Tandor_PICKPOCKET);
};

