
const int Value_ItAm_Addon_Franco = 1200;
const int HP_ItAm_Addon_Franco = 40;
const int STR_Franco = 4;
const int DEX_Franco = 4;
const int Value_ItRi_Addon_Health_01 = 400;
const int Value_ItAm_Addon_Health = 800;
const int Value_ItRi_Addon_Mana_01 = 1000;
const int Value_ItAm_Addon_Mana = 2000;
const int Value_ItRi_Addon_STR_01 = 500;
const int Value_ItAm_Addon_STR = 1000;
const int HP_Ring_Solo_Bonus = 20;
const int HP_Ring_Double_Bonus = 60;
const int HP_Amulett_Solo_Bonus = 40;
const int HP_Amulett_EinRing_Bonus = 80;
const int HP_Amulett_Artefakt_Bonus = 160;
const int MA_Ring_Solo_Bonus = 5;
const int MA_Ring_Double_Bonus = 15;
const int MA_Amulett_Solo_Bonus = 10;
const int MA_Amulett_EinRing_Bonus = 20;
const int MA_Amulett_Artefakt_Bonus = 40;
const int STR_Ring_Solo_Bonus = 5;
const int STR_Ring_Double_Bonus = 15;
const int STR_Amulett_Solo_Bonus = 10;
const int STR_Amulett_EinRing_Bonus = 20;
const int STR_Amulett_Artefakt_Bonus = 40;

instance ItAm_Addon_Franco(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET;
	value = Value_ItAm_Addon_Franco;
	visual = "ItAm_Addon_Franco.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItAm_Addon_Franco;
	on_unequip = UnEquip_ItAm_Addon_Franco;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Franco's Amulet";
	text[2] = NAME_Bonus_Str;
	count[2] = STR_Franco;
	text[3] = NAME_Bonus_Dex;
	count[3] = DEX_Franco;
	text[4] = NAME_Bonus_HpMax;
	count[4] = HP_ItAm_Addon_Franco;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItAm_Addon_Franco()
{
	self.attribute[ATR_STRENGTH] += STR_Franco;
	self.attribute[ATR_DEXTERITY] += DEX_Franco;
	B_RaiseAttributeByTempBonus(self,ATR_STRENGTH,STR_Franco);
	B_RaiseAttributeByTempBonus(self,ATR_DEXTERITY,DEX_Franco);
	Equip_MaxHP(HP_ItAm_Addon_Franco);
};

func void UnEquip_ItAm_Addon_Franco()
{
	self.attribute[ATR_STRENGTH] -= STR_Franco;
	self.attribute[ATR_DEXTERITY] -= DEX_Franco;
	B_RaiseAttributeByTempBonus(self,ATR_STRENGTH,-STR_Franco);
	B_RaiseAttributeByTempBonus(self,ATR_DEXTERITY,-DEX_Franco);
	UnEquip_MaxHP(HP_ItAm_Addon_Franco);
};


instance ItAm_Addon_Greg(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET | ITEM_MISSION;
	value = 900;
	visual = "ItAm_Addon_Greg.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItAm_Addon_Greg;
	on_unequip = UnEquip_ItAm_Addon_Greg;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Captain's amulet.";
	text[2] = NAME_Prot_Edge;
	count[2] = 5;
	text[3] = NAME_Prot_Point;
	count[3] = 5;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItAm_Addon_Greg()
{
	self.protection[PROT_EDGE] += 5;
	self.protection[PROT_BLUNT] += 5;
	self.protection[PROT_POINT] += 5;
};

func void UnEquip_ItAm_Addon_Greg()
{
	self.protection[PROT_EDGE] -= 5;
	self.protection[PROT_BLUNT] -= 5;
	self.protection[PROT_POINT] -= 5;
};


instance ItAm_Addon_Health(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET;
	value = Value_ItAm_Addon_Health;
	visual = "ItAm_Addon_Health.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItAm_Addon_Health;
	on_unequip = UnEquip_ItAm_Addon_Health;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Amulet of the Healer";
	text[2] = NAME_Bonus_HpMax;
	count[2] = HP_Amulett_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItAm_Addon_Health()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_HP_ArtefaktValue();
	HP_Amulett_Equipped = TRUE;
	NewValue = C_HP_ArtefaktValue();
	Equip_MaxHP(NewValue - OldValue);
};

func void UnEquip_ItAm_Addon_Health()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_HP_ArtefaktValue();
	HP_Amulett_Equipped = FALSE;
	NewValue = C_HP_ArtefaktValue();
	UnEquip_MaxHP(OldValue - NewValue);
	HP_Artefakt_Effekt = FALSE;
};


instance ItRi_Addon_Health_01(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING;
	value = Value_ItRi_Addon_Health_01;
	visual = "ItRi_Addon_Health.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Addon_Health_01;
	on_unequip = UnEquip_ItRi_Addon_Health_01;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Ring of the Healers";
	text[2] = NAME_Bonus_HpMax;
	count[2] = HP_Ring_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};


func void Equip_ItRi_Addon_Health_01()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_HP_ArtefaktValue();
	HP_Ring_1_Equipped = TRUE;
	NewValue = C_HP_ArtefaktValue();
	Equip_MaxHP(NewValue - OldValue);
};

func void UnEquip_ItRi_Addon_Health_01()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_HP_ArtefaktValue();
	HP_Ring_1_Equipped = FALSE;
	NewValue = C_HP_ArtefaktValue();
	UnEquip_MaxHP(OldValue - NewValue);
	HP_Artefakt_Effekt = FALSE;
};


instance ItRi_Addon_Health_02(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING;
	value = Value_ItRi_Addon_Health_01;
	visual = "ItRi_Addon_Health.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Addon_Health_02;
	on_unequip = UnEquip_ItRi_Addon_Health_02;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Ring of the Healers";
	text[2] = NAME_Bonus_HpMax;
	count[2] = HP_Ring_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};


func void Equip_ItRi_Addon_Health_02()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_HP_ArtefaktValue();
	HP_Ring_2_Equipped = TRUE;
	NewValue = C_HP_ArtefaktValue();
	Equip_MaxHP(NewValue - OldValue);
};

func void UnEquip_ItRi_Addon_Health_02()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_HP_ArtefaktValue();
	HP_Ring_2_Equipped = FALSE;
	NewValue = C_HP_ArtefaktValue();
	UnEquip_MaxHP(OldValue - NewValue);
	HP_Artefakt_Effekt = FALSE;
};


instance ItAm_Addon_MANA(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET;
	value = Value_ItAm_Addon_Mana;
	visual = "ItAm_Addon_Mana.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItAm_Addon_MANA;
	on_unequip = UnEquip_ItAm_Addon_MANA;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Amulet of the Priests";
	text[2] = NAME_Bonus_ManaMax;
	count[2] = MA_Amulett_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItAm_Addon_MANA()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_MA_ArtefaktValue();
	MA_Amulett_Equipped = TRUE;
	NewValue = C_MA_ArtefaktValue();
	Equip_MaxMana(NewValue - OldValue);
};

func void UnEquip_ItAm_Addon_MANA()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_MA_ArtefaktValue();
	MA_Amulett_Equipped = FALSE;
	NewValue = C_MA_ArtefaktValue();
	UnEquip_MaxMana(OldValue - NewValue);
	MA_Artefakt_Effekt = FALSE;
};


instance ItRi_Addon_MANA_01(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING;
	value = Value_ItRi_Addon_Mana_01;
	visual = "ItRi_Addon_Mana.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Addon_MANA_01;
	on_unequip = UnEquip_ItRi_Addon_MANA_01;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Ring of the Priests";
	text[2] = NAME_Bonus_ManaMax;
	count[2] = MA_Ring_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};


func void Equip_ItRi_Addon_MANA_01()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_MA_ArtefaktValue();
	MA_Ring_1_Equipped = TRUE;
	NewValue = C_MA_ArtefaktValue();
	Equip_MaxMana(NewValue - OldValue);
};

func void UnEquip_ItRi_Addon_MANA_01()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_MA_ArtefaktValue();
	MA_Ring_1_Equipped = FALSE;
	NewValue = C_MA_ArtefaktValue();
	UnEquip_MaxMana(OldValue - NewValue);
	MA_Artefakt_Effekt = FALSE;
};


instance ItRi_Addon_MANA_02(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING;
	value = Value_ItRi_Addon_Mana_01;
	visual = "ItRi_Addon_Mana.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Addon_MANA_02;
	on_unequip = UnEquip_ItRi_Addon_MANA_02;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Ring of the Priests";
	text[2] = NAME_Bonus_ManaMax;
	count[2] = MA_Ring_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};


func void Equip_ItRi_Addon_MANA_02()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_MA_ArtefaktValue();
	MA_Ring_2_Equipped = TRUE;
	NewValue = C_MA_ArtefaktValue();
	Equip_MaxMana(NewValue - OldValue);
};

func void UnEquip_ItRi_Addon_MANA_02()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_MA_ArtefaktValue();
	MA_Ring_2_Equipped = FALSE;
	NewValue = C_MA_ArtefaktValue();
	UnEquip_MaxMana(OldValue - NewValue);
	MA_Artefakt_Effekt = FALSE;
};


instance ItAm_Addon_STR(C_Item)
{
	name = NAME_Amulett;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_AMULET;
	value = Value_ItAm_Addon_STR;
	visual = "ItAm_Addon_Str.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItAm_Addon_STR;
	on_unequip = UnEquip_ItAm_Addon_STR;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Amulet of the Warriors";
	text[2] = NAME_Prot_Edge;
	count[2] = STR_Amulett_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_AMULETTE_STANDARD;
};


func void Equip_ItAm_Addon_STR()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_STR_ArtefaktValue();
	STR_Amulett_Equipped = TRUE;
	NewValue = C_STR_ArtefaktValue();
	self.protection[PROT_EDGE] += NewValue - OldValue;
	self.protection[PROT_BLUNT] += NewValue - OldValue;
};

func void UnEquip_ItAm_Addon_STR()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_STR_ArtefaktValue();
	STR_Amulett_Equipped = FALSE;
	NewValue = C_STR_ArtefaktValue();
	self.protection[PROT_EDGE] += NewValue - OldValue;
	self.protection[PROT_BLUNT] += NewValue - OldValue;
	STR_Artefakt_Effekt = FALSE;
};


instance ItRi_Addon_STR_01(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING;
	value = Value_ItRi_Addon_STR_01;
	visual = "ItRi_Addon_Str.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Addon_STR_01;
	on_unequip = UnEquip_ItRi_Addon_STR_01;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Ring of the Warriors";
	text[2] = NAME_Prot_Edge;
	count[2] = STR_Ring_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};


func void Equip_ItRi_Addon_STR_01()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_STR_ArtefaktValue();
	STR_Ring_1_Equipped = TRUE;
	NewValue = C_STR_ArtefaktValue();
	self.protection[PROT_EDGE] += NewValue - OldValue;
	self.protection[PROT_BLUNT] += NewValue - OldValue;
};

func void UnEquip_ItRi_Addon_STR_01()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_STR_ArtefaktValue();
	STR_Ring_1_Equipped = FALSE;
	NewValue = C_STR_ArtefaktValue();
	self.protection[PROT_EDGE] += NewValue - OldValue;
	self.protection[PROT_BLUNT] += NewValue - OldValue;
	STR_Artefakt_Effekt = FALSE;
};


instance ItRi_Addon_STR_02(C_Item)
{
	name = NAME_Ring;
	mainflag = ITEM_KAT_MAGIC;
	flags = ITEM_RING;
	value = Value_ItRi_Addon_STR_01;
	visual = "ItRi_Addon_Str.3ds";
	visual_skin = 0;
	material = MAT_METAL;
	on_equip = Equip_ItRi_Addon_STR_02;
	on_unequip = UnEquip_ItRi_Addon_STR_02;
	wear = WEAR_EFFECT;
	effect = "SPELLFX_ITEMGLIMMER";
	description = "Ring of the Warriors";
	text[2] = NAME_Prot_Edge;
	count[2] = STR_Ring_Solo_Bonus;
	text[3] = PRINT_Addon_KUMU_01;
	text[4] = PRINT_Addon_KUMU_02;
	text[5] = NAME_Value;
	count[5] = value;
	inv_zbias = INVCAM_ENTF_RING_STANDARD;
	inv_rotz = INVCAM_Z_RING_STANDARD;
	inv_rotx = INVCAM_X_RING_STANDARD;
};


func void Equip_ItRi_Addon_STR_02()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_STR_ArtefaktValue();
	STR_Ring_2_Equipped = TRUE;
	NewValue = C_STR_ArtefaktValue();
	self.protection[PROT_EDGE] += NewValue - OldValue;
	self.protection[PROT_BLUNT] += NewValue - OldValue;
};

func void UnEquip_ItRi_Addon_STR_02()
{
	var int OldValue;
	var int NewValue;
	OldValue = C_STR_ArtefaktValue();
	STR_Ring_2_Equipped = FALSE;
	NewValue = C_STR_ArtefaktValue();
	self.protection[PROT_EDGE] += NewValue - OldValue;
	self.protection[PROT_BLUNT] += NewValue - OldValue;
	STR_Artefakt_Effekt = FALSE;
};

