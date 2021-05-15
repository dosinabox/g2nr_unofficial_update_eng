
instance DIA_BDT_1020_Wegelagerer_EXIT(C_Info)
{
	npc = BDT_1020_Bandit_L;
	nr = 999;
	condition = DIA_Wegelagerer_EXIT_Condition;
	information = DIA_Wegelagerer_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Wegelagerer_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Wegelagerer_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

func void B_BuildWegelagererDialogOptions()
{
	Info_ClearChoices(DIA_BDT_1020_Wegelagerer_FirstWarn);
	if(Npc_HasItems(other,ItMi_Gold) >= 20)
	{
		Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"All right, here's your money.",DIA_BDT_1020_Wegelagerer_FirstWarn_GiveMoney);
	};
	Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"Sorry, I don't have any money.",DIA_BDT_1020_Wegelagerer_FirstWarn_NoMoney);
	Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"Just get out of my way.",DIA_BDT_1020_Wegelagerer_FirstWarn_Never);
	if((Wegelagerer_Surprise == FALSE) && (MIS_Schnitzeljagd == LOG_Running) && !Npc_KnowsInfo(other,DIA_Agon_GolemDead) && !Npc_KnowsInfo(other,DIA_Agon_GolemLives))
	{
		Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"Say, have you seen a novice?",DIA_BDT_1020_Wegelagerer_AGON);
	};
};

const string BDT_1020_Wegelagerer_Checkpoint = "NW_TROLLAREA_PATH_46";
var int Wegelagerer_Spared;
var int Wegelagerer_Hello_Once;

instance DIA_BDT_1020_Wegelagerer_FirstWarn(C_Info)
{
	npc = BDT_1020_Bandit_L;
	nr = 1;
	condition = DIA_BDT_1020_Wegelagerer_FirstWarn_Condition;
	information = DIA_BDT_1020_Wegelagerer_FirstWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_BDT_1020_Wegelagerer_FirstWarn_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_NONE) && (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_47") < 1000) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp))
	{
		return TRUE;
	};
};

func void DIA_BDT_1020_Wegelagerer_FirstWarn_Info()
{
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP(other,BDT_1020_Wegelagerer_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_FirstWarnGiven;
	if(Wegelagerer_Spared == TRUE)
	{
		AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_HowMuch_06_01");	//(grins) 20 gold pieces and we could be friends.
		B_BuildWegelagererDialogOptions();
	}
	else
	{
		if(Wegelagerer_Hello_Once == FALSE)
		{
			AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_06_00");	//Hey you, stop right there!
			AI_Output(other,self,"DIA_BDT_1020_Wegelagerer_FirstWarn_15_01");	//What do you want?
			Wegelagerer_Hello_Once = TRUE;
		};
		AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_06_02");	//If you don't want me to smash in your face, you had better transfer a few gold coins from your pockets to mine - and pronto!
		Info_ClearChoices(DIA_BDT_1020_Wegelagerer_FirstWarn);
		Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"How much do you want?",DIA_BDT_1020_Wegelagerer_FirstWarn_HowMuch);
		Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"You're joking.",DIA_BDT_1020_Wegelagerer_FirstWarn_Joke);
		Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"Get out of my way!",DIA_BDT_1020_Wegelagerer_PissOff);
		if((Wegelagerer_Surprise == FALSE) && (MIS_Schnitzeljagd == LOG_Running) && !Npc_KnowsInfo(other,DIA_Agon_GolemDead) && !Npc_KnowsInfo(other,DIA_Agon_GolemLives))
		{
			Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"Say, have you seen a novice?",DIA_BDT_1020_Wegelagerer_AGON);
		};
	};
};

func void DIA_BDT_1020_Wegelagerer_AGON()
{
	AI_Output (other, self, "DIA_BDT_1020_Wegelagerer_AGON_15_00");	//Say, have you seen a novice?
	AI_Output (self, other, "DIA_BDT_1020_Wegelagerer_AGON_06_01");	//(puzzled) er - what? Hmm... (thinking) That might well be.
	AI_Output (self, other, "DIA_BDT_1020_Wegelagerer_AGON_06_02");	//Give me 20 gold pieces, and I'll tell you!
	Wegelagerer_Surprise = TRUE;
	B_BuildWegelagererDialogOptions();
};

func void DIA_BDT_1020_Wegelagerer_FirstWarn_HowMuch()
{
	AI_Output(other,self,"DIA_BDT_1020_Wegelagerer_FirstWarn_HowMuch_15_00");	//How much do you want?
	AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_HowMuch_06_01");	//(grins) 20 gold pieces and we could be friends.
	B_BuildWegelagererDialogOptions();
};

func void DIA_BDT_1020_Wegelagerer_FirstWarn_Joke()
{
	AI_Output (other, self, "DIA_BDT_1020_Wegelagerer_FirstWarn_Joke_15_00");	//You're joking.
	AI_Output (self, other, "DIA_BDT_1020_Wegelagerer_FirstWarn_Joke_06_01");	//Do I look the part?
	AI_Output (self, other, "DIA_BDT_1020_Wegelagerer_FirstWarn_Joke_06_02");	//If I don't see 20 gold pieces before you come even one step closer ...
	AI_Output (self, other, "DIA_BDT_1020_Wegelagerer_FirstWarn_Joke_06_03");	//Then I'll flatten you. So fork over the dough already.
	self.aivar[AIV_Guardpassage_Status] = GP_SecondWarnGiven;
	B_BuildWegelagererDialogOptions();
};

func void DIA_BDT_1020_Wegelagerer_PissOff()
{
	AI_Output(other,self,"DIA_BDT_1020_Wegelagerer_PissOff_15_00");	//Get out of my way!
	AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_PissOff_06_01");	//My, you have a big mouth for such a scrawny little fellow.
	AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_PissOff_06_02");	//It's time I shut it for you.
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};

func void B_WegelagererToldAboutAgon()
{
	AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_GiveMoney_06_02");	//Okay, now, this novice came by here almost an hour ago.
	AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_GiveMoney_06_03");	//He was in a bit of a hurry, looking behind him all the time, he was. Now scram.
};

func void DIA_BDT_1020_Wegelagerer_FirstWarn_GiveMoney()
{
	AI_Output(other,self,"DIA_BDT_1020_Wegelagerer_FirstWarn_GiveMoney_15_00");	//All right, here's your money.
	B_GiveInvItems(other,self,ItMi_Gold,20);
	if(Wegelagerer_Surprise == FALSE)
	{
		AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_GiveMoney_06_01");	//(sneering) I should say 20 gold pieces wasn't too much to pay for your life. You can pass.
	}
	else
	{
		B_WegelagererToldAboutAgon();
	};
	self.aivar[AIV_PASSGATE] = TRUE;
	AI_StopProcessInfos(self);
};

func void DIA_BDT_1020_Wegelagerer_FirstWarn_NoMoney()
{
	AI_Output(other,self,"DIA_BDT_1020_Wegelagerer_FirstWarn_NoMoney_15_00");	//Sorry, I don't have any money.
	if(Wegelagerer_Spared == FALSE)
	{
		AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_NoMoney_06_01");	//Yeah, these are terrible times all right.
		if(Npc_HasEquippedMeleeWeapon(other) || Npc_HasReadiedWeapon(other))
		{
			AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_NoMoney_06_02");	//But I'll tell you what - just hand me your weapon. Then I'll let you pass.
			Info_ClearChoices(DIA_BDT_1020_Wegelagerer_FirstWarn);
			Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"Forget it.",DIA_BDT_1020_Wegelagerer_FirstWarn_NoWeapon);
			Info_AddChoice(DIA_BDT_1020_Wegelagerer_FirstWarn,"Here, take my weapon.",DIA_BDT_1020_Wegelagerer_FirstWarn_GiveWeapon);
		}
		else
		{
			AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_FirstWarn_NoMoney_06_03");	//I'll tell you what: come back when you have money. No money, no bridge.
			Wegelagerer_Spared = TRUE;
			self.aivar[AIV_Guardpassage_Status] = GP_FirstWarnGiven;
			AI_StopProcessInfos(self);
		};
	}
	else
	{
		B_Say(self,other,"$DIEENEMY");
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_NONE,1);
	};
};

func void DIA_BDT_1020_Wegelagerer_FirstWarn_Never()
{
	AI_Output (other, self, "DIA_BDT_1020_Wegelagerer_FirstWarn_Never_15_00");	//Just get out of my way.
	AI_Output (self, other, "DIA_BDT_1020_Wegelagerer_FirstWarn_Never_06_01");	//So you want it the hard way?
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

func void DIA_BDT_1020_Wegelagerer_FirstWarn_NoWeapon()
{
	AI_Output (other, self, "DIA_BDT_1020_Wegelagerer_FirstWarn_NoWeapon_15_00");	//Forget it.
	AI_Output (self, other, "DIA_BDT_1020_Wegelagerer_FirstWarn_NoWeapon_06_01");	//OK, the hard way it is.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};

var C_Item PlayerWeapon;

func void DIA_BDT_1020_Wegelagerer_FirstWarn_GiveWeapon()
{
	PlayerWeapon = Npc_GetEquippedMeleeWeapon(other);
	B_GiveInvItems(other,self,Hlp_GetInstanceID(PlayerWeapon),1);
	AI_Output(other,self,"DIA_BDT_1020_Wegelagerer_FirstWarn_GiveWeapon_15_00");	//Here, take my weapon.
	if(!Npc_HasReadiedWeapon(other))
	{
		AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_SecondWarn_GiveMoney_06_01");	/Ah, now you're talking.
		AI_EquipBestMeleeWeapon(self);
		self.aivar[AIV_PASSGATE] = TRUE;
		if(Wegelagerer_Surprise == TRUE)
		{
			AI_Output(other,self,"DIA_Jorgen_Novice_15_00");	//Have you seen a novice walk past?
			B_WegelagererToldAboutAgon();
		};
		AI_StopProcessInfos(self);
	}
	else
	{
		B_Say(self,other,"$WEAPONDOWN");
		AI_DrawWeapon(self);
		AI_Output(other,self,"DIA_Dar_ORCRING_necken_schlagen_15_00");	//Okay. Just try it.
		AI_StopProcessInfos(self);
		B_Attack(self,other,AR_GuardStopsIntruder,1);
	};
};


instance DIA_BDT_1020_Wegelagerer_SecondWarn(C_Info)
{
	npc = BDT_1020_Bandit_L;
	nr = 2;
	condition = DIA_BDT_1020_Wegelagerer_SecondWarn_Condition;
	information = DIA_BDT_1020_Wegelagerer_SecondWarn_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_BDT_1020_Wegelagerer_SecondWarn_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_FirstWarnGiven) && (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_47") < 1000) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,BDT_1020_Wegelagerer_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_BDT_1020_Wegelagerer_SecondWarn_Info()
{
	AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_SecondWarn_06_00");	//Ты действительно хочешь испытать судьбу? Как знаешь.
	Info_ClearChoices(DIA_BDT_1020_Wegelagerer_SecondWarn);
	if(Npc_HasItems(other,ItMi_Gold) >= 20)
	{
		Info_AddChoice (DIA_BDT_1020_Wegelagerer_SecondWarn, "Here's your money.", DIA_BDT_1020_Wegelagerer_SecondWarn_GiveMoney);
	};
	Info_AddChoice (DIA_BDT_1020_Wegelagerer_SecondWarn, "I won't give you a penny.", DIA_BDT_1020_Wegelagerer_SecondWarn_NoMoney);
	other.aivar[AIV_LastDistToWP] = Npc_GetDistToWP (other, BDT_1020_Wegelagerer_Checkpoint);
	self.aivar[AIV_Guardpassage_Status] = GP_SecondWarnGiven;
};

func void DIA_BDT_1020_Wegelagerer_SecondWarn_GiveMoney()
{
	AI_Output(other,self,"DIA_BDT_1020_Wegelagerer_SecondWarn_GiveMoney_15_00");	//Here's your money.
	B_GiveInvItems(other,self,ItMi_Gold,20);
	AI_Output(self,other,"DIA_BDT_1020_Wegelagerer_SecondWarn_GiveMoney_06_01");	//Ah, now you're talking.
	self.aivar[AIV_PASSGATE] = TRUE;
	if(Wegelagerer_Surprise == TRUE)
	{
		AI_Output(other,self,"DIA_Jorgen_Novice_15_00");	//Have you seen a novice walk past?
		B_WegelagererToldAboutAgon();
	};
	AI_StopProcessInfos(self);
};

func void DIA_BDT_1020_Wegelagerer_SecondWarn_NoMoney()
{
	AI_Output (other, self, "DIA_BDT_1020_Wegelagerer_SecondWarn_NoMoney_15_00");	//I won't give you a penny.
	AI_Output (self, other, "DIA_BDT_1020_Wegelagerer_SecondWarn_NoMoney_06_01");	//I'll get it for myself then.
	AI_StopProcessInfos (self);
	B_Attack (self, other, AR_NONE, 1);
};


instance DIA_BDT_1020_Wegelagerer_Attack(C_Info)
{
	npc = BDT_1020_Bandit_L;
	nr = 3;
	condition = DIA_BDT_1020_Wegelagerer_Attack_Condition;
	information = DIA_BDT_1020_Wegelagerer_Attack_Info;
	permanent = TRUE;
	important = TRUE;
};


func int DIA_BDT_1020_Wegelagerer_Attack_Condition()
{
	if((self.aivar[AIV_Guardpassage_Status] == GP_SecondWarnGiven) && (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_47") < 1000) && (self.aivar[AIV_PASSGATE] == FALSE) && Hlp_StrCmp(Npc_GetNearestWP(self),self.wp) && (Npc_GetDistToWP(other,BDT_1020_Wegelagerer_Checkpoint) < (other.aivar[AIV_LastDistToWP] - 50)))
	{
		return TRUE;
	};
};

func void DIA_BDT_1020_Wegelagerer_Attack_Info()
{
	other.aivar[AIV_LastDistToWP] = 0;
	self.aivar[AIV_Guardpassage_Status] = GP_NONE;
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_NONE,1);
};

instance BDT_1020_Bandit_L_GetLost(C_Info)
{
	npc = BDT_1020_Bandit_L;
	nr = 2;
	condition = BDT_1020_Bandit_L_GetLost_Condition;
	information = BDT_1020_Bandit_L_GetLost_Info;
	important = TRUE;
	permanent = TRUE;
};


func int BDT_1020_Bandit_L_GetLost_Condition()
{
//	if(Npc_IsInState(self,ZS_Talk) && (Npc_GetDistToWP(Lares,"NW_TROLLAREA_PATH_47") <= 3000))
	if(Npc_IsInState(self,ZS_Talk) && (Npc_GetDistToWP(self,"NW_TROLLAREA_PATH_47") >= 1000))
	{
		return TRUE;
	};
};

func void BDT_1020_Bandit_L_GetLost_Info()
{
	B_Say(self,other,"$GETOUTOFHERE");
	AI_StopProcessInfos(self);
};

instance DIA_BDT_1020_Wegelagerer_AGON2(C_Info)
{
	npc = BDT_1020_Bandit_L;
	nr = 900;
	condition = DIA_Wegelagerer_AGON2_Condition;
	information = DIA_Wegelagerer_AGON2_Info;
	permanent = FALSE;
	description = "Say, have you seen a novice?";
};


func int DIA_Wegelagerer_AGON2_Condition()
{
	if((Wegelagerer_Surprise == FALSE) && (MIS_Schnitzeljagd == LOG_Running) && !Npc_KnowsInfo(other,DIA_Agon_GolemDead) && !Npc_KnowsInfo(other,DIA_Agon_GolemLives))
	{
		return TRUE;
	};
};

func void DIA_Wegelagerer_AGON2_Info()
{
	AI_Output(other,self,"DIA_BDT_1020_Wegelagerer_AGON_15_00");	//Say, have you seen a novice?
	B_WegelagererToldAboutAgon();
	AI_StopProcessInfos(self);
};

