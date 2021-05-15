
const int AM_EyeProtEdge = 10;
const int AM_EyeProtPoint = 10;
const int AM_EyeProtMage = 20;
const int AM_EyeProtFire = 30; //20

instance ItMi_InnosEye_MIS(C_Item)
{
	name = NAME_InnosEye;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = 0;
	visual = "ItMi_InnosEye_MIS.3DS";
	material = MAT_METAL;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = name;
	on_equip = Equip_InnosEye;
	on_unequip = UnEquip_InnosEye;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
	text[0] = "���� ���������� ��������.";
	text[1] = NAME_Prot_Edge;
	count[1] = AM_EyeProtEdge;
	text[2] = NAME_Prot_Point;
	count[2] = AM_EyeProtPoint;
	text[3] = NAME_Prot_Fire;
	count[3] = AM_EyeProtFire;
	text[4] = NAME_Prot_Magic;
	count[4] = AM_EyeProtMage;
};


func void Equip_InnosEye()
{
	Wld_PlayEffect("spellFX_Innoseye",self,self,0,0,0,FALSE);
	Wld_PlayEffect("spellFX_LIGHTSTAR_RED",self,self,0,0,0,FALSE);
	Wld_PlayEffect("FX_EarthQuake",self,self,0,0,0,FALSE);
	AI_PlayAni(self,"T_MAGRUN_2_HEASHOOT");
	AI_Standup(self);
	Snd_Play("SFX_INNOSEYE");
	self.protection[PROT_EDGE] += AM_EyeProtEdge;
	self.protection[PROT_BLUNT] += AM_EyeProtEdge;
	self.protection[PROT_POINT] += AM_EyeProtPoint;
	self.protection[PROT_FIRE] += AM_EyeProtFire;
	self.protection[PROT_MAGIC] += AM_EyeProtMage;
	SC_IsWearingInnosEye = TRUE;
};

func void UnEquip_InnosEye()
{
	self.protection[PROT_EDGE] -= AM_EyeProtEdge;
	self.protection[PROT_BLUNT] -= AM_EyeProtEdge;
	self.protection[PROT_POINT] -= AM_EyeProtPoint;
	self.protection[PROT_FIRE] -= AM_EyeProtFire;
	self.protection[PROT_MAGIC] -= AM_EyeProtMage;
	SC_IsWearingInnosEye = FALSE;
};


instance ItMi_InnosEye_Discharged_Mis(C_Item)
{
	name = NAME_InnosEye;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = 0;
	visual = "ItMi_InnosEye_Discharged_MIS.3DS";
	material = MAT_METAL;
	description = name;
	on_equip = Equip_ItMi_InnosEye_Discharged_Mis;
	text[0] = "���� ����� � �� �����.";
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItMi_InnosEye_Discharged_Mis()
{
	Wld_PlayEffect("spellFX_Fear",self,self,0,0,0,FALSE);
	Snd_Play("MFX_FEAR_CAST");
};


instance ItMi_InnosEye_Broken_Mis(C_Item)
{
	name = NAME_InnosEye;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = 0;
	visual = "ItMi_InnosEye_Broken_MIS.3DS";
	material = MAT_METAL;
	description = name;
	on_equip = Equip_ItMi_InnosEye_Broken_Mis;
	text[0] = TEXT_Innoseye_Setting;
	text[1] = TEXT_Innoseye_Gem;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItMi_InnosEye_Broken_Mis()
{
	Wld_PlayEffect("spellFX_Fear",self,self,0,0,0,FALSE);
	Snd_Play("MFX_FEAR_CAST");
};


instance ItWr_PermissionToWearInnosEye_MIS(C_Item)
{
	name = "������ ��� ��������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_PermissionToWearInnosEye;
	scemeName = "MAP";
	description = name;
	text[0] = "� ������������� ����������.";
};


func void Use_PermissionToWearInnosEye()
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
	Doc_PrintLines(nDocID,0,"������������ ����� ��������� �������� ����� ����� � ��������� ���� ���������.");
	Doc_PrintLines(nDocID,0,"��� ���������, ���������� �������� ������ ������ ������ ����������� ����������.");
	Doc_PrintLines(nDocID,0,"������������� ������� ������� �������������� ���������� ���� ���� ������� � �������� ���������� ����� ������� � ������������� ������, � ����� �������� ������� � ���������� ������ ������ �� 2 ���� �� ����.");
	Doc_PrintLines(nDocID,0,"� �� ���� ������ ������� ���������� ���������� � ������ ���������������� ���������� ���� ��������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"�� ������ ����� ������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"        ���� �����");
	Doc_Show(nDocID);
};


instance ItWr_XardasBookForPyrokar_Mis(C_Item)
{
	name = "������� ��������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_03_03.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = Use_XardasBookForPyrokar;
};


func void Use_XardasBookForPyrokar()
{
	Print(PRINT_IrdorathBookDoesntOpen);
	Wld_PlayEffect("spellFX_Fear",self,self,0,0,0,FALSE);
	Snd_Play("MFX_FEAR_CAST");
};


instance ItKe_CHEST_SEKOB_XARDASBOOK_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "���� �� ������� �� ����� ������.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_CorneliusTagebuch_Mis(C_Item)
{
	name = "������� ����������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_01.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = UseCorneliusTagebuch;
};


func void UseCorneliusTagebuch()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Brown_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Brown_R.tga",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���� ������ ����� ���������� � ��� �� ����, ��� �������� ������ ����������� ���� ������ �����.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���-�� �������� ��������� �� ���� ������� �����. ��� ����� ����� ���� �� ���� ������ � ������ ���������, � ������� ����� ������� ������ ��������� �����. � �� �����-�� ���������, ���� �������� �� ��, ���, ��� �������, ��� - ���� ���. ��� ���� �����-���� �������� ����. �� ����� ��� ��������� � ������������� � ����.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"�� ��������� ��� 20000 ������� �� ��, ����� ���� �� ��������� ��� �������. �� ������, ��� � �����, ��� �� ���� � ����, ����� ��� ����������.");
	Doc_PrintLines(nDocID,1,"������� ��, � ����������. ��� �������� ��� ����� �� ����������� ������ ������. ���� �� �� ���, � ���� ��� ���� �� ������. � ��� ������ �������� ��� �������� ��������� ��������.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"��� ��������� - ���� �� ��������� ��� ���������. �������� ��� ����� ����� ������.");
	Doc_Show(nDocID);
	if(Cornelius_IsLiar == FALSE)
	{
		B_LogEntry(TOPIC_RescueBennet,"���� ������� - ��������������, ����������� ��� ������������� ������������ �������.");
		Cornelius_IsLiar = TRUE;
	};
};


instance ITWR_DementorObsessionBook_MIS(C_Item)
{
	name = "�������� ���������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_03_05.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = Use_DementorObsessionBook;
};


func void Use_DementorObsessionBook()
{
	var int nDocID;
	Wld_PlayEffect("spellFX_Fear",hero,hero,0,0,0,FALSE);
	Snd_Play("MFX_FEAR_CAST");
	SC_ObsessionCounter = 100;
	B_SCIsObsessed(hero);
	if(hero.guild == GIL_KDF)
	{
		nDocID = Doc_Create();
		Doc_SetPages(nDocID,2);
		Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
		Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
		Doc_SetMargins(nDocID,0,275,20,30,20,1);
		Doc_SetFont(nDocID,0,FONT_Book);
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"edef Kon dirandorix");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"in Sparady bell");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"el utoy");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"Kho ray xaondron");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLines(nDocID,0,"em piratoram endro");
		Doc_SetMargins(nDocID,-1,30,20,275,20,1);
		Doc_SetFont(nDocID,1,FONT_Book);
		Doc_PrintLine(nDocID,1,"");
		Doc_PrintLine(nDocID,1,"");
		if(Kapitel >= 3)
		{
			if(Vino_isAlive_Kap3 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"           ����");
			};
			if(Fernando_isAlive_Kap3 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"��������");
			};
			if(Malak_isAlive_Kap3 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"        �����");
			};
			if(Bromor_isAlive_Kap3 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"������");
			};
		};
		if(Kapitel >= 4)
		{
			if(Engrom_isAlive_Kap4 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"    ������");
				Doc_PrintLine(nDocID,1,"");
			};
			if(Randolph_isAlive_preKap4 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"        ��������");
			};
			Doc_PrintLine(nDocID,1,"");
		};
		if(Kapitel >= 5)
		{
			Doc_PrintLine(nDocID,1,"");
			if(Sekob_isAlive_Kap5 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"�����");
			};
			Doc_PrintLine(nDocID,1,"");
			Doc_PrintLine(nDocID,1,"");
			if(Brutus_isAlive_preKap5 == TRUE)
			{
				Doc_PrintLine(nDocID,1,"");
				Doc_PrintLine(nDocID,1,"            ������");
			};
			Doc_PrintLine(nDocID,1,"");
		};
		if((Kapitel == 6) && (Mario_IsOnBoard == LOG_SUCCESS) && (OrkSturmDI == TRUE))
		{
			Doc_PrintLine(nDocID,1,"");
			Doc_PrintLine(nDocID,1,"�����");
		};
		Doc_Show(nDocID);
	};
};


instance ItWr_PyrokarsObsessionList(C_Item)
{
	name = "���������� ������ ��������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_PyrokarsObsessionList;
	scemeName = "MAP";
	description = name;
};


func void Use_PyrokarsObsessionList()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"���������");
	Doc_SetFont(nDocID,0,FONT_Book);
	if(Kapitel >= 3)
	{
		Doc_PrintLine(nDocID,0,"");
		if(Fernando_isAlive_Kap3 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"��������");
		};
		if(Vino_isAlive_Kap3 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"����");
		};
		if(Malak_isAlive_Kap3 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"�����");
		};
		if(Bromor_isAlive_Kap3 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"������");
		};
	};
	if(Kapitel >= 4)
	{
		if(Engrom_isAlive_Kap4 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"������");
		};
		if(Randolph_isAlive_preKap4 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"��������");
		};
	};
	if(Kapitel >= 5)
	{
		if(Sekob_isAlive_Kap5 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"�����");
		};
		if(Brutus_isAlive_preKap5 == TRUE)
		{
			Doc_PrintLine(nDocID,0,"");
			Doc_PrintLine(nDocID,0,"������");
		};
	};
	if((Kapitel == 6) && (Mario_IsOnBoard == LOG_SUCCESS) && (OrkSturmDI == TRUE))
	{
		Doc_PrintLine(nDocID,0,"");
		Doc_PrintLine(nDocID,0,"�����");
	};
	Doc_Show(nDocID);
};


instance ItPo_HealHilda_MIS(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_HpEssenz;
	visual = "ItPo_HealHilda.3ds";
	material = MAT_GLAS;
	on_state[0] = Use_HealHilda;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "��������� �� ������ ���������";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Essenz;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_HealHilda()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Essenz);
	if(MIS_HealHilda == LOG_RUNNING)
	{
		MIS_HealHilda = LOG_FAILED;
		B_CheckLog();
	};
};


instance ItMw_MalethsGehstock_MIS(C_Item)
{
	name = "�������� �����";
	mainflag = ITEM_KAT_NF;
	flags = ITEM_AXE;
	material = MAT_WOOD;
	value = 15;
	damageTotal = 10;
	damagetype = DAM_BLUNT;
	range = 80;
	cond_atr[2] = ATR_STRENGTH;
	cond_value[2] = Condition_VLKMace;
	visual = "Itmw_008_1h_pole_02.3ds";
	description = name;
	text[0] = "�� ������ �������� ����� '�.'";
	text[2] = NAME_Damage;
	count[2] = damageTotal;
	text[3] = NAME_Str_needed;
	count[3] = cond_value[2];
	text[4] = NAME_OneHanded;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_MalethsBanditGold(C_Item)
{
	name = NAME_Bag;
	mainflag = ITEM_KAT_NONE;
	flags = 0;
	value = 300;
	visual = "ItMi_Bag.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = Use_MalethsBanditGold;
	description = name;
	text[0] = "���� ����� ������� ����� ��������!";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_MalethsBanditGold()
{
	B_PlayerFindItem(ItMi_Gold,300);
};


instance ItMi_Moleratlubric_MIS(C_Item)
{
	name = "��� ����������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = Value_Pitch * 3;
	visual = "ItMi_Moleratlubric.3ds";
	material = MAT_STONE;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItWr_BabosLetter_MIS(C_Item)
{
	name = "������ ����";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_BabosLetter;
	scemeName = "MAP";
	description = name;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_BabosLetter()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"������� ����,");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"��, ���������, ��������� ��������, ��� �� ������ �������� ���� ��� ������. �� ������� ��� ���� ���������� ������� ������� � ��������� ��� �������� ��� �������. �� ������ ���� ����� ���������� � �������� ���� ������� � �������� ����������� ����, ����� �� ������ ������ � ��� �� ����� ������ ����� � ���������.");
	Doc_PrintLines(nDocID,0,"�����. ��������, ���� ���������� ���� �������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"���� � �����");
	Doc_Show(nDocID);
};


instance ItWr_BabosPinUp_MIS(C_Item)
{
	name = "�������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
//	visual = "ItWr_Scroll_01.3DS";
	visual = "ItWr_BabosPinUp_MIS.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_BabosPinUp;
	scemeName = "MAP";
	description = name;
	text[0] = "����������� ����� �������.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_BabosPinUp()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Map_Pinup.TGA",0);
	Doc_Show(nDocID);
};


instance ItWr_BabosDocs_MIS(C_Item)
{
	name = "������ �����";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_BabosDocs;
	scemeName = "MAPSEALED";
	description = name;
	text[0] = "��������� ����������,";
	text[1] = "���������� ������.";
};


func void Use_BabosDocs()
{
	Snd_Play("MOB_BOOK_TURNPAGE_A1");
	BabosDocsOpen = TRUE;
	AI_PrintScreen("�������� ������ � �������",-1,YPOS_ItemGiven,FONT_ScreenSmall,2);
	CreateInvItems(self,ItWr_BabosLetter_MIS,1);
	CreateInvItems(self,ItWr_BabosPinUp_MIS,1);
};


instance ItKe_IgarazChest_Mis(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "��� ���� �� �������,";
	text[1] = "�������������� �������.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Astronomy_Mis(C_Item)
{
	name = "������������ ���� �����";
	mainflag = ITEM_KAT_DOCS;
	//flags = ITEM_MISSION;
	flags = 0;
	value = 400;
	visual = "ItWr_Book_02_02.3ds";
	material = MAT_LEATHER;
	on_state[0] = Use_Astronomy;
	scemeName = "MAP";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};


var int Astronomy_Once;

func void Use_Astronomy()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Mage_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Mage_R.tga",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"... �� ����� ���� ���� ������������ � ������� �����, ����� ��������� �������� �������.");
	Doc_PrintLines(nDocID,0,"��������������� ���� ���� � ������������� ����� ����� �������� ������� ������ ���. ����������� ������� ����� ����������� ���������� ������ - ����� ������, ��� ������� ����� ������� �������� ����������� ���������� � ��� ���.");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"��� ����� ��������� ���������� �����, �������� ��� �� ������� ���� ������� ������, ����� ����� ����� ������ ���� ��� ������. ��� ������� ��� ����� ������ � ���������� ������ ����, � ��������� ���������� � ������ ��� ��� �������� �� ����� ���.");
	Doc_PrintLines(nDocID,1,"���� ����� ������ �����-���� ��������� �����, �� �� ������� ��� �����, ��� ��� �� ����� ���������� ������ ��� ������ ����� ���.");
	Doc_Show(nDocID);
	if(Astronomy_Once == FALSE)
	{
		B_RaiseAttribute(self,ATR_MANA_MAX,2);
		Print(Print_ReadAstronomy);
		Snd_Play("LEVELUP");
		Astronomy_Once = TRUE;
	};
};


var int SC_ObsessionTimes;

instance ItPo_HealObsession_MIS(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_HpEssenz;
	visual = "ItPo_HealObsession.3ds";
	material = MAT_GLAS;
	on_state[0] = Use_HealObsession;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "��������� �� �����������";
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Essenz;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_HealObsession()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Essenz);
	if(SC_IsObsessed == TRUE)
	{
		SC_ObsessionTimes += 1;
		B_ClearSCObsession(self);
		Wld_PlayEffect("spellFX_LIGHTSTAR_VIOLET",hero,hero,0,0,0,FALSE);
//		Wld_PlayEffect("spellFX_LIGHTSTAR_GREEN",hero,hero,0,0,0,FALSE);
		Snd_Play("SFX_HealObsession");
	};
};


instance ItSe_Golemchest_Mis(C_Item)
{
	name = NAME_Beutel;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 50;
	visual = "ItMi_Pocket.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = Use_GolemChest;
	description = name;
	text[0] = PRINT_Pocket_50;
	text[1] = "�������, ������ ����������� ���-�� ���.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_GolemChest()
{
	B_PlayerFindItem(ItMi_Gold,50);
	B_PlayerFindItem(ItRi_Prot_Total_02,1);
};


instance ItWr_ShatteredGolem_MIS(C_Item)
{
	name = "����� ������ �����";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 150;
	visual = "ItWr_Map_NW_02.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_ShatteredGolem_Mis;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_ShatteredGolem_Mis()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_ShatteredGolem_MIS);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_NewWorld_ShatteredGolem.tga",TRUE);
	Doc_SetLevel(Document,"NewWorld\NewWorld.zen");
	Doc_SetLevelCoords(Document,-28000,50500,95500,-42500);
	Doc_Show(Document);
};


instance ItWr_DiegosLetter_MIS(C_Item)
{
	name = "������ ����� ����������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_DiegosLetter_Mis;
	scemeName = "MAP";
	description = name;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_DiegosLetter_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"���������,");
	Doc_PrintLines(nDocID,0,"������, ���� ������ ����� ����.");
	Doc_PrintLines(nDocID,0,"� �������� � ����� � ��� ����. � ����� � ����� ����, � ������� ���� ��� �������. �� ������ ���� ������, ��� ��� �� �������, ���� ��� ����� �� ������� ������ ������.");
	Doc_PrintLines(nDocID,0,"�������, ��� ����� �� ������� ���� �� ������, �� � �� �����, ��� � ���� ���������. ��� �, �� ��������.");
	Doc_PrintLines(nDocID,0,"� ������ �� ���, ��� ����������� ��� �� �����.");
	Doc_PrintLines(nDocID,0,"���� ������������ ���� �������� � ����� - ��� ������� ���� �������� � �������� ���� ������ ���. ����� �� ����� �����.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"�����");
	Doc_Show(nDocID);
};


instance ItSe_DiegosTreasure_Mis(C_Item)
{
	name = NAME_Beutel;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = DiegosTreasure;
	visual = "ItMi_Pocket_Mis.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = Use_DiegosTreasure;
	description = name;
	text[0] = PRINT_Pocket_MIS;
	text[1] = "� ������ '�����'.";
	text[2] = "������ ����� ���� ������!";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_DiegosTreasure()
{
	B_PlayerFindItem(ItMi_Gold,DiegosTreasure);
	OpenedDiegosBag = TRUE;
};


instance ItMi_UltharsHolyWater_Mis(C_Item)
{
	name = "������ ���� �������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = Value_HolyWater;
	visual = "ItMi_UltharsHolyWater.3ds";
	material = MAT_GLAS;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};


instance ItWr_MinenAnteil_Mis(C_Item)
{
	name = "����� ������� ��������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 50;
	visual = "ItWr_Scroll_02.3DS";
//	visual = "Fakescroll.3ds";
	material = MAT_LEATHER;
	on_state[0] = Use_MinenAnteil_Mis;
	scemeName = "MAP";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_MinenAnteil_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"����� �������");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"�������� ������������ ������������� � �������������, ������������ ����� ��������� ������ ����� �� ���������� ������ ����� � ����������� ������.");
	Doc_PrintLines(nDocID,0,"������������� ������ ������ ������ ���� ���������� ������������� � ���� ������.");
	Doc_PrintLines(nDocID,0,"�������� ������ � ��������������� �������, ������ ���������� 16 ����� � �������������� ��������� � 3 ���� �� ���������.");
	Doc_PrintLines(nDocID,0,"����������� ���������� ����� ����� �� ��������� ������ � ������ ������������ �����.");
	Doc_PrintLines(nDocID,0,"���� ��������� �� � ��������� ������� �����, ��� ����� �� ����� ������������ � �����������.");
	Doc_PrintLine(nDocID,0,"                                �������:");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"      ����������� ����������,");
	Doc_PrintLine(nDocID,0,"                ���������");
	Doc_Show(nDocID);
	if(SC_KnowsProspektorSalandril == FALSE)
	{
		if(!Npc_IsDead(Salandril))
		{
			B_LogEntry(TOPIC_MinenAnteileKDF,"�����, ���������� ����� ���� ���������, ����� ���������. ��������, � ����� ����� ��� � ������� ����� ��������, ���� �� ��� �� ����� ��������� �� ����������.");
		}
		else
		{
			B_LogEntry(TOPIC_MinenAnteileKDF,"�����, ���������� ����� ���� ���������, ����� ���������. �� �����. ��� ����� �������� ��� ����������.");
			Log_SalandrilIsDead = TRUE;
		};
		SC_KnowsProspektorSalandril = TRUE;
	};
};


instance ItAm_Prot_BlackEye_Mis(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = Value_Am_HpMana;
//	visual = "ItAm_Hp_Mana_01.3ds";
	visual = "ItAm_Prot_BlackEye_Mis.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "������ ������ ���";
	text[2] = "������ �� ������.";
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};

instance ItMi_KarrasBlessedStone_Mis(C_Item)
{
	name = "������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 0;
//	visual = "ItMi_Rockcrystal.3ds";
	visual = "ItMi_KarrasBlessedStone.3ds";
	visual_skin = 0;
	material = MAT_STONE;
	description = "������ �� �������������� �����";
	inv_zbias = 190;
};

instance ItWr_RichterKomproBrief_MIS(C_Item)
{
	name = "��������� �����";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_RichterKomproBrief;
	scemeName = "MAP";
	description = name;
};


func void Use_RichterKomproBrief()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"���������, ��, ��������� ����� ���. ������� ��� ������, ��� ��� �������� �������� ������ ������� ������������� � ���������� ��� ����.");
	Doc_PrintLines(nDocID,0,"��� ������ ���� ������� ������ �����. ������ ���������� ��������������.");
	Doc_PrintLines(nDocID,0,"���� �� �� ������� ������ �� ��� �������� ������, ����� ����� ������� ������. � ������ ���, ��� �� ��������� ��� ������� ������� �� �������� �������.");
	Doc_PrintLines(nDocID,0,"�� �� ��������� � ���� ��������, ��� ��������� ������� ����, � ������ �������� �� �������.");
	Doc_PrintLines(nDocID,0,"������: ���� �� ��������� ���������� ��� ����, � �� ��������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"          ������� ����� �");
	Doc_PrintLine(nDocID,0,"          ����������� ���������");
	Doc_Show(nDocID);
	if(SCKnowsRichterKomproBrief == FALSE)
	{
		B_LogEntry(TOPIC_RichterLakai,"���������, ������� �� ������ � ��, ��� ��� �������� �� ������� �����?");
		SCKnowsRichterKomproBrief = TRUE;
	};
};


instance ItWr_MorgahardTip(C_Item)
{
	name = NAME_Letter;
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_MorgahardTip;
	scemeName = "MAP";
	description = name;
	text[0] = "��� ������ ���� � ���������� ������������.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_MorgahardTip()
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
	Doc_PrintLines(nDocID,0,"� �����. �������, �� ���������� �����, ����� ��� ������� ����������.");
	Doc_PrintLines(nDocID,0,"�� ����������, �����. � ������� ������, � ������� ����� ������.");
	Doc_PrintLines(nDocID,0,"��� ����� ������.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"                     �.");
//	Doc_PrintLine(nDocID,0,"");
	Doc_Show(nDocID);
};


instance ItWr_Map_Shrine_MIS(C_Item)
{
	name = "����� ��������� �������";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 200;
	visual = "ItWr_Map_NW_01.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_NewWorld_Shrine_MIS;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Map_NewWorld_Shrine_MIS()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_Shrine_MIS);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_NewWorld_Shrine.tga",TRUE);
	Doc_SetLevel(Document,"NewWorld\NewWorld.zen");
	Doc_SetLevelCoords(Document,-28000,50500,95500,-42500);
	Doc_Show(Document);
};


instance ItWr_VinosKellergeister_Mis(C_Item)
{
	name = "��� ����";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Book_02_05.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	on_state[0] = Use_VinosKellergeister_Mis;
};


func void Use_VinosKellergeister_Mis()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Red_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Red_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_PrintLines(nDocID,0,"���� ���������");
	Doc_PrintLine(nDocID,0,"");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"... � ��� ������ ������������, �� ���� ����, ��� ��� �������� ��� ��-�� ������� �� ������� ������, ��������� ��� �������� ...");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"... ��� ����� ��������� ��������� � ���, ��� ����� ����� � ���� ����� ������ ...");
	Doc_PrintLine(nDocID,0,"");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"... ���� ��� ������. �� ��� ��� �� �� �� ���� �� �����, ��� ����� ���������, ���� ���� �������� �� ����� ���������� ��������������. �� �����������, ��� ����� ������ ���������, ���� ��� ������ ���� �����. ��� ����� ���� �������� ���� �� ������ ...");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"... ��� ����� ���������������. ��� ����� �������� ��� �������, ���� ��� �� ���������� �������, � ������� � ����� ������, ����� ���� ������, ��� ����� ���� ������ �� ������������ ...");
	Doc_Show(nDocID);
};


