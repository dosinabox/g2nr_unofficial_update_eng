
instance DIA_RodDJG_EXIT(C_Info)
{
	npc = DJG_702_Rod;
	nr = 999;
	condition = DIA_RodDJG_EXIT_Condition;
	information = DIA_RodDJG_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_RodDJG_EXIT_Condition()
{
	return TRUE;
};

func void DIA_RodDJG_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_RodDJG_HALLO(C_Info)
{
	npc = DJG_702_Rod;
	condition = DIA_RodDJG_HALLO_Condition;
	information = DIA_RodDJG_HALLO_Info;
	description = "Everything all right with you?";
};


func int DIA_RodDJG_HALLO_Condition()
{
	if(DJG_SwampParty == FALSE)
	{
		return TRUE;
	};
};

func void DIA_RodDJG_HALLO_Info()
{
	AI_Output (other, self, "DIA_RodDJG_HALLO_15_00");	//Everything all right with you?
	AI_Output (self, other, "DIA_RodDJG_HALLO_06_01");	//These boots are killing me! The new armor is really great, but why do the straps on these boots have to be so tight?
	AI_Output (self, other, "DIA_RodDJG_HALLO_06_02");	//If I loosen them, the boots nearly drop off my feet.
	if(!Npc_IsDead(SwampDragon) && (DJG_SwampParty == FALSE))
	{
		Info_AddChoice (DIA_RodDJG_HALLO, "What are you waiting for?", DIA_RodDJG_HALLO_warten);
	};
	Info_AddChoice (DIA_RodDJG_HALLO, "Where did you get those boots?", DIA_RodDJG_HALLO_Woher);
};

func void DIA_RodDJG_HALLO_Woher()
{
	AI_Output (other, self, "DIA_RodDJG_HALLO_Woher_15_00");	//Where did you get those boots?
	AI_Output (self, other, "DIA_RodDJG_HALLO_Woher_06_01");	//That old warhorse Bennet made them for us dragon hunters, and had us pay him generously for that junk to boot.
	AI_Output (self, other, "DIA_RodDJG_HALLO_Woher_06_02");	//If I ever lay hands on him, I'll make him eat the things first and then force him to give me my money back.
};

func void DIA_RodDJG_HALLO_warten()
{
	AI_Output(other,self,"DIA_RodDJG_HALLO_warten_15_00");	//What are you waiting for?
	Info_ClearChoices(DIA_RodDJG_HALLO);
	if(!Npc_IsDead(DJG_Cipher))
	{
		AI_Output (self, other, "DIA_RodDJG_HALLO_warten_06_01");	//For Cipher to get his ass going at last. It's about time we left.
		AI_StopProcessInfos (self);
	}
	else
	{
		AI_Output (self, other, "DIA_RodDJG_HALLO_warten_06_02");	//I had been thinking about having a closer look at that swampy area over there.
		AI_Output (self, other, "DIA_RodDJG_HALLO_warten_06_03");	//What do you think? Should we go over there together and see what we can find?
		Info_AddChoice (DIA_RodDJG_HALLO, "I'll go by myself.", DIA_RodDJG_HALLO_warten_allein);
		Info_AddChoice (DIA_RodDJG_HALLO, "What do you know about the swamp region?", DIA_RodDJG_HALLO_warten_wasweisstdu);
		Info_AddChoice (DIA_RodDJG_HALLO, "Let's go in together.", DIA_RodDJG_HALLO_warten_zusammen);
	};
};

func void DIA_RodDJG_HALLO_warten_zusammen()
{
	AI_Output (other, self, "DIA_RodDJG_HALLO_warten_zusammen_15_00");	//Let's go in together.
	AI_Output (self, other, "DIA_RodDJG_HALLO_warten_zusammen_06_01");	//All right. Follow me, then.
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,other);
	};
	AI_StopProcessInfos(self);
	self.npcType = NPCTYPE_FRIEND;
	self.aivar[AIV_PARTYMEMBER] = TRUE;
	Npc_ExchangeRoutine(self,"SwampWait2");
};

func void DIA_RodDJG_HALLO_warten_wasweisstdu()
{
	AI_Output (other, self, "DIA_RodDJG_HALLO_warten_wasweisstdu_15_00");	//What do you know about the swamp region?
	AI_Output (self, other, "DIA_RodDJG_HALLO_warten_wasweisstdu_06_01");	//Only that it stinks to high heaven, and that there's probably a load of gold to be had there. Isn't that enough?
};

func void DIA_RodDJG_HALLO_warten_allein()
{
	AI_Output (other, self, "DIA_RodDJG_HALLO_warten_allein_15_00");	//I'll go by myself.
	AI_Output (self, other, "DIA_RodDJG_HALLO_warten_allein_06_01");	//Well, then, I wish you luck.
	AI_StopProcessInfos (self);
};


instance DIA_RodDJG_WARTEMAL(C_Info)
{
	npc = DJG_702_Rod;
	condition = DIA_RodDJG_WARTEMAL_Condition;
	information = DIA_RodDJG_WARTEMAL_Info;
	permanent = TRUE;
	description = "What's the matter with you?";
};


func int DIA_RodDJG_WARTEMAL_Condition()
{
	if(Npc_KnowsInfo(other,DIA_RodDJG_HALLO) || (DJG_SwampParty == TRUE))
	{
		return TRUE;
	};
};

func void DIA_RodDJG_WARTEMAL_Info()
{
	AI_Output (other, self, "DIA_RodDJG_WARTEMAL_15_00");	//What's the matter with you?
	if (((DJG_SwampParty == TRUE) || (Npc_GetDistToWP (self, "OW_DJG_SWAMP_WAIT2_02") < 1000)) && Npc_IsDead (DJG_Cipher))
	{
		AI_Output (self, other, "DIA_RodDJG_WARTEMAL_06_01");	//Listen, man. I think this thing is getting a bit out of hand. I'll just slip quietly away.
		DJG_SwampParty = FALSE;
		AI_StopProcessInfos(self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"Start");
	}
	else
	{
		AI_Output (self, other, "DIA_RodDJG_WARTEMAL_06_02");	//(curses) These boots! These blasted boots!
	};
	if(Npc_IsDead(SwampDragon))
	{
		AI_Output (other, self, "DIA_RodDJG_WARTEMAL_15_03");	//And what are you going to do now?
		AI_Output (self, other, "DIA_RodDJG_WARTEMAL_06_04");	//The questions you ask! First thing I'll buy myself some new boots, man!
		AI_StopProcessInfos(self);
		self.aivar[AIV_PARTYMEMBER] = FALSE;
		Npc_ExchangeRoutine(self,"Start");
	};
	AI_StopProcessInfos(self);
};


instance DIA_RodDJG_GiveItBack(C_Info)
{
	npc = DJG_702_Rod;
	nr = 7;
	condition = DIA_Rod_GiveItBack_Condition;
	information = DIA_Rod_GiveItBack_Info;
	permanent = TRUE;
	description = "Here's your sword back!";
};


instance DIA_Rod_PICKPOCKET(C_Info)
{
	npc = DJG_702_Rod;
	nr = 900;
	condition = DIA_Rod_PICKPOCKET_Condition;
	information = DIA_Rod_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Rod_PICKPOCKET_Condition()
{
	return C_Beklauen(16,320);
};

func void DIA_Rod_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Rod_PICKPOCKET);
	Info_AddChoice(DIA_Rod_PICKPOCKET,Dialog_Back,DIA_Rod_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Rod_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Rod_PICKPOCKET_DoIt);
};

func void DIA_Rod_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Rod_PICKPOCKET);
};

func void DIA_Rod_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Rod_PICKPOCKET);
};

