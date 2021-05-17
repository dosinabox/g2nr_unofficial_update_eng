
instance DIA_Wambo_EXIT(C_Info)
{
	npc = MIL_316_Wambo;
	nr = 999;
	condition = DIA_Wambo_EXIT_Condition;
	information = DIA_Wambo_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Wambo_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Wambo_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Wambo_PICKPOCKET(C_Info)
{
	npc = MIL_316_Wambo;
	nr = 900;
	condition = DIA_Wambo_PICKPOCKET_Condition;
	information = DIA_Wambo_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60_Key;
};


func int DIA_Wambo_PICKPOCKET_Condition()
{
//	return C_StealItems(50,Hlp_GetInstanceID(ItKe_City_Tower_04),1);
	if(Npc_HasItems(self,ItKe_City_Tower_04))
	{
		return C_StealItem(50);
	};
	return FALSE;
};

func void DIA_Wambo_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Wambo_PICKPOCKET);
	Info_AddChoice(DIA_Wambo_PICKPOCKET,Dialog_Back,DIA_Wambo_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Wambo_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Wambo_PICKPOCKET_DoIt);
};

func void DIA_Wambo_PICKPOCKET_DoIt()
{
//	B_StealItems(50,Hlp_GetInstanceID(ItKe_City_Tower_04),1);
	B_StealItem(50,Hlp_GetInstanceID(ItKe_City_Tower_04));
	Info_ClearChoices(DIA_Wambo_PICKPOCKET);
};

func void DIA_Wambo_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Wambo_PICKPOCKET);
};


var int DIA_Wambo_Deal_permanent;

instance DIA_Wambo_Job(C_Info)
{
	npc = MIL_316_Wambo;
	nr = 5;
	condition = DIA_Wambo_Job_Condition;
	information = DIA_Wambo_Job_Info;
	permanent = FALSE;
	description = "What are you doing here?";
};


func int DIA_Wambo_Job_Condition()
{
	if(DIA_Wambo_Deal_permanent == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Wambo_Job_Info()
{
	AI_Output (other, self, "DIA_Wambo_Job_15_00");	//What are you doing here?
	AI_Output (self, other, "DIA_Wambo_Job_03_01");	//I make sure that nobody enters the houses.
	AI_Output (self, other, "DIA_Wambo_Job_03_02");	//Explicit order from Lord Hagen. And don't even think about violating this order!
};


instance DIA_Wambo_Situation(C_Info)
{
	npc = MIL_316_Wambo;
	nr = 10;
	condition = DIA_Wambo_Situation_Condition;
	information = DIA_Wambo_Situation_Info;
	permanent = TRUE;
	description = "How are things?";
};


func int DIA_Wambo_Situation_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wambo_Job) || (DIA_Wambo_Deal_permanent == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Wambo_Situation_Info()
{
	AI_Output (other, self, "DIA_Wambo_Situation_15_00");	//How are things?
	AI_Output (self, other, "DIA_Wambo_Situation_03_01");	//At the moment, everything is quiet.
};


instance DIA_Wambo_Ramirez(C_Info)
{
	npc = MIL_316_Wambo;
	nr = 5;
	condition = DIA_Wambo_Ramirez_Condition;
	information = DIA_Wambo_Ramirez_Info;
	permanent = FALSE;
	description = "I come from our mutual friend Ramirez.";
};


func int DIA_Wambo_Ramirez_Condition()
{
	if(RamirezToldAboutWambo == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Wambo_Ramirez_Info()
{
	AI_Output (other, self, "DIA_Wambo_Ramirez_15_00");	//I come from our mutual friend Ramirez.
	AI_Output (self, other, "DIA_Wambo_Ramirez_03_01");	//Oh? That Ramirez is a little rat. And he's no friend of mine. Never mind. Did you bring me anything?
	AI_Output (other, self, "DIA_Wambo_Ramirez_15_02");	//That depends on what it is you want.
	AI_PlayAni (self, "T_SEARCH");
	AI_Output (self, other, "DIA_Wambo_Ramirez_03_03");	//(quietly) Okay, I'll tell you how it works. You pay 250 gold pieces. Then I won't be here at night.
	AI_Output (self, other, "DIA_Wambo_Ramirez_03_04");	//If you're too conspicuous anyway and I happen to be in the area, the deal is off.
};


instance DIA_Wambo_Deal(C_Info)
{
	npc = MIL_316_Wambo;
	nr = 5;
	condition = DIA_Wambo_Deal_Condition;
	information = DIA_Wambo_Deal_Info;
	permanent = TRUE;
	description = "I've got your money... (pay 250 gold)";
};


func int DIA_Wambo_Deal_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Wambo_Ramirez) && (DIA_Wambo_Deal_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Wambo_Deal_Info()
{
	AI_Output(other,self,"DIA_Wambo_Deal_15_00");	//I've got your money...
	if(B_GiveInvItems(other,self,ItMi_Gold,250))
	{
		AI_Output (self, other, "DIA_Wambo_Deal_03_01");	//All right, then I'll disappear in the evening from now on.
		AI_Output (self, other, "DIA_Wambo_Deal_03_02");	//And remember - if you cause trouble around me, I don't know you.
		DIA_Wambo_Deal_permanent = TRUE;
		AI_StopProcessInfos(self);
		Npc_ExchangeRoutine(self,"DRINK");
	}
	else
	{
		AI_Output (other, self, "DIA_Wambo_Deal_15_03");	//... but not with me right now.
		AI_Output (self, other, "DIA_Wambo_Deal_03_04");	//I can't stand it when somebody tries to make a fool out of me. So get the gold.
		AI_StopProcessInfos (self);
	};
};

