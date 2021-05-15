
instance DIA_Zuris_EXIT(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 999;
	condition = DIA_Zuris_EXIT_Condition;
	information = DIA_Zuris_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Zuris_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Zuris_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Zuris_PICKPOCKET(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 900;
	condition = DIA_Zuris_PICKPOCKET_Condition;
	information = DIA_Zuris_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be easy to steal his potion)";
};


func int DIA_Zuris_PICKPOCKET_Condition()
{
//	return C_StealItems(40,Hlp_GetInstanceID(ItPo_Health_03),0);
	return C_StealItem(40);
};

func void DIA_Zuris_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Zuris_PICKPOCKET);
	Info_AddChoice(DIA_Zuris_PICKPOCKET,Dialog_Back,DIA_Zuris_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Zuris_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Zuris_PICKPOCKET_DoIt);
};

func void DIA_Zuris_PICKPOCKET_DoIt()
{
//	CreateInvItem(self,ItPo_Health_03);
//	B_StealItems(40,Hlp_GetInstanceID(ItPo_Health_03),1);
//	B_StealItem(40,Hlp_GetInstanceID(ItPo_Health_03));
	if(other.attribute[ATR_DEXTERITY] >= 40)
	{
		CreateInvItem(other,ItPo_Health_03);
		AI_PrintScreen(ConcatStrings(NAME_HP_Elixier,PRINT_ItemTaken),-1,YPOS_ItemTaken,FONT_ScreenSmall,2);
		self.aivar[AIV_PlayerHasPickedMyPocket] = TRUE;
		B_GiveThiefXP();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Zuris",PRINT_PickPocketSuccess));
	}
	else
	{
		B_ResetThiefLevel();
		B_LogEntry(Topic_PickPocket,ConcatStrings("Zuris",PRINT_PickPocketFailed));
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_Theft,1);
	};
	Info_ClearChoices(DIA_Zuris_PICKPOCKET);
};

func void DIA_Zuris_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Zuris_PICKPOCKET);
};


instance DIA_Zuris_Sperre(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 2;
	condition = DIA_Zuris_Sperre_Condition;
	information = DIA_Zuris_Sperre_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Zuris_Sperre_Condition()
{
	if((Canthar_Sperre == TRUE) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Zuris_Sperre_Info()
{
	AI_Output (self, other, "DIA_Zuris_Sperre_14_00");	//You are a convict from the mining colony. Scram!
	AI_StopProcessInfos (self);
};


instance DIA_Zuris_GREET(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 2;
	condition = DIA_Zuris_GREET_Condition;
	information = DIA_Zuris_GREET_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Zuris_GREET_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Canthar_Sperre == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Zuris_GREET_Info()
{
	AI_Output (self, other, "DIA_Zuris_GREET_14_00");	//I am Zuris, Master of Potions.
	AI_Output (self, other, "DIA_Zuris_GREET_14_01");	//Do you need an essence of healing or a magic elixir? Then you've come to the right place.
	Log_CreateTopic (TOPIC_CityTrader, LOG_NOTE);
	B_LogEntry (TOPIC_CityTrader, "Zuris sells potions at the marketplace.");
};


var int Zuris_einmal;

instance DIA_Zuris_WAREZ(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 800;
	condition = DIA_Zuris_WAREZ_Condition;
	information = DIA_Zuris_WAREZ_Info;
	permanent = TRUE;
	trade = TRUE;
	description = DIALOG_TRADE_v4;
};


func int DIA_Zuris_WAREZ_Condition()
{
	return TRUE;
};

func void DIA_Zuris_WAREZ_Info()
{
	AI_Output(other,self,"DIA_Zuris_WAREZ_15_00");	//Show me your wares.
	if((Zuris_einmal == FALSE) && !Npc_KnowsInfo(other,DIA_Zuris_Potions))
	{
		AI_Output (self, other, "DIA_Zuris_GREET_14_02");	//I just received some new potions. My guest, Master Daron the Fire Magician, brought them along from the monastery.
		Zuris_einmal = TRUE;
	};
	if(MIS_Serpentes_MinenAnteil_KDF == LOG_Running)
	{
		ZurisMinenAnteil = TRUE;
	};
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Zuris_Potions(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 2;
	condition = DIA_Zuris_POTIONS_Condition;
	information = DIA_Zuris_POTIONS_Info;
	permanent = FALSE;
	description = "Do you brew your own potions?";
};


func int DIA_Zuris_POTIONS_Condition()
{
	return TRUE;
};

func void DIA_Zuris_POTIONS_Info()
{
	AI_Output (other, self, "DIA_Zuris_POTIONS_15_00");	//Do you brew your own potions?
	AI_Output (self, other, "DIA_Zuris_POTIONS_14_01");	//No, I either get them from the monastery, or I buy them from Constantino, the alchemist.
	if (hero.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Zuris_POTIONS_14_02");	//If you're interested in brewing potions, then go talk to him. He needs an assistant.
		AI_Output (self, other, "DIA_Zuris_POTIONS_14_03");	//But he is too pig-headed to hire somebody himself. He's just as stubborn as a mule.
	};
	AI_Output (self, other, "DIA_Zuris_Add_14_00");	//He always passes me when he goes out the east gate to collect plants for his potions.
};


instance DIA_Zuris_Kraut(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 2;
	condition = DIA_Zuris_Kraut_Condition;
	information = DIA_Zuris_Kraut_Info;
	permanent = FALSE;
	description = "Where exactly does Constantino gather his herbs?";
};


func int DIA_Zuris_Kraut_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Zuris_Potions))
	{
		return TRUE;
	};
};

func void DIA_Zuris_Kraut_Info()
{
	AI_Output (other, self, "DIA_Zuris_Add_15_01");	//Where exactly does Constantino gather his herbs?
	AI_Output (self, other, "DIA_Zuris_Add_14_02");	//He always goes through the eastern city gate here and then disappears into the wilderness to the left.
	AI_Output (self, other, "DIA_Zuris_Add_14_03");	//He once told me that just about everything grows there, except for king's sorrel.
	Wld_InsertItem (ItPl_Mana_Herb_01, "FP_ITEM_HERB_01");
	Wld_InsertItem (ItPl_Mana_Herb_02, "FP_ITEM_HERB_02");
	Wld_InsertItem (ItPl_Mana_Herb_03, "FP_ITEM_HERB_03");
	Wld_InsertItem (ItPl_Health_Herb_01, "FP_ITEM_HERB_04");
	Wld_InsertItem (ItPl_Health_Herb_02, "FP_ITEM_HERB_05");
	Wld_InsertItem (ItPl_Health_Herb_03, "FP_ITEM_HERB_06");
	Wld_InsertItem (ItPl_Speed_Herb_01, "FP_ITEM_HERB_07");
	Wld_InsertItem (ItPl_Temp_Herb, "FP_ITEM_HERB_08");
	Wld_InsertItem (ItPl_Strength_Herb_01, "FP_ITEM_HERB_09");
	Wld_InsertItem (ItPl_Dex_Herb_01, "FP_ITEM_HERB_10");
};


instance DIA_Zuris_Kronstoeckel(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 2;
	condition = DIA_Zuris_Kronstoeckel_Condition;
	information = DIA_Zuris_Kronstoeckel_Info;
	permanent = FALSE;
	description = "Has Constantino ever told you where to find king's sorrel?";
};


func int DIA_Zuris_Kronstoeckel_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Zuris_Kraut))
	{
		return TRUE;
	};
};

func void DIA_Zuris_Kronstoeckel_Info()
{
	AI_Output (other, self, "DIA_Zuris_Add_15_04");	//Has Constantino ever told you where to find king's sorrel?
	AI_Output (self, other, "DIA_Zuris_Add_14_05");	//I once heard him say that the stuff grows near stone circles.
	AI_Output (self, other, "DIA_Zuris_Add_14_06");	//Near Lobart's farm, that's the farm near the other gate, there is one of those stone circles.
	AI_Output (self, other, "DIA_Zuris_Add_14_07");	//I think it's on a hill. It used to be a grave or something.
	Wld_InsertItem (ItPl_Perm_Herb, "FP_ITEM_HERB_11");
};


instance DIA_Zuris_WHERE(C_Info)
{
	npc = VLK_409_Zuris;
	condition = DIA_Zuris_WHERE_Condition;
	information = DIA_Zuris_WHERE_Info;
	permanent = FALSE;
	description = "Where can I find Constantino?";
};


func int DIA_Zuris_WHERE_Condition()
{
	if(Npc_KnowsInfo(hero,DIA_Zuris_Potions))
	{
		return TRUE;
	};
};

func void DIA_Zuris_WHERE_Info()
{
	AI_Output (other, self, "DIA_Zuris_WHERE_15_00");	//Where can I find Constantino?
	AI_Output (self, other, "DIA_Zuris_WHERE_14_01");	//His chambers are in the tunnel near Harad's smithy. Shouldn't be hard to find.
};


instance DIA_Zuris_Kloster(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 2;
	condition = DIA_Zuris_Kloster_Condition;
	information = DIA_Zuris_Kloster_Info;
	description = "Tell me about the monastery.";
};


func int DIA_Zuris_Kloster_Condition()
{
	if((Zuris_einmal == TRUE) || Npc_KnowsInfo(other,DIA_Zuris_Potions))
	{
		if(other.guild != GIL_KDF)
		{
			return TRUE;
		};
	};
};

func void DIA_Zuris_Kloster_Info()
{
	AI_Output (other, self, "DIA_Zuris_Kloster_14_00");	//Tell me about the monastery.
	AI_Output (self, other, "DIA_Zuris_Kloster_14_01");	//You had better talk to Master Daron himself. He knows more about that than I do.
};


instance DIA_Zuris_Minenanteil(C_Info)
{
	npc = VLK_409_Zuris;
	nr = 3;
	condition = DIA_Zuris_Minenanteil_Condition;
	information = DIA_Zuris_Minenanteil_Info;
	description = "You're selling mine shares?";
};


func int DIA_Zuris_Minenanteil_Condition()
{
	//if((hero.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running))
	if((hero.guild == GIL_KDF) && (MIS_Serpentes_MinenAnteil_KDF == LOG_Running) && (ZurisMinenAnteil == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Zuris_Minenanteil_Info()
{
	AI_Output (other, self, "DIA_Zuris_Minenanteil_15_00");	//You're selling mining shares?
	AI_Output (self, other, "DIA_Zuris_Minenanteil_14_01");	//Yes. Some flop that was. That's the last time I get involved in a shady deal like that!
	B_GivePlayerXP (XP_Ambient);
};

