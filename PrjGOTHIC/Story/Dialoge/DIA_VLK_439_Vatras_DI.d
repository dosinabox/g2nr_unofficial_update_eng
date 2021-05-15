
instance DIA_Vatras_DI_EXIT(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 999;
	condition = DIA_Vatras_DI_EXIT_Condition;
	information = DIA_Vatras_DI_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Vatras_DI_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Vatras_DI_EXIT_Info()
{
	B_EquipTrader(self);
	AI_StopProcessInfos(self);
};


instance DIA_Vatras_DI_HEAL(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 10;
	condition = DIA_Vatras_DI_HEAL_Condition;
	information = DIA_Vatras_DI_HEAL_Info;
	permanent = TRUE;
	description = "Heal me.";
};


func int DIA_Vatras_DI_HEAL_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Vatras_DI_HEAL_Info()
{
	AI_Output (other, self, "DIA_Vatras_DI_HEAL_15_00");	//Heal me.
	if (hero.attribute[ATR_HITPOINTS] < hero.attribute[ATR_HITPOINTS_MAX])
	{
		AI_Output (self, other, "DIA_Vatras_DI_HEAL_05_01");	//(devout) Adanos bless this body. It is destined to restore the balance of the world.
		hero.attribute[ATR_HITPOINTS] = hero.attribute[ATR_HITPOINTS_MAX];
		PrintScreen(PRINT_FullyHealed,-1,-1,FONT_Screen,2);
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_DI_HEAL_05_02");	//Your body is undamaged at the moment.
	};
};


instance DIA_Vatras_DI_TRADE(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 11;
	condition = DIA_Vatras_DI_TRADE_Condition;
	information = DIA_Vatras_DI_TRADE_Info;
	permanent = TRUE;
	trade = TRUE;
	description = "Can you sell me something?";
};


func int DIA_Vatras_DI_TRADE_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Vatras_DI_TRADE_Info()
{
	AI_Output (other, self, "DIA_Vatras_DI_TRADE_15_00");	//Can you sell me something?
	B_GiveTradeInv (self);
	AI_Output (self, other, "DIA_Vatras_DI_TRADE_05_01");	//What do you need, then?
	Trade_IsActive = TRUE;
};


instance DIA_Vatras_DI_OBSESSION(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 12;
	condition = DIA_Vatras_DI_OBSESSION_Condition;
	information = DIA_Vatras_DI_OBSESSION_Info;
	permanent = TRUE;
	description = "Help me. I am possessed!";
};


func int DIA_Vatras_DI_OBSESSION_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (SC_IsObsessed == TRUE))
	{
		return TRUE;
	};
};


var int DIA_Vatras_DI_OBSESSION_Info_OneTime;

func void DIA_Vatras_DI_OBSESSION_Info()
{
	AI_Output (other, self, "DIA_Vatras_DI_OBSESSION_15_00");	//Help me. I am possessed!
	if (Got_HealObsession_Day <= (Wld_GetDay () - 2))
	{
		if(DIA_Vatras_DI_OBSESSION_Info_OneTime <= 1)
		{
			CreateInvItems(self,ItPo_HealObsession_MIS,1);
			DIA_Vatras_DI_OBSESSION_Info_OneTime += 1;
		};
		if(Npc_HasItems(self,ItPo_HealObsession_MIS))
		{
			AI_Output (self, other, "DIA_Vatras_DI_OBSESSION_05_01");	//Take this Potion of Deliverance. Pyrokar has given me some of the healing elixirs at my request.
			AI_Output (self, other, "DIA_Vatras_DI_OBSESSION_05_02");	//However, always remember: my means of ridding you of your nightmares are limited.
			B_GiveInvItems (self, other, ItPo_HealObsession_MIS, 1);
			Got_HealObsession_Day = Wld_GetDay ();
		}
		else
		{
			AI_Output (self, other, "DIA_Vatras_DI_OBSESSION_05_03");	//Pyrokar's supplies are exhausted. I am very sorry, my friend. I cannot help you any more.
		};
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_DI_OBSESSION_05_04");	//I shall not take the risk of giving you another phial after so short a time. Come back later, my friend.
	};
};


instance DIA_Vatras_DI_RAT(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 13;
	condition = DIA_Vatras_DI_RAT_Condition;
	information = DIA_Vatras_DI_RAT_Info;
	description = "What advice can you give me?";
};


func int DIA_Vatras_DI_RAT_Condition()
{
	if(!Npc_IsDead(UndeadDragon) && (SC_IsObsessed == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_DI_RAT_Info()
{
	AI_Output (other, self, "DIA_Vatras_DI_RAT_15_00");	//What advice can you give me?
	AI_Output (self, other, "DIA_Vatras_DI_RAT_05_01");	//Stay away from the Seekers. Remember that their black look can do you great damage here, far away from the monastery.
	if (Npc_HasItems (other, ItAm_Prot_BlackEye_Mis))
	{
		AI_Output (other, self, "DIA_Vatras_DI_RAT_15_02");	//Don't worry, I've got the soul summoning amulet.
	};
	AI_Output (self, other, "DIA_Vatras_DI_RAT_05_03");	//Should something happen to you nevertheless, come to me. I shall see what I can do.
};


var int DIA_Vatras_DI_PEDROTOT_VatrasSucked;

instance DIA_Vatras_DI_PEDROTOT(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 3;
	condition = DIA_Vatras_DI_PEDROTOT_Condition;
	information = DIA_Vatras_DI_PEDROTOT_Info;
	description = "I have found the traitor Pedro.";
};


func int DIA_Vatras_DI_PEDROTOT_Condition()
{
	if(Npc_KnowsInfo(other,DIA_Pedro_DI_YOU) || Npc_IsDead(Pedro_DI))
	{
		return TRUE;
	};
};

func void DIA_Vatras_DI_PEDROTOT_Info()
{
	AI_Output(other,self,"DIA_Vatras_DI_PEDROTOT_15_00");	//I have found the traitor Pedro.
	B_GivePlayerXP(XP_AmbientKap6);
	self.flags = 0;
	if((MIS_Gorax_KillPedro == LOG_SUCCESS) && Npc_IsDead(Pedro_DI))
	{
		AI_Output(other,self,"DIA_Vatras_DI_PEDROTOT_15_01");	//He's dead.
		AI_Output(self,other,"DIA_Vatras_DI_PEDROTOT_05_02");	//I am extremely disappointed. I had not thought it of you.
		DIA_Common_WhatDoYouMean();
		AI_Output(self,other,"DIA_Vatras_DI_PEDROTOT_05_04");	//I know about your repugnant agreement with Serpentes. I am deeply shaken that I should be proven wrong in the end after all.
		DIA_Vatras_DI_PEDROTOT_VatrasSucked = TRUE;
		AI_StopProcessInfos(self);
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_DI_PEDROTOT_05_05");	//Then bring him here to the ship. We shall hand him over to the legal authorities of Khorinis.
		if (Npc_IsDead (Pedro_DI))
		{
			AI_Output (other, self, "DIA_Vatras_DI_PEDROTOT_15_06");	//It's kind of too late for that. He's dead.
			AI_Output (self, other, "DIA_Vatras_DI_PEDROTOT_05_07");	//(surprised) Oh. That is very regrettable. I shall pray for his poor soul.
		}
		else
		{
			AI_StopProcessInfos(self);
		};
	};
};


instance DIA_Vatras_DI_VatrasSucked(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 1;
	condition = DIA_Vatras_DI_VatrasSucked_Condition;
	information = DIA_Vatras_DI_VatrasSucked_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Vatras_DI_VatrasSucked_Condition()
{
	if(Npc_IsInState(self,ZS_Talk) && (DIA_Vatras_DI_PEDROTOT_VatrasSucked == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Vatras_DI_VatrasSucked_Info()
{
	AI_Output (self, other, "DIA_Vatras_DI_VatrasSucked_05_00");	//Get out of my sight, you murderer. You can expect no help from me whatsoever.
	AI_StopProcessInfos (self);
};


instance DIA_Vatras_DI_Talente(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 14;
	condition = DIA_Vatras_DI_Talente_Condition;
	information = DIA_Vatras_DI_Talente_Info;
	permanent = TRUE;
	description = "Teach me your abilities.";
};


func int DIA_Vatras_DI_Talente_Condition()
{
	if(!Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};

func void DIA_Vatras_DI_Talente_Info()
{
	AI_Output (other, self, "DIA_Vatras_DI_Talente_15_00");	//Teach me your abilities.
	AI_Output (self, other, "DIA_Vatras_DI_Talente_05_01");	//I shall do what is in my power.
	Info_ClearChoices(DIA_Vatras_DI_Talente);
	Info_AddChoice(DIA_Vatras_DI_Talente,Dialog_Back,DIA_Vatras_DI_Talente_BACK);
	if((hero.guild == GIL_KDF) && (Npc_GetTalentSkill(other,NPC_TALENT_MAGE) < 6))
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,"Circles of Magic",DIA_Vatras_DI_Talente_CIRCLES);
	};
	Info_AddChoice(DIA_Vatras_DI_Talente,NAME_Skill_Alchemy,DIA_Vatras_DI_Talente_ALCHIMIE);
};

func void DIA_Vatras_DI_Talente_CIRCLES()
{
	Info_ClearChoices(DIA_Vatras_DI_Talente);
	Info_AddChoice(DIA_Vatras_DI_Talente,Dialog_Back,DIA_Vatras_DI_Talente_BACK);
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) < 1)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Circle_1,B_GetLearnCostTalent(other,NPC_TALENT_MAGE,1)),DIA_Vatras_DI_Talente_Circle_1);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 1)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Circle_2,B_GetLearnCostTalent(other,NPC_TALENT_MAGE,2)),DIA_Vatras_DI_Talente_Circle_2);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 2)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Circle_3,B_GetLearnCostTalent(other,NPC_TALENT_MAGE,3)),DIA_Vatras_DI_Talente_Circle_3);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 3)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Circle_4,B_GetLearnCostTalent(other,NPC_TALENT_MAGE,4)),DIA_Vatras_DI_Talente_Circle_4);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 4)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Circle_5,B_GetLearnCostTalent(other,NPC_TALENT_MAGE,5)),DIA_Vatras_DI_Talente_Circle_5);
	};
	if(Npc_GetTalentSkill(other,NPC_TALENT_MAGE) == 5)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Circle_6,B_GetLearnCostTalent(other,NPC_TALENT_MAGE,6)),DIA_Vatras_DI_Talente_Circle_6);
	};
};

func void DIA_Vatras_DI_Talente_ALCHIMIE()
{
	Info_ClearChoices(DIA_Vatras_DI_Talente);
	Info_AddChoice(DIA_Vatras_DI_Talente,Dialog_Back,DIA_Vatras_DI_Talente_BACK);
	if(PLAYER_TALENT_ALCHEMY[POTION_Health_01] == FALSE)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_HP_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_01)),DIA_Vatras_DI_Talente_POTION_Health_01);
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Health_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_01] == TRUE))
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_HP_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_02)),DIA_Vatras_DI_Talente_POTION_Health_02);
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Health_03] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_02] == TRUE))
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_HP_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Health_03)),DIA_Vatras_DI_Talente_POTION_Health_03);
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == FALSE)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Mana_Essenz,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_01)),DIA_Vatras_DI_Talente_POTION_Mana_01);
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_01] == TRUE))
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Mana_Extrakt,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_02)),DIA_Vatras_DI_Talente_POTION_Mana_02);
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_02] == TRUE))
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Mana_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Mana_03)),DIA_Vatras_DI_Talente_POTION_Mana_03);
	};
	if(PLAYER_TALENT_ALCHEMY[POTION_Speed] == FALSE)
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_Speed_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Speed)),DIA_Vatras_DI_Talente_POTION_Speed);
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Perm_STR] == FALSE) && C_ShowAlchemySTRDEXDialog())
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_STR_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_STR)),DIA_Vatras_DI_Talente_POTION_Perm_STR);
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Perm_DEX] == FALSE) && C_ShowAlchemySTRDEXDialog())
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_DEX_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_DEX)),DIA_Vatras_DI_Talente_POTION_Perm_DEX);
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Perm_Mana] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Mana_03] == TRUE))
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_ManaMax_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_Mana)),DIA_Vatras_DI_Talente_POTION_Perm_Mana);
	};
	if((PLAYER_TALENT_ALCHEMY[POTION_Perm_Health] == FALSE) && (PLAYER_TALENT_ALCHEMY[POTION_Health_03] == TRUE))
	{
		Info_AddChoice(DIA_Vatras_DI_Talente,B_BuildLearnString(NAME_HPMax_Elixier,B_GetLearnCostTalent(other,NPC_TALENT_ALCHEMY,POTION_Perm_Health)),DIA_Vatras_DI_Talente_POTION_Perm_Health);
	};
};

func void DIA_Vatras_DI_Talente_Circle_1()
{
	B_TeachMagicCircle(self,other,1);
	DIA_Vatras_DI_Talente_CIRCLES();
};

func void DIA_Vatras_DI_Talente_Circle_2()
{
	B_TeachMagicCircle(self,other,2);
	DIA_Vatras_DI_Talente_CIRCLES();
};

func void DIA_Vatras_DI_Talente_Circle_3()
{
	B_TeachMagicCircle(self,other,3);
	DIA_Vatras_DI_Talente_CIRCLES();
};

func void DIA_Vatras_DI_Talente_Circle_4()
{
	B_TeachMagicCircle(self,other,4);
	DIA_Vatras_DI_Talente_CIRCLES();
};

func void DIA_Vatras_DI_Talente_Circle_5()
{
	B_TeachMagicCircle(self,other,5);
	AI_Output(self,other,"DIA_Vatras_DI_Talente_Circle_5_05_00");	//You are now a magician of the fifth Circle. Use the magic spells you have learned prudently.
};

func void DIA_Vatras_DI_Talente_Circle_6()
{
	B_TeachMagicCircle(self,other,6);
	AI_Output (self, other, "DIA_Vatras_DI_Talente_Circle_6_05_00");	//You now have access to the highest knowledge of magic.
	AI_Output (self, other, "DIA_Vatras_DI_Talente_Circle_6_05_01");	//Be guided by reason and control your human weaknesses. They can cloud your sight.
	Info_ClearChoices(DIA_Vatras_DI_Talente);
};

func void DIA_Vatras_DI_Talente_POTION_Health_01()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_01);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Health_02()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_02);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Health_03()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Health_03);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Mana_01()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_01);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Mana_02()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_02);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Mana_03()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Mana_03);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Speed()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Speed);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Perm_STR()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_STR);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Perm_DEX()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_DEX);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Perm_Mana()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_Mana);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_POTION_Perm_Health()
{
	B_TeachPlayerTalentAlchemy(self,other,POTION_Perm_Health);
	DIA_Vatras_DI_Talente_ALCHIMIE();
};

func void DIA_Vatras_DI_Talente_BACK()
{
	Info_ClearChoices(DIA_Vatras_DI_Talente);
};


instance DIA_Vatras_DI_DementorObsessionBook(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 15;
	condition = DIA_Vatras_DI_DementorObsessionBook_Condition;
	information = DIA_Vatras_DI_DementorObsessionBook_Info;
	permanent = TRUE;
	description = "I've got an almanac of the Possessed here.";
};


func int DIA_Vatras_DI_DementorObsessionBook_Condition()
{
	if(Npc_HasItems(other,ITWR_DementorObsessionBook_MIS))
	{
		return TRUE;
	};
};


var int DIA_Vatras_DI_DementorObsessionBook_OneTime;
var int VatrasBookCount;

func void DIA_Vatras_DI_DementorObsessionBook_Info()
{
	VatrasBookCount = Npc_HasItems(other,ITWR_DementorObsessionBook_MIS);
	AI_Output(other,self,"DIA_Vatras_DI_DementorObsessionBook_15_00");	//I've got an Almanac of the Possessed here.
	if(DIA_Vatras_DI_DementorObsessionBook_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Vatras_DI_DementorObsessionBook_05_01");	//Hm. I think it would be best if I take it to Pyrokar in the monastery, if we get away from here again.
		DIA_Vatras_DI_DementorObsessionBook_OneTime = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Vatras_DI_DementorObsessionBook_05_02");	//Do you have more of them? Bring me all that you can find.
	};
	if(VatrasBookCount > 1)
	{
		AI_Output(other,self,"DIA_Pyrokar_AlmanachBringen_15_03");	//I've got even more books of the Seekers for you.
	};
	B_GiveInvItems(other,self,ITWR_DementorObsessionBook_MIS,VatrasBookCount);
	Npc_RemoveInvItems(self,ITWR_DementorObsessionBook_MIS,VatrasBookCount);
	B_GivePlayerXP(XP_AmbientKap6 * VatrasBookCount);
};


instance DIA_Vatras_DI_UndeadDragonDead(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 2;
	condition = DIA_Vatras_DI_UndeadDragonDead_Condition;
	information = DIA_Vatras_DI_UndeadDragonDead_Info;
	permanent = TRUE;
	description = "I did it.";
};


func int DIA_Vatras_DI_UndeadDragonDead_Condition()
{
	if(Npc_IsDead(UndeadDragon))
	{
		return TRUE;
	};
};


var int DIA_Vatras_DI_UndeadDragonDead_OneTime;

func void DIA_Vatras_DI_UndeadDragonDead_Info()
{
	AI_Output (other, self, "DIA_Vatras_DI_UndeadDragonDead_15_00");	//I did it.
	if (DIA_Vatras_DI_UndeadDragonDead_OneTime == FALSE)
	{
		AI_Output (self, other, "DIA_Vatras_DI_UndeadDragonDead_05_01");	//I know, I can feel it.
		AI_Output (self, other, "DIA_Vatras_DI_UndeadDragonDead_05_02");	//You have dealt a blow to Beliar which will keep him busy for some time.
		AI_Output(self,other,"DIA_Vatras_DI_UndeadDragonDead_05_04");	//But bear in mind that this was only an episode in the eternal battle between Good and Evil.
		if(hero.guild == GIL_DJG)
		{
			AI_Output(other,self,"DIA_Vatras_DI_UndeadDragonDead_15_03");	//Can I retire now, or do you magicians have another skeleton in the closet which needs to be driven from this world?
		};
		AI_Output(self,other,"DIA_Vatras_DI_UndeadDragonDead_05_05");	//Evil always finds a way to enter this world. The war will never end.
		if(hero.guild == GIL_PAL)
		{
			AI_Output(self,other,"DIA_Vatras_DI_UndeadDragonDead_05_06");	//As a warrior for the good cause you should know that.
		};
		AI_Output (self, other, "DIA_Vatras_Add_05_15");	//Only Adanos alone stands between the warring gods in order to preserve the balance!
		AI_Output (other, self, "DIA_Vatras_Add_15_16");	//He should have helped me instead.
		AI_Output (self, other, "DIA_Vatras_Add_05_17");	//(mischievously) But he did - of that you can be certain.
		DIA_Vatras_DI_UndeadDragonDead_OneTime = TRUE;
	};
	AI_Output (self, other, "DIA_Vatras_DI_UndeadDragonDead_05_09");	//Tell the captain that he should weigh anchor as soon as possible. The momentary peace may be deceptive.
};


instance DIA_Addon_Vatras_PISSOFFFOREVVER_DI(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 1;
	condition = DIA_Addon_Vatras_PISSOFFFOREVVER_DI_Condition;
	information = DIA_Addon_Vatras_PISSOFFFOREVVER_DI_Info;
	important = TRUE;
	permanent = TRUE;
};


func int DIA_Addon_Vatras_PISSOFFFOREVVER_DI_Condition()
{
	if(((VatrasPissedOffForever == TRUE) || ((MadKillerCount >= 7) && (VatrasMadKillerCount != MadKillerCount))) && Npc_IsInState(self,ZS_Talk))
	{
		return TRUE;
	};
};


var int DIA_Addon_Vatras_PISSOFFFOREVVER_DI_OneTime;

func void DIA_Addon_Vatras_PISSOFFFOREVVER_DI_Info()
{
	if(DIA_Addon_Vatras_PISSOFFFOREVVER_DI_OneTime == FALSE)
	{
		B_LastWarningVatras();
		DIA_Addon_Vatras_PISSOFFFOREVVER_DI_OneTime = TRUE;
	};
	B_VatrasPissedOff();
	AI_StopProcessInfos(self);
};


instance DIA_Addon_Vatras_DI_Stoneplate(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 16;
	condition = DIA_Addon_Vatras_DI_Stoneplate_Condition;
	information = DIA_Addon_Vatras_Stoneplate_Info;
	description = "I've got this stone tablet. Can you tell me more about it?";
};


func int DIA_Addon_Vatras_DI_Stoneplate_Condition()
{
	if(!Npc_KnowsInfo(other,DIA_Addon_Vatras_Stoneplate) && (C_ScHasMagicStonePlate() || Npc_HasItems(other,ItWr_StonePlateCommon_Addon)))
	{
		return TRUE;
	};
};

instance DIA_Addon_Vatras_DI_SellStonplate(C_Info)
{
	npc = VLK_439_Vatras_DI;
	nr = 16;
	condition = DIA_Addon_Vatras_SellStonplate_Condition;
	information = DIA_Addon_Vatras_SellStonplate_Info;
	permanent = TRUE;
	description = "I've got more stone tablets for you...";
};

