
instance ITWR_Addon_Runemaking_KDW_CIRC1(C_Item)
{
	name = "Runebook of the Water Mages";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 100;
	visual = "ItWr_Book_Runemaking_KDW.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Runemaking_KDW_CIRC1_S1;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

/*instance ITWR_Addon_Runemaking_KDW_CIRC2(C_Item)
{
	name = "Runebook of the Water Mages II";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 100;
	visual = "ItWr_Book_02_04.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Книга рун магов Воды (2-й круг)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Runemaking_KDW_CIRC2_S1;
};

instance ITWR_Addon_Runemaking_KDW_CIRC3(C_Item)
{
	name = "Runebook of the Water Mages III";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 100;
	visual = "ItWr_Book_02_04.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Книга рун магов Воды (3-й круг)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Runemaking_KDW_CIRC3_S1;
};

instance ITWR_Addon_Runemaking_KDW_CIRC4(C_Item)
{
	name = "Runebook of the Water Mages IV";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 100;
	visual = "ItWr_Book_02_04.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Книга рун магов Воды (4-й круг)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Runemaking_KDW_CIRC4_S1;
};

instance ITWR_Addon_Runemaking_KDW_CIRC5(C_Item)
{
	name = "Runebook of the Water Mages V";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 100;
	visual = "ItWr_Book_02_04.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Книга рун магов Воды (5-й круг)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Runemaking_KDW_CIRC5_S1;
};

instance ITWR_Addon_Runemaking_KDW_CIRC6(C_Item)
{
	name = "Runebook of the Water Mages VI";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 100;
	visual = "ItWr_Book_02_04.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Книга рун магов Воды (6-й круг)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Runemaking_KDW_CIRC6_S1;
};*/

instance ITWR_Addon_Runemaking_KDF_CIRC1(C_Item)
{
	name = "Fire Runebook I";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 100;
	visual = "ItWr_Book_Runemaking_KDF.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Runebook of the Fire Magicians (1st Circle)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Bookstand_Kreise_01_S1;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

instance ITWR_Addon_Runemaking_KDF_CIRC2(C_Item)
{
	name = "Fire Runebook II";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 100;
	visual = "ItWr_Book_Runemaking_KDF.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Runebook of the Fire Magicians (2nd Circle)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Bookstand_Kreise_02_S1;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

instance ITWR_Addon_Runemaking_KDF_CIRC3(C_Item)
{
	name = "Fire Runebook III";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 100;
	visual = "ItWr_Book_Runemaking_KDF.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Runebook of the Fire Magicians (3rd Circle)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Bookstand_Kreise_03_S1;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

instance ITWR_Addon_Runemaking_KDF_CIRC4(C_Item)
{
	name = "Fire Runebook IV";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 100;
	visual = "ItWr_Book_Runemaking_KDF.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Runebook of the Fire Magicians (4th Circle)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Bookstand_Kreise_04_S1;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

instance ITWR_Addon_Runemaking_KDF_CIRC5(C_Item)
{
	name = "Fire Runebook V";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 100;
	visual = "ItWr_Book_Runemaking_KDF.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Runebook of the Fire Magicians (5th Circle)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Bookstand_Kreise_05_S1;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

instance ITWR_Addon_Runemaking_KDF_CIRC6(C_Item)
{
	name = "Fire Runebook VI";
	mainflag = ITEM_KAT_DOCS;
//	flags = ITEM_MISSION;
	flags = 0;
	value = 100;
	visual = "ItWr_Book_Runemaking_KDF.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Runebook of the Fire Magicians (6th Circle)";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = Use_Bookstand_Kreise_06_S1;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};

