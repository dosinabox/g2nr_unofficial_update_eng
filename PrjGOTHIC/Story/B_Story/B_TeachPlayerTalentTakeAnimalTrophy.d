
func int B_TeachPlayerTalentTakeAnimalTrophy(var C_Npc slf,var C_Npc oth,var int trophy)
{
	var int kosten;
	if((trophy == TROPHY_Fur) || (trophy == TROPHY_ReptileSkin))
	{
		kosten = B_GetLearnCostTalent(oth,NPC_TALENT_TAKEANIMALFUR,trophy);
	}
	else
	{
		kosten = B_GetLearnCostTalent(oth,NPC_TALENT_TAKEANIMALTROPHY,trophy);
	};
	if(oth.lp < kosten)
	{
		PrintScreen(PRINT_NotEnoughLP,-1,-1,FONT_ScreenSmall,2);
		B_Say(slf,oth,"$NOLEARNNOPOINTS");
		return FALSE;
	};
	oth.lp -= kosten;
	Log_CreateTopic(TOPIC_TalentAnimalTrophy,LOG_NOTE);
	Log_AddEntry(TOPIC_TalentAnimalTrophy,"Now I can:");
	if(trophy == TROPHY_Teeth)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Teeth] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove teeth from dead animals.");
	};
	if(trophy == TROPHY_Claws)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Claws] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove claws from dead animals.");
	};
	if(trophy == TROPHY_Fur)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Fur] = TRUE;
		Npc_SetTalentSkill(oth,NPC_TALENT_TAKEANIMALFUR,1);
		PrintScreen(PRINT_LearnTakeAnimalFur,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove fur from dead animals.");
	};
	if(trophy == TROPHY_ReptileSkin)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ReptileSkin] = TRUE;
		Npc_SetTalentSkill(oth,NPC_TALENT_TAKEANIMALFUR,1);
		PrintScreen(PRINT_LearnTakeAnimalFur,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove skin from reptiles.");
	};
	if(trophy == TROPHY_Heart)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Heart] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove heart from dead golems and dead demons.");
	};
	if(trophy == TROPHY_ShadowHorn)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_ShadowHorn] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"....remove horn from dead shadowbeasts.");
	}
	if(trophy == TROPHY_FireTongue)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_FireTongue] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove tongue from dead fire lizards.");
	};
	if(trophy == TROPHY_BFWing)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFWing] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove wings from dead bloodflies.");
	};
	if(trophy == TROPHY_BFSting)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_BFSting] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove sting from dead bloodflys.");
	};
	if(trophy == TROPHY_Mandibles)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_Mandibles] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove mandibles from dead animals.");
	};
	if(trophy == TROPHY_CrawlerPlate)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_CrawlerPlate] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove plates from dead minecrawler..");
	};
	if(trophy == TROPHY_DrgSnapperHorn)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DrgSnapperHorn] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove horn from dead dragon snapper.");
	};
	if(trophy == TROPHY_DragonScale)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DragonScale] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		if(CurrentLevel == OLDWORLD_ZEN)
		{
			CreateInvItems(SwampDragon,ItAt_DragonScale,12);
			CreateInvItems(RockDragon,ItAt_DragonScale,12);
			CreateInvItems(FireDragon,ItAt_DragonScale,12);
			CreateInvItems(IceDragon,ItAt_DragonScale,12);
		}
		else
		{
			DragonScaleLearnedOutsideOW = TRUE;
		};
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...remove dragon scales from the hide of dead dragons.");
	};
	if(trophy == TROPHY_DragonBlood)
	{
		PLAYER_TALENT_TAKEANIMALTROPHY[TROPHY_DragonBlood] = TRUE;
		Npc_SetTalentSkill(hero,NPC_TALENT_TAKEANIMALTROPHY,1);
		if(CurrentLevel == OLDWORLD_ZEN)
		{
			CreateInvItems(SwampDragon,ItAt_DragonBlood,2);
			CreateInvItems(RockDragon,ItAt_DragonBlood,2);
			CreateInvItems(FireDragon,ItAt_DragonBlood,2);
			CreateInvItems(IceDragon,ItAt_DragonBlood,2);
		}
		else
		{
			DragonBloodLearnedOutsideOW = TRUE;
		};
		PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
		B_LogEntry(TOPIC_TalentAnimalTrophy,"...collect the blood from a dead dragon.");
	};
//	PrintScreen(PRINT_LearnTakeAnimalTrophy,-1,-1,FONT_Screen,2);
//	Npc_SetTalentSkill(oth,NPC_TALENT_TAKEANIMALFUR,1);
	return TRUE;
};

