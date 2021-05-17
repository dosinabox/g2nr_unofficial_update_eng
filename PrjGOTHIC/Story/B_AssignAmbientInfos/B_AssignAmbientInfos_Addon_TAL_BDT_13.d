
instance DIA_Addon_TAL_BDT_13_EXIT(C_Info)
{
	nr = 999;
	condition = DIA_Addon_TAL_BDT_13_EXIT_Condition;
	information = DIA_Addon_TAL_BDT_13_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_TAL_BDT_13_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_TAL_BDT_13_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_TAL_BDT_13_Hi(C_Info)
{
	nr = 2;
	condition = DIA_Addon_TAL_BDT_13_Hi_Condition;
	information = DIA_Addon_TAL_BDT_13_Hi_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_Addon_TAL_BDT_13_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_TAL_BDT_13_Hi_Info()
{
	AI_Output(other,self,"DIA_Addon_TAL_BDT_13_Hi_15_00");	//How's it going?
	if(Wld_IsRaining())
	{
		B_Say(self,other,"$WEATHER");
	}
	else
	{
		AI_Output (self, other, "DIA_Addon_TAL_BDT_13_Hi_13_01");	//Either you'll get eaten by a beast or you'll get eaten by a beast.
		AI_Output (self, other, "DIA_Addon_TAL_BDT_13_Hi_13_02");	//This swamp will be our grave...
	};
};


instance DIA_Addon_TAL_BDT_13_Tal(C_Info)
{
	nr = 3;
	condition = DIA_Addon_TAL_BDT_13_Tal_Condition;
	information = DIA_Addon_TAL_BDT_13_Tal_Info;
	permanent = TRUE;
	description = "What do you know about this valley?";
};


func int DIA_Addon_TAL_BDT_13_Tal_Condition()
{
	return TRUE;
};

func void DIA_Addon_TAL_BDT_13_Tal_Info()
{
	AI_Output (other, self, "DIA_Addon_TAL_BDT_13_Tal_15_00");	//What do you know about this valley?
	AI_Output (self, other, "DIA_Addon_TAL_BDT_13_Tal_13_01");	//There's loads of old stuff here. Raven's ordered us to gather up everything.
	AI_Output (self, other, "DIA_Addon_TAL_BDT_13_Tal_13_02");	//No idea what he wants with it, but nobody in his right mind would risk his neck for a few old rocks...
};


instance DIA_Addon_TAL_BDT_13_News(C_Info)
{
	nr = 4;
	condition = DIA_Addon_TAL_BDT_13_News_Condition;
	information = DIA_Addon_TAL_BDT_13_News_Info;
	permanent = TRUE;
	description = "Is there anything new?";
};


func int DIA_Addon_TAL_BDT_13_News_Condition()
{
	return TRUE;
};

func void DIA_Addon_TAL_BDT_13_News_Info()
{
	AI_Output (other, self, "DIA_Addon_TAL_BDT_13_News_15_00");	//Is there anything new?
	AI_Output (self, other, "DIA_Addon_TAL_BDT_13_News_13_01");	//We really put one over on those pirates.
	AI_Output (self, other, "DIA_Addon_TAL_BDT_13_News_13_02");	//They provided us with prisoners, but never saw a coin for it. No wonder they're angry.
	if (BDT_13_einmal == FALSE)
	{
		AI_Output (self, other, "DIA_Addon_TAL_BDT_13_News_13_03");	//But what can they do? Attack the camp? (laughs) HAHAHA.
		BDT_13_einmal = TRUE;
	};
};

func void B_AssignAmbientInfos_Addon_TAL_BDT_13(var C_Npc slf)
{
	DIA_Addon_TAL_BDT_13_EXIT.npc = Hlp_GetInstanceID(slf);
	DIA_Addon_TAL_BDT_13_Hi.npc = Hlp_GetInstanceID(slf);
	DIA_Addon_TAL_BDT_13_Tal.npc = Hlp_GetInstanceID(slf);
	DIA_Addon_TAL_BDT_13_News.npc = Hlp_GetInstanceID(slf);
};

