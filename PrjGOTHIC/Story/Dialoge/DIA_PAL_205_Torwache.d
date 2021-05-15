
instance DIA_PAL_205_Torwache_EXIT(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 999;
	condition = DIA_PAL_205_Torwache_EXIT_Condition;
	information = DIA_PAL_205_Torwache_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_PAL_205_Torwache_EXIT_Condition()
{
	return TRUE;
};

func void DIA_PAL_205_Torwache_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


func void B_Mil_205_Torwache_Crimes()
{
	if(B_GetGreatestPetzCrime(self) == CRIME_MURDER)
	{
		AI_Output(self,other,"DIA_PAL_205_Torwache_FirstWarn_12_01");	//I would violate my most sacred duty if I were to grant entrance to a murderer.
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_THEFT)
	{
		AI_Output(self,other,"DIA_PAL_205_Torwache_FirstWarn_12_02");	//You are accused of theft. As long as that is true, you may not enter!
	};
	if(B_GetGreatestPetzCrime(self) == CRIME_ATTACK)
	{
		AI_Output(self,other,"DIA_PAL_205_Torwache_FirstWarn_12_03");	//You are known as a brawler. I shall not let you through.
	};
	AI_Output(self,other,"DIA_PAL_205_Torwache_FirstWarn_12_04");	//Go to Lord Andre and settle the matter!
};

const string PAL_205_Checkpoint = "NW_CITY_CITYHALL_IN";

var int PAL_205_schonmalreingelassen;

instance DIA_PAL_205_Torwache_FirstWarn(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 1;
	condition = DIA_PAL_205_Torwache_FirstWarn_Condition;
	information = DIA_PAL_205_Torwache_FirstWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_PAL_205_Torwache_FirstWarn_Condition()
{
	if((VisibleGuild(other) == GIL_MIL) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK))
	{
		return FALSE;
	}
	else if(Npc_GetDistToWP(other,PAL_205_Checkpoint) <= 550)
	{
		Npc_SetRefuseTalk(self,5);
		return FALSE;
	};
	if((B_GetGreatestPetzCrime(self) >= CRIME_ATTACK) && (PAL_205_schonmalreingelassen == TRUE))
	{
		self.aivar[AIV_PASSGATE] = FALSE;
	}
	else if(PAL_205_schonmalreingelassen == TRUE)
	{
		self.aivar[AIV_PASSGATE] = TRUE;
	};
	if((self.aivar[AIV_Guardpassage_Status] == GP_NONE) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && !Npc_RefuseTalk(self))
	{
		return TRUE;
	};
};

func void DIA_PAL_205_Torwache_FirstWarn_Info()
{
	AI_Output (self, other, "DIA_PAL_205_Torwache_FirstWarn_12_00");	//HALT!
	if (B_GetGreatestPetzCrime (self) >= CRIME_ATTACK)
	{
		B_Mil_205_Torwache_Crimes();
	}
	else
	{
		AI_Output (self, other, "DIA_PAL_205_Torwache_FirstWarn_12_05");	//Only men who are in service to the king may enter the town hall.
	};
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,PAL_205_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_FirstWarnGiven;
};


instance DIA_PAL_205_Torwache_SecondWarn(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 2;
	condition = DIA_PAL_205_Torwache_SecondWarn_Condition;
	information = DIA_PAL_205_Torwache_SecondWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_PAL_205_Torwache_SecondWarn_Condition()
{
	if((VisibleGuild(other) == GIL_MIL) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK))
	{
		return FALSE;
	}
	else if((self.aivar[AIV_Guardpassage_Status] == GP_FirstWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,PAL_205_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_PAL_205_Torwache_SecondWarn_Info()
{
	AI_Output (self, other, "DIA_PAL_205_Torwache_SecondWarn_12_00");	//If you take one more step forward, by Innos, I shall knock you down!
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP (other, PAL_205_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_SecondWarnGiven;
	AI_StopProcessInfos(self);
};


instance DIA_PAL_205_Torwache_Attack(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 3;
	condition = DIA_PAL_205_Torwache_Attack_Condition;
	information = DIA_PAL_205_Torwache_Attack_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_PAL_205_Torwache_Attack_Condition()
{
	if((VisibleGuild(other) == GIL_MIL) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK))
	{
		return FALSE;
	}
	else if((self.aivar[AIV_Guardpassage_Status] == GP_SecondWarnGiven) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,PAL_205_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_PAL_205_Torwache_Attack_Info()
{
	other.aivar[AIV_LastDistToWP] = 0;
	self.aivar[AIV_Guardpassage_Status] = GP_NONE;
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_GuardStopsIntruder,0);
};


instance DIA_PAL_205_Torwache_Hagen(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 2;
	condition = DIA_PAL_205_Torwache_Hagen_Condition;
	information = DIA_PAL_205_Torwache_Hagen_Info;
	permanent = TRUE;
	description = "I need to speak to Lord Hagen!";
};


func int DIA_PAL_205_Torwache_Hagen_Condition()
{
	if(PAL_205_schonmalreingelassen == FALSE)
	{
		if((other.guild == GIL_NONE) || (other.guild == GIL_NOV))
		{
			return TRUE;
		};
	};
};

func void DIA_PAL_205_Torwache_Hagen_Info()
{
	AI_Output(other,self,"DIA_PAL_205_Torwache_Hagen_15_00");	//I need to speak to Lord Hagen!
	AI_Output(self,other,"DIA_PAL_205_Torwache_Hagen_12_01");	//Do you know how often I've heard that? You can't go in. If you try anyway, I'll have to kill you.
	AI_StopProcessInfos(self);
};


func void B_CityHallPass()
{
	self.aivar[AIV_PASSGATE] = TRUE;
	PAL_205_schonmalreingelassen = TRUE;
	B_PlayerEnteredUpperCity();
};

instance DIA_PAL_205_Torwache_PassAsArmoredMil(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 3;
	condition = DIA_PAL_205_Torwache_PassAsArmoredMil_Condition;
	information = DIA_PAL_205_Torwache_PassAsArmoredMil_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_PAL_205_Torwache_PassAsArmoredMil_Condition()
{
	if((VisibleGuild(other) == GIL_MIL) && (PAL_205_schonmalreingelassen == FALSE) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK))
	{
		return TRUE;
	};
};

func void DIA_PAL_205_Torwache_PassAsArmoredMil_Info()
{
	AI_Output(self,other,"DIA_PAL_205_Torwache_PassAsMil_12_01");	//All right, you can go in.
	B_CityHallPass();
	AI_StopProcessInfos(self);
};


instance DIA_PAL_205_Torwache_PassAsMil(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 3;
	condition = DIA_PAL_205_Torwache_PassAsMil_Condition;
	information = DIA_PAL_205_Torwache_PassAsMil_Info;
	permanent = TRUE;
	description = "I am a member of the militia.";
};


func int DIA_PAL_205_Torwache_PassAsMil_Condition()
{
	if((other.guild == GIL_MIL) && (PAL_205_schonmalreingelassen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_PAL_205_Torwache_PassAsMil_Info()
{
	AI_Output(other,self,"DIA_PAL_205_Torwache_PassAsMil_15_00");	//I am a member of the militia.
	if(B_GetGreatestPetzCrime(self) >= CRIME_ATTACK)
	{
		B_Mil_205_Torwache_Crimes();
	}
	else
	{
		AI_Output(self,other,"DIA_PAL_205_Torwache_PassAsMil_12_01");	//All right, you can go in.
		B_CityHallPass();
	};
	AI_StopProcessInfos(self);
};


instance DIA_PAL_205_Torwache_PassAsMage(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 3;
	condition = DIA_PAL_205_Torwache_PassAsMage_Condition;
	information = DIA_PAL_205_Torwache_PassAsMage_Info;
	permanent = TRUE;
	description = "I am a Fire Magician.";
};


func int DIA_PAL_205_Torwache_PassAsMage_Condition()
{
	if((other.guild == GIL_KDF) && (PAL_205_schonmalreingelassen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_PAL_205_Torwache_PassAsMage_Info()
{
	AI_Output(other,self,"DIA_PAL_205_Torwache_PassAsMage_15_00");	//I am a Fire Magician.
	if(B_GetGreatestPetzCrime(self) >= CRIME_ATTACK)
	{
		B_Mil_205_Torwache_Crimes();
	}
	else
	{
		AI_Output(self,other,"DIA_PAL_205_Torwache_PassAsMage_12_01");	//Yes, of course. Forgive me, Chosen One, but I am only doing my duty.
		B_CityHallPass();
	};
	AI_StopProcessInfos(self);
};


instance DIA_PAL_205_Torwache_PassAsSld(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 3;
	condition = DIA_PAL_205_Torwache_PassAsSld_Condition;
	information = DIA_PAL_205_Torwache_PassAsSld_Info;
	permanent = TRUE;
	description = "Let me through, I bear a message from the mercenaries.";
};


func int DIA_PAL_205_Torwache_PassAsSld_Condition()
{
	if(Npc_HasItems(other,ItWr_Passage_MIS) && (PAL_205_schonmalreingelassen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_PAL_205_Torwache_PassAsSld_Info()
{
	AI_Output(other,self,"DIA_PAL_205_Torwache_PassAsSld_15_00");	//Let me through, I bear a message from the mercenaries.
	if(B_GetGreatestPetzCrime(self) >= CRIME_ATTACK)
	{
		B_Mil_205_Torwache_Crimes();
	}
	else
	{
		AI_Output(self,other,"DIA_PAL_205_Torwache_PassAsSld_12_01");	//All right, but I'm warning you. If you cause any trouble here, you won't have time to regret it.
		B_CityHallPass();
	};
	AI_StopProcessInfos(self);
};


instance DIA_PAL_205_Torwache_PERM(C_Info)
{
	npc = PAL_205_Torwache;
	nr = 2;
	condition = DIA_PAL_205_Torwache_PERM_Condition;
	information = DIA_PAL_205_Torwache_PERM_Info;
	permanent = TRUE;
	description = "How's your duty?";
};


func int DIA_PAL_205_Torwache_PERM_Condition()
{
	if((PAL_205_schonmalreingelassen == TRUE) && (B_GetGreatestPetzCrime(self) < CRIME_ATTACK))
	{
		return TRUE;
	};
};

func void DIA_PAL_205_Torwache_PERM_Info()
{
	AI_Output (other, self, "DIA_PAL_205_Torwache_PERM_15_00");	//How's duty?
	if ((other.guild == GIL_PAL) || (other.guild == GIL_MIL))
	{
		AI_Output (self, other, "DIA_PAL_205_Torwache_PERM_12_01");	//We have everything under control.
	}
	else if(other.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_PAL_205_Torwache_PERM_12_02");	//My task fulfills me, Chosen One.
	}
	else if((other.guild == GIL_SLD) || (other.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_PAL_205_Torwache_PERM_12_03");	//Go on in and shut up.
	}
	else
	{
		AI_Output (self, other, "DIA_PAL_205_Torwache_PERM_12_04");	//What do you want?
	};
	AI_StopProcessInfos(self);
};

