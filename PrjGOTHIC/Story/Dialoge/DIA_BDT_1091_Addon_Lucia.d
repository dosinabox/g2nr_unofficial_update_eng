
instance DIA_Addon_Lucia_EXIT(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 999;
	condition = DIA_Addon_Lucia_EXIT_Condition;
	information = DIA_Addon_Lucia_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Lucia_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Lucia_EXIT_Info()
{
	B_EquipTrader(self);
	EnteredBanditsCamp = TRUE;
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Lucia_PICKPOCKET(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 900;
	condition = DIA_Addon_Lucia_PICKPOCKET_Condition;
	information = DIA_Addon_Lucia_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80_Female;
};


func int DIA_Addon_Lucia_PICKPOCKET_Condition()
{
	return C_Beklauen(80,100);
};

func void DIA_Addon_Lucia_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Lucia_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Lucia_PICKPOCKET,Dialog_Back,DIA_Addon_Lucia_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Lucia_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Lucia_PICKPOCKET_DoIt);
};

func void DIA_Addon_Lucia_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Lucia_PICKPOCKET);
};

func void DIA_Addon_Lucia_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Lucia_PICKPOCKET);
};


instance DIA_Addon_Lucia_Hi(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 2;
	condition = DIA_Addon_Lucia_Hi_Condition;
	information = DIA_Addon_Lucia_Hi_Info;
	permanent = FALSE;
	description = "And? How's it going?";
};


func int DIA_Addon_Lucia_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Lucia_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_Lucia_Hi_15_00");	//And? How's it going?
	AI_Output (self, other, "DIA_Addon_Lucia_Hi_16_01");	//Listen. If you want something to eat, go to Snaf. If you want something to drink, you're in the right place.
};


instance DIA_Addon_Lucia_was(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 2;
	condition = DIA_Addon_Lucia_was_Condition;
	information = DIA_Addon_Lucia_was_Info;
	permanent = FALSE;
	description = "What do you drink here then?";
};


func int DIA_Addon_Lucia_was_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lucia_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_was_Info()
{
		AI_Output (other, self, "DIA_Addon_Lucia_was_15_00");	//What do you drink here then?
		AI_Output (self, other, "DIA_Addon_Lucia_was_16_01");	//We only have a little beer. The only beer on the island was brought by the paladins.
		AI_Output (self, other, "DIA_Addon_Lucia_was_16_02");	//Just about the only good thing those fellows brought with them...
		AI_Output (self, other, "DIA_Addon_Lucia_was_16_03");	//Otherwise we drink booze. I've got moonshine, grog and white rum -
		AI_Output (self, other, "DIA_Addon_Lucia_was_16_04");	//(appreciatively) hmmm... you should try THAT - I got the recipe from Samuel. The old boy really knows his trade.
	CreateInvItems(self,ItFo_Addon_Liquor,1);
	B_GiveInvItems(self,other,ItFo_Addon_Liquor,1);
	if(!Npc_KnowsInfo(other,DIA_Addon_Scatty_Trinken))
	{
		Log_CreateTopic(Topic_Addon_BDT_Trader,LOG_NOTE);
		B_LogEntry(Topic_Addon_BDT_Trader,"Lucia can sell me some drinks.");
	};
};


instance DIA_Addon_Lucia_Khorinis(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 2;
	condition = DIA_Addon_Lucia_Khorinis_Condition;
	information = DIA_Addon_Lucia_Khorinis_Info;
	permanent = FALSE;
	description = "Aren't you from Khorinis?";
};


func int DIA_Addon_Lucia_Khorinis_Condition()
{
	if((MIS_LookingForLucia == LOG_Running) || (LuciaMentionedInKhorinis == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_Khorinis_Info()
{
	AI_Output (other, self, "DIA_Addon_Lucia_Khorinis_15_00");	//Aren't you from Khorinis?
	AI_Output (self, other, "DIA_Addon_Lucia_Khorinis_16_01");	//Don't remind me! My life in that city was horrible.
	AI_Output (self, other, "DIA_Addon_Lucia_Khorinis_16_02");	//While the ships with the new convicts kept coming in, there was still life in town.
	AI_Output (self, other, "DIA_Addon_Lucia_Khorinis_16_03");	//But all those other guys... (laughs) No thanks. Maybe it's because we're on an island... well, those days are over.
	if(MIS_LookingForLucia == LOG_Running)
	{
		B_LogEntry(TOPIC_Addon_Lucia,"It looks like Lucia is alive and well. She ran off with the bandits of her own will and seems to enjoy her new life.");
	};
	MIS_LookingForLucia = LOG_SUCCESS;
	B_CheckLog();
};


instance DIA_Addon_Lucia_SadElvrich(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 2;
	condition = DIA_Addon_Lucia_SadElvrich_Condition;
	information = DIA_Addon_Lucia_SadElvrich_Info;
	permanent = FALSE;
	description = "What are you planning to do?";
};


func int DIA_Addon_Lucia_SadElvrich_Condition()
{
	if((MIS_LookingForLucia == LOG_SUCCESS) && (MIS_LuciasLetter == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_SadElvrich_Info()
{
	AI_Output(other,self,"DIA_Addon_Lucia_Khorinis_15_04_add");	//А как же Элврих?@@@
	AI_Output(self,other,"DIA_Addon_Lucia_Khorinis_16_06");	//I'm finished with Elvrich!
	AI_Output(other,self,"DIA_Addon_Lucia_Khorinis_15_04");	//Why?
	AI_Output(self,other,"DIA_Addon_Lucia_Khorinis_16_05");	//He's a wimp! When the bandits dragged me off, he didn't lift a finger to help me.
	B_GivePlayerXP(XP_Ambient);
};


instance DIA_Addon_Lucia_Jetzt(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 2;
	condition = DIA_Addon_Lucia_Jetzt_Condition;
	information = DIA_Addon_Lucia_Jetzt_Info;
	permanent = FALSE;
	description = "You're not very fond of the paladins, are you?";
};


func int DIA_Addon_Lucia_Jetzt_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lucia_Khorinis))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_Jetzt_Info()
{
	AI_Output(other,self,"DIA_Addon_Lucia_Jetzt_15_00");	//What are you planning to do?
	AI_Output(self,other,"DIA_Addon_Lucia_Jetzt_16_01");	//We'll see. For now, I'll stay here with Snaf, Fisk and the others.
	AI_Output(self,other,"DIA_Addon_Lucia_Jetzt_16_02");	//Have you already talked to Thorus? (rolls her eyes) Oh, Innos, is that a hunk of a man!
	AI_Output(self,other,"DIA_Addon_Lucia_Jetzt_16_03");	//(laughs) Excuse me... let's get back to your question... I haven't set a goal, I'm only drifting.
};


instance DIA_Addon_Lucia_Paladine(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 2;
	condition = DIA_Addon_Lucia_Paladine_Condition;
	information = DIA_Addon_Lucia_Paladine_Info;
	permanent = FALSE;
	description = "You're not very fond of the paladins, are you?";
};


func int DIA_Addon_Lucia_Paladine_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lucia_was))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_Paladine_Info()
{
	AI_Output (other, self, "DIA_Addon_Lucia_Paladine_15_00");	//You're not very fond of the paladins, are you?
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_16_01");	//Those fanatical murderers in the pay of the Fire Magicians? No.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_16_02");	//That Lord Hagen occupies the city with his thugs, and everybody bows down to him.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_16_03");	//And I didn't want to do that. I wasn't going to wait until they closed down the Red Lantern and locked me up.
	if((other.guild != GIL_SLD) && (other.guild != GIL_DJG))
	{
		Info_ClearChoices(DIA_Addon_Lucia_Paladine);
		Info_AddChoice(DIA_Addon_Lucia_Paladine,"(say nothing)",DIA_Addon_Lucia_Paladine_BACK);
		Info_AddChoice(DIA_Addon_Lucia_Paladine,"The paladins don't only fight in his name. Innos chooses his warriors.",DIA_Addon_Lucia_Paladine_WAHL);
		Info_AddChoice(DIA_Addon_Lucia_Paladine,"The paladins are the warriors of Innos. They aren't murderers.",DIA_Addon_Lucia_Paladine_MURDER);
	};
};

func void DIA_Addon_Lucia_Paladine_BACK()
{
	Info_ClearChoices(DIA_Addon_Lucia_Paladine);
};

func void DIA_Addon_Lucia_Paladine_WAHL()
{
	AI_Output (other, self, "DIA_Addon_Lucia_Paladine_WAHL_15_00");	//The paladins don't only fight in his name. Innos chooses his warriors.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_WAHL_16_01");	//So? I believe it's the people who choose themselves.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_WAHL_16_02");	//Still, your words amaze me. You talk almost like you were one of them.
	Info_AddChoice (DIA_Addon_Lucia_Paladine, "Have you ever killed someone?", DIA_Addon_Lucia_Paladine_KILL);
};

func void DIA_Addon_Lucia_Paladine_KILL()
{
	AI_Output (other, self, "DIA_Addon_Lucia_Paladine_KILL_15_00");	//Have you ever killed someone?
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_KILL_16_01");	//No, and I'm very glad of it.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_KILL_16_02");	//Please, let's not be so serious any more.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_KILL_16_03");	//Instead, let's drink and enjoy every moment the gods give us.
	Info_ClearChoices(DIA_Addon_Lucia_Paladine);
};

func void DIA_Addon_Lucia_Paladine_WEIB()
{
	AI_Output (other, self, "DIA_Addon_Lucia_Paladine_WEIB_15_00");	//Do you deny Innos then, wench?
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_WEIB_16_01");	//How could I? It's just people who misuse his name.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_WEIB_16_02");	//But I never doubted Innos' divine splendor for a second.
};

func void DIA_Addon_Lucia_Paladine_MURDER()
{
	AI_Output (other, self, "DIA_Addon_Lucia_Paladine_MURDER_15_00");	//The paladins are the warriors of Innos. They aren't murderers.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_MURDER_16_01");	//So? Blood sticks to their swords too - just like the weapons of the pirates or the bandits.
	AI_Output (self, other, "DIA_Addon_Lucia_Paladine_MURDER_16_02");	//The only difference is they do it in Innos' name and not because they want to survive.
	Info_AddChoice (DIA_Addon_Lucia_Paladine, "Do you deny Innos then, wench?", DIA_Addon_Lucia_Paladine_WEIB);
};


instance DIA_Addon_Lucia_Attentat(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 9;
	condition = DIA_Addon_Lucia_Attentat_Condition;
	information = DIA_Addon_Lucia_Attentat_Info;
	permanent = FALSE;
	description = DIALOG_ADDON_ATTENTAT_DESCRIPTION;
};


func int DIA_Addon_Lucia_Attentat_Condition()
{
	if(MIS_Judas == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_Attentat_Info()
{
	B_Say (other, self, "$ATTENTAT_ADDON_DESCRIPTION");
	AI_Output (self, other, "DIA_Addon_Lucia_Attentat_16_00");	//Nothing at all.
};


instance DIA_Addon_Lucia_Trade(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 99;
	condition = DIA_Addon_Lucia_Trade_Condition;
	information = DIA_Addon_Lucia_Trade_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "Give me something to drink.";
};


func int DIA_Addon_Lucia_Trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lucia_was))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_Trade_Info()
{
	if(Lucia_flag == TRUE)
	{
		B_ClearAlchemyInv(self);
		if(Lucia_flasks > 0)
		{
			CreateInvItems(self,ItMi_Flask,Lucia_flasks);
		};
		Lucia_flag = FALSE;
	};
	AI_Output(other,self,"DIA_Addon_Lucia_Trade_15_00");	//Give me something to drink.
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Addon_Lucia_lernen(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 19;
	condition = DIA_Addon_Lucia_lernen_Condition;
	information = DIA_Addon_Lucia_lernen_Info;
	permanent = FALSE;
	description = "Can you teach me something?";
};


func int DIA_Addon_Lucia_lernen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lucia_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_lernen_Info()
{
	AI_Output (other, self, "DIA_Addon_Lucia_lernen_15_00");	//Can you teach me something?
	AI_Output (self, other, "DIA_Addon_Lucia_lernen_16_01");	//(laughs) Only too gladly. You can train your DEXTERITY with me.
	Log_CreateTopic (Topic_Addon_BDT_Teacher, LOG_NOTE);
	B_LogEntry (Topic_Addon_BDT_Teacher, "Lucia can help me train my dexterity.");
};


func void B_BuildLearnDialog_Lucia()
{
	Info_ClearChoices(DIA_Addon_Lucia_TEACH);
	Info_AddChoice(DIA_Addon_Lucia_TEACH,Dialog_Back,DIA_Addon_Lucia_TEACH_BACK);
	Info_AddChoice(DIA_Addon_Lucia_TEACH,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_Addon_Lucia_TEACH_1);
	Info_AddChoice(DIA_Addon_Lucia_TEACH,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_Addon_Lucia_TEACH_5);
};

instance DIA_Addon_Lucia_TEACH(C_Info)
{
	npc = BDT_1091_Addon_Lucia;
	nr = 101;
	condition = DIA_Addon_Lucia_TEACH_Condition;
	information = DIA_Addon_Lucia_TEACH_Info;
	permanent = TRUE;
	description = "I want to become more dexterous.";
};


func int DIA_Addon_Lucia_TEACH_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Lucia_lernen))
	{
		return TRUE;
	};
};

func void DIA_Addon_Lucia_TEACH_Info()
{
	AI_Output(other,self,"DIA_Addon_Lucia_TEACH_15_00");	//I want to become more dexterous.
	B_BuildLearnDialog_Lucia();
};

func void DIA_Addon_Lucia_TEACH_BACK()
{
	Info_ClearChoices(DIA_Addon_Lucia_TEACH);
};

func void DIA_Addon_Lucia_TEACH_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MED))
	{
		B_BuildLearnDialog_Lucia();
	};
};

func void DIA_Addon_Lucia_TEACH_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MED))
	{
		B_BuildLearnDialog_Lucia();
	};
};

