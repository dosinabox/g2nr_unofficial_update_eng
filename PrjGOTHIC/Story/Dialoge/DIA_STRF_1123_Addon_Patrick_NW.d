
instance DIA_Addon_Patrick_NW_EXIT(C_Info)
{
	npc = STRF_1123_Addon_Patrick_NW;
	nr = 999;
	condition = DIA_Addon_Patrick_NW_EXIT_Condition;
	information = DIA_Addon_Patrick_NW_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Addon_Patrick_NW_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Addon_Patrick_NW_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Patrick_NW_PICKPOCKET(C_Info)
{
	npc = STRF_1123_Addon_Patrick_NW;
	nr = 900;
	condition = DIA_Addon_Patrick_NW_PICKPOCKET_Condition;
	information = DIA_Addon_Patrick_NW_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Addon_Patrick_NW_PICKPOCKET_Condition()
{
	return C_Beklauen(35,50);
};

func void DIA_Addon_Patrick_NW_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Addon_Patrick_NW_PICKPOCKET);
	Info_AddChoice(DIA_Addon_Patrick_NW_PICKPOCKET,Dialog_Back,DIA_Addon_Patrick_NW_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Addon_Patrick_NW_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Addon_Patrick_NW_PICKPOCKET_DoIt);
};

func void DIA_Addon_Patrick_NW_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Addon_Patrick_NW_PICKPOCKET);
};

func void DIA_Addon_Patrick_NW_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Addon_Patrick_NW_PICKPOCKET);
};


instance DIA_Addon_Patrick_NW_Hi(C_Info)
{
	npc = STRF_1123_Addon_Patrick_NW;
	nr = 2;
	condition = DIA_Addon_Patrick_NW_Hi_Condition;
	information = DIA_Addon_Patrick_NW_Hi_Info;
	permanent = FALSE;
	description = "So? Everything okay with you?";
};


func int DIA_Addon_Patrick_NW_Hi_Condition()
{
	return TRUE;
};

func void DIA_Addon_Patrick_NW_Hi_Info()
{
	AI_Output (other, self, "DIA_Addon_Patrick_NW_Hi_15_00");	//So? Everything okay with you?
	AI_Output (self, other, "DIA_Addon_Patrick_NW_Hi_07_01");	//All's fine. The Water Mages led us safely out of this accursed valley.
	AI_Output (other, self, "DIA_Addon_Patrick_NW_Hi_15_02");	//And what will you do next?
	AI_Output (self, other, "DIA_Addon_Patrick_NW_Hi_07_03");	//I'm going to continue to fight for Lee. And some day we're going to leave this island ...
	AI_Output (other, self, "DIA_Addon_Patrick_NW_Hi_15_04");	//And then?
	AI_Output (self, other, "DIA_Addon_Patrick_NW_Hi_07_05");	//We shall see. If the war is still raging, we'll go up against the orcs. But that remains to be seen.
};

