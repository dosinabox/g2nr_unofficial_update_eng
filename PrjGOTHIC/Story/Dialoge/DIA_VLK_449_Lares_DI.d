
instance DIA_Lares_DI_EXIT(C_Info)
{
	npc = VLK_449_Lares_DI;
	nr = 999;
	condition = DIA_Lares_DI_EXIT_Condition;
	information = DIA_Lares_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Lares_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Lares_DI_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Lares_DI_Hallo(C_Info)
{
	npc = VLK_449_Lares_DI;
	nr = 2;
	condition = DIA_Lares_DI_Hallo_Condition;
	information = DIA_Lares_DI_Hallo_Info;
	permanent = TRUE;
	description = "What's up?";
};


func int DIA_Lares_DI_Hallo_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Lares_DI_Hallo_Info()
{
	AI_Output(other,self,"DIA_Lares_DI_Hallo_15_00");	//How's it going?
	if(OrkSturmDI == TRUE)
	{
		AI_Output (self, other, "DIA_Lares_DI_Hallo_09_01");	//Hurry up. The orcs will certainly come back.
	}
	else
	{
		AI_Output (self, other, "DIA_Lares_DI_Hallo_09_02");	//Well. This grotto sure is spooky.
	};
};


var int DIA_Lares_DI_Teacher_permanent;
var int Lares_DI_TeachComment;

func void B_BuildLearnDialog_Lares_DI()
{
	Info_ClearChoices(DIA_Lares_DI_Training);
	Info_AddChoice(DIA_Lares_DI_Training,Dialog_Back,DIA_Lares_DI_Training_BACK);
	if(!Npc_GetTalentSkill(other,NPC_TALENT_SNEAK))
	{
		Info_AddChoice(DIA_Lares_DI_Training,B_BuildLearnString(NAME_Skill_Sneak,B_GetLearnCostTalent(other,NPC_TALENT_SNEAK,1)),DIA_Lares_DI_Training_SNEAK);
	};
	if(other.attribute[ATR_DEXTERITY] < T_MED)
	{
		Info_AddChoice(DIA_Lares_DI_Training,B_BuildLearnString(PRINT_LearnDEX1,B_GetLearnCostAttribute(other,ATR_DEXTERITY)),DIA_Lares_DI_Training_DEX_1);
		Info_AddChoice(DIA_Lares_DI_Training,B_BuildLearnString(PRINT_LearnDEX5,B_GetLearnCostAttribute(other,ATR_DEXTERITY) * 5),DIA_Lares_DI_Training_DEX_5);
	};
	if(VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Lares)
	{
		Info_AddChoice(DIA_Lares_DI_Training,B_BuildLearnString(PRINT_Learn1h1,B_GetLearnCostTalent(other,NPC_TALENT_1H,1)),DIA_Lares_DI_Training_1H_1);
		Info_AddChoice(DIA_Lares_DI_Training,B_BuildLearnString(PRINT_Learn1h5,B_GetLearnCostTalent(other,NPC_TALENT_1H,5)),DIA_Lares_DI_Training_1H_5);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_SNEAK) && (other.attribute[ATR_DEXTERITY] >= T_MED) && (VisibleTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Lares))
	{
		if((RealTalentValue(NPC_TALENT_1H) >= TeachLimit_1H_Lares) && (other.aivar[REAL_DEXTERITY] >= T_MED))
		{
			DIA_Lares_DI_Teacher_permanent = TRUE;
		};
		PrintScreen(PRINT_NoLearnTotalMAXReached,-1,53,FONT_Screen,2);
		B_Say(self,other,"$NOLEARNYOUREBETTER");
		AI_StopProcessInfos(self);
	};
};

func void B_Lares_DI_TeachComment()
{
	if(Lares_DI_TeachComment == 0)
	{
		AI_Output(self,other,"DIA_Lares_DI_Training_1H_1_09_00");	//You have to bend your front leg a bit and keep the back one straight - then you have a firmer stance.
		Lares_DI_TeachComment = 1;
	}
	else if(Lares_DI_TeachComment == 1)
	{
		AI_Output(self,other,"DIA_Lares_DI_Training_1H_5_09_00");	//Keep your hips flexible, that'll help you dodge a counterattack.
		Lares_DI_TeachComment = 2;
	}
	else if(Lares_DI_TeachComment == 2)
	{
		AI_Output(self,other,"DIA_Lares_DI_Training_DEX_1_09_00");	//The upper half of your body has to act in harmony with the rest.
		Lares_DI_TeachComment = 3;
	}
	else if(Lares_DI_TeachComment == 3)
	{
		AI_Output(self,other,"DIA_Lares_DI_Training_DEX_5_09_00");	//You always have to watch your footing.
		Lares_DI_TeachComment = 0;
	};
};

instance DIA_Lares_DI_Training(C_Info)
{
	npc = VLK_449_Lares_DI;
	nr = 10;
	condition = DIA_Lares_DI_Training_Condition;
	information = DIA_Lares_DI_Training_Info;
	permanent = TRUE;
	description = "Teach me your abilities.";
};


func int DIA_Lares_DI_Training_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (DIA_Lares_DI_Teacher_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Lares_DI_Training_Info()
{
	AI_Output(other,self,"DIA_Lares_DI_Training_15_00");	//Teach me your abilities.
	if(!Npc_GetTalentSkill(other,NPC_TALENT_SNEAK) && (VisibleTalentValue(NPC_TALENT_1H) < TeachLimit_1H_Lares))
	{
		AI_Output(self,other,"DIA_Lares_DI_Training_09_01");	//No problem.
	}
	else if(other.attribute[ATR_DEXTERITY] < T_MED)
	{
		AI_Output(self,other,"DIA_Lares_Dex_09_01");	//Sure. If you want, I'll help you become more dexterous.
	};
	B_BuildLearnDialog_Lares_DI();
};

func void DIA_Lares_DI_Training_1H_1()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,1,TeachLimit_1H_Lares))
	{
		B_Lares_DI_TeachComment();
		B_BuildLearnDialog_Lares_DI();
	};
};

func void DIA_Lares_DI_Training_1H_5()
{
	if(B_TeachFightTalentPercent(self,other,NPC_TALENT_1H,5,TeachLimit_1H_Lares))
	{
		B_Lares_DI_TeachComment();
		B_BuildLearnDialog_Lares_DI();
	};
};

func void DIA_Lares_DI_Training_DEX_1()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,1,T_MED))
	{
		B_Lares_DI_TeachComment();
		B_BuildLearnDialog_Lares_DI();
	};
};

func void DIA_Lares_DI_Training_DEX_5()
{
	if(B_TeachAttributePoints(self,other,ATR_DEXTERITY,5,T_MED))
	{
		B_Lares_DI_TeachComment();
		B_BuildLearnDialog_Lares_DI();
	};
};

func void DIA_Lares_DI_Training_SNEAK()
{
	if(B_TeachThiefTalent(self,other,NPC_TALENT_SNEAK))
	{
		AI_Output (self, other, "DIA_Lares_DI_Training_SNEAK_09_00");	//Always use the entire sole of your foot when sneaking.
	};
};

func void DIA_Lares_DI_Training_BACK()
{
	Info_ClearChoices(DIA_Lares_DI_Training);
};

var int DIA_Lares_DI_UndeadDragonDead_OneTime;

instance DIA_Lares_DI_UndeadDragonDead(C_Info)
{
	npc = VLK_449_Lares_DI;
	nr = 5;
	condition = DIA_Lares_DI_UndeadDragonDead_Condition;
	information = DIA_Lares_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "You don't really seem to care about all this.";
};


func int DIA_Lares_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Lares_DI_UndeadDragonDead_Info()
{
	AI_Output (other, self, "DIA_Lares_DI_UndeadDragonDead_15_00");	//You don't really seem to care about all this.
	AI_Output (self, other, "DIA_Lares_DI_UndeadDragonDead_09_01");	//Ah, you know, I thought you'd make it.
	if (DIA_Lares_DI_UndeadDragonDead_OneTime == FALSE)
	{
		AI_Output (other, self, "DIA_Lares_DI_UndeadDragonDead_15_02");	//What are you going to do now?
		AI_Output (self, other, "DIA_Lares_DI_UndeadDragonDead_09_03");	//No idea. I guess I'll follow you for now.
		DIA_Lares_DI_UndeadDragonDead_OneTime = TRUE;
	};
	AI_StopProcessInfos(self);
};

instance DIA_Addon_Lares_DI_RingBack(C_Info)
{
	npc = VLK_449_Lares_DI;
	nr = 6;
	condition = DIA_Addon_Lares_RingBack2_Condition;
	information = DIA_Addon_Lares_RingBack2_Info;
	description = "Here's your ring.";
};

