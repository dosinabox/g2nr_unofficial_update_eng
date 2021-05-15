
instance DIA_Rumbold_EXIT(C_Info)
{
	npc = MIL_335_Rumbold;
	nr = 999;
	condition = DIA_Rumbold_EXIT_Condition;
	information = DIA_Rumbold_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Rumbold_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Rumbold_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Rumbold_PrePerm(C_Info)
{
	npc = MIL_335_Rumbold;
	nr = 1;
	condition = DIA_Rumbold_PrePerm_Condition;
	information = DIA_Rumbold_PrePerm_Info;
	permanent = TRUE;
	description = "What are you doing here?";
};


func int DIA_Rumbold_PrePerm_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Bengar_MILIZKLATSCHEN) || (MIS_Torlof_BengarMilizKlatschen != LOG_Running) || (ScaredRumbold == TRUE) || (Kapitel >= 3))
	{
		if((Kapitel >= 3) || Npc_IsDead(Rick))
		{
			DIA_Rumbold_PrePerm.description = "What's up?";
		}
		else
		{
			DIA_Rumbold_PrePerm.description = "What are you doing here?";
		};
		return TRUE;
	};
};

func void DIA_Rumbold_PrePerm_Info()
{
	if((Kapitel >= 3) || Npc_IsDead(Rick))
	{
		AI_Output(other,self,"DIA_Addon_Owen_MalcomStunt_15_00");	//What's up?
	}
	else
	{
		AI_Output(other,self,"DIA_Rumbold_PrePerm_15_00");	//What are you doing here?
	};
	AI_Output(self,other,"DIA_Rumbold_PrePerm_10_01");	//Beat it! Understand?
	AI_StopProcessInfos(self);
};


instance DIA_Rumbold_Hallo(C_Info)
{
	npc = MIL_335_Rumbold;
	nr = 1;
	condition = DIA_Rumbold_Hallo_Condition;
	information = DIA_Rumbold_Hallo_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Rumbold_Hallo_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Bengar_MILIZKLATSCHEN) && (MIS_Torlof_BengarMilizKlatschen == LOG_Running) && (Kapitel < 3))
	{
		if(ScaredRumbold == FALSE)
		{
			return TRUE;
		};
	};
};

func void DIA_Rumbold_Hallo_Info()
{
	AI_Output(self,other,"DIA_Rumbold_Hallo_10_00");	//Look at this one. Another joke. What are you doing here, huh?
	if(VisibleGuild(other) == GIL_SLD)
	{
		AI_Output(self,other,"DIA_Rumbold_Hallo_10_02");	//You're another one of those filthy mercenaries!
	};
	AI_Output(self,other,"DIA_Rumbold_Hallo_10_01");	//Who the hell are you?
	Info_ClearChoices (DIA_Rumbold_Hallo);
	Info_AddChoice (DIA_Rumbold_Hallo, "I am nobody.", DIA_Rumbold_HALLO_schwanzeinziehen);
	Info_AddChoice (DIA_Rumbold_Hallo, "I want you to disappear from here.", DIA_Rumbold_HALLO_verschwindet);
	Info_AddChoice (DIA_Rumbold_Hallo, "I'm your worst nightmare.", DIA_Rumbold_HALLO_Attack);
};

func void DIA_Rumbold_HALLO_Attack()
{
	AI_Output (other, self, "DIA_Rumbold_HALLO_Attack_15_00");	//I'm your worst nightmare.
	AI_Output (self, other, "DIA_Rumbold_HALLO_Attack_10_01");	//You're a dead man!
	Info_ClearChoices (DIA_Rumbold_Hallo);
	Info_AddChoice (DIA_Rumbold_Hallo, Dialog_Ende, DIA_Rumbold_HALLO_ENDAttack);
};

func void DIA_Rumbold_HALLO_verschwindet()
{
	AI_Output (other, self, "DIA_Rumbold_HALLO_verschwindet_15_00");	//I want you to disappear from here.
	AI_Output (self, other, "DIA_Rumbold_HALLO_verschwindet_10_01");	//Well, well. So you want us to disappear.
	AI_Output (self, other, "DIA_Rumbold_HALLO_verschwindet_10_02");	//(threatening) What'll happen if we don't go, hey?
	Info_ClearChoices (DIA_Rumbold_Hallo);
	Info_AddChoice (DIA_Rumbold_Hallo, "What do I have to pay you to get lost?", DIA_Rumbold_HALLO_geld);
	Info_AddChoice (DIA_Rumbold_Hallo, "In that case, you've bothered the farmers for the last time.", DIA_Rumbold_HALLO_AufsMaul);
};

func void DIA_Rumbold_HALLO_AufsMaul()
{
	AI_Output (other, self, "DIA_Rumbold_HALLO_AufsMaul_15_00");	//In that case, you've bothered the farmers for the last time.
	AI_Output (self, other, "DIA_Rumbold_HALLO_AufsMaul_10_01");	//You've bitten off more than you can chew, moron!
	Info_ClearChoices (DIA_Rumbold_Hallo);
	Info_AddChoice (DIA_Rumbold_Hallo, Dialog_Ende, DIA_Rumbold_HALLO_ENDAttack);
};

func void DIA_Rumbold_HALLO_geld()
{
	AI_Output (other, self, "DIA_Rumbold_HALLO_geld_15_00");	//What do I have to pay you to get lost?
	AI_Output (self, other, "DIA_Rumbold_HALLO_geld_10_01");	//You want to pay for Bengar? That's different.
	AI_Output (self, other, "DIA_Rumbold_HALLO_geld_10_02");	//Let me think. With all his outstanding expenses, Bengar still owes us 65 gold coins.
	AI_Output (self, other, "DIA_Rumbold_HALLO_geld_10_03");	//Either pay the dough or go stand quietly in the corner.
	AI_Output (self, other, "DIA_Rumbold_HALLO_geld_10_04");	//So. Are you Bengar's treasurer, or what?
	Info_ClearChoices (DIA_Rumbold_Hallo);
	Info_AddChoice (DIA_Rumbold_Hallo, "Are you crazy? That's way too much.", DIA_Rumbold_HALLO_Geld_TooMuch);
	if (Npc_HasItems (other, ItMi_Gold) >= 65)
	{
		Info_AddChoice (DIA_Rumbold_Hallo, "Here's your money, now scram.", DIA_Rumbold_HALLO_geld_ok);
	};
};

func void DIA_Rumbold_HALLO_geld_ok()
{
	AI_Output (other, self, "DIA_Rumbold_HALLO_geld_ok_15_00");	//Here's your money, and now scram.
	B_GiveInvItems (other, self, ItMi_Gold, 65);
	AI_Output (self, other, "DIA_Rumbold_HALLO_geld_ok_10_01");	//I don't care who pays for Bengar. Have a nice day. (to himself) Moron!
	AI_StopProcessInfos (self);
	Rumbold_Bezahlt = TRUE;
	if((VisibleGuild(other) == GIL_NONE) || (VisibleGuild(other) == GIL_NOV))
	{
		Npc_ExchangeRoutine(self,"Start");
		B_StartOtherRoutine(Rick,"Start");
	}
	else
	{
		Npc_ExchangeRoutine(self,"Flucht3");
		self.aivar[AIV_DropDeadAndKill] = FALSE;
		if(!Npc_IsDead(Rick))
		{
			B_StartOtherRoutine(Rick,"Flucht3");
			Rick.aivar[AIV_DropDeadAndKill] = FALSE;
		};
		Miliz_Flucht = TRUE;
	};
	if(Hlp_IsValidNpc(Bengar) && !Npc_IsDead(Bengar))
	{
		B_StartOtherRoutine(Bengar,"Start");
	};
};

func void DIA_Rumbold_HALLO_Geld_TooMuch()
{
	AI_Output (other, self, "DIA_Rumbold_HALLO_geld_TooMuch_15_00");	//Are you crazy? That's way too much.
	AI_Output (self, other, "DIA_Rumbold_HALLO_geld_TooMuch_10_01");	//Then go hide in your corner!
	AI_StopProcessInfos (self);
};

func void DIA_Rumbold_HALLO_schwanzeinziehen()
{
	AI_Output (other, self, "DIA_Rumbold_HALLO_schwanzeinziehen_15_00");	//I am nobody.
	AI_Output (self, other, "DIA_Rumbold_HALLO_schwanzeinziehen_10_01");	//Then get out of my way!
	AI_StopProcessInfos (self);
};

func void DIA_Rumbold_HALLO_ENDAttack()
{
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
	if(Hlp_IsValidNpc(Rick) && !C_NpcIsDown(Rick))
	{
		B_Attack(Rick,other,AR_KILL,1);
	};
};


instance DIA_Rumbold_FightNow(C_Info)
{
	npc = MIL_335_Rumbold;
	nr = 1;
	condition = DIA_Rumbold_FightNow_Condition;
	information = DIA_Rumbold_FightNow_Info;
	permanent = TRUE;
	description = "Leave the farmer alone!";
};


func int DIA_Rumbold_FightNow_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rumbold_Hallo) && (Rumbold_Bezahlt == FALSE) && (MIS_Torlof_BengarMilizKlatschen == LOG_Running) && (Kapitel < 3))
	{
		if(ScaredRumbold == FALSE)
		{
			return TRUE;
		};
	};
};

func void DIA_Rumbold_FightNow_Info()
{
	AI_Output (other, self, "DIA_Rumbold_FightNow_15_00");	//Leave the farmer alone!
	AI_Output (self, other, "DIA_Rumbold_FightNow_10_01");	//Is there something wrong with your ears, boy?
	Info_ClearChoices (DIA_Rumbold_FightNow);
	Info_AddChoice (DIA_Rumbold_FightNow, Dialog_Ende, DIA_Rumbold_FightNow_ENDAttack);
};

func void DIA_Rumbold_FightNow_ENDAttack()
{
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
	if(Hlp_IsValidNpc(Rick) && !C_NpcIsDown(Rick))
	{
		B_Attack(Rick,other,AR_KILL,1);
	};
};


instance DIA_Rumbold_StillThere(C_Info)
{
	npc = MIL_335_Rumbold;
	nr = 1;
	condition = DIA_Rumbold_StillThere_Condition;
	information = DIA_Rumbold_StillThere_Info;
	permanent = TRUE;
	description = "Hey, you're still here!";
};


func int DIA_Rumbold_StillThere_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Rumbold_Hallo) && (Rumbold_Bezahlt == TRUE) && (Miliz_Flucht == FALSE) && (MIS_Torlof_BengarMilizKlatschen == LOG_Running) && (Kapitel < 3))
	{
		if(ScaredRumbold == FALSE)
		{
			return TRUE;
		};
	};
};

func void DIA_Rumbold_StillThere_Info()
{
	AI_Output (other, self, "DIA_Rumbold_StillThere_15_00");	//Hey, you're still here!
	AI_Output (self, other, "DIA_Rumbold_StillThere_10_01");	//I've about had it with you!
	Info_ClearChoices (DIA_Rumbold_StillThere);
	Info_AddChoice (DIA_Rumbold_StillThere, Dialog_Ende, DIA_Rumbold_StillThere_ENDAttack);
};

func void DIA_Rumbold_StillThere_ENDAttack()
{
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
	if(Hlp_IsValidNpc(Rick) && !C_NpcIsDown(Rick))
	{
		B_Attack(Rick,other,AR_KILL,1);
	};
};


instance DIA_Rumbold_PICKPOCKET(C_Info)
{
	npc = MIL_335_Rumbold;
	nr = 900;
	condition = DIA_Rumbold_PICKPOCKET_Condition;
	information = DIA_Rumbold_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Rumbold_PICKPOCKET_Condition()
{
	return C_Beklauen(24,45);
};

func void DIA_Rumbold_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Rumbold_PICKPOCKET);
	Info_AddChoice(DIA_Rumbold_PICKPOCKET,Dialog_Back,DIA_Rumbold_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Rumbold_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Rumbold_PICKPOCKET_DoIt);
};

func void DIA_Rumbold_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Rumbold_PICKPOCKET);
};

func void DIA_Rumbold_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Rumbold_PICKPOCKET);
};

