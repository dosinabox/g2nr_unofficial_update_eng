
instance StatsBook(C_Item)
{
	name = "����� ����������";
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
	Doc_PrintLine(nDocID,0,"�����:");
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Stats_Killed_Draconian)," �����-������"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Stats_Killed_Dementor)," ������"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Stats_Killed_OrcElite)," ������� �����"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Stats_Killed_OrcCommander)," ������������� �����"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(MadKillerCount)," �������� �����"));
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"������������:");
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalApplesEaten)," �����"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalMushroomsEaten)," ������ ������"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalDexEaten)," ���������� ����"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalStrEaten)," ��������� ������"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalPermEaten)," ������� �������"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Shell_Opener)," ���������"));
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"������:");
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(TotalStoneplatesForVatras)," �������� �������"));
	Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(OldCoinCounter)," ����� �������"));
	if((hero.guild == GIL_SLD) || (hero.guild == GIL_DJG))
	{
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(BusterTrophyCounter)," ����� �������"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(DragonEggCounter)," ��� �������"));
	}
	else if(hero.guild == GIL_KDF)
	{
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(AlmanachCounter)," ���������� ��������"));
	}
	else if(hero.guild == GIL_PAL)
	{
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(OrkRingCounter)," ����� ������"));
	};
	Doc_PrintLine(nDocID,0,"");
	if(Player_IsApprentice == APP_Constantino)
	{
		Doc_PrintLine(nDocID,0,"������� (�����������):");
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Constantino_DunkelpilzCounter)," ������ ������ �������"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(Constantino_BigMushroomsCounter)," ���� �������� �������"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(ApprenticeGoldCounter),PRINT_GoldTaken));
	}
	else if(Player_IsApprentice == APP_Bosper)
	{
		Doc_PrintLine(nDocID,0,"������� (������):");
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(BosperFurCounter)," ���� �������"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(ApprenticeGoldCounter),PRINT_GoldTaken));
	}
	else if(Player_IsApprentice == APP_Harad)
	{
		Doc_PrintLine(nDocID,0,"������� (�����):");
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(AnyAnvilUsed)," ����� ��������"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(HaradSwordsCounter)," ����� �������"));
		Doc_PrintLine(nDocID,0,ConcatStrings(IntToString(ApprenticeGoldCounter),PRINT_GoldTaken));
	};
	Doc_SetMargins(nDocID,-1,10,20,275,20,1);
	Doc_PrintLine(nDocID,1,"������� ������:");
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_GoldGiven),PRINT_GoldGiven));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_Str)," ���� ��������"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_Dex)," �������� ��������"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_MaxHp)," ����. �������� ��������"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Blessings_MaxMana)," ����. ���� ��������"));
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"������� �������:");
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Beliar_HpGiven)," ����. �������� ������"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Beliar_ManaGiven)," ����. ���� ������"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Beliar_GoldTaken),PRINT_GoldTaken));
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"��������� �����:");
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(Stats_Beliar_ClawMaxHp)," ����. �������� ������"));
	if(Saturas_KlaueInsMeer == FALSE)
	{
		Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(BeliarWeapCurrentLvL)," �������"));
	}
	else
	{
		Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(BeliarWeapCurrentLvL)," ������� (���������)"));
	};
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"�����:");
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(TotalThefts)," �������� ����"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(TotalTheftXP)," ����� ��������"));
	Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(TotalTheftGold)," ������� ��������"));
	Doc_PrintLine(nDocID,1,"");
	if(UnionActivated == TRUE)
	{
		Doc_PrintLine(nDocID,1,"���������� � ������:");
	}
	else
	{
		Doc_PrintLine(nDocID,1,"������ (��� Union):");
	};
	Doc_PrintLine(nDocID,1,ConcatStrings(ConcatStrings(IntToString(FIX_VERSION_START)," ������ �� "),FIX_VERSION_DATE));
	if(FIX_VERSION_SAVE == FALSE)
	{
		if(Addon_zuerst == TRUE)
		{
			Doc_PrintLine(nDocID,1,"���� ������ � ���������");
		}
		else
		{
			Doc_PrintLine(nDocID,1,"���� ������ ��� ������");
		};
	}
	else
	{
		Doc_PrintLine(nDocID,1,ConcatStrings(IntToString(FIX_VERSION_SAVE)," ������ � ����������"));
	};
	if(Wasteland_Seeded == TRUE)
	{
		Doc_PrintLine(nDocID,1,"��� Wasteland �������");
	};
	if(HardModeEnabled == TRUE)
	{
		Doc_PrintLine(nDocID,1,ConcatStrings(ConcatStrings("���� ������ �� ",IntToString(HardModeXPModifier)),"%"));
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
	text[0] = "����� �������� ������������������";
	text[1] = "��������� � �������!";
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
	Print("������� ����� ������ �������� � ������!");
};

instance WastelandRune(C_Item)
{
	name = "���� Wasteland";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItRu_TeleportOWDemonTower.3DS";
	material = MAT_STONE;
	scemeName = "MAP";
	description = name;
	text[0] = "�������� ��� ���� Wasteland.";
	on_state[0] = UseWastelandRune;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UseWastelandRune()
{
	if(CurrentLevel == OLDWORLD_ZEN)
	{
		PrintScreen("��������...",-1,-1,FONT_Screen,1);
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
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ������� ������� �� ��������� ��������",StoryHelper_Penalties);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ������� ������� �� ��������� ��������",StoryHelper_Penalties);
	};*/
	Info_AddChoice(StoryHelper_PatchSettings,"�������� ����� �������� �������",StoryHelper_IceDragonSpell);
	if(FullNPCRemoval == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ������ �������� NPC �� ����",StoryHelper_FullNPCRemoval);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ������ �������� NPC �� ����",StoryHelper_FullNPCRemoval);
	};
	if(AlternativeSmithing == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� �������������� �������� � �������",StoryHelper_AlternativeSmithing);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� �������������� �������� � �������",StoryHelper_AlternativeSmithing);
	};
	if(HardModeEnabled == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ���������� ������� ���������",StoryHelper_HardMode);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ���������� ������� ���������",StoryHelper_HardMode);
	};
	if(ClassicAlchemy == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ������� �� ������ 2 ��� ������",StoryHelper_ClassicAlchemy);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ������� �� ������ 2 ��� ������",StoryHelper_ClassicAlchemy);
	};
	if(Helmets_Enabled == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ����� �� ��������",StoryHelper_Helmets);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ����� � �������",StoryHelper_Helmets);
	};
	if(HonestStatCalculation == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ������� ������ ��������� ��������",StoryHelper_HonestStatCalculation);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ������� ������ ��������� ��������",StoryHelper_HonestStatCalculation);
	};
	if(AddonDisabled == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ����������� ����������� ��� ������",StoryHelper_Addon);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ����������� ����������� ��� ������",StoryHelper_Addon);
	};
	if(GuildlessMode == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ����������� ����������� ��� �������",StoryHelper_Guildless);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ����������� ����������� ��� �������",StoryHelper_Guildless);
	};
	if(!Npc_KnowsInfo(other,DIA_Coragon_GiveBook) && !Npc_KnowsInfo(other,DIA_Thorben_GiveBook))
	{
		if(ClassicLehmarBook == FALSE)
		{
			Info_AddChoice(StoryHelper_PatchSettings,"�������� ����� ��������� � ������� � ��������",StoryHelper_LehmarBook);
		}
		else
		{
			Info_AddChoice(StoryHelper_PatchSettings,"��������� ����� ��������� � ������� � ��������",StoryHelper_LehmarBook);
		};
	};
	if(TradersHaveLimitedAmmo == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ����� ������ ����� � ������ � ���������",StoryHelper_Limit);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ����� ������ ����� � ������ � ���������",StoryHelper_Limit);
	};
	if(Dont_Fix_Unlim == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ����������� ����� � �������� � ���������",StoryHelper_Unlimfix);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ����������� ����� � �������� � ���������",StoryHelper_Unlimfix);
	};
	if(NpcWantToFlee == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ����� �������� � ����� � ��������",StoryHelper_Flee);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ����� �������� � ����� � ��������",StoryHelper_Flee);
	};
	if(IgnoreBonuses == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ������������� ������� ��� ��������",StoryHelper_Bonuses);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ������������� ������� ��� ��������",StoryHelper_Bonuses);
	};
	if(RandomGoblinBerries == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ��������� ���������� ����� � ���������",StoryHelper_GoblinBerries);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ��������� ���������� ����� � ���������",StoryHelper_GoblinBerries);
	};
	if(InfiniteApples == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ��������� ����������� �����",StoryHelper_Apples);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ��������� ����������� �����",StoryHelper_Apples);
	};
	if(XP_Static == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ������������� ���� �� ������",StoryHelper_XP);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ������������� ���� �� ������",StoryHelper_XP);
	};
	if(NoXPFromSummonedSkeletons == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ���� � ���������� ����������� ��������",StoryHelper_Skeletons);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ���� � ���������� ����������� ��������",StoryHelper_Skeletons);
	};
	if(NewLogEnabled == FALSE)
	{
		Info_AddChoice(StoryHelper_PatchSettings,"�������� ����� ���������� ��� ���������� ��������",StoryHelper_Log);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,"��������� ����� ���������� ��� ���������� ��������",StoryHelper_Log);
	};
};

func void StoryHelper_Limit()
{
	if(TradersHaveLimitedAmmo == TRUE)
	{
		TradersHaveLimitedAmmo = FALSE;
		PrintScreen("����� ��������",-1,-1,FONT_Screen,2);
	}
	else
	{
		TradersHaveLimitedAmmo = TRUE;
		PrintScreen("����� �������",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_Flee()
{
	if(NpcWantToFlee == TRUE)
	{
		NpcWantToFlee = FALSE;
		PrintScreen("����� �������� ��������",-1,-1,FONT_Screen,2);
	}
	else
	{
		NpcWantToFlee = TRUE;
		PrintScreen("����� �������� �������",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_Unlimfix()
{
	if(Dont_Fix_Unlim == TRUE)
	{
		Dont_Fix_Unlim = FALSE;
		PrintScreen("����� � �������� ����������",-1,-1,FONT_Screen,2);
	}
	else
	{
		Dont_Fix_Unlim = TRUE;
		PrintScreen("����� � �������� ����������",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_Bonuses()
{
	if(IgnoreBonuses == TRUE)
	{
		IgnoreBonuses = FALSE;
		TAL_CostFlags_TS_PermBonus = 1;
		PrintScreen("��������: ������ ����� ������",-1,-1,FONT_Screen,2);
	}
	else
	{
		IgnoreBonuses = TRUE;
		TAL_CostFlags_TS_PermBonus = 0;
		PrintScreen("������ ������ ����� �� ������",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_GoblinBerries()
{
	if(RandomGoblinBerries == TRUE)
	{
		RandomGoblinBerries = FALSE;
		PrintScreen("������������� ���������� ���� � ���������",-1,-1,FONT_Screen,3);
	}
	else
	{
		RandomGoblinBerries = TRUE;
		PrintScreen("��������� ���������� ���� � ���������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Apples()
{
	if(InfiniteApples == TRUE)
	{
		InfiniteApples = FALSE;
		PrintScreen("����������� ������ ����������",-1,-1,FONT_Screen,2);
	}
	else
	{
		InfiniteApples = TRUE;
		PrintScreen("������ ����������",-1,-1,FONT_Screen,2);
	};
	b_build_settings_diag();
};

func void StoryHelper_Helmets()
{
	if(Helmets_Enabled == TRUE)
	{
		PrintScreen("����� � ������� ����� ������� (��������)",-1,-1,FONT_Screen,3);
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
		PrintScreen("����� � ������� ���������",-1,-1,FONT_Screen,2);
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
		PrintScreen("������� �� ������ 2 ��� ������ ���������",-1,-1,FONT_Screen,3);
	}
	else
	{
		ClassicAlchemy = TRUE;
		PrintScreen("������� �� ������ 2 ��� ������ ��������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_AlternativeSmithing()
{
	if(AlternativeSmithing == TRUE)
	{
		AlternativeSmithing = FALSE;
		PrintScreen("�������������� �������� � ������� ���������",-1,-1,FONT_Screen,3);
	}
	else
	{
		AlternativeSmithing = TRUE;
		PrintScreen("�������������� �������� � ������� ��������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Log()
{
	if(NewLogEnabled == TRUE)
	{
		NewLogEnabled = FALSE;
		PrintScreen("����� ���������� ��������",-1,-1,FONT_Screen,3);
	}
	else
	{
		NewLogEnabled = TRUE;
		PrintScreen("����� ���������� �������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Skeletons()
{
	if(NoXPFromSummonedSkeletons == TRUE)
	{
		NoXPFromSummonedSkeletons = FALSE;
		PrintScreen("���� �� ����������� �������� �������",-1,-1,FONT_Screen,3);
	}
	else
	{
		NoXPFromSummonedSkeletons = TRUE;
		PrintScreen("���� �� ����������� �������� ��������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_HardMode()
{
	if(HardModeEnabled == TRUE)
	{
		HardModeEnabled = FALSE;
		PrintScreen("���������� ������� ��������� ��������",-1,-1,FONT_Screen,3);
		b_build_settings_diag();
	}
	else
	{
		HardModeEnabled = TRUE;
		PrintScreen("���������� ������� ��������� �������",-1,-1,FONT_Screen,3);
		Info_ClearChoices(StoryHelper_PatchSettings);
		Info_AddChoice(StoryHelper_PatchSettings,"-50% �����",StoryHelper_HardMode_50);
		Info_AddChoice(StoryHelper_PatchSettings,"-40% �����",StoryHelper_HardMode_40);
		Info_AddChoice(StoryHelper_PatchSettings,"-30% �����",StoryHelper_HardMode_30);
		Info_AddChoice(StoryHelper_PatchSettings,"-20% �����",StoryHelper_HardMode_20);
		Info_AddChoice(StoryHelper_PatchSettings,"-10% �����",StoryHelper_HardMode_10);
	};
};

func void StoryHelper_HardMode_10()
{
	HardModeXPModifier = 10;
	PrintScreen("���������� ���� ������ �� 10%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_HardMode_20()
{
	HardModeXPModifier = 20;
	PrintScreen("���������� ���� ������ �� 20%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_HardMode_30()
{
	HardModeXPModifier = 30;
	PrintScreen("���������� ���� ������ �� 30%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_HardMode_40()
{
	HardModeXPModifier = 40;
	PrintScreen("���������� ���� ������ �� 40%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_HardMode_50()
{
	HardModeXPModifier = 50;
	PrintScreen("���������� ���� ������ �� 50%",-1,YPOS_LOGENTRY,FONT_ScreenSmall,3);
	b_build_settings_diag();
};

func void StoryHelper_Penalties()
{
	if(PenaltiesAffectLearnCost == TRUE)
	{
		PenaltiesAffectLearnCost = FALSE;
		PrintScreen("������� ������� �� ��������� �������� ���������",-1,-1,FONT_Screen,3);
	}
	else
	{
		PenaltiesAffectLearnCost = TRUE;
		PrintScreen("������� ������� �� ��������� �������� ��������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_LehmarBook()
{
	if(ClassicLehmarBook == TRUE)
	{
		ClassicLehmarBook = FALSE;
		PrintScreen("����� ��������� ��������",-1,-1,FONT_Screen,3);
	}
	else
	{
		ClassicLehmarBook = TRUE;
		PrintScreen("����� ��������� ��� � ���������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Guildless()
{
	if(GuildlessMode == TRUE)
	{
		GuildlessMode = FALSE;
		PrintScreen("����������� ��� ������� ���������",-1,-1,FONT_Screen,3);
	}
	else
	{
		GuildlessMode = TRUE;
		PrintScreen("����������� ��� ������� ��������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_Addon()
{
	if(AddonDisabled == TRUE)
	{
		AddonDisabled = FALSE;
		PrintScreen("����������� ��� ������ ���������",-1,-1,FONT_Screen,3);
	}
	else
	{
		AddonDisabled = TRUE;
		PrintScreen("����������� ��� ������ ��������",-1,-1,FONT_Screen,3);
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
		PrintScreen("��������: ������������ ���� �� ������",-1,-1,FONT_Screen,3);
		b_build_settings_diag();
	}
	else
	{
		Info_ClearChoices(StoryHelper_PatchSettings);
		Info_AddChoice(StoryHelper_PatchSettings,Dialog_Back,StoryHelper_XP_Back);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 300 (����� 6)",StoryHelper_XP_6);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 250 (����� 5)",StoryHelper_XP_5);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 200 (����� 4)",StoryHelper_XP_4);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 150 (����� 3)",StoryHelper_XP_3);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 100 (����� 2)",StoryHelper_XP_2);
		Info_AddChoice(StoryHelper_PatchSettings,"XP_Ambient = 50  (����� 1)",StoryHelper_XP_1);
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
	PrintScreen("������ ������ ����� �� �����������",-1,40,FONT_Screen,3);
	PrintScreen("XP_Ambient = 300 (����� 6)",-1,45,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_5()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap5;
	PrintScreen("������ ������ ����� �� �����������",-1,40,FONT_Screen,3);
	PrintScreen("XP_Ambient = 250 (����� 5)",-1,45,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_4()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap4;
	PrintScreen("������ ������ ����� �� �����������",-1,40,FONT_Screen,3);
	PrintScreen("XP_Ambient = 200 (����� 4)",-1,45,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_3()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap3;
	PrintScreen("������ ������ ����� �� �����������",-1,40,FONT_Screen,3);
	PrintScreen("XP_Ambient = 150 (����� 3)",-1,45,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_2()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap2;
	PrintScreen("������ ������ ����� �� �����������",-1,40,FONT_Screen,3);
	PrintScreen("XP_Ambient = 100 (����� 2)",-1,45,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_XP_1()
{
	XP_Static = TRUE;
	XP_Ambient = XP_AmbientKap1;
	PrintScreen("������ ������ ����� �� �����������",-1,40,FONT_Screen,3);
	PrintScreen("XP_Ambient = 50 (����� 1)",-1,45,FONT_Screen,3);
	Info_ClearChoices(StoryHelper_PatchSettings);
	b_build_settings_diag();
};

func void StoryHelper_HonestStatCalculation()
{
	if(HonestStatCalculation == TRUE)
	{
		HonestStatCalculation = FALSE;
		PrintScreen("������ ��������� �������� ��� � ���������",-1,-1,FONT_Screen,3);
	}
	else
	{
		HonestStatCalculation = TRUE;
		PrintScreen("������� ������ ��������� �������� �������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_FullNPCRemoval()
{
	if(FullNPCRemoval == TRUE)
	{
		FullNPCRemoval = FALSE;
		PrintScreen("������ �������� NPC �� ���� ���������",-1,-1,FONT_Screen,3);
	}
	else
	{
		FullNPCRemoval = TRUE;
		PrintScreen("������ �������� NPC �� ���� ��������",-1,-1,FONT_Screen,3);
	};
	b_build_settings_diag();
};

func void StoryHelper_IceDragonSpell()
{
	Info_ClearChoices(StoryHelper_PatchSettings);
	Info_AddChoice(StoryHelper_PatchSettings,Dialog_Back,StoryHelper_IceDragonSpell_BACK);
	if(IceDragonSpell == SPL_InstantFireball)
	{
		Info_AddChoice(StoryHelper_PatchSettings,ConcatStrings(NAME_SPL_InstantFireball," (������������)"),StoryHelper_IceDragonSpell_InstantFireball);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,NAME_SPL_InstantFireball,StoryHelper_IceDragonSpell_InstantFireball);
	};
	if(IceDragonSpell == SPL_IceLance)
	{
		Info_AddChoice(StoryHelper_PatchSettings,ConcatStrings(NAME_SPL_IceLance," (������������)"),StoryHelper_IceDragonSpell_IceLance);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,NAME_SPL_IceLance,StoryHelper_IceDragonSpell_IceLance);
	};
	if(IceDragonSpell == SPL_ChargeZap)
	{
		Info_AddChoice(StoryHelper_PatchSettings,ConcatStrings(NAME_SPL_ChargeZap," (������������)"),StoryHelper_IceDragonSpell_ChargeZap);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,NAME_SPL_ChargeZap,StoryHelper_IceDragonSpell_ChargeZap);
	};
	if(IceDragonSpell == SPL_Icebolt)
	{
		Info_AddChoice(StoryHelper_PatchSettings,ConcatStrings(NAME_SPL_Icebolt," (������������)"),StoryHelper_IceDragonSpell_Icebolt);
	}
	else
	{
		Info_AddChoice(StoryHelper_PatchSettings,NAME_SPL_Icebolt,StoryHelper_IceDragonSpell_Icebolt);
	};
};

func void StoryHelper_IceDragonSpell_InstantFireball()
{
	IceDragonSpell = SPL_InstantFireball;
	PrintScreen(ConcatStrings("����� �������� �������: ",NAME_SPL_InstantFireball),-1,-1,FONT_Screen,3);
	StoryHelper_IceDragonSpell();
};

func void StoryHelper_IceDragonSpell_IceLance()
{
	IceDragonSpell = SPL_IceLance;
	PrintScreen(ConcatStrings("����� �������� �������: ",NAME_SPL_IceLance),-1,-1,FONT_Screen,3);
	StoryHelper_IceDragonSpell();
};

func void StoryHelper_IceDragonSpell_ChargeZap()
{
	IceDragonSpell = SPL_ChargeZap;
	PrintScreen(ConcatStrings("����� �������� �������: ",NAME_SPL_ChargeZap),-1,-1,FONT_Screen,3);
	StoryHelper_IceDragonSpell();
};

func void StoryHelper_IceDragonSpell_Icebolt()
{
	IceDragonSpell = SPL_Icebolt;
	PrintScreen(ConcatStrings("����� �������� �������: ",NAME_SPL_Icebolt),-1,-1,FONT_Screen,3);
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

