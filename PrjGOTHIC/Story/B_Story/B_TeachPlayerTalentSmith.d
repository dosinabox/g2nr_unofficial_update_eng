
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
		B_LogEntry(TOPIC_TalentSmith,"��� �������� �������� ���� ��� �� ����� ������� �������������� �������.");
	};
	if(waffe == WEAPON_1H_Special_01)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Special_01] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"��� �������� ������� ���� ��� ����� 1 ����� ����.");
	};
	if(waffe == WEAPON_2H_Special_01)
	{
		PLAYER_TALENT_SMITH[WEAPON_2H_Special_01] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"��� ���������� ������� ���� ��� ����� 2 ����� ����.");
	};
	if(waffe == WEAPON_1H_Special_02)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Special_02] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"��� ����������� ������� ���� ��� ����� 2 ����� ����.");
	};
	if(waffe == WEAPON_2H_Special_02)
	{
		PLAYER_TALENT_SMITH[WEAPON_2H_Special_02] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"��� �������� ���������� ������� ���� ��� ����� 3 ����� ����.");
	};
	if(waffe == WEAPON_1H_Special_03)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Special_03] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"��� ������� ������� ���� ��� ����� 3 ����� ����.");
	};
	if(waffe == WEAPON_2H_Special_03)
	{
		PLAYER_TALENT_SMITH[WEAPON_2H_Special_03] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"��� �������� ������� ������� ���� ��� ����� 4 ����� ����.");
	};
	if(waffe == WEAPON_1H_Special_04)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Special_04] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"��� ������� '������ ��������' ��� ����� 4 ����� ���� � 5 �������� ����� �������.");
	};
	if(waffe == WEAPON_2H_Special_04)
	{
		PLAYER_TALENT_SMITH[WEAPON_2H_Special_04] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"��� �������� ������� '������ ��������' ��� ����� 5 ������ ���� � 5 �������� ����� �������.");
	};
	if(waffe == WEAPON_1H_Harad_01)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Harad_01] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"������ � ���� �������� ���������� ���.");
	};
	if(waffe == WEAPON_1H_Harad_02)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Harad_02] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"������ � ���� �������� ���������� ������� ���.");
	};
	if(waffe == WEAPON_1H_Harad_03)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Harad_03] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"������ � ���� �������� ��������� ������.");
	};
	if(waffe == WEAPON_1H_Harad_04)
	{
		PLAYER_TALENT_SMITH[WEAPON_1H_Harad_04] = TRUE;
		B_LogEntry(TOPIC_TalentSmith,"����� ������� ��� ������ ����� '���-��������' - ������ �� ������ ������� � ����!");
	};
	if((Opened_Banditenaxt == TRUE) && (Knows_Banditenaxt == FALSE))
	{
		B_LogEntry(TOPIC_TalentSmith,"��� ����������� ������ ��� ����� 1 ����� ����, 3 ���� � 1 �������������� �������� ���������.");
		Knows_Banditenaxt = TRUE;
	};
	PrintScreen(PRINT_LearnSmith,-1,-1,FONT_Screen,2);
	return TRUE;
};

