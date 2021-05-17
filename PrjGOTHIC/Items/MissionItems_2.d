
instance ItMi_StoneOfKnowlegde_MIS(C_Item)
{
	name = "Stone of Knowledge";
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
	name = "A letter to Lord Hagen";
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
	Doc_PrintLine (nDocID, 0, "Lord Hagen!");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLines (nDocID, 0, "The expedition to the Valley of Mines failed. We suffered many losses. The survivors are trapped in the castle, surrounded by orcs.");
	Doc_PrintLines (nDocID, 0, "We have been attacked by dragons many times. They have devastated the lands around the castle. With Innos' help we shall prevail until reinforcements arrive. A sortie is impossible.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "May Innos keep us all.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Garond");
	Doc_Show(nDocID);
};


instance ItWr_LetterForGorn_MIS(C_Item)
{
	name = "Milten's Note to Gorn";
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
	Doc_PrintLine(nDocID,0,"Gorn!");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "Garond has agreed to set you free - for 1000 pieces of gold.");
	Doc_PrintLines (nDocID, 0, "So, if you have any gold stacked away somewhere, now would be a good time to reveal it.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Milten");
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
	text[0] = "The key to the dungeon in the castle.";
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
	text[0] = "The key to the store room in the castle.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ITKE_ErzBaronFlur(C_Item)
{
	name = "Key for the first door.";
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "There is a name engraved on it:";
	text[1] = "'Gomez'";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ITKE_ErzBaronRaum(C_Item)
{
	name = "Key for the second door.";
	mainflag = ITEM_KAT_KEYS;
	flags = 0;
	value = 0;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "There is a name engraved on it:";
	text[1] = "Gomez.";
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
	text[1] = "Gorn's leather bag.";
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
	name = "Silvestro's Note";
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
	Doc_PrintLine(nDocID,0,"From the King's paladin Silvestro");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "Another day of scraping awaits. Today we intend to break through the wall and dig deeper into the rock.");
	Doc_PrintLines (nDocID, 0, "I've got a bad feeling about this, so I'm going to have the ore hidden away.");
	Doc_PrintLines (nDocID, 0, "Diego's the only one of us who knows his way round here. I have to trust him. He'll take the chests to safety - but I'm not letting him go alone.");
	Doc_PrintLines (nDocID, 0, "The ore must be protected at all costs, so I'm sending two knights to go with Diego.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Long live the King.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Silvestro");
	Doc_Show(nDocID);
	if((MIS_ScoutMine == LOG_Running) && Npc_IsDead(DiegoOW) && !Npc_KnowsInfo(other,DIA_DiegoOw_Beweise) && (Silvestro_Ore == FALSE))
	{
		B_LogEntry(TOPIC_ScoutMine,"Diego transported Silvestro's ore to safety. After a while the mine was swarmed with minecrawlers. Nobody survived.");
	};
	Silvestro_Ore = TRUE;
};


instance ItAt_ClawLeader(C_Item)
{
	name = "Claws";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 100;
	visual = "ItAt_ClawLeader.3DS";
	material = MAT_LEATHER;
	description = name;
	text[0] = "Leader of the Pack's Claws";
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
	text[1] = "Olav's bag.";
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
	name = "Gold Plate";
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
	text[0] = "A small key.";
	text[1] = "Opens the gate to the pass.";
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
	text[0] = "The key to the hotel.";
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
	text[0] = "The chest this key belongs to";
	text[1] = "is under a bridge.";
	text[2] = "It contains a runestone.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Bloody_MIS(C_Item)
{
	name = "Alchemist's Notes";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseBloodMIS;
	scemeName = "MAP";
	description = name;
	text[0] = "Bloodflies' Venom";
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
	Doc_PrintLines (nDocID, 0, "The stinger of a bloodfly contains a deadly venom that no person of sane mind would ever take.");
	Doc_PrintLines (nDocID, 0, "Unless he knows the art of removing the stinger and the following rule.");
	Doc_PrintLines (nDocID, 0, "The stinger is cut open tidily by running a sharp blade from the tip to the shaft.");
	Doc_PrintLines (nDocID, 0, "The upper skin layer is removed. The exposed tissue is cut open around the glands.");
	Doc_PrintLines (nDocID, 0, "The special juice of the tissue has healing properties.");
	Doc_PrintLines (nDocID, 0, "However, the human body grows immune to the healing potion in time.");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Damarok");
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
	name = "Note of Debenture";
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
	Doc_PrintLines(nDocID,0,"For payment of outstanding debts a pawned item shall be accepted, whose value equals that of the debts.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Pawned: A decorated gold chalice of the Blood Chalice collection");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"signed:");
	Doc_PrintLine(nDocID,0,"Lutero, merchant");
	Doc_PrintLine(nDocID,0,"Lehmar, pawnbroker");
	Doc_Show(nDocID);
};


instance ItWr_Map_OldWorld_Oremines_MIS(C_Item)
{
	name = "Garond's Mine Map";
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
	name = "Garond's Mine Map";
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
	name = "Song lyrics.";
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
	Doc_PrintLines(nDocID,0,"Dominique's Cry");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines (nDocID, 0, "We shall reap His glory.");
	Doc_PrintLines (nDocID, 0, "Innos stands by me and my brothers.");
	Doc_PrintLines (nDocID, 0, "I will slay all who would stop me like sheep");
	Doc_PrintLines (nDocID, 0, "for He is the fire inside my heart.");
	Doc_PrintLines (nDocID, 0, "My blade serves Him alone.");
	Doc_PrintLines (nDocID, 0, "On this day His name will echo forth.");
	Doc_PrintLines (nDocID, 0, "Any man who opposes me");
	Doc_PrintLines (nDocID, 0, "will die at my hand");
	Doc_PrintLines (nDocID, 0, "for I am a warrior of Innos.");
	Doc_Show(nDocID);
	if(Manowar_Once == FALSE)
	{
		B_GivePlayerXP(200);
		Manowar_Once = TRUE;
	};
};


instance ItWr_KDWLetter(C_Item)
{
	name = "Message";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseKDWLetter;
	scemeName = "MAP";
	description = name;
	text[0] = "From a frozen camp in the Valley of Mines.";
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
	Doc_PrintLines(nDocID,0,"We have left the camp. Now that the Barrier has fallen, we will seek out the center of the destruction. Maybe we will find there the answers we have sought for so many years. Adanos alone knows where our journey will take us.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Adanos is with us.");
	Doc_PrintLine(nDocID,0,"Saturas");
	Doc_Show(nDocID);
};


instance ItWr_GilbertLetter(C_Item)
{
	name = "Note";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseGilbertLetter;
	scemeName = "MAP";
	description = name;
	text[0] = "From a cave in the Valley of Mines.";
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
	Doc_PrintLines (nDocID, 0, "I'm fed up. I've been hiding here long enough. And if I heard rightly, the Barrier's finally fallen.");
	Doc_PrintLines (nDocID, 0, "It seems unlikely anyone will look for me now. I've had enough of this cave and the whole damn valley. It's time I went home.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Gilbert");
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
	text[0] = "Tengron's ring.";
	text[2] = NAME_Bonus_HpMax;
	count[2] = Ri_Hp;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};

