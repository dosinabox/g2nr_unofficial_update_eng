
instance StatsBook(C_Item)
{
	name = "Stats Book";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_Stats.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = Use_StatsBook;
};


func void Use_StatsBook()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Blue_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Blue_R.tga",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,0,270,20,30,20,1);
	Doc_PrintLine(nDocID,0,"Killed:");
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Stats_Killed_Draconian)," lizard men"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Stats_Killed_Dementor)," seekers"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Stats_Killed_OrcElite)," orc elites"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Stats_Killed_OrcCommander)," orc commanders"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(MadKillerCount)," innocent people"));
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Used:");
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalApplesEaten)," apples"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalMushroomsEaten)," dark mushrooms"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalDexEaten)," goblin berries"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalStrEaten)," dragon roots"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalPermEaten)," king's sorrels"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Shell_Opener)," clams"));
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Given:");
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalStoneplatesForVatras)," tablets to Vatras"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(OldCoinCounter)," coins to Wasili"));
	if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(BusterTrophyCounter)," horns to Buster"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(DragonEggCounter)," eggs to Bennet"));
	}
	else if(hero.guild == GIL_KDF)
	{
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(AlmanachCounter)," almanacs to Pyrokar"));
	}
	else if(hero.guild == GIL_PAL)
	{
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(OrkRingCounter)," rings to Hagen"));
	};
	Doc_PrintLine(nDocID,0,"");
	if(Player_IsApprentice == APP_Constantino)
	{
		Doc_PrintLine(nDocID,0,"Profession (Constantino):");
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Constantino_DunkelpilzCounter)," black mushrooms sold"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Constantino_BigMushroomsCounter)," digger's meat sold"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(ApprenticeGoldCounter),PRINT_GoldTaken));
	}
	else if(Player_IsApprentice == APP_Bosper)
	{
		Doc_PrintLine(nDocID,0,"Profession (Bosper):");
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(BosperFurCounter)," furs sold"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(ApprenticeGoldCounter),PRINT_GoldTaken));
	}
	else if(Player_IsApprentice == APP_Harad)
	{
		Doc_PrintLine(nDocID,0,"Profession (Harad):");
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(AnyAnvilUsed)," swords forged"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(HaradSwordsCounter)," swords sold"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(ApprenticeGoldCounter),PRINT_GoldTaken));
	};
	Doc_SetMargins(nDocID,-1,10,20,275,20,1);
	Doc_PrintLine(nDocID,1,"Innos blessings:");
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_GoldGiven),PRINT_GoldGiven));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_Str)," strength received"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_Dex)," dexterity received"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_MaxHp)," max health received"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_MaxMana)," max mana received"));
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Beliar blessings:");
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Beliar_HpGiven)," max health given"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Beliar_ManaGiven)," max mana given"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Beliar_GoldTaken),PRINT_GoldTaken));
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Claw upgrades:");
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Beliar_ClawMaxHp)," max health given"));
	if(Saturas_KlaueInsMeer == FALSE)
	{
		Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(BeliarWeapCurrentLvL)," level"));
	}
	else
	{
		Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(BeliarWeapCurrentLvL)," level (destroyed)"));
	};
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"Thefts:");
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(TotalThefts)," successfull thefts"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(TotalTheftXP)," experience received"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(TotalTheftGold)," gold stolen"));
	Doc_PrintLine(nDocID,1,"");
	if(UnionActivated == TRUE)
	{
		Doc_PrintLine(nDocID,1,"Build info:");
	}
	else
	{
		Doc_PrintLine(nDocID,1,"Build (no Union):");
	};
	Doc_PrintLine(nDocID,1,ConcatStrings(ConcatStrings(IntToString(FIX_VERSION_START)," version at "),FIX_VERSION_DATE));
	if(FIX_VERSION_SAVE == FALSE)
	{
		if(Addon_zuerst == TRUE)
		{
			Doc_PrintLine(nDocID,1,"Game started in original");
		}
		else
		{
			Doc_PrintLine(nDocID,1,"Game started without addon");
		};
	}
	else
	{
		Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(FIX_VERSION_SAVE)," version in save"));
	};
	if(Wasteland_Seeded == TRUE)
	{
		Doc_PrintLine(nDocID,1,"Wasteland world seeded");
	};
	if(HardModeEnabled == TRUE)
	{
		Doc_PrintLine(nDocID,1,ConcatStrings(ConcatStrings("Exp lowered by ",IntToString(HardModeXPModifier)),"%"));
	};
	Doc_Show(nDocID);
};

instance Helmets(C_Item)
{
	name = NAME_Bag;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItMi_Bag.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = UseHelmets;
	description = name;
	text[0] = "Bag filled with experimental";
	text[1] = "armors and helmets!";
};


func void UseHelmets()
{
	CreateInvItem(self,ITAR_DJGN_M);
	CreateInvItem(self,ITAR_DJGN_H);
	CreateInvItem(self,ITAR_PALN_M);
	CreateInvItem(self,ITAR_PALN_H);
	CreateInvItem(self,ITAR_OHT);
	CreateInvItem(self,ITAR_DHT);
	CreateInvItem(self,ITHE_DJG_M);
	CreateInvItem(self,ITHE_DJG_H);
	CreateInvItem(self,ITHE_PAL_M);
	CreateInvItem(self,ITHE_PAL_H);
	CreateInvItem(self,ITHE_OHT);
	CreateInvItem(self,ITHE_DHT);
	Print("I've got a bunch of armors and helmets!");
};

instance WastelandRune(C_Item)
{
	name = "Wasteland Rune";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItRu_TeleportOWDemonTower.3DS";
	material = MAT_STONE;
	scemeName = "MAP";
	description = name;
	text[0] = "Seed Wasteland world.";
	on_state[0] = UseWastelandRune;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UseWastelandRune()
{
	if(CurrentLevel == OLDWORLD_ZEN)
	{
		PrintScreen("Seeding...",-1,-1,FONT_Screen,1);
		B_Seed_Wasteland_World_Main();
		B_Seed_Wasteland_World_Psicamp();
		B_Seed_Wasteland_World_Freeminecamp();
	}
	else
	{
		PrintScreen(PRINT_TeleportTooFarAway,-1,-1,FONT_Screen,1);
	};
};

func void b_build_settings_diag()
{
	Info_ClearChoices(StoryHelper_PatchSettings);
	Info_AddChoice(StoryHelper_PatchSettings,Dialog_Back,StoryHelper_PatchSettings_BACK);
	/*if(PenaltiesAffectLearnCost == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable penalties affect learn cost",StoryHelper_Penalties);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable âpenalties affect learn cost",StoryHelper_Penalties);
	};*/
	Info_AddChoice(StoryHelper_PatchSettings,"Change ice dragon magic",StoryHelper_IceDragonSpell);
	if(FullNPCRemoval == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable full NPCs removal",StoryHelper_FullNPCRemoval);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable full NPCs removal",StoryHelper_FullNPCRemoval);
	};
	if(AlternativeSmithing == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable Bennet's alternative smithing skills tree",StoryHelper_AlternativeSmithing);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable Bennet's alternative smithing skills tree",StoryHelper_AlternativeSmithing);
	};
	if(HardModeEnabled == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable increased difficulty",StoryHelper_HardMode);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable increased difficulty",StoryHelper_HardMode);
	};
	if(ClassicAlchemy == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable pre-addon G2 alchemy",StoryHelper_ClassicAlchemy);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable pre-addon G2 alchemy",StoryHelper_ClassicAlchemy);
	};
	if(Helmets_Enabled == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable separate helmets and armors",StoryHelper_Helmets);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable separate helmets and armors",StoryHelper_Helmets);
	};
	if(HonestStatCalculation == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable honest learn cost calculation",StoryHelper_HonestStatCalculation);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable honest learn cost calculation",StoryHelper_HonestStatCalculation);
	};
	if(AddonDisabled == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable walkthrough without addon",StoryHelper_Addon);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable walkthrough without addon",StoryHelper_Addon);
	};
	if(GuildlessMode == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable walkthrough without guild",StoryHelper_Guildless);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable walkthrough without guild",StoryHelper_Guildless);
	};
	if(!Npc_KnowsInfo(other,DIA_Coragon_GiveBook) && !Npc_KnowsInfo(other,DIA_Thorben_GiveBook))
	{
		if(ClassicLehmarBook == FALSE)
		{
			Info_AddChoice(StoryHelper_PatchSettings,"Enable Lehmar's book buyback from Thorben and Coragon",StoryHelper_LehmarBook);
		}
		else
		{
			Info_AddChoice(StoryHelper_PatchSettings,"Disable Lehmar's book buyback from Thorben and Coragon",StoryHelper_LehmarBook);
		};
	};
	if(TradersHaveLimitedAmmo == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable arrows and bolts daily traders limit",StoryHelper_Limit);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable arrows and bolts daily traders limit",StoryHelper_Limit);
	};
	if(Dont_Fix_Unlim == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable infinite steel and flasks from traders",StoryHelper_Unlimfix);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable infinite steel and flasks from traders",StoryHelper_Unlimfix);
	};
	if(NpcWantToFlee == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable coward mode for humans and animals",StoryHelper_Flee);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable coward mode for humans and animals",StoryHelper_Flee);
	};
	if(IgnoreBonuses == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable ignore bonuses when learning attributes",StoryHelper_Bonuses);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable ignore bonuses when learning attributes",StoryHelper_Bonuses);
	};
	if(RandomGoblinBerries == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable random Goblin Berries from dead paladins",StoryHelper_GoblinBerries);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable random Goblin Berries from dead paladins",StoryHelper_GoblinBerries);
	};
	if(InfiniteApples == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable infinite apples from unconscious NPCs",StoryHelper_Apples);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable infinite apples from unconscious NPCs",StoryHelper_Apples);
	};
	if(XP_Static == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable static XP",StoryHelper_XP);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable static XP",StoryHelper_XP);
	};
	if(NoXPFromSummonedSkeletons == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable XP from infinite summoned skeletons",StoryHelper_Skeletons);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable XP from infinite summoned skeletons",StoryHelper_Skeletons);
	};
	if(NewLogEnabled == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Enable quests titles when updating diary",StoryHelper_Log);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"Disable quests titles when updating diary",StoryHelper_Log);
	};
};

func void StoryHelper_Limit()
{
	if(TradersHaveLimitedAmmo == TRUE)
	{
		TradersHaveLimitedAmmo = FALSE;
		PrintScreen("Limit disabled",-1,-1,FONT_Screen,2);
	}
	else
	{
		TradersHaveLimitedAmmo = TRUE;
		PrintScreen("Limit enabled",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_Flee()
{
	if(NpcWantToFlee == TRUE)
	{
		NpcWantToFlee = FALSE;
		PrintScreen("Coward mode disabled",-1,-1,FONT_Screen,2);
	}
	else
	{
		NpcWantToFlee = TRUE;
		PrintScreen("Coward mode enabled",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_Unlimfix()
{
	if(Dont_Fix_Unlim == TRUE)
	{
		Dont_Fix_Unlim = FALSE;
		PrintScreen("Steel and flasks are limited now",-1,-1,FONT_Screen,2);
	}
	else
	{
		Dont_Fix_Unlim = TRUE;
		PrintScreen("Steel and flasks are unlimited now",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_Bonuses()
{
	if(IgnoreBonuses == TRUE)
	{
		IgnoreBonuses = FALSE;
		TAL_CostFlags_TS_PermBonus = 1;
		PrintScreen("Original bonuses enabled",-1,-1,FONT_Screen,2);
	}
	else
	{
		IgnoreBonuses = TRUE;
		TAL_CostFlags_TS_PermBonus = 0;
		PrintScreen("You can stop bonuses hoarding now",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_GoblinBerries()
{
	if(RandomGoblinBerries == TRUE)
	{
		RandomGoblinBerries = FALSE;
		PrintScreen("Traders have static berries amount now",-1,-1,FONT_Screen,3);
	}
	else
	{
		RandomGoblinBerries = TRUE;
		PrintScreen("Paladins have random berries now",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Apples()
{
	if(InfiniteApples == TRUE)
	{
		InfiniteApples = FALSE;
		PrintScreen("No more infinite apples",-1,-1,FONT_Screen,2);
	}
	else
	{
		InfiniteApples = TRUE;
		PrintScreen("Apples are infinite now",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_Helmets()
{
	if(Helmets_Enabled == TRUE)
	{
		PrintScreen("Helmets and armors are combined now",-1,-1,FONT_Screen,3);
		Npc_RemoveInvItem(hero,ITHE_PAL_M);
		Npc_RemoveInvItem(hero,ITHE_PAL_H);
		Npc_RemoveInvItem(hero,ITHE_DJG_M);
		Npc_RemoveInvItem(hero,ITHE_DJG_H);
		if(Npc_HasItems(hero,ITAR_PALN_M))
		{
			Npc_RemoveInvItem(hero,ITAR_PALN_M);
			CreateInvItem(hero,ITAR_PAL_M);
		};
		if(Npc_HasItems(hero,ITAR_PALN_H))
		{
			Npc_RemoveInvItem(hero,ITAR_PALN_H);
			CreateInvItem(hero,ITAR_PAL_H);
		};
		if(Npc_HasItems(hero,ITAR_DJGN_M))
		{
			Npc_RemoveInvItem(hero,ITAR_DJGN_M);
			CreateInvItem(hero,ITAR_DJG_M);
		};
		if(Npc_HasItems(hero,ITAR_DJGN_H))
		{
			Npc_RemoveInvItem(hero,ITAR_DJGN_H);
			CreateInvItem(hero,ITAR_DJG_H);
		};
		Helmets_Enabled = FALSE;
	}
	else
	{
		PrintScreen("Helmets and armors are separated now",-1,-1,FONT_Screen,2);
		if(Npc_HasItems(hero,ITAR_PAL_M))
		{
			Npc_RemoveInvItem(hero,ITAR_PAL_M);
			CreateInvItem(hero,ITAR_PALN_M);
			CreateInvItem(hero,ITHE_PAL_M);
		};
		if(Npc_HasItems(hero,ITAR_PAL_H))
		{
			Npc_RemoveInvItem(hero,ITAR_PAL_H);
			CreateInvItem(hero,ITAR_PALN_H);
			CreateInvItem(hero,ITHE_PAL_H);
		};
		if(Npc_HasItems(hero,ITAR_DJG_M))
		{
			Npc_RemoveInvItem(hero,ITAR_DJG_M);
			CreateInvItem(hero,ITAR_DJGN_M);
			CreateInvItem(hero,ITHE_DJG_M);
		};
		if(Npc_HasItems(hero,ITAR_DJG_H))
		{
			Npc_RemoveInvItem(hero,ITAR_DJG_H);
			CreateInvItem(hero,ITAR_DJGN_H);
			CreateInvItem(hero,ITHE_DJG_H);
		};
		Helmets_Enabled = TRUE;
	};
	b_build_settings_diag();
};

func void StoryHelper_ClassicAlchemy()
{
	if(ClassicAlchemy == TRUE)
	{
		ClassicAlchemy = FALSE;
		PrintScreen("Pre-addon G2 alchemy disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		ClassicAlchemy = TRUE;
		PrintScreen("Pre-addon G2 alchemy enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_AlternativeSmithing()
{
	if(AlternativeSmithing == TRUE)
	{
		AlternativeSmithing = FALSE;
		PrintScreen("Bennet's alternative smithing skills tree disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		AlternativeSmithing = TRUE;
		PrintScreen("Bennet's alternative smithing skills tree enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Log()
{
	if(NewLogEnabled == TRUE)
	{
		NewLogEnabled = FALSE;
		PrintScreen("Diary titles disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		NewLogEnabled = TRUE;
		PrintScreen("Diary titles enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Skeletons()
{
	if(NoXPFromSummonedSkeletons == TRUE)
	{
		NoXPFromSummonedSkeletons = FALSE;
		PrintScreen("XP for infinite skeletons enabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		NoXPFromSummonedSkeletons = TRUE;
		PrintScreen("XP for infinite skeletons disabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_HardMode()
{
	if(HardModeEnabled == TRUE)
	{
		HardModeEnabled = FALSE;
		PrintScreen("Increased difficulty disabled",-1,-1,FONT_Screen,3);
		b_build_settings_diag();
	}
	else
	{
		HardModeEnabled = TRUE;
		PrintScreen("Increased difficulty enabled",-1,-1,FONT_Screen,3);
		Info_ClearChoices(StoryHelper_PatchSettings);
		Info_AddChoice(StoryHelper_PatchSettings,"XP -50%",StoryHelper_HardMode_50);
		Info_AddChoice(StoryHelper_PatchSettings,"XP -40%",StoryHelper_HardMode_40);
		Info_AddChoice(StoryHelper_PatchSettings,"XP -30%",StoryHelper_HardMode_30);
		Info_AddChoice(StoryHelper_PatchSettings,"XP -20%",StoryHelper_HardMode_20);
		Info_AddChoice(StoryHelper_PatchSettings,"XP -10%",StoryHelper_HardMode_10);
	};
};

func void StoryHelper_HardMode_10()
{
	HardModeXPModifier = 10;
	PrintScreen("XP decreased by 10%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_HardMode_20()
{
	HardModeXPModifier = 20;
	PrintScreen("XP decreased by 20%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_HardMode_30()
{
	HardModeXPModifier = 30;
	PrintScreen("XP decreased by 30%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_HardMode_40()
{
	HardModeXPModifier = 40;
	PrintScreen("XP decreased by 40%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_HardMode_50()
{
	HardModeXPModifier = 50;
	PrintScreen("XP decreased by 50%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_Penalties()
{
	if(PenaltiesAffectLearnCost == TRUE)
	{
		PenaltiesAffectLearnCost = FALSE;
		PrintScreen("Penalties affect learn cost disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		PenaltiesAffectLearnCost = TRUE;
		PrintScreen("Penalties affect learn cost enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_LehmarBook()
{
	if(ClassicLehmarBook == TRUE)
	{
		ClassicLehmarBook = FALSE;
		PrintScreen("Book buyback disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		ClassicLehmarBook = TRUE;
		PrintScreen("Book buyback enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Guildless()
{
	if(GuildlessMode == TRUE)
	{
		GuildlessMode = FALSE;
		PrintScreen("Walkthrough without guild disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		GuildlessMode = TRUE;
		PrintScreen("Walkthrough without guild enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Addon()
{
	if(AddonDisabled == TRUE)
	{
		AddonDisabled = FALSE;
		PrintScreen("Walkthrough without addon disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		AddonDisabled = TRUE;
		PrintScreen("Walkthrough without addon enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_XP()
{
	if(XP_Static == TRUE)
	{
		XP_Static = FALSE;
		if(Kapitel == 1)
		{
			XP_Ambient = XP_AmbientKap1;
		};
		if(Kapitel == 2)
		{
			XP_Ambient = XP_AmbientKap2;
		};
		if(Kapitel == 3)
		{
			XP_Ambient = XP_AmbientKap3;
		};
		if(Kapitel == 4)
		{
			XP_Ambient = XP_AmbientKap4;
		};
		if(Kapitel == 5)
		{
			XP_Ambient = XP_AmbientKap5;
		};
		if(Kapitel == 6)
		{
			XP_Ambient = XP_AmbientKap6;
		};
		PrintScreen("Original ambient dynamic XP enabled",-1,-1,FONT_Screen,3);
		b_build_settings_diag();
	}
	else
	{
		Info_ClearChoices(StoryHelper_PatchSettings);
		Info_AddChoice(StoryHelper_PatchSettings,Dialog_Back,StoryHelper_XP_Back);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 300 (chapter 6)",StoryHelper_XP_6);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 250 (chapter 5)",StoryHelper_XP_5);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 200 (chapter 4)",StoryHelper_XP_4);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 150 (chapter 3)",StoryHelper_XP_3);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 100 (chapter 2)",StoryHelper_XP_2);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 50  (chapter 1)",StoryHelper_XP_1);
	};
};

func void StoryHelper_XP_Back()
{
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_6()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap6;
	PrintScreen("XP_Ambient = 300 (chapter 6)",-1,-1,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_5()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap5;
	PrintScreen("XP_Ambient = 250 (chapter 5)",-1,-1,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_4()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap4;
	PrintScreen("XP_Ambient = 200 (chapter 4)",-1,-1,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_3()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap3;
	PrintScreen("XP_Ambient = 150 (chapter 3)",-1,-1,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_2()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap2;
	PrintScreen("XP_Ambient = 100 (chapter 2)",-1,-1,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_1()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap1;
	PrintScreen("XP_Ambient = 50 (chapter 1)",-1,-1,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_HonestStatCalculation()
{
	if(HonestStatCalculation == TRUE)
	{
		HonestStatCalculation = FALSE;
		PrintScreen("Honest learn cost calculation disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		HonestStatCalculation = TRUE;
		PrintScreen("Honest learn cost calculation enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_FullNPCRemoval()
{
	if(FullNPCRemoval == TRUE)
	{
		FullNPCRemoval = FALSE;
		PrintScreen("Full NPCs removal disabled",-1,-1,FONT_Screen,3);
	}
	else
	{
		FullNPCRemoval = TRUE;
		PrintScreen("Full NPCs removal enabled",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_IceDragonSpell()
{
	Info_ClearChoices(StoryHelper_PatchSettings);
	Info_AddChoice(StoryHelper_PatchSettings,Dialog_Back,StoryHelper_IceDragonSpell_BACK);
	if(IceDragonSpell == SPL_InstantFireball)
	{
		Info_AddChoice(StoryHelper_PatchSettings,ConcatStrings(NAME_SPL_InstantFireball," (active)"),StoryHelper_IceDragonSpell_InstantFireball);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,NAME_SPL_InstantFireball,StoryHelper_IceDragonSpell_InstantFireball);
	};
	if(IceDragonSpell == SPL_IceLance)
	{
		Info_AddChoice(StoryHelper_PatchSettings,ConcatStrings(NAME_SPL_IceLance," (active)"),StoryHelper_IceDragonSpell_IceLance);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,NAME_SPL_IceLance,StoryHelper_IceDragonSpell_IceLance);
	};
	if(IceDragonSpell == SPL_ChargeZap)
	{
		Info_AddChoice(StoryHelper_PatchSettings,ConcatStrings(NAME_SPL_ChargeZap," (active)"),StoryHelper_IceDragonSpell_ChargeZap);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,NAME_SPL_ChargeZap,StoryHelper_IceDragonSpell_ChargeZap);
	};
	if(IceDragonSpell == SPL_Icebolt)
	{
		Info_AddChoice(StoryHelper_PatchSettings,ConcatStrings(NAME_SPL_Icebolt," (active)"),StoryHelper_IceDragonSpell_Icebolt);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,NAME_SPL_Icebolt,StoryHelper_IceDragonSpell_Icebolt);
	};
};

func void StoryHelper_IceDragonSpell_InstantFireball()
{
	IceDragonSpell = SPL_InstantFireball;
	PrintScreen(ConcatStrings("Ice dragon magic: ",NAME_SPL_InstantFireball),-1,-1,FONT_Screen,3);
	StoryHelper_IceDragonSpell();
};

func void StoryHelper_IceDragonSpell_IceLance()
{
	IceDragonSpell = SPL_IceLance;
	PrintScreen(ConcatStrings("Ice dragon magic: ",NAME_SPL_IceLance),-1,-1,FONT_Screen,3);
	StoryHelper_IceDragonSpell();
};

func void StoryHelper_IceDragonSpell_ChargeZap()
{
	IceDragonSpell = SPL_ChargeZap;
	PrintScreen(ConcatStrings("Ice dragon magic: ",NAME_SPL_ChargeZap),-1,-1,FONT_Screen,3);
	StoryHelper_IceDragonSpell();
};

func void StoryHelper_IceDragonSpell_Icebolt()
{
	IceDragonSpell = SPL_Icebolt;
	PrintScreen(ConcatStrings("Ice dragon magic: ",NAME_SPL_Icebolt),-1,-1,FONT_Screen,3);
	StoryHelper_IceDragonSpell();
};

func void StoryHelper_IceDragonSpell_BACK()
{
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_PatchSettings_BACK()
{
	Info_ClearChoices(StoryHelper_PatchSettings);
};

