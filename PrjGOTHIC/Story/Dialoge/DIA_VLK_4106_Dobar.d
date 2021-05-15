
instance DIA_Dobar_EXIT(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 999;
	condition = DIA_Dobar_EXIT_Condition;
	information = DIA_Dobar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Dobar_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Dobar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Dobar_HALLO(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 2;
	condition = DIA_Dobar_HALLO_Condition;
	information = DIA_Dobar_HALLO_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Dobar_HALLO_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Dobar_HALLO_Info()
{
	AI_Output (self, other, "DIA_Dobar_HALLO_08_00");	//(grumpily) What do you want?
};


instance DIA_Dobar_Talent(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 3;
	condition = DIA_Dobar_Talent_Condition;
	information = DIA_Dobar_Talent_Info;
	permanent = FALSE;
	description = "I know a thing or two about forging.";
};


func int DIA_Dobar_Talent_Condition()
{
	if(Npc_GetTalentSkill(other,NPC_TALENT_SMITH) > 0)
	{
		return TRUE;
	};
};

func void DIA_Dobar_Talent_Info()
{
	AI_Output (other, self, "DIA_Dobar_Talent_15_00");	//I know a thing or two about forging.
	AI_Output (self, other, "DIA_Dobar_Talent_08_01");	//Fine ... so what?
};


instance DIA_Dobar_Schmiede(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 3;
	condition = DIA_Dobar_Schmiede_Condition;
	information = DIA_Dobar_Schmiede_Info;
	permanent = FALSE;
	description = "Can I use your smithy?";
};


func int DIA_Dobar_Schmiede_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dobar_Talent))
	{
		return TRUE;
	};
};

func void DIA_Dobar_Schmiede_Info()
{
	AI_Output (other, self, "DIA_Dobar_Schmiede_15_00");	//Can I use your smithy?
	AI_Output (self, other, "DIA_Dobar_Schmiede_08_01");	//I've got a lot to do. We'd only be in each other's way. Just wait until it gets dark.
	AI_Output (self, other, "DIA_Dobar_Schmiede_08_02");	//Then Parlaf and I will hit the sack and you can work undisturbed.
};


instance DIA_Dobar_beibringen(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 4;
	condition = DIA_Dobar_beibringen_Condition;
	information = DIA_Dobar_beibringen_Info;
	permanent = FALSE;
	description = "Can you teach me something?";
};


func int DIA_Dobar_beibringen_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Dobar_Talent))
	{
		return TRUE;
	};
};

func void DIA_Dobar_beibringen_Info()
{
	AI_Output (other, self, "DIA_Dobar_beibringen_15_00");	//Can you teach me something?
	AI_Output (self, other, "DIA_Dobar_beibringen_08_01");	//So you already know the basics. I can show you how to improve your work.
	AI_Output (self, other, "DIA_Dobar_beibringen_08_02");	//Then you'll be in a position to make better weapons.
	Dobar_Learnsmith = TRUE;
	Log_CreateTopic (TOPIC_Teacher_OC, LOG_NOTE);
	B_LogEntry (TOPIC_Teacher_OC, "Dobar can teach me to forge better weapons.");
};


instance DIA_Dobar_Teach(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 5;
	condition = DIA_Dobar_Teach_Condition;
	information = DIA_Dobar_Teach_Info;
	description = B_BuildLearnString ("Show me how I can forge a good sword!", B_GetLearnCostTalent (other, NPC_TALENT_SMITH, WEAPON_1H_Special_01));
	permanent = TRUE;
};


func int DIA_Dobar_Teach_Condition()
{
	if((Dobar_Learnsmith == TRUE) && (PLAYER_TALENT_SMITH[WEAPON_1H_Special_01] == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Dobar_Teach_Info()
{
	AI_Output (other, self, "DIA_Dobar_Teach_15_00");	//Show me how I can forge a good sword!
	if (B_TeachPlayerTalentSmith (self, hero, WEAPON_1H_Special_01))
	{
		AI_Output (self, other, "DIA_Dobar_Teach_08_01");	//Make sure that the steel glows evenly all around, so that you get an even blade afterwards.
		AI_Output (self, other, "DIA_Dobar_Teach_08_02");	//If you keep that in mind, the blades you forge will be harder and sharper.
		if(!Npc_IsDead(Engor))
		{
		AI_Output (self, other, "DIA_Dobar_Teach_08_03");	//That is all you need to know. If you're looking for steel here in the castle, talk to Engor.
			B_EngorTradeLog();
		};
	};
};


instance DIA_Dobar_Waffe(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 6;
	condition = DIA_Dobar_Waffe_Condition;
	information = DIA_Dobar_Waffe_Info;
	permanent = FALSE;
	description = "Could you make a weapon for me?";
};


func int DIA_Dobar_Waffe_Condition()
{
	return TRUE;
};

func void DIA_Dobar_Waffe_Info()
{
	AI_Output(other,self,"DIA_Dobar_Waffe_15_00");	//Could you make a weapon for me?
	AI_Output (self, other, "DIA_Dobar_Waffe_08_01");	//I don't have time for that. Tandor hands out the weapons - I just make them, and Parlaf sharpens them.
	if(!Npc_KnowsInfo(other,DIA_Keroloth_WantTeach) && !Npc_KnowsInfo(other,DIA_Tandor_Hallo) && !Npc_KnowsInfo(other,DIA_Garond_Equipment))
	{
		Log_CreateTopic(TOPIC_Trader_OC,LOG_NOTE);
		B_LogEntry(TOPIC_Trader_OC,"Tandor trades in weapons at the castle.");
	};
};


instance DIA_Dobar_NEWS(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 7;
	condition = DIA_Dobar_NEWS_Condition;
	information = DIA_Dobar_NEWS_Info;
	permanent = TRUE;
	description = "How's work?";
};


func int DIA_Dobar_NEWS_Condition()
{
	return TRUE;
};

func void DIA_Dobar_NEWS_Info()
{
	AI_Output (other, self, "DIA_Dobar_NEWS_15_00");	//How's work?
	if (Dobar_einmalig == FALSE)
	{
		AI_Output (self, other, "DIA_Dobar_NEWS_08_01");	//I forge the weapons for the castle's knights. Since we've been here, I've been fully occupied making new weapons.
		AI_Output (self, other, "DIA_Dobar_NEWS_08_02");	//And we'll need them, too. We'll show these damned orcs how sharp our blades are.
		if(!Npc_IsDead(Parlaf) && (Npc_GetDistToWP(Parlaf,"OC_SMITH_SHARP") < 500))
		{
			B_TurnToNpc(self,Parlaf);
			AI_Output (self, other, "DIA_Dobar_NEWS_08_03");	//(calls) Hey, Parlaf - make those blades nice and sharp - orcs are damn tough creatures!
			B_TurnToNpc(self,other);
		};
		Dobar_einmalig = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Dobar_NEWS_08_04");	//It could be better. If you didn't constantly interrupt me, I might actually get something done.
	};
};


instance DIA_Dobar_PICKPOCKET(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 900;
	condition = DIA_Dobar_PICKPOCKET_Condition;
	information = DIA_Dobar_PICKPOCKET_Info;
	permanent = TRUE;
	description = "(It would be difficult to steal his ore nugget)";
};


func int DIA_Dobar_PICKPOCKET_Condition()
{
//	return C_StealItems(79,Hlp_GetInstanceID(ItMi_Nugget),1);
	if(Npc_HasItems(self,ItMi_Nugget))
	{
		return C_StealItem(79);
	};
	return FALSE;
};

func void DIA_Dobar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Dobar_PICKPOCKET);
	Info_AddChoice(DIA_Dobar_PICKPOCKET,Dialog_Back,DIA_Dobar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Dobar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Dobar_PICKPOCKET_DoIt);
};

func void DIA_Dobar_PICKPOCKET_DoIt()
{
//	B_StealItems(79,Hlp_GetInstanceID(ItMi_Nugget),1);
	B_StealItem(79,Hlp_GetInstanceID(ItMi_Nugget));
	Info_ClearChoices(DIA_Dobar_PICKPOCKET);
};

func void DIA_Dobar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Dobar_PICKPOCKET);
};

instance DIA_Dobar_RepairNecklace(C_Info)
{
	npc = VLK_4106_Dobar;
	nr = 8;
	condition = DIA_Dobar_RepairNecklace_Condition;
	information = DIA_Dobar_RepairNecklace_Info;
	permanent = FALSE;
	description = "Ты можешь чинить драгоценности?";
};


func int DIA_Dobar_RepairNecklace_Condition()
{
	if((MIS_Bennet_InnosEyeRepairedSetting != LOG_SUCCESS) && (Npc_HasItems(other,ItMi_InnosEye_Broken_Mis) || (MIS_SCKnowsInnosEyeIsBroken == TRUE)))
	{
		if(!Npc_KnowsInfo(other,DIA_Bennet_ShowInnosEye))
		{
			return TRUE;
		};
	};
};

func void DIA_Dobar_RepairNecklace_Info()
{
	DIA_Common_CanYouRepairJewelry();
	AI_Output(self,other,"DIA_Dobar_NEWS_08_01");	//I forge the weapons for the castle's knights. Since we've been here, I've been fully occupied making new weapons.
	MIS_SCKnowsInnosEyeIsBroken = TRUE;
};

