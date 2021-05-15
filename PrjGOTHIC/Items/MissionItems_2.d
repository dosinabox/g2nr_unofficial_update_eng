
instance ItMi_StoneOfKnowlegde_MIS(C_Item)
{
	name = "������ ������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 0;
	visual = "ItMi_StoneOfKnowlegde_MIS.3DS";
	material = MAT_METAL;
	scemeName = "SDW";
	description = name;
};

instance ItWr_PaladinLetter_MIS(C_Item)
{
	name = "������ ������� ����� ������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UsePaladinLetter;
	scemeName = "MAP";
	description = name;
};


func void UsePaladinLetter()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"���� �����!");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���������� � ������ �������� ����������� ��������. �� ������� �������� ������. ��, ���� ������� ������, ������� � �����, ���������� ������.");
	Doc_PrintLines(nDocID,0,"�� ������������ ������������ ��������� ��������. ��� ���������� ����� ������ �����. �������, � ������� ������ �� ������ ������������ �� �������� ������������. ���� �������� ������ �� �� ������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"�� ������� ��� �����.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"������");
	Doc_Show(nDocID);
};


instance ItWr_LetterForGorn_MIS(C_Item)
{
	name = "��������� ������� �����";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseLetterForGorn;
	scemeName = "MAP";
	description = name;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UseLetterForGorn()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"����!");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"������ ���������� ���������� ���� - �� 1000 �������.");
	Doc_PrintLines(nDocID,0,"��� ��� ���� � ���� ���� ���-�� ������������ ���������, ����� ����� ������� �� ����.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"������");
	Doc_Show(nDocID);
};


instance ItKe_PrisonKey_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "��� ���� �� ������� � �����.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_OC_Store(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "��� ���� �� ������ � �����.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ITKE_ErzBaronFlur(C_Item)
{
	name = "���� �� ������ �����";
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "�� ��� ������������� ���:";
	text[1] = "�����.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ITKE_ErzBaronRaum(C_Item)
{
	name = "���� �� ������ �����";
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "�� ��� ������������� ���:";
	text[1] = "�����.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItMi_GornsTreasure_MIS(C_Item)
{
	name = NAME_Beutel;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 250;
	visual = "ItMi_Pocket_Mis.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = UseGornsTreasure;
	description = name;
	text[0] = PRINT_Pocket_MIS;
	text[1] = "� ������ '����'.";
	text[2] = PRINT_Pocket_300;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseGornsTreasure()
{
	B_PlayerFindItem(ItMi_Gold,250);
	Gorns_Beutel = TRUE;
};


instance ItWr_Silvestro_MIS(C_Item)
{
	name = "������� ����������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseItwr_Silvestro;
	scemeName = "MAP";
	description = name;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UseItwr_Silvestro()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"�� ������������ �������� ����������");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"��� ���� ��� ���� ���� ��������. ������� �� ���������� ��������� ����� ����� � ���������� ������ � �����.");
	Doc_PrintLines(nDocID,0,"� ���� ��������� ������������, ������� � ����������� �������� ����.");
	Doc_PrintLines(nDocID,0,"����� ������������ �� ���, ��� ������ ������������� �����. � �������� �������� ���. �� ��������� ����� � ���������� ����� - �� � �� ������� ��� ����� ������.");
	Doc_PrintLines(nDocID,0,"��� ���� ����� ��������� �� ��� �� �� �� �����, ������� � ��������� � ����� ���� �������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"�� ����������� ������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"����������");
	Doc_Show(nDocID);
	if((MIS_ScoutMine == LOG_Running) && Npc_IsDead(DiegoOW) && !Npc_KnowsInfo(other,DIA_DiegoOw_Beweise) && (Silvestro_Ore == FALSE))
	{
		B_LogEntry(TOPIC_ScoutMine,"����� ���������� � ���������� ����� ����, ������� ����������� ����������. ����� ��������� ����� �� ����� ������ ��������. ����� �� �����.");
	};
	Silvestro_Ore = TRUE;
};


instance ItAt_ClawLeader(C_Item)
{
	name = "�����";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 100;
	visual = "ItAt_ClawLeader.3DS";
	material = MAT_LEATHER;
	description = name;
	text[0] = "����� ������ ���� ���������.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItSe_Olav(C_Item)
{
	name = NAME_Beutel;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 25;
	visual = "ItMi_Pocket_Mis.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = UseOlav;
	description = name;
	text[0] = PRINT_Pocket_MIS;
	text[1] = "� ������ '����'.";
	text[2] = PRINT_Pocket_25;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseOlav()
{
	B_PlayerFindItem(ItMi_Gold,25);
};


/*instance ItMi_GoldPlate_MIS(C_Item)
{
	name = "������� �������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_GoldPlate;
	visual = "ItMi_GoldPlate.3DS";
	material = MAT_METAL;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};*/

instance ItKe_Pass_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_04.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "���� ��������� ������";
	text[1] = "��������� ������ �������.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 190;
};

instance ItKe_Bromor(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "���� �� ������� � �������.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_Rune_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "������, � �������� ��������";
	text[1] = "���� ����, ��������� ��� ������.";
	text[2] = "� ��� ����� ������ ������.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Bloody_MIS(C_Item)
{
	name = "������� ��������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseBloodMIS;
	scemeName = "MAP";
	description = name;
	text[0] = "�� �������� ���.";
};


func void UseBloodMIS()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���� �������� ��� �������� ����������� ��, � �� ���� ������� � ������� ��� �� ������� ��� � ����.");
	Doc_PrintLines(nDocID,0,"���� ������ �� �� ������� ���������� ���������� ���� � ��� ���������.");
	Doc_PrintLines(nDocID,0,"���� ���������� ��������� ��������� ������ ����� �� ������� �� ���������.");
	Doc_PrintLines(nDocID,0,"������� ���� ���������. ����� ����������� ����� ������ �����.");
	Doc_PrintLines(nDocID,0,"������������ ��� ������� �������� �������� ��������� ����������.");
	Doc_PrintLines(nDocID,0,"������, �� �������� ������������ �������� ���������� ��������������� � ���� �������� ����������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"�������");
	Doc_Show(nDocID);
	if(Knows_Bloodfly == FALSE)
	{
		PrintScreen(PRINT_ADDON_KNOWSBF,-1,-1,FONT_Screen,2);
		Log_CreateTopic(Topic_Bonus,LOG_NOTE);
		B_LogEntry(Topic_Bonus,PRINT_KnowsBloodfly);
		Knows_Bloodfly = TRUE;
		B_GivePlayerXP(XP_Ambient);
	};
};


instance ItWr_Pfandbrief_MIS(C_Item)
{
	name = "���������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UsePfandbrief;
	scemeName = "MAP";
	description = name;
};


func void UsePfandbrief()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"� �������� �������� ��������� ����� ����������� �����, ��������� �������� ����� ����� �����.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"�����: ����������������� ������� ����� �� ��������� �������� ������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"���������:");
	Doc_PrintLine(nDocID,0,"������, ��������");
	Doc_PrintLine(nDocID,0,"�����, ���������");
	Doc_Show(nDocID);
};


instance ItWr_Map_OldWorld_Oremines_MIS(C_Item)
{
	name = "����� �������� �������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 50;
	visual = "ItWr_Map_OW.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_OldWorld_Oremines;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Map_OldWorld_Oremines()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_OldWorld_Oremines_MIS);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_OldWorld_Oremines.tga",TRUE);
	Doc_SetLevel(Document,"OldWorld\OldWorld.zen");
	Doc_SetLevelCoords(Document,-78500,47500,54000,-53000);
	Doc_Show(Document);
};


instance ItWr_Map_OldWorld_Oremines_Small_MIS(C_Item)
{
	name = "����� �������� �������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 50;
	visual = "ItWr_Map_OW_Small.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_OldWorld_Oremines_Small;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Map_OldWorld_Oremines_Small()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_OldWorld_Oremines_Small_MIS);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_OldWorld_Oremines_Small.tga",TRUE);
	Doc_SetLevel(Document,"OldWorld\OldWorld.zen");
	Doc_SetLevelCoords(Document,-78500,47500,54000,-53000);
	Doc_Show(Document);
};


var int Manowar_Once;

instance ItWr_Manowar(C_Item)
{
	name = "����� �����";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = UseManowar;
	description = name;
};


func void UseManowar()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���� ��������");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"�� �������� ��� ��������");
	Doc_PrintLines(nDocID,0,"����� ������ �� ���� � ����� ��������");
	Doc_PrintLines(nDocID,0,"� ���� ����, ��� ������� �� ���� ����");
	Doc_PrintLines(nDocID,0,"��� � ���� ������ ����� ��� �����");
	Doc_PrintLines(nDocID,0,"��� ������ ������ ������ ���");
	Doc_PrintLines(nDocID,0,"��� ��� ������ � ���� �� �����");
	Doc_PrintLines(nDocID,0,"�����, ��� ������������ ���");
	Doc_PrintLines(nDocID,0,"����� �� ���� ����");
	Doc_PrintLines(nDocID,0,"���� � ���� ������");
	Doc_Show(nDocID);
	if(Manowar_Once == FALSE)
	{
		B_GivePlayerXP(200);
		Manowar_Once = TRUE;
	};
};


instance ItWr_KDWLetter(C_Item)
{
	name = "���������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseKDWLetter;
	scemeName = "MAP";
	description = name;
	text[0] = "�� ���������� ������ � ������ ��������.";
};


func void UseKDWLetter()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"�� �������� ������. ������, ����� ������ ���, �� ���������� �� ������ ������ ����������. ��������, ��� �� ������ ������ �� �������, ������� �� �������� ������� ������ ���. ������ ������� ������, ���� �������� ��� ��� ����.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"�� �������� � ���� ������.");
	Doc_PrintLine(nDocID,0,"�������");
	Doc_Show(nDocID);
};


instance ItWr_GilbertLetter(C_Item)
{
	name = "�������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseGilbertLetter;
	scemeName = "MAP";
	description = name;
	text[0] = "�� ������ � ������ ��������.";
};


func void UseGilbertLetter()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"� ���� ������. � ����� ��������� �����. � ���� ����� ����� - ������, �������, ���.");
	Doc_PrintLines(nDocID,0,"���� �� ���-�� ����� ������ ���� ������. ���� ��� ������� ��� ������ � ��� ��� ������� ������. ������ ����� ������������ �����.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"�������");
	Doc_Show(nDocID);
};


instance ItRi_HP_01_Tengron(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING;
	value = Value_Ri_Hp;
	visual = "ItRi_Hp_01.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Hp_01;
	on_unequip = UnEquip_ItRi_Hp_01;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = NAME_ADDON_CASSIASBELOHNUNGSRING;
	text[0] = "��� ������ ����������� ��������.";
	text[2] = NAME_Bonus_HpMax;
	count[2] = Ri_Hp;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};

