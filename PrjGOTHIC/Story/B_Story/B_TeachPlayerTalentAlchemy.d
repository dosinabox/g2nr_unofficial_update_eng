
func int B_TeachPlayerTalentAlchemy(var C_Npc slf,var C_Npc oth,var int potion)
{
	var int kosten;
	kosten = B_GetLearnCostTalent(oth,NPC_TALENT_ALCHEMY,potion);
	if(oth.lp < kosten)
	{
		PrintScreen(PRINT_NotEnoughLP,-1,-1,FONT_ScreenSmall,2);
		B_Say(slf,oth,"$NOLEARNNOPOINTS");
		return FALSE;
	};
	oth.lp -= kosten;
	Log_CreateTopic(TOPIC_TalentAlchemy,LOG_NOTE);
	B_LogEntry(TOPIC_TalentAlchemy,"To brew a potion I need an empty laboratory flask and the ingredients required to make the potion. Using these ingredients on the alchemist's bench I can prepare the desired potion.");
	if(potion == POTION_Health_01)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Health_01] = TRUE;
		B_LogEntry(TOPIC_TalentAlchemy,"Ingredients for 'ESSENCE OF HEALING':2 Healing Plants and 1 Meadow Knotweed.");
	};
	if(potion == POTION_Health_02)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Health_02] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'EXTRACT OF HEALING':2 Healing Herbs and 1 Meadow Knotweed.");
	};
	if(potion == POTION_Health_03)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Health_03] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'ELIXIR OF HEALING´:2 Healing Roots and 1 Meadow Knotweed.");
	};
	if(potion == POTION_Mana_01)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Mana_01] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'MANA ESSENCE': 2 Fire Nettles and 1 Meadow Knotweed.");
	};
	if(potion == POTION_Mana_02)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Mana_02] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'MANA EXTRACT': 2 Fireweed and 1 Meadow Knotweed.");
	};
	if(potion == POTION_Mana_03)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Mana_03] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'MANA ELIXIR':2 Fire Roots and 1 Meadow Knotweed");
	};
	if(potion == POTION_Speed)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Speed] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'SPEED POTION': 1 Snapperweed and 1 Meadow Knotweed");
	};
	if(potion == POTION_Perm_STR)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Perm_STR] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'ELIXIR OF STRENGTH':1 Dragonroot and 1 King's Sorrel.");
	};
	if(potion == POTION_Perm_DEX)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Perm_DEX] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'ELIXIR OF DEXTERITY': 1 Goblin Berries and 1 King's Sorrel.");
	};
	if(potion == POTION_Perm_Mana)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Perm_Mana] = TRUE;
		B_LogEntry (TOPIC_TalentAlchemy, "Ingredients for 'ELIXIR OF SPIRIT':1 Fire Root and 1 King's Sorrel.");
	};
	if(potion == POTION_Perm_Health)
	{
		PLAYER_TALENT_ALCHEMY[POTION_Perm_Health] = TRUE;
		B_LogEntry(TOPIC_TalentAlchemy,"Ingredients for 'ELIXIR OF LIFE': 1 Healing Root and 1 King's Sorrel");
	};
	if((Opened_LousHammer == TRUE) && (Knows_LousHammer == FALSE))
	{
		B_LogEntry(TOPIC_TalentAlchemy,"Ingredients for 'LOU's Hammer': 1 Water, 2 Turnips, 1 Swampweed, 1 Tooth from Swampshark and 1 rum.");
		Knows_LousHammer = TRUE;
	};
	if((Opened_Schlafhammer == TRUE) && (Knows_Schlafhammer == FALSE))
	{
		B_LogEntry(TOPIC_TalentAlchemy,"Ingredients for 'LOU's DOUBLE HAMMER': 1 'LOU's Hammer' and 1 rum.");
		Knows_Schlafhammer = TRUE;
	};
	if((Opened_SchnellerHering == TRUE) && (Knows_SchnellerHering == FALSE))
	{
		B_LogEntry(TOPIC_TalentAlchemy,"Ingredients for 'HASTY HERRING': 1 Water, 1 Rum, 1 Fish and 1 Snapperweed.");
		Knows_SchnellerHering = TRUE;
	};
	if((Opened_MushroomMana == TRUE) && (Knows_MushroomMana == FALSE))
	{
		B_LogEntry(TOPIC_TalentAlchemy,"Ingredients for 'MUSHROOM EXTRACT': 50 Dark Mushrooms and 1 Meadow Berry.");
		Knows_MushroomMana = TRUE;
	};
	if((Opened_MegaDrink == TRUE) && (PLAYER_TALENT_ALCHEMY[POTION_MegaDrink] == FALSE))
	{
		B_LogEntry(TOPIC_TalentAlchemy,"Ingredients for 'EMBARLA FIGASTRO': 10 Dragon Eggs, 1 Black Peark and 1 Sulfur.");
		PLAYER_TALENT_ALCHEMY[POTION_MegaDrink] = TRUE;
	};
	PrintScreen(PRINT_LearnAlchemy,-1,-1,FONT_Screen,2);
	Npc_SetTalentSkill(oth,NPC_TALENT_ALCHEMY,1);
	return TRUE;
};

