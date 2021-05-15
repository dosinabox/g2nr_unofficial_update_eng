
instance DIA_Boltan_EXIT(C_Info)
{
	npc = MIL_313_Boltan;
	nr = 999;
	condition = DIA_Boltan_EXIT_Condition;
	information = DIA_Boltan_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende_v2;
};


func int DIA_Boltan_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Boltan_EXIT_Info()
{
	DIA_Common_IHaveToGo_v2();
	AI_WaitTillEnd(self,other);
	AI_StopProcessInfos(self);
};

func int C_PrisonIsEmpty()
{
	if((MIS_Andre_REDLIGHT == LOG_SUCCESS) && !Npc_IsDead(Borka))
	{
		return FALSE;
	}
	else if((Npc_GetDistToWP(Canthar,"NW_CITY_HABOUR_KASERN_RENGARU") <= 600) && !Npc_IsDead(Canthar))
	{
		return FALSE;
	}
	else if((Sarah_Ausgeliefert == TRUE) && !Npc_IsDead(Sarah))
	{
		return FALSE;
	}
	else if((Rengaru_Ausgeliefert == TRUE) && !Npc_IsDead(Rengaru))
	{
		return FALSE;
	}
	else if((Nagur_Ausgeliefert == TRUE) && !Npc_IsDead(Nagur))
	{
		return FALSE;
	}
	else if((Halvor_Ausgeliefert == TRUE) && !Npc_IsDead(Halvor))
	{
		return FALSE;
	}
	else if((Fernando_ImKnast == TRUE) && !Npc_IsDead(Fernando))
	{
		return FALSE;
	}
	else if((MIS_RescueBennet != LOG_SUCCESS) && (Kapitel == 3))
	{
		return FALSE;
	}
	else if((MIS_RescueBennet == LOG_SUCCESS) && (CorneliusFlee == FALSE) && !Npc_IsDead(Cornelius))
	{
		return FALSE;
	};
	return TRUE;
};


instance DIA_Boltan_HALLO(C_Info)
{
	npc = MIL_313_Boltan;
	nr = 1;
	condition = DIA_Boltan_HALLO_Condition;
	information = DIA_Boltan_HALLO_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Boltan_HALLO_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Boltan_HalloBennet) || Npc_KnowsInfo(other,DIA_Boltan_HalloCanthar))
	{
		return FALSE;
	}
	else if((Kapitel == 3) && (MIS_RescueBennet != LOG_SUCCESS) && (other.guild == GIL_SLD))
	{
		return FALSE;
	}
	else if((Kapitel >= 3) && (Canthar_Ausgeliefert == TRUE) && !Npc_IsDead(Canthar))
	{
		return FALSE;
	}
	else
	{
		return TRUE;
	};
};

func void DIA_Boltan_HALLO_Info()
{
	AI_Output (self, other, "DIA_Boltan_Add_05_00");	//What do you want here?
};


instance DIA_Boltan_ToConvicts(C_Info)
{
	npc = MIL_313_Boltan;
	nr = 2;
	condition = DIA_Boltan_ToConvicts_Condition;
	information = DIA_Boltan_ToConvicts_Info;
	permanent = TRUE;
	description = "I want to see the prisoners.";
};


func int DIA_Boltan_ToConvicts_Condition()
{
	return TRUE;
};

func void DIA_Boltan_ToConvicts_Info()
{
	AI_Output (other, self, "DIA_Boltan_Add_15_01");	//I want to see the prisoners.
	if ((Kapitel == 3) && (MIS_RescueBennet != LOG_SUCCESS))
	{
		if(other.guild == GIL_SLD)
		{
			AI_Output (self, other, "DIA_Boltan_Add_05_07");	//Yeah, go ahead and say good-bye to your pal.
		}
		else
		{
			AI_Output (self, other, "DIA_Boltan_Add_05_06");	//We've put away the swine who murdered Lothar the paladin.
		};
	}
	else if(C_PrisonIsEmpty())
	{
		AI_Output (self, other, "DIA_Boltan_Add_05_02");	//All the cells are empty at the moment.
	}
	else if(other.guild == GIL_MIL)
	{
		AI_Output (self, other, "DIA_Boltan_Add_05_04");	//All right, mate.
	}
	else if((other.guild == GIL_PAL) || (other.guild == GIL_KDF))
	{
		AI_Output (self, other, "DIA_Boltan_Add_05_05");	//Of course.
	}
	else
	{
		AI_Output (self, other, "DIA_Boltan_Add_05_03");	//Go ahead, but don't stay away too long, understood?
	};
};


instance DIA_Boltan_HalloBennet(C_Info)
{
	npc = MIL_313_Boltan;
	nr = 1;
	condition = DIA_Boltan_HalloBennet_Condition;
	information = DIA_Boltan_HalloBennet_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Boltan_HalloBennet_Condition()
{
	if((Kapitel == 3) && (MIS_RescueBennet != LOG_SUCCESS) && (other.guild == GIL_SLD))
	{
		return TRUE;
	};
};

func void DIA_Boltan_HalloBennet_Info()
{
	AI_Output (self, other, "DIA_Boltan_Add_05_08");	//You haven't come to get your buddy out of here, have you?
	AI_Output (self, other, "DIA_Boltan_Add_05_09");	//Forget it! As soon as I raise the alarm, the boys will be here in an instant!
	AI_Output (self, other, "DIA_Boltan_Add_05_10");	//And then we'll have us some minced mercenary! (dirty laugh)
};


instance DIA_Boltan_HalloCanthar(C_Info)
{
	npc = MIL_313_Boltan;
	nr = 1;
	condition = DIA_Boltan_HalloCanthar_Condition;
	information = DIA_Boltan_HalloCanthar_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Boltan_HalloCanthar_Condition()
{
	if((Kapitel == 3) && (MIS_RescueBennet != LOG_SUCCESS) && (other.guild == GIL_SLD) && !Npc_KnowsInfo(other,DIA_Boltan_HalloBennet))
	{
		return FALSE;
	}
	else if((Kapitel >= 3) && (Canthar_Ausgeliefert == TRUE) && !Npc_IsDead(Canthar))
	{
		return TRUE;
	};
};

func void DIA_Boltan_HalloCanthar_Info()
{
	AI_Output (self, other, "DIA_Boltan_Add_05_11");	//Hey, you're the guy who filed a complaint against Canthar, the merchant.
	AI_Output (self, other, "DIA_Boltan_Add_05_12");	//Lots of people came here to vouch for him. Well-respected people.
	AI_Output (self, other, "DIA_Boltan_Add_05_13");	//The matter must have been a misunderstanding. These things happen.
	AI_Output (self, other, "DIA_Boltan_Add_05_14");	//In future, you should be more careful about who you send to jail.
};

