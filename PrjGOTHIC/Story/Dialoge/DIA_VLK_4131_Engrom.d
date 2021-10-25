
instance DIA_Engrom_EXIT(C_Info)
{
	npc = VLK_4131_Engrom;
	nr = 999;
	condition = DIA_Engrom_EXIT_Condition;
	information = DIA_Engrom_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Engrom_EXIT_Condition()
{
	if(Kapitel < 3)
	{
		return TRUE;
	};
};

func void DIA_Engrom_EXIT_Info()
{
	B_NpcClearObsessionByDMT(self);
};


instance DIA_Engrom_HALLO(C_Info)
{
	npc = VLK_4131_Engrom;
	nr = 5;
	condition = DIA_Engrom_HALLO_Condition;
	information = DIA_Engrom_HALLO_Info;
	description = "What's up?";
};


func int DIA_Engrom_HALLO_Condition()
{
	if(Kapitel <= 3)
	{
		return TRUE;
	};
};

func void DIA_Engrom_HALLO_Info()
{
	AI_Output (other, self, "DIA_Engrom_HALLO_15_00");	//How's it going?
	AI_Output (self, other, "DIA_Engrom_HALLO_12_01");	//Crappy!
	AI_Output (other, self, "DIA_Engrom_HALLO_15_02");	//Mmh!
	AI_Output (self, other, "DIA_Engrom_HALLO_12_03");	//What else should I say. Nothing but up and down this damned river for days.
	AI_Output (self, other, "DIA_Engrom_HALLO_12_04");	//Orcs lurking on the left, bandits hanging around on the right, and every day I eat lurker meat. I can't take it any more, you see.
};


instance DIA_Engrom_WhatAboutLeaving(C_Info)
{
	npc = VLK_4131_Engrom;
	nr = 6;
	condition = DIA_Engrom_WhatAboutLeaving_Condition;
	information = DIA_Engrom_WhatAboutLeaving_Info;
	description = "Ever considered getting out of here?";
};


func int DIA_Engrom_WhatAboutLeaving_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Engrom_HALLO) && (Kapitel <= 3))
	{
		return TRUE;
	};
};

func void DIA_Engrom_WhatAboutLeaving_Info()
{
	AI_Output (other, self, "DIA_Engrom_WhatAboutLeaving_15_00");	//Ever considered getting out of here?
	AI_Output (self, other, "DIA_Engrom_WhatAboutLeaving_12_01");	//Yeah, sure. No problem at all.
	AI_Output (self, other, "DIA_Engrom_WhatAboutLeaving_12_02");	//First I'll carve my way through the hordes of orcs, say hello to all the other monsters that are all over the place, and then I just stroll right across the pass!
	AI_Output (self, other, "DIA_Engrom_WhatAboutLeaving_12_03");	//That would be quite a trick!
	AI_Output (other, self, "DIA_Engrom_WhatAboutLeaving_15_04");	//I got in here, too.
	AI_Output (self, other, "DIA_Engrom_WhatAboutLeaving_12_05");	//Are you trying to tell me you just came across the pass?
	AI_Output (other, self, "DIA_Engrom_WhatAboutLeaving_15_06");	//More or less, yes!
	AI_Output (self, other, "DIA_Engrom_WhatAboutLeaving_12_07");	//Then you got lucky. As long as things are so messed up around here, I'm not going to budge.
};


instance DIA_Engrom_Jagd(C_Info)
{
	npc = VLK_4131_Engrom;
	nr = 6;
	condition = DIA_Engrom_Jagd_Condition;
	information = DIA_Engrom_Jagd_Info;
	permanent = TRUE;
	description = "How's the hunting?";
};


func int DIA_Engrom_Jagd_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Engrom_HALLO) && (Kapitel <= 3))
	{
		return TRUE;
	};
};

func void DIA_Engrom_Jagd_Info()
{
	B_WasMachtJagd ();
	AI_Output (self, other, "DIA_Engrom_Jagd_12_01");	//Hunting is my only consolation. But I'd like to see a target once in a while other than these disgusting lurkers.
};


instance DIA_Engrom_KAP3_EXIT(C_Info)
{
	npc = VLK_4131_Engrom;
	nr = 999;
	condition = DIA_Engrom_KAP3_EXIT_Condition;
	information = DIA_Engrom_KAP3_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Engrom_KAP3_EXIT_Condition()
{
	if(Kapitel >= 3)
	{
		return TRUE;
	};
};

func void DIA_Engrom_KAP3_EXIT_Info()
{
	B_NpcClearObsessionByDMT(self);
};


instance DIA_Engrom_B_NpcObsessedByDMT(C_Info)
{
	npc = VLK_4131_Engrom;
	nr = 32;
	condition = DIA_Engrom_B_NpcObsessedByDMT_Condition;
	information = DIA_Engrom_B_NpcObsessedByDMT_Info;
	description = "Are you all right?";
};


func int DIA_Engrom_B_NpcObsessedByDMT_Condition()
{
	if((NpcObsessedByDMT_Engrom == FALSE) && (Kapitel >= 4))
	{
		return TRUE;
	};
};

func void DIA_Engrom_B_NpcObsessedByDMT_Info()
{
	DIA_Common_IsEverythingOk();
	MIS_Tabin_LookForEngrom = LOG_SUCCESS;
	B_NpcObsessedByDMT(self);
};


instance DIA_Engrom_BESSEN(C_Info)
{
	npc = VLK_4131_Engrom;
	nr = 55;
	condition = DIA_Engrom_BESSEN_Condition;
	information = DIA_Engrom_BESSEN_Info;
	permanent = TRUE;
	description = "Evil has taken possession of you.";
};


func int DIA_Engrom_BESSEN_Condition()
{
	if((NpcObsessedByDMT_Engrom == TRUE) && (NpcObsessedByDMT == FALSE) && (Kapitel >= 4))
	{
		return TRUE;
	};
};

func void DIA_Engrom_BESSEN_Info()
{
	AI_Output (other, self, "DIA_Engrom_BESSEN_15_00");	//Evil has taken possession of you.
	AI_Output (other, self, "DIA_Engrom_BESSEN_15_01");	//Let me help you.
	AI_Output (self, other, "DIA_Engrom_BESSEN_12_02");	//(screams) Don't touch me!
	B_NpcClearObsessionByDMT(self);
	if(Npc_GetDistToWP(self,"START") < 1000)
	{
		Npc_SetTarget(self,other);
		self.aivar[AIV_INVINCIBLE] = FALSE;
		other.aivar[AIV_INVINCIBLE] = FALSE;
		AI_StartState(self,ZS_Flee,0,"");
	}
	else
	{
		Npc_ExchangeRoutine(self,"FleePass");
		if(Engrom_Orc_Spawned == FALSE)
		{
			Wld_InsertNpc(OrcWarrior_Scout,"START");
			Engrom_Orc_Spawned = TRUE;
		};
	};
};


instance DIA_Engrom_PICKPOCKET(C_Info)
{
	npc = VLK_4131_Engrom;
	nr = 900;
	condition = DIA_Engrom_PICKPOCKET_Condition;
	information = DIA_Engrom_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Engrom_PICKPOCKET_Condition()
{
	return C_Beklauen(10,5);
};

func void DIA_Engrom_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Engrom_PICKPOCKET);
	Info_AddChoice(DIA_Engrom_PICKPOCKET,Dialog_Back,DIA_Engrom_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Engrom_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Engrom_PICKPOCKET_DoIt);
};

func void DIA_Engrom_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Engrom_PICKPOCKET);
};

func void DIA_Engrom_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Engrom_PICKPOCKET);
};

