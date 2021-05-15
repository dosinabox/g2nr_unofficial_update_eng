
instance ItSe_XardasNotfallBeutel_MIS(C_Item)
{
	name = NAME_Bag;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_Bag.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	on_state[0] = Use_XardasNotfallBeutel;
	description = name;
	text[0] = "����� �������� �����.";
	text[1] = "������, ��� � ��� ���������";
	text[2] = "������� ������� � ��������.";
};


func void Use_XardasNotfallBeutel()
{
	B_PlayerFindItem(ItWr_XardasErmahnungFuerIdioten_MIS,1);
	B_PlayerFindItem(ItMi_InnosEye_Discharged_Mis,1);
	XardasDIBagOpened = TRUE;
};


instance ItWr_XardasErmahnungFuerIdioten_MIS(C_Item)
{
	name = "������ � ���������������� ��������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_XardasErmahnungFuerIdioten;
	scemeName = "MAP";
	description = name;
};


func void Use_XardasErmahnungFuerIdioten()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"��� ���� �������, �� ����� ����������� ����. ��� �� ��� ������� �� ������� � �� ����� ���� ������?");
	Doc_PrintLines(nDocID,0,"��� �������� ������ ���������, ��� � ����� ���������� ���� �������. � ��������� ������ ���� ������� �� ������� �������� ��� �� ��� � ��� �������� ����� ������� ���� �� ���� �������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"                      �������");
	Doc_Show(nDocID);
};


instance ItWr_Krypta_Garon(C_Item)
{
	name = "������ ������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Krypta_Garon;
	scemeName = "MAP";
	description = name;
	text[0] = "���������� ���������� �����.";
};


func void Use_Krypta_Garon()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"��� ����� ������. � ������ ������� �������� ������� �� ���� �����.");
	Doc_PrintLines(nDocID,0,"������� ��� ����������, ��� � ��� �����. �� ���-����� ���� ��� ��� �������� � ������ ������ �����.");
	Doc_PrintLines(nDocID,0,"������ ������� �� �������. ��������� ������� ������� ���������, ������ �� ���� �������� �� ���� ���������.");
	Doc_PrintLines(nDocID,0,"������ � ��� ������ �� ��� ��������������. � �� ���� ������, ��� ����� ������������, ��� ������, ��� ����� ����� ����.");
	Doc_PrintLines(nDocID,0,"� ����� ��� ������ � ���� ������. �� � �� ������, ������� �� ��� �������� � ����� �������. ������� � ���� ��� ������ � �������, ��� ���-������ ������ ��.");
	Doc_PrintLines(nDocID,0,"������. ������� ���� �������� ���������� �� ��������� ���. ������ ����� �� ���������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"�� ������ ����� ���� ����.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"                                 ����");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
};


instance ItKe_OrkKnastDI_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = "���� ���������� �����";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_EVT_UNDEAD_01(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = "���� ������";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_EVT_UNDEAD_02(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = "���� ��������";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_LastDoorToUndeadDrgDI_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = "���� ������� ����";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_LastDoorToUndeadDrgDI_MIS(C_Item)
{
	name = "������ ������� ����";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_ItWr_LastDoorToUndeadDrgDI_MIS;
	scemeName = "MAP";
	description = name;
};


func void Use_ItWr_LastDoorToUndeadDrgDI_MIS()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"�����");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���� �����");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���� ���� �������� ���� ����.");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
	if(Read_LastDoorToUndeadDrgDI_MIS == FALSE)
	{
		B_LogEntry(TOPIC_HallenVonIrdorath,"������ ������� ���� �������� ����� ����� ���� �����. ��� ������ �� �����-�� ���������� �������, �� ��� ���� ��� ������������ - � ��� ����� ���� ����?");
		Read_LastDoorToUndeadDrgDI_MIS = TRUE;
	};
};


instance ItKe_ChestMasterDementor_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = "���� �� ������� ������� ����";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Rezept_MegaDrink_MIS(C_Item)
{
	name = "������ '������� ��������'";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_RezeptFuerMegaTrank;
	scemeName = "MAP";
	description = name;
	text[0] = PRINT_RequiresAlchemyTalent;
};


func void Use_RezeptFuerMegaTrank()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"� ������ � ����� ������� ���������. �����, ������, �������� �� ������ ��� ����������.");
	Doc_PrintLines(nDocID,0,"���, �������� ������, ��������, ��� � ������ ���������� ���� ��� ������� � �����. ���� �� ������ �� �� ����� �� ����� ����� ��� ����� ��� ������, � �� ���������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,NAME_MegaDrink);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"10 ��������� ���, ���� �������� � ������� ������ ��������� � ������� ����.");
	Doc_PrintLines(nDocID,0,"��� ����� ����� ������� �� �������, ��������� ���������, � ���������� ����� �����������.");
	Doc_PrintLines(nDocID,0,"������������ ������� ����� ������������ � �������������. �� �������� �������� ��������� ��������� � ����� ������������ �������� �� ����.");
	Doc_Show(nDocID);
	if(Npc_IsPlayer(self))
	{
		if(Npc_GetTalentSkill(hero,NPC_TALENT_ALCHEMY) && (PLAYER_TALENT_ALCHEMY[POTION_MegaDrink] == FALSE))
		{
			B_LogEntry(TOPIC_TalentAlchemy,"����������� ��� '������� ��������': 10 ��������� ���, 1 ������ ��������� � 1 ����.");
			PLAYER_TALENT_ALCHEMY[POTION_MegaDrink] = TRUE;
		};
		Opened_MegaDrink = TRUE;
	};
};


instance ItWr_Diary_BlackNovice_MIS(C_Item)
{
	name = "�������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_03_04.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	text[0] = "������� ���������� ������� ����.";
	on_state[0] = Use_Diary_BlackNovice;
};


var int Use_Diary_BlackNovice_Once;

func void Use_Diary_BlackNovice()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Wood_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Wood_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"� ��� ���������� ��� ��� 36 ����. � ������� �����������, ��� ���� ������ ��������. �� � ������ ���, ��� ��� �������. � ����������� �� ��� ������� �� ����������.");
	Doc_PrintLines(nDocID,0,"������� �������� ��� ������� �������. � ��� �� ������ �����. ���� ��� � ������ ����� ���� � ��� �� ����, ����� ������ �������� ������ ����� ������.");
	Doc_PrintLines(nDocID,0,"��� ����, ��� � �� ����� ����������.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"� ������ � ������� ��� ��� ������-�����. � �� ���� ���������, ����� ����� �������. ���������, �������� �� ��� ������ ���, ����� � ����� ����� �� ���.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"����� � ������� �������. �� �������� ������� � ���� ������� � �������� ��� �� ����, ��� ���� ������ ��� ������������� � �������� ����� � ���������� �������. ���� ��� ������ ������! ������ � ��������� ������� � ���� ����...");
	Doc_Show(nDocID);
	if(Use_Diary_BlackNovice_Once == FALSE)
	{
		B_LogEntry(TOPIC_HallenVonIrdorath,"� �������� ���������� ������� ���� ����������� ������ � ��������, �������, ���������� �������������� � ����� ���� ���. � ������ ��������� ���, ������� �� ������ �������, ��� ����������, � ��� ���.");
		Use_Diary_BlackNovice_Once = TRUE;
	};
};


instance ItWr_ZugBruecke_MIS(C_Item)
{
	name = "������ ������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_ZugBruecke;
	scemeName = "MAP";
	description = name;
	text[0] = "�� ������� ������ �� ��������.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_ZugBruecke()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"   ��������� ��������������!");
	Doc_SetMargins(nDocID,-1,50,50,70,50,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���� �� ����������, ������� �� �������� ���� � ������ ������� ��� ���. ���� ��� ��������� ��� ������ - �� ��� ������������ ������ � ���.");
	Doc_PrintLines(nDocID,0,"� ��������� �������� ���� �������� �� ��� ���, ���� � �������� �����. � ���� � ������, ��� ���-�� �������� ������ ������������� ��� ������ ���� � ������, � ����� ������� ����� ������ �� ��������� ������!");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"                      �����");
	Doc_Show(nDocID);
};


instance ItMi_PowerEye(C_Item)
{
	name = "���� ����";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItMi_StoneOfKnowlegde_MIS.3ds";
	material = MAT_METAL;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = name;
};

