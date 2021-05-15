
instance DIA_Maria_EXIT(C_Info)
{
	npc = BAU_910_Maria;
	nr = 999;
	condition = DIA_Maria_EXIT_Condition;
	information = DIA_Maria_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Maria_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Maria_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Maria_Hallo(C_Info)
{
	npc = BAU_910_Maria;
	nr = 1;
	condition = DIA_Maria_Hallo_Condition;
	information = DIA_Maria_Hallo_Info;
	permanent = FALSE;
	description = "Who are you?";
};


func int DIA_Maria_Hallo_Condition()
{
	return TRUE;
};

func void DIA_Maria_Hallo_Info()
{
	AI_Output (other, self, "DIA_Maria_Hallo_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Maria_Hallo_17_01");	//I am Onar's wife, Maria.
	AI_Output (self, other, "DIA_Maria_Hallo_17_02");	//What do you want here?
};


instance DIA_Maria_Umsehen(C_Info)
{
	npc = BAU_910_Maria;
	nr = 2;
	condition = DIA_Maria_Umsehen_Condition;
	information = DIA_Maria_Umsehen_Info;
	permanent = FALSE;
	description = "I just wanted to have a look around here ...";
};


func int DIA_Maria_Umsehen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Maria_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Maria_Umsehen_Info()
{
	AI_Output (other, self, "DIA_Maria_Umsehen_15_00");	//I just wanted to have a look around here...
	AI_Output (self, other, "DIA_Maria_Umsehen_17_01");	//With all these men on the farm now, there's no peace to be had inside the house.
	AI_Output (self, other, "DIA_Maria_Umsehen_17_02");	//They just keep barging in here.
};


instance DIA_Maria_Soeldner(C_Info)
{
	npc = BAU_910_Maria;
	nr = 3;
	condition = DIA_Maria_Soeldner_Condition;
	information = DIA_Maria_Soeldner_Info;
	permanent = FALSE;
	description = "Do the mercenaries bother you?";
};


func int DIA_Maria_Soeldner_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Maria_Umsehen))
	{
		return TRUE;
	};
};

func void DIA_Maria_Soeldner_Info()
{
	AI_Output (other, self, "DIA_Maria_Soeldner_15_00");	//Do the mercenaries bother you?
	if ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_Maria_Soeldner_17_01");	//Oh well, forget what I just said - it's been a lot safer here since you guys showed up.
	}
	else
	{
		AI_Output (self, other, "DIA_Maria_Soeldner_17_02");	//Oh well, at least the farm has been a lot safer since the mercenaries came.
	};
	AI_Output (self, other, "DIA_Maria_Soeldner_17_03");	//Back when we were still on our own, the militia came from town all the time to plunder our provisions.
	AI_Output (self, other, "DIA_Maria_Soeldner_17_04");	//They dragged off the better part of the harvest. And they took some sheep, too. They did nothing for us in return.
	AI_Output (self, other, "DIA_Maria_Soeldner_17_05");	//A few of those scoundrels even stole from us.
	if (hero.guild == GIL_MIL)
	{
		AI_Output (self, other, "DIA_Maria_Soeldner_17_06");	//Don't get me wrong now, soldier. I know that not all of you are like that.
	};
};


instance DIA_Maria_Mission(C_Info)
{
	npc = BAU_910_Maria;
	nr = 4;
	condition = DIA_Maria_Mission_Condition;
	information = DIA_Maria_Mission_Info;
	permanent = FALSE;
	description = "So what did they steal from you?";
};


func int DIA_Maria_Mission_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Maria_Soeldner) && (MIS_Maria_BringPlate != LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Maria_Mission_Info()
{
	AI_Output (other, self, "DIA_Maria_Mission_15_00");	//So what did they steal from you?
	AI_Output (self, other, "DIA_Maria_Mission_17_01");	//Mostly gold and silver. They even took my wedding present. A golden plate.
	if (other.guild != GIL_MIL)
	{
		AI_Output (self, other, "DIA_Maria_Mission_17_02");	//I bet it's now gathering dust in the chest of some filthy city guard.
	};
	MIS_Maria_BringPlate = LOG_Running;
};


instance DIA_Maria_BringPlate(C_Info)
{
	npc = BAU_910_Maria;
	nr = 5;
	condition = DIA_Maria_BringPlate_Condition;
	information = DIA_Maria_BringPlate_Info;
	permanent = FALSE;
	description = "I have a golden plate here. Would this be yours?";
};


func int DIA_Maria_BringPlate_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Maria_Hallo) && Npc_HasItems(other,ItMi_MariasGoldPlate))
	{
		return TRUE;
	};
};

func void DIA_Maria_BringPlate_Info()
{
	B_GiveInvItems (other, self, ItMi_MariasGoldPlate, 1);
	AI_Output (other, self, "DIA_Maria_BringPlate_15_00");	//I have a golden plate here. Would this be yours?
	AI_Output (self, other, "DIA_Maria_BringPlate_17_01");	//Yes! That is it! Thanks a million!
	MIS_Maria_BringPlate = LOG_SUCCESS;
	B_GivePlayerXP(XP_Maria_Teller);
};


var int Maria_Belohnung;

instance DIA_Maria_Belohnung(C_Info)
{
	npc = BAU_910_Maria;
	nr = 6;
	condition = DIA_Maria_Belohnung_Condition;
	information = DIA_Maria_Belohnung_Info;
	permanent = TRUE;
	description = "So what about my reward?";
};


func int DIA_Maria_Belohnung_Condition()
{
	if((MIS_Maria_BringPlate == LOG_SUCCESS) && (Maria_Belohnung == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Maria_Belohnung_Info()
{
	AI_Output(other,self,"DIA_Maria_Belohnung_15_00");	//So what about my reward?
	if(other.guild == GIL_SLD)
	{
		AI_Output (self, other, "DIA_Maria_Belohnung_17_01");	//You're working for my husband as a mercenary, aren't you?
		AI_Output (other, self, "DIA_Maria_Belohnung_15_02");	//Right.
		AI_Output (self, other, "DIA_Maria_Belohnung_17_03");	//How much is my husband paying you?
		if(Npc_KnowsInfo(other,DIA_Onar_HowMuch))
		{
			if(Onar_SOLD_Gold == 50)
			{
				AI_Output(other,self,"DIA_Lehmar_GELDLEIHEN_50_15_00");	//50 gold coins.
			}
			else if(Onar_SOLD_Gold == 40)
			{
				AI_Output(other,self,"DIA_Maria_Belohnung_15_03_40_add");	//40 gold coins.
			}
			else if(Onar_SOLD_Gold == 30)
			{
				AI_Output(other,self,"DIA_Maria_Belohnung_15_03_30_add");	//30 gold pieces.
			}
			else if(Onar_SOLD_Gold == 20)
			{
				AI_Output(other,self,"DIA_Rukhar_RANDOLPHWILL_20_15_00");	//20
			}
			else if(Onar_SOLD_Gold == 10)
			{
				AI_Output(other,self,"DIA_Rukhar_RANDOLPHWILL_10_15_00");	//10 gold coins
			}
			else if(Onar_SOLD_Gold < 10)
			{
				AI_Output(other,self,"DIA_Moe_Hallo_Zahlen_15_04");	//... but I don't even have 10 gold pieces.
			};
		AI_Output (self, other, "DIA_Maria_Belohnung_17_04");	//That's not enough. Go to him and tell him to pay you more.
		AI_Output (other, self, "DIA_Maria_Belohnung_15_05");	//And you think he'll do that?
		AI_Output (self, other, "DIA_Maria_Belohnung_17_06");	//He knows what happens if he doesn't. Believe me.
			Maria_MehrGold = TRUE;
			Maria_Belohnung = TRUE;
		}
		else
		{
			DIA_Common_Well();
			AI_Output(self,other,"DIA_Maria_Belohnung_SOLD_17_02");	//Come back when you have discussed your pay with my husband.
		};
	}
	else if(other.guild == GIL_NONE)
	{
		AI_Output (self, other, "DIA_Maria_Belohnung_17_07");	//Do you want to hire on as a mercenary here on the farm?
		Info_ClearChoices (DIA_Maria_Belohnung);
		Info_AddChoice (DIA_Maria_Belohnung, "No - not really.", DIA_Maria_Belohnung_Gold);
		Info_AddChoice (DIA_Maria_Belohnung, "Yes.", DIA_Maria_Belohnung_SOLD);
	}
	else
	{
		AI_Output(self,other,"DIA_Maria_Belohnung_17_08");	//Here, take this. You deserve it.
		B_GiveInvItems(self,other,ItMi_Gold,50);
		Maria_Belohnung = TRUE;
	};
};

func void DIA_Maria_Belohnung_Gold()
{
	AI_Output(other,self,"DIA_Maria_Belohnung_Gold_15_00");	//No - not really.
	AI_Output(self,other,"DIA_Maria_Belohnung_Gold_17_01");	//Then take this gold as a reward. You've earned it.
	B_GiveInvItems(self,other,ItMi_Gold,50);
	Maria_Belohnung = TRUE;
	Info_ClearChoices(DIA_Maria_Belohnung);
};

func void DIA_Maria_Belohnung_SOLD()
{
	AI_Output (other, self, "DIA_Maria_Belohnung_SOLD_15_00");	//Yes.
	AI_Output (self, other, "DIA_Maria_Belohnung_SOLD_17_01");	//All right, if you work here, then I shall see to it that you're getting a decent pay.
	if(!Npc_KnowsInfo(other,DIA_Onar_HowMuch))
	{
		AI_Output(self,other,"DIA_Maria_Belohnung_SOLD_17_02");	//Come back when you have discussed your pay with my husband.
	};
	Info_ClearChoices(DIA_Maria_Belohnung);
};


instance DIA_Maria_AboutOnar(C_Info)
{
	npc = BAU_910_Maria;
	nr = 7;
	condition = DIA_Maria_AboutOnar_Condition;
	information = DIA_Maria_AboutOnar_Info;
	permanent = FALSE;
	description = "Tell me about Onar.";
};


func int DIA_Maria_AboutOnar_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Maria_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Maria_AboutOnar_Info()
{
	AI_Output (other, self, "DIA_Maria_AboutOnar_15_00");	//Tell me about Onar.
	AI_Output (self, other, "DIA_Maria_AboutOnar_17_01");	//He's a good man. A little grumpy and very impatient, but we've all got our faults.
	AI_Output (self, other, "DIA_Maria_AboutOnar_17_02");	//I told my husband, why do you let the soldiers from the city treat you like that?
	AI_Output (self, other, "DIA_Maria_AboutOnar_17_03");	//Do something, I said.
	AI_Output (self, other, "DIA_Maria_AboutOnar_17_04");	//So he hired the mercenaries. Now I feel like I'm in the middle of a war.
	AI_Output (self, other, "DIA_Maria_AboutOnar_17_05");	//But then, we ARE at war, aren't we?
};


instance DIA_Maria_PERM(C_Info)
{
	npc = BAU_910_Maria;
	nr = 8;
	condition = DIA_Maria_PERM_Condition;
	information = DIA_Maria_PERM_Info;
	permanent = FALSE;
	description = "Has anything exciting happened here lately?";
};


func int DIA_Maria_PERM_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Maria_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Maria_PERM_Info()
{
	AI_Output (other, self, "DIA_Maria_PERM_15_00");	//Has anything exciting happened here lately?
	if (Kapitel <= 2)
	{
		AI_Output (self, other, "DIA_Maria_PERM_17_01");	//The paladins passed by here.
		AI_Output (self, other, "DIA_Maria_PERM_17_02");	//At first we thought they were going to attack the farm, but the were headed for the Valley of Mines.
	}
	else if(Kapitel == 3)
	{
		AI_Output(self,other,"DIA_Maria_PERM_17_03");	//Wasili chased off a thief a few nights ago. Apart from that, everything's been quiet.
	}
	else if(Kapitel >= 4)
	{
		AI_Output(self,other,"DIA_Maria_PERM_17_04");	//It's been a lot quieter here since some of the mercenaries left.
	};
};


instance DIA_Maria_PICKPOCKET(C_Info)
{
	npc = BAU_910_Maria;
	nr = 900;
	condition = DIA_Maria_PICKPOCKET_Condition;
	information = DIA_Maria_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60_Female;
};


func int DIA_Maria_PICKPOCKET_Condition()
{
	return C_Beklauen(60,110);
};

func void DIA_Maria_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Maria_PICKPOCKET);
	Info_AddChoice(DIA_Maria_PICKPOCKET,Dialog_Back,DIA_Maria_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Maria_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Maria_PICKPOCKET_DoIt);
};

func void DIA_Maria_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Maria_PICKPOCKET);
};

func void DIA_Maria_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Maria_PICKPOCKET);
};

