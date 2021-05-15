
instance DIA_Rupert_EXIT(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 999;
	condition = DIA_Rupert_EXIT_Condition;
	information = DIA_Rupert_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Rupert_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Rupert_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Rupert_PICKPOCKET(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 998;
	condition = DIA_Rupert_PICKPOCKET_Condition;
	information = DIA_Rupert_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Rupert_PICKPOCKET_Condition()
{
	return C_Beklauen(18,10);
};

func void DIA_Rupert_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Rupert_PICKPOCKET);
	Info_AddChoice(DIA_Rupert_PICKPOCKET,Dialog_Back,DIA_Rupert_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Rupert_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Rupert_PICKPOCKET_DoIt);
};

func void DIA_Rupert_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Rupert_PICKPOCKET);
};

func void DIA_Rupert_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Rupert_PICKPOCKET);
};


instance DIA_Rupert_Hello(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 1;
	condition = DIA_Rupert_Hello_Condition;
	information = DIA_Rupert_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Rupert_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Rupert_Hello_Info()
{
	if((hero.guild == GIL_NONE) && (Player_IsApprentice == APP_NONE))
	{
		AI_Output(self,other,"DIA_Rupert_Hello_03_00");	//Hello, stranger!
	};
	AI_Output (self, other, "DIA_Rupert_Hello_03_01");	//You must be hungry and thirsty - can I perhaps interest you in my wares?
	Log_CreateTopic(TOPIC_CityTrader,LOG_NOTE);
	B_LogEntry(TOPIC_CityTrader,"Rupert the merchant near the southern gate is selling food.");
};


instance DIA_Rupert_ZuPal(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 1;
	condition = DIA_Rupert_ZuPal_Condition;
	information = DIA_Rupert_ZuPal_Info;
	permanent = FALSE;
	description = "I was actually on my way to see the paladins ...";
};


func int DIA_Rupert_ZuPal_Condition()
{
	if(Kapitel < 2)
	{
		return TRUE;
	};
};

func void DIA_Rupert_ZuPal_Info()
{
	AI_Output (other, self, "DIA_Rupert_ZuPal_15_00");	//I was actually on my way to see the paladins ...
	AI_Output (self, other, "DIA_Rupert_ZuPal_03_01");	//There's little chance of that. Since the paladins made themselves at home in the upper end of town, hardly anyone gets in there any more.
};


instance DIA_Rupert_HelpMeIntoOV(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 1;
	condition = DIA_Rupert_HelpMeIntoOV_Condition;
	information = DIA_Rupert_HelpMeIntoOV_Info;
	permanent = FALSE;
	description = "Can you help me get into the upper quarter?";
};


func int DIA_Rupert_HelpMeIntoOV_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rupert_ZuPal) && ((hero.guild == GIL_NONE) || (hero.guild == GIL_NOV)) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Rupert_HelpMeIntoOV_Info()
{
	AI_Output (other, self, "DIA_Rupert_HelpMeIntoOV_15_00");	//Can you help me get into the upper quarter?
	AI_Output (self, other, "DIA_Rupert_HelpMeIntoOV_03_01");	//Me? No, I don't have much say here myself!
	AI_Output (self, other, "DIA_Rupert_HelpMeIntoOV_03_02");	//There are only a few people here in the lower city who have enough influence to get you past the guards.
	AI_Output (self, other, "DIA_Rupert_HelpMeIntoOV_03_03");	//Matteo, my boss, is one of them. Maybe you should talk to him.
	Log_CreateTopic (TOPIC_OV, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_OV, LOG_Running);
	B_LogEntry (TOPIC_OV, "If I want to get in the upper quarter, I'll need the help of some influential citizens from the lower part of town.");
	Log_AddEntry(TOPIC_OV,"The merchant Matteo is one of the influential citizens of the lower part of town.");
};


instance DIA_Rupert_WoMatteo(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 1;
	condition = DIA_Rupert_WoMatteo_Condition;
	information = DIA_Rupert_WoMatteo_Info;
	permanent = FALSE;
	description = "Where can I find Matteo?";
};


func int DIA_Rupert_WoMatteo_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rupert_HelpMeIntoOV) && ((hero.guild == GIL_NONE) || (hero.guild == GIL_NOV)) && (Knows_Matteo == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Rupert_WoMatteo_Info()
{
	AI_Output (other, self, "DIA_Rupert_WoMatteo_15_00");	//Where can I find Matteo?
	AI_Output (self, other, "DIA_Rupert_WoMatteo_03_01");	//You're standing right outside his shop. Just go on in. He's practically always there.
	if (Knows_Matteo == FALSE)
	{
		Log_CreateTopic (TOPIC_CityTrader, LOG_NOTE);
		B_LogEntry (TOPIC_CityTrader, "Matteo's shop is at the south gate of the city. He sells equipment, weapons and supplies.");
		Knows_Matteo = TRUE;
	};
};


instance DIA_Rupert_WerEinfluss(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 2;
	condition = DIA_Rupert_WerEinfluss_Condition;
	information = DIA_Rupert_WerEinfluss_Info;
	permanent = FALSE;
	description = "What about the other influential citizens?";
};


func int DIA_Rupert_WerEinfluss_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rupert_HelpMeIntoOV) && ((hero.guild == GIL_NONE) || (hero.guild == GIL_NOV)))
	{
		return TRUE;
	};
};

func void DIA_Rupert_WerEinfluss_Info()
{
	AI_Output (other, self, "DIA_Rupert_WerEinfluss_15_00");	//What about the other influential citizens?
	AI_Output (self, other, "DIA_Rupert_WerEinfluss_03_01");	//The merchants and master craftsmen here on the main street are the most important figures in the city.
	if(Player_IsApprentice == APP_NONE)
	{
	AI_Output (self, other, "DIA_Rupert_WerEinfluss_03_02");	//You should try to get accepted by one of them as an apprentice - like me.
		B_LogEntry(TOPIC_OV,"I should try to start work as an apprentice for one of the master craftsmen.");
	};
	AI_Output(self,other,"DIA_Rupert_WerEinfluss_03_03");	//Since I started working for Matteo, the people in the city treat me with respect!
};


instance DIA_Rupert_Work(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 3;
	condition = DIA_Rupert_Work_Condition;
	information = DIA_Rupert_Work_Info;
	permanent = FALSE;
	description = "I need some money, and I'm looking for work.";
};


func int DIA_Rupert_Work_Condition()
{
	if(((hero.guild == GIL_NONE) || (hero.guild == GIL_NOV)) && (Player_IsApprentice == APP_NONE))
	{
		return TRUE;
	};
};

func void DIA_Rupert_Work_Info()
{
	AI_Output (other, self, "DIA_Rupert_Work_15_00");	//I need some money, and I'm looking for work.
	AI_Output (self, other, "DIA_Rupert_Work_03_01");	//I've heard that Bosper has trouble with his suppliers. His shop is right over there.
	AI_Output (self, other, "DIA_Rupert_Work_03_02");	//They say he pays pretty well.
};


var int RupertMentionedOnar;

instance DIA_Rupert_YourOffer(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 4;
	condition = DIA_Rupert_YourOffer_Condition;
	information = DIA_Rupert_YourOffer_Info;
	permanent = FALSE;
	description = "Что ты можешь мне предложить?";
};


func int DIA_Rupert_YourOffer_Condition()
{
	return TRUE;
};

func void DIA_Rupert_YourOffer_Info()
{
	AI_Output (other, self, "DIA_Rupert_YourOffer_15_00");	//What do you have to offer?
	AI_Output (self, other, "DIA_Rupert_YourOffer_03_01");	//At the moment, I don't have much choice.
	if ((hero.guild != GIL_SLD) && (hero.guild != GIL_DJG))
	{
		AI_Output(self,other,"DIA_Rupert_YourOffer_03_02");	//The damned landowner doesn't deliver any more, and what we get from the small farms isn't enough to meet the demands of the city.
		RupertMentionedOnar = TRUE;
	};
};


instance DIA_Rupert_Trade(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 900;
	condition = DIA_Rupert_Trade_Condition;
	information = DIA_Rupert_Trade_Info;
	permanent = TRUE;
	description = DIALOG_TRADE_v4;
	trade = TRUE;
};


func int DIA_Rupert_Trade_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rupert_YourOffer))
	{
		return TRUE;
	};
};

func void DIA_Rupert_Trade_Info()
{
	AI_Output(other,self,"DIA_Rupert_Trade_15_00");	//Show me your wares.
	B_GiveTradeInv(self);
	if(Npc_HasItems(self,ItFo_Cheese) < 5)
	{
		CreateInvItems(self,ItFo_Cheese,5);
	};
	if((hero.guild == GIL_KDF) || (hero.guild == GIL_PAL))
	{
		AI_Output(self,other,"DIA_Rupert_Trade_03_01");	//I must beg your pardon for my poor selection. A man in your position is certainly used to better.
	};
	Trade_IsActive = TRUE;
};


instance DIA_Rupert_Bauernaufstand(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 4;
	condition = DIA_Rupert_Bauernaufstand_Condition;
	information = DIA_Rupert_Bauernaufstand_Info;
	permanent = FALSE;
	description = "Tell me more about the peasants' revolt.";
};


func int DIA_Rupert_Bauernaufstand_Condition()
{
	if((RupertMentionedOnar == TRUE) && (hero.guild != GIL_SLD) && (hero.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Rupert_Bauernaufstand_Info()
{
	AI_Output (other, self, "DIA_Rupert_Bauernaufstand_15_00");	//Tell me more about the peasants' revolt.
	AI_Output (self, other, "DIA_Rupert_Bauernaufstand_03_01");	//It's quite simple: Onar, the fat landowner, won't pay any more taxes to the city.
	AI_Output (self, other, "DIA_Rupert_Bauernaufstand_03_02");	//Imagine! We're at war with the orcs and the fat slob wants everything for himself!
	AI_Output (self, other, "DIA_Rupert_Bauernaufstand_03_03");	//Normally, the city guard would take firm measures in such cases.
	AI_Output (self, other, "DIA_Rupert_Bauernaufstand_03_04");	//But now comes the best part: they say Onar has hired mercenaries to keep the troops from the city off his back!
	AI_Output (self, other, "DIA_Rupert_Bauernaufstand_03_05");	//MERCENARIES! The whole thing will end in a damn war! As if ONE war weren't enough!
};


instance DIA_Rupert_Mercs(C_Info)
{
	npc = VLK_458_Rupert;
	nr = 4;
	condition = DIA_Rupert_Mercs_Condition;
	information = DIA_Rupert_Mercs_Info;
	permanent = FALSE;
	description = "What do you know about Onar's mercenaries?";
};


func int DIA_Rupert_Mercs_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rupert_Bauernaufstand) && (hero.guild != GIL_SLD) && (hero.guild != GIL_DJG))
	{
		return TRUE;
	};
};

func void DIA_Rupert_Mercs_Info()
{
	AI_Output (other, self, "DIA_Rupert_Mercs_15_00");	//What do you know about Onar's mercenaries?
	AI_Output (self, other, "DIA_Rupert_Mercs_03_01");	//I heard that most of them are former convicts from the mining colony.
	AI_Output (self, other, "DIA_Rupert_Mercs_03_02");	//And their leader is supposed to have been a big shot with the King - a general or something - whom they put away as a traitor!
	AI_Output (self, other, "DIA_Rupert_Mercs_03_03");	//These are terrible times.
};

