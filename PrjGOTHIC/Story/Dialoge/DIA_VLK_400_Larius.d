
instance DIA_Larius_EXIT(C_Info)
{
	npc = VLK_400_Larius;
	nr = 999;
	condition = DIA_Larius_EXIT_Condition;
	information = DIA_Larius_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Larius_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Larius_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Larius_Hello(C_Info)
{
	npc = VLK_400_Larius;
	nr = 1;
	condition = DIA_Larius_Hello_Condition;
	information = DIA_Larius_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Larius_Hello_Condition()
{
	if(Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};

func void DIA_Larius_Hello_Info()
{
	AI_Output(self,other,"DIA_Larius_Hello_01_00");	//What's your business here? If you want something, make an appointment.
	if(VisibleGuild(other) == GIL_PAL)
	{
		AI_Output(self,other,"DIA_Larius_Richterueberfall_01_02");	//Even if you are a warrior of Innos...
	}
	else if((VisibleGuild(other) == GIL_KDF) || (VisibleGuild(other) == GIL_KDW))
	{
		AI_Output(self,other,"DIA_Larius_Richterueberfall_01_03");	//Even if you are an ordained magician...
	};
};


instance DIA_Larius_WhoAreYou(C_Info)
{
	npc = VLK_400_Larius;
	nr = 1;
	condition = DIA_Larius_WhoAreYou_Condition;
	information = DIA_Larius_WhoAreYou_Info;
	permanent = FALSE;
	description = "Who are you?";
};


func int DIA_Larius_WhoAreYou_Condition()
{
	return TRUE;
};

func void DIA_Larius_WhoAreYou_Info()
{
	AI_Output (other, self, "DIA_Larius_WhoAreYou_15_00");	//Who are you?
	AI_Output (self, other, "DIA_Larius_WhoAreYou_01_01");	//I am Larius, the local governor.
	AI_Output (self, other, "DIA_Larius_WhoAreYou_01_02");	//Even if it may not seem so at the moment, I am the most powerful man in the city.
	AI_Output (other, self, "DIA_Larius_WhoAreYou_15_03");	//So you're in charge here?
	AI_Output (self, other, "DIA_Larius_WhoAreYou_01_04");	//I ... well ... at the moment my hands are tied.
	AI_Output (self, other, "DIA_Larius_WhoAreYou_01_05");	//That Lord Hagen is in command here, for as long as he is in the city at any rate.
	Player_KnowsLordHagen = TRUE;
	Player_KnowsLariusAsGovernor = TRUE;
};


instance DIA_Larius_Disturb(C_Info)
{
	npc = VLK_400_Larius;
	nr = 2;
	condition = DIA_Larius_Disturb_Condition;
	information = DIA_Larius_Disturb_Info;
	permanent = TRUE;
	description = "I didn't mean to intrude.";
};


func int DIA_Larius_Disturb_Condition()
{
	return TRUE;
};

func void DIA_Larius_Disturb_Info()
{
	AI_Output(other,self,"DIA_Larius_Disturb_15_00");	//I didn't mean to intrude.
	if(!Npc_KnowsInfo(other,DIA_Larius_Dragons_Proof))
	{
		AI_Output(self,other,"DIA_Larius_Disturb_01_01");	//You have failed utterly at that. So go away!
	}
	else
	{
		B_Say(self,other,"$ABS_GOOD");
	};
};


instance DIA_Larius_DieLage(C_Info)
{
	npc = VLK_400_Larius;
	nr = 3;
	condition = DIA_Larius_DieLage_Condition;
	information = DIA_Larius_DieLage_Info;
	permanent = TRUE;
	description = "What's up?";
};


func int DIA_Larius_DieLage_Condition()
{
	return TRUE;
};

func void DIA_Larius_DieLage_Info()
{
	AI_Output(other,self,"DIA_Larius_DieLage_15_00");	//How's it going?
	if(!Npc_KnowsInfo(other,DIA_Larius_Dragons_Proof))
	{
	AI_Output (self, other, "DIA_Larius_DieLage_01_01");	//What business is it of yours? As long as the paladins are in the city, Lord Hagen takes care of all the affairs that concern the city.
	}
	else
	{
		AI_Output(self,other,"DIA_Lothar_Add_01_47");	//You again.
	};
};


instance DIA_Larius_Richterueberfall(C_Info)
{
	npc = VLK_400_Larius;
	nr = 4;
	condition = DIA_Larius_Richterueberfall_Condition;
	information = DIA_Larius_Richterueberfall_Info;
	description = "The judge hired some thugs to assault you.";
};


func int DIA_Larius_Richterueberfall_Condition()
{
	if(SCKnowsRichterKomproBrief == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Larius_Richterueberfall_Info()
{
	AI_Output (other, self, "DIA_Larius_Richterueberfall_15_00");	//The judge hired some thugs to assault you. I can prove it.
	AI_Output (self, other, "DIA_Larius_Richterueberfall_01_01");	//Don't talk such nonsense, or do you want me to have you put in chains?
	AI_Output(self,other,"DIA_Larius_Richterueberfall_01_04");	//My word still has weight in this city. Do not dare to sully the honorable name of the judge ever again!
	if(Npc_KnowsInfo(other,DIA_Larius_Dragons_Proof))
	{
		AI_Output(other,self,"DIA_Sekob_Heilung_15_02");	//(to himself) A difficult case.
	};
	B_GivePlayerXP(XP_Ambient);
	AI_StopProcessInfos(self);
};


instance DIA_Larius_Dragons(C_Info)
{
	npc = VLK_400_Larius;
	nr = 1;
	condition = DIA_Larius_Dragons_Condition;
	information = DIA_Larius_Dragons_Info;
	description = "Listen - the city is threatened by dragons!";
};


func int DIA_Larius_Dragons_Condition()
{
	if((Player_KnowsLariusAsGovernor == TRUE) && (Kapitel < 5))
	{
		return TRUE;
	};
};

func void DIA_Larius_Dragons_Info()
{
	AI_Output(other,self,"DIA_Lothar_Dragons_15_00");	//Listen - the city is threatened by dragons!
	AI_Output(self,other,"DIA_Larius_Richterueberfall_01_01");	//Don't talk such nonsense, or do you want me to have you put in chains?
	B_Say(self,other,"$GETUPANDBEGONE");
	if(Npc_KnowsInfo(other,DIA_Lothar_Dragons))
	{
		Player_TalkedAboutDragonsToSomeone = TRUE;
	};
	AI_StopProcessInfos(self);
};


instance DIA_Larius_Dragons_Proof(C_Info)
{
	npc = VLK_400_Larius;
	nr = 1;
	condition = DIA_Larius_Dragons_Proof_Condition;
	information = DIA_Larius_Dragons_Proof_Info;
	description = "I have the proof! Here is the letter from Commander Garond!";
};


func int DIA_Larius_Dragons_Proof_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Larius_Dragons) && Npc_HasItems(other,ItWr_PaladinLetter_MIS))
	{
		return TRUE;
	};
};

func void DIA_Larius_Dragons_Proof_Info()
{
	DIA_Lothar_OWRunningBrief_Info();
	B_GivePlayerXP(100);
};


instance DIA_Larius_PICKPOCKET(C_Info)
{
	npc = VLK_400_Larius;
	nr = 900;
	condition = DIA_Larius_PICKPOCKET_Condition;
	information = DIA_Larius_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Larius_PICKPOCKET_Condition()
{
	return C_Beklauen(35,120);
};

func void DIA_Larius_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Larius_PICKPOCKET);
	Info_AddChoice(DIA_Larius_PICKPOCKET,Dialog_Back,DIA_Larius_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Larius_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Larius_PICKPOCKET_DoIt);
};

func void DIA_Larius_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Larius_PICKPOCKET);
};

func void DIA_Larius_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Larius_PICKPOCKET);
};

