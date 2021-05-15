
instance DIA_Agon_EXIT(C_Info)
{
	npc = NOV_603_Agon;
	nr = 999;
	condition = DIA_Agon_EXIT_Condition;
	information = DIA_Agon_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Agon_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Agon_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Agon_Hello(C_Info)
{
	npc = NOV_603_Agon;
	nr = 2;
	condition = DIA_Agon_Hello_Condition;
	information = DIA_Agon_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Agon_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (MIS_Schnitzeljagd != LOG_Running) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Agon_Hello_Info()
{
	AI_Output (self, other, "DIA_Agon_Hello_07_00");	//(scornful) What do you want?
};


instance DIA_Agon_Wurst(C_Info)
{
	npc = NOV_603_Agon;
	nr = 2;
	condition = DIA_Agon_Wurst_Condition;
	information = DIA_Agon_Wurst_Info;
	permanent = FALSE;
	description = "Here, I've got a mutton sausage for you.";
};


func int DIA_Agon_Wurst_Condition()
{
	if(C_CanFeedNOV(self))
	{
		return TRUE;
	};
};

func void DIA_Agon_Wurst_Info()
{
	AI_Output (other, self, "DIA_Agon_Wurst_15_00");	//Here, I've got a mutton sausage for you.
	AI_Output (self, other, "DIA_Agon_Wurst_07_01");	//Sheep sausage, sheep cheese ... sheep milk ... it's getting so I can't stand the sight of it.
	AI_Output (other, self, "DIA_Agon_Wurst_15_02");	//So do you want the sausage, or not?
	AI_Output (self, other, "DIA_Agon_Wurst_07_03");	//Oh, give it here already!
	B_FeedNOV(self);
};


instance DIA_Agon_New(C_Info)
{
	npc = NOV_603_Agon;
	nr = 1;
	condition = DIA_Agon_New_Condition;
	information = DIA_Agon_New_Info;
	permanent = FALSE;
	description = "I'm new here.";
};


func int DIA_Agon_New_Condition()
{
	if((MIS_Schnitzeljagd == FALSE) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Agon_New_Info()
{
	AI_Output (other, self, "DIA_Agon_New_15_00");	//I'm new here.
	AI_Output (self, other, "DIA_Agon_New_07_01");	//So I see.
	AI_Output (self, other, "DIA_Agon_New_07_02");	//If you still don't have any work, talk to Parlan. He'll assign you some.
};


instance DIA_Agon_YouAndBabo(C_Info)
{
	npc = NOV_603_Agon;
	nr = 1;
	condition = DIA_Agon_YouAndBabo_Condition;
	information = DIA_Agon_YouAndBabo_Info;
	permanent = FALSE;
	description = "What happened between you and Babo?";
};


func int DIA_Agon_YouAndBabo_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Opolos_Monastery) && (MIS_Schnitzeljagd == FALSE) && (other.guild == GIL_NOV))
	{
		return TRUE;
	};
};

func void DIA_Agon_YouAndBabo_Info()
{
	AI_Output (other, self, "DIA_Agon_YouAndBabo_15_00");	//What happened between you and Babo?
	AI_Output (self, other, "DIA_Agon_YouAndBabo_07_01");	//You shouldn't believe everything you hear.
	AI_Output (self, other, "DIA_Agon_YouAndBabo_07_02");	//(insistently) Let's get something straight: I shall go my own way. The way that Innos foreordained for me.
	AI_Output (self, other, "DIA_Agon_YouAndBabo_07_03");	//I won't allow anyone to stand in my way, and certainly not that simpleton Babo.
	Info_ClearChoices (DIA_Agon_YouAndBabo);
	Info_AddChoice (DIA_Agon_YouAndBabo, "Shouldn't we novices stick together?", DIA_Agon_YouAndBabo_AllTogether);
	Info_AddChoice (DIA_Agon_YouAndBabo, "Innos alone knows which path we shall take.", DIA_Agon_YouAndBabo_InnosWay);
	Info_AddChoice (DIA_Agon_YouAndBabo, "We'll get along just fine.", DIA_Agon_YouAndBabo_Understand);
};

func void DIA_Agon_YouAndBabo_AllTogether()
{
	AI_Output (other, self, "DIA_Agon_YouAndBabo_AllTogether_15_00");	//Shouldn't we novices stick together?
	AI_Output (self, other, "DIA_Agon_YouAndBabo_AllTogether_07_01");	//The rest of you can stick together as much as you like.
	AI_Output (self, other, "DIA_Agon_YouAndBabo_AllTogether_07_02");	//But please, don't waste my time. (cold) And no one should get in my way.
	Info_ClearChoices (DIA_Agon_YouAndBabo);
};

func void DIA_Agon_YouAndBabo_InnosWay()
{
	AI_Output (other, self, "DIA_Agon_YouAndBabo_InnosWay_15_00");	//Innos alone knows which path we shall take.
	AI_Output (self, other, "DIA_Agon_YouAndBabo_InnosWay_07_01");	//My family has always stood highly in Innos' favor and nothing about that is going to change.
	Info_ClearChoices (DIA_Agon_YouAndBabo);
};

func void DIA_Agon_YouAndBabo_Understand()
{
	AI_Output (other, self, "DIA_Agon_YouAndBabo_Understand_15_00");	//We'll get along just fine.
	AI_Output (self, other, "DIA_Agon_YouAndBabo_Understand_07_01");	//I hope so. Once I'm a magician, I can put in a good word for you.
	Info_ClearChoices (DIA_Agon_YouAndBabo);
};


instance DIA_Agon_GetHerb(C_Info)
{
	npc = NOV_603_Agon;
	nr = 1;
	condition = DIA_Agon_GetHerb_Condition;
	information = DIA_Agon_GetHerb_Info;
	permanent = TRUE;
	description = "What are you planting here?";
};


func int DIA_Agon_GetHerb_Condition()
{
	if(MIS_Schnitzeljagd == FALSE)
	{
		if(Npc_GetDistToWP(self,"NW_MONASTERY_HERB_05") > 600)
		{
			DIA_Agon_GetHerb.description = "What are you planting here?";
		}
		else
		{
//			DIA_Agon_GetHerb.description = "Что ты выращиваешь здесь?";
		};
		return TRUE;
	};
};

func void DIA_Agon_GetHerb_Info()
{
	if(Npc_GetDistToWP(self,"NW_MONASTERY_HERB_05") > 600)
	{
		DIA_Common_WhatAreYouGuysDoingHere();
	}
	else
	{
		AI_Output(other,self,"DIA_Agon_GetHerb_15_00");	//What are you planting here?
	};
	AI_Output(self,other,"DIA_Agon_GetHerb_07_01");	//We're trying to grow healing plants that Master Neoras can use to brew potions.
};


instance DIA_Agon_GolemDead(C_Info)
{
	npc = NOV_603_Agon;
	nr = 1;
	condition = DIA_Agon_GolemDead_Condition;
	information = DIA_Agon_GolemDead_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Agon_GolemDead_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && Npc_IsDead(Magic_Golem))
	{
		return TRUE;
	};
};

func void DIA_Agon_GolemDead_Info()
{
	AI_Output (self, other, "DIA_Agon_GolemDead_07_00");	//(triumphant) You are too late!
	AI_Output (self, other, "DIA_Agon_GolemDead_07_01");	//I was here first! I have won!
	Info_ClearChoices (DIA_Agon_GolemDead);
	Info_AddChoice (DIA_Agon_GolemDead, "(menacing) Only if you get out of here alive.", DIA_Agon_GolemDead_NoWay);
	Info_AddChoice (DIA_Agon_GolemDead, "Shut up!", DIA_Agon_GolemDead_ShutUp);
	Info_AddChoice (DIA_Agon_GolemDead, "Congratulations, you have really deserved it.", DIA_Agon_GolemDead_Congrat);
};

func void DIA_Agon_GolemDead_NoWay()
{
	AI_Output (other, self, "DIA_Agon_GolemDead_NoWay_15_00");	//(menacing) Only if you get out of here alive.
	AI_Output (self, other, "DIA_Agon_GolemDead_NoWay_07_01");	//Do you want to kill me? You will never succeed.
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
};

func void DIA_Agon_GolemDead_ShutUp()
{
	AI_Output (other, self, "DIA_Agon_GolemDead_ShutUp_15_00");	//Shut up!
	AI_Output (self, other, "DIA_Agon_GolemDead_ShutUp_07_01");	//(mocking) It is hopeless, you have lost! Resign yourself to it.
	AI_Output (self, other, "DIA_Agon_GolemDead_ShutUp_07_02");	//Only I am destined to become a magician.
	Info_ClearChoices (DIA_Agon_GolemDead);
	Info_AddChoice (DIA_Agon_GolemDead, "Destined my ass. The chest is mine.", DIA_Agon_GolemDead_ShutUp_MyChest);
	Info_AddChoice (DIA_Agon_GolemDead, "You win.", DIA_Agon_GolemDead_ShutUp_YouWin);
};

func void DIA_Agon_GolemDead_ShutUp_MyChest()
{
	AI_Output (other, self, "DIA_Agon_GolemDead_ShutUp_MyChest_15_00");	//Destined my ass. The chest is mine.
	AI_Output (self, other, "DIA_Agon_GolemDead_ShutUp_MyChest_07_01");	//(furious) No, you cannot do that, I will kill you first.
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
};

func void DIA_Agon_GolemDead_ShutUp_YouWin()
{
	AI_Output (other, self, "DIA_Agon_GolemDead_ShutUp_YouWin_15_00");	//You win.
	AI_Output (self, other, "DIA_Agon_GolemDead_ShutUp_YouWin_07_01");	//(furious) No, you cannot deceive me. You're trying to get rid of me.
	AI_Output (self, other, "DIA_Agon_GolemDead_ShutUp_YouWin_07_02");	//I shall prevent that!
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
};

func void DIA_Agon_GolemDead_Congrat()
{
	AI_Output (other, self, "DIA_Agon_GolemDead_Congrat_15_00");	//Congratulations, you have really deserved it.
	AI_Output (self, other, "DIA_Agon_GolemDead_Congrat_07_01");	//(distrustful) What does that mean? What are you planning?
	AI_Output (other, self, "DIA_Agon_GolemDead_Congrat_15_02");	//What are you talking about?
	AI_Output (self, other, "DIA_Agon_GolemDead_Congrat_07_03");	//(nervous) You want to dispute my victory. You want to kill me and take all the glory for yourself!
	AI_Output (self, other, "DIA_Agon_GolemDead_Congrat_07_04");	//You will never succeed!
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,1);
};


instance DIA_Agon_GolemLives(C_Info)
{
	npc = NOV_603_Agon;
	nr = 1;
	condition = DIA_Agon_GolemLives_Condition;
	information = DIA_Agon_GolemLives_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Agon_GolemLives_Condition()
{
	if((MIS_Schnitzeljagd == LOG_Running) && !Npc_IsDead(Magic_Golem))
	{
		return TRUE;
	};
};

func void DIA_Agon_GolemLives_Info()
{
	AI_Output (self, other, "DIA_Agon_GolemLives_07_00");	//(surprised) You found the hiding place before me. That cannot be ...
	AI_Output (self, other, "DIA_Agon_GolemLives_07_01");	//(determined) That must not be! I shall not permit it.
	AI_Output (self, other, "DIA_Agon_GolemLives_07_02");	//They won't even find your corpse.
	AI_StopProcessInfos(self);
	B_Attack(self,other,AR_KILL,0);
};


instance DIA_Agon_Perm(C_Info)
{
	npc = NOV_603_Agon;
	nr = 2;
	condition = DIA_Agon_Perm_Condition;
	information = DIA_Agon_Perm_Info;
	permanent = TRUE;
	description = "So how are things?";
};


func int DIA_Agon_Perm_Condition()
{
	if((Kapitel >= 3) && (other.guild != GIL_KDF))
	{
		return TRUE;
	};
};

func void DIA_Agon_Perm_Info()
{
	AI_Output (other, self, "DIA_Agon_Perm_15_00");	//So how's it going?
	if (other.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Agon_Perm_07_01");	//Oh - thank you for your concern, Sir Paladin. I enjoy the work and I am certain to be selected as a magician soon.
	}
	else
	{
		AI_Output (self, other, "DIA_Agon_Perm_07_02");	//(arrogant) You are only a guest here in the monastery of Innos. Therefore you should act accordingly and not disturb me while I am working. Good day.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Agon_PICKPOCKET(C_Info)
{
	npc = NOV_603_Agon;
	nr = 900;
	condition = DIA_Agon_PICKPOCKET_Condition;
	information = DIA_Agon_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Agon_PICKPOCKET_Condition()
{
	return C_Beklauen(23,12);
};

func void DIA_Agon_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Agon_PICKPOCKET);
	Info_AddChoice(DIA_Agon_PICKPOCKET,Dialog_Back,DIA_Agon_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Agon_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Agon_PICKPOCKET_DoIt);
};

func void DIA_Agon_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Agon_PICKPOCKET);
};

func void DIA_Agon_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Agon_PICKPOCKET);
};

