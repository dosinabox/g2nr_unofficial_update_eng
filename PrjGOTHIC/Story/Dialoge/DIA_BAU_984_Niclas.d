
instance DIA_Niclas_EXIT(C_Info)
{
	npc = BAU_984_Niclas;
	nr = 999;
	condition = DIA_Niclas_EXIT_Condition;
	information = DIA_Niclas_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Niclas_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Niclas_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Niclas_Hello(C_Info)
{
	npc = BAU_984_Niclas;
	nr = 1;
	condition = DIA_Niclas_Hello_Condition;
	information = DIA_Niclas_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Niclas_Hello_Condition()
{
	return TRUE;
};

func void DIA_Niclas_Hello_Info()
{
	AI_Output (self, other, "DIA_Niclas_Hello_03_00");	//Did you run away, too?
	AI_Output (other, self, "DIA_Niclas_Hello_15_01");	//What makes you think that?
	AI_Output (self, other, "DIA_Niclas_Hello_03_02");	//Why would you come here all alone? There's NOTHING here.
};


instance DIA_Niclas_HaveALook(C_Info)
{
	npc = BAU_984_Niclas;
	nr = 1;
	condition = DIA_Niclas_HaveALook_Condition;
	information = DIA_Niclas_HaveALook_Info;
	permanent = FALSE;
	description = "I only wanted to have a look around.";
};


func int DIA_Niclas_HaveALook_Condition()
{
	return TRUE;
};

func void DIA_Niclas_HaveALook_Info()
{
	AI_Output (other, self, "DIA_Niclas_HaveALook_15_00");	//I only wanted to have a look around.
	AI_Output (self, other, "DIA_Niclas_HaveALook_03_01");	//Okay, be my guest. Would you like a piece of meat?
//	CreateInvItems(self,ItFoMutton,1);
	CreateInvItems(self,ItFo_NiclasBacon,1);
	Info_ClearChoices(DIA_Niclas_HaveALook);
	Info_AddChoice (DIA_Niclas_HaveALook, "No, thank you.", DIA_Niclas_HaveALook_No);
	Info_AddChoice (DIA_Niclas_HaveALook, "Yes, gladly.", DIA_Niclas_HaveALook_Yes);
};

func void DIA_Niclas_HaveALook_No()
{
	AI_Output (other, self, "DIA_Niclas_HaveALook_No_15_00");	//No, thank you.
	AI_Output (self, other, "DIA_Niclas_HaveALook_No_03_01");	//Suit yourself. I hope it doesn't bother you if I eat.
//	B_UseItem(self,ItFoMutton);
	B_UseItem(self,ItFo_NiclasBacon);
	Info_ClearChoices(DIA_Niclas_HaveALook);
};

func void DIA_Niclas_HaveALook_Yes()
{
	AI_Output (other, self, "DIA_Niclas_HaveALook_Yes_15_00");	//Yes, gladly.
	AI_Output (self, other, "DIA_Niclas_HaveALook_Yes_03_01");	//Here, the finest leg of molerat. According to my own recipe.
//	B_GiveInvItems(self,other,ItFoMutton,1);
	B_GiveInvItems(self,other,ItFo_NiclasBacon,1);
	Info_ClearChoices(DIA_Niclas_HaveALook);
};


instance DIA_Niclas_WhyHere(C_Info)
{
	npc = BAU_984_Niclas;
	nr = 2;
	condition = DIA_Niclas_WhyHere_Condition;
	information = DIA_Niclas_WhyHere_Info;
	permanent = FALSE;
	description = "So why are you here?";
};


func int DIA_Niclas_WhyHere_Condition()
{
	return TRUE;
};

func void DIA_Niclas_WhyHere_Info()
{
	AI_Output (other, self, "DIA_Niclas_WhyHere_15_00");	//So why are you here?
	AI_Output (self, other, "DIA_Niclas_WhyHere_03_01");	//I can get a bit of peace up here. I always feel so restricted in the city.
};


instance DIA_Niclas_ShouldntWork(C_Info)
{
	npc = BAU_984_Niclas;
	nr = 2;
	condition = DIA_Niclas_ShouldntWork_Condition;
	information = DIA_Niclas_ShouldntWork_Info;
	permanent = FALSE;
	description = "Don't you have to work?";
};


func int DIA_Niclas_ShouldntWork_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Niclas_WhyHere))
	{
		return TRUE;
	};
};

func void DIA_Niclas_ShouldntWork_Info()
{
	AI_Output (other, self, "DIA_Niclas_ShouldntWork_15_00");	//Don't you have to work?
	AI_Output (self, other, "DIA_Niclas_ShouldntWork_03_01");	//Everything I need, I can get for myself. I cut the arrows, and nature provides the meat.
	AI_Output (other, self, "DIA_Niclas_ShouldntWork_15_02");	//So you're a hunter.
	AI_Output (self, other, "DIA_Niclas_ShouldntWork_03_03");	//Yes, if you want to call it that. But I only hunt what I need for myself, not to earn money.
};


instance DIA_Niclas_CanTeachMe(C_Info)
{
	npc = BAU_984_Niclas;
	nr = 2;
	condition = DIA_Niclas_CanTeachMe_Condition;
	information = DIA_Niclas_CanTeachMe_Info;
	permanent = FALSE;
	description = "In that case, I'm sure you can teach me something.";
};


func int DIA_Niclas_CanTeachMe_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Niclas_ShouldntWork))
	{
		return TRUE;
	};
};

func void DIA_Niclas_CanTeachMe_Info()
{
	AI_Output (other, self, "DIA_Niclas_CanTeachMe_15_00");	//In that case, I'm sure you can teach me something.
	AI_Output (self, other, "DIA_Niclas_CanTeachMe_03_01");	//Why not. I could show you how to handle a bow.
	Log_CreateTopic(TOPIC_OutTeacher,LOG_NOTE);
	B_LogEntry(TOPIC_OutTeacher,"Niclas can show me how to improve my skill with the bow.");
};


var int DIA_Niclas_Teacher_permanent;
var int DIA_Niclas_TeachState_Bow;

func void B_BuildLearnDialog_Niclas()
{
	if(VisibleTalentValue(NPC_TALENT_BOW) < TeachLimit_Bow_Niclas)
	{
		Info_ClearChoices(DIA_Niclas_Teach);
		Info_AddChoice(DIA_Niclas_Teach,Dialog_Back,DIA_Niclas_Teach_Back);
		Info_AddChoice(DIA_Niclas_Teach,B_BuildLearnString(PRINT_LearnBow1,B_GetLearnCostTalent(other,NPC_TALENT_BOW,1)),DIA_Niclas_Teach_BOW_1);
		Info_AddChoice(DIA_Niclas_Teach,B_BuildLearnString(PRINT_LearnBow5,B_GetLearnCostTalent(other,NPC_TALENT_BOW,5)),DIA_Niclas_Teach_BOW_5);
	}
	else
	{
		if(RealTalentValue(NPC_TALENT_BOW) >= TeachLimit_Bow_Niclas)
		{
			DIA_Niclas_Teacher_permanent = TRUE;
		};
		PrintScreen(ConcatStrings(PRINT_NoLearnMAXReached,IntToString(TeachLimit_Bow_Niclas)),-1,53,FONT_Screen,2);
		if(DIA_Niclas_TeachState_Bow == FALSE)
		{
			AI_Output(self,other,"DIA_Niclas_Teach_03_00");	//I can't teach you any more tricks.
		}
		else
		{
			AI_Output(self,other,"DIA_Niclas_Teach_03_01");	//I've taught you everything I can. You'll have to find another teacher.
		};
		AI_StopProcessInfos(self);
	};
};

instance DIA_Niclas_Teach(C_Info)
{
	npc = BAU_984_Niclas;
	nr = 2;
	condition = DIA_Niclas_Teach_Condition;
	information = DIA_Niclas_Teach_Info;
	permanent = TRUE;
	description = "Show me how to handle a bow.";
};


func int DIA_Niclas_Teach_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Niclas_CanTeachMe) && (DIA_Niclas_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Niclas_Teach_Info()
{
	AI_Output(other,self,"DIA_Niclas_Teach_15_00");	//Show me how to handle a bow.
	B_BuildLearnDialog_Niclas();
};

func void DIA_Niclas_Teach_Back()
{
	Info_ClearChoices(DIA_Niclas_Teach);
};

func void DIA_Niclas_Teach_BOW_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,1,TeachLimit_Bow_Niclas))
	{
		DIA_Niclas_TeachState_Bow = TRUE;
		B_BuildLearnDialog_Niclas();
	};
};

func void DIA_Niclas_Teach_BOW_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_BOW,5,TeachLimit_Bow_Niclas))
	{
		DIA_Niclas_TeachState_Bow = TRUE;
		B_BuildLearnDialog_Niclas();
	};
};

instance DIA_Niclas_PICKPOCKET(C_Info)
{
	npc = BAU_984_Niclas;
	nr = 900;
	condition = DIA_Niclas_PICKPOCKET_Condition;
	information = DIA_Niclas_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Niclas_PICKPOCKET_Condition()
{
	return C_Beklauen(27,20);
};

func void DIA_Niclas_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Niclas_PICKPOCKET);
	Info_AddChoice(DIA_Niclas_PICKPOCKET,Dialog_Back,DIA_Niclas_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Niclas_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Niclas_PICKPOCKET_DoIt);
};

func void DIA_Niclas_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Niclas_PICKPOCKET);
};

func void DIA_Niclas_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Niclas_PICKPOCKET);
};

