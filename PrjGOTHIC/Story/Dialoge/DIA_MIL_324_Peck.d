
instance DIA_Peck_EXIT(C_Info)
{
	npc = MIL_324_Peck;
	nr = 999;
	condition = DIA_Peck_EXIT_Condition;
	information = DIA_Peck_EXIT_Info;
	permanent = TRUE;
	description = Dialog_Ende;
};


func int DIA_Peck_EXIT_Condition()
{
	return TRUE;
};

func void DIA_Peck_EXIT_Info()
{
	AI_StopProcessInfos(self);
};


instance DIA_Peck_PICKPOCKET(C_Info)
{
	npc = MIL_324_Peck;
	nr = 900;
	condition = DIA_Peck_PICKPOCKET_Condition;
	information = DIA_Peck_PICKPOCKET_Info;
	permanent = TRUE;
	description = Pickpocket_60_Key;
};


func int DIA_Peck_PICKPOCKET_Condition()
{
//	return C_StealItems(60,Hlp_GetInstanceID(ItKe_City_Tower_05),1);
	if(Npc_HasItems(self,ItKe_City_Tower_05))
	{
		return C_StealItem(60);
	};
	return FALSE;
};

func void DIA_Peck_PICKPOCKET_Info()
{
	Info_ClearChoices(DIA_Peck_PICKPOCKET);
	Info_AddChoice(DIA_Peck_PICKPOCKET,Dialog_Back,DIA_Peck_PICKPOCKET_BACK);
	Info_AddChoice(DIA_Peck_PICKPOCKET,DIALOG_PICKPOCKET,DIA_Peck_PICKPOCKET_DoIt);
};

func void DIA_Peck_PICKPOCKET_DoIt()
{
//	B_StealItems(60,Hlp_GetInstanceID(ItKe_City_Tower_05),1);
	B_StealItem(60,Hlp_GetInstanceID(ItKe_City_Tower_05));
	Info_ClearChoices(DIA_Peck_PICKPOCKET);
};

func void DIA_Peck_PICKPOCKET_BACK()
{
	Info_ClearChoices(DIA_Peck_PICKPOCKET);
};


instance DIA_Peck_HEY(C_Info)
{
	npc = MIL_324_Peck;
	nr = 2;
	condition = DIA_Peck_HEY_Condition;
	information = DIA_Peck_HEY_Info;
	permanent = TRUE;
	description = "Hey, what's up?";
};


func int DIA_Peck_HEY_Condition()
{
	if((MIS_Andre_Peck != LOG_Running) && (Npc_GetDistToWP(self,"NW_CITY_HABOUR_PUFF_PECK") <= 500))
	{
		return TRUE;
	};
};

func void DIA_Peck_HEY_Info()
{
	AI_Output (other, self, "DIA_Peck_HEY_15_00");	//Hey, what's up?
	AI_Output (self, other, "DIA_Peck_HEY_12_01");	//Man, I'm busy. Leave me alone.
	AI_StopProcessInfos (self);
};


instance DIA_Peck_FOUND_PECK(C_Info)
{
	npc = MIL_324_Peck;
	nr = 2;
	condition = DIA_Peck_FOUND_PECK_Condition;
	information = DIA_Peck_FOUND_PECK_Info;
	permanent = FALSE;
	description = "Hey, it's time to hit the road.";
};


func int DIA_Peck_FOUND_PECK_Condition()
{
	if((MIS_Andre_Peck == LOG_Running) && (Npc_GetDistToWP(self,"NW_CITY_HABOUR_PUFF_PECK") <= 500))
	{
		return TRUE;
	};
};

func void DIA_Peck_FOUND_PECK_Info()
{
	AI_Output (other, self, "DIA_Peck_FOUND_PECK_15_00");	//Hey, it's time to hit the road.
	AI_Output (self, other, "DIA_Peck_FOUND_PECK_12_01");	//What do you want? Can't you see I'm busy?
	AI_Output (other, self, "DIA_Peck_FOUND_PECK_15_02");	//I need a weapon, so come back to the barracks.
	AI_Output (self, other, "DIA_Peck_FOUND_PECK_12_03");	//Damnit, your weapon can wait.
	AI_Output (other, self, "DIA_Peck_FOUND_PECK_15_04");	//Come on, Andre's already missed you, too.
	AI_Output (self, other, "DIA_Peck_FOUND_PECK_12_05");	//Hmpf... damn. Okay, I'm coming already - but when you report back to Andre, don't tell him I was here.
	self.aivar[AIV_IgnoresFakeGuild] = FALSE;
	self.aivar[AIV_ToughGuy] = FALSE;
	self.aivar[AIV_ToughGuyNewsOverride] = FALSE;
	self.aivar[AIV_IGNORE_Murder] = FALSE;
	self.aivar[AIV_IGNORE_Theft] = FALSE;
	self.aivar[AIV_IGNORE_Sheepkiller] = FALSE;
	AI_StopProcessInfos(self);
	Npc_ExchangeRoutine(self,"STORAGE");
	Npc_ExchangeRoutine(Vanja,"ALONE");
};


var int DIA_Peck_WEAPON_perm;
var int DIA_Peck_WEAPON2_perm;

func void B_GetWeaponFromPeckCh3()
{
	AI_Output(self,other,"DIA_Peck_Add_12_03");	//Good thing you asked. We got a few pretty good blades from Onar's mercenaries.
	AI_Output(self,other,"DIA_Peck_Add_12_04");	//They had no further use for them. (laughs dirty)
	AI_Output(self,other,"DIA_Peck_Add_12_05");	//Here, take it.
	if(MIS_Andre_Peck == LOG_FAILED)
	{
		B_GiveInvItems(self,other,ItMw_Schwert2,1);
	}
	else
	{
		B_GiveInvItems(self,other,ItMw_Rubinklinge,1);
	};
	DIA_Peck_WEAPON_perm = TRUE;
	DIA_Peck_WEAPON2_perm = TRUE;
};

instance DIA_Peck_WEAPON(C_Info)
{
	npc = MIL_324_Peck;
	nr = 2;
	condition = DIA_Peck_WEAPON_Condition;
	information = DIA_Peck_WEAPON_Info;
	permanent = TRUE;
	description = "I've come to get myself a weapon.";
};


func int DIA_Peck_WEAPON_Condition()
{
	if((other.guild == GIL_MIL) && (DIA_Peck_WEAPON_perm == FALSE))
	{
		if((Npc_GetDistToWP(self,"NW_CITY_ARMORY_PECK") <= 1000) || (Npc_GetDistToWP(self,"NW_CITY_BARRACK02_BED_PECK") <= 2000))
		{
			return TRUE;
		};
	};
};

func void DIA_Peck_WEAPON_Info()
{
	AI_Output(other,self,"DIA_Peck_WEAPON_15_00");	//I've come to get myself a weapon.
	if(MIS_Andre_Peck == LOG_Running)
	{
		AI_Output(self,other,"DIA_Peck_WEAPON_12_01");	//First go to Andre and report back to him.
	}
	else if(MIS_Andre_Peck == LOG_OBSOLETE)
	{
		AI_Output(self,other,"DIA_Peck_WEAPON_12_02");	//Well, look who's here. Our new comrade. And he wants a sword.
		AI_Output(self,other,"DIA_Peck_WEAPON_12_03");	//You didn't tell Andre I was in the Red Lantern. You seem to be okay. Here, take your sword.
		AI_Output(self,other,"DIA_Peck_Add_12_00");	/It's the best that I have.
		B_GiveInvItems(self,other,ItMw_Schwert1,1);
		DIA_Peck_WEAPON_perm = TRUE;
	}
	else if(MIS_Andre_Peck == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Peck_WEAPON_12_04");	//I haven't forgotten you. Who told Andre that I was in the Red Lantern, then?
		AI_Output(self,other,"DIA_Peck_WEAPON_12_05");	//And now you want a blade from me... all right, you'll get a blade. Here. And now drop dead.
		B_GiveInvItems(self,other,ItMw_1h_MISC_Sword,1);
		DIA_Peck_WEAPON_perm = TRUE;
	}
	else if(Kapitel >= 3)
	{
		B_GetWeaponFromPeckCh3();
	};
	AI_StopProcessInfos(self);
};

func void B_Peck_LeckMich()
{
	AI_Output (self, other, "DIA_Peck_Add_12_07");	//Kiss my ass!
};

instance DIA_Peck_WEAPON2(C_Info)
{
	npc = MIL_324_Peck;
	nr = 2;
	condition = DIA_Peck_WEAPON2_Condition;
	information = DIA_Peck_WEAPON2_Info;
	permanent = TRUE;
	description = "Do you have a better weapon for me?";
};


func int DIA_Peck_WEAPON2_Condition()
{
	if((other.guild == GIL_MIL) && (DIA_Peck_WEAPON_perm == TRUE) && (DIA_Peck_WEAPON2_perm == FALSE))
	{
		if((Npc_GetDistToWP(self,"NW_CITY_ARMORY_PECK") <= 1000) || (Npc_GetDistToWP(self,"NW_CITY_BARRACK02_BED_PECK") <= 2000))
		{
			return TRUE;
		};
	};
};

func void DIA_Peck_WEAPON2_Info()
{
	AI_Output(other,self,"DIA_Peck_Add_15_01");	//Do you have a better weapon for me?
	if(MIS_Andre_Peck == LOG_SUCCESS)
	{
		AI_Output(self,other,"DIA_Peck_Add_12_06");	//I haven't forgotten that you ratted me out to Lord Andre.
		B_Peck_LeckMich();
	}
	else if(Kapitel < 3)
	{
		AI_Output(self,other,"DIA_Peck_Add_12_02");	//Not at the moment...
		AI_Output(self,other,"DIA_Peck_WEAPON_12_06");	//If you want a better weapon, then go to the merchants in the market.
	}
	else
	{
		B_GetWeaponFromPeckCh3();
	};
};


func int C_PeckCanSellArmor()
{
	if(MIS_Addon_Andre_MissingPeople == LOG_SUCCESS)
	{
		return TRUE;
	}
	else if(MIS_OLDWORLD == LOG_SUCCESS)
	{
		return TRUE;
	};
	return FALSE;
};

var int VALUE_ITAR_MIL_M_Dynamic;

func void B_SetPeckArmorPrice()
{
	VALUE_ITAR_MIL_M_Dynamic = 4500;
	if(MIS_Andre_Peck == LOG_SUCCESS)
	{
		VALUE_ITAR_MIL_M_Dynamic += 500;
	};
	if((MIS_Andre_WAREHOUSE == LOG_SUCCESS) && (MIS_Andre_REDLIGHT == LOG_SUCCESS) && Npc_KnowsInfo(other,DIA_Andre_LOBART_SUCCESS))
	{
		VALUE_ITAR_MIL_M_Dynamic -= 500;
	};
	if(Rengaru_Ausgeliefert == TRUE)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 100;
	};
	if(Halvor_Ausgeliefert == TRUE)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 100;
	};
	if(Nagur_Ausgeliefert == TRUE)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 100;
	};
	if(Sarah_Ausgeliefert == TRUE)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 100;
	};
	if(Canthar_Ausgeliefert == TRUE)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 100;
	};
	if(Fernando_ImKnast == TRUE)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 100;
	};
	if(Andre_Knows_MartinEmpfehlung == TRUE)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 100;
	};
	if(MIS_Andre_GuildOfThieves == LOG_SUCCESS)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 1000;
	}
	else if(Andre_FoundThieves_Reported == TRUE)
	{
		VALUE_ITAR_MIL_M_Dynamic -= 500;
	};
};

instance DIA_Peck_ARMOR(C_Info)
{
	npc = MIL_324_Peck;
	nr = 3;
	condition = DIA_Peck_ARMOR_Condition;
	information = DIA_Peck_ARMOR_Info;
	permanent = TRUE;
	description = "What about some better armor?";
};


func int DIA_Peck_ARMOR_Condition()
{
	if((other.guild == GIL_MIL) && (DIA_MIL_ARMOR_M_perm == FALSE))
	{
		if((Npc_GetDistToWP(self,"NW_CITY_ARMORY_PECK") <= 1000) || (Npc_GetDistToWP(self,"NW_CITY_BARRACK02_BED_PECK") <= 2000))
		{
			return TRUE;
		};
	};
};

func void DIA_Peck_ARMOR_Info()
{
	DIA_Common_WhatAboutBetterArmor();
	if(MIS_Andre_Peck == LOG_Running)
	{
		AI_Output(self,other,"DIA_Peck_WEAPON_12_01");	//First go to Andre and report back to him.
	}
	else if(B_GetGreatestPetzCrime(self) != CRIME_NONE)
	{
		B_Say(self,other,"$CITY_CRIME");
	}
	else
	{
		if(C_PeckCanSellArmor())
		{
			B_SetPeckArmorPrice();
			if(MIS_Andre_Peck == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Addon_BDT_10014_Thorus_Rein_12_01");	//Okay.
			}
			else
			{
				AI_Output(self,other,"DIA_Peck_Add_12_00");	//It's the best that I have.
			};
			Info_ClearChoices(DIA_Peck_ARMOR);
			Info_AddChoice(DIA_Peck_ARMOR,Dialog_Back,DIA_Peck_ARMOR_Back);
			Info_AddChoice(DIA_Peck_ARMOR,B_BuildPriceString("Buy Heavy Militia Armor. Protection: 70/70/10/10.",VALUE_ITAR_MIL_M_Dynamic),DIA_Peck_ARMOR_BUY);
		}
		else
		{
			if(MIS_Andre_Peck == LOG_SUCCESS)
			{
				AI_Output(self,other,"DIA_Addon_Thorus_Add_12_05");	//(firmly) No!
				AI_StopProcessInfos(self);
			}
			else
			{
				AI_Output(self,other,"DIA_Peck_Add_12_02");	//Not at the moment...
			};
		};
	};
};


func void DIA_Peck_ARMOR_Back()
{
	Info_ClearChoices(DIA_Peck_ARMOR);
};

func void DIA_Peck_ARMOR_BUY()
{
	DIA_Common_GiveMeThatArmor();
	if(B_GiveInvItems(other,self,ItMi_Gold,VALUE_ITAR_MIL_M_Dynamic))
	{
		AI_Output(self,other,"DIA_Peck_Add_12_05");	//Here, take it.
		B_GiveArmor(ITAR_MIL_M);
		DIA_MIL_ARMOR_M_perm = TRUE;
	}
	else
	{
		AI_Output(self,other,"DIA_Mika_UEBERLEGT_12_02");	//(angry) Come back when you have the money.
	};
	Info_ClearChoices(DIA_Peck_ARMOR);
};

/*instance DIA_Peck_TRADE(C_Info)
{
	npc = MIL_324_Peck;
	nr = 4;
	condition = DIA_Peck_TRADE_Condition;
	information = DIA_Peck_TRADE_Info;
	permanent = TRUE;
	description = "Have you got anything else for me?";
};


func int DIA_Peck_TRADE_Condition()
{
	if((other.guild == GIL_MIL) && (DIA_Peck_ARMOR_perm == FALSE))
	{
		if((Npc_GetDistToWP(self,"NW_CITY_ARMORY_PECK") <= 1000) || (Npc_GetDistToWP(self,"NW_CITY_BARRACK02_BED_PECK") <= 2000))
		{
			return TRUE;
		};
	};
	return FALSE;
};

func void DIA_Peck_TRADE_Info()
{
	//AI_Output(other,self,"DIA_Parlan_Bibliothek_15_00");	//Have you got anything else for me?
};*/


instance DIA_Peck_PERM(C_Info)
{
	npc = MIL_324_Peck;
	nr = 800;
	condition = DIA_Peck_PERM_Condition;
	information = DIA_Peck_PERM_Info;
	permanent = TRUE;
	description = "Everything all right with you?";
};


func int DIA_Peck_PERM_Condition()
{
	if((Npc_GetDistToWP(self,"NW_CITY_ARMORY_PECK") <= 1000) || (Npc_GetDistToWP(self,"NW_CITY_BARRACK02_BED_PECK") <= 2000))
	{
		return TRUE;
	};
};

func void DIA_Peck_PERM_Info()
{
	AI_Output (other, self, "DIA_Peck_PERM_15_00");	//Everything all right with you?
	if (MIS_Andre_Peck == LOG_SUCCESS)
	{
		B_Peck_LeckMich();
	}
	else if(Kapitel != 3)
	{
		AI_Output (self, other, "DIA_Peck_PERM_12_01");	//Yeah, and with you?
	}
	else if(Kapitel == 3)
	{
		if(MIS_RescueBennet != LOG_SUCCESS)
		{
			if((hero.guild == GIL_MIL) || (hero.guild == GIL_PAL))
			{
				AI_Output (self, other, "DIA_Peck_PERM_12_02");	//Not really. I'm worried about the mercenaries, I mean, they're bound to try and break their friend out of jail now.
				AI_Output (self, other, "DIA_Peck_PERM_12_03");	//I don't want to go up against a bunch of experienced fighters.
			}
			else if(hero.guild == GIL_KDF)
			{
				AI_Output (self, other, "DIA_Peck_PERM_12_04");	//Of course! We're all keeping our eyes open. The magicians can rest assured that the prisoner has no chance of escaping.
			}
			else
			{
				AI_Output (self, other, "DIA_Peck_PERM_12_05");	//I know what you're planning, but you won't succeed in getting away with the prisoner.
			};
		}
		else
		{
			AI_Output (self, other, "DIA_Peck_PERM_12_06");	//I'm very glad that business with the murder has been cleared up.
			AI_Output (other, self, "DIA_Peck_PERM_15_07");	//Why?
			AI_Output (self, other, "DIA_Peck_PERM_12_08");	//The mercenaries wouldn't have just stood by without a fight and watched us take one of them to the gallows.
			AI_Output (self, other, "DIA_Peck_PERM_12_09");	//At worst, they would have just attacked us. I don't even want to imagine what would have happened then.
		};
	};
};

