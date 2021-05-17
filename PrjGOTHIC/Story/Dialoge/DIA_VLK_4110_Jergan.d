
instance DIA_Jergan_EXIT(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 999;
	condition = DIA_Jergan_EXIT_Condition;
	information = DIA_Jergan_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Jergan_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Jergan_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Jergan_Hallo(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 2;
	condition = DIA_Jergan_Hallo_Condition;
	information = DIA_Jergan_Hallo_Info;
	permanent = FALSE;
	description = "What are you standing around here for?";
};


func int DIA_Jergan_Hallo_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Garond_NeedProof))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Hallo_Info()
{
	AI_Output (other, self, "DIA_Jergan_Hallo_15_00");	//What are you standing around here for?
	AI_Output (self, other, "DIA_Jergan_Hallo_13_01");	//I come from the castle. They've sent me to look for those missing, and to check out the area.
};


instance DIA_Jergan_Vermisste(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 2;
	condition = DIA_Jergan_Vermisste_Condition;
	information = DIA_Jergan_Vermisste_Info;
	permanent = FALSE;
	description = "Those missing?";
};


func int DIA_Jergan_Vermisste_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jergan_Hallo) || Npc_KnowsInfo(other,DIA_Jergan_Mine))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Vermisste_Info()
{
	AI_Output (other, self, "DIA_Jergan_Vermisste_15_00");	//Those missing?
	AI_Output (self, other, "DIA_Jergan_Vermisste_13_01");	//Some fled when the dragons attacked. Most of them didn't make it - no surprise there!
	AI_Output (self, other, "DIA_Jergan_Vermisste_13_02");	//But if there are any survivors left, I'll bring them back.
};


instance DIA_Jergan_Burg(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 3;
	condition = DIA_Jergan_Burg_Condition;
	information = DIA_Jergan_Burg_Info;
	permanent = FALSE;
	description = "Can you help me get into the castle?";
};


func int DIA_Jergan_Burg_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jergan_Hallo) && !Npc_KnowsInfo(other,DIA_Garond_Hello))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Burg_Info()
{
	AI_Output (other, self, "DIA_Jergan_Burg_15_00");	//Can you help me get into the castle?
	AI_Output (self, other, "DIA_Jergan_Burg_13_01");	//Sure, but you have to do me a favor.
	AI_Output (self, other, "DIA_Jergan_Burg_13_02");	//If you can make it to the castle, talk to the paladin Oric. Tell him that his brother bought it up there at the pass.
	if(!Npc_IsDead(Oric))
	{
		Log_CreateTopic(Topic_OricBruder,LOG_MISSION);
		Log_SetTopicStatus(Topic_OricBruder,LOG_Running);
		B_LogEntry(Topic_OricBruder,"When I'm in the castle, I'm to tell Oric that his brother fell up at the pass.");
	};
};


instance DIA_Jergan_Gegend(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 9;
	condition = DIA_Jergan_Gegend_Condition;
	information = DIA_Jergan_Gegend_Info;
	permanent = TRUE;
	description = "What do I need to know about this area?";
};


func int DIA_Jergan_Gegend_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jergan_Hallo) || Npc_KnowsInfo(other,DIA_Jergan_Mine))
	{
		return TRUE;
	};
};


var int Jergan_Tell;

func void DIA_Jergan_Gegend_Info()
{
	AI_Output(other,self,"DIA_Jergan_Gegend_15_00");	//What do I need to know about this area?
	if(Jergan_Tell == FALSE)
	{
		AI_Output (self, other, "DIA_Jergan_Gegend_13_01");	//If you want to live, go back to wherever you came from.
		AI_Output (self, other, "DIA_Jergan_Gegend_13_02");	//The greenhides have laid siege to the castle for weeks now - and those dragons are hiding out somewhere, too.
	};
	AI_Output (self, other, "DIA_Jergan_Gegend_13_03");	//The entire Valley of Mines is teeming with orcs - no matter where you're headed, this won't be a picnic.
	Jergan_Tell = TRUE;
};


instance DIA_Jergan_Hilfe(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 3;
	condition = DIA_Jergan_Hilfe_Condition;
	information = DIA_Jergan_Hilfe_Info;
	permanent = FALSE;
	description = "How can I get into the castle?";
};


func int DIA_Jergan_Hilfe_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jergan_Burg) && !Npc_KnowsInfo(other,DIA_Garond_Hello))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Hilfe_Info()
{
	AI_Output (other, self, "DIA_Jergan_Hilfe_15_00");	//How can I get into the castle?
	AI_Output (self, other, "DIA_Jergan_Hilfe_13_01");	//First of all, you can forget the direct path. But if you walk around the castle, you might have a chance from the back.
	AI_Output (self, other, "DIA_Jergan_Hilfe_13_02");	//You should stay away from the paths and use the river. It will be best if you swim downstream for a stretch. It should be easier from there.
	AI_Output (self, other, "DIA_Jergan_Hilfe_13_03");	//The orcs have set up a ram behind the castle. You can get in that way - creep up on the orcs as closely as you can, and then run for it.
	AI_Output (self, other, "DIA_Jergan_Hilfe_13_04");	//You might just make it if you're fast enough.
};


instance DIA_Jergan_Mine(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 3;
	condition = DIA_Jergan_Mine_Condition;
	information = DIA_Jergan_Mine_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Jergan_Mine_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Garond_NeedProof))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Mine_Info()
{
	AI_Output(other,self,"DIA_Jergan_Mine_15_00");	//What are you doing here?
	if(!Npc_KnowsInfo(other,DIA_Jergan_Hallo))
	{
		AI_Output(self,other,"DIA_Jergan_Hallo_13_01");	//I come from the castle. They've sent me to look for those missing, and to check out the area.
	};
	if(!Npc_KnowsInfo(other,DIA_Jergan_Burg))
	{
		AI_Output(self,other,"DIA_Jergan_Burg_13_02");	//If you can make it to the castle, talk to the paladin Oric. Tell him that his brother bought it up there at the pass.
		if(!Npc_IsDead(Oric))
		{
			Log_CreateTopic(Topic_OricBruder,LOG_MISSION);
			Log_SetTopicStatus(Topic_OricBruder,LOG_Running);
			B_LogEntry(Topic_OricBruder,"When I'm in the castle, I'm to tell Oric that his brother fell up at the pass.");
		};
	};
	AI_Output(self,other,"DIA_Jergan_Mine_13_01");	//I'm a scout. I roam the country. But all those snappers haven't made it easy for me.
	AI_Output(self,other,"DIA_Jergan_Mine_13_02");	//It's a good time to land a few trophies - provided you know what you're doing.
};


instance DIA_Jergan_Claw(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 3;
	condition = DIA_Jergan_Claw_Condition;
	information = DIA_Jergan_Claw_Info;
	permanent = FALSE;
	description = "Can you teach me how to do that?";
};


func int DIA_Jergan_Claw_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jergan_Mine) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Claw_Info()
{
	AI_Output (other, self, "DIA_Jergan_Claw_15_00");	//Can you teach me how to do that?
	AI_Output (self, other, "DIA_Jergan_Claw_13_01");	//I can show you how to pull the claws off those things once they're dead.
	Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_OutTeacher,"Jergan the scout can show me how to remove claws from dead animals.");
};


instance DIA_Jergan_Teach(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 9;
	condition = DIA_Jergan_Teach_Condition;
	information = DIA_Jergan_Teach_Info;
	permanent = TRUE;
//	description = B_BuildLearnString("Show me how to pull claws.",B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Claws));
	description = B_BuildLearnString(NAME_TROPHY_Claws,B_GetLearnCostTalent(other,NPC_TALENT_TAKEANIMALTROPHY,TROPHY_Claws));
};


func int DIA_Jergan_Teach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Jergan_Claw) && (PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Teach_Info()
{
	AI_Output(other,self,"DIA_Jergan_Teach_15_00");	//Show me how to pull claws.
	if(B_TeachPlayerTalentTakeAnimalTrophy(self,other,TROPHY_Claws))
	{
		AI_Output (self, other, "DIA_Jergan_Teach_13_01");	//The important thing is to remove the claws with a jerk. Don't be too hesitant, and don't go poking with a blade.
		AI_Output (self, other, "DIA_Jergan_Teach_13_02");	//You don't only pull the claws from snappers that way, but also from lizards and shadowbeasts.
	};
};


instance DIA_Jergan_Diego(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 9;
	condition = DIA_Jergan_Diego_Condition;
	information = DIA_Jergan_Diego_Info;
	permanent = FALSE;
	description = "Do you know where Diego got to? ";
};


func int DIA_Jergan_Diego_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_DiegoOw_Hallo) && Npc_KnowsInfo(other,DIA_Parcival_Diego))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Diego_Info()
{
	AI_Output (other, self, "DIA_Jergan_Diego_15_00");	//Do you know where Diego got to?
	AI_Output (self, other, "DIA_Jergan_Diego_13_01");	//Diego? He was one of Silvestro's scrapers. But he's made himself scarce.
	AI_Output (self, other, "DIA_Jergan_Diego_13_02");	//I saw him with two knights and a box, not so far from here.
	AI_Output (self, other, "DIA_Jergan_Diego_13_03");	//You can see the old watchtower from here, right? Go over there, and then towards the castle.
	AI_Output (self, other, "DIA_Jergan_Diego_13_04");	//A path leads through the rocks to the right. That's where they went.
};


instance DIA_Jergan_Leader(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 3;
	condition = DIA_Jergan_Leader_Condition;
	information = DIA_Jergan_Leader_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Jergan_Leader_Condition()
{
	if((Npc_GetDistToWP(self,"OW_NEWMINE_04") < 1000) && Npc_IsDead(NewMine_LeadSnapper) && (NewMine_LeadSnapper_Spawned == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Jergan_Leader_Info()
{
	AI_Output (self, other, "DIA_Jergan_Leader_13_00");	//So you killed the leader of the pack. And - did you get the claws off that beast?
	if(Npc_HasItems(other,ItAt_ClawLeader) || (Lutero_Krallen == LOG_SUCCESS))
	{
		AI_Output (other, self, "DIA_Jergan_Leader_15_01");	//Yes.
		AI_Output (self, other, "DIA_Jergan_Leader_13_02");	//They're certainly worth a lot. There are some fellows who collect this stuff.
		AI_Output (self, other, "DIA_Jergan_Leader_13_03");	//If you find the right buyer, you'll get a heap of gold for that.
		if(Lutero_Krallen == LOG_SUCCESS)
		{
			AI_Output(other,self,"DIA_Raoul_TROLLFELL_ja_15_00");	//Sold.
		};
	}
	else
	{
		AI_Output (other, self, "DIA_Jergan_Leader_15_04");	//No.
		AI_Output (self, other, "DIA_Jergan_Leader_13_05");	//You should do that. I'm sure they're worth a fortune.
	};
};


instance DIA_Jergan_PICKPOCKET(C_Info)
{
	npc = VLK_4110_Jergan;
	nr = 900;
	condition = DIA_Jergan_PICKPOCKET_Condition;
	information = DIA_Jergan_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_100;
};


func int DIA_Jergan_PICKPOCKET_Condition()
{
	return C_Beklauen(84,110);
};

func void DIA_Jergan_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Jergan_PICKPOCKET);
	Info_AddChoice(DIA_Jergan_PICKPOCKET,Dialog_Back,DIA_Jergan_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Jergan_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Jergan_PICKPOCKET_DoIt);
};

func void DIA_Jergan_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Jergan_PICKPOCKET);
};

func void DIA_Jergan_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Jergan_PICKPOCKET);
};



