
func int B_TeachPlayerTalentSmith(var C_Npc slf,var C_Npc oth,var int waffe)
{
	var int kosten;
	kosten = B_GetLearnCostTalent(oth,NPC_TALENT_SMITH,waffe);
	if(oth.lp < kosten)
	{
		PrintScreen(PRINT_NotEnoughLP,-1,-1,FONT_ScreenSmall,2);
		B_Say(slf,oth,"$NOLEARNNOPOINTS");
		return FALSE;
	};
	oth.lp -= kosten;
	if(Npc_GetTalentSkill(oth,NPC_TALENT_SMITH) == 0)
	{
		Npc_SetTalentSkill(oth,NPC_TALENT_SMITH,1);
		Log_CreateTopic(TOPIC_TalentSmith,LOG_NOTE);
		Log_AddEntry(TOPIC_TalentSmith,PRINT_LearnSmithLog);
	};
	if(waffe == WEAPON_Common)
	{
		PLAYER_TALENT_SMITH[WEAPON_Common] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"To forge a simple weapon, I don't need any special ingredients.");
	};
	if(waffe == WEAPON_1H_Special_01)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Special_01] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I need 1 ore nugget to forge an Ore Longsword.");
	};
	if(waffe == WEAPON_2H_Special_01)
	{
		PLAYER_TALENT_SMITH[WEAPON_2H_Special_01] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I need 2 ore nuggets to forge an Ore Two-Hander.");
	};
	if(waffe == WEAPON_1H_Special_02)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Special_02] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I need 2 ore nuggets to forge an Ore Bastard Sword.");
	};
	if(waffe == WEAPON_2H_Special_02)
	{
		PLAYER_TALENT_SMITH[WEAPON_2H_Special_02] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I need 3 ore nuggets to forge a Heavy Ore Two-Hander.");
	};
	if(waffe == WEAPON_1H_Special_03)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Special_03] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I need 3 ore nuggets to forge an Ore Battle Blade.");
	};
	if(waffe == WEAPON_2H_Special_03)
	{
		PLAYER_TALENT_SMITH[WEAPON_2H_Special_03] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I need 4 ore nuggets to forge an Heavy Ore Battle Blade.");
	};
	if(waffe == WEAPON_1H_Special_04)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Special_04] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "If I add 4 units of ore and 5 of dragon blood, I can forge an ORE DRAGON SLAYER.");
	};
	if(waffe == WEAPON_2H_Special_04)
	{
		PLAYER_TALENT_SMITH[WEAPON_2H_Special_04] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "If I add 5 units of ore and 5 of dragon blood, I can forge a LARGE ORE DRAGON SLAYER.");
	};
	if(waffe == WEAPON_1H_Harad_01)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Harad_01] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I can now forge a fine sword.");
	};
	if(waffe == WEAPON_1H_Harad_02)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Harad_02] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I can now forge a fine longsword.");
	};
	if(waffe == WEAPON_1H_Harad_03)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Harad_03] = TRUE;
		B_LogEntry (TOPIC_TalentSmith, "I can now forge even a ruby blade.");
	};
	if(waffe == WEAPON_1H_Harad_04)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Harad_04] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"Harad revealed me a secret of forging 'El Bastardo' - one of the finest blades in the world!");
	};
	if((Opened_Banditenaxt == TRUE) && (Knows_Banditenaxt == FALSE))
	{
		B_LogEntry(TOPIC_TalentSmith,"To forge a Bandit Axe I will need 1 lump of ore, 3 teeth and 1 additional steel billet.");
		Knows_Banditenaxt = TRUE;
	};
	PrintScreen(PRINT_LearnSmith,-1,-1,FONT_Screen,2);
	return TRUE;
};

