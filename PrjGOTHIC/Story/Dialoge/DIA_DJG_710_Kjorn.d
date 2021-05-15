
instance DIA_Kjorn_EXIT(C_Info)
{
	npc = DJG_710_Kjorn;
	nr = 999;
	condition = DIA_Kjorn_EXIT_Condition;
	information = DIA_Kjorn_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Kjorn_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Kjorn_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Kjorn_Hello(C_Info)
{
	npc = DJG_710_Kjorn;
	nr = 4;
	condition = DIA_Kjorn_Hello_Condition;
	information = DIA_Kjorn_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Kjorn_Hello_Condition()
{
	if((Npc_GetDistToNpc(self,hero) < 300) || Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Kjorn_Hello_Info()
{
	AI_Output (self, other, "DIA_Kjorn_Hello_06_00");	//Hey, come over here!
	AI_Output (other, self, "DIA_Kjorn_Hello_15_01");	//What do you want?
	AI_Output (self, other, "DIA_Kjorn_Hello_06_02");	//This valley is a dangerous place, and without the right equipment you'll find yourself dead in no time.
	AI_Output (other, self, "DIA_Kjorn_Hello_15_03");	//I assume that YOU've got the right equipment.
	AI_Output (self, other, "DIA_Kjorn_Hello_06_04");	//You guessed it. I might even sell it to you.
	Log_CreateTopic(TOPIC_OutTrader,LOG_NOTE);
	B_LogEntry(TOPIC_OutTrader,"Kjorn the dragon hunter can sell me equipment and provisions.");
};


instance DIA_Kjorn_TRADE(C_Info)
{
	npc = DJG_710_Kjorn;
	nr = 4;
	condition = DIA_Kjorn_TRADE_Condition;
	information = DIA_Kjorn_TRADE_Info;
	trade = TRUE;
	permanent = TRUE;
	description = "What can you offer me?";
};


func int DIA_Kjorn_TRADE_Condition()
{
	return TRUE;
};

func void DIA_Kjorn_TRADE_Info()
{
	AI_Output(other,self,"DIA_Kjorn_TRADE_15_00");	//What can you offer me?
	B_GiveTradeInv(self);
	Trade_IsActive = TRUE;
};


instance DIA_Kjorn_SellInfos(C_Info)
{
	npc = DJG_710_Kjorn;
	nr = 5;
	condition = DIA_Kjorn_SellInfos_Condition;
	information = DIA_Kjorn_SellInfos_Info;
	permanent = FALSE;
	description = "Do you sell information as well?";
};


func int DIA_Kjorn_SellInfos_Condition()
{
	return TRUE;
};

func void DIA_Kjorn_SellInfos_Info()
{
	AI_Output (other, self, "DIA_Kjorn_SellInfos_15_00");	//Do you sell information as well?
	AI_Output (self, other, "DIA_Kjorn_SellInfos_06_01");	//That depends. If the price is right, I'll tell you everything I know.
	AI_Output (other, self, "DIA_Kjorn_SellInfos_15_02");	//How much do you charge?
	AI_Output (self, other, "DIA_Kjorn_SellInfos_06_03");	//Hmm... hard to say. But I think that 50 gold pieces for every piece of information I give you sounds about right.
};


instance DIA_Kjorn_BuyInfos(C_Info)
{
	npc = DJG_710_Kjorn;
	nr = 5;
	condition = DIA_Kjorn_BuyInfos_Condition;
	information = DIA_Kjorn_BuyInfos_Info;
	permanent = TRUE;
	description = "I need some information.";
};


func int DIA_Kjorn_BuyInfos_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kjorn_SellInfos))
	{
		return TRUE;
	};
};

func void DIA_Kjorn_BuyInfos_Info()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_15_00");	//I need some information.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_06_01");	//50 gold pieces!
	Info_ClearChoices (DIA_Kjorn_BuyInfos);
	Info_AddChoice (DIA_Kjorn_BuyInfos, "That's too expensive for me.", DIA_Kjorn_BuyInfos_HoldMoney);
	if (Npc_HasItems (other, ItMi_Gold) >= 50)
	{
		Info_AddChoice (DIA_Kjorn_BuyInfos, "Yes, here.", DIA_Kjorn_BuyInfos_GiveMoney);
	};
};

func void DIA_Kjorn_BuyInfos_HoldMoney()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_HoldMoney_15_00");	//That's too expensive for me.
	Info_ClearChoices (DIA_Kjorn_BuyInfos);
};

func void DIA_Kjorn_BuyInfos_GiveMoney()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_GiveMoney_15_00");	//Yes, here.
	B_GiveInvItems (other, self, ItMi_Gold, 50);
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_GiveMoney_15_01");	//Now tell me...
	Info_ClearChoices (DIA_Kjorn_BuyInfos);
	Info_AddChoice (DIA_Kjorn_BuyInfos, Dialog_Back, DIA_Kjorn_BuyInfos_Back);
	if (KjornToldDragon == 0)
	{
		Info_AddChoice (DIA_Kjorn_BuyInfos, "... about the dragons.", DIA_Kjorn_BuyInfos_Dragon1);
	}
	else if(KjornToldDragon == 1)
	{
		Info_AddChoice (DIA_Kjorn_BuyInfos, "... more about the dragons.", DIA_Kjorn_BuyInfos_Dragon2);
	};
	if(KjornToldColony == 0)
	{
		Info_AddChoice (DIA_Kjorn_BuyInfos, "... about the Valley of Mines.", DIA_Kjorn_BuyInfos_Colony1);
	}
	else if(KjornToldColony == 1)
	{
		Info_AddChoice (DIA_Kjorn_BuyInfos, "... more about the Valley of Mines.", DIA_Kjorn_BuyInfos_Colony2);
	};
	if(KjornToldOldCamp == 0)
	{
		Info_AddChoice (DIA_Kjorn_BuyInfos, "... about the castle.", DIA_Kjorn_BuyInfos_OldCamp1);
	};
	if(KjorntoldOrks == 0)
	{
		Info_AddChoice (DIA_Kjorn_BuyInfos, "... about the orcs.", DIA_Kjorn_BuyInfos_Orks1);
	}
	else if(KjorntoldOrks == 1)
	{
		Info_AddChoice (DIA_Kjorn_BuyInfos, "... more about the orcs.", DIA_Kjorn_BuyInfos_Orks2);
	};
};

func void DIA_Kjorn_BuyInfos_Back()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_Back_15_00");	//You know, just give me back my money, I changed my mind.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Back_06_01");	//Suit yourself.
	B_GiveInvItems (self, other, ItMi_Gold, 50);
	Info_ClearChoices (DIA_Kjorn_BuyInfos);
};

func void DIA_Kjorn_BuyInfos_Dragon1()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_Dragon1_15_00");	//Tell me about the dragons.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Dragon1_06_01");	//Dragons are ancient, incredibly powerful creatures. Once there were thousands of them living all over the world.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Dragon1_06_02");	//It's been over a hundred years, though, that any of them were seen.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Dragon1_06_03");	//Their blood is as hot as boiling oil. If they look into your eyes, your heart will turn to stone. So I've heard ...
	KjornToldDragon = 1;
	Info_ClearChoices(DIA_Kjorn_BuyInfos);
};

func void DIA_Kjorn_BuyInfos_Dragon2()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_Dragon2_15_00");	//Tell me more about the dragons.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Dragon2_06_01");	//But all dragons are not alike.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Dragon2_06_02");	//Some of them could cover the entire land with a layer of ice several feet thick.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Dragon2_06_03");	//Others prefer living in swampy surroundings, or in volcanoes.
	B_LogEntry (TOPIC_DRACHENJAGD, "Kjorn the Dragon Hunter thinks there are different kinds of dragons. Some supposedly prefer cold, damp places, others seem to like fire better.");
	KjornToldDragon = 2;
	Info_ClearChoices(DIA_Kjorn_BuyInfos);
};

func void DIA_Kjorn_BuyInfos_Colony1()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_Colony1_15_00");	//Tell me about the Valley of Mines.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Colony1_06_01");	//The Valley of Mines of Khorinis is known all over the country for its magic ore.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Colony1_06_02");	//These mountains are the only place where the magic ore can be found.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Colony1_06_03");	//A weapon forged from this ore is virtually unbreakable and will cut through the strongest armor.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Colony1_06_04");	//Until a few weeks ago, the entire valley was surrounded by a magic barrier. It was impenetrable, and nobody could get out.
	KjornToldColony = 1;
	Info_ClearChoices(DIA_Kjorn_BuyInfos);
};

func void DIA_Kjorn_BuyInfos_Colony2()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_Colony2_15_00");	//Tell me more about the Valley of Mines.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Colony2_06_01");	//The valley has changed a lot during these last few days.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Colony2_06_02");	//When the orcs came, other horrible creatures showed up as well, the likes of which have never been seen around here before.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Colony2_06_03");	//They say that a few lonely hunters are still about, but I'm not sure whether they're even still alive.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Colony2_06_04");	//It seems like all the creatures of Beliar have flocked together in this very valley.
	KjornToldColony = 2;
	Info_ClearChoices(DIA_Kjorn_BuyInfos);
};

func void DIA_Kjorn_BuyInfos_OldCamp1()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_OldCamp1_15_00");	//Tell me about the castle.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_OldCamp1_06_01");	//It lies pretty much in the center of the Valley of Mines.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_OldCamp1_06_02");	//Back when the valley was still a prison, the ore barons controlled the entire ore trade from there.
	KjornToldOldCamp = 1;
	Info_ClearChoices(DIA_Kjorn_BuyInfos);
};

func void DIA_Kjorn_BuyInfos_Orks1()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_Orks1_15_00");	//Tell me about the orcs.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Orks1_06_01");	//The orcs haven't been here for long. At least those orcs in front of the castle, that is.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Orks1_06_02");	//But I'm wondering about how well they're organized. Orcs usually attack blindly, no matter what.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Orks1_06_03");	//These orcs are biding their time. They're waiting, but we don't know for what.
	KjorntoldOrks = 1;
	Info_ClearChoices(DIA_Kjorn_BuyInfos);
};

func void DIA_Kjorn_BuyInfos_Orks2()
{
	AI_Output (other, self, "DIA_Kjorn_BuyInfos_Orks2_15_00");	//Tell me more about the orcs.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Orks2_06_01");	//The orcs are led by elite warriors. Those warriors are very strong and heavily armored. They are almost impossible to defeat.
	AI_Output (self, other, "DIA_Kjorn_BuyInfos_Orks2_06_02");	//I once saw one of them fell a fully-grown oak tree with one blow of his axe.
	KjorntoldOrks = 2;
	Info_ClearChoices(DIA_Kjorn_BuyInfos);
};


instance DIA_Kjorn_AllDragonsDead(C_Info)
{
	npc = DJG_710_Kjorn;
	nr = 5;
	condition = DIA_Kjorn_AllDragonsDead_Condition;
	information = DIA_Kjorn_AllDragonsDead_Info;
	permanent = FALSE;
	description = "I killed all the dragons!";
};


func int DIA_Kjorn_AllDragonsDead_Condition()
{
	if(MIS_AllDragonsDead == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Kjorn_AllDragonsDead_Info()
{
	AI_Output (other, self, "DIA_Kjorn_AllDragonsDead_15_00");	//I killed all the dragons!
	AI_Output (self, other, "DIA_Kjorn_AllDragonsDead_06_01");	//(laughs) Sure, and I'm a paladin.
	AI_Output (self, other, "DIA_Kjorn_AllDragonsDead_06_02");	//You might have killed ONE, but all of them? Go find somebody else who will believe you.
};


instance DIA_Kjorn_PICKPOCKET(C_Info)
{
	npc = DJG_710_Kjorn;
	nr = 900;
	condition = DIA_Kjorn_PICKPOCKET_Condition;
	information = DIA_Kjorn_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60;
};


func int DIA_Kjorn_PICKPOCKET_Condition()
{
	return C_Beklauen(47,75);
};

func void DIA_Kjorn_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Kjorn_PICKPOCKET);
	Info_AddChoice(DIA_Kjorn_PICKPOCKET,Dialog_Back,DIA_Kjorn_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Kjorn_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Kjorn_PICKPOCKET_DoIt);
};

func void DIA_Kjorn_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Kjorn_PICKPOCKET);
};

func void DIA_Kjorn_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Kjorn_PICKPOCKET);
};

