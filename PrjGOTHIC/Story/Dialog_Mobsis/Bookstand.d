
func void Use_Bookstand_01_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLine(nDocID,0,"��������� �����");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"���� ��������� ����� ����������� ���� ������� ������ ��������� ������, �� ����� �� �������, ��� �� ����������� ����� ������. ����, ������, �� ������ ��� ������� ����� ������� ����������� � ���� �� ���������� �� ����� �������, �� ������� ������ ��������� ����������� ����� ���������, � �� ���� ��� �� ����� �������� ��� � ����. �� ��������� ������ �� ������ ������ ��������� ������, �� ����� ����� ����������� ����� �����.");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"��� ��������� ������ ��������� ���� ������ ��������, ���� � �������� ����������. �������������, �� ������ ������ ��� ���������, ������ �� ������� ������ ��� ����� �� ����� ������� ������, ������ ��� ��� ����� ��������� ������� ������ ���� � �������������� � ���������� ����.");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"������ ���� ������ � ��� ���� � ����.");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLines(nDocID,1,"������ C����");
		Doc_Show(nDocID);
		if((hero.guild == GIL_NOV) && (KNOWS_FIRE_CONTEST == FALSE))
		{
			KNOWS_FIRE_CONTEST = TRUE;
			Log_CreateTopic(TOPIC_FireContest,LOG_MISSION);
			Log_SetTopicStatus(TOPIC_FireContest,LOG_Running);
			B_LogEntry(TOPIC_FireContest,"������ �����������, � ���� ����� ��������� ����������� ��������� �����. ������ �� ���� ����� ������� ������ ������ ���� ��� �������. ���� � ������ ��� ���������, � ���� ������ � ���� ����.");
		};
	};
};


var int FinalDragonEquipment_Once;

func void Use_FINALDRAGONEQUIPMENT_S1()
{
	var int nDocID;
	if(C_NpcIsHero(self))
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetFont(nDocID,-1,FONT_Book);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_PrintLines(nDocID,0,"... � �������, ��� ���� ����� ������� ���� �� ��������� �������. ������ ��������� ������, ��� �����, ��� �� ������ ���� ����� ��� �������������� �������. ��� �, ���� ��� ������ ��������� ��� ��������� ����� ������ ����, ����� ��� � �����. ��� �������� ������ ���������, ��� � ��� �������� ���������� �������, ����� ������������� � �����. ��� ������ ����� ������ ������ �������� ����� ����������, � ������ ��� ��������� � ���� ������������ ����, ����� ������� ������� � �������� �����.");
		if(hero.guild == GIL_KDF)
		{
			Doc_SetMargins(nDocID,-1,30,20,275,20,1);
			Doc_PrintLines(nDocID,1,"... � �������� ����������� � ������ ������� ������ ����� ������ ������ ������, ������� �� ������ �����. ������ ������ ��� ���������. � ����������, ��� ��� ���������� ���������� ������ ����������.");
			Doc_PrintLines(nDocID,1,"� ������� ��������� ���� ������ ��� ������� ���������. ���������� ����������� � ��� �� ��� ���, ���� �� ��������� ���������.");
			Doc_PrintLines(nDocID,1,"����� ������, ��������, ����� ������ ������ ���� � �������� �����. �� ������� ������ ��������� �� � ���� �� ����. � ����� ������ �� �����.");
			Doc_Show(nDocID);
			PlayerGetsAmulettOfDeath = TRUE;
			if(FinalDragonEquipment_Once == FALSE)
			{
				PLAYER_TALENT_RUNES[SPL_MasterOfDisaster] = TRUE;
				PrintScreen(PRINT_LearnRunes,-1,-1,FONT_Screen,4);
				Log_CreateTopic(TOPIC_TalentRunes,LOG_NOTE);
				B_LogEntry(TOPIC_TalentRunes,"����������� ��� ���� '������ ����': 1 ������ ����. ������ �� �����.");
			};
		}
		else if(hero.guild == GIL_PAL)
		{
			Doc_SetMargins(nDocID,-1,30,20,275,20,1);
			Doc_PrintLines(nDocID,1,"����� ������� ���������� �����, ���������� ������� ���� ������������. ��� ����� ��������� ������ ������ ������ � ��������� ��������� ������ ����. ��� ������ ���� ���� ����� ����������������� � �������.");
//			Doc_PrintLine(nDocID,1,"");
			Doc_PrintLines(nDocID,1,"������ � ������ ������, ��� ����� ������ - ������ ��, ��� ������� �������� ������������ � ����� ������� ������� '��������� ����'. ��� ��������, ��� ��� ������ ���� ��������� ����� ������� �������������� ���� ����������� ������.");
			Doc_Show(nDocID);
			PAL_KnowsAbout_FINAL_BLESSING = TRUE;
			if(FinalDragonEquipment_Once == FALSE)
			{
				PLAYER_TALENT_RUNES[SPL_PalTeleportSecret] = TRUE;
				PrintScreen(PRINT_LearnPalTeleportSecret,-1,-1,FONT_Screen,4);
				Log_CreateTopic(TOPIC_TalentRunes,LOG_NOTE);
				B_LogEntry(TOPIC_TalentRunes,"��� �������� ���� ���������� ������������� �����������. ��� ������ ���� ������������ � ������� ������� �����, ����� ������� ���� �� ������ �����.");
				Log_AddEntry(TOPIC_TalentRunes,"����������� ��� ���� '��������� ��������': 1 ������ ����.");
			};
		}
		else
		{
			Doc_SetMargins(nDocID,-1,30,20,275,20,1);
			Doc_PrintLines(nDocID,1,"������ ���������� ��������.");
			Doc_PrintLines(nDocID,1,"����� ������� ������� �� ����� ������� ����������� ��������, ������� ����� ������� �����, ������� � ������ �� ������� �������.");
			Doc_PrintLine(nDocID,1,"");
			Doc_PrintLines(nDocID,1,"����� ���������� ���, ��������� ���������� ��������, ���� ��� ������ ���� ������� � ��������� �����. 5 �������� ����� ����� ������� ����� ��������������� ������� � ���������.");
			Doc_PrintLine(nDocID,1,"");
			Doc_PrintLines(nDocID,1,"����������: '�������' �������� ������������� ��������� �������� '�������'.");
			Doc_Show(nDocID);
			PlayergetsFinalDJGArmor = TRUE;
			if(FinalDragonEquipment_Once == FALSE)
			{
				if(Npc_GetTalentSkill(self,NPC_TALENT_SMITH) == 0)
				{
					Npc_SetTalentSkill(self,NPC_TALENT_SMITH,1);
					Log_CreateTopic(TOPIC_TalentSmith,LOG_NOTE);
					B_LogEntry(TOPIC_TalentSmith,PRINT_LearnSmithLog);
				};
				PLAYER_TALENT_SMITH[WEAPON_1H_Special_04] = TRUE;
				PLAYER_TALENT_SMITH[WEAPON_2H_Special_04] = TRUE;
				PrintScreen(PRINT_LearnSmith,-1,-1,FONT_Screen,4);
				B_LogEntry(TOPIC_TalentSmith,"���� � ������� 4 ����� ���� � 5 �������� ��������� �����, �� ����� �������� ������ ������ '������ ��������'.");
				Log_AddEntry(TOPIC_TalentSmith,"���� � ������� 5 ������ ���� � 5 �������� ��������� �����, �� ����� �������� ������� ������ ������ '������ ��������'.");
			};
		};
		if(FinalDragonEquipment_Once == FALSE)
		{
			B_GivePlayerXP(XP_FinalDragonEquipment);
			FinalDragonEquipment_Once = TRUE;
		};
	};
};

