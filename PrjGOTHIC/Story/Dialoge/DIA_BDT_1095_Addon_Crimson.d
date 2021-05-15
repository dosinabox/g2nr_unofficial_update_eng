
instance DIA_Addon_Crimson_EXIT(C_Info)
{
	npc = BDT_1095_Addon_Crimson;
	nr = 999;
	condition = DIA_Addon_Crimson_EXIT_Condition;
	information = DIA_Addon_Crimson_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Crimson_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Crimson_EXIT_Info()
{
	Wld_StopEffect("DEMENTOR_FX");
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Crimson_PICKPOCKET(C_Info)
{
	npc = BDT_1095_Addon_Crimson;
	nr = 900;
	condition = DIA_Addon_Crimson_PICKPOCKET_Condition;
	information = DIA_Addon_Crimson_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_80;
};


func int DIA_Addon_Crimson_PICKPOCKET_Condition()
{
	return C_Beklauen(66,66);
};

func void DIA_Addon_Crimson_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Crimson_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Crimson_PICKPOCKET,Dialog_Back,DIA_Addon_Crimson_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Crimson_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Crimson_PICKPOCKET_DoIt);
};

func void DIA_Addon_Crimson_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Crimson_PICKPOCKET);
};

func void DIA_Addon_Crimson_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Crimson_PICKPOCKET);
};


instance DIA_Addon_Crimson_Hi(C_Info)
{
	npc = BDT_1095_Addon_Crimson;
	nr = 2;
	condition = DIA_Addon_Crimson_Hi_Condition;
	information = DIA_Addon_Crimson_Hi_Info;
	permanent = FALSE;
	description = "What are you doing? Are you melting down your gold?";
};


func int DIA_Addon_Crimson_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Crimson_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_Crimson_Hi_15_00");	//What are you doing? Are you melting down your gold?
	AI_Output (self, other, "DIA_Addon_Crimson_Hi_10_01");	//No, I'm washing vegetables. Of course, I'm melting down gold - and I'm making coins out of it.
	AI_Output (self, other, "DIA_Addon_Crimson_Hi_10_02");	//Because, just imagine: one fine evening Raven comes along and shoves a coin die in my hands.
	AI_Output (self, other, "DIA_Addon_Crimson_Hi_10_03");	//Out of one single gold nugget, I can mint a heap of coins - I'm so good that no one can tell the difference!
};


instance DIA_Addon_Crimson_How(C_Info)
{
	npc = BDT_1095_Addon_Crimson;
	nr = 2;
	condition = DIA_Addon_Crimson_How_Condition;
	information = DIA_Addon_Crimson_How_Info;
	permanent = FALSE;
	description = "How many coins will you give me for one nugget?";
};


func int DIA_Addon_Crimson_How_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Crimson_Hi))
	{
		return TRUE;
	};
};

func void DIA_Addon_Crimson_How_Info()
{
	AI_Output (other, self, "DIA_Addon_Crimson_How_15_00");	//How many coins will you give me for one nugget?
	AI_Output (self, other, "DIA_Addon_Crimson_How_10_01");	//Well, I don't know you at all, but I'll make you a special price. For one nugget I'll give you...
	B_Say_Gold (self, other, 10);
};


instance DIA_Addon_Crimson_Feilsch(C_Info)
{
	npc = BDT_1095_Addon_Crimson;
	nr = 2;
	condition = DIA_Addon_Crimson_Feilsch_Condition;
	information = DIA_Addon_Crimson_Feilsch_Info;
	permanent = FALSE;
	description = "Let's haggle!";
};


func int DIA_Addon_Crimson_Feilsch_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Crimson_How))
	{
		return TRUE;
	};
};

func void DIA_Addon_Crimson_Feilsch_Info()
{
	AI_Output (other, self, "DIA_Addon_Crimson_Feilsch_15_00");	//Let's haggle!
	AI_Output (self, other, "DIA_Addon_Crimson_Feilsch_10_01");	//Hmm...no. That's the standard price EVERYONE gets.
	AI_Output (other, self, "DIA_Addon_Crimson_Feilsch_15_02");	//I thought that was a special price.
	AI_Output (self, other, "DIA_Addon_Crimson_Feilsch_10_03");	//It is. Everyone here is special to me.
};


instance DIA_Addon_Crimson_Gold(C_Info)
{
	npc = BDT_1095_Addon_Crimson;
	nr = 99;
	condition = DIA_Addon_Crimson_Gold_Condition;
	information = DIA_Addon_Crimson_Gold_Info;
	permanent = TRUE;
	description = "Trade gold nuggets...";
};


func int DIA_Addon_Crimson_Gold_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Crimson_How))
	{
		return TRUE;
	};
};

func void DIA_Addon_Crimson_Gold_Info()
{
	AI_Output(other,self,"DIA_Addon_Crimson_Gold_15_00");	//Let's trade...
	if(self.aivar[AIV_DefeatedByPlayer] == TRUE)
	{
		B_Say(self,other,"$NOTNOW");
		Wld_StopEffect("DEMENTOR_FX");
		AI_StopProcessInfos(self);
	}
	else
	{
		Info_ClearChoices(DIA_Addon_Crimson_Gold);
		Info_AddChoice(DIA_Addon_Crimson_Gold,Dialog_Back,DIA_Addon_Crimson_Gold_BACK);
		if(Npc_HasItems(other,ItMi_GoldNugget_Addon))
		{
			if(Npc_HasItems(other,ItMi_GoldNugget_Addon) > 1)
			{
				Info_AddChoice(DIA_Addon_Crimson_Gold,DIALOG_SellGoldNuggets,DIA_Addon_Crimson_Gold_ALLE);
			};
			Info_AddChoice(DIA_Addon_Crimson_Gold,DIALOG_SellGoldNugget,DIA_Addon_Crimson_Gold_1);
		}
		else
		{
			AI_Output(self,other,"DIA_Addon_Crimson_Gold_10_01");	//But you don't have any gold nuggets on you.
		};
	};
};

func void DIA_Addon_Crimson_Gold_BACK()
{
	Info_ClearChoices(DIA_Addon_Crimson_Gold);
};

func void DIA_Addon_Crimson_Gold_ALLE()
{
	var int CurrentNuggets;
	CurrentNuggets = Npc_HasItems(other,ItMi_GoldNugget_Addon);
	B_GiveInvItems(other,self,ItMi_GoldNugget_Addon,CurrentNuggets);
	B_GiveInvItems(self,other,ItMi_Gold,CurrentNuggets * 10);
	Npc_RemoveInvItems(self,ItMi_GoldNugget_Addon,Npc_HasItems(self,ItMi_GoldNugget_Addon));
	Info_ClearChoices(DIA_Addon_Crimson_Gold);
/*	Info_AddChoice(DIA_Addon_Crimson_Gold,Dialog_Back,DIA_Addon_Crimson_Gold_BACK);
	if(Npc_HasItems(other,ItMi_GoldNugget_Addon))
	{
		if(Npc_HasItems(other,ItMi_GoldNugget_Addon) > 1)
		{
			Info_AddChoice(DIA_Addon_Crimson_Gold,DIALOG_SellGoldNuggets,DIA_Addon_Crimson_Gold_ALLE);
		};
		Info_AddChoice(DIA_Addon_Crimson_Gold,DIALOG_SellGoldNugget,DIA_Addon_Crimson_Gold_1);
	};*/
};

func void DIA_Addon_Crimson_Gold_1()
{
	B_GiveInvItems(other,self,ItMi_GoldNugget_Addon,1);
	B_GiveInvItems(self,other,ItMi_Gold,10);
	Npc_RemoveInvItems(self,ItMi_GoldNugget_Addon,Npc_HasItems(self,ItMi_GoldNugget_Addon));
	Info_ClearChoices(DIA_Addon_Crimson_Gold);
	Info_AddChoice(DIA_Addon_Crimson_Gold,Dialog_Back,DIA_Addon_Crimson_Gold_BACK);
	if(Npc_HasItems(other,ItMi_GoldNugget_Addon))
	{
		if(Npc_HasItems(other,ItMi_GoldNugget_Addon) > 1)
		{
			Info_AddChoice(DIA_Addon_Crimson_Gold,DIALOG_SellGoldNuggets,DIA_Addon_Crimson_Gold_ALLE);
		};
		Info_AddChoice(DIA_Addon_Crimson_Gold,DIALOG_SellGoldNugget,DIA_Addon_Crimson_Gold_1);
	};
};

func void B_Say_CrimsonBeliar()
{
	AI_Output (self, other, "DIA_Addon_Crimson_FATAGN_LOS_10_00");	//(conjuring) KHARDIMON FATAGN SHATAR FATAGN BELIAR.
};


instance DIA_Addon_Crimson_Raven(C_Info)
{
	npc = BDT_1095_Addon_Crimson;
	nr = 9;
	condition = DIA_Addon_Crimson_Raven_Condition;
	information = DIA_Addon_Crimson_Raven_Info;
	permanent = FALSE;
	description = "What do you know about Raven?";
};


func int DIA_Addon_Crimson_Raven_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Crimson_How))
	{
		return TRUE;
	};
};

func void DIA_Addon_Crimson_Raven_Info()
{
	AI_Output (other, self, "DIA_Addon_Crimson_Raven_15_00");	//What do you know about Raven?
	AI_Output (self, other, "DIA_Addon_Crimson_Raven_10_01");	//You won't believe it. I was there. I saw what he did in the tomb!
	AI_Output (self, other, "DIA_Addon_Crimson_Raven_10_02");	//(afraid) He mumbled and called some strange words. Over and over...
	B_Say_CrimsonBeliar ();
	AI_Output (self, other, "DIA_Addon_Crimson_Raven_10_03");	//(loudly) And then a blazing light came out of the tomb and I heard the SCREAM.
	AI_Output (self, other, "DIA_Addon_Crimson_Raven_10_04");	//(calls) Oh, ye gods, that voice. That was the sound of the end of the world!
	AI_Output (self, other, "DIA_Addon_Crimson_Raven_10_05");	//Raven spoke with it, they conversed - Raven and THAT voice!
	AI_Output (self, other, "DIA_Addon_Crimson_Raven_10_06");	//I can't remember what they said - I just know that I could only master my limbs again many hours later, back in the camp.
};


instance DIA_Addon_Crimson_FATAGN(C_Info)
{
	npc = BDT_1095_Addon_Crimson;
	nr = 98;
	condition = DIA_Addon_Crimson_FATAGN_Condition;
	information = DIA_Addon_Crimson_FATAGN_Info;
	permanent = TRUE;
	description = "Can you repeat Raven's words again?";
};


func int DIA_Addon_Crimson_FATAGN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Crimson_Raven) && (Crimson_SayBeliar < 4))
	{
		return TRUE;
	};
};

func void DIA_Addon_Crimson_FATAGN_Info()
{
	Crimson_SayBeliar += 1;
	AI_Output(other,self,"DIA_Addon_Crimson_FATAGN_15_00");	//Can you repeat Raven's words again?
	if(Crimson_SayBeliar <= 3)
	{
		AI_Output (self, other, "DIA_Addon_Crimson_FATAGN_10_01");	//Sure. Are you ready?
		Info_ClearChoices (DIA_Addon_Crimson_FATAGN);
		Info_AddChoice (DIA_Addon_Crimson_FATAGN, "Okay.", DIA_Addon_Crimson_FATAGN_LOS);
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_Crimson_FATAGN_10_02");	//I think we had better leave it be...
	};
};

func void DIA_Addon_Crimson_FATAGN_LOS()
{
	if(Crimson_SayBeliar == 1)
	{
		Snd_Play("Mystery_01");
	}
	else if(Crimson_SayBeliar == 2)
	{
		Snd_Play("Mystery_03");
	}
	else
	{
		Snd_Play("Mystery_07");
		Wld_PlayEffect("FX_EARTHQUAKE",self,self,0,0,0,FALSE);
		Wld_PlayEffect("DEMENTOR_FX",self,self,0,0,0,FALSE);
	};
	B_Say_CrimsonBeliar();
	Info_ClearChoices(DIA_Addon_Crimson_FATAGN);
};

