
const int Value_Lockpick = 10;
const int Value_Key_01 = 0;

instance ItKe_Lockpick(C_Item)
{
	name = "Lockpick";
	//mainflag = ITEM_KAT_KEYS;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_Lockpick;
	visual = "ItKe_Lockpick.3ds";
	material = MAT_METAL;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

/*instance ItKe_Key_01(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_Key_02(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_Key_03(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};*/

instance ItKe_City_Tower_01(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = NAME_TowerKey;
	text[0] = "This one belonged to Pablo.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_City_Tower_02(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = NAME_TowerKey;
	text[0] = "This one belonged to Ranger.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_City_Tower_03(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = NAME_TowerKey;
	text[0] = "This one belonged to Ruga.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_City_Tower_04(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = NAME_TowerKey;
	text[0] = "This one belonged to Wambo.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_City_Tower_05(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = NAME_TowerKey;
	text[0] = "This one belonged to Peck.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_City_Tower_06(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = NAME_TowerKey;
	text[0] = "This key was inside a chest";
	text[1] = "in the barracks.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_Orlan_BackDoor(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = "Orlan's Key";
	text[0] = "Fits the back door";
	text[1] = "of the 'Dead Harpy' tavern.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

