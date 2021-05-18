
instance DIA_Balthasar_EXIT(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 999;
	condition = DIA_Balthasar_EXIT_Condition;
	information = DIA_Balthasar_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Balthasar_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Balthasar_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Balthasar_HALLO(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 3;
	condition = DIA_Balthasar_HALLO_Condition;
	information = DIA_Balthasar_HALLO_Info;
	description = "How are things?";
};


func int DIA_Balthasar_HALLO_Condition()
{
	return TRUE;
};

func void DIA_Balthasar_HALLO_Info()
{
	AI_Output(other,self,"DIA_Balthasar_HALLO_15_00");	//How are things?
	if((VisibleGuild(other) == GIL_NONE) || (VisibleGuild(other) == GIL_NOV) || (VisibleGuild(other) == GIL_SLD))
	{
	AI_Output (self, other, "DIA_Balthasar_HALLO_05_01");	//Ah, a new face here on the farm. Has the old skinflint finally granted me an apprentice?
	AI_Output (other, self, "DIA_Balthasar_HALLO_15_02");	//I'm not an apprentice.
	AI_Output (self, other, "DIA_Balthasar_HALLO_05_03");	//Oh. I see. I'm not as young as I used to be, you know? And I've been waiting for a replacement for years.
	};
	AI_Output(self,other,"DIA_Balthasar_HALLO_05_04");	//You aren't here because the neighbors are annoyed, are you?
};


instance DIA_Balthasar_WASMACHSTDU(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 4;
	condition = DIA_Balthasar_WASMACHSTDU_Condition;
	information = DIA_Balthasar_WASMACHSTDU_Info;
	description = "What's the work you do here?";
};


func int DIA_Balthasar_WASMACHSTDU_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Balthasar_HALLO))
	{
		return TRUE;
	};
};

func void DIA_Balthasar_WASMACHSTDU_Info()
{
	AI_Output (other, self, "DIA_Balthasar_WASMACHSTDU_15_00");	//What's the work you do here?
	AI_Output (self, other, "DIA_Balthasar_WASMACHSTDU_05_01");	//Oh, I guard the sheep, and I've been doing that for as long as I can remember.
	AI_Output (self, other, "DIA_Balthasar_WASMACHSTDU_05_02");	//The animals are very loyal and very smart, you see. If you treat them well, they'll follow you for a lifetime.
};


instance DIA_Addon_Balthasar_Rangerbandits(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 5;
	condition = DIA_Addon_Balthasar_Rangerbandits_Condition;
	information = DIA_Addon_Balthasar_Rangerbandits_Info;
	description = "Have you seen any bandits passing through here?";
};


func int DIA_Addon_Balthasar_Rangerbandits_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Balthasar_HALLO) && ((MIS_Vatras_FindTheBanditTrader == LOG_Running) || (SC_KnowsLuciaCaughtByBandits == TRUE)))
	{
		return TRUE;
	};
};

func void DIA_Addon_Balthasar_Rangerbandits_Info()
{
	AI_Output(other,self,"DIA_Addon_Balthasar_Rangerbandits_15_00");	//Have you seen any bandits passing through here?
	AI_Output(self,other,"DIA_Addon_Balthasar_Rangerbandits_05_01");	//I certainly have. They passed along the edge of the field near Sekob's farm and entered the forest to the north.
	AI_Output(self,other,"DIA_Addon_Balthasar_Rangerbandits_05_02");	//They were carrying loads of weapons. They looked like they were all set to win the war against the orcs.
	AI_Output(self,other,"DIA_Addon_Balthasar_Rangerbandits_05_03");	//If my eyes didn't deceive me, they were also dragging a young woman along to the forest.
	AI_Output(self,other,"DIA_Addon_Balthasar_Rangerbandits_05_04");	//I really hope they left her alone.
	AI_Output(self,other,"DIA_Addon_Balthasar_Rangerbandits_05_05");	//I'm just glad they stayed away from our farm.
	B_GivePlayerXP(XP_Ambient);
};


func int C_BalthasarSheepsAreDead()
{
	if(Npc_IsDead(BalthasarSheep1) && Npc_IsDead(BalthasarSheep2) && Npc_IsDead(BalthasarSheep3))
	{
		return TRUE;
	};
	return FALSE;
};

func void B_BalthasarLostHisSheeps()
{
	AI_WaitTillEnd(self,other);
	AI_PlayAni(self,"T_SEARCH");
	AI_Output(self,other,"DIA_Balthasar_PERMKAP1_05_02_add");	//I can't find my sheep!@@@
	AI_StopProcessInfos(self);
	MIS_Balthasar_BengarsWeide = LOG_OBSOLETE;
	B_CheckLog();
};

instance DIA_Balthasar_AERGERMITNACHBARN(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 5;
	condition = DIA_Balthasar_AERGERMITNACHBARN_Condition;
	information = DIA_Balthasar_AERGERMITNACHBARN_Info;
	description = "What's the trouble with your neighbors?";
};


func int DIA_Balthasar_AERGERMITNACHBARN_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Balthasar_WASMACHSTDU) && ((other.guild == GIL_NONE) || (other.guild == GIL_SLD) || (other.guild == GIL_DJG)))
	{
		return TRUE;
	};
};

func void DIA_Balthasar_AERGERMITNACHBARN_Info()
{
	AI_Output (other, self, "DIA_Balthasar_AERGERMITNACHBARN_15_00");	//What's the trouble with your neighbors?
	AI_Output (self, other, "DIA_Balthasar_AERGERMITNACHBARN_05_01");	//The grass on this side of the big field is always so stunted and dry. So I mostly go to the big pastures of the other farmers.
	AI_Output (self, other, "DIA_Balthasar_AERGERMITNACHBARN_05_02");	//The landowner doesn't mind, but Bengar, the farmer on the high pastures, always makes a huge deal out of it when I take the animals up there.
	AI_Output (self, other, "DIA_Balthasar_AERGERMITNACHBARN_05_03");	//He says Sekob should pay if I take his animals onto Bengar's pasture.
	AI_Output (self, other, "DIA_Balthasar_AERGERMITNACHBARN_05_04");	//But Sekob won't spend a measly coin for that, so I can't go up onto the plateau anymore.
};


instance DIA_Balthasar_WOBENGAR(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 10;
	condition = DIA_Balthasar_WOBENGAR_Condition;
	information = DIA_Balthasar_WOBENGAR_Info;
	description = "Where can I find the high pastures and Bengar's farm?";
};


func int DIA_Balthasar_WOBENGAR_Condition()
{
	if(BalthasarMovedToBengar == TRUE)
	{
		return FALSE;
	};
	if(Npc_KnowsInfo(other,DIA_Balthasar_AERGERMITNACHBARN))
	{
		DIA_Balthasar_WOBENGAR.description = "Where can I find the high pastures and Bengar's farm?";
		return TRUE;
	};
	if(Npc_KnowsInfo(other,DIA_Rosi_BENGAR))
	{
		DIA_Balthasar_WOBENGAR.description = "How can I find Bengar's farm?";
		return TRUE;
	};
};

func void DIA_Balthasar_WOBENGAR_Info()
{
	if(Npc_KnowsInfo(other,DIA_Balthasar_AERGERMITNACHBARN))
	{
		AI_Output(other,self,"DIA_Balthasar_WOBENGAR_15_00");	//Where can I find the high pastures and Bengar's farm?
	}
	else if(Npc_KnowsInfo(other,DIA_Rosi_BENGAR))
	{
		AI_Output(other,self,"B_Torlof_BengarMilizKlatschen_15_03");	//How can I find Bengar's farm?
	};
	AI_Output(self,other,"DIA_Balthasar_WOBENGAR_05_01");	//Follow this path and cross the big crossroad.
	AI_Output(self,other,"DIA_Balthasar_WOBENGAR_05_02");	//If you stick to the right, you'll see a big outcropping of rock. Behind that to the right are the high pastures and the pass.
};


instance DIA_Balthasar_TALKTOBENGAR(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 6;
	condition = DIA_Balthasar_TALKTOBENGAR_Condition;
	information = DIA_Balthasar_TALKTOBENGAR_Info;
	description = "Maybe I should talk to Bengar.";
};


func int DIA_Balthasar_TALKTOBENGAR_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Balthasar_AERGERMITNACHBARN) && ((other.guild == GIL_NONE) || (other.guild == GIL_SLD) || (other.guild == GIL_DJG)))
	{
		return TRUE;
	};
};

func void DIA_Balthasar_TALKTOBENGAR_Info()
{
	AI_Output(other,self,"DIA_Balthasar_TALKTOBENGAR_15_00");	//Maybe I should talk to Bengar.
	if(!C_BalthasarSheepsAreDead())
	{
	AI_Output (self, other, "DIA_Balthasar_TALKTOBENGAR_05_01");	//You'd do that for me? What will you tell him, I mean, I don't want any trouble, you hear?
	AI_Output (other, self, "DIA_Balthasar_TALKTOBENGAR_15_02");	//We'll see about that.
		Log_CreateTopic(TOPIC_BalthasarsSchafe,LOG_MISSION);
		Log_SetTopicStatus(TOPIC_BalthasarsSchafe,LOG_Running);
		B_LogEntry(TOPIC_BalthasarsSchafe,"Farmer Bengar has forbidden Balthasar the shepherd to take his sheep to the high pastures.");
		MIS_Balthasar_BengarsWeide = LOG_Running;
	}
	else
	{
		B_BalthasarLostHisSheeps();
	};
};


instance DIA_Balthasar_BENGARUEBERREDET(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 8;
	condition = DIA_Balthasar_BENGARUEBERREDET_Condition;
	information = DIA_Balthasar_BENGARUEBERREDET_Info;
	description = "You can bring your sheep back to Bengar's pastures.";
};


func int DIA_Balthasar_BENGARUEBERREDET_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Balthasar_TALKTOBENGAR) && (MIS_Balthasar_BengarsWeide == LOG_SUCCESS))
	{
		return TRUE;
	};
};

func void DIA_Balthasar_BENGARUEBERREDET_Info()
{
	AI_Output(other,self,"DIA_Balthasar_BENGARUEBERREDET_15_00");	//You can bring your sheep back to Bengar's pastures. I've talked to him.
	if(!C_BalthasarSheepsAreDead())
	{
		AI_Output(self,other,"DIA_Balthasar_BENGARUEBERREDET_05_01");	//Thank you. I'll be right on my way.
		AI_Output(self,other,"DIA_Balthasar_BENGARUEBERREDET_05_02");	//Here, take these sheepskins as a token of my appreciation.
		B_GiveInvItems(self,other,ItAt_SheepFur,10);
		AI_StopProcessInfos(self);
		Npc_ExchangeRoutine(self,"BengarsWeide");
		B_GivePlayerXP(XP_Balthasar_BengarsWeide);
		if(Hlp_IsValidNpc(BalthasarSheep1) && !Npc_IsDead(BalthasarSheep1))
		{
			BalthasarSheep1.wp = "NW_BIGMILL_FARM3_BALTHASAR";
			BalthasarSheep1.start_aistate = ZS_MM_AllScheduler;
			B_StartOtherRoutine(BalthasarSheep1,"NewFarm");
		};
		if(Hlp_IsValidNpc(BalthasarSheep2) && !Npc_IsDead(BalthasarSheep2))
		{
			BalthasarSheep2.wp = "NW_BIGMILL_FARM3_BALTHASAR";
			BalthasarSheep2.start_aistate = ZS_MM_AllScheduler;
			B_StartOtherRoutine(BalthasarSheep2,"NewFarm");
		};
		if(Hlp_IsValidNpc(BalthasarSheep3) && !Npc_IsDead(BalthasarSheep3))
		{
			BalthasarSheep3.wp = "NW_BIGMILL_FARM3_BALTHASAR";
			BalthasarSheep3.start_aistate = ZS_MM_AllScheduler;
			B_StartOtherRoutine(BalthasarSheep3,"NewFarm");
		};
		BalthasarMovedToBengar = TRUE;
	}
	else
	{
		B_BalthasarLostHisSheeps();
	};
};


instance DIA_Balthasar_PERMKAP1(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 70;
	condition = DIA_Balthasar_PERMKAP1_Condition;
	information = DIA_Balthasar_PERMKAP1_Info;
	permanent = TRUE;
	description = "Everything else all right?";
};


func int DIA_Balthasar_PERMKAP1_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Balthasar_WASMACHSTDU))
	{
		return TRUE;
	};
};

func void DIA_Balthasar_PERMKAP1_Info()
{
	AI_Output(other,self,"DIA_Balthasar_PERMKAP1_15_00");	//Everything else all right?
	if(!C_BalthasarSheepsAreDead())
	{
		AI_Output(self,other,"DIA_Balthasar_PERMKAP1_05_01");	//I can't complain. Thanks for asking.
		AI_StopProcessInfos(self);
	}
	else
	{
		AI_Output(self,other,"DIA_Balthasar_PERMKAP1_05_02");	//These are bad times. I can't find my sheep!
		if(!Npc_IsDead(Sekob))
		{
			AI_Output(self,other,"DIA_Balthasar_PERMKAP1_05_03");	//I guess I'll have to fess up to Sekob.
		};
		AI_StopProcessInfos(self);
		if(BalthasarMovedToBengar == TRUE)
		{
			if(Kapitel < 3)
			{
				Npc_ExchangeRoutine(self,"Start");
			}
			else if(Npc_IsDead(DMT_DementorAmbientSekob1) && Npc_IsDead(DMT_DementorAmbientSekob2) && Npc_IsDead(DMT_DementorAmbientSekob3) && Npc_IsDead(DMT_DementorAmbientSekob4))
			{
				Npc_ExchangeRoutine(self,"Start");
			}
			else
			{
				Npc_ExchangeRoutine(self,"FleeDMT");
			};
			BalthasarMovedToBengar = FALSE;
		};
	};
};


instance DIA_Balthasar_PICKPOCKET(C_Info)
{
	npc = BAU_932_Balthasar;
	nr = 900;
	condition = DIA_Balthasar_PICKPOCKET_Condition;
	information = DIA_Balthasar_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_20;
};


func int DIA_Balthasar_PICKPOCKET_Condition()
{
	return C_Beklauen(10,10);
};

func void DIA_Balthasar_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Balthasar_PICKPOCKET);
	Info_AddChoice(DIA_Balthasar_PICKPOCKET,Dialog_Back,DIA_Balthasar_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Balthasar_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Balthasar_PICKPOCKET_DoIt);
};

func void DIA_Balthasar_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Balthasar_PICKPOCKET);
};

func void DIA_Balthasar_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Balthasar_PICKPOCKET);
};

