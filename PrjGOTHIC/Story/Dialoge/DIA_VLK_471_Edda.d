
instance DIA_Edda_EXIT(C_Info)
{
	npc = VLK_471_Edda;
	nr = 999;
	condition = DIA_Edda_EXIT_Condition;
	information = DIA_Edda_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Edda_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Edda_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Edda_Hallo(C_Info)
{
	npc = VLK_471_Edda;
	nr = 2;
	condition = DIA_Edda_Hallo_Condition;
	information = DIA_Edda_Hallo_Info;
	permanent = FALSE;
	description = "What are you cooking there?";
};


func int DIA_Edda_Hallo_Condition()
{
	if(Wld_IsTime(8,0,22,0))
	{
		return TRUE;
	};
};

func void DIA_Edda_Hallo_Info()
{
	AI_Output (other, self, "DIA_Edda_Hallo_15_00");	//What are you cooking there?
	AI_Output (self, other, "DIA_Edda_Hallo_17_01");	//A fish soup. It's not all that tasty, but at least it's hot.
	AI_Output (self, other, "DIA_Edda_Hallo_17_02");	//You can try a plateful if you like.
	AI_Output(self,other,"DIA_Edda_Kochen_17_01");	//I cook for everybody. For you, too, if you want. All you need to do is bring me a fish.
};


func void B_Edda_AboutStolenStatue()
{
	if(Wld_IsTime(8,0,22,0))
	{
		AI_Output(self,other,"DIA_Edda_Stadt_17_02");	//But if you're looking for a place to stay overnight, you're welcome to sleep in my hut. There's an extra bed that you can have.
	}
	else
	{
		AI_Output(self,other,"DIA_Edda_Stadt_17_02_add");	//If you're looking for a place to stay overnight, you're welcome to sleep in my hut. There's an extra bed that you can have.
	};
	AI_Output (other, self, "DIA_Edda_Stadt_15_03");	//Aren't you afraid of thieves?
	AI_Output (self, other, "DIA_Edda_Stadt_17_04");	//The only valuable thing I ever owned has already been taken.
	AI_Output (self, other, "DIA_Edda_Stadt_17_05");	//Someone stole my statue of Innos.
	Edda_Schlafplatz = TRUE;
};

instance DIA_Edda_Sleep(C_Info)
{
	npc = VLK_471_Edda;
	nr = 3;
	condition = DIA_Edda_Sleep_Condition;
	information = DIA_Edda_Sleep_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Edda_Sleep_Condition()
{
	if(Wld_IsTime(22,0,8,0) && Npc_IsInState(self,ZS_Talk) && (Edda_Schlafplatz == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Edda_Sleep_Info()
{
	B_Edda_AboutStolenStatue();
};


instance DIA_Edda_Stadt(C_Info)
{
	npc = VLK_471_Edda;
	nr = 9;
	condition = DIA_Edda_Stadt_Condition;
	information = DIA_Edda_Stadt_Info;
	permanent = FALSE;
	description = "What can you tell me about the city?";
};


func int DIA_Edda_Stadt_Condition()
{
	return TRUE;
};

func void DIA_Edda_Stadt_Info()
{
	AI_Output(other,self,"DIA_Edda_Stadt_15_00");	//What can you tell me about the city?
	AI_Output(self,other,"DIA_Edda_Stadt_17_01");	//Most citizens in this town are afraid of thieves. Therefore, it is not a good idea to enter strange houses.
	if(Edda_Schlafplatz == FALSE)
	{
		B_Edda_AboutStolenStatue();
	};
};


instance DIA_Edda_Suppe(C_Info)
{
	npc = VLK_471_Edda;
	nr = 6;
	condition = DIA_Edda_Suppe_Condition;
	information = DIA_Edda_Suppe_Info;
	permanent = TRUE;
	description = "Could you cook me some soup?";
};


func int DIA_Edda_Suppe_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Edda_Hallo))
	{
		return TRUE;
	};
};

func void DIA_Edda_Suppe_Info()
{
	AI_Output (other, self, "DIA_Edda_Suppe_15_00");	//Could you cook me some soup?
	if (Wld_GetDay () == 0)
	{
		AI_Output (self, other, "DIA_Edda_Suppe_17_02");	//Starting tomorrow, you can come and get some soup every day.
	}
	else if(Wld_IsTime(22,0,8,0))
	{
		AI_Output(self,other,"DIA_Edda_Suppe_17_03_add");	//Come back later.
	}
	else if(Edda_Day != Wld_GetDay())
	{
		if(Npc_HasItems(other,ItFo_Fish) || Npc_HasItems(other,ItFo_SmellyFish))
		{
			if(Npc_HasItems(other,ItFo_Fish))
			{
				B_GiveInvItems(other,self,ItFo_Fish,1);
				Npc_RemoveInvItems(self,ItFo_Fish,Npc_HasItems(self,ItFo_Fish));
			}
			else
			{
				B_GiveInvItems(other,self,ItFo_SmellyFish,1);
				Npc_RemoveInvItems(self,ItFo_SmellyFish,Npc_HasItems(self,ItFo_SmellyFish));
			};
			AI_Output(self,other,"DIA_Edda_Suppe_17_01");	//Nothing could be simpler. Here, have a plate.
			B_GiveInvItems(self,other,ItFo_EddasFishSoup,1);
			Edda_Day = Wld_GetDay();
		}
		else
		{
			AI_Output (self, other, "DIA_Edda_Suppe_17_04");	//Bring me a fish, and I'll cook you a tasty soup.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Edda_Suppe_17_03");	//No, not today. Come back tomorrow.
	};
};


instance DIA_Edda_Statue(C_Info)
{
	npc = VLK_471_Edda;
	nr = 6;
	condition = DIA_Edda_Statue_Condition;
	information = DIA_Edda_Statue_Info;
	permanent = FALSE;
	description = "Look, I've got a statue of Innos for you.";
};


func int DIA_Edda_Statue_Condition()
{
	if(Edda_Schlafplatz == TRUE)
	{
		if(Npc_HasItems(other,ItMi_EddasStatue) || Npc_HasItems(other,ItMi_InnosStatue) || Npc_HasItems(other,ItMi_LostInnosStatue_Daron))
		{
			return TRUE;
		};
	};
};

func void DIA_Edda_Statue_Info()
{
	AI_Output(other,self,"DIA_Edda_Statue_15_00");	//Look, I've got a statue of Innos for you.
	if(Npc_HasItems(other,ItMi_EddasStatue))
	{
		B_GiveInvItems(other,self,ItMi_EddasStatue,1);
		B_GivePlayerXP(XP_Edda_Statue * 2);
		AI_Output(self,other,"DIA_Maria_BringPlate_17_01");	//Yes! That is it! Thanks a million!
	}
	else if(Npc_HasItems(other,ItMi_InnosStatue))
	{
		B_GiveInvItems(other,self,ItMi_InnosStatue,1);
		B_GivePlayerXP(XP_Edda_Statue);
		AI_Output(self,other,"DIA_Edda_Statue_17_01");	//Oh - thank you very, very much. May Innos let his light shine on you...
	}
	else if(Npc_HasItems(other,ItMi_LostInnosStatue_Daron))
	{
		B_GiveInvItems(other,self,ItMi_LostInnosStatue_Daron,1);
		B_GivePlayerXP(XP_Edda_Statue);
		AI_Output(self,other,"DIA_Edda_Statue_17_01");	//Oh - thank you very, very much. May Innos let his light shine on you...
	};
	AI_Output(other,self,"DIA_Edda_Statue_15_02");	//Yeah, never mind.
	
};

instance DIA_Edda_PICKPOCKET(C_Info)
{
	npc = VLK_471_Edda;
	nr = 900;
	condition = DIA_Edda_PICKPOCKET_Condition;
	information = DIA_Edda_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be child's play to steal her statue)";
};


func int DIA_Edda_PICKPOCKET_Condition()
{
	if(Npc_HasItems(self,ItMi_EddasStatue))
	{
		return C_StealItem(20);
	}
	else if(Npc_HasItems(self,ItMi_InnosStatue))
	{
		return C_StealItem(20);
	}
	else if(Npc_HasItems(self,ItMi_LostInnosStatue_Daron))
	{
		return C_StealItem(20);
	};
	return FALSE;
};

func void DIA_Edda_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Edda_PICKPOCKET);
	Info_AddChoice(DIA_Edda_PICKPOCKET,Dialog_Back,DIA_Edda_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Edda_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Edda_PICKPOCKET_DoIt);
};

func void DIA_Edda_PICKPOCKET_DoIt()
{
	if(Npc_HasItems(self,ItMi_EddasStatue))
	{
		B_StealItem(20,Hlp_GetInstanceID(ItMi_EddasStatue));
	}
	else if(Npc_HasItems(self,ItMi_InnosStatue))
	{
		B_StealItem(20,Hlp_GetInstanceID(ItMi_InnosStatue));
	}
	else if(Npc_HasItems(self,ItMi_LostInnosStatue_Daron))
	{
		B_StealItem(20,Hlp_GetInstanceID(ItMi_LostInnosStatue_Daron));
	};
	Info_ClearChoices(DIA_Edda_PICKPOCKET);
};

func void DIA_Edda_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Edda_PICKPOCKET);
};

