
instance DIA_Kati_EXIT(C_Info)
{
	npc = BAU_941_Kati;
	nr = 999;
	condition = DIA_Kati_EXIT_Condition;
	information = DIA_Kati_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Kati_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Kati_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


var int Kati_AskedForHelp;

instance DIA_Kati_SLDNOCHDA(C_Info)
{
	npc = BAU_941_Kati;
	nr = 4;
	condition = DIA_Kati_SLDNOCHDA_Condition;
	information = DIA_Kati_SLDNOCHDA_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Kati_SLDNOCHDA_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (Kapitel < 4))
	{
		if(!C_AkilFarmIsFree())
		{
			return TRUE;
		};
	};
};

func void DIA_Kati_SLDNOCHDA_Info()
{
	if(Kati_AskedForHelp == FALSE)
	{
		AI_Output(self,other,"DIA_Kati_SLDNOCHDA_16_00");	//Those cutthroats are threatening my husband! We are citizens of the town, loyal to the king, and the mercenaries are planning to rob us!
		Kati_AskedForHelp = TRUE;
	};
	AI_Output(self,other,"DIA_Kati_SLDNOCHDA_16_01");	//Now don't you just stand there. Do something then! Help us.
	if(Akils_SLDStillthere == FALSE)
	{
		Log_CreateTopic(TOPIC_AkilsSLDStillthere,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_AkilsSLDStillthere,LOG_Running);
		B_LogEntry(TOPIC_AkilsSLDStillthere,"Akil's farm is threatened by mercenaries.");
		Akils_SLDStillthere = TRUE;
	};
	AI_StopProcessInfos(self);
};


instance DIA_Kati_HALLO(C_Info)
{
	npc = BAU_941_Kati;
	nr = 5;
	condition = DIA_Kati_HALLO_Condition;
	information = DIA_Kati_HALLO_Info;
	permanent = FALSE;
	description = "Are you all right?";
};


func int DIA_Kati_HALLO_Condition()
{
	if(C_AkilFarmIsFree())
	{
		return TRUE;
	};
};

func void DIA_Kati_HALLO_Info()
{
	AI_Output(other,self,"DIA_Kati_HALLO_15_00");	//Are you all right?
	if(Npc_IsDead(Akil))
	{
		AI_Output(self,other,"DIA_Kati_HALLO_16_01");	//(sobs) My beloved husband is dead! Oh Innos, why do you punish me so hard?
		TOPIC_END_AkilsSLDStillthere = TRUE;
		B_GivePlayerXP(XP_Akil_Tot);
	}
	else
	{
		AI_Output(self,other,"DIA_Kati_HALLO_16_02");	//Yes, I'm fine, thank you.
	};
	Npc_ExchangeRoutine(self,"Start");
//	self.flags = 0;
	if(Hlp_IsValidNpc(Akil) && !Npc_IsDead(Akil))
	{
		B_StartOtherRoutine(Akil,"Start");
	};
	if(Hlp_IsValidNpc(Randolph) && !Npc_IsDead(Randolph))
	{
		B_StartOtherRoutine(Randolph,"Start");
		Randolph.flags = 0;
	};
};


instance DIA_Kati_ESSEN(C_Info)
{
	npc = BAU_941_Kati;
	nr = 12;
	condition = DIA_Kati_ESSEN_Condition;
	information = DIA_Kati_ESSEN_Info;
	permanent = FALSE;
	description = "Akil says you've got a meal for me.";
};


func int DIA_Kati_ESSEN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kati_HALLO) && (Kati_Mahlzeit == TRUE) && !Npc_IsDead(Akil))
	{
		return TRUE;
	};
};

func void DIA_Kati_ESSEN_Info()
{
	AI_Output (other, self, "DIA_Kati_ESSEN_15_00");	//Akil says you've got a meal for me.
	AI_Output (self, other, "DIA_Kati_ESSEN_16_01");	//We've hit some hard times ever since the Barrier fell and the land is no longer safe.
	AI_Output (self, other, "DIA_Kati_ESSEN_16_02");	//Here's a loaf of bread, a little meat and some water. That's all I can spare, I'm afraid.
	Npc_RemoveInvItem(self,ItFo_Bread);
	CreateInvItem(other,ItFo_Bread);
	Npc_RemoveInvItem(self,ItFo_Milk);
	CreateInvItem(other,ItFo_Milk);
	Npc_RemoveInvItem(self,ItFo_Water);
	CreateInvItem(other,ItFo_Water);
	AI_PrintScreen("Received: Bread",-1,40,FONT_ScreenSmall,2);
	AI_PrintScreen("Received: Milk",-1,43,FONT_ScreenSmall,2);
	AI_PrintScreen("Received: Water",-1,46,FONT_ScreenSmall,2);
};


instance DIA_Kati_Baltram(C_Info)
{
	npc = BAU_941_Kati;
	nr = 4;
	condition = DIA_Kati_Baltram_Condition;
	information = DIA_Kati_Baltram_Info;
	permanent = FALSE;
	description = "Baltram sent me...";
};


func int DIA_Kati_Baltram_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kati_HALLO) && Npc_IsDead(Akil) && (MIS_Baltram_ScoutAkil == LOG_Running) && (Lieferung_Geholt == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Kati_Baltram_Info()
{
	AI_Output (other, self, "DIA_Kati_Baltram_15_00");	//Baltram sent me. I'm supposed to pick up a shipment for him.
	AI_Output (self, other, "DIA_Kati_Baltram_16_01");	//Yes, of course. Here, I've packed it all up.
	B_GetBaltramPaket();
};


instance DIA_Kati_BAUERNAUFSTAND(C_Info)
{
	npc = BAU_941_Kati;
	nr = 6;
	condition = DIA_Kati_BAUERNAUFSTAND_Condition;
	information = DIA_Kati_BAUERNAUFSTAND_Info;
	permanent = FALSE;
	description = "Why don't you defend yourselves against Onar's tyranny? ";
};


func int DIA_Kati_BAUERNAUFSTAND_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kati_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Kati_BAUERNAUFSTAND_Info()
{
	AI_Output (other, self, "DIA_Kati_BAUERNAUFSTAND_15_00");	//Why don't you defend yourselves against Onar's tyranny?
	AI_Output (self, other, "DIA_Kati_BAUERNAUFSTAND_16_01");	//For us farmers near the city, it makes more sense to stay on the good side of the city militia than to rely on Onar's mercenaries.
	AI_Output (self, other, "DIA_Kati_BAUERNAUFSTAND_16_02");	//On the other hand, there's Bengar and Sekob who would rather give up their farms than work for the king.
};


instance DIA_Kati_ANDEREHOEFE(C_Info)
{
	npc = BAU_941_Kati;
	nr = 7;
	condition = DIA_Kati_ANDEREHOEFE_Condition;
	information = DIA_Kati_ANDEREHOEFE_Info;
	permanent = FALSE;
	description = "Where do I find the farms of Bengar and Sekob?";
};


func int DIA_Kati_ANDEREHOEFE_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kati_BAUERNAUFSTAND))
	{
		return TRUE;
	};
};

func void DIA_Kati_ANDEREHOEFE_Info()
{
	AI_Output (other, self, "DIA_Kati_ANDEREHOEFE_15_00");	//Where do I find the farms of Bengar and Sekob?
	AI_Output (self, other, "DIA_Kati_ANDEREHOEFE_16_01");	//They're not far from the farm where the landowner lives. Go east from here, and you'll find them.
};


instance DIA_Kati_HIERWEG(C_Info)
{
	npc = BAU_941_Kati;
	nr = 9;
	condition = DIA_Kati_HIERWEG_Condition;
	information = DIA_Kati_HIERWEG_Info;
	permanent = FALSE;
	description = "Haven't you ever considered moving away from here?";
};


func int DIA_Kati_HIERWEG_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kati_BAUERNAUFSTAND))
	{
		return TRUE;
	};
};

func void DIA_Kati_HIERWEG_Info()
{
	AI_Output (other, self, "DIA_Kati_HIERWEG_15_00");	//Haven't you ever considered moving away from here?
	AI_Output (self, other, "DIA_Kati_HIERWEG_16_01");	//It's not easy to get away from this part of the country. All the land is walled in by a high, insurmountable chain of mountains.
	AI_Output (self, other, "DIA_Kati_HIERWEG_16_02");	//The only two ways out of here are the pass to the Valley of Mines, and the harbor.
	AI_Output (self, other, "DIA_Kati_HIERWEG_16_03");	//Since we cannot afford passage on a ship, and the Valley of Mines is a place of no return, we're going to have to stay here.
};


instance DIA_Kati_PASS(C_Info)
{
	npc = BAU_941_Kati;
	nr = 10;
	condition = DIA_Kati_PASS_Condition;
	information = DIA_Kati_PASS_Info;
	permanent = FALSE;
	description = "What do you know about the pass?";
};


func int DIA_Kati_PASS_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Kati_HIERWEG))
	{
		return TRUE;
	};
};

func void DIA_Kati_PASS_Info()
{
	AI_Output (other, self, "DIA_Kati_PASS_15_00");	//What do you know about the pass?
	AI_Output (self, other, "DIA_Kati_PASS_16_01");	//I've never been there myself. But it must be somewhere near Bengar's farm on the high pastures.
};


instance DIA_Kati_PERMKAP1(C_Info)
{
	npc = BAU_941_Kati;
	nr = 11;
	condition = DIA_Kati_PERMKAP1_Condition;
	information = DIA_Kati_PERMKAP1_Info;
	permanent = TRUE;
	description = "Look out for your husband.";
};


func int DIA_Kati_PERMKAP1_Condition()
{
	if(!C_NpcIsDown(Akil) && Npc_KnowsInfo(other,DIA_Kati_HALLO) && Npc_KnowsInfo(other,DIA_Kati_BAUERNAUFSTAND) && Npc_KnowsInfo(other,DIA_Kati_ANDEREHOEFE) && Npc_KnowsInfo(other,DIA_Kati_HIERWEG) && Npc_KnowsInfo(other,DIA_Kati_PASS) && (Kapitel < 3))
	{
		return TRUE;
	};
};

func void DIA_Kati_PERMKAP1_Info()
{
	AI_Output (other, self, "DIA_Kati_PERMKAP1_15_00");	//Look out for your husband.
	AI_Output (self, other, "DIA_Kati_PERMKAP1_16_01");	//I shall do my best.
	AI_StopProcessInfos(self);
};


instance DIA_Kati_PERM(C_Info)
{
	npc = BAU_941_Kati;
	nr = 3;
	condition = DIA_Kati_PERM_Condition;
	information = DIA_Kati_PERM_Info;
	permanent = TRUE;
	description = "Everything still fine with you?";
};


func int DIA_Kati_PERM_Condition()
{
	if((Kapitel >= 3) && Npc_KnowsInfo(other,DIA_Kati_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Kati_PERM_Info()
{
	AI_Output (other, self, "DIA_Kati_PERM_15_00");	//Everything still fine with you?
	AI_Output (self, other, "DIA_Kati_PERM_16_01");	//We can manage. I just wonder how much longer we're going to have to endure these devils in black.
	AI_Output (self, other, "DIA_Kati_PERM_16_02");	//I can't stand it any more. They sneak around the house, making those funny noises.
};


instance DIA_Kati_PICKPOCKET(C_Info)
{
	npc = BAU_941_Kati;
	nr = 900;
	condition = DIA_Kati_PICKPOCKET_Condition;
	information = DIA_Kati_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20_Female;
};


func int DIA_Kati_PICKPOCKET_Condition()
{
	return C_Beklauen(13,15);
};

func void DIA_Kati_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Kati_PICKPOCKET);
	Info_AddChoice(DIA_Kati_PICKPOCKET,Dialog_Back,DIA_Kati_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Kati_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Kati_PICKPOCKET_DoIt);
};

func void DIA_Kati_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Kati_PICKPOCKET);
};

func void DIA_Kati_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Kati_PICKPOCKET);
};

