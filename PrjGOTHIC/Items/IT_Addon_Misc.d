
const int Value_Goldnugget = 18;
const int Value_WhitePearl = 120;
const int Value_Addon_Joint_01 = 60;

instance ItMi_GoldNugget_Addon(C_Item)
{
	name = "������� ���������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_Goldnugget;
	visual = "ItMi_GoldNugget_01.3ds";
	material = MAT_STONE;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_MISC2_STANDARD;
};

instance ItMi_Addon_WhitePearl(C_Item)
{
	name = "���������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_WhitePearl;
	visual = "ItMi_WhitePearl_01.3ds";
	material = MAT_STONE;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_MISC_STANDARD;
};

instance ItMi_Addon_Joint_01(C_Item)
{
	name = NAME_Joint;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_Addon_Joint_01;
	visual = "ItMi_Addon_Joint_01.3ds";
	material = MAT_LEATHER;
	scemeName = "JOINT";
	on_state[0] = Use_Addon_Joint_01;
	description = "������� ���������";
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = 200;
};


var int FirstJoint;

func void Use_Addon_Joint_01()
{
	if(Npc_IsPlayer(self))
	{
		if(FirstJoint == FALSE)
		{
			if(Npc_GetTalentSkill(hero,NPC_TALENT_ALCHEMY))
			{
				B_GivePlayerXP(50);
			}
			else
			{
				B_GivePlayerXP(5);
			};
			FirstJoint = TRUE;
		};
		Wld_StopEffect("SLOW_TIME");
		Wld_PlayEffect("SLOW_TIME",self,self,0,0,0,FALSE);
	};
};


instance ItMi_BaltramPaket(C_Item)
{
	name = "����� ��� ���������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 200;
	visual = "ItMi_Packet.3ds";
	material = MAT_LEATHER;
	description = name;
	text[0] = "������� ����� �";
	text[1] = "���������� ��������";
	text[2] = "� ����� �����.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_Packet_Baltram4Skip_Addon(C_Item)
{
	name = "����� ��� �����";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 200;
	visual = "ItMi_Packet.3ds";
	material = MAT_LEATHER;
	description = name;
	text[0] = "������� ����� �";
	text[1] = "���������� ��������";
	text[2] = "��� ������ �����.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_BromorsGeld_Addon(C_Item)
{
	name = "������� �����";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_Nugget;
	visual = "ItMi_MariasGoldPlate.3DS";
	material = MAT_METAL;
	description = name;
	text[0] = "������ ��������� �� ���";
	text[1] = "���������� ��� '������'.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItSe_ADDON_CavalornsBeutel(C_Item)
{
	name = NAME_Beutel;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_Nugget;
	visual = "ItMi_Pocket_Mis.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = Use_CavalornsBeutel;
	description = name;
	text[0] = PRINT_Pocket_MIS;
	text[1] = "� ������ '��������'.";
	text[2] = "������ ��������� ����� ����.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_CavalornsBeutel()
{
	B_PlayerFindItem(ItMi_Nugget,1);
	Log_CreateTopic(TOPIC_Addon_CavalornTheHut,LOG_MISSION);
	Log_SetTopicStatus(TOPIC_Addon_CavalornTheHut,LOG_Running);
	B_LogEntry(TOPIC_Addon_CavalornTheHut,"� ����� ������� � ������ ���� ����� ������ ��������� � ������ ��������. ���, ������ ����, ����� ��� ������ �������� ��������.");
	SC_OpenedCavalornsBeutel = TRUE;
};


instance ItMi_Skull(C_Item)
{
	name = "�����";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 10;
	visual = "DT_SKELETON_V01_HEAD.3ds";
	material = MAT_WOOD;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_IECello(C_Item)
{
	name = "����������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 20;
	visual = "Itmi_IE_Cello.3ds";
	material = MAT_WOOD;
	scemeName = "CELLO";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_IECelloBow(C_Item)
{
	name = "������������� ������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 5;
	visual = "Itmi_IE_CelloBow.3ds";
	material = MAT_WOOD;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_IEDrum(C_Item)
{
	name = "�������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 20;
	visual = "Itmi_IE_Drum.3ds";
	material = MAT_WOOD;
	scemeName = "PAUKE";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_IEDrumStick(C_Item)
{
	name = "���������� �������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 5;
	visual = "Itmi_IE_DrumStick.3ds";
	material = MAT_WOOD;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = 55;
};

instance ItMi_IEDrumScheit(C_Item)
{
	name = "��������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 20;
	visual = "Itmi_IE_Drumscheit.3ds";
	material = MAT_WOOD;
	scemeName = "DRUMSCHEIT";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_IEDudelBlau(C_Item)
{
	name = "����� �������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 20;
	visual = "Itmi_IE_DudelBlau.3ds";
	material = MAT_LEATHER;
	scemeName = "DUDEL";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_IEDudelGelb(C_Item)
{
	name = "������ �������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 20;
	visual = "Itmi_IE_DudelGelb.3ds";
	material = MAT_LEATHER;
	scemeName = "DUDEL";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_IEHarfe(C_Item)
{
	name = "����";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 20;
	visual = "Itmi_IE_Harfe.3ds";
	material = MAT_WOOD;
	scemeName = "HARFE";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_IELaute(C_Item)
{
	name = "������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 20;
	visual = "Itmi_IE_Laute.3ds";
	material = MAT_WOOD;
	scemeName = "IELAUTE";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 45;
	inv_rotx = 270;
	inv_roty = 295;
};

instance ItMi_Addon_Lennar_Paket(C_Item)
{
	name = "�������� �����";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 300;
	visual = "ItMi_Packet.3ds";
	scemeName = "MAPSEALED";
	on_state[0] = Use_LennarPaket;
	material = MAT_LEATHER;
	description = name;
	text[0] = "������ ��������� �������.";
	text[1] = "����� �������.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_LennarPaket()
{
	B_PlayerFindItem(ItKe_Lockpick,Lennar_picklock_amount);
	Snd_Play("Geldbeutel");
	LennarPaket_Open = TRUE;
};


instance ItMi_Grog_Crate(C_Item)
{
	name = "���� � ������";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = Value_Grog * 4;
	visual = "ItMi_Crate.3ds";
	scemeName = "MAPSEALED";
	on_state[0] = Use_Grog_Crate;
	material = MAT_WOOD;
	description = name;
	text[0] = "������ ��������� ������ ������� �����.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_Grog_Crate()
{
	B_PlayerFindItem(ItFo_Addon_Grog,4);
};


instance ItMi_Zeitspalt_Addon(C_Item)
{
	name = "������ ����";
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI;
	value = 100;
	visual = "ItMi_Zeitspalt_Addon.3DS";
	scemeName = "MAPSEALED";
	on_state[0] = Use_Zeitspalt_Addon;
	material = MAT_STONE;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_WEAKGLIMMER";
	description = name;
//	text[0] = PRINT_UnknownEffect;
	text[1] = TEXT_Zeitspalt_Setting;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_MISC_STANDARD;
};


func void Use_Zeitspalt_Addon()
{
	if(Npc_IsPlayer(self))
	{
		Wld_PlayEffect("spellFX_BELIARSRAGE",self,self,0,0,0,FALSE);
		Wld_StopEffect("SLOW_MOTION");
		Wld_PlayEffect("SLOW_MOTION",self,self,0,0,0,FALSE);
		TEXT_Zeitspalt_Setting = PRINT_SlowTime;
		Zeitspalt_Used = TRUE;
	};
};


