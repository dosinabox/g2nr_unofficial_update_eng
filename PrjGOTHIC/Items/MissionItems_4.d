
const int Value_Dragonegg = 200;
const int Value_OrcEliteRing = 130;

instance ItAm_Mana_Angar_MIS(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = Value_Am_Mana;
	visual = "ItAm_Mana_01.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItAm_Mana_01;
	on_unequip = UnEquip_ItAm_Mana_01;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Amulet of Magic";
	text[0] = "Belongs to Angar.";
	text[2] = NAME_Bonus_ManaMax;
	count[2] = Am_Mana;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};

instance ItMW_1H_FerrosSword_Mis(C_Item)
{
	name = "Fero's Sword";
	mainflag = ITEM_KAT_NF;
	flags = ITEM_SWD | ITEM_MISSION;
	material = MAT_METAL;
	value = Value_Special_1H_2;
	damageTotal = Damage_Special_1H_2;
	damagetype = DAM_EDGE;
	range = Range_Special_1H_2;
	cond_atr[2] = ATR_STRENGTH;
	cond_value[2] = Condition_Special_1H_2;
//	visual = "ItMw_060_1h_Sword_smith_03.3DS";
	visual = "ItMw_060_1h_Sword_smith_04.3DS";
	description = name;
	text[2] = NAME_Damage;
	count[2] = damageTotal;
	text[3] = NAME_Str_needed;
	count[3] = cond_value[2];
	text[4] = NAME_OneHanded;
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItMi_KerolothsGeldbeutel_MIS(C_Item)
{
	name = NAME_Beutel;
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 300;
	visual = "ItMi_Pocket_Mis.3ds";
	scemeName = "MAPSEALED";
	material = MAT_LEATHER;
	on_state[0] = UseKerolothsGeldbeutel;
	description = name;
//	text[0] = PRINT_Pocket_MIS;
	text[0] = "Keroloth' satchel.";
	text[1] = PRINT_Pocket_300;
	text[5] = NAME_Value;
	count[5] = value;
};


func void UseKerolothsGeldbeutel()
{
	B_PlayerFindItem(ItMi_Gold,300);
	CreateInvItems(self,ItMi_KerolothsGeldbeutelLeer_MIS,1);
};


instance ItMi_KerolothsGeldbeutelLeer_MIS(C_Item)
{
	name = "Keroloth's Leather Satchel";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION;
	value = 0;
	visual = "ItMi_Pocket_Empty.3ds";
	material = MAT_LEATHER;
	description = name;
	text[0] = "It's empty.";
	inv_zbias = 190;
};

instance ItRw_SengrathsArmbrust_MIS(C_Item)
{
	name = "Sengrath's Crossbow";
	mainflag = ITEM_KAT_FF;
	flags = ITEM_CROSSBOW;
	material = MAT_WOOD;
	value = 300;
	damageTotal = 50;
	damagetype = DAM_POINT;
	munition = ItRw_Bolt;
	cond_atr[2] = ATR_STRENGTH;
	cond_value[2] = Condition_MilArmbrust;
	visual = "ItRw_Crossbow_Mission_02.mms";
	description = name;
	text[2] = NAME_Damage;
	count[2] = damageTotal;
	text[3] = NAME_Str_needed;
	count[3] = cond_value[2];
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItAt_TalbinsLurkerSkin(C_Item)
{
	name = "Lurker Skin";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MULTI;
	value = Value_ReptileSkin;
	visual = "ItAt_LurkerSkin.3DS";
	material = MAT_LEATHER;
	description = name;
	text[0] = "The name Talbin's been branded on the inside.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItAt_DragonEgg_MIS(C_Item)
{
	name = "Dragon Egg";
	mainflag = ITEM_KAT_NONE;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = Value_Dragonegg;
	visual = "ItAt_DragonEgg.3ds";
	material = MAT_LEATHER;
	description = name;
	text[0] = "The egg is warm, and there's";
	text[1] = "a scratching noise on the inside.";
	text[5] = NAME_Value;
	count[5] = value;
};

instance ItRi_OrcEliteRing(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_MISSION | ITEM_RING | ITEM_MULTI;
	value = Value_OrcEliteRing;
	visual = "ItRi_OrcEliteRing.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_OrcEliteRing;
	on_unequip = UnEquip_OrcEliteRing;
	description = "Ring of the Orcish Warlords";
	text[0] = "The ring is rough and seems";
	text[1] = "strangely cold.";
	text[5] = NAME_Value;
	count[5] = value;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_WEAKGLIMMER";
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};


func void Equip_OrcEliteRing()
{
	if(self.attribute[ATR_STRENGTH] >= OrcRingPenalty)
	{
		Npc_ChangeAttribute(self,ATR_STRENGTH,-OrcRingPenalty);
		Print(PRINT_OrcEliteRingEquip);
		OrcRingCurrentPenalty = OrcRingPenalty;
	};
};

func void UnEquip_OrcEliteRing()
{
	if(OrcRingCurrentPenalty != 0)
	{
		Npc_ChangeAttribute(self,ATR_STRENGTH,OrcRingPenalty);
		Print(PRINT_Eat3);
		OrcRingCurrentPenalty = 0;
	};
};


var int Neoras_SCUsedDragonEggDrink;

instance ItPo_DragonEggDrinkNeoras_MIS(C_Item)
{
	name = NAME_Trank;
	mainflag = ITEM_KAT_POTIONS;
	flags = ITEM_MULTI;
	value = 300;
//	visual = "ItPo_Perm_STR.3ds";
	visual = "ItPo_Special_01.3ds";
	material = MAT_GLAS;
	on_state[0] = Use_DragonEggDrinkNeoras;
	scemeName = "POTIONFAST";
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Potion of Dragon Egg Secretion";
	text[1] = PRINT_UnknownEffect;
	text[5] = NAME_Value;
	count[5] = value;
};


func void Use_DragonEggDrinkNeoras()
{
	Npc_ChangeAttribute(self,ATR_HITPOINTS,HP_Elixier);
	B_RaiseAttribute(self,ATR_STRENGTH,3);
	Snd_Play("DEM_Warn");
	Neoras_SCUsedDragonEggDrink = TRUE;
};


instance ItWr_Map_Orcelite_MIS(C_Item)
{
	name = "Orcish War Map";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 350;
	visual = "ItWr_Map_NW_01.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_NewWorld_Orcelite_MIS;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


var int Use_Map_NewWorld_Orcelite_MIS_OneTime;

func void Use_Map_NewWorld_Orcelite_MIS()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_Orcelite_MIS);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_NewWorld_Orcelite.tga",TRUE);
	Doc_SetLevel(Document,"NewWorld\NewWorld.zen");
	Doc_SetLevelCoords(Document,-28000,50500,95500,-42500);
	Doc_Show(Document);
	if((Use_Map_NewWorld_Orcelite_MIS_OneTime == FALSE) && (MIS_KillOrkOberst != FALSE))
	{
		B_LogEntry(TOPIC_OrcElite,"I found a strange map on the orcish colonel. It looks like the orcs' strategic war map.");
		Use_Map_NewWorld_Orcelite_MIS_OneTime = TRUE;
	};
};


instance ItWr_Map_Caves_MIS(C_Item)
{
	name = "The Caves of Khorinis";
	mainflag = ITEM_KAT_DOCS;
	flags = ITEM_MISSION | ITEM_MULTI;
	value = 200;
	visual = "ItWr_Map_NW_01.3DS";
	material = MAT_LEATHER;
	scemeName = "MAP";
	on_state[0] = Use_Map_NewWorld_Caves_MIS;
	description = name;
	text[5] = NAME_Value;
	count[5] = value;
	inv_rotz = 180;
	inv_rotx = 90;
	inv_roty = 180;
};


func void Use_Map_NewWorld_Caves_MIS()
{
	var int Document;
	if(Npc_IsPlayer(self))
	{
		B_SetPlayerMap(ItWr_Map_Caves_MIS);
	};
	Document = Doc_CreateMap();
	Doc_SetPages(Document,1);
	Doc_SetPage(Document,0,"Map_NewWorld_Caves.tga",TRUE);
	Doc_SetLevel(Document,"NewWorld\NewWorld.zen");
	Doc_SetLevelCoords(Document,-28000,50500,95500,-42500);
	Doc_Show(Document);
};

