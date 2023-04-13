
instance DIA_Addon_Pardos_EXIT(C_Info)
{
	npc = STRF_1122_Addon_Pardos;
	nr = 999;
	condition = DIA_Addon_Pardos_EXIT_Condition;
	information = DIA_Addon_Pardos_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Pardos_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Pardos_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Pardos_Hi(C_Info)
{
	npc = STRF_1122_Addon_Pardos;
	nr = 2;
	condition = DIA_Addon_Pardos_Hi_Condition;
	information = DIA_Addon_Pardos_Hi_Info;
	permanent = FALSE;
	description = "Are you all right?";
};


func int DIA_Addon_Pardos_Hi_Condition()
{
	if(Sklaven_Flucht == FALSE)
	{
		return TRUE;
	};
};

func void DIA_Addon_Pardos_Hi_Info()
{
	DIA_Common_IsEverythingOk();
	AI_Output (self, other, "DIA_Addon_Pardos_Hi_03_01");	//(wearily) I'm beat... completely worn out. Is it a glorious sunny day, or one of those clear nights where a thousand stars are twinkling?
	AI_Output (self, other, "DIA_Addon_Pardos_Hi_03_02");	//(even more weary) I don't know... where's the gentle rain of summer... the cool evening breeze... I can feel them no longer...
	AI_Output (self, other, "DIA_Addon_Pardos_Hi_03_03");	//(resignedly) It's the eyes that go first in here...
};


instance DIA_Addon_Pardos_save(C_Info)
{
	npc = STRF_1122_Addon_Pardos;
	nr = 2;
	condition = DIA_Addon_Pardos_save_Condition;
	information = DIA_Addon_Pardos_save_Info;
	permanent = FALSE;
	description = "Hang in there. Your rescue is near.";
};


func int DIA_Addon_Pardos_save_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Addon_Pardos_Hi) && (Sklaven_Flucht == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Pardos_save_Info()
{
	AI_Output (other, self, "DIA_Addon_Pardos_save_15_00");	//Hang in there. Your rescue is near.
	AI_Output (self, other, "DIA_Addon_Pardos_save_03_01");	//(wearily) Thanks. Thank you for your words.
};


var int Pardos_Geheilt;

instance DIA_Addon_Pardos_trank(C_Info)
{
	npc = STRF_1122_Addon_Pardos;
	nr = 2;
	condition = DIA_Addon_Pardos_trank_Condition;
	information = DIA_Addon_Pardos_trank_Info;
	permanent = TRUE;
	description = "Here, drink this. (give potion)";
};


func int DIA_Addon_Pardos_trank_Condition()
{
	if((Pardos_Geheilt == FALSE) && Npc_KnowsInfo(other,DIA_Addon_Pardos_save))
	{
		return TRUE;
	};
};

func void DIA_Addon_Pardos_trank_Info()
{
	AI_Output(other,self,"DIA_Addon_Pardos_trank_15_00");	//Here, drink that.
	if(C_BodyStateContains(self,BS_SIT))
	{
		AI_Standup(self);
		B_TurnToNpc(self,hero);
	};
	Info_ClearChoices(DIA_Addon_Pardos_trank);
	Info_AddChoice(DIA_Addon_Pardos_trank,Dialog_Back,DIA_Addon_Pardos_trank_BACK);
	if(Npc_HasItems(other,ItFo_Addon_Meatsoup))
	{
		Info_AddChoice(DIA_Addon_Pardos_trank,"(give meat stew)",DIA_Addon_Pardos_trank_Soup);
	};
	if(Npc_HasItems(other,ItPo_Health_Addon_04))
	{
		Info_AddChoice(DIA_Addon_Pardos_trank,"(give pure healing)",DIA_Addon_Pardos_trank_04);
	};
	if(Npc_HasItems(other,ItPo_Health_03))
	{
		Info_AddChoice(DIA_Addon_Pardos_trank,"(give elixir of healing)",DIA_Addon_Pardos_trank_03);
	};
	if(Npc_HasItems(other,ItPo_Health_02))
	{
		Info_AddChoice(DIA_Addon_Pardos_trank,"(give extract of healing)",DIA_Addon_Pardos_trank_02);
	};
	if(Npc_HasItems(other,ItPo_Health_01))
	{
		Info_AddChoice(DIA_Addon_Pardos_trank,"(give essence of healing)",DIA_Addon_Pardos_trank_01);
	};
};

func void B_SayPardosThanks(var int bonus)
{
	Info_ClearChoices(DIA_Addon_Pardos_trank);
	Pardos_Geheilt = TRUE;
	if(bonus < 4)
	{
		AI_Output(self,other,"DIA_Addon_Pardos_trank_03_00");	//Thanks, that does me good.
	}
	else
	{
		AI_Output(self,other,"DIA_Addon_Pardos_trank_03_01");	//Thank you, I feel a little stronger now.
	};
	B_GivePlayerXP(XP_Ambient * bonus);
};

func void DIA_Addon_Pardos_trank_BACK()
{
	DIA_Common_IWillGiveYouSomethingLater();
	Info_ClearChoices(DIA_Addon_Pardos_trank);
};

func void DIA_Addon_Pardos_trank_01()
{
	B_GiveInvItems(other,self,ItPo_Health_01,1);
	B_UseItem(self,ItPo_Health_01);
	B_SayPardosThanks(1);
};

func void DIA_Addon_Pardos_trank_02()
{
	B_GiveInvItems(other,self,ItPo_Health_02,1);
	B_UseItem(self,ItPo_Health_02);
	B_SayPardosThanks(2);
};

func void DIA_Addon_Pardos_trank_03()
{
	B_GiveInvItems(other,self,ItPo_Health_03,1);
	B_UseItem(self,ItPo_Health_03);
	B_SayPardosThanks(3);
};

func void DIA_Addon_Pardos_trank_04()
{
	B_GiveInvItems(other,self,ItPo_Health_Addon_04,1);
	B_UseItem(self,ItPo_Health_Addon_04);
	B_SayPardosThanks(4);
};

func void DIA_Addon_Pardos_trank_Soup()
{
	AI_Output(other,self,"DIA_Addon_Pardos_trank_soup_15_00");	//Here, have some meat stew.
	AI_WaitTillEnd(self,other);
	B_GiveInvItems(other,self,ItFo_Addon_Meatsoup,1);
	B_UseItem(self,ItFo_Addon_Meatsoup);
	self.attribute[ATR_HITPOINTS] = self.attribute[ATR_HITPOINTS_MAX];
	B_SayPardosThanks(5);
};


instance DIA_Addon_Pardos_perm(C_Info)
{
	npc = STRF_1122_Addon_Pardos;
	nr = 99;
	condition = DIA_Addon_Pardos_perm_Condition;
	information = DIA_Addon_Pardos_perm_Info;
	permanent = TRUE;
	description = "How are you now?";
};


func int DIA_Addon_Pardos_perm_Condition()
{
	if(Pardos_Geheilt == TRUE)
	{
		return TRUE;
	};
	if(Npc_KnowsInfo(other,DIA_Addon_Pardos_Hi) && (Sklaven_Flucht == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Addon_Pardos_perm_Info()
{
	AI_Output (other, self, "DIA_Addon_Pardos_perm_15_00");	//How are you now?
	AI_Output (self, other, "DIA_Addon_Pardos_perm_03_01");	//Better, thanks to you. I can feel my strength returning.
};

