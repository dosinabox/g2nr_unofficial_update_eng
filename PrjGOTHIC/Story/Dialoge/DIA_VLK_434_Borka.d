
instance DIA_Borka_EXIT(C_Info)
{
	npc = VLK_434_Borka;
	nr = 999;
	condition = DIA_Borka_EXIT_Condition;
	information = DIA_Borka_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Borka_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Borka_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Borka_PICKPOCKET(C_Info)
{
	npc = VLK_434_Borka;
	nr = 900;
	condition = DIA_Borka_PICKPOCKET_Condition;
	information = DIA_Borka_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Borka_PICKPOCKET_Condition()
{
	return C_Beklauen(80,120);
};

func void DIA_Borka_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Borka_PICKPOCKET);
	Info_AddChoice(DIA_Borka_PICKPOCKET,Dialog_Back,DIA_Borka_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Borka_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Borka_PICKPOCKET_DoIt);
};

func void DIA_Borka_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Borka_PICKPOCKET);
};

func void DIA_Borka_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Borka_PICKPOCKET);
};


instance DIA_Borka_PISSOFF(C_Info)
{
	npc = VLK_434_Borka;
	condition = DIA_Borka_PISSOFF_Condition;
	information = DIA_Borka_PISSOFF_Info;
	important = TRUE;
	permanent = FALSE;
};


func int DIA_Borka_PISSOFF_Condition()
{
	if((Npc_GetDistToNpc(self,other) <= ZivilAnquatschDist) || Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Borka_PISSOFF_Info()
{
	AI_Output(self,other,"DIA_Borka_PISSOFF_11_00");	//Hey, you! Where are you going? No matter what your plans are - there'll be plenty of time later.
	if(Npc_GetDistToWP(other,"NW_CITY_HABOUR_PUFF_IN_01") > 200)
	{
		AI_Output(self,other,"DIA_Borka_PISSOFF_11_01");	//You're right in front of the pearl of Khorinis - the RED LANTERN. This is the most beautiful brothel in all of Myrtana, damnit!
	};
	AI_Output (self, other, "DIA_Borka_PISSOFF_11_02");	//Sailors from the most remote corners of the world dock here just to spend a few nights in the Red Lantern.
	AI_Output (self, other, "DIA_Borka_PISSOFF_11_03");	//And now it's you who has the chance - nay, the honor - of spending a night with Nadja, the most passionate flower of the gods!
	AI_Output (self, other, "DIA_Borka_PISSOFF_11_04");	//Come on in and you're going to experience what others cannot even dream of!
	if(!Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) || (other.attribute[ATR_DEXTERITY] < 70) || (self.aivar[AIV_PlayerHasPickedMyPocket] == TRUE))
	{
		if(MIS_Andre_REDLIGHT != LOG_Running)
		{
			AI_StopProcessInfos(self);
		};
	};
};


instance DIA_Borka_TROUBLE(C_Info)
{
	npc = VLK_434_Borka;
	nr = 3;
	condition = DIA_Borka_TROUBLE_Condition;
	information = DIA_Borka_TROUBLE_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_Borka_TROUBLE_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && !Npc_IsDead(Nadja) && (Npc_GetDistToWP(self,"NW_CITY_HABOUR_PUFF_ENTRANCE") <= 500))
	{
		return TRUE;
	};
};

func void DIA_Borka_TROUBLE_Info()
{
	AI_Output (self, other, "DIA_Borka_TROUBLE_11_00");	//What are you standing around for out here? Go on in and meet our passionate Nadja.
	AI_Output (self, other, "DIA_Borka_TROUBLE_11_01");	//This hot creature of the night will give your life a new meaning!
	if(!Npc_GetTalentSkill(other,NPC_TALENT_PICKPOCKET) || (other.attribute[ATR_DEXTERITY] < 70) || (self.aivar[AIV_PlayerHasPickedMyPocket] == TRUE))
	{
		if(MIS_Andre_REDLIGHT != LOG_Running)
		{
			AI_StopProcessInfos(self);
		};
	};
};


instance DIA_Borka_Smoke(C_Info)
{
	npc = VLK_434_Borka;
	nr = 3;
	condition = DIA_Borka_Smoke_Condition;
	information = DIA_Borka_Smoke_Info;
	permanent = FALSE;
	description = "Do you know where I can buy some weed?";
};


func int DIA_Borka_Smoke_Condition()
{
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Borka_Smoke_Info()
{
	AI_Output (other, self, "DIA_Borka_Smoke_15_00");	//Do you know where I could buy some weed?
	AI_Output (self, other, "DIA_Borka_Smoke_11_01");	//No, piss off!
	AI_StopProcessInfos (self);
};


func void B_Borka_RefuseToTalk()
{
	AI_Output(self,other,"DIA_Borka_BUYHERB_11_01");	//I'm sorry, Mr. City Guard, sir. There must have been a mistake. I know nothing about weed.
	Borka_RefuseToTalk = TRUE;
};

instance DIA_Borka_BUYHERB(C_Info)
{
	npc = VLK_434_Borka;
	nr = 2;
	condition = DIA_Borka_BUYHERB_Condition;
	information = DIA_Borka_BUYHERB_Info;
	permanent = TRUE;
	description = "I've heard you're selling weed.";
};


func int DIA_Borka_BUYHERB_Condition()
{
	if((MIS_Andre_REDLIGHT == LOG_Running) && (Knows_Borka_Dealer == TRUE) && (Borka_RefuseToTalk == FALSE) && (Nadja_Victim == FALSE) && (Borka_Deal == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Borka_BUYHERB_Info()
{
	AI_Output(other,self,"DIA_Borka_BUYHERB_15_00");	//'ve heard you're selling weed.
	if(Undercover_Failed_Borka == TRUE)
	{
		B_Borka_RefuseToTalk();
	}
	else
	{
		AI_Output (self, other, "DIA_Borka_BUYHERB_11_02");	//Says who?
		Info_ClearChoices (DIA_Borka_BUYHERB);
		Info_AddChoice (DIA_Borka_BUYHERB, "That's not important.", DIA_Borka_BUYHERB_Egal);
		Info_AddChoice (DIA_Borka_BUYHERB, "Says Nadja.", DIA_Borka_BUYHERB_Nadja);
	};
};

func void DIA_Borka_BUYHERB_Egal()
{
	AI_Output (other, self, "DIA_Borka_BUYHERB_Egal_15_00");	//That is besides the point.
	AI_Output (self, other, "DIA_Borka_BUYHERB_Egal_11_01");	//I just want to know who sent you so I can be sure you're all right.
	Info_ClearChoices (DIA_Borka_BUYHERB);
	Info_AddChoice (DIA_Borka_BUYHERB, "Says Nadja.", DIA_Borka_BUYHERB_Nadja);
	Info_AddChoice (DIA_Borka_BUYHERB, "So do you want to cut a deal, or not?", DIA_Borka_BUYHERB_Deal);
};

func void DIA_Borka_BUYHERB_Nadja()
{
	AI_Output (other, self, "DIA_Borka_BUYHERB_NADJA_15_00");	//Says Nadja.
	AI_Output (self, other, "DIA_Borka_BUYHERB_NADJA_11_01");	//What do you know, the little bird has sung. You know, you shouldn't believe everything this gal tells you.
	Nadja_Victim = TRUE;
	Undercover_Failed = TRUE;
	Info_ClearChoices(DIA_Borka_BUYHERB);
};

func void DIA_Borka_BUYHERB_Deal()
{
	AI_Output (other, self, "DIA_Borka_BUYHERB_Deal_15_00");	//So do you want to cut a deal, or not?
	AI_PlayAni (self, "T_SEARCH");
	AI_Output (self, other, "DIA_Borka_BUYHERB_Deal_11_01");	//... all right ... let's make a deal. You give me 50 gold pieces, and then you'll get your weed. No haggling.
	Info_ClearChoices (DIA_Borka_BUYHERB);
	Borka_Deal = TRUE;
};


instance DIA_Borka_SECOND_CHANCE(C_Info)
{
	npc = VLK_434_Borka;
	nr = 2;
	condition = DIA_Borka_SECOND_CHANCE_Condition;
	information = DIA_Borka_SECOND_CHANCE_Info;
	permanent = TRUE;
	description = "Let's make a deal (pay 50 gold).";
};


func int DIA_Borka_SECOND_CHANCE_Condition()
{
	if((Borka_Deal == TRUE) && (Npc_HasItems(other,ItMi_Gold) >= 50) && (Borka_RefuseToTalk == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Borka_SECOND_CHANCE_Info()
{
	AI_Output(other,self,"DIA_Borka_SECOND_CHANCE_15_00");	//Let's make a deal. Here's the gold.
	if(Undercover_Failed_Borka == TRUE)
	{
		B_Borka_RefuseToTalk();
	}
	else
	{
		B_GiveInvItems(hero,self,ItMi_Gold,50);
		AI_Output(self,other,"DIA_Borka_SECOND_CHANCE_11_01");	//All right...
		AI_PlayAni(self,"T_SEARCH");
		AI_Output(self,other,"DIA_Borka_SECOND_CHANCE_11_02");	//...here's a fresh, resinous stalk of weed.
		B_GiveInvItems(self,hero,ItMi_Joint,1);
		Borka_Deal = 2;
	};
	AI_StopProcessInfos(self);
};

