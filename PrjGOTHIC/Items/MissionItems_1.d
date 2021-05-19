
instance ItKe_Xardas(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[2] = "A key to a chest";
	text[3] = "belonging to Xardas.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Canthars_KomproBrief_MIS(C_Item)
{
	name = "Faked Letter";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Canthars_KomproBrief;
	scemeName = "MAP";
	description = name;
	text[0] = "I received this paper from Canthar,";
	text[1] = "I'm to secretly stick it into her pocket.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Canthars_KomproBrief()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"     Last Warning");
	Doc_PrintLine(nDocID,0,"");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLines(nDocID,0,"        I have already reminded you several");
	Doc_PrintLines(nDocID,0,"        times in the friendliest");
	Doc_PrintLines(nDocID,0,"        terms that I urgently require the");
	Doc_PrintLines(nDocID,0,"        weapons I ordered from you a week");
	Doc_PrintLines(nDocID,0,"        ago.");
	Doc_PrintLines(nDocID,0,"        If I don't hear from you very soon,");
	Doc_PrintLines(nDocID,0,"        Sarah, I will be forced to change my");
	Doc_PrintLines(nDocID,0,"        attitude to you. I hope we understand");
	Doc_PrintLine(nDocID,0,"		 each other!!!!!!!!!!!!");
	Doc_PrintLine(nDocID,0,"            Onar");
//	Doc_PrintLine(nDocID,0,"");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
};


instance ItMw_2h_Rod(C_Item)
{
	name = NAME_2h_Rod;
	mainflag = ITEM_KAT_NF;
	flags = ITEM_2HD_SWD;
	material = MAT_METAL;
	value = Value_Sld2hSchwert;
	damageTotal = Damage_Rod;
	damagetype = DAM_EDGE;
	range = Range_Sld2hSchwert;
	cond_atr[2] = ATR_STRENGTH;
	cond_value[2] = Condition_Rod;
	visual = "ItMw_035_2h_sld_sword_02.3DS";
	description = name;
	text[2] = NAME_Damage;
	count[2] = damageTotal;
	text[3] = NAME_Str_needed;
	count[3] = cond_value[2];
	text[4] = NAME_TwoHanded;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMw_2h_Rod_Fake(C_Item)
{
	name = NAME_2h_Rod;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = 0;
	visual = "ItMw_035_2h_sld_sword_02.3DS";
	scemeName = "INSPECTWEAPON";
	material = MAT_METAL;
	description = name;
};

instance ItMi_CoragonsSilber(C_Item)
{
	name = "Coragon's Silver";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_SilverCup;
	visual = "ItMi_CoragonsSilber.3DS";
	material = MAT_METAL;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_TheklasPaket(C_Item)
{
	name = "Thekla's Parcel";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 100;
	visual = "ItMi_Packet.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = Use_TheklasPacket;
	description = name;
	text[0] = "Small parcel with herbs from Sagitta.";
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_TheklasPacket()
{
	CreateInvItems(hero,ItPl_Mana_Herb_01,3);
	CreateInvItems(hero,ItPl_Health_Herb_02,1);
	CreateInvItems(hero,ItPl_Speed_Herb_01,1);
	CreateInvItems(hero,ItPl_Blueplant,2);
	Print(PRINT_GotPlants);
};


instance ItMi_MariasGoldPlate(C_Item)
{
	name = "Heavy Gold Plate";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_GoldPlate;
	visual = "ItMi_MariasGoldPlate.3DS";
	material = MAT_METAL;
	description = name;
	text[0] = "The plate is engraved with the";
	text[1] = "names of Onar and Maria.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItRi_Prot_Edge_01_Valentino(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING;
	value = Value_Ri_ProtEdge;
	visual = "ItRi_Prot_Edge_01.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Prot_Edge_01;
	on_unequip = UnEquip_ItRi_Prot_Edge_01;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Valentino's Ring";
	text[0] = "It used to belong to Valentino.";
	text[2] = NAME_Prot_Edge;
	count[2] = Ri_ProtEdge;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};

instance ItKe_Dexter(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "A key to a chest";
	text[1] = "belonging to Dexter.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Kraeuterliste(C_Item)
{
	name = "List";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_Kraeuterliste;
	scemeName = "MAP";
	description = "Constantino's list of herbs";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Kraeuterliste()
{
	var int nDocID;
	nDocID = Doc_Create ();
	Doc_SetPages (nDocID, 1);
	Doc_SetPage (nDocID, 0, "letters.TGA", 0);
	Doc_SetFont (nDocID, -1, FONT_Book);
	Doc_SetMargins (nDocID, -1, 50, 50, 50, 50, 1);
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Alchemical Herbs");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Healing Plant");
	Doc_PrintLine (nDocID, 0, "Healing Herb");
	Doc_PrintLine (nDocID, 0, "Healing Root");
	Doc_PrintLine (nDocID, 0, "Fire Nettle");
	Doc_PrintLine (nDocID, 0, "Fireweed");
	Doc_PrintLine (nDocID, 0, "Fire Root");
	Doc_PrintLine (nDocID, 0, "Goblin Berry");
	Doc_PrintLine (nDocID, 0, "Dragonroot");
	Doc_PrintLine (nDocID, 0, "Snapperweed");
	Doc_PrintLine (nDocID, 0, "Meadow Knotweed");
	Doc_PrintLine (nDocID, 0, "King's Sorrel");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLines (nDocID, 0, "Note: Let a potential apprentice fetch the plants for you. That way you'll know if he's any good. ");
	Doc_PrintLine (nDocID, 0, "");
	Doc_PrintLine (nDocID, 0, "Regards, Zuris.");
	Doc_SetMargins (nDocID, -1, 200, 50, 50, 50, 1);
	Doc_Show (nDocID);
};


instance ItWr_ManaRezept(C_Item)
{
	name = "Recipe for Magical Potions";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 20;
	visual = "ItWr_Recipe.3DS";
	material = MAT_LEATHER;
	on_state[0] = Use_ManaRezept;
	scemeName = "MAP";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_ManaRezept()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Magic Potions");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"To brew magic potions, a skilled alchemist needs:");
//	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Fire Nettle");
	Doc_PrintLine(nDocID,0,"Fireweed");
	Doc_PrintLine(nDocID,0,"Fire Root");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"He also requires a plant of");
	Doc_PrintLine(nDocID,0,"Meadow Knotweed");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Master Neoras");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
};


instance ItWr_Passierschein(C_Item)
{
	name = "Pass";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 50;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = UsePassierschein;
	scemeName = "MAP";
	description = name;
	text[0] = "These papers permit me to";
	text[1] = "pass the city guards.";
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UsePassierschein()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_BookHeadline);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"     Pass");
	Doc_PrintLine(nDocID,0,"            Khorinis");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLines (nDocID, 0, "        This document entitles the");
	Doc_PrintLines (nDocID, 0, "        bearer to move freely in the lower areas");
	Doc_PrintLines (nDocID, 0, "        of Khorinis for an unlimited time period.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"            Larius");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"            the King's governor");
//	Doc_PrintLine(nDocID,0,"");
//	Doc_PrintLine(nDocID,0,"");
//	Doc_PrintLine(nDocID,0,"");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
	Player_KnowsLariusAsGovernor = TRUE;
};


instance ItMi_HerbPaket(C_Item)
{
	name = "Parcel of Weed";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 200;
	visual = "ItMi_HerbPaket.3ds";
	material = MAT_LEATHER;
	description = name;
	text[0] = "A heavy, sticky package that";
	text[1] = "stinks of swampweed.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItKe_Storage(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to the harbor";
	text[1] = "storehouse.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};


instance ItFo_HalvorFish_MIS(C_Item)
{
	name = "Strange Fish";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItFo_Fish.3DS";
	material = MAT_LEATHER;
	scemeName = "MAPSEALED";
	on_state[0] = Use_HalvorFish;
	description = name;
	text[0] = "There's something wrong with this fish.";
	text[1] = "Looks like it's been sewn up...";
};


func void Use_HalvorFish()
{
	Snd_Play("CS_IHL_WO_WA");
	CreateInvItems(hero,ItWr_HalvorMessage,1);
	Print(PRINT_FishLetter);
};


instance ItWr_HalvorMessage(C_Item)
{
	name = "Stinking Note";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseHalvorMessage;
	scemeName = "MAP";
	description = name;
	text[0] = "This note was hidden inside a fish.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UseHalvorMessage()
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
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"    Keep your heads low, guys!");
	Doc_PrintLines(nDocID,0,"    The militia's getting suspicious.");
	Doc_PrintLines(nDocID,0,"    Don't do anything until you hear from me again!,");
	Doc_PrintLines(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"    Halvor");
	Doc_Show(nDocID);
	Knows_Halvor = TRUE;
};


instance ItMw_AlriksSword_Mis(C_Item)
{
	name = "Alrik's Sword";
	mainflag = ITEM_KAT_NF;
	flags = ITEM_MISSION | ITEM_SWD;
	material = MAT_METAL;
	value = Value_Alrik;
	damageTotal = Damage_Alrik;
	damagetype = DAM_EDGE;
	range = Range_Alrik;
	cond_atr[2] = ATR_STRENGTH;
	cond_value[2] = Condition_Alrik;
	visual = "ItMw_025_1h_Sld_Sword_02.3DS";
	on_equip = Equip_1H_10;
	on_unequip = UnEquip_1H_10;
	description = name;
	text[2] = NAME_Damage;
	count[2] = damageTotal;
	text[3] = NAME_Str_needed;
	count[3] = cond_value[2];
	text[4] = NAME_ADDON_BONUS_1H;
	count[4] = Waffenbonus_10;
	text[5] = NAME_Value;
	count[5] = value;
};

/*
func void Equip_AlriksSword()
{
	B_AddFightSkill(self,NPC_TALENT_1H,10);
	if(Npc_IsPlayer(self))
	{
		b_meleeweaponchange(10,0,0);
	};
};

func void UnEquip_AlriksSword()
{
	if(!Npc_IsPlayer(self))
	{
		B_AddFightSkill(self,NPC_TALENT_1H,-10);
	};
	if(Npc_IsPlayer(self) && ((MELEEWEAPONCHANGEDHERO == TRUE) || (SCRIPTPATCHWEAPONCHANGE == FALSE)))
	{
		B_AddFightSkill(self,NPC_TALENT_1H,-10);
		b_meleeweaponundochange();
	};
};
*/

instance ItWr_VatrasMessage(C_Item)
{
	name = NAME_LetterSealed;
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseVatrasMessageSealed;
	scemeName = "MAPSEALED";
	description = name;
	text[1] = "A message from Vatras";
	text[2] = "for the Fire Mages.";
};


func void UseVatrasMessage()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Dear Isgaroth,");
	Doc_PrintLines(nDocID,0,"I sense the ever-growing presence of another force.");
	Doc_PrintLines(nDocID,0,"It's a force so far unknown to us. Can it be that there are vassals of Beliar near?");
	Doc_PrintLines(nDocID,0,"I could be mistaken, but I believe Father Pyrokar would be wise to take the matter in hand.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"May our prayers be answered.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Vatras");
	Doc_Show(nDocID);
};


func void UseVatrasMessageSealed()
{
	Snd_Play("PICKLOCK_BROKEN");
	CreateInvItems(self,ItWr_VatrasMessage_Open,1);
	UseVatrasMessage();
};


instance ItWr_VatrasMessage_Open(C_Item)
{
	name = NAME_Letter;
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseVatrasMessage;
	scemeName = "MAP";
	description = name;
	text[0] = "A message from Vatras";
	text[1] = "for the Fire Mages.";
	text[3] = "The seal has been broken.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


/*instance ItKe_Hotel(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to the hotel room.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};*/

instance ItKe_ThiefGuildKey_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_05.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "This key has been damaged by salty seawater.";
	text[1] = "";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_ThiefGuildKey_Hotel_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to the hotel cellar.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_Innos_MIS(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to the portal of the";
	text[1] = "monastery of Innos.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_KlosterSchatz(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to the monastery's treasury.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_KlosterStore(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to the monastery's larder.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_KDFPlayer(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_02.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to the chamber in the monastery.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_KlosterBibliothek(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to the monastery's library.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItFo_Schafswurst(C_Item)
{
	name = "Sheep Sausage";
	mainflag = ITEM_KAT_FOOD;
	flags = ITEM_MULTI;
	value = Value_Sausage;
	visual = "ItFo_Schafswurst.3DS";
	material = MAT_LEATHER;
	scemeName = "FOODHUGE";
	on_state[0] = Use_Schafswurst;
	description = name;
	text[1] = NAME_Bonus_HP;
	count[1] = HP_Sausage;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_Schafswurst()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Sausage);
};


instance ItPo_Perm_LittleMana(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI;
	value = 500;
	visual = "ItMi_UltharsHolyWater.3ds";
	material = MAT_GLAS;
	on_state[0] = UseItPo_LittleMana;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_MANAPOTION";
	description = "Essence of Spirit";
	text[1] = NAME_Bonus_ManaMax;
	count[1] = 3;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseItPo_LittleMana()
{
	B_RaiseAttribute(self,ATR_MANA_MAX,3);
};


instance Holy_Hammer_MIS(C_Item)
{
	name = "Sacred Hammer";
	mainflag = ITEM_KAT_NF;
	flags = ITEM_MISSION | ITEM_2HD_AXE;
	material = MAT_WOOD;
	value = Value_HolyHammer;
	owner = Nov_608_Garwig;
	damageTotal = Damage_HolyHammer;
	damagetype = DAM_BLUNT;
	range = Range_HolyHammer;
	cond_atr[2] = ATR_STRENGTH;
	cond_value[2] = Condition_HolyHammer;
	visual = "ItMw_030_2h_kdf_hammer_01.3DS";
	description = name;
//	text[2] = "Урон:                     ??";
//	text[3] = "Необходима сила:          ??";
//	text[4] = "Двуручное оружие";
//	text[5] = "Цена:  невозможно определить";
//	text[2] = NAME_Damage;
//	count[2] = damageTotal;
//	text[3] = NAME_Str_needed;
//	count[3] = cond_value[2];
	text[2] = NAME_DamageUnknown;
	text[3] = NAME_Unknown_needed;
	text[4] = NAME_TwoHanded;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItKe_MagicChest(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 0;
	visual = "ItKe_Key_05.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "An old iron key.";
	text[1] = "It could belong to a";
	text[2] = "padlock.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Passage_MIS(C_Item)
{
	name = "Peace Offer for the Paladins";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_02.3DS";
	material = MAT_LEATHER;
	on_state[0] = UsePassage;
	scemeName = "MAP";
	description = name;
	text[0] = "With this note I should be able to";
	text[1] = "see Lord Hagen.";
};


func void UsePassage()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,-1,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Honored Lord Hagen,");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"We are both aware of your situation. I therefore propose the following arrangement:");
	Doc_PrintLines(nDocID,0,"Grant my men and myself total absolution before Innos and before the King.");
	Doc_PrintLines(nDocID,0,"In return, we offer to assist you in the defense of the town and the surrounding lands.");
	Doc_PrintLines(nDocID,0,"Moreover, I personally shall see to it that my men steer clear of the surrounding farms - except, of course, that of Onar, where we will continue to be stationed.");
	Doc_PrintLines(nDocID,0,"I am aware that there is enough room for myself and some of my men on the ship aboard which you will depart to the mainland. When you set sail, I want to be on board.");
	Doc_PrintLines(nDocID,0,"I beseech you: Make your decision with all the wisdom given to you.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"Signed   General Lee");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
};


instance ItWr_BanditLetter_MIS(C_Item)
{
	name = "Message";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItWr_Scroll_01.3DS";
	material = MAT_LEATHER;
	on_state[0] = UseBanditLetter;
	scemeName = "MAP";
	description = name;
	text[0] = "I took it from one of Brago's bandits.";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UseBanditLetter()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"letters.TGA",0);
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_SetMargins(nDocID,-1,50,50,50,50,1);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Stop all men who come from the mountains.");
	Doc_PrintLines(nDocID,0,"If someone comes along the pass,");
	Doc_PrintLines(nDocID,0," it will probably be an old man.");
	Doc_PrintLines(nDocID,0,"Don't let him fool you -");
	Doc_PrintLines(nDocID,0,"    he is a dangerous sorcerer.   ");
	Doc_PrintLines(nDocID,0,"Keep an eye on him.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"It's possible the guy we're looking for");
	Doc_PrintLines(nDocID,0,"    will contact him.");
	Doc_PrintLines(nDocID,0,"With this letter I'm sending you");
	Doc_PrintLines(nDocID,0,"    thirty pieces of gold.");
	Doc_PrintLines(nDocID,0,"I will give another thirty to anyone");
	Doc_PrintLines(nDocID,0,"    who kills the man.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Bring his head to the old mine near the landowner.");
	Doc_PrintLines(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"D.");
//	Doc_PrintLine(nDocID,0,"");
	Doc_SetMargins(nDocID,-1,200,50,50,50,1);
	Doc_Show(nDocID);
};


instance ItWr_Poster_MIS(C_Item)
{
	name = "Wanted Note";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = 0;
	visual = "ItWr_Poster_MIS.3DS";
	material = MAT_LEATHER;
	on_state[0] = UsePoster;
	scemeName = "MAP";
	description = name;
	text[0] = "A picture of me!";
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void UsePoster()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,1);
	Doc_SetPage(nDocID,0,"Gesucht.TGA",0);
	Doc_Show(nDocID);
};


instance ItKe_Bandit(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key belonged to a bandit.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItRw_Bow_L_03_MIS(C_Item)
{
	name = "Hunting Bow";
	mainflag = ITEM_KAT_FF;
	flags = ITEM_BOW | ITEM_MISSION;
	material = MAT_WOOD;
	value = Value_Jagdbogen;
	damageTotal = Damage_Jagdbogen;
	damagetype = DAM_POINT;
	munition = ItRw_Arrow;
	cond_atr[2] = ATR_DEXTERITY;
	cond_value[2] = Condition_Jagdbogen;
	visual = "ItRw_Bow_L_03.mms";
	description = name;
	text[0] = "Bosper's hunting bow.";
	text[2] = NAME_Damage;
	count[2] = damageTotal;
	text[3] = NAME_Dex_needed;
	count[3] = cond_value[2];
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItRi_Prot_Point_01_MIS(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING | ITEM_MISSION;
	value = Value_Ri_ProtPoint;
	visual = "ItRi_Prot_Point_01.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Prot_Point_01;
	on_unequip = UnEquip_ItRi_Prot_Point_01;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Ring of Wooden Skin";
	text[0] = "It belongs to Constantino.";
	text[2] = NAME_Prot_Point;
	count[2] = Ri_ProtPoint;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};

instance ItMi_EddasStatue(C_Item)
{
	name = "Statue of Innos";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI | ITEM_MISSION;
	value = Value_InnosStatue;
	visual = "ItMi_InnosStatue.3DS";
	material = MAT_METAL;
	description = name;
	text[0] = "Inscription:";
	text[1] = "'Innos, Lord of Justice";
	text[2] = "bless and guard me,";
	text[3] = "and spare me from harm.'.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItKe_EVT_CRYPT_01(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_05.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key from the skeleton in the first room.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_EVT_CRYPT_02(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_05.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key from the skeleton in the second room.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_EVT_CRYPT_03(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_05.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key from the skeleton in the third room.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};


const int Value_ITAR_PAL_Skel = 500;

instance ITAR_PAL_Skel(C_Item)
{
	name = "Old Knight's Armor";
	mainflag = ITEM_KAT_ARMOR;
	flags = 0;
	protection[PROT_EDGE] = 100;
	protection[PROT_BLUNT] = 100;
	protection[PROT_POINT] = 100;
	protection[PROT_FIRE] = 50;
	protection[PROT_MAGIC] = 50;
	value = Value_ITAR_PAL_Skel;
	wear = WEAR_TORSO;
	visual = "ItAr_Pal_Skel.3ds";
	visual_change = "Armor_Pal_Skeleton.asc";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ArmorSet;
	description = name;
	text[1] = NAME_Prot_Edge;
	count[1] = protection[PROT_EDGE];
	text[2] = NAME_Prot_Point;
	count[2] = protection[PROT_POINT];
	text[3] = NAME_Prot_Fire;
	count[3] = protection[PROT_FIRE];
	text[4] = NAME_Prot_Magic;
	count[4] = protection[PROT_MAGIC];
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItKe_Valentino(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to a chest";
	text[1] = "belonging to Valentino.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_Buerger(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_04.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "It was lying around on a windowsill.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 190;
};

instance ItKe_Richter(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_04.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "The key to a chest";
	text[1] = "belonging to the judge.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 190;
};

instance ItKe_Salandril(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_03.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "Belonging to Salandril the Alchemist.";
	text[1] = "";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItKe_PaladinTruhe(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_04.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "A small brass key from";
	text[1] = "the house of the paladins.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 190;
};

instance ItKe_ThiefTreasure(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = Value_Key_01;
	visual = "ItKe_Key_04.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "Small Key.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 190;
};

instance ItKe_Fingers(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_05.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "A rusty door key";
	text[1] = "from the sewers.";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItWr_Schuldenbuch(C_Item)
{
	name = "Book of Debts";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION;
	value = 200;
	visual = "ItWr_Book_02_03.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = name;
	text[0] = "Lehmar's book of debts.";
	text[5] = NAME_Value;
	count[5] = value;
	on_state[0] = UseSchuldBuch;
};


func void UseSchuldBuch()
{
	var int nDocID;
	nDocID = Doc_Create();
	Doc_SetPages(nDocID,2);
	Doc_SetPage(nDocID,0,"Book_Brown_L.tga",0);
	Doc_SetPage(nDocID,1,"Book_Brown_R.tga",0);
	Doc_SetMargins(nDocID,0,275,20,30,20,1);
	Doc_SetFont(nDocID,0,FONT_BookHeadline);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"Deals and Debts");
	Doc_SetFont(nDocID,0,FONT_Book);
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"I, Master Thorben, carpenter of Khorinis, owe to the honorable Lehmar a debt of 200 gold coins.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"             Thorben");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLines(nDocID,0,"I, Coragon, innkeeper of Khorinis, owe the honorable Lehmar a debt of 150 in gold.");
	Doc_PrintLine(nDocID,0,"");
	Doc_PrintLine(nDocID,0,"             Coragon");
	Doc_SetMargins(nDocID,-1,30,20,275,20,1);
	Doc_SetFont(nDocID,1,FONT_Book);
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLines(nDocID,1,"I, Hanna, hotelier of Khorinis, owe the honorable Lehmar a debt of 250 gold coins.");
	Doc_PrintLine(nDocID,1,"");
	Doc_PrintLine(nDocID,1,"               Hanna");
	Doc_Show(nDocID);
	SchuldBuchNamesKnown = TRUE;
};


instance ItPl_Sagitta_Herb_MIS(C_Item)
{
	name = "Sun Aloe";
	mainflag = ITEM_KAT_FOOD;
//	flags = ITEM_MULTI;
	flags = ITEM_MISSION;
	value = Value_Strength_Herb_01;
	visual = "ItPl_Sagitta_Herb.3DS";
	material = MAT_LEATHER;
	scemeName = "FOOD";
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItKe_Orlan_HotelZimmer(C_Item)
{
	name = NAME_Key;
	mainflag = ITEM_KAT_KEYS;
	flags = ITEM_MISSION;
	value = Value_Key_01;
	visual = "ItKe_Key_01.3ds";
	material = MAT_METAL;
	description = name;
	text[0] = "From the tavern 'The Dead Harpy";
	text[1] = "";
	inv_rotz = -45;
	inv_rotx = -25;
	inv_roty = 0;
	inv_zbias = 145;
};

instance ItRw_DragomirsArmbrust_MIS(C_Item)
{
	name = "Dragomir's Crossbow";
	mainflag = ITEM_KAT_FF;
	flags = ITEM_CROSSBOW;
	material = MAT_WOOD;
	value = 1000;
	damageTotal = 65;
	damagetype = DAM_POINT;
	munition = ItRw_Bolt;
	cond_atr[2] = ATR_STRENGTH;
	cond_value[2] = Condition_LeichteArmbrust;
	visual = "ItRw_Crossbow_Mission_01.mms";
	description = name;
	text[2] = NAME_Damage;
	count[2] = damageTotal;
	text[3] = NAME_Str_needed;
	count[3] = cond_value[2];
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_GregsSilverPlate(C_Item)
{
	name = "Silver Dish";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 130;
	visual = "ItMi_GregsSilverPlate.3DS";
	material = MAT_METAL;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
};

