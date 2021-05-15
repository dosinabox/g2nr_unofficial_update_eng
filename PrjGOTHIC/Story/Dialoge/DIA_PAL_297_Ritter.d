
instance DIA_PAL_297_EXIT(C_Info)
{
	npc = PAL_297_Ritter;
	nr = 999;
	condition = DIA_PAL_297_EXIT_Condition;
	information = DIA_PAL_297_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_PAL_297_EXIT_Condition()
{
	return TRUE;
};

func void DIA_PAL_297_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_PAL_297_FIRST(C_Info)
{
	npc = PAL_297_Ritter;
	nr = 1;
	condition = DIA_PAL_297_FIRST_Condition;
	information = DIA_PAL_297_FIRST_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_PAL_297_FIRST_Condition()
{
	if(MIS_OLDWORLD != LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_PAL_297_FIRST_Info()
{
	AI_Output(self,other,"DIA_PAL_297_TRESPAS_04_01");	//The area here is extremely dangerous, so you should turn back - we certainly don't want anything to happen to you.
	AI_StopProcessInfos(self);
};


instance DIA_PAL_297_TRESPAS(C_Info)
{
	npc = PAL_297_Ritter;
	nr = 2;
	condition = DIA_PAL_297_TRESPAS_Condition;
	information = DIA_PAL_297_TRESPAS_Info;
	permanent = TRUE;
	description = "How's it going?";
};


func int DIA_PAL_297_TRESPAS_Condition()
{
	return TRUE;
};

func void DIA_PAL_297_TRESPAS_Info()
{
	AI_Output (other, self, "DIA_PAL_297_TRESPAS_15_00");	//How's it going?
	if (Kapitel == 1)
	{
		if(Wld_IsRaining())
		{
			B_Say(self,other,"$WEATHER");
		}
		else
		{
			B_Say(self,other,"$WHYAREYOUINHERE");
		};
	}
	else
	{
		AI_Output (self, other, "DIA_PAL_297_TRESPAS_04_02");	//It is very courageous of you to enter the valley. Just as long as you have enough healing potions with you.
	};
};


instance DIA_Addon_PAL_297_Rangerbandits(C_Info)
{
	npc = PAL_297_Ritter;
	nr = 5;
	condition = DIA_Addon_PAL_297_Rangerbandits_Condition;
	information = DIA_Addon_PAL_297_Rangerbandits_Info;
	description = "Have any bandits passed by here lately?";
};


func int DIA_Addon_PAL_297_Rangerbandits_Condition()
{
	if(MIS_Vatras_FindTheBanditTrader == LOG_Running)
	{
		return TRUE;
	};
};

func void DIA_Addon_PAL_297_Rangerbandits_Info()
{
	AI_Output (other, self, "DIA_Addon_PAL_297_Rangerbandits_15_00");	//Have any bandits passed by here lately?
	AI_Output (self, other, "DIA_Addon_PAL_297_Rangerbandits_04_01");	//No idea what you're talking about. As long as we are on guard duty here, nobody passes. And certainly not any lousy bandits.
	AI_Output (self, other, "DIA_Addon_PAL_297_Rangerbandits_04_02");	//Ask those peasants back there. Maybe they've seen something.
};

