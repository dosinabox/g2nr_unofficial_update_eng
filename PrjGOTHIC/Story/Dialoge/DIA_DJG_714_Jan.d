
instance DIA_Jan_EXIT(C_Info)
{
	npc = DJG_714_Jan;
	nr = 999;
	condition = DIA_Jan_EXIT_Condition;
	information = DIA_Jan_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Jan_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Jan_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_JAN_Hello(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_Hello_Condition;
	information = DIA_Jan_Hello_Info;
	permanent = FALSE;
	important = TRUE;
};


func int DIA_Jan_Hello_Condition()
{
	if((Kapitel >= 4) && Npc_IsInState(self,ZS_Talk) && (MIS_OCGateOpen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_Hello_Info()
{
	AI_Output (self, other, "DIA_Jan_Hello_10_00");	//It was a really, really stupid idea to come here.
	AI_Output (self, other, "DIA_Jan_Hello_10_01");	//I thought there was something to be had here. But there's nothing here but a few arrogant paladins and orcs.
};


instance DIA_JAN_Dragons(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_Dragons_Condition;
	information = DIA_Jan_Dragons_Info;
	permanent = FALSE;
	description = "You forgot about the dragons!";
};


func int DIA_Jan_Dragons_Condition()
{
	if(Npc_KnowsInfo(other,DIA_JAN_Hello) && (MIS_JanBecomesSmith == FALSE) && (Kapitel == 4) && (MIS_OCGateOpen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_Dragons_Info()
{
	AI_Output (other, self, "DIA_Jan_Dragons_15_00");	//You forgot about the dragons!
	AI_Output (self, other, "DIA_Jan_Dragons_10_01");	//(mockingly) How could I forget. I'll tell you what. I'm a blacksmith, not a warrior.
	AI_Output (self, other, "DIA_Jan_Dragons_10_02");	//I make weapons. The fighting I leave to others.
	AI_Output (other, self, "DIA_Jan_Dragons_15_03");	//Then why aren't you standing behind an anvil?
	AI_Output (self, other, "DIA_Jan_Dragons_10_04");	//The paladins here won't let me into the smithy. I can't make anything unless I want to wind up in the dungeon.
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Jan_Dragons_10_05");	//You're one of them, too. So how about putting in a good word for me?
	};
	Info_ClearChoices(DIA_JAN_Dragons);
	Info_AddChoice(DIA_JAN_Dragons,Dialog_Ende_v2,DIA_JAN_Dragons_ShitHappen);
	Info_AddChoice(DIA_JAN_Dragons,"What's in it for me if I help you?",DIA_JAN_Dragons_Reward);
	Info_AddChoice(DIA_JAN_Dragons,"I'll try to help you.",DIA_JAN_Dragons_HelpYou);
};

func void DIA_JAN_Dragons_HelpYou()
{
	AI_Output (other, self, "DIA_JAN_Dragons_HelpYou_15_00");	//I'll try to help you.
	AI_Output (self, other, "DIA_JAN_Dragons_HelpYou_10_01");	//How will you manage that? Parcival has ordered a watch kept on us.
	AI_Output (self, other, "DIA_JAN_Dragons_HelpYou_10_02");	//No one would dare to disregard it.
	AI_Output (other, self, "DIA_JAN_Dragons_HelpYou_15_03");	//I'll do whatever I can.
	AI_Output (self, other, "DIA_JAN_Dragons_HelpYou_10_04");	//I can't imagine that he would listen to you.
	Log_CreateTopic (TOPIC_JanBecomesSmith, LOG_MISSION);
	Log_SetTopicStatus (TOPIC_JanBecomesSmith, LOG_Running);
	B_LogEntry (TOPIC_JanBecomesSmith, "Jan, the Dragon Hunter in the castle in the Valley of Mines, wants to work at the smithy. But Parcival forbids it.");
	MIS_JanBecomesSmith = LOG_Running;
	Info_ClearChoices(DIA_JAN_Dragons);
};

func void DIA_JAN_Dragons_Reward()
{
	AI_Output (other, self, "DIA_JAN_Dragons_Reward_15_00");	//What's in it for me if I help you?
	AI_Output (self, other, "DIA_JAN_Dragons_Reward_10_01");	//I don't have anything. At the most, I could teach you something.
	if ((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		AI_Output (self, other, "DIA_JAN_Dragons_Reward_10_02");	//I know a method of making blades forged from magic ore even harder.
	};
	Jan_TeachPlayer = TRUE;
};

func void DIA_JAN_Dragons_ShitHappen()
{
	AI_Output (other, self, "DIA_JAN_Dragons_ShitHappen_15_00");	//I've got to be on my way.
	AI_Output (self, other, "DIA_JAN_Dragons_ShitHappen_10_01");	//Terrific. I can't leave the castle now, and I can't forge anything either.
	Info_ClearChoices (DIA_JAN_Dragons);
};


instance DIA_JAN_Home(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_Home_Condition;
	information = DIA_Jan_Home_Info;
	permanent = FALSE;
	description = "Where do you come from?";
};


func int DIA_Jan_Home_Condition()
{
	if(Npc_KnowsInfo(other,DIA_JAN_Hello) && (Kapitel >= 4) && (MIS_OCGateOpen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_Home_Info()
{
	AI_Output (other, self, "DIA_Jan_Home_15_00");	//Where do you come from?
	AI_Output (self, other, "DIA_Jan_Home_10_01");	//I've joined up with some men from the mountains. We were headed for the valley to make a real profit hunting dragons.
	AI_Output (self, other, "DIA_Jan_Home_10_02");	//Their leader went by the name of Sylvio. Boy, what an ass. He treated me like I was his property.
};


instance DIA_JAN_OldCamp(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_OldCamp_Condition;
	information = DIA_Jan_OldCamp_Info;
	permanent = TRUE;
	description = "What happened in the castle?";
};


func int DIA_Jan_OldCamp_Condition()
{
	if(Npc_KnowsInfo(other,DIA_JAN_Hello) && (Kapitel == 4) && (MIS_OCGateOpen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_OldCamp_Info()
{
	AI_Output (other, self, "DIA_Jan_OldCamp_15_00");	//What all happened in the castle?
	AI_Output (self, other, "DIA_Jan_OldCamp_10_01");	//Nothing that I've heard. Of course, I'm worried about what's happened OUTSIDE the castle.
};


instance DIA_JAN_Parcival(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_Parcival_Condition;
	information = DIA_Jan_Parcival_Info;
	permanent = FALSE;
	description = "I talked to Parcival.";
};


func int DIA_Jan_Parcival_Condition()
{
	if((MIS_JanBecomesSmith != LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_Parcival_Jan) && (MIS_OCGateOpen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_Parcival_Info()
{
	AI_Output (other, self, "DIA_Jan_Parcival_15_00");	//I talked to Parcival.
	AI_Output (self, other, "DIA_Jan_Parcival_10_01");	//So?
	if (hero.guild == GIL_DJG)
	{
		AI_Output (other, self, "DIA_Jan_Parcival_15_02");	//He doesn't trust us dragon hunters.
	}
	else
	{
		AI_Output (other, self, "DIA_Jan_Parcival_15_03");	//He doesn't trust you dragon hunters.
	};
	AI_Output (self, other, "DIA_Jan_Parcival_10_04");	//Damn. I just want to work.
	AI_Output (self, other, "DIA_Jan_Parcival_10_05");	//Then I might as well give up. Only Garond could help me now.
};


instance DIA_JAN_JanIsSmith(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_JanIsSmith_Condition;
	information = DIA_Jan_JanIsSmith_Info;
	permanent = FALSE;
	description = "Go get your hammer, there's work for you.";
};


func int DIA_Jan_JanIsSmith_Condition()
{
	if((MIS_JanBecomesSmith == LOG_SUCCESS) && (MIS_OCGateOpen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_JanIsSmith_Info()
{
	AI_Output (other, self, "DIA_Jan_JanIsSmith_15_00");	//Go get your hammer, there's work for you.
	AI_Output (self, other, "DIA_Jan_JanIsSmith_10_01");	//You did it? How did you manage that?
	AI_Output (other, self, "DIA_Jan_JanIsSmith_15_02");	//I had to vouch for you, so don't disappoint me.
	AI_Output (self, other, "DIA_Jan_JanIsSmith_10_03");	//Don't worry. I'm glad that I can work at all.
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"SMITH");
	B_StartOtherRoutine(Ferros,"TRAIN");
	B_StartOtherRoutine(Rethon,"START");
};


instance DIA_JAN_SellWeapons(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_SellWeapons_Condition;
	information = DIA_Jan_SellWeapons_Info;
	permanent = FALSE;
	description = "Are you selling any weapons?";
};


func int DIA_Jan_SellWeapons_Condition()
{
	if((MIS_JanBecomesSmith == LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_JAN_JanIsSmith) && (Jan_TeachPlayer == FALSE) && (MIS_OCGateOpen == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_SellWeapons_Info()
{
	AI_Output (other, self, "DIA_Jan_SellWeapons_15_00");	//Are you selling any weapons?
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Jan_SellWeapons_10_01");	//No way. And then your colleagues here will stick me in jail for black-marketing, huh? Nah, forget about it.
	}
	else
	{
		AI_Output (self, other, "DIA_Jan_SellWeapons_10_02");	//I would if I could. But first I have to provide the paladins here in the castle with weapons.
	};
	AI_Output (self, other, "DIA_Jan_SellWeapons_10_03");	//But I can show you how to forge your own weapon.
	Jan_TeachPlayer = TRUE;
};


instance Jan_Training_Talente(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = Jan_Training_Talente_Condition;
	information = Jan_Training_Talente_Info;
	permanent = TRUE;
	description = "Teach me how to be a smith.";
};


func int Jan_Training_Talente_Condition()
{
	if((Jan_TeachPlayer == TRUE) && Npc_KnowsInfo(other,DIA_JAN_JanIsSmith) && (MIS_OCGateOpen == FALSE))
	{
		return TRUE;
	};
};

func void Jan_Training_Talente_Info()
{
	AI_Output(other,self,"DIA_Jan_TeachPlayer_15_00");	//Teach me how to be a smith.
	if((hero.guild != GIL_SLD) && (hero.guild != GIL_DJG) && (PLAYER_TALENT_SMITH[WEAPON_Common] == TRUE))
	{
		B_Say(self,other,"$NOLEARNOVERPERSONALMAX");
	}
	else if((PLAYER_TALENT_SMITH[WEAPON_1H_Special_01] == TRUE) && (PLAYER_TALENT_SMITH[WEAPON_2H_Special_01] == TRUE) && (PLAYER_TALENT_SMITH[WEAPON_1H_Special_02] == TRUE) && (PLAYER_TALENT_SMITH[WEAPON_2H_Special_02] == TRUE))
	{
		B_Say(self,other,"$NOLEARNYOUREBETTER");
	}
	else
	{
		AI_Output(self,other,"DIA_Jan_TeachPlayer_10_01");	//What exactly do you plan to make?
		Info_ClearChoices(Jan_Training_Talente);
		Info_AddChoice(Jan_Training_Talente,Dialog_Back,Jan_Training_Smith_Back);
		if(PLAYER_TALENT_SMITH[WEAPON_Common] == FALSE)
		{
			Info_AddChoice(Jan_Training_Talente,B_BuildLearnString(NAME_Skill_Smith,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_Common)),Jan_Training_Smith_Common);
		}
		else if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
		{
			if(PLAYER_TALENT_SMITH[WEAPON_1H_Special_01] == FALSE)
			{
				Info_AddChoice(Jan_Training_Talente,B_BuildLearnString(NAME_ItMw_1H_Special_01,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_01)),Jan_Training_Smith_1hSpecial1);
			};
			if(PLAYER_TALENT_SMITH[WEAPON_2H_Special_01] == FALSE)
			{
				Info_AddChoice(Jan_Training_Talente,B_BuildLearnString(NAME_ItMw_2H_Special_01,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_01)),Jan_Training_Smith_2hSpecial1);
			};
			if(PLAYER_TALENT_SMITH[WEAPON_1H_Special_02] == FALSE)
			{
				Info_AddChoice(Jan_Training_Talente,B_BuildLearnString(NAME_ItMw_1H_Special_02,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_1H_Special_02)),Jan_Training_Smith_1hSpecial2);
			};
			if(PLAYER_TALENT_SMITH[WEAPON_2H_Special_02] == FALSE)
			{
				Info_AddChoice(Jan_Training_Talente,B_BuildLearnString(NAME_ItMw_2H_Special_02,B_GetLearnCostTalent(other,NPC_TALENT_SMITH,WEAPON_2H_Special_02)),Jan_Training_Smith_2hSpecial2);
			};
		};
	};
};

func void Jan_Training_Smith_Back()
{
	Info_ClearChoices(Jan_Training_Talente);
};

func void Jan_Training_Smith_Common()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_Common);
};

func void Jan_Training_Smith_1hSpecial1()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Special_01);
};

func void Jan_Training_Smith_2hSpecial1()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_2H_Special_01);
};

func void Jan_Training_Smith_1hSpecial2()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_1H_Special_02);
};

func void Jan_Training_Smith_2hSpecial2()
{
	B_TeachPlayerTalentSmith(self,other,WEAPON_2H_Special_02);
};


var int DIA_JAN_SellArmor_permanent;

instance DIA_JAN_SellArmor(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_SellArmor_Condition;
	information = DIA_Jan_SellArmor_Info;
	permanent = TRUE;
	description = "Can I buy some armor from you?";
};


func int DIA_Jan_SellArmor_Condition()
{
	if((MIS_JanBecomesSmith == LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_JAN_JanIsSmith) && (MIS_OCGateOpen == FALSE) && (DIA_JAN_SellArmor_permanent == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_SellArmor_Info()
{
	AI_Output (other, self, "DIA_Jan_SellArmor_15_00");	//Can I buy some armor from you?
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Jan_SellArmor_10_01");	//Nothing that would be better than your armor. We should forget it.
	}
	else if(hero.guild == GIL_KDF)
	{
		AI_Output (self, other, "DIA_Jan_SellArmor_10_02");	//A mage who wants armor? Forget it - go see a tailor. I can't make armor for you.
	}
	else
	{
		AI_Output (self, other, "DIA_Jan_SellArmor_10_03");	//If I had any, I'd sell it to you. Unfortunately, I don't have any.
		Info_ClearChoices (DIA_JAN_SellArmor);
		Info_AddChoice (DIA_JAN_SellArmor, "I guess there's nothing to be done.", DIA_JAN_SellArmor_Sorry);
		Info_AddChoice (DIA_JAN_SellArmor, "Can you make one for me, then?", DIA_JAN_SellArmor_BuildOne);
	};
};

func void DIA_JAN_SellArmor_Sorry()
{
	AI_Output (other, self, "DIA_JAN_SellArmor_Sorry_15_00");	//I guess there's nothing to be done.
	AI_Output (self, other, "DIA_JAN_SellArmor_Sorry_10_01");	//Once you've got something after all, just let me know.
	Info_ClearChoices (DIA_JAN_SellArmor);
};

func void DIA_JAN_SellArmor_BuildOne()
{
	AI_Output (other, self, "DIA_JAN_SellArmor_BuildOne_15_00");	//Can you make one for me, then?
	AI_Output (self, other, "DIA_JAN_SellArmor_BuildOne_10_01");	//Well, if you want something better, you'll have to get me the materials.
	AI_Output (other, self, "DIA_JAN_SellArmor_BuildOne_15_02");	//What is it you need?
	AI_Output (self, other, "DIA_JAN_SellArmor_BuildOne_10_03");	//You want to fight the dragons, don't you? Bring me some dragon scales - with those, I should be able to cobble something together for you.
	AI_Output (self, other, "DIA_JAN_SellArmor_BuildOne_10_04");	//20 scales should be enough.
	DIA_JAN_SellArmor_permanent = TRUE;
	Info_ClearChoices(DIA_JAN_SellArmor);
};


var int Jan_Sells_Armor;

instance DIA_JAN_Dragonscales(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_Dragonscales_Condition;
	information = DIA_Jan_Dragonscales_Info;
	permanent = TRUE;
	description = "I've got the dragon scales for you.";
};


func int DIA_Jan_Dragonscales_Condition()
{
	if((MIS_JanBecomesSmith == LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_JAN_JanIsSmith) && (MIS_OCGateOpen == FALSE) && (DIA_JAN_SellArmor_permanent == TRUE) && (Jan_Sells_Armor == FALSE) && Npc_HasItems(other,ItAt_DragonScale))
	{
		return TRUE;
	};
};


var int DIA_JAN_Dragonscales_OneTime;

func void DIA_Jan_Dragonscales_Info()
{
	AI_Output (other, self, "DIA_JAN_Dragonscales_15_00");	//I've got the dragon scales for you.
	if (Npc_HasItems (other, ItAt_DragonScale) >= 20)
	{
		B_GiveInvItems(other,self,ItAt_DragonScale,20);
		Npc_RemoveInvItems(self,ItAt_DragonScale,20);
		AI_Output (self, other, "DIA_JAN_Dragonscales_10_01");	//Good, something can be done with that.
		AI_Output (self, other, "DIA_JAN_Dragonscales_10_02");	//Come back tomorrow, the part should be finished then.
		if(DIA_JAN_Dragonscales_OneTime == FALSE)
		{
			B_GivePlayerXP(XP_Addon_JanSellsArmor);
			DIA_JAN_Dragonscales_OneTime = TRUE;
		};
		Jan_Sells_Armor = Wld_GetDay();
	}
	else
	{
		AI_Output (self, other, "DIA_JAN_Dragonscales_10_03");	//I need 20 dragon scales, otherwise I can't make you any armor.
	};
};


var int DJG_Armor_is_offered;
var int DIA_JAN_ArmorReady_NoPerm;

instance DIA_JAN_ArmorReady(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_ArmorReady_Condition;
	information = DIA_Jan_ArmorReady_Info;
	permanent = TRUE;
	description = "Is the armor ready?";
};


func int DIA_Jan_ArmorReady_Condition()
{
	if((MIS_OCGateOpen == FALSE) && (Jan_Sells_Armor != FALSE) && (DIA_JAN_ArmorReady_NoPerm == FALSE))
	{
		return TRUE;
	};
};

func void DIA_Jan_ArmorReady_Info()
{
	AI_Output (other, self, "DIA_JAN_ArmorReady_15_00");	//Is the armor ready?
	if (Jan_Sells_Armor == Wld_GetDay ())
	{
		AI_Output (self, other, "DIA_JAN_ArmorReady_10_01");	//No, not yet. Come back tomorrow.
	}
	else
	{
		AI_Output (self, other, "DIA_JAN_ArmorReady_10_02");	//Yes, a real masterpiece. You can buy it if you want.
		AI_Output (self, other, "DIA_JAN_ArmorReady_10_03");	//I'll give you a special price. 12,000 gold pieces.
		AI_Output (other, self, "DIA_JAN_ArmorReady_15_04");	//What? After all I've done for you?
		AI_Output (self, other, "DIA_JAN_ArmorReady_10_05");	//Don't be like that. I've got to make a living here. Take it or leave it.
		DJG_Armor_is_offered = TRUE;
		DIA_JAN_ArmorReady_NoPerm = TRUE;
	};
};


var int Jan_DIA_Jan_DJG_ARMOR_M_permanent;

instance DIA_Jan_DJG_ARMOR_M(C_Info)
{
	npc = DJG_714_Jan;
	nr = 4;
	condition = DIA_Jan_DJG_ARMOR_M_Condition;
	information = DIA_Jan_DJG_ARMOR_M_Info;
	permanent = TRUE;
	description = "Medium Dragon Hunter Armor (120/120/75/35, 12000 gold)";
};


func int DIA_Jan_DJG_ARMOR_M_Condition()
{
	if((Jan_DIA_Jan_DJG_ARMOR_M_permanent == FALSE) && (hero.guild == GIL_DJG) && (DJG_Armor_is_offered == TRUE))
	{
		return TRUE;
	};
};

func void DIA_Jan_DJG_ARMOR_M_Info()
{
	AI_Output(other,self,"DIA_Jan_DJG_ARMOR_M_15_00");	//I want to buy the armor.
	if(Npc_HasItems(other,ItMi_Gold) >= VALUE_ITAR_DJG_M)
	{
		AI_Output(self,other,"DIA_Jan_DJG_ARMOR_M_10_01");	//You can see that it's worth every gold piece.
		B_GiveInvItems(other,self,ItMi_Gold,VALUE_ITAR_DJG_M);
		Npc_RemoveInvItems(self,ItMi_Gold,VALUE_ITAR_DJG_M);
		if(Helmets_Enabled == TRUE)
		{
			B_GiveArmor(ITAR_DJGN_M);
			CreateInvItem(hero,ITHE_DJG_M);
		}
		else
		{
			B_GiveArmor(ITAR_DJG_M);
		};
		Jan_DIA_Jan_DJG_ARMOR_M_permanent = TRUE;
	}
	else
	{
		AI_Output (self, other, "DIA_Jan_DJG_ARMOR_M_10_02");	//You don't have enough gold.
	};
};


instance DIA_Jan_DragonPlettBericht(C_Info)
{
	npc = DJG_714_Jan;
	nr = 3;
	condition = DIA_Jan_DragonPlettBericht_Condition;
	information = DIA_Jan_DragonPlettBericht_Info;
	description = "About the dragons...";
};


func int DIA_Jan_DragonPlettBericht_Condition()
{
	if((Kapitel >= 4) && (MIS_OCGateOpen == FALSE) && (MIS_KilledDragons > 0))
	{
		if(MIS_KilledDragons == 1)
		{
			DIA_Jan_DragonPlettBericht.description = "I've killed a dragon.";
		}
		else if((MIS_KilledDragons == 2) || (MIS_KilledDragons == 3))
		{
			DIA_Jan_DragonPlettBericht.description = "I've killed a few dragons.";
		}
		else
		{
			DIA_Jan_DragonPlettBericht.description = "I've killed all the dragons.";
		};
		return TRUE;
	};
};

func void DIA_Jan_DragonPlettBericht_Info()
{
	if(MIS_KilledDragons == 1)
	{
		AI_Output (other, self, "DIA_Jan_DragonPlettBericht_15_00");	//I've killed a dragon.
	}
	else if((MIS_KilledDragons == 2) || (MIS_KilledDragons == 3))
	{
		AI_Output (other, self, "DIA_Jan_DragonPlettBericht_15_01");	//I've killed a few dragons.
	}
	else
	{
		AI_Output (other, self, "DIA_Jan_DragonPlettBericht_15_02");	//I've killed all the dragons.
	};
	if(hero.guild == GIL_DJG)
	{
		AI_Output (self, other, "DIA_Jan_DragonPlettBericht_10_03");	//So what? You are a dragon hunter, aren't you?
		AI_Output (other, self, "DIA_Jan_DragonPlettBericht_15_04");	//Aren't you one, too?
	};
	AI_Output(self,other,"DIA_Jan_DragonPlettBericht_10_05");	//That's nice. But to be honest, I'm not particularly interested.
	if(Npc_KnowsInfo(other,DIA_JAN_Dragons))
	{
		AI_Output(self,other,"DIA_Jan_DragonPlettBericht_10_06");	//I already told you, I'd rather make weapons than set out myself to kill dragons.
	};
	if((hero.guild != GIL_DJG) && (hero.guild != GIL_SLD))
	{
		AI_Output (self, other, "DIA_Jan_DragonPlettBericht_10_07");	//There is one thing, however, that could interest me.
		AI_Output (self, other, "DIA_Jan_DragonPlettBericht_10_08");	//If you could get me some dragon blood, I would pay a high price for it.
		Jan_WantsDragonBlood = TRUE;
	};
};


instance DIA_Jan_DragonBlood(C_Info)
{
	npc = DJG_714_Jan;
	nr = 3;
	condition = DIA_Jan_DragonBlood_Condition;
	information = DIA_Jan_DragonBlood_Info;
	permanent = TRUE;
	description = "I've got some dragon blood for you.";
};


func int DIA_Jan_DragonBlood_Condition()
{
	if((Jan_WantsDragonBlood == TRUE) && (MIS_OCGateOpen == FALSE) && Npc_HasItems(other,ItAt_DragonBlood) && ((hero.guild != GIL_DJG) && (hero.guild != GIL_SLD)))
	{
		return TRUE;
	};
};

func void DIA_Jan_DragonBlood_Info()
{
	AI_Output (other, self, "DIA_Jan_DragonBlood_15_00");	//I've got some dragon blood for you.
	AI_Output (self, other, "DIA_Jan_DragonBlood_10_01");	//That's great. Sell me everything you have.
	Info_ClearChoices(DIA_Jan_DragonBlood);
	Info_AddChoice(DIA_Jan_DragonBlood,Dialog_Back,DIA_Jan_DragonBlood_BACK);
	if(Npc_HasItems(other,ItAt_DragonBlood))
	{
		if(Npc_HasItems(other,ItAt_DragonBlood) > 1)
		{
			Info_AddChoice(DIA_Jan_DragonBlood,DIALOG_GiveAllDragonBlood,DIA_Jan_DragonBlood_all);
		};
		Info_AddChoice(DIA_Jan_DragonBlood,DIALOG_GiveDragonBlood,DIA_Jan_DragonBlood_1);
	};
};

func void DIA_Jan_DragonBlood_BACK()
{
	Info_ClearChoices(DIA_Jan_DragonBlood);
};

func void DIA_Jan_DragonBlood_1()
{
	var int DragonBloodCount;
	var int DragonBloodGeld;
	var int XP_DJG_BringDragonBloods;
	var string BloodText;
	var string BloodLeft;
	DragonBloodCount = 1;
	B_GiveInvItems(other,self,ItAt_DragonBlood,DragonBloodCount);
	XP_DJG_BringDragonBloods = DragonBloodCount * 200;
	B_GivePlayerXP(XP_DJG_BringDragonBloods);
	DragonBloodGeld = DragonBloodCount * Value_DragonBlood;
	CreateInvItems(self,ItMi_Gold,DragonBloodGeld);
	B_GiveInvItems(self,other,ItMi_Gold,DragonBloodGeld);
	Npc_RemoveInvItem(self,ItAt_DragonBlood);
	Info_ClearChoices(DIA_Jan_DragonBlood);
	Info_AddChoice(DIA_Jan_DragonBlood,Dialog_Back,DIA_Jan_DragonBlood_BACK);
	if(Npc_HasItems(other,ItAt_DragonBlood))
	{
		if(Npc_HasItems(other,ItAt_DragonBlood) > 1)
		{
			Info_AddChoice(DIA_Jan_DragonBlood,DIALOG_GiveAllDragonBlood,DIA_Jan_DragonBlood_all);
		};
		Info_AddChoice(DIA_Jan_DragonBlood,DIALOG_GiveDragonBlood,DIA_Jan_DragonBlood_1);
		BloodLeft = IntToString(Npc_HasItems(other,ItAt_DragonBlood));
		BloodText = ConcatStrings(PRINT_BloodLeft,BloodLeft);
		AI_PrintScreen(BloodText,-1,-1,FONT_ScreenSmall,2);
	};
};

func void DIA_Jan_DragonBlood_all()
{
	var int DragonBloodCount;
	var int DragonBloodGeld;
	var int XP_DJG_BringDragonBloods;
//	var string BloodText;
//	var string BloodLeft;
	DragonBloodCount = Npc_HasItems(other,ItAt_DragonBlood);
	B_GiveInvItems(other,self,ItAt_DragonBlood,DragonBloodCount);
	XP_DJG_BringDragonBloods = DragonBloodCount * 200;
	B_GivePlayerXP(XP_DJG_BringDragonBloods);
	DragonBloodGeld = DragonBloodCount * Value_DragonBlood;
	CreateInvItems(self,ItMi_Gold,DragonBloodGeld);
	B_GiveInvItems(self,other,ItMi_Gold,DragonBloodGeld);
	Npc_RemoveInvItems(self,ItAt_DragonBlood,DragonBloodCount);
	Info_ClearChoices(DIA_Jan_DragonBlood);
	/*Info_AddChoice(DIA_Jan_DragonBlood,Dialog_Back,DIA_Jan_DragonBlood_BACK);
	if(Npc_HasItems(other,ItAt_DragonBlood))
	{
		if(Npc_HasItems(other,ItAt_DragonBlood) > 1)
		{
			Info_AddChoice(DIA_Jan_DragonBlood,DIALOG_GiveAllDragonBlood,DIA_Jan_DragonBlood_all);
		};
		Info_AddChoice(DIA_Jan_DragonBlood,DIALOG_GiveDragonBlood,DIA_Jan_DragonBlood_1);
	};
	BloodLeft = IntToString(Npc_HasItems(other,ItAt_DragonBlood));
	BloodText = ConcatStrings(BloodLeft,PRINT_NumberLeft);
	AI_PrintScreen(BloodText,-1,-1,FONT_ScreenSmall,2);*/
};


instance DIA_Jan_NACHOCGATEOPEN(C_Info)
{
	npc = DJG_714_Jan;
	nr = 3;
	condition = DIA_Jan_NACHOCGATEOPEN_Condition;
	information = DIA_Jan_NACHOCGATEOPEN_Info;
	permanent = TRUE;
	description = "Everything all right?";
};


func int DIA_Jan_NACHOCGATEOPEN_Condition()
{
	if(MIS_OCGateOpen == TRUE)
	{
		return TRUE;
	};
};

func void DIA_Jan_NACHOCGATEOPEN_Info()
{
	AI_Output (other, self, "DIA_Jan_NACHOCGATEOPEN_15_00");	//Everything all right?
	AI_Output (self, other, "DIA_Jan_NACHOCGATEOPEN_10_01");	//Absolutely nothing is clear!
	if (hero.guild == GIL_PAL)
	{
		AI_Output (self, other, "DIA_Jan_NACHOCGATEOPEN_10_02");	//Why did you idiots open the gate? You paladins are a few beans short of a fart!
	}
	else
	{
		AI_Output (self, other, "DIA_Jan_NACHOCGATEOPEN_10_03");	//So they just go ahead and open the gate. Dimwits! I just can't get over it.
	};
	AI_StopProcessInfos(self);
};


instance DIA_Jan_PICKPOCKET(C_Info)
{
	npc = DJG_714_Jan;
	nr = 900;
	condition = DIA_Jan_PICKPOCKET_Condition;
	information = DIA_Jan_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_40;
};


func int DIA_Jan_PICKPOCKET_Condition()
{
	return C_Beklauen(37,95);
};

func void DIA_Jan_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Jan_PICKPOCKET);
	Info_AddChoice(DIA_Jan_PICKPOCKET,Dialog_Back,DIA_Jan_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Jan_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Jan_PICKPOCKET_DoIt);
};

func void DIA_Jan_PICKPOCKET_DoIt()
{
	B_Beklauen();
	Info_ClearChoices(DIA_Jan_PICKPOCKET);
};

func void DIA_Jan_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Jan_PICKPOCKET);
};

